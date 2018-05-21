// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';

    dnn.groupSpaces.GroupAdministrators = function GroupAdministrators($, ko, settings) {
        var self = this;
        
        this.settings = settings;
        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('GroupAdministrators');
        this.componentFactory = this.social.getComponentFactory();
        this.totalResults = ko.observable(0);
        this.results = ko.observableArray([]);
        this.pageSize = 5;
        this.pageIndex = ko.observable(0);
        this.totalPages = ko.computed(function () {
            var total = self.totalResults();
            return total > 0 ? Math.max(1, Math.ceil(total / self.pageSize)) : 0;
        });
        this.load = function () {
            var success = function (data) {
                var results = [];

                $.each(data.Results,
                    function (index, model) {
                        results.push({
                            userId: model.userId,
                            groupId: model.groupId,
                            displayName: model.displayName,
                            avatar: model.avatar,
                            profileUrl: model.profileUrl,
                            totalRecords: model.totalRecords
                        });
                    });

                self.totalResults(data.TotalRecords || 0);
                self.results(results);
            };

            var failure = function () {
                self.results([]);
            };

            var params = { groupId: settings.groupId, pageIndex: self.pageIndex(), pageSize: self.pageSize };
            self.service.post('GetGroupAdministrators', params, success, failure);
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

        this.binded = function() {
            this.load();
        };
    };
})(window.dnn);