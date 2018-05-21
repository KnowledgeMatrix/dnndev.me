// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    dnn.activities.SearchController = function SearchController($, ko, settings, social, root) {
        var that = this;

        this.service = social.getService('Activity');

        this.results = ko.observableArray([]);

        this.totalResults = ko.observable(0);

        this.startPosition =
            function () {
                var pager = social.getComponentFactory().resolve('PagingControl');
                if (pager != null) {
                    if (that.results().length > 0) {
                        return pager.page() * pager.pageSize + 1;
                    }
                }

                return 0;
            };

        this.endPosition =
            function () {
                if (that.results().length > 0) {
                    return that.startPosition() + that.results().length - 1;
                }
                return 0;
            };

        this.search = function () {
            var startSearch = function () {
                $('.filter-content', settings.moduleScope).addClass('searching');
            };

            var finishSearch = function () {
                $('.filter-content', settings.moduleScope).removeClass('searching');
            };

            var success = function (model) {
                
                var results = [];

                $.each(model.Results,
                    function (index, result) {
                        results.push(new dnn.activities.SearchResult($, ko, settings, root, social, result));
                    });

                that.results(results);
                that.totalResults(model.TotalResults || 0);
                $('.qaTooltip', settings.moduleScope).qaTooltip();

                finishSearch();
            };

            var failure = function (xhr, status) {
                var localizer = social.getLocalizationController();
                
                if ((status || new String()).length > 0) {
                    $.dnnAlert({
                        title: localizer.getString('SearchErrorTitle'),
                        text: localizer.getString('SearchError') + ': ' + (status || 'Unknown error')
                    });
                }

                that.results([]);
                that.totalResults(0);

                finishSearch();
            };

            startSearch();

            that.service.get('GetActivities', root.getSearchParameters(), success, failure);
        };
        
        this.sort = function () {
            root.sortedTable.sort(arguments[0], arguments[1]);
            
            var pager = social.getComponentFactory().resolve('PagingControl');
            if (pager != null) {
                pager.page(0);
            }
            
            that.search();
        };

        dnn.social.EventQueue.push(
            function () {
                var pagingControl = social.getComponentFactory().resolve('PagingControl');
                if (pagingControl != null) {
                    pagingControl.page.subscribe(
                        function () {
                            that.search();
                        });
                }
                
                that.search();
            });
    };
})(window.dnn);
