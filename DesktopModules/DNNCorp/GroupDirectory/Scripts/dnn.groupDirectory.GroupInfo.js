// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};

(function (dnn) {
    'use strict';
    
    dnn.groupDirectory.Member = function (userId, displayName, avatar, profileUrl, recentActivitySummary, summaryData) {
        var self = this;
        self.UserId = ko.observable(userId);
        self.DisplayName = ko.observable(displayName);
        self.Avatar = ko.observable(avatar);
        self.ProfileUrl = ko.observable(profileUrl);
        self.RecentActivitySummary = ko.observable(recentActivitySummary);
        self.SummaryUrl = ko.computed(function () {
            //return $.parseJSON(summaryData)['Url'];
        });
    };

    dnn.groupDirectory.GroupInfo = function ($, ko, settings, social, params) {
        var self = this;
        self.social = social;
        self.service = social.getService('List');
        self.localizer = social.getLocalizationController();
        self.settings = settings;
        
        self.GroupId = params.GroupId;
        self.GroupKey = params.GroupKey;
        self.GroupName = ko.observable(params.Name);
        self.GroupImage = ko.observable(params.ImageUrl);
        self.IconFile = ko.observable(params.IconFile);
        self.Description = ko.observable(params.Description);
        self.MemberCount = ko.observable(params.MemberCount);
        self.GroupUrl = ko.observable(params.Url);
        self.Tags = params.Tags;
        self.TagsString = ko.observable('');
        self.IsMember = ko.observable(params.IsMember);
        self.MembershipPending = ko.observable(params.MembershipPending);
        self.IsPendingToBeApproved = params.IsPendingToBeApproved;
        self.UserCanViewGroup = params.UserCanViewGroup;
        self.IsPublic = params.IsPublic;
        self.FolderId = params.FolderId;
        self.RatingClass = ''; //'hot'; //TODO: figure out rating.
        self.CreatedOnDate = ko.computed(function () {
            if (params.CreatedOnDate.startsWith('/Date')) {
                return dnn.social.toDateFromDotNetJson(params.CreatedOnDate).toDateString();
            } else {
                return new Date(params.CreatedOnDate.substring(0, 10)).toDateString();
            }
        });
        self.MembershipStatus = ko.computed(function () {
            if (self.IsMember()) {
                return "joinButton pending groupStatusLabel";
            }
            
            if (self.MembershipPending()) {
                return "joinButton pending groupStatusLabel";
            } else {
                return "joinButton dnnPrimaryAction";
            }
        });
        self.MembershipStatusText = ko.computed(function () {
            if (self.IsMember()) {
                return self.localizer.getString('YouAreMember');
            }
            
            if (self.MembershipPending()) {
                return self.localizer.getString('Pending');
            } else {
                return self.localizer.getString('Join');
            }
        });

        // GroupToolTip Fields
        self.NumberOfParticipants = 4;
        self.NumberOfActivities = 2;
        self.LastActiveDate = ko.observable('');       
        self.RecentParticipants = ko.observableArray([]);        
        self.RecentActivity = ko.observableArray([]);
        
        self.populateToolTip = function () {
            var failure = function () { };
            var success = function (result) {                
                // Last Activity Date
                self.LastActiveDate(result.LastActivityDate);
                
                // Tags
                var tagString = '';
                var tagCount = 0;
                var tagMax = 3;
                $.each(result.Tags,
                    function (index, tag) {
                        if (tagCount == tagMax) {
                            return false;
                        }
                        tagString = tagString + tag.name + ', ';
                        tagCount += 1;
                    });
                
                self.TagsString(tagString.substring(0, tagString.length - 2));
                
                // Recent Participants
                self.RecentParticipants([]);
                $.each(result.RecentParticipants, 
                        function(index, user) {
                            self.RecentParticipants.push(new dnn.groupDirectory.Member(user.userId, user.displayName, user.avatar, user.profileUrl, user.recentActivitySummary, user.summaryData));
                        });
                // Recent Activity
                self.RecentActivity([]);  
            };
            
            var toolTipParams = {
                GroupId: self.GroupId,
                GroupName: self.GroupName(),
                NumberOfParticipants: self.NumberOfParticipants,
                NumberOfActivities: self.NumberOfActivities
            };

            self.service.getsync('GetGroupToolTip', toolTipParams, success, failure, self.loading);            
        };

        self.joinGroup = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
            var success = function (data) {
                if (!data.Pending) {
                    self.IsMember(true);
                    self.MemberCount(self.MemberCount() + 1);
                } else {
                    self.MembershipPending(true);
                }
            };
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: self.localizer.getString('FailedToJoinGroupTitle'),
                    text: self.localizer.getString('FailedToJoinGroup').format(status)
                });
            };

            var groupParams = {
                groupId: self.GroupId,
                groupKey: self.GroupKey
            };

            if (!self.MembershipPending() && !self.IsMember()) {
                self.service.post('JoinGroup', groupParams, success, failure);
            }
        };

        self.hasGroupFolderPermission = function () {
            var hasPermission = false;
            var failure = function () {};
            var success = function (data) {
                hasPermission = data.Result;
            };
            var groupParams = {
                groupId: self.GroupId
            };
            self.service.getsync('HasGroupFolderPermission', groupParams, success, failure, self.loading);
            return hasPermission;
        };

        self.editGroup = function () {
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: self.localizer.getString('EditGroup'),
                width: 850,
                closeOnEscape: false,
                resizable: false,
				open: function () {
					$('.group-edit-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            		var $input = $('#' + $(this).attr('id').replace('_tag', ''));
						if ($input.data('dnnTagInput')) {
							$(this).dnnResetAutosize($input.data('dnnTagInput'));
						}
					});
				},
            };

            var hasGroupFolderPermission = self.hasGroupFolderPermission();
            if (!hasGroupFolderPermission) {
                var failure = function() {
                    $.dnnAlert({
                        title: self.localizer.getString('NoGroupFolderPermissionsTitle'),
                        text: self.localizer.getString('NoGroupFolderPermissions').format(status)
                    });
                };
                var success = function (data) {
                    hasGroupFolderPermission = data.Result;
                };
                self.service.postsync('AddGroupFolderUserPermission',
                    { GroupId: self.GroupId, GroupName: self.GroupName() },
                    success, failure, self.loading);
            }

            if (hasGroupFolderPermission) {
                var editModel = window.ko.contextFor($(self.settings.editId)[0]).$root;
                if (editModel != null) {
                    editModel.groupId(self.GroupId);
                    editModel.fileUploadControlId = $("[id$=EditWizard_groupImageFile_dnnFileUploadScope]")[0].id;
                    editModel.groupImageFileId = self.IconFile();
                    editModel.bindControls();
                }

                var fileUploadSettings = {
                    fileFilter: 'jpg,jpeg,jpe,gif,bmp,png',
                    foldersComboId: $('[id$=EditWizard_groupImageFile_FoldersComboBox]')[0].id,
                    filesComboId: $('[id$=EditWizard_groupImageFile_FilesComboBox]')[0].id,
                    folder: 'Groups/' + self.GroupId + '/',
                    progressBarId: $('[id$=EditWizard_groupImageFile_dnnFileUploadProgressBar]')[0].id,
                    dropZoneId: $('[id$=EditWizard_groupImageFile_dnnFileUploadDropZone]')[0].id,
                    selectedFolderId: self.FolderId
                };
                
                $('#' + $('[id$=EditWizard_groupImageFile_dnnFileUploadScope]')[0].id).dnnFileUpload(fileUploadSettings);
                dnn[fileUploadSettings.filesComboId].selectedItem({ key: self.IconFile() });
                var service = $.dnnSF();
                $.ajax({
                    url: service.getServiceRoot('internalservices') + 'fileupload/loadimage',
                    type: 'GET',
                    async: false,
                    data: { fileId: self.IconFile() },
                    success: function(d) {
                        var img = new Image();
                        var dropZoneId = fileUploadSettings.dropZoneId;
                        $(img).load(function() {
                            $('#' + dropZoneId + ' img').remove();
                            $(img).css({ 'max-width': 180, 'max-height': 150 }).insertBefore($('#' + dropZoneId + ' span'));
                        });
                        img.src = d;
                    },
                    error: function() {
                    }
                });
                $('.group-edit-dialog').dialog(options);
            }
        };
        
        self.navGroupHomeUrl = function () {
            var failure = function (err) {
                if (err.status === 401) {
                    $.dnnAlert({
                        title: self.localizer.getString('PrivateGroupTitle'),
                        text: self.localizer.getString('PrivateGroupMembershipRequired').format(status)
                    });
                } else {
                    $.dnnAlert({
                        title: self.localizer.getString('FailedToNavigateToGroupTitle'),
                        text: self.localizer.getString('FailedToNavigateToGroup').format(status)
                    });
                }                
            };
            var success = function (data) {
                window.location.href = data.Url;
            };

            if (self.IsPendingToBeApproved) {
                if (!self.UserCanViewGroup) {
                    $.dnnAlert({
                        title: self.localizer.getString('GroupPendingApprovalTitle'),
                        text: self.localizer.getString('GroupPendingApproval').format(status)
                    });
                } else {
                    self.service.getsync('GetGroupHomeUrl', { groupId: self.GroupId }, success, failure);
                }
            } else if (self.IsMember() || self.IsPublic || settings.canModerate) {
                self.service.getsync('GetGroupHomeUrl', { groupId: self.GroupId }, success, failure);
            } else {
                $.dnnAlert({
                    title: self.localizer.getString('FailedToNavigateToGroupTitle'),
                    text: self.localizer.getString('MembershipRequired').format(status)
                });
            }
        };
    };

})(window.dnn);