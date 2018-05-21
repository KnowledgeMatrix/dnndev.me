// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.DetailController = function DetailController($, ko, settings, componentFactory) {
        var that = this;

        $.extend(this, settings);
        
        this.likes = function () {
            var controller = componentFactory.resolve('SocialController');
            if (controller != null) {
                return controller.likes();
            }

            return 0;
        };

        this.like = function (data, event) {
            var controller = componentFactory.resolve('SocialController');
            if (controller != null) {
                return controller.like();
            }
        };

        this.unlike = function (data, event) {
            var controller = componentFactory.resolve('SocialController');
            if (controller != null) {
                return controller.unlike();
            }
        };

    };
})(window.dnn);
