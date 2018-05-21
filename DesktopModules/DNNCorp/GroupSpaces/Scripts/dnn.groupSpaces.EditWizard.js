// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2015, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';


    dnn.groupSpaces.Tab = function (tabId, tabName, selected) {
        var self = this;
        self.TabId = tabId;
        self.TabName = tabName;
        self.Selected = ko.observable(selected);
    };

    dnn.groupSpaces.EditWizard = function EditWizard($, ko, sf, settings) {
        var self = this;

        $.extend(this, settings);
        self.ko = ko;
        self.settings = settings;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService('GroupSpaces');
        self.localizer = self.social.getLocalizationController();

        // Input Fields
        self.groupId = ko.observable();
        self.groupName = ko.observable();
        self.description = ko.observable();
        self.groupImageUrl = ko.observable();
        self.tags = ko.observableArray([]);
        self.isPublic = ko.observable('true');
        self.isPrivate = ko.observable('false');
        self.reviewMembers = ko.observable(false);
        self.enableSubmit = ko.observable(true);
        self.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnActions .dnnPrimaryAction', $(settings.moduleScope));
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
        this.bindTags = function () {
            var tags = self.serializeTags(self.tags()).join(',');
            $('#groupTags').val(tags);
            $('#groupTags').dnnTagsInput({
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
            $('#groupTags').dnnImportTags(tags);
        };

        this.loadGroup = function () {
            var failure =
                function (xhr, status) {
                };

            var success =
                function (data) {
                    if (data.GroupInfo.groupId > -1) {
                        self.groupId(data.GroupInfo.groupId);
                        self.groupName(data.GroupInfo.groupName);
                        self.description(data.GroupInfo.description);
                        self.groupImageUrl(data.GroupInfo.imageUrl);

                        self.tags(data.GroupInfo.tags);
                        self.bindTags();

                        self.isPublic(data.GroupInfo.isPublic.toString());
                        self.isPrivate(data.GroupInfo.isPublic.toString());
                        self.reviewMembers(data.GroupInfo.reviewMembers);
                    }
                };

            var params = { groupId: settings.groupId, tabId: settings.tabId };
            if (settings.groupId > -1) {
                self.service.get('GetGroup', params, success, failure);
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

        this.manualValidate = function () {
            var validationExpression = new RegExp("^[0-9a-zA-Z \_\-]+$");
            if (!validationExpression.test(self.groupName())) {                
                $.dnnAlert({
                    title: self.localizer.getString('UpdateFailedTitle'),
                    text: self.localizer.getString('GroupNameInvalid')
                });                
                return false;
            }
            if (self.description().length <= 0) {
                $.dnnAlert({
                    title: self.localizer.getString('UpdateFailedTitle'),
                    text: self.localizer.getString('DescriptionInvalid')
                });
                return false;
            }            
            if (self.tags().length <= 0) {
                $.dnnAlert({
                    title: self.localizer.getString('UpdateFailedTitle'),
                    text: self.localizer.getString('TagsInvalid')
                });
                return false;
            }
            return true;
        };
        
        this.bindControls = function () {
            self.loadGroup();
        };

        this.update = function () {
            if (!self.validate($('#groupFields'))) {
                return false;
            }
            if (!self.validate($('#groupFields'), self.customValidator)) {
                return false;
            }
            if (!self.manualValidate()) {
                return false;
            }

            var failure = function (data, status) {
                $.dnnAlert({
                    title: self.localizer.getString('UpdateFailedTitle'),
                    text: self.localizer.getString('UpdateFailed') + JSON.parse(data.responseText)["ErrorMessage"] || status
                });
                self.enableSubmit(true);
            };
            var success = function (data) {
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

            var dnnFileUploadScope = $('.dnnFileUploadScope').attr('id');
            var dnnFileUploadSettings = dnn.dnnFileUpload.settings[dnnFileUploadScope];
            var fileIdCtrl = $('#' + dnnFileUploadSettings.fileIdId);
            var fileId = parseInt(fileIdCtrl.val());

            var params = {
                GroupId: self.groupId(),
                GroupName: self.groupName(),
                Description: self.description(),
                IconFile: 'FileID=' + fileId,
                Tags: tags,
                IsPublic: self.isPublic(),
                ReviewMembers: self.reviewMembers()
            };

            self.service.post("Update", params, success, failure, self.loading);
            return false;
        };

        this.cancel = function () {
            $('.group-edit-dialog').dialog('close');
        };
    };
})(window.dnn);