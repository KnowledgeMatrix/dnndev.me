// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function (dnn) {
    'use strict';

    dnn.challenges.DetailController = function DetailController($, ko, settings, componentFactory) {
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