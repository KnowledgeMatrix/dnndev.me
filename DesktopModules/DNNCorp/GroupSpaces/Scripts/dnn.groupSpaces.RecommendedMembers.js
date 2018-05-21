// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';

    dnn.groupSpaces.Member = function (parent, sf, settings, userId, username, displayName, avatar, profileUrl, isMember) {
        var self = this;
        this.social = settings.social;
        this.service = this.social.getService('GroupSpacesService');
        this.localizer = self.social.getLocalizationController();

        self.UserId = ko.observable(userId);
        self.Username = ko.observable(username);
        self.DisplayName = ko.observable(displayName);
        self.Avatar = ko.observable(avatar);
        self.ProfileUrl = ko.observable(profileUrl);
        self.IsMember = ko.observable(isMember);
        self.Invited = ko.observable(false);
        
        self.invite = function () {
            if (settings.groupPending) {
                $.dnnAlert({
                    title: self.localizer.getString('NoInvitesSentPendingGroupTitle'),
                    text: self.localizer.getString('NoInvitesSentPendingGroup'),
                    callback: function () { self.onGroupCreated(); },
                    close: function () { self.onGroupCreated(); }
                });
            } else {
                var failure = function (data) {
                    $.dnnAlert({
                        title: self.localizer.getString('InviteFailedTitle'),
                        text: self.localizer.getString('InviteFailed').replace(settings.usernameToken, displayName).replace(settings.groupNameToken, settings.groupName) + '<br/>' + JSON.parse(data.Message)["ErrorMessage"]
                    });
                };
                var success = function () {
                    self.Invited(true);
                    parent.invitedUserIds.push(userId);
                    var inviteBtn = $('#recommendedInviteLink_User' + userId);
                    inviteBtn.removeClass('dnnPrimaryAction');
                    inviteBtn.addClass('dnnSecondaryAction');
                    inviteBtn.html(self.localizer.getString('Invited'));
                };

                if (!self.Invited()) {
                    var params = { groupId: settings.groupId, userId: userId };
                    self.service.post('InviteUser', params, success, failure);
                }
            }            
        };
    };

    dnn.groupSpaces.RecommendedMembers = function RecommendedMembers($, sf, ko, settings) {
        var self = this;
        this.settings = settings;
        this.social = new dnn.social.Module(settings);
        this.localizer = self.social.getLocalizationController();
        this.service = this.social.getService('RelatedGroupsMembers');
        this.componentFactory = this.social.getComponentFactory();
        this.totalResults = ko.observable(0);
        this.members = ko.observableArray([]);
        this.pageSize = 5;
        this.pageIndex = ko.observable(0);
        this.totalPages = ko.computed(function () {
            var total = self.totalResults();
            return total > 0 ? Math.max(1, Math.ceil(total / self.pageSize)) : 0;
        });
        
        this.invitedUserIds = ko.observableArray([]);
        this.userCanInviteUsers = ko.observable(settings.userCanInviteUsers);

        dnn.social.ipc.register(self.settings, function(source, msg) {
            switch (msg.event) {
            case 'UserJoinsGroup':
                self.userCanInviteUsers(true);
                break;
            }
        });

        this.load = function () {
            var success = function (data) {
                var members = [];
                $.each(data.Results,
                    function (index, user) {
                        var memberSettings = {
                            social: self.social,
                            groupId: user.groupId,
                            groupPending: settings.groupPending,
                            usernameToken: settings.usernameToken,
                            groupNameToken: settings.groupNameToken
                        };
                        members.push(new dnn.groupSpaces.Member(self, sf, memberSettings, user.userId, user.username, user.displayName, user.avatar, user.profileUrl, user.isMember));
                    });

                self.totalResults(data.TotalRecords || 0);
                self.members(members);

                // paging handle: hides invite button for all users who were already 
                $.each(self.invitedUserIds(),
                    function (index, userId) {
                        $('#recommendedInviteLink_User' + userId).hide();
                        $('#recommendedInvitedText_User' + userId).show();
                    });
            };

            var failure = function () {};
            var params = { groupId: settings.groupId, pageIndex: self.pageIndex(), pageSize: self.pageSize };
            self.service.post('GetRecommendedMembers', params, success, failure);
        };
        
        this.prev = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex > 0) {
                self.pageIndex(--pageIndex);
                self.load();
            }
        };
        this.next = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex < self.totalPages() - 1) {
                self.pageIndex(++pageIndex);
                self.load();
            }
        };
        
        this.prevClass = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex > 0) {
                return new String();
            }
            return 'disabled';
        };
        
        this.nextClass = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex < self.totalPages() - 1) {
                return new String();
            }
            return 'disabled';
        };
        
        this.invite = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return false;
            }        

            var inviteMemberModel = ko.contextFor($(settings.inviteMembersId)[0]).$root;
            if (inviteMemberModel) {
                inviteMemberModel.privateOnly(!settings.isPublic);
                inviteMemberModel.bindControls();
            }

            var isMobile = dnn.social.MobileView.onMobile;
            if (!isMobile) {
                var options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: self.localizer.getString('InviteMembers'),
                    minWidth: 895,
                    resizable: false,
                    closeOnEscape: false
                };
                $('.group-invite-dialog').dialog(options);
            } else {
                $('.group-invite-dialog').dialog(dnn.social.MobileView.dialogOptions({
                    title: self.localizer.getString('InviteMembers')
                }));
            }
            return false;
        };
        
        this.binded = function () {
            var inviteMembers = ko.contextFor($(settings.inviteMembersId)[0]).$root;
            if (inviteMembers) {
                inviteMembers.groupName(settings.groupName);
                inviteMembers.groupId(settings.groupId);
            }
            
            this.load();
        };

    };
    
})(window.dnn);