// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function (dnn) {
    'use strict';
    dnn.wiki.ContentEditor = function ContentEditor(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);
        this.localizer = social.getLocalizationController();

        this.postImageService = social.getService('Social');

        this.isMobileView = window.ko.observable(false);

        this.title = window.ko.observable('');

        this.modal = window.ko.observable(false);

        this.toc = window.ko.observable(true);

        this.tags = window.ko.observableArray([]);

        this.articleType = window.ko.observable();

        this.articleId = window.ko.observable(-1);

        this.contentItemId = window.ko.observable(-1);

        this.content = window.ko.observable('');

        this.summary = window.ko.observable('');

        this.groupId = window.ko.observable(-1);

        this.subscribeToActivity = window.ko.observable(true);

        this.availableTypes = window.ko.observableArray([]);

        this.availableTypes.push(dnn.social.komodel(settings.emptyType));

        this.primaryArticle = window.ko.observable(false);

        this.canModerate = window.ko.observable(settings.canModerate);

        this.approved = window.ko.observable(false);

        $.each(settings.availableTypes,
            function (unused, t) {
                that.availableTypes.push(dnn.social.komodel(t));
            });

        this.canPublish = window.ko.observable(false);

        this.canEditOtherFields = window.ko.observable(false);

        this.contentEditor = null;

        this.summaryEditor = null;

        var validator = new window.dnn.social.Validator($, window.ko, settings);

        this.validate = validator.validate;

        this.customValidators = [
            {
                name: 'validateArticleType',
                validate: function () {
                    if (!that.primaryArticle())
                        return that.articleType() > 0;
                    return true;
                },
                errorMsg: that.localizer.getString('FieldIsRequired')
            },
            {
                name: 'validateArticleTitle',
                validate: function () {
                    if (!that.primaryArticle())
                        return that.title().length > 0;
                    return true;
                },
                errorMsg: that.localizer.getString('FieldIsRequired')
            },
            {
                name: 'validateArticleTag',
                validate: function () {
                    if (!that.primaryArticle())
                        return $('#wiki-edit-tags').val().length > 0;
                    return true;
                },
                errorMsg: that.localizer.getString('FieldIsRequired')
            }
        ];

        this.getLastSequence = function (continueWith) {
            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(that.localizer, status);
            };

            var success = function (revision) {
                if (settings.sequence != revision.sequence) {
                    $.dnnRevisionChangePrompt(that.localizer, continueWith);
                } else {
                    continueWith();
                }
            };

            var params = {
                articleId: settings.articleId,
                sequence: settings.sequence
            };

            var service = social.getService('Content');
            service.get('GetLastSequence', params, success, failure);
        };

        this.remove = function () {
            var localizer = social.getLocalizationController();

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
                articleId: settings.articleId
            };

            var service = social.getService('Content');

            service.post('DeletePage', params, success, failure, that.loading);
        };

        this.publish = function () {
            if (!that.validate($('.wiki-editor-form'), that.customValidators)) {
                return;
            }
            if (settings.articleId == -1) {
                that.continuePublish();
                return;
            }
            that.getLastSequence(function () { that.continuePublish(); });
        };

        this.continuePublish = function () {
            var failure = function (xhr, status) {
                var r = JSON.parse(xhr.responseText);
                $.dnnAlert({
                    title: r.Title || that.localizer.getString('SaveError'),
                    text: that.getErrorText(that.localizer.getString('UnableToPublish'), status)
                });
            };

            var success = function (model) {
                var create = settings.articleId < 0;
                settings.articleId = model.articleId;
                settings.articleTypeId = model.articleTypeId;
                $('.article-type', $(settings.dialogScope)).attr('disabled', 'disable');
                that.completionEvent(model, create);
            };

            var service = social.getService('Content');
            var method = that.canPublish() && that.approved() ? 'Publish' : 'SaveDraft';
            service.post(method, that.getPublishObject(), success, failure, that.working);
        };

        this.completionEvent = function (m, creation) {
            if (that.modal()) {
                that.cancel();
            }

            var articleInfo = dnn.social.komodel(m);

            var message = {
                event: creation ? 'ArticleCreated' : 'ArticleModified',
                articleInfo: articleInfo
            };

            dnn.social.ipc.post(settings, 'DNNCorp/Wiki', message);

            if (that.primaryArticle()) {
                window.location.reload();
            } else {
                window.location.href = m.detailUrl;
            }
        };

        this.getPublishObject = function () {
            var publish = {
                articleId: that.articleId(),
                articleTypeId: that.articleType(),
                title: that.title(),
                tableOfContents: that.toc(),
                groupId: that.groupId(),
                subscribeToActivity: that.subscribeToActivity()
            };

            publish.tags = that.tags();

            publish.content = $('#content').dnnRedactor('code.getCleanHtml');

            publish.summary = $('#summary').dnnRedactor('code.getCleanHtml');

            if (typeof publish.summary !== "string")
                publish.summary = that.summary();

            publish.primaryArticle = that.primaryArticle();
            return publish;
        };

        this.working = function (b) {
            var c = $(settings.moduleScope);
            if (b) {
                c.addClass('loading');
            } else {
                c.removeClass('loading');
            }
        };

        this.getErrorText = function (base, status) {
            if (typeof status === 'string' && status.length > 0) {
                base += ': ';
                base += status;
            }

            return base;
        };

        this.cancel = function () {
            if (that.modal()) {
                $(settings.moduleScope).dialog('close');
            } else {
                window.location = settings.cancelUrl;
            }
        };

        this.dialog = function (article) {
            var dialog;

            that.initModel(article);

            this.modal(true);

            var title = article ? article.title : settings.title;

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: title || 'Create an article',
                resizable: false,
                minWidth: 900,
                closeOnEscape: false,
                open: $.ui.dialog.prototype.options.open,
                close: $.ui.dialog.prototype.options.close,
            };

            var isMobile = this.isMobileView() || dnn.social.MobileView.onMobile;

            if (isMobile) {
                options = dnn.social.MobileView.dialogOptions({
                    title: title
                });
            }

            dialog = $(settings.moduleScope).dialog(options);
            that.bindControls();

            setTimeout(function(){
                window.dnn.social.unbindEventsThatConflictWithJQueryDialog(dialog);
            },0);
        };

        this.initModel = function (article) {
            article = $.extend(settings, article);
            if (article) {
                that.isMobileView(article.isMobileView);
                that.articleId(article.articleId);
                that.contentItemId(article.contentItemId),
                that.canModerate(article.canModerate);
                that.groupId(article.groupId);
                that.title(article.title);
                that.tags(article.tags);
                that.articleType(article.articleType);
                that.primaryArticle(article.primaryArticle);
                that.canPublish(article.canPublish);
                that.content(article.content);
                that.summary(article.summary);
                that.canEditOtherFields(that.canPublish() || that.articleId() < 1);
                that.approved(article.approved);
            }
        };

        this.bindControls = function () {

            var typeControl = $('.article-type', $(settings.dialogScope));

            if (that.articleType() >= 0) {
                typeControl.attr('disabled', 'disable');
            } else {
                typeControl.removeAttr('disabled');
            }

            $('.wiki-type-error').hide();

            if ($('#wiki-edit-tags_tag', $(settings.dialogScope)).length == 0) {
                $('#wiki-edit-tags', $(settings.dialogScope)).dnnTagsInput({
                    onAddTag:
                        function (t) {
                            that.tags.push(t);
                        },
                    onRemoveTag:
                        function (t) {
                            $.each(that.tags(), function (index, term) {
                                if (term === t || (typeof term.name == 'function' && term.name() === t)) {
                                    that.tags.splice(index, 1);
                                    return false;
                                }
                                return true;
                            });
                        },
                    width: '47%',
                    minInputWidth: '200px',
                    defaultText: that.localizer.getString('AddTag'),
                    interactive: that.canEditOtherFields()
                });
            }

            $('#wiki-edit-tags', $(settings.dialogScope)).dnnImportTags((that.tags()).join(','));

            if (!that.canPublish()) {
                $('#wiki-edit-tags_tagsinput span.tag a').remove();
            }

            if (that.contentEditor) {
                try {
                    $('#content').dnnRedactor('core.destroy');
                } catch (e) {

                }
            }

            if (that.summaryEditor) {
                try {
                    $('#summary').dnnRedactor('core.destroy');
                } catch (e) {
                }
            }

            var editorSettings = {
                toolbar: settings.editorToolbar,
                allowIframe: settings.editorAllowIframe,
                allowScript: settings.editorAllowScript,
                allowEmbed: settings.editorAllowEmbed
            };

            var moduleContentEditor = $('#content').addClass('validateErrorAfterParent imageIsNotEmptyContent');
            dnn.social.initRedactor(moduleContentEditor, null, 'rich', that.isMobileView(), that.postImageService.getRoot(), editorSettings,
                function (redactor) {
                    that.contentEditor = redactor;
                    $('#content').dnnRedactor('code.set', that.content());
                    dnn.social.initUserMentions(moduleContentEditor, settings.moduleId, settings.moduleName, false, redactor);
                });

            var moduleSummaryEditor = $('#summary');
            dnn.social.initRedactor(moduleSummaryEditor,
                {
                    shortcuts: [],
                    toolbar: false,
                    paragraphy: false,
                    convertDivs: false,
                    linebreaks: true,
                    tabFocus: false
                },
                null, this.isMobileView(), this.postImageService.getRoot(), null,
                function (redactor) {
                    that.summaryEditor = redactor;
                    $('#summary').dnnRedactor('code.set', that.summary());
                    dnn.social.initUserMentions(moduleSummaryEditor, settings.moduleId, settings.moduleName, false, redactor);
                });

            if (!that.isMobileView()) {
                $(settings.moduleScope).dnnPanels({ regionToToggleSelector: 'div' });
            } else {
                $('.wiki-editor-form').show();
            }
        };
    };
})(window.dnn);
