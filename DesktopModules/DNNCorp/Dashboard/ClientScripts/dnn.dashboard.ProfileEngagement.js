// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileEngagement = function ProfileEngagement(settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;

        this.engagement = window.ko.computed(function() {
            if (settings.engagement >= settings.optimalEngagement)
                return 100;
            return parseInt(((settings.engagement / settings.optimalEngagement) * 100).toString(), 10);
        });
        
        this.influence = window.ko.observable(settings.influence || 0);
        
        this.bindProgressbars = function () {
            var width = $(this.moduleScope).width() - 40;
            $('.dashboard-single-line-bar', $(this.moduleScope)).css('width', width);
            $('.dashboard-engagement-progress').progressbar({ value: this.engagement() });
            $('.dashboard-influence-progress').progressbar({ value: this.influence() });
        };
        
        this.binded = function () {
            this.bindProgressbars();
            var p = $.proxy(this.bindProgressbars, this);
            var resizeThrottle = null;
            var lp = function() {
                if (resizeThrottle) {
                    clearTimeout(resizeThrottle);
                    resizeThrottle = null;
                }
                resizeThrottle = setTimeout(function() {
                    resizeThrottle = null;
                    p();
                }, 400);
            };
            $(window).unbind('resize', lp).bind('resize', lp);
        };
    };
})(window.dnn);