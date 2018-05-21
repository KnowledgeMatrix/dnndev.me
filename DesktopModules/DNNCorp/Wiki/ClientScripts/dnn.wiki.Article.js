// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function(dnn, $, ko) {
    'use strict';
    
    dnn.wiki.Article = function Article() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.social.komodel(this.dataModel);
        this.socialController = this.social.getSocialController(this.settings.contentItemId, this.model, this.settings.journalTypeId);
        this.init();
    };

    dnn.wiki.Article.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.wiki.Article.prototype.init = function () {
        var self = this;
        dnn.social.ipc.register(self.settings, function (source, msg) {
            switch (msg.event) {
                case 'LoadContent':
                    self.model.tags(msg.tags);
                    break;
            }
        });
        this.model.getLikeControlId = function () {
            return 'likes_{0}'.format(self.model.contentItemId());
        };
        this.model.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(self.model.contentItemId());
        };
        this.showCommentsTitle = ko.observable(false);
        this.moduleScope = this.settings.moduleScope;
        this.like = function (data, event) {
            return self.socialController ? self.socialController.like(data, event) : undefined;
        };
        this.unlike = function (data, event) {
            return self.socialController ? self.socialController.unlike(data, event) : undefined;
        };
        this.bookmark = function (data, event) {
            return self.socialController ? self.socialController.bookmark(data, event) : undefined;
        };
        this.unbookmark = function (data, event) {
            return self.socialController ? self.socialController.unbookmark(data, event) : undefined;
        };
        this.subscribe = function (data, event) {
            return self.socialController ? self.socialController.subscribe(data, event) : undefined;
        };
        this.unsubscribe = function (data, event) {
            return self.socialController ? self.socialController.unsubscribe(data, event) : undefined;
        };
        dnn.social.DetailView.prototype.init.apply(this);
    };

    dnn.wiki.Article.prototype.edit = function () {
        if(this.contentContext) this.contentContext.edit();
        return false;
    };
    
    dnn.wiki.Article.prototype.history = function () {
        var context = window.ko.contextFor($(this.settings.historyScope)[0]).$root;
        if (context) context.history();
        return false;
    };
    
    dnn.wiki.Article.prototype.likes = function () {
        return this.socialController ? this.socialController.likes() : 0;
    };
    
    dnn.wiki.Article.prototype.bindControls = function () {
        $(".wiki-tab-content").hide();
        this.contentContext = window.ko.contextFor($(this.settings.contentScope)[0]).$root;
    };
    
    dnn.wiki.Article.prototype.customisedSwitchedView = function () {
        var self = this;
        if (!self.isMobileView()) {
            $('a#deleteWiki').dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                callbackTrue: function () {
                    var failure = function (xhr, status) {
                        $.dnnAlert({
                            title: self.getString('DeleteErrorTitle'),
                            text: self.getString('DeleteError').format(status || self.getString('UnknownError'))
                        });
                    };
                    var success = function () {
                        window.location = self.settings.returnUrl;
                    };
                    var params = {
                        articleId: self.settings.articleId
                    };
                    var service = self.social.getService('Content');
                    service.post('DeletePage', params, success, failure);
                }
            });
        }
    };
    
    dnn.wiki.Article.prototype.notifyViewSwitched = function () {
        var self = this;
        var msg = {
            event: 'ViewSwitched',
            isMobileView: self.isMobileView()
        };
        dnn.social.ipc.post(self.settings, 'DNNCorp/Wiki', msg);
    };
    
})(window.dnn, window.jQuery, window.ko);