// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};

(function(dnn) {
    'use strict';

    dnn.share.View = function View($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.services = ko.observableArray([]);

        this.controls = ko.observableArray();

        this.facebook = ko.computed(
            function () {
                var found = false;

                $.each(that.services(),
                    function (unused, service) {
                        if (service.settings.service() === 'Facebook') {
                            found = true;
                            return false;
                        }

                        return true;
                    });

                return found;
            });

        this.transformUrl = function (completionHandler, preferredTransformer) {
            var success = function (response) {
                completionHandler(response);
            };

            var failure = function (xhr, status) {
                completionHandler(window.location.href);
            };

            var params = {
                target: window.location.href,
                preferredTransformer: preferredTransformer || new String()
            };

            var service = that.social.getService('Share');
            service.getsync('TransformUrl', params, success, failure);
        };

        this.bindControls = function () {
            $.each(settings.services,
                function (unused, model) {
                    var service = {
                        service: model.Service,
                        settings: dnn.social.komodel(model.Settings)
                    };

                    that.services.push(service);
                });

            var delayedLoad = false;

            $.each(that.services(),
                function (unused, service) {
                    if (service.settings.enabled() == false) {
                        return;
                    }
                    
                    var obj = '(new {0}($, ko, settings, service.settings, that.social, that))'.format(service.settings.clientType());
                    
                    that.controls.push(eval(obj));
                    
                    if (typeof service.settings.delayedLoad === 'function' && service.settings.delayedLoad() == true) {
                        delayedLoad = true;
                    }
                });
        };

        this.binded = function () {
            that.bindControls();
        };
    };
})(window.dnn);