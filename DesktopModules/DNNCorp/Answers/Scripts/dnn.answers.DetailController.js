// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.answers === 'undefined') dnn.answers = {};

(function (dnn) {
    'use strict';
    dnn.answers.DetailController = function DetailController($, ko, settings, social, model) {
        var that = this;

        $.extend(this, settings);
        
        var componentFactory = social.getComponentFactory();

        this.sort = ko.observable('votes');

        this.order = ko.observable('ascending');

        this.service = social.getService('Detail');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);

        this.resultsMobile = ko.observableArray([]);

        this.question = model;

        this.pager = function () {
            return componentFactory.resolve('PagingControl');
        };

        this.page = function () {
            var paging = that.pager();
            if (paging != null) {
                return paging.page();
            }

            return 0;
        };

        this.answerPosted = function (m) {
            var post = new dnn.answers.Post($, ko, settings, social, m);
            if (post.answerId() == post.postId()) {
                that.results.unshift(post);
                that.resultsMobile.unshift(post);
            }
            else {
                that.results.push(post);
                that.resultsMobile.push(post);
                post.bindControls();
            }
            
            that.totalResults(that.totalResults() + 1);

            dnn.social.EventQueue.push(
                function () {
                    dnn.social.ipc.post({}, settings.moduleRoot, { event: 'PostAnswer' });
                });
        };

        this.post = function (content, successHandler) {
            var localizer = social.getLocalizationController();

            if (String.isEmpty(content)) {
                $.dnnAlert({
                    title: localizer.getString('NoAnswerTitle'),
                    text: localizer.getString('NoAnswer')
                });

                return;
            }

            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('AnswerError'),
                    text: localizer.getString('AnswerErrorText').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.answerPosted(m);
                if (typeof successHandler === 'function') {
                    successHandler();
                }
            };

            var service = social.getService('Detail');

            var params = {
                parentId: settings.postId,
                contentTitle: "",
                content: content
            };

            service.post('PostAnswer', params, success, failure, that.posting);
        };

        this.posting = function (b) {
            var c = $('.answer-add-panel', settings.moduleScope);
            if (b) {
                c.addClass('loading');
            }
            else {
                c.removeClass('loading');
            }
        };
        
        this.loading = function (b) {
            var control = $('.answer-answers', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.load = function (appendToOriginalSets) {
            var localizer = social.getLocalizationController();

            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('LoadAnswersFailureTitle'),
                    text: localizer.getString('LoadAnswersFailureText').format(status || localizer.getString('UnknownError'))
                });
                
                that.load = function () { };
            };

            var success = function (m) {
                var answers = [];
                $.each(m.Posts,
                    function (index, answer) {
                        var post = new dnn.answers.Post($, ko, settings, social, answer);
                        if (post.answerId() == post.postId())
                            answers.unshift(post);
                        else
                            answers.push(post);
                    });

                that.totalResults(m.TotalRecords || 0);
                
                if (appendToOriginalSets) {
                    for (var i = 0; i < answers.length; i++) {
                        var exists = false;
                        $.each(that.resultsMobile(),
                            function (index, p) {
                                if (p.postId() === answers[i].postId()) {
                                    exists = true;
                                    return false;
                                }
                                return true;
                            });

                        if (!exists)
                            that.resultsMobile.push(answers[i]);
                    }
                } else {
                    that.resultsMobile([]);
                    $.each(answers, function (index, post) {
                        that.resultsMobile.push(post);
                    });
                }

                that.results([]);
                $.each(answers, function (index, post) {
                    that.results.push(post);
                });

                $.each(answers, function(index, post) {
                    post.bindControls();
                });
            };

            var pager = that.pager();
            if (pager == null) {
                return;
            }

            var params = {
                postId: model.postId(),
                pageIndex: pager.page(),
                pageSize: pager.pageSize,
                sortColumn: 'score',
                sortAscending: false
            };

            that.service.get('GetAnswers', params, success, failure, that.loading);
        };

        this.loadStart = function () {
            var pagingController = that.pager();
            if (pagingController != null) {
                if (pagingController.page() != 0) {
                    pagingController.page(0);
                } else {
                    that.load();
                }
            }
        };
       
        $.each([this.sort, this.order],
            function (index, observable) {
                observable.subscribe(that.loadStart);
            });

        var p = that.pager();
        if (p != null) {
            p.page.subscribe(that.load);
        }
    };
})(window.dnn);