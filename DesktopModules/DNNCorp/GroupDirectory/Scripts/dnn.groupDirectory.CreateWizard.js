// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};

(function (dnn) {
    'use strict';

    dnn.groupDirectory.Tab = function (tabId, tabName, selected) {
        var self = this;
        self.TabId = tabId;
        self.TabName = tabName;
        self.Selected = ko.observable(selected);
    };

    dnn.groupDirectory.CreateWizard = function ($, ko, settings) {
        var self = this;

        $.extend(this, settings);
        self.ko = ko;
        self.settings = settings;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService('List');
        self.localizer = self.social.getLocalizationController();

        self.groupUrl = ko.observable();
        self.groupId = ko.observable();
        self.groupIsPendingToBeApproved = false;

        self.isMobileView = ko.computed(function () {
            var root = ko.contextFor($(settings.parentId)[0]);
            if (root && root.$root && root.$root.isMobileView) {
                return root.$root.isMobileView();
            }
            return false;
        });

        // Input Fields
        self.groupName = ko.observable();
        self.description = ko.observable();
        self.tags = ko.observableArray([]);
        self.Accessibility = ko.observable();
        self.reviewMembers = ko.observable(false);
        self.selectedTabs = ko.observableArray(settings.groupTabs);
        self.tabs = ko.observableArray(settings.groupTabs);
        self.homeTabId = ko.observable();
        self.enableSubmit = ko.observable(true);
        self.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnActions .dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            } else {
                submitBtn.attr('disabled', 'disabled');
            }
        });

        // Tags
        this.serializeTags = function (tags) {
            var list = [];
            $.each(tags,
                function (index, tag) {
                    list.push(tag);
                });
            return list;
        };

        // Group Tabs
        this.updateSelectedTabs = function (data) {
            var tabs = self.selectedTabs().filter(function (tab) { return tab.selected == true; });
            if (data != undefined) {
                if (data.selected) tabs.push(data);
            }
            self.selectedTabs(tabs.sort(function (a, b) { if (a.tabId < b.tabId) return -1; if (a.tabId > b.tabId) return 1; return 0; }));

            return true;
        };
        
        this.canInviteByEmail = function () {
            if (self.Accessibility() == 'public') {
                $('.inviteByEmailSection').show();
                $('.invitePrivateList').addClass('inviteList');
                $('.inviteList').removeClass('invitePrivateList');
                $('.reviewMembers').removeAttr('disabled');
            }
            else {
                $('.reviewMembers').attr('disabled', 'disabled');
                $('.accessibility-review .dnnCheckbox').removeClass('dnnCheckbox-checked');
                self.reviewMembers(false);
            }
            return true;
        };

        // Create Group
        this.createGroup = function () {
            $('#next').hide();
            $('#prev').hide();
            var failure = function (data, status) {
                var r = JSON.parse(data.responseText);
                $.dnnAlert({
                    title: r.Title || self.localizer.getString('CreateFailedTitle'),
                    text: self.localizer.getString('CreateFailed') + (r.ErrorMessage || status)
                });
                self.enableSubmit(true);
                $('#next').show();
                $('#prev').show();
            };
            var success = function (data) {
                self.groupUrl(data.GroupInfo.url);
                self.groupId(data.GroupInfo.groupId);
                self.groupIsPendingToBeApproved = data.GroupInfo.isPendingToBeApproved;

                var inviteMembers = ko.contextFor($(settings.inviteMembersId)[0]).$root;
                
                if (self.groupIsPendingToBeApproved) {
                    if (inviteMembers && inviteMembers.inviteCount() > 0) {
                        $.dnnAlert({
                            title: self.localizer.getString('NoInvitesSentPendingGroupTitle'),
                            text: self.localizer.getString('NoInvitesSentPendingGroup'),
                            callback: function() { self.onGroupCreated(); },
                            close: function() { self.onGroupCreated(); }
                        });
                    } else {
                        self.onGroupCreated();
                    }
                } else {                
                    if (inviteMembers) {
                        inviteMembers.groupName(self.groupName());
                        inviteMembers.groupId(self.groupId());
                        inviteMembers.inviteShowResults = true;
                        inviteMembers.inviteCallback = function() { self.onGroupCreated(); };
                        inviteMembers.inviteClose = function() { self.onGroupCreated(); };
                        inviteMembers.invite();
                    }
                }
            };

            var tags = [];
            $.each(self.tags(),
                function (index, t) {
                    if (typeof (t) === 'string') {
                        tags.push(t);
                    } else {
                        tags.push(t.name());
                    }
                });

            var selectedTabs = [];
            $.each(self.tabs(),
                function (index, t) {
                    if (t.selected) {
                        selectedTabs.push(t);
                    }
                });
            
            var dnnFileUploadScope = $("[id$=Create_groupImageFile_dnnFileUploadScope]")[0].id;
            var dnnFileUploadSettings = dnn.dnnFileUpload.settings[dnnFileUploadScope];
            var filesCombo = dnn[dnnFileUploadSettings.filesComboId];
            var selectedFileId = filesCombo.selectedItem() ? filesCombo.selectedItem().key : "-1";

            var params = {
                GroupName: self.groupName(),
                Description: self.description(),
                IconFile: 'FileID=' + selectedFileId,
                Tags: tags,
                Tabs: selectedTabs,
                HomeTabId: self.homeTabId(),
                IsPublic: (self.Accessibility() == 'public'),
                ReviewMembers: self.reviewMembers(),
                RoleGroupId: settings.roleGroupId
            };

            self.service.postsync("Create", params, success, failure, self.loading);
        };

        this.cancel = function () {
            $('.create-dialog').dialog('close');
        };

        this.createWizard = function () {
            var wizardPages = ['details', 'features', 'invite'];
            var options = {
                root: $('#wizard'),
                pages: wizardPages,
                validate: self.validator.validate,
                moduleId: settings.moduleId,
                moduleScope: settings.moduleScope,
                customValidator: [{
                    name: 'validateGroupName',
                    validate: function () {
                        var validationExpression = new RegExp("^[0-9a-zA-Z \_\-]+$");
                        return validationExpression.test(self.groupName());
                    },
                    errorMsg: self.localizer.getString('GroupNameInvalid')
                },
                {
                    name: 'validateGroupNameDoesNotExist',
                    validate: function () {
                        var exists = false;
                        var failure = function () { };
                        var success = function (data) {
                            if (data == true) {
                                exists = true;
                            }
                        };
                        var params = { GroupName: self.groupName() };
                        self.service.getsync('CheckGroupNameExists', params, success, failure, self.loading);
                        return !exists;
                    },
                    errorMsg: self.localizer.getString('GroupNameAlreadyExists')
                },
                {
                    name: 'validateGroupImage',
                    validate: function () {
                        var dnnFileUploadScope = $("[id$=Create_groupImageFile_dnnFileUploadScope]")[0].id;
                        var dnnFileUploadSettings = dnn.dnnFileUpload.settings[dnnFileUploadScope];
                        var filesCombo = dnn[dnnFileUploadSettings.filesComboId];
                        var selectedFileId = filesCombo.selectedItem() ? filesCombo.selectedItem().key : null;
                        return selectedFileId && parseInt(selectedFileId) > 0;
                    },
                    errorMsg: self.localizer.getString('MustUploadGroupImage')
                },
                {
                    name: 'validateGroupFeatures',
                    validate: function () {
                        return (self.selectedTabs().length > 0);
                    },
                    errorMsg: self.localizer.getString('MustSelectOneGroupFeature')
                }],
                
                onCancel: function() {
                    $('.create-dialog').dialog('close');
                },

                onSwitch: function (page) {
                    $('#prev').html(self.localizer.getString(page == 0 ? 'Cancel' : 'Previous'));
                    switch (page) {
                        case 0:
                            $('#next').html(self.localizer.getString('Next'));
                            // fileUpload reinit code for mobile
                            var isMobileView = self.isMobileView();
                            $('#wizard .dnnMobileUploadGroupImage').remove();
                            if (isMobileView) {
                                $('<span class="dnnMobileUploadGroupImage">Add a group photo</span>').insertBefore('#wizard .dnnInputFileWrapper');
                                var width = $('#wizard .dnnFileUploadDropZone').width();
                                $('#wizard .dnnFileUploadDropZone').height(width);
                            } else {
                                $('#wizard .dnnFileUploadDropZone').height(150);
                            }
                            break;
                        case 1:
                            var inviteMemberModel = ko.contextFor($(settings.inviteMembersId)[0]).$root;
                            inviteMemberModel.groupName(self.groupName());
                            inviteMemberModel.showBottomPanel(false);
                            inviteMemberModel.bindControls();
                            break;
                    }
                },

                onFinish: function () {
                    self.createGroup();
                }
            };

            $.extend(this, new dnn.social.Wizard($, ko, self.social, options, self.isMobileView()));
            $('#invite-actions').hide();
        };

        this.onGroupCreated = function() {
            if (self.groupIsPendingToBeApproved) {
                self.cancel();
                self.openGroupUnderModerationDialog();
            } else {
                window.location = self.groupUrl();
            }
        };

        this.openGroupUnderModerationDialog = function () {
            var isMobileView = self.isMobileView();
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                width: isMobileView ? 'auto' : 750,
                resizable: false,
                title: self.localizer.getString('CreateGroup'),
                close: function() {
                    window.location.reload(true);
                }
            };
            $("#groupUnderModeration").dialog(options);
        };

        this.closeGroupUnderModerationDialog = function() {
            $("#groupUnderModeration").dialog("close");
        };

        this.createWizard();

        this.bindControls = function () {
            $('#next').show();
            $('#prev').show();
            self.Accessibility('public');
            $('#tab_' + settings.homeTabId).attr("disabled", "disabled");
            var tags = self.serializeTags(self.tags()).join(',');
            $('#tags').val(tags);

            $('#tags').dnnTagsInput({
                onAddTag:
                    function (t) {
                        self.tags.push(t);
                    },
                onRemoveTag:
                    function (t) {
                        $.each(self.tags(),
                            function (index, term) {
                                if (term === t || (typeof term.name == 'function' && term.name() === t)) {
                                    self.tags.splice(index, 1);
                                    return false;
                                }
                                return true;
                            });
                    },
                minInputWidth: '200px',
                width: '57%',
                defaultText: self.localizer.getString('AddTag')
            });

            $('#tags').dnnImportTags(tags);
        };
    };
})(window.dnn);