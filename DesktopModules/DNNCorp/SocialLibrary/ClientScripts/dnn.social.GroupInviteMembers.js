// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social.GroupInviteMembers === 'undefined') dnn.social.GroupInviteMembers = {};
if (typeof dnn.social.Friend === 'undefined') dnn.social.Friend = {};

(function (dnn) {
    'use strict';

    dnn.social.Friend = function (sf, settings, userId, username, displayName, avatar, profileUrl, isMember) {
        var self = this;
        this.social = settings.social;
        this.localizer = self.social.getLocalizationController();
        
        self.UserId = ko.observable(userId);
        self.Username = ko.observable(username);
        self.DisplayName = ko.observable(displayName);
        self.Avatar = ko.observable(avatar);
        self.ProfileUrl = ko.observable(profileUrl);
        self.IsMember = ko.observable(isMember);
        self.Invited = ko.observable(false);
        self.inviteFriend = function () {
            var inviteBtn = $('#inviteLink_User' + self.UserId());
            if (self.Invited()) {
                self.Invited(false);
                inviteBtn.removeClass('dnnSecondaryAction');
                inviteBtn.addClass('dnnPrimaryAction');
                inviteBtn.html(self.localizer.getString('Invite'));
            } else {
                self.Invited(true);
                inviteBtn.removeClass('dnnPrimaryAction');
                inviteBtn.addClass('dnnSecondaryAction');
                inviteBtn.html(self.localizer.getString('Invited'));
            }
        };
    };

    dnn.social.GroupInviteMembers = function ($, ko, settings, sf) {
        var self = this;

        $.extend(this, settings);
        self.ko = ko;
        self.settings = settings;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService('SocialGroup');
        self.localizer = self.social.getLocalizationController();
        self.groupId = ko.observable();
        self.groupName = ko.observable();
        self.friends = ko.observableArray([]);
        self.privateOnly = ko.observable(false);
        self.inviteCallback = function () {};
        self.inviteClose = function () {};
        self.inviteEmails = ko.observable();
        self.notificationsSent = 0;
        self.emailsSent = 0;
        self.inviteSuccess = true;
        self.inviteErrorMsg = '';
        self.inviteShowResults = true;
        self.inviteCount = 0;
      
        // Friends
        this.loadFriends = function () {
            if (settings.anonymous || this.friends().length > 0) {
                return;
            }
            this.friends([]);
            if (self.groupName() != undefined) {
                var failure = function () {};
                var success = function (data) {
                    $.each(data,
                        function (index, user) {
                            var friendSettings = {
                                social: self.social,
                                groupId: self.groupId(),
                                groupName: self.groupName(),
                                usernameToken: settings.usernameToken,
                                groupNameToken: settings.groupNameToken
                            };
                            self.friends.push(new dnn.social.Friend(sf, friendSettings, user.userId, user.username, user.displayName, user.avatar, user.profileUrl, user.isMember));
                        });
                };
                var params = { GroupName: self.groupName() };
                self.service.getsync('GetFriends', params, success, failure);
            }
        };

        this.inviteCount = function () {
            //Friends
            var friends = 0;
            if (self.friends().length > 0) {
                $.each(self.friends(),
                    function(index, friend) {
                        if (friend.Invited()) {
                            friends = friends + 1;
                        }
                    });
            }
            //Emails
            var emails = 0;
            if(self.inviteEmails() != undefined){
                emails = self.inviteEmails().trim().split(',').length;
            }

            return friends + emails;
        };

        this.inviteFriends = function() {
            if (self.friends().length > 0) {
                var invites = [];
                
                $.each(self.friends(),
                    function(index, friend) {

                        if (friend.Invited()) {
                            var invite = { groupId: self.groupId(), senderUserId: self.settings.currentUserId, userId: friend.UserId(), inviteEmails: '' };
                            invites.push(invite);
                        }
                    });

                var failure = function(data) {
                    self.inviteSuccess = false;
                    self.inviteErrorMsg = JSON.parse(data.Message)["ErrorMessage"];
                };
                var success = function() {
                    self.inviteSuccess = true;
                    self.notificationsSent = self.notificationsSent + invites.length;
                };
                var params = { invites: invites };
                self.service.postsync('InviteUsers', params, success, failure);
            }
        };

        // Invite members by email address
        this.inviteByEmail = function () {
            if (self.inviteEmails() != undefined) {
                var failure = function (response) {
                    self.inviteSuccess = false;
                    self.inviteErrorMsg = JSON.parse(response.responseText)["Message"];                        
                };
                var success = function(response) {
                    self.inviteSuccess = true;
                    $('#inviteEmails').attr('disabled', 'disabled');
                    self.notificationsSent = self.notificationsSent + response.NotificationCount;
                    self.emailsSent = response.EmailCount;
                };
                var params = { groupId: self.groupId(), inviteEmails: self.inviteEmails().trim().split(',') };
                self.service.postsync('InviteUsersByEmail', params, success, failure);
            }
        };
       
        this.reset = function () {
            self.inviteEmails(null);
            $('#inviteEmails').removeAttr('disabled');
            self.notificationsSent = 0;
            self.emailsSent = 0;
        };
        
        this.inviteComplete = function () {
            self.reset();            
            // If dialog close it.
            $('.group-invite-dialog').dialog('close');            
        };

        this.invite = function () {
            self.inviteFriends();
            self.inviteByEmail();
            
            if (self.inviteSuccess) {
                if (self.inviteShowResults && !dnn.social.MobileView.onMobile) {
                    if (self.notificationsSent > 0 || self.emailsSent > 0) {
                        var sentText = self.localizer.getString('InvitesSent').replace(settings.groupNameToken, self.groupName()).replace(settings.emailCountToken, self.emailsSent).replace(settings.notificationCountToken, self.notificationsSent);
                        $.dnnAlert({
                            title: self.localizer.getString('InvitesSentTitle'),
                            text: sentText,
                            callback: self.inviteCallback,
                            close: self.inviteClose
                        });
                    } else {
                        self.inviteClose();
                    }
                }
                self.inviteComplete();
            } else {
                if (self.inviteShowResults) {
                    $.dnnAlert({
                        title: self.localizer.getString('InviteFailedTitle'),
                        text: self.localizer.getString('InvitesByEmailFailed').replace(settings.groupNameToken, self.groupName()) + '<br/><br/>' + self.inviteErrorMsg,
                        callback: self.inviteCallback,
                        close: self.inviteClose
                    });
                }
            }
        };

        this.showBottomPanel = ko.observable(true);

        this.bindControls = function() {
            this.loadFriends();
        };
    };
})(window.dnn);