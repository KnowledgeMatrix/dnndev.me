// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileFeatures = function ProfileFeatures(settings) {

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;
        
        this.toggleNavBarMobile = function () {
            if ($('.dnnMobileGroupsTab').is(':visible')) {
                $('.dnnMobileGroupsTab').slideUp('fast');
            } else {
                $('.dnnMobileGroupsTab').slideDown('fast');
            }
        };

        this.switchingView = function () {
            $(".ui-dialog-content").dialog("close");
        };

        this.switchedView = function () {
            dnn.social.loaded(settings.moduleScope.id);
        };

        this.binded = function () {
            this.switchedView();
        };

        dnn.social.MobileView.init($, window.ko, this, this.switchingView, this.switchedView);
    };
})(window.dnn);