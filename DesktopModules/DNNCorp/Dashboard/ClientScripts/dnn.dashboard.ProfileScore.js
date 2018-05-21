// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileScore = function ProfileScore(settings) {

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;

        this.pointsToday = window.ko.observable(settings.pointsToday);

        this.pointsBest = window.ko.observable(settings.pointsBest);

        this.pointsTotal = window.ko.observable(settings.pointsTotal);

        this.showHelpPoints = window.ko.observable(true);
        
        this.helpPoints = function () {
            if (!String.isEmpty(settings.pointsUrl)) {
                window.location = settings.pointsUrl;
            }
        };

        this.draw = function() {
            var width = Math.floor(($(this.moduleScope).width() - 20) / 3);
            $('.points-list-item', $(this.moduleScope)).css('width', width);
            this.showHelpPoints(!dnn.social.MobileView.onMobile);
            $('.points-list', $(this.moduleScope)).show();
        };

        this.binded = function () {
            this.draw();
            var p = $.proxy(this.draw, this);
            var resizeThrottle = null;
            var lp = function () {
                if (resizeThrottle) {
                    clearTimeout(resizeThrottle);
                    resizeThrottle = null;
                }
                resizeThrottle = setTimeout(function () {
                    resizeThrottle = null;
                    p();
                }, 400);
            };
            $(window).unbind('resize', lp).bind('resize', lp);
        };
    };
})(window.dnn);