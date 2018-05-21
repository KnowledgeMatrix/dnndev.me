// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function(dnn) {
    'use strict';

    dnn.wiki.ArticleContent = function ArticleContent(settings) {
        var that = this;
        var social = new dnn.social.Module(settings);
        this.localizer = social.getLocalizationController();

        this.edit = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }

            if (settings.articleId == -1) {
                that.continueEdit();
                return;
            }

            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(that.localizer, status);
            };

            var success = function (revision) {
                settings.sequence = revision.sequence;
                settings.approved = revision.approved;
                settings.content = revision.latestContent;
                that.continueEdit();
            };

            var params = {
                articleId: settings.articleId,
                sequence: settings.sequence
            };

            var service = social.getService('Content');
            service.get('GetLastSequence', params, success, failure);
        };

        this.continueEdit = function () {
            if (settings.editorScope && $(settings.editorScope).length) {
                var context = window.ko.contextFor($(settings.editorScope)[0]).$root;
                if (context) {
                    context.dialog({
                        articleId: settings.articleId,
                        sequence: settings.sequence,
                        contentItemId: settings.contentItemId,
                        canModerate: settings.canModerate,
                        groupId: settings.groupId,
                        content: settings.content,
                        summary: settings.summary,
                        title: settings.title,
                        tags: settings.tags,
                        articleType: settings.articleType,
                        articleTypeId: settings.articleTypeId,
                        primaryArticle: settings.primaryArticle,
                        canPublish: settings.canPublish,
                        cancleUr: settings.cancelUrl,
                        detailUrl: settings.detailUrl,
                        approved: settings.approved
                    });
                }
            } 

            return false;
        };

        this.bindControls = function () {
            var loader = $('.wiki-binding-loader', settings.moduleScope);

            loader
                .removeClass('wiki-binding-loader')
                .removeClass('loading')
                .fadeIn();

            $('.wiki-nonexistent-article').click(
                function () {
                    var subject = $(this).attr('subject');

                    if (typeof subject === 'string' && subject.length > 0) {
                        that.create(subject);
                    }

                    return false;
                });

            dnn.social.ipc.register(settings, function(source, msg) {
                switch (msg.event) {
                    case 'LoadContent':
                        $('.wiki-content', settings.moduleScope).html(msg.content);
                        break;
                }
            });
        };

        this.binded = function() {
            this.bindControls();
        };
        
    };
})(window.dnn);