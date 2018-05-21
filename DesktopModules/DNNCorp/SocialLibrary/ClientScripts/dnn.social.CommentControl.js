// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.CommentControl = function CommentControl ($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);
        var componentFactory = this.social.getComponentFactory();
        componentFactory.register(this);
        componentFactory.register(this.social.getPagingControl('CommentControl'));
        componentFactory.register(this.social.getService('Social'));
        componentFactory.register(this.social.getFocusController([]));

        this.poster = new dnn.social.CommentPostController($, ko, settings, this.social, settings.contentItemId);
        componentFactory.register(this.poster);

        this.totalResults = ko.observable(0);

        this.totalComments = ko.computed(function () {
            var localizer = that.social.getLocalizationController();
            return localizer.getString("NumberOfComments").format(that.totalResults());
        });

        this.comments = ko.observableArray([]);

        this.commentsMobileView = ko.observableArray([]);

        this.currentLoadedPageIndex = ko.observable(settings.pageIndex - 1);

        this.frozen = ko.observable(true);

        this.rolledup = ko.observable(false);

        this.authoring = ko.observable(false);

        this.inlineLoginAction = ko.observable('registration');

        this.inlineLoginUserName = ko.observable('');
        
        this.inlineLoginPassword = ko.observable('');
        
        this.inlineRegistrationUserName = ko.observable('');

        this.inlineRegistrationEmail = ko.observable('');

        this.mostRecentFirst = ko.observable(false);
        
        this.sortComments = function (mostRecentFirst) {
            if (that.mostRecentFirst() === mostRecentFirst) {
                return;
            }

            that.mostRecentFirst(mostRecentFirst);
            var pager = componentFactory.resolve('PagingControl');
            pager.page(0);
            that.load();
        }

        this.changeInlineLoginAction = function(action, event) {
            that.inlineLoginAction(action);
            $('a.dnnMobile-comment-option').removeClass('selected');
            $(event.target).addClass('selected');
        };

        this.showPager = ko.computed(function() {
            return componentFactory.resolve('PagingControl').totalPages() > 1 && !that.poster.authoring();
        });

        this.showPagerMobileView = ko.computed(function () {
            var pagingControl = componentFactory.resolve('PagingControl');
            return pagingControl.totalPages() - 1 > that.currentLoadedPageIndex() && !that.poster.authoring();
        });

        this.loading = function (b) {
            var control = $(settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.load = function (completionHandler, pageSize) {
            if (that.frozen()) return;

            var pager = componentFactory.resolve('PagingControl');
            var pagerIndex = pager.page();
            pageSize = pageSize || settings.pageSize;

            if (settings.inline) {
                pagerIndex = -1;
            }
            
            var failure = function (xhr, status) {
                var localizer = that.social.getLocalizationController();

                $.dnnAlert({
                    title: localizer.getString('GetCommentsErrorTitle'),
                    text: localizer.getString('GetCommentsError').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                var comments = [], originalComments = that.commentsMobileView();

                that.totalResults(m.TotalRecords);

                $.each(m.Comments,
                    function (index, c) {
                        var com = new dnn.social.Comment($, ko, settings, that.social, settings.contentItemId, c);
                        comments.push(com);
                    });

                that.comments(comments);

                for (var i = 0; i < comments.length; i++) {
                    var comm = comments[i];
                    var exists = false;
                    $.each(originalComments,
                        function(index, c) {
                            if (c.commentId() === comm.commentId()) {
                                exists = true;
                                return false;
                            }
                            return true;
                        });

                    if (!exists) {
                        originalComments.push(comm);
                    }
                }

                if (that.currentLoadedPageIndex() < pagerIndex) {
                    that.currentLoadedPageIndex(pagerIndex);
                }

                that.commentsMobileView(originalComments);

                if (that.rolledup()) {
                    that.rolledup(that.totalResults() > 3);
                }

                that.toggleCommentsControlTitle(that.comments().length > 0);

                that.bindHoverCard();

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(completionHandler);
                }

                that.initEditControls();
                dnn.social.initLikeControl().bindControls($(settings.moduleScope));
            };

            var params = {
                journalTypeId: settings.journalTypeId || -1,
                contentItemId: settings.contentItemId,
                groupId: settings.groupId || -1,
                objectKey: settings.objectKey || null,
                pageIndex: pagerIndex,
                pageSize: pageSize,
                canModerate: settings.canModerate,
                mostRecentFirst: that.mostRecentFirst()
            };

            var service = componentFactory.resolve('ServiceCaller');
            service.get('GetComments', params, success, failure, that.loading);
        };

        this.toggleCommentsControlTitle = function(show) {
            var parentControl = $('#' + settings.parentControlScopeId);
            if (parentControl.length) {
                var parentControlContext = ko.contextFor(parentControl[0]);
                if (parentControlContext && parentControlContext.$root && parentControlContext.$root.showCommentsTitle) {
                    parentControlContext.$root.showCommentsTitle(show);
                }
            }
        };

        this.bindHoverCard = function() {
            if (typeof dnn.social.bindCommentContext === 'function') {
                dnn.social.bindCommentContext(settings.moduleScope, that);
            }
        };

        this.pagingControl = ko.computed(function() {
            return componentFactory.resolve('PagingControl').markup();
        });

        this.prev = function () {
            if (that.prevClass() !== 'disabled') {
                componentFactory.resolve('PagingControl').previous();
            }
        };

        this.next = function () {
            if (that.nextClass() !== 'disabled') {
                componentFactory.resolve('PagingControl').next();
            }
        };

        this.nextClass = function () {
            var pager = componentFactory.resolve('PagingControl');
            if (pager.page() + 1 >= pager.totalPages()) {
                return 'disabled';
            }
            return new String();
        };

        this.prevClass = function () {
            if (componentFactory.resolve('PagingControl').page() == 0) {
                return 'disabled';
            }
            return new String();
        };

        this.formattedResults = ko.computed(
            function () {
                var localizer = that.social.getLocalizationController();
                if (localizer != null) {
                    var key = 'CommentCount';

                    if (that.totalResults() == 1) {
                        key = 'SingleCommentCount';
                    }

                    return localizer.getString(key).format(that.totalResults());
                }
                return new String();
            });

        this.reply = function() {
            that.poster.comment(new String());
            that.poster.reply([]);
            var inlineMessage = $('.inline-comment-message', settings.moduleScope);
            if (inlineMessage.length) {
                $(window).scrollTop(inlineMessage.position().top);
                inlineMessage.trigger('focus');
            }
        };

        this.commentExists = function (cid) {
            for (var i = 0; i < that.comments().length; ++i) {
                if (that.comments()[i].commentId() == cid) {
                    return true;
                }
            }
            return false;
        };

        this.cancelUpdate = function () {
            if (dnn.social.editDialog) {
                dnn.social.editDialog.dialog("close");
                dnn.social.editDialog = null;
                dnn.social.editCommentModel = null;
            }
        };

        this.saveUpdate = function () {
            if (dnn.social.editCommentModel && dnn.social.editDialog) {
                var $message = $('.message', dnn.social.editDialog);
                var comment = $message.is('textarea') ? $message.val() : $message.html();
                if (comment) {
                    dnn.social.editCommentModel.saveComment(comment);
                }
            }
        };

        this.sortAllComments = function (mostRecentFirst) {
            if (that.mostRecentFirst() === mostRecentFirst) {
                return;
            }

            that.mostRecentFirst(mostRecentFirst);
            if (that.rolledup()) {
                that.more();
            } else {                
                that.sort();
            }
        };

        this.more = function () {
            var failure = function () {
                $(settings.moduleScope).animate({ 'background-color': 'rgba(ff, 00, 00, 0.3)' },
                    function () {
                        $(settings.moduleScope).css({ 'background-color': 'transparent' });
                    });
            };

            var success = function (m) {
                $.each(m.Comments,
                    function (idx, c) {
                        if (that.commentExists(c.CommentId) == false) {
                            that.comments.push(new dnn.social.Comment($, ko, settings, that.social, settings.contentItemId, c));
                        }
                    });

                that.totalResults(m.TotalRecords);

                that.sort();

                if (that.rolledup()) {
                    that.rolledup(false);
                }

                if (!that.isMobileView()) {
                    $('html body').animate({ scrollTop: $(settings.moduleScope).offset().top + $(settings.moduleScope).height() / 2 });
                }

                that.bindHoverCard();

                that.initEditControls();
            };

            var index = parseInt((that.comments().length / settings.pageSize).toString(), 10);

            if (that.comments().length / settings.pageSize > index) {
                ++index;
            }

            var pageSize = settings.pageSize;
            var pageIndex = index;
            if (that.rolledup()) {
                pageIndex = 0;
                pageSize = that.totalResults();
            }

            var params = {
                journalTypeId: settings.journalTypeId || -1,
                contentItemId: settings.contentItemId,
                groupId: settings.groupId || -1,
                objectKey: settings.objectKey || null,
                pageIndex: pageIndex,
                pageSize: pageSize,
                canModerate: settings.canModerate,
                mostRecentFirst: that.mostRecentFirst()
            };

            var service = componentFactory.resolve('ServiceCaller');
            service.get('GetComments', params, success, failure, that.loading);
        };

        this.showMobileCommentButton = ko.computed(function() {
            return !that.authoring() && (!settings.hideMobileCommentBtn || that.commentsMobileView().length > 0);
        });

        this.initEditControls = function() {
            $('.comment-actions-menu', settings.moduleScope).click(function (e) {
                $(e.target).closest('ul.comment-actions-dropdown').hide();
            }).hoverIntent({
                over: function() {
                    $('ul.comment-actions-dropdown', $(this)).show();
                },
                out: function() {
                    $('ul.comment-actions-dropdown', $(this)).hide();
                },
                timeout: 300,
                interval: 150
            });

            $('.approve-comment-actions').qaTooltip();
        };

        this.sortNewest = function(a, b) {
            return - b.secondsAgo() + a.secondsAgo();
        }

        this.sortOldest = function (a, b) {
            return b.secondsAgo() - a.secondsAgo();
        }

        this.sort = function () {
            if (that.mostRecentFirst()) {
                that.comments.sort(that.sortNewest);
                that.commentsMobileView.sort(that.sortNewest);
            } else {
                that.comments.sort(that.sortOldest);
                that.commentsMobileView.sort(that.sortOldest);
            }            
        };

        this.moreAvailable = ko.computed(function () {
            return that.totalResults() > that.comments().length;
        });

        this.moreText = ko.computed(function () {
            if (that.moreAvailable()) {
                var n = Math.min(that.totalResults() - that.comments().length, settings.pageSize);
                return '{0} more comments...'.format(n);
            }
            return new String();
        });

        this.bindControls = function () {
            var hideCard = function() {
                if (typeof dnn.social.hideCommentContext === 'function') {
                    dnn.social.hideCommentContext();
                }
            };

            $(window.document).bind('focused', hideCard);

            componentFactory.resolve('PagingControl').page.subscribe(
                function () {
                    if (typeof dnn.social.hideCommentContext === 'function') {
                        dnn.social.hideCommentContext();
                    }
                    that.load();
                });
        };

        $(settings.moduleScope).removeClass('initial-loading');
        this.isMobileView = ko.observable(dnn.social.MobileView.isMobileView());
        this.binded = function () {
            this.bindControls();
            if (typeof settings.autoreload !== 'undefined' && !settings.autoreload) {
                this.rolledup(true);
            }
            if (this.isMobileView()) {
                componentFactory.resolve('PagingControl').page(0);
            }
            this.frozen(false);

            var hash = window.location.hash;
            if (hash.indexOf('#commentPage=') == 0) {
                var pageIndex = hash.replace('#commentPage=', '');
                var pager = componentFactory.resolve('PagingControl');
                pager.page(parseInt(pageIndex, 10));
                this.load(function () {
                    var top = $('.dnnActions.answer-post-actions').position().top;
                    window.scrollTo(0, top);
                });
                return;
            }
            
            this.totalResults.subscribe(function(v) {
                dnn.social.ipc.post({}, settings.moduleRoot, { event: 'RefreshCommentCount', count: v });
            });
            
            this.load();
        };
    };
})(window.dnn);