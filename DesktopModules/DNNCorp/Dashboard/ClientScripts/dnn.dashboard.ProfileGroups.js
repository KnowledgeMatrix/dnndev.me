// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.ProfileGroups = function ProfileGroups(settings) {

        var self = this;
        
        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;

        this.results = ko.observableArray(settings.userGroups);

        this.totalResults = ko.observable(settings.totalRecords);

        this.pageSize = settings.pageSize;

        this.pageIndex = ko.observable(0);

        this.totalPages = ko.computed(function() {
            var total = self.totalResults();
            return total > 0 ? Math.max(1, Math.ceil(total / self.pageSize)) : 0;
        });

        this.load = function () {
            var success = function (data) {
                self.results(data);
            };

            var failure = function () {
                self.results([]);
            };

            var params = { userId: settings.userId, pageIndex: self.pageIndex(), pageSize: self.pageSize };
            var service = self.social.getService('Charts');
            service.get('GetUserGroups', params, success, failure);
        };
        
        this.prev = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex > 0) {
                self.pageIndex(--pageIndex);
                self.load();
            }
        };
        this.next = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex < self.totalPages() - 1) {
                self.pageIndex(++pageIndex);
                self.load();
            }
        };
        this.prevClass = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex > 0) {
                return new String();
            }
            return 'disabled';
        };
        
        this.nextClass = function () {
            var pageIndex = self.pageIndex();
            if (pageIndex < self.totalPages() - 1) {
                return new String();
            }
            return 'disabled';
        };
    };
})(window.dnn);