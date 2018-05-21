// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $, ko) {
    'use strict';

    dnn.social.Module = function SocialModule (settings) {
        var that = this;

        this.settings = settings;

        this.componentFactory = new dnn.social.ComponentFactory(this.settings.moduleId);
        
        this.getComponentFactory = function () {
            return that.componentFactory;
        };

        this.getService = function (controller) {
            return new dnn.social.ServiceCaller($, that.settings, controller);
        };

        this.getHistory = function () {
            if (!that.componentFactory.hasComponent('HistoryController')) {
                that.componentFactory.register(new dnn.social.History($), 'HistoryController');
            }
            return that.componentFactory.resolve('HistoryController');
        };

        this.getSocialController = function (contentItemId, model, objectKey) {
            return new dnn.social.SocialController($, ko, that.settings, that, model, contentItemId, objectKey);
        };

        this.getPagingControl = function (controllerName) {
            return new dnn.social.PagingControl($, ko, that.settings, that, controllerName);
        };

        this.getCommentControl = function (control, contentItemId) {
            var s = $.extend({}, that.settings);
            s.moduleScope = $(control)[0];
            s.contentItemId = contentItemId;

            return new dnn.social.CommentControl($, ko, s);
        };

        this.getLocalizationController = function () {
			var localizationController = dnn.social.LocalizationControllerCache[that.settings.moduleRoot];
			if(!localizationController){
				localizationController = new dnn.social.LocalizationController($, that.settings, that);
			}
			if (!that.componentFactory.hasComponent('LocalizationController')) {
			    that.componentFactory.register(localizationController, 'LocalizationController');
			}
			return localizationController;
        };

        this.getFocusController = function (children) {
            return new dnn.social.FocusController($, ko, settings, that.social, window.document, children);
        };
    };
})(window.dnn, window.jQuery, window.ko);