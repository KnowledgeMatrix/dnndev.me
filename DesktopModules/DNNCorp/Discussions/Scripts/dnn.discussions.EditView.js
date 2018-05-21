// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.discussions === 'undefined') dnn.discussions = {};

(function (dnn) {
    'use strict';

    dnn.discussions.EditView = function EditView($, ko, settings, model) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Edit');
        
        this.postImageService = this.social.getService('Social');
        
        this.isMobileView = ko.computed(function () {
            var root = ko.contextFor($(settings.parentId)[0]);
            if (root && root.$root && root.$root.isMobileView) {
                return root.$root.isMobileView();
            }
            return false;
        });

        var localizer = this.social.getLocalizationController();

        this.moderator = settings.moderator || false;

        this.model = ko.observable(dnn.social.komodel(model));

        this.persistentAttachments = null;

        this.loading = ko.observable(false);

        this.attachmentsHtml = ko.observable('');

        this.terms = ko.observableArray([]);

        this.subscribeToActivity = ko.observable();
        
        this.showModeration = ko.observable(false);

        this.enableSubmit = ko.observable(true);

        this.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnActions .dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            }
            else {
                submitBtn.attr('disabled', 'disabled');
            }
        });

        this.bindControls = function (sequence, content) {
            dnn.social.EventQueue.push(
                function () {
                    if (String.isEmpty(settings.suggestedTitle) == false) {
                        that.model().contentTitle(settings.suggestedTitle);

                        dnn.social.EventQueue.push(
                            function () {
                                $('.answer-add-content', settings.moduleScope).focus();
                            });
                    } else {
                        $('.answer-add-title', settings.moduleScope).focus();
                    }
                });

            that.showModeration(false);
            
            if (typeof that.controlsBound !== 'undefined') {
                that.model(dnn.social.komodel(model));
                that.initModel();
            } else {
                that.controlsBound = true;
            }

            $('#tags', settings.moduleScope).val(that.serializeTags(that.model().tags()));
            $('#tags', settings.moduleScope).dnnTagsInput({
                onAddTag:
                    function (t) {
                        that.model().tags.push(t);
                    },
                onRemoveTag:
                    function (t) {
                        $.each(that.model().tags(),
                            function (index, term) {
                                if (term === t || (typeof term.name == 'function' && term.name() === t)) {
                                    that.model().tags.splice(index, 1);
                                    return false;
                                }

                                return true;
                            });
                    },
                width: '57%',
                minInputWidth: '200px',
                defaultText: localizer.getString('AddTag')
            });
            
            if (content !== undefined) {
                that.model().content(content);
            }

            var editorSettings = {
                toolbar: settings.editorToolbar,
                allowIframe: settings.editorAllowIframe,
                allowScript: settings.editorAllowScript,
                allowEmbed: settings.editorAllowEmbed
            };
            var module = $('.answer-add-content', settings.moduleScope).addClass('validateErrorAfterParent');
            dnn.social.initRedactor(module, null, settings.editorMode, that.isMobileView(), that.postImageService.getRoot(), editorSettings,
                function (redactor) {
                    if (that.model().content()) {
                        $('.answer-add-content', settings.moduleScope).dnnRedactor('code.set', that.model().content());
                    }

                    dnn.social.initUserMentions(module, settings.moduleId, settings.moduleName, false, redactor);
                });
            
            if (sequence !== undefined) {
                that.model().revisionSequence(sequence);
            }
            
            // NOTES by Richard,  I must put those init code here, everytime dialog close then open again, 
            // the upload control will not work.
            // cause jquery dialog close will move those elements out and then they will lost their own initialized 
            // jquery instance, but platform controls only init themself when page loaded.
            // Everytime dialog open, i need to reinit those upload control and dropdown list control here.
            // Best way to do this is to wrap those init code into platform's control and call it whenever you need
            var fileuploadSettings = window.dnn.dnnFileUpload.settings[settings.fileUploadControl];
            if (fileuploadSettings) {
                $('#' + settings.fileUploadControl).dnnFileUpload(fileuploadSettings);
                dnn.createDropDownList('#' + fileuploadSettings.foldersComboId,
                    {
                        "selectedItemCss": "selected-item",
                        "internalStateFieldId": fileuploadSettings.foldersComboId + "_state",
                        "disabled": true,
                        "selectItemDefaultText": "Site Root",
                        "initialState": { "selectedItem": { "key": "57", "value": "My Folder" } },
                        "services": { "moduleId": "", "serviceRoot": "InternalServices", "getTreeMethod": "ItemListService/GetFolders", "sortTreeMethod": "ItemListService/SortFolders", "getNodeDescendantsMethod": "ItemListService/GetFolderDescendants", "searchTreeMethod": "ItemListService/SearchFolders", "getTreeWithNodeMethod": "ItemListService/GetTreePathForFolder", "rootId": "Root", "parameters": { "permission": "READ,ADD" } },
                        "itemList": { "sortAscendingButtonTitle": "A-Z", "unsortedOrderButtonTooltip": "Remove sorting", "sortAscendingButtonTooltip": "Sort in ascending order", "sortDescendingButtonTooltip": "Sort in descending order", "selectedItemExpandTooltip": "Click to expand", "selectedItemCollapseTooltip": "Click to collapse", "searchInputPlaceHolder": "Search...", "clearButtonTooltip": "Clear", "searchButtonTooltip": "Search", "loadingResultText": "...Loading Results", "resultsText": "Results", "firstItem": null, "disableUnspecifiedOrder": true },
                        "onSelectionChanged": ["dnn.dnnFileUpload.Folders_Changed"]
                    }, {});
                dnn.createDropDownList('#' + fileuploadSettings.filesComboId,
                    {
                        "selectedItemCss": "selected-item",
                        "internalStateFieldId": fileuploadSettings.filesComboId + "_state",
                        "disabled": false,
                        "selectItemDefaultText": "<None Specified>",
                        "initialState": { "selectedItem": { "key": "-1", "value": "<None Specified>" } },
                        "services": { "moduleId": "", "serviceRoot": "InternalServices", "getTreeMethod": "ItemListService/GetFiles", "sortTreeMethod": "ItemListService/SortFiles", "getNodeDescendantsMethod": null, "searchTreeMethod": "ItemListService/SearchFiles", "getTreeWithNodeMethod": null, "rootId": "Root", "parameters": { "parentId": "-1", "filter": null } },
                        "itemList": { "sortAscendingButtonTitle": "A-Z", "unsortedOrderButtonTooltip": "Remove sorting", "sortAscendingButtonTooltip": "Sort in ascending order", "sortDescendingButtonTooltip": "Sort in descending order", "selectedItemExpandTooltip": "Click to expand", "selectedItemCollapseTooltip": "Click to collapse", "searchInputPlaceHolder": "Search...", "clearButtonTooltip": "Clear", "searchButtonTooltip": "Search", "loadingResultText": "...Loading Results", "resultsText": "Results", "firstItem": { "key": "-1", "value": "<None Specified>" }, "disableUnspecifiedOrder": true },
                        "onSelectionChanged": ["dnn.dnnFileUpload.Files_Changed"]
                    }, {});
            }

            that.generateAttachmentsHtml();
        };

        this.serializeTags = function (tags) {
            var list = [];

            $.each(tags,
                function (index, tag) {
                    if (typeof tag.name === 'function' && tag.name()) {
                        list.push(tag.name());
                    } else {
                        list.push(tag);
                    }
                });

            return list;
        };

        this.completionEvent = function (m) {
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (root && root.$root) {
                    var collectionItem = {
                        id: m.topicId,
                        title: m.contentTitle,
                        targetUrl: m.detailsUrl,
                        contentItemId: m.contentItemId,
                        contentTypeId: m.contentTypeId,
                        createdOnDate: m.createdOnDate,
                        lastModifiedOnDate: m.lastModifiedOnDate
                    };

                    if (that.model().contentItemId() < 1) {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'CreateContentItem', model: collectionItem });
                        
                        dnn.social.ipc.post(settings, 'DNNCorp/RelatedContent',
                            { event: 'Refresh' });
                        
                    } else {
                        dnn.social.ipc.post(settings, 'DNNCorp/MyStatus',
                            { event: 'EditContentItem', model: collectionItem });
                    }

                    var topic = m;
                    if (topic.approved)
                        that.cancel();
                    else
                        that.showModeration(true);

                    that.enableSubmit(true);

                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                    }
                }

                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                return true;
            }

            return false;
        };

        this.save = function () {
            if (!that.enableSubmit())
                return false;

            that.enableSubmit(false);

            if (!that.validate($('#postFields', settings.moduleScope))) {
                that.enableSubmit(true);
                return false;
            }

            if (!that.submit()) {
                return false;
            }

            return true;
        };

        this.getJumpUrl = function (m) {
            if (typeof m.detailsUrl === 'string' && m.detailsUrl.length > 0) {
                return m.detailsUrl;
            }

            return settings.returnUrl;
        };

        this.getLastSequence = function (continueWith) {
            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(localizer, status);
            };

            var success = function (revision) {
                if (that.model().revisionSequence() != revision.sequence) {
                    $.dnnRevisionChangePrompt(localizer, continueWith);
                    that.enableSubmit(true);
                } else {
                    continueWith();
                }
            };

            var params = {
                contentItemId: that.model().contentItemId(),
                sequence: that.model().revisionSequence()
            };

            return that.service.get('GetLastSequence', params, success, failure);
        };

        this.submit = function () {
            var failure = function (xhr, status) {
                var r = JSON.parse(xhr.responseText);
                $.dnnAlert({
                    title: r.Title || localizer.getString('SaveFailedTitle'),
                    text: status || localizer.getString('SaveFailed')
                });
                that.enableSubmit(true);
            };

            var success = function (m) {
                dnn.social.EventQueue.push(
                    function () {
                        that.completionEvent(m);
                    });
            };

            var tags = [];

            $.each(that.model().tags(),
                function (index, t) {
                    if (typeof(t) === 'string') {
                        tags.push(t);
                    } else {
                        tags.push(t.name());
                    }
                });

            var attachments = [];
            
            $.each(that.model().attachments(),
                function (index, a) {
                    attachments.push(a.fileId());
                });
            
            var html = $('.answer-add-content', settings.moduleScope).dnnRedactor('code.get');

            var params = {
                contentItemId: that.model().contentItemId(),
                topicId: that.model().topicId(),
                groupId: settings.groupId,
                closed : that.model().closed(),
                approved: that.model().approved(),
                contentTitle: that.model().contentTitle(),
                content: html,
                subscribeToActivity: that.subscribeToActivity(),
                tags: tags,
                attachments: attachments
            };

            if (that.model().topicId() < 1) {
                that.service.post('Add', params, success, failure, that.loading);
            } else {
                that.getLastSequence(function() {
                    that.service.post('Update', params, success, failure, that.loading);
                });
            }
        };

        this.remove = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('DeleteErrorTitle'),
                    text: localizer.getString('DeleteError').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function () {
                that.cancel();
                window.location = settings.returnUrl;
            };

            var params = {
                ideaId: that.model().ideaId()
            };

            that.service.post('Delete', params, success, failure, that.loading);
        };

        this.cancel = function () {
            $('.editor-dialog').dialog('close');
        };

        this.setSuggestedTitle = function (title) {
            settings.suggestedTitle = title;
        };

        this.loading.subscribe(
            function () {
                if (that.loading()) {
                    $(settings.moduleScope).addClass('loading');
                }
                else {
                    $(settings.moduleScope).removeClass('loading');
                }
            });

        this.initModel = function () {
            if (that.model != null) {
                that.subscribeToActivity(true);
                if (that.model().topicId() < 1) {
                    if (settings.approved) {
                        that.model().approved(true);
                    }
                }
            }
        };

        this.generateAttachmentsHtml = function () {
            var attachments = this.persistentAttachments == null ? 
                this.model().attachments() : this.persistentAttachments;
            
            var results = attachments.length == 0 ? '' :
                             attachments.length == 1 ? 'Attachment: {0}' : 'Attachments: {0} {1}';
            
            if (results) {
                var replace1 = "<b>" + attachments[0].fileName() + "</b>";
                var replace2 = "and <b>" + (attachments.length - 1) + " more</b>";
                results = results.replace("{0}", replace1);
                results = results.replace("{1}", replace2);
            }
            
            this.model().attachments(attachments);
            this.attachmentsHtml(results);
        };

        this.attachFileUploaded = function (fileUploadSettings, fileId, fileName) {
            if (fileUploadSettings) {
                var myFileuploadSettings = window.dnn.dnnFileUpload.settings[settings.fileUploadControl];
                if (fileUploadSettings.fileUploadId === myFileuploadSettings.fileUploadId) {
                    if (fileId > 0 && fileName) {
                        var attachments = this.model().attachments();
                        var index = -1;
                        $.each(attachments, function (i, v) {
                            if (v.fileId() === fileId) {
                                index = i;
                                return false;
                            }
                            return true;
                        });
                        if (index < 0) {
                            attachments.push({
                                fileId: ko.observable(fileId),
                                fileName: ko.observable(fileName)
                            });
                            this.model().attachments(attachments);
                            this.generateAttachmentsHtml();
                        }
                    }
                }
            }
        };

        this.binded = function() {
            this.initModel();
            dnn.social.attachFileUploaded($.proxy(this.attachFileUploaded, this));
            dnn.social.ipc.register(settings,
                function (source, message) {
                    if (!message || !message.event) return;
                    switch (message.event) {
                        case 'RemoveAttachment':
                            if (typeof that.model().attachments == 'function') {
                                that.persistentAttachments = message.attachments;
                                that.generateAttachmentsHtml();
                            }
                            break;
                    }
                });
        };
    };
    
})(window.dnn);