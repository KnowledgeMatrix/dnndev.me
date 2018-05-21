// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.SearchController = function SearchController ($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('Related');

        this.results = ko.observableArray([]);

        this.totalResults = ko.observable(0);

        this.searchText = ko.observable('');

        this.sortAscending = ko.observable(false);

        this.sortColumn = ko.observable('createdOnDate');

        this.clear = function () {
            that.results([]);
            that.totalResults(0);
        };

        this.startPosition =
            function () {
                var pagingControl = componentFactory.resolve('PagingControl');
                if (pagingControl == null) {
                    return 0;
                }
                
                if (that.results().length > 0) {
                    return pagingControl.page() * pagingControl.pageSize + 1;
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

        this.loading = function (b) {
            if (b) {
                $('.related-content-container', settings.moduleScope).addClass('loading');
            }
            else {
                $('.related-content-container', settings.moduleScope).removeClass('loading');
            }
        };

        this.load = function () {
            var success = function (m) {
                var results = [];

                $.each(m.Results,
                    function (index, model) {
                        results.push(new dnn.related.RelatedItem($, ko, settings, social, model));
                    });

                that.totalResults(m.TotalRecords || 0);

                that.results(results);

                dnn.social.EventQueue.push(
                    function () {
                        $('.related-content-edit').dialog('option', 'position', 'center');
                    });
            };

            var failure = function () {
                that.totalResults(0);
                that.results([]);
            };

            var pager = componentFactory.resolve('PagingControl');
            if (pager == null) {
                return null;
            }

            var contentTypes = [];

            var filter = componentFactory.resolve('ContentTypesFilter');
            if (filter != null) {
                contentTypes = filter.contentTypes();
            }

            var params = {
                contentItemId: settings.contentItemId || -1,
                sortColumn: that.sortColumn(),
                sortAscending: that.sortAscending(),
                searchText: that.searchText(),
                pageIndex: pager.page(),
                pageSize: pager.pageSize,
                contentTypes: contentTypes
            };

            that.service.post('GetRelatedContent', params, success, failure, that.loading);
        };

        this.loadStart = function () {
            var pager = componentFactory.resolve('PagingControl');
            if (pager != null) {
                if (pager.page() != 0) {
                    pager.page(0);
                } else {
                    that.load();
                }
            } else {
                that.load();
            }
        };

        this.sort = function () {
            var column = arguments.callee.arguments[1].currentTarget.hash.substr(1);
            if (column == that.sortColumn()) {
                that.sortAscending(that.sortAscending() == false);
            } else {
                that.sortColumn(column);
                that.sortAscending(true);
            }
        };

        var pagingControl = componentFactory.resolve('PagingControl');
        if (pagingControl != null) {
            pagingControl.page.subscribe(
                function () {
                    that.load();
                });
        }

        this.searchText.subscribe(
            function () {
                if (typeof(that.searchTimeout) != 'undefined') {
                    clearTimeout(that.searchTimeout);
                }

                that.searchTimeout = setTimeout(
                    function () {
                        that.loadStart();
                    }, 350);
            });

        dnn.social.EventQueue.push(
            function () {
                that.sortColumn.subscribe(that.loadStart);
                that.sortAscending.subscribe(that.loadStart);
            });
    };
})(window.dnn);