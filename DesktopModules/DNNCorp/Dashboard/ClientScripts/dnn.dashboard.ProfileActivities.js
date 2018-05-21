// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileActivities = function ProfileActivities(settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;
        
        this.heatmap = null;

        this.activities = ko.observableArray([]);

        this.selectedDate = ko.observable('');

        this.bindHeatMap = function(containerId) {
            if (!that.heatmap) {
                var chartSettings = {
                    method: 'GetUserActivitiesHeatMap',
                    detailMethod: 'GetUserActivitiesForDay',
                    containerId: containerId,
                    detailCallback: function(d, dd) {
                        that.activities(d);
                        that.selectedDate(dd);
                    },
                    extendedOptions: function () {
                        return { userId: settings.userId };
                    }
                };
                that.heatmap = new dnn.dashboard.D3Heatmap(settings, that.social, chartSettings, that);
                that.heatmap.load();
            } else {
                that.heatmap.containerId = containerId;
                that.heatmap.draw();
            }
        };

        this.bindControls = function () {
            $(settings.moduleScope).show();
            this.bindHeatMap('dashboard-profile-heatmap');
        };

        this.bindControlsMobileView = function () {
            $(settings.moduleScope).hide();
            if (that.heatmap) {
                $('#dashboard-profile-heatmap').empty();
                that.heatmap = null;
            }
        };

        this.switchingView = function() {
            $(".ui-dialog-content").dialog("close");
        };

        this.switchedView = function () {
            if (this.isMobileView()) {
                this.bindControlsMobileView();
            } else {
                this.bindControls();
            }
        };
        
        this.binded = function () {
            this.switchedView();
        };
        
        dnn.social.MobileView.init($, window.ko, this, this.switchingView, this.switchedView);
    };
})(window.dnn);