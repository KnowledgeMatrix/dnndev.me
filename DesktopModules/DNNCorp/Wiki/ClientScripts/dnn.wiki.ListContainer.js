// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function (dnn, $, ko) {

    dnn.wiki.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        dnn.social.ipc.register(this.settings, $.proxy(function (source, message) {
            switch (message.event) {
                case 'ArticleCreated':
                case 'ArticleModified':
                    if (typeof this.refresh === 'function') this.refresh();
                    break;
            }
        }, this));
        this.register(this, 'PrimaryView');
        this.register(new dnn.wiki.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }

        this.init();
    };

    try{
        dnn.wiki.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.wiki.ListView.prototype.init = function () {
        var self = this;
        this.sortOptions = [
            { value: 'lastactive', text: this.getString('SortByLastActive') },
            { value: 'createddate', text: this.getString('SortByCreated') },
            { value: 'title', text: this.getString('SortByTitle') },
            { value: 'views', text: this.getString('SortByViews') }
        ];

        this.create = function (primary, query) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (typeof primary === 'boolean' && primary) {
                var context = window.ko.contextFor($(self.settings.editorScope)[0]).$root;
                if (context) {
                    context.dialog({
                        isMobileView: self.isMobileView(),
                        articleId: -1,
                        sequence: 0,
                        contentItemId: -1,
                        canModerate: true,
                        groupId: self.settings.groupId,
                        title: '',
                        content: '',
                        summary: '',
                        tags: [],
                        articleType: -1,
                        primaryArticle: true,
                        canPublish: self.settings.canPublish,
                        cancleUrl: '',
                        detailUrl: '',
                        approved: self.settings.canPublish
                    });
                }

            } else {
                var root = window.ko.contextFor($(self.settings.editorScope)[0]).$root;
                if (root) {
                    var title = typeof query === 'string' ? query : '';
                    root.dialog({
                        isMobileView: self.isMobileView(),
                        articleId: -1,
                        sequence: 0,
                        contentItemId: -1,
                        canModerate: true,
                        groupId: self.settings.groupId,
                        content: '',
                        summary: '',
                        title: title,
                        tags: [],
                        articleType: -1,
                        primaryArticle: false,
                        canPublish: self.settings.canPublish,
                        publishPermission: self.settings.publishPermission,
                        cancleUrl: '',
                        detailUrl: '',
                        approved: self.settings.canPublish
                    });
                }
            }
            return false;
        };
        
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.wiki.ListView.prototype.addDialog = function(query) {
        this.create(false, query);
    };
    
    dnn.wiki.ListView.prototype.addDialogMobileView = function (query) {
        this.create(false, query);
    };

    dnn.wiki.ListView.prototype.validateCategory = function (c) {
        if (c === 'myarticles')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

    dnn.wiki.ListView.prototype.switchingView = function() {
        dnn.social.ListView.prototype.switchingView.apply(this);
        $(this.settings.primaryArticleScope).appendTo($('.wiki-primary-article-common', this.settings.moduleScope));
    };

    dnn.wiki.ListView.prototype.switchedView = function() {
        dnn.social.ListView.prototype.switchedView.apply(this);
        var primaryArticleContainer = this.isMobileView() ? $('.wiki-primary-article-mobile', this.settings.moduleScope) : $('.wiki-primary-article', this.settings.moduleScope);
        $(this.settings.primaryArticleScope).appendTo(primaryArticleContainer);
    };

    dnn.wiki.ListView.prototype.binded = function() {
        var primaryArticleContainer = this.isMobileView() ? $('.wiki-primary-article-mobile', this.settings.moduleScope) : $('.wiki-primary-article', this.settings.moduleScope);
        $(this.settings.primaryArticleScope).appendTo(primaryArticleContainer);
        dnn.social.ListView.prototype.binded.apply(this);
    };

})(window.dnn, window.jQuery, window.ko);
