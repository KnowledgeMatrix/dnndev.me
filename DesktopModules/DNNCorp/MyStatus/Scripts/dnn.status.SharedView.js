// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.SharedView = function SharedView($, ko, settings, social) {
        var that = this;
        this.bindControls = function () {
            $('.status-binding-loading')
                .removeClass('loading')
                .removeClass('status-binding-loading');

            var completionHandler = function () {
                dnn.social.loaded(settings.moduleScope.id);
            };
            
            var primaryView = social.getComponentFactory().resolve('PrimaryView');
            var expandView = primaryView != null && dnn.social.ComponentFactory.getType(primaryView) === 'ExtendedView';
            
            if (settings.anonymous && !expandView) {
                completionHandler();
            }
            else {
                var profile = social.getComponentFactory().resolve('Profile');
                if (profile != null) {
                    profile.load(completionHandler, completionHandler);
                }
            }

           dnn.social.ipc.register(settings,
                function (source, msg) {
                    dnn.status.MessageProcessor(social.getComponentFactory().resolve('PrimaryView'), social, source, msg);
                });
        };

        dnn.social.EventQueue.push(
            function () {
                that.bindControls();
            });
    };
})(window.dnn);