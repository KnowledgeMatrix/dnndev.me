// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn) {
    'use strict';

    dnn.ideas.DetailController = function DetailController ($, ko, settings, componentFactory) {
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

            return false;
        };

        this.unlike = function (data, event) {
            var controller = componentFactory.resolve('SocialController');
            if (controller != null) {
                return controller.unlike();
            }

            return false;
        };

    };
})(window.dnn);
