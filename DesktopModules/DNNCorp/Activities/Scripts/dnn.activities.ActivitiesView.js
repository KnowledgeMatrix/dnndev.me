// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    
    dnn.activities.ActivitiesView = function ActivitiesView($, ko, settings) {
        var that = this;

        $.extend(this, dnn.activities.ActivitiesView.defaultSettings, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Activity');

        this.desktopModuleId = ko.observable(-1);

        this.searchText = ko.observable(new String());

        var searchController = new dnn.activities.SearchController($, ko, settings, this.social, this);

        this.componentFactory = this.social.getComponentFactory();
        this.componentFactory.register(searchController);
        this.componentFactory.register(this.social.getPagingControl('SearchController'));
        this.sortedTable = new dnn.activities.SortTable($, $('#activity-table', settings.moduleScope)[0], searchController.results, null);
        this.sortedTable.column = 'ActionDisplayName';
        this.sortedTable.ascending = true;
        this.sortedTable.updateColumns();

        this.loadTooltips = function () {
            setTimeout(function () {
                $('.qaTooltip', that.moduleScope).qaTooltip();
            }, 100);
        };
       
        this.getSearchParameters = function () {
            var pager = that.componentFactory.resolve('PagingControl');
            if (pager == null) {
                return null;
            }

            return {
                searchText: that.searchText(),
                pageIndex: pager.page(),
                pageSize: pager.pageSize || 25,
                sortColumn: that.sortedTable.column,
                sortAscending: that.sortedTable.ascending,
                desktopModuleId: that.desktopModuleId() || -1
            };
        };

        this.loadStart = function () {
            var pager = that.componentFactory.resolve('PagingControl');
            if (pager.page() != 0) {
                pager.page(0);
            }
            else {
                searchController.search();
            }
        };

        this.pagingControl = ko.computed(
            function () {
                var pager = that.componentFactory.resolve('PagingControl');
                if (pager) {
                    return pager.markup();
                }

                return new String();
            });
        
        this.searchText.subscribe(
            function () {
                if (typeof (that.searchTimeout) !== 'undefined' && that.searchTimeout !== null) {
                    clearTimeout(that.searchTimeout);
                }

                that.searchTimeout = setTimeout(
                    function () {
                        that.loadStart();
                    }, 250);
            });
    };

    dnn.activities.ActivitiesView.defaultSettings = {
        moduleId: -1,
        portalId: 0,
        pageSize: 25
    };
})(window.dnn);

dnn.activities.ActivitiesView.defaultSettings = {
    moduleId: -1,
    portalId: 0,
    moduleScope: null
};
