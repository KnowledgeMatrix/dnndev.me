// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.leaderboard === 'undefined') dnn.leaderboard = {};

(function(dnn) {
    'use strict';
    
    dnn.leaderboard.MobileBoard = function MobileBoard  ($, ko, settings, social, controlSettings, homeControl) {
        var that = this;

        this.loading = ko.observable(false);
        
        this.moduleScope = $(settings.moduleScope);
        
        this.total = ko.observable(0);
        
        this.records = {};

        this.pageIndex = ko.observable(0);
        
        this.searchText = '';

        this.userId = settings.userId;
        
        this.interval = settings.interval;

        this.totalPages = ko.computed(
          function () {
              return Math.max(Math.ceil(that.total() / settings.pageSize), 1);
          });
        

        this.loadLeaders = function(completionHandler) {
            var success = function (m) {
                that.total(m.Records || 0);

                that.records[m.PageIndex] = [];
                that.pageIndex(m.PageIndex);
                that.initialOffset = m.PageOffset;

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(completionHandler);
                }

                that.records[m.PageIndex] = [];
                that.refresh(m.PageLeaders);
                that.loading(false);
            };

            var failure = function (xhr, status) {
                console.log('Unable to load leaderboard envelope:' + (status || 'Unknown error'));
            };

            var params = {
                mode: controlSettings.mode(),
                roleId: settings.groupId,
                searchText: that.searchText || '',
                userId: that.userId,
                interval: that.interval,
                rankMode: homeControl.rankMode,
                pageSize: settings.pageSize,
                mobileTemplate: true
            };

            that.loading(true);

            var service = social.getService('Leaderboard');

            service.get('GetLeaders', params, success, failure);
        }
                
        this.loadPage = function (completionHandler) {
            var success = function (m) {
                
                that.records[m.PageIndex] = [];

                that.refresh(m.PageLeaders);

                that.loading(false);

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(completionHandler);
                }
            };

            var failure = function (xhr, status) {
                console.log('Unable to load leaderboard page: ' + (status || 'Unknown error'));
            };

            that.loading(true);

            var pageIndex = this.pageIndex();

            var params = {
                mode: controlSettings.mode(),
                roleId: settings.groupId,
                pageIndex: pageIndex,
                pageSize: settings.pageSize,
                searchText: that.searchText || '',
                userId: that.userId,
                interval: that.interval,
                mobileTemplate: true
            };

            var service = social.getService('Leaderboard');

            service.get('LoadPage', params, success, failure);

            return true;
        };

        this.next = function () {
            this.pageIndex(this.pageIndex() + 1);
            this.loadPage();
        };

        this.prev = function() {
            this.pageIndex(this.pageIndex() - 1);
            this.loadPage();
        };

        this.refresh = function(rows) {
            var control = $('.dnnMobileListTblContainer tbody', that.moduleScope);
            control.html(rows.join(''));
        };
    };
})(window.dnn);