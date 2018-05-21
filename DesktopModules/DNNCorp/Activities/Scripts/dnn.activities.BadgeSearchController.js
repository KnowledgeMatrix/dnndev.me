// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    
    dnn.activities.BadgeSearchController = function BadgeSearchController($, ko, settings, social) {
        
        this.service = social.getService('UserBadges');

        this.results = ko.observableArray([]);

        this.totalRecords = ko.observable(0);

        this.query = ko.observableArray();

        this.timeout = undefined;
        
        this.loading = function (b) {
            var control = $('.answer-addanswer-suggestion', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };
    };
})(window.dnn);