// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social.GroupEditWizard === 'undefined') dnn.social.GroupEditWizard = {};

(function (dnn) {
    'use strict';

    dnn.social.GroupEditWizard = function ($, ko, sf, settings) {
        var self = this;

        $.extend(this, settings);
        self.ko = ko;
        self.settings = settings;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService('SocialGroup');
        self.localizer = self.social.getLocalizationController();
        self.groupId = ko.observable(settings.groupId);
        self.tabId = settings.tabId;
        self.groupImageFileId = '-1';

        // Input Fields        
        self.groupName = ko.observable();
        self.description = ko.observable();
        self.groupImageUrl = ko.observable();
        self.tags = ko.observableArray([]);
        self.accessibility = ko.observable('public');
        self.isPrivate = ko.observable('false');
        self.reviewMembers = ko.observable(false);

        self.enableSubmit = ko.observable(true);
        self.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnActions .dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            } else {
                submitBtn.attr('disabled', 'disabled');
                self.reviewMembers(false);
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
        this.bindTags = function () {
            var tags = self.serializeTags(self.tags()).join(',');
            $('#groupTags', settings.moduleScope).val(tags);
            $('#groupTags', settings.moduleScope).dnnTagsInput({
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
                width: '57%',
                minInputWidth: '200px',
                defaultText: self.localizer.getString('AddTag')
            });
            $('#groupTags', settings.moduleScope).dnnImportTags(tags);
        };

        this.accessibilityChange = function () {
            if (self.accessibility() =="public") {
                $('.reviewMembers').removeAttr('disabled');                
            }
            else {
                $('.reviewMembers').attr('disabled', 'diabled');
                $('.accessibility-review .dnnCheckbox').removeClass('dnnCheckbox-checked');
                self.reviewMembers(false);
            }
            return true;
        };

        this.loadGroup = function () {
            var failure = function () {};
            var success = function (data) {
                if (data.GroupInfo.groupId > -1) {
                    self.groupId(data.GroupInfo.groupId);
                    self.groupName(data.GroupInfo.groupName);
                    self.description(dnn.social.htmlDecode(data.GroupInfo.description));
                    self.groupImageUrl(data.GroupInfo.imageUrl);
                    self.tags(data.GroupInfo.tags);
                    self.bindTags();
                    self.isPrivate(data.GroupInfo.isPublic.toString());
                    self.reviewMembers(data.GroupInfo.reviewMembers);
                    if (data.GroupInfo.isPublic.toString() == 'true') {
                        self.accessibility('public');
                    } else {
                        self.accessibility('private');
                        $('.reviewMembers').attr('disabled', 'diabled');
                    }
                }
            };
            var params = { groupId: self.groupId, tabId: self.tabId };
            if (self.groupId() > -1) {
                self.service.getsync('GetGroup', params, success, failure);
            }
        };
        
        // Custom Validator
        this.customValidator = [{
            name: 'validateGroupName',
            validate: function () {
                var validationExpression = new RegExp("^[0-9a-zA-Z \_\-]+$");               
                return validationExpression.test(self.groupName());
            },
            errorMsg: self.localizer.getString('GroupNameInvalid')
        }];      
        
        this.bindControls = function () {
            self.loadGroup();
        };

        this.update = function () {
            if (!self.validate($('#postFields', settings.moduleScope), self.customValidator)) {
                return false;
            }

            var failure = function (data, status) {
                $.dnnAlert({
                    title: self.localizer.getString('UpdateFailedTitle'),
                    text: self.localizer.getString('UpdateFailed') + JSON.parse(data.responseText)["ErrorMessage"] || status
                });
                self.enableSubmit(true);
            };
            var success = function () {
                dnn.social.EventQueue.push(
                    function () {
                        window.location.reload();
                    });
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

            var dnnFileUploadScope = $('.dnnFileUploadScope', settings.moduleScope).attr('id');
            var dnnFileUploadSettings = dnn.dnnFileUpload.settings[dnnFileUploadScope];
            var filesCombo = dnn[dnnFileUploadSettings.filesComboId];
            var selectedFileId = filesCombo.selectedItem() ? filesCombo.selectedItem().key : "-1";

            var fileId = parseInt(selectedFileId);
            if (fileId < 1) fileId = self.groupImageFileId;
            
            var params = {
                GroupId: self.groupId(),
                GroupName: self.groupName(),
                Description: self.description(),
                IconFile: 'FileID=' + fileId,
                Tags: tags,
                IsPublic: (self.accessibility() == 'public'),
                ReviewMembers: self.reviewMembers()
            };
            self.service.post('UpdateGroup', params, success, failure, self.loading);
            return false;
        };

        this.cancel = function () {
            $('.group-edit-dialog').dialog('close');
        };
    };
})(window.dnn);