// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function(dnn) {
    'use strict';

    dnn.ideas.Subscribe = function Subscribe($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);
        this.componentFactory = this.social.getComponentFactory();
        this.componentFactory.register(this.social.getService('List'));
        this.service = this.social.getService('List');

        this.localizer = function() {
            return that.social.getLocalizationController();
        };

        this.subscribed = ko.observable(settings.subscribed);

        this.subscribe = function (data, event) {
            var loadingContainer = $('.loading-container', settings.moduleScope);

            var success = function(response) {
                loadingContainer.removeClass('loading');
                that.subscribed(true);
            };

            var failure = function(xhr, status) {
                loadingContainer.removeClass('loading');
            };

            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            ;

            loadingContainer.addClass('loading');

            that.service.post('Subscribe',
                { groupId: settings.groupId, moduleId: settings.moduleId },
                success, failure);
        };

        this.unsubscribe = function (data, event) {
            var loadingContainer = $('.loading-container', settings.moduleScope);

            var success = function(response) {
                loadingContainer.removeClass('loading');
                that.subscribed(false);
            };

            var failure = function(xhr, status) {
                loadingContainer.removeClass('loading');
            };

            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            ;

            loadingContainer.addClass('loading');

            that.service.post('Unsubscribe',
                { groupId: settings.groupId, moduleId: settings.moduleId },
                success, failure);
        };

        this.getString = function(key) {
            var localizer = that.localizer();
            if (localizer) {
                return localizer.getString(key);
            }

            return key;
        };

    };
})(window.dnn);