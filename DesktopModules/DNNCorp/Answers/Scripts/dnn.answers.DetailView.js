// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.answers === 'undefined') dnn.answers = {};


(function (dnn, $, ko) {
    'use strict';
    dnn.answers.DetailView = function DetailView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.answers.Post($, ko, this.settings, this.social, this.dataModel);
        this.register(this, 'PrimaryView');
        this.register(this.social.getService('Detail'));
        this.register(this.social.getPagingControl('DetailController'));
        this.register(new dnn.answers.DetailController($, ko, this.settings, this.social, this.model));
        this.init();
    };

    dnn.answers.DetailView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.answers.DetailView.prototype.init = function () {
        var self = this;
        this.inlineCommentControl = true;
        this.service = this.social.getService('Detail');
        
        this.postImageService = this.social.getService('Social');
        this.replyContent = ko.observable();
        this.searcher = function () {
            return self.componentFactory.resolve('DetailController');
        };
        
        this.pagingControl = ko.computed(
          function () {
              var pager = self.pager();
              return pager ? pager.markup() : new String();
          });

        this.answerAuthoring = ko.observable(false);

        this.answerAccepted = ko.computed(function () {
            var answerId = self.model.answerId();
            return answerId !== undefined && answerId > 0;
        });

        this.totalResults = ko.computed(
            function () {
                var search = self.searcher();
                var localString = search && search.totalResults() == 1 ? 'SingleAnswerResultCount' : 'AnswerResultCount';
                return self.getString(localString).format(search.totalResults());
            });

        this.nextClass = ko.computed(
            function () {
                var pager = self.pager();
                return pager && pager.page() + 1 >= pager.totalPages() ? 'disabled' : new String();
            });

        this.prevClass = ko.computed(
            function () {
                var pager = self.pager();
                return pager && pager.page() == 0 ? 'disabled' : new String();
            });
        
        this.showPagerMobileView = ko.computed(
             function () {
                 return self.pager().totalPages() - 1 > self.pager().page() && !self.answerAuthoring();
             });
        
        this.supporterControlPageIndex = 0;
        this.supportersControl = {
            results: ko.observableArray([]),
            postId: ko.observable(0),
            showMore: ko.observable(false),
            getMore: function () {
                self.supporterControlPageIndex++;
                self.loadSupporters(self.supporterControlPageIndex);
            }
        };
        this.supportersControlInitialized = false;
        dnn.social.DetailView.prototype.init.apply(this);
    };
    
    dnn.answers.DetailView.prototype.initSuportersControl = function () {
        this.totalSupporters = 0;
        this.averageVotesPerUser = '';
        this.supportersControl.results([]);
    };
    
    dnn.answers.DetailView.prototype.viewSupporters = function (postId, isAnswer) {
        if ($('#answer-voters-dialog').length < 1) return;
        var self = this;
        var callback = function () {
            if (self.supportersControl.results().length == 0) return;
            var popup = $('#answer-voters-dialog');
            popup.dialog({
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: isAnswer ? 'Votes on this answer' : 'Votes on this question',
                minWidth: 350,
                resizable: false,
                draggable: false
            });
        };

        if (self.supportersControl.results().length > 0 && self.supportersControl.postId() == postId)
            callback();
        else {
            self.supportersControl.postId(postId);
            self.supporterControlPageIndex = 0;
            self.loadSupporters(0, callback);
        }
    };

    dnn.answers.DetailView.prototype.moveContent = function () {
        dnn.social.contentExchange({
            methodName: 'Move',
            actionTitle: this.getString('Move'),
            summary: this.model.contentTitle()
        });
    };

    dnn.answers.DetailView.prototype.moveContentToComment = function () {
        dnn.social.contentExchange({
            methodName: 'MoveToComment',
            actionTitle: this.getString('Move'),
            actionTitle2: this.getString('ToComment'),
            summary: this.model.contentTitle()
        });
    };

    dnn.answers.DetailView.prototype.copyContent = function () {
        dnn.social.contentExchange({
            methodName: 'Copy',
            actionTitle: this.getString('Copy'),
            summary: this.model.contentTitle()
        });
    };
    
    dnn.answers.DetailView.prototype.loadSupporters = function (pageIndex, callback) {
        var self = this;
        var failure = function () {
        };
        var success = function (m) {
            var supporters = pageIndex == 0 ? [] : self.supportersControl.results();
            for (var i = 0; i < m.Results.length; i++) {
                var supporter = m.Results[i];
                supporter.votes = supporter.votes > 0 ? '+' + supporter.votes : supporter.votes;
                supporters.push(supporter);
            }
            self.supportersControl.results(supporters);
            self.totalSupporters = m.Total;
            self.averageVotesPerUser = m.Average;
            self.supportersControl.showMore(Math.ceil(self.totalSupporters / 10) - 1 > self.supporterControlPageIndex);
            if (typeof callback === 'function') callback();
        };

        var params = {
            postId: self.supportersControl.postId(),
            pageIndex: pageIndex
        };
        self.service.get('GetVotesDetail', params, success, failure);
    };
    
    dnn.answers.DetailView.prototype.toggleLike = function (data, event) {
        this.model.toggleLike(data, event);
    };
    
    dnn.answers.DetailView.prototype.edit = function () {
        return this.model.edit();
    };

    dnn.answers.DetailView.prototype.deletePost = function () {
        return this.model.deletePost();
    };

    dnn.answers.DetailView.prototype.cancelReply = function () {
        var self = this;
        var control = $('.answer-add-panel', self.settings.moduleScope);
        var addAnswerBtn = $('.answer-comment-button', self.settings.moduleScope);
        if (control.is(':visible')) {
            var editor = self.isMobileView() ? $('.dnnMobile-redactor-answer-area') : $('.redactor-answer-area');
            editor.dnnRedactor('code.set', '');
            control.slideUp({
                complete: function () {
                    addAnswerBtn.show();
                    self.answerAuthoring(false);
                }
            });
        }
    };

    dnn.answers.DetailView.prototype.submitReply = function () {
        var self = this;
        var editor = self.isMobileView() ? $('.dnnMobile-redactor-answer-area') : $('.redactor-answer-area');
        var html = editor.dnnRedactor('code.get');
        var controller = self.componentFactory.resolve('DetailController');
        controller.post(html, function () {
            if (typeof dnn.social.refreshUser === 'function') dnn.social.refreshUser();
            self.cancelReply();
        });
    };

    dnn.answers.DetailView.prototype.prev = function () {
        var pager = this.pager();
        pager.previous();
    };

    dnn.answers.DetailView.prototype.next = function () {
        var pager = this.pager();
        pager.next();
    };
    
    dnn.answers.DetailView.prototype.loadMore = function () {
        var pager = this.pager();
        if (pager) {
            var p = pager.page();
            pager.page(p + 1);
            this.searcher().load(true);
        }
    };
    
    dnn.answers.DetailView.prototype.bindControls = function () {
        var self = this;
        var editorSettings = {
            toolbar: this.settings.editorToolbar,
            allowIframe: this.settings.editorAllowIframe,
            allowScript: this.settings.editorAllowScript,
            allowEmbed: this.settings.editorAllowEmbed
        };

        var $editor = this.isMobileView() ? $('.dnnMobile-redactor-answer-area') : $('.redactor-answer-area');
        if (this.settings.initializeRedactor) {
            dnn.social.initRedactor($editor, null, this.settings.editorMode, this.isMobileView(), this.postImageService.getRoot(), editorSettings, function (redactor) {
                dnn.social.initUserMentions($editor, self.settings.moduleId, self.settings.moduleName, false, redactor);
            });
        }
    };
    
    dnn.answers.DetailView.prototype.switchedView = function () {
        this.bindControls();
        this.model.bindControls();
        var posts = this.isMobileView() ? this.searcher().resultsMobile() : this.searcher().results();
        $.each(posts, function (index, post) { post.bindControls(); });
        dnn.social.DetailView.prototype.switchedView.apply(this);
    };

    dnn.answers.DetailView.prototype.binded = function() {
        this.searcher().loadStart();
        this.switchedView();
    };
    
    dnn.answers.DetailView.prototype.reply = function () {
        var self = this;
        if (dnn.social.authorizationRequired(self.settings)) return;
        var control = $('.answer-add-panel', self.settings.moduleScope);
        if (control.is(':visible')) {
            control.slideUp({
                complete: function () { self.answerAuthoring(false); }
            });
        }
        else {
            self.replyContent(undefined);
            self.answerAuthoring(true);
            control.slideDown(
                function () {
                    $('html body').animate({ scrollTop: control.offset().top });
                    var editor = self.isMobileView() ? $('.dnnMobile-redactor-answer-area') : $('.redactor-answer-area');
                    editor.dnnRedactor('focus.setStart');
                });
        }
    };
    
    dnn.answers.DetailView.prototype.report = function () {
        if (dnn.social.authorizationRequired(this.settings)) return;
        dnn.social.reportContent(this.model.postId());
    };

})(window.dnn, window.jQuery, window.ko);