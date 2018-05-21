// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileBadges = function ProfileBadges(settings) {

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;
        
        this.badges = window.ko.observableArray([]);
        
        this.helpBadges = function () {
            if (!String.isEmpty(settings.badgesUrl)) {
                window.location = settings.badgesUrl;
            }
        };

        this.draw = function() {
            setTimeout(function () { var slider = new dnn.dashboard.BadgeSlider(); }, 100);
        };

        this.binded = function () {
            var badges = [];
            $.each(settings.badges || [],
                function (index, badge) {
                    badges.push(dnn.social.komodel(badge));
                });

            this.badges(badges);
            this.draw();
        };
    };
})(window.dnn);