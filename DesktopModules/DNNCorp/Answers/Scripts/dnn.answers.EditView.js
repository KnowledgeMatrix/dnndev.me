// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.answers === 'undefined') dnn.answers = {};

(function (dnn) {
    'use strict';

    dnn.answers.EditView = function EditView($, ko, settings, model) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.serviceFramework = $.ServicesFramework(settings.moduleId);

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

        this.loading = ko.observable(false);

        this.terms = ko.observableArray([]);

        this.subscribeToActivity = ko.observable();

        this.showModeration = ko.observable(false);

        this.enableSubmit = ko.observable(true);

        this.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            } else {
                submitBtn.attr('disabled', 'disabled');
            }

        });

        this.bindControls = function (m) {

            dnn.social.EventQueue.push(
                function () {
                    if (String.isEmpty(settings.suggestedTitle) == false) {
                        that.model().contentTitle(settings.suggestedTitle);
                        dnn.social.EventQueue.push(
                            function () {
                                $('.answer-add-content').focus();
                            });
                    } else {
                        $('.answer-add-title').focus();
                    }
                });

            that.showModeration(false);

            that.model(dnn.social.komodel(m || model));

            that.initModel();
            $('#tags', settings.moduleScope).val(that.serializeTags(that.model().tags()).join(','));
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

            var editorSettings = {
                toolbar: settings.editorToolbar,
                allowIframe: settings.editorAllowIframe,
                allowScript: settings.editorAllowScript,
                allowEmbed: settings.editorAllowEmbed
            };

            var $module = $('.answer-add-content', settings.moduleScope).addClass('validateErrorAfterParent');
            dnn.social.initRedactor($module, null, settings.editorMode, that.isMobileView(), that.postImageService.getRoot(), editorSettings,
                    function (redactor) {
                        if (that.model().body()) {
                            $('.answer-add-content', settings.moduleScope).dnnRedactor('code.set', that.model().body());
                        }
                        dnn.social.initUserMentions($module, settings.moduleId, settings.moduleName, false, redactor);
                    });
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

            this.enableSubmit(false);
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (typeof root !== 'undefined' &&
                    typeof root.$root !== 'undefined') {
                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                    }
                }

                var collectionItem = {
                    id: m.postId,
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

                var post = m;
                if (post.approved)
                    that.cancel();
                else
                    that.showModeration(true);

                that.enableSubmit(true);

                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                return true;
            }

            return false;
        };
        this.titleLabel = ko.computed(function () {
            return localizer.getString('askQuestion');
        });

        this.descriptionLabel = ko.computed(function () {
            if (that.model().parentId() <= 0) {
                return localizer.getString('QuestionDescription');
            }
            return localizer.getString('AnswerQuestion');
        });

        this.saveLabel = ko.computed(
            function () {
                if (that.model().parentId() <= 0) {
                    return localizer.getString('askAsk');
                }

                return localizer.getString('askAnswer');
            });

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
                postId: that.model().postId(),
                sequence: that.model().revisionSequence()
            };

            var service = that.social.getService('Detail');
            service.get('GetLastSequence', params, success, failure);
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
                    if (typeof (t) === 'string') {
                        tags.push(t);
                    } else {
                        tags.push(t.name());
                    }
                });

            var html = $('.answer-add-content', settings.moduleScope).dnnRedactor('code.get');

            var params = {
                postId: that.model().postId(),
                approved: that.model().approved(),
                closed: that.model().closed(),
                content: html,
                contentTitle: that.model().contentTitle(),
                subscribeToActivity: that.subscribeToActivity(),
                groupId: settings.groupId,
                tags: tags
            };

            if (params.postId < 1) {
                that.service.post('Ask', params, success, failure, that.loading);
            } else {
                that.getLastSequence(function () {
                    that.service.post('Update', params, success, failure, that.loading);
                });
            }
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
                } else {
                    $(settings.moduleScope).removeClass('loading');
                }
            });

        this.initModel = function (reset) {
            if (that.model != null) {
                if (typeof reset === 'boolean' && reset) {
                    that.model().contentTitle(new String());
                    that.model().content(new String());
                    that.model().tags(new Array());
                }

                that.subscribeToActivity(true);

                if (that.model().postId() < 1) {
                    if (settings.approved) {
                        that.model().approved(true);
                    }
                }
            }
        };

        this.binded = function () {
            this.initModel();
        };
    };
})(window.dnn);