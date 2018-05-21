// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function (dnn) {
    'use strict';

    dnn.social.ContentExchangeSearch = function ContentExchangeSearch($, ko, settings, social, context) {
        var that = this;

        this.context = context;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('ContentExchange');

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

        this.pagingControlVisible = function () {
            var pagingControl = componentFactory.resolve('PagingControl');
            if (pagingControl == null) {
                return false;
            }

            return pagingControl.totalPages() > 1;
        };

        this.loading = function (b) {
            if (b) {
                $('.social-content-exchange', settings.moduleScope).addClass('loading');
            }
            else {
                $('.social-content-exchange', settings.moduleScope).removeClass('loading');
            }
        };

        this.load = function() {
            var success = function(m) {
                var results = [];

                $.each(m.Results,
                    function(index, model) {
                        results.push(new dnn.social.ContentExchangeSearchItem($, ko, settings, social, model, {
                            itemId: index,
                            toggleSelectionHandler: function(itemId, isSelected) {
                                if (isSelected) {
                                    for (var i = 0; i < that.results().length; i++) {
                                        if (i != itemId) {
                                            that.results()[i].isSelected(false);
                                        }
                                    }
                                }
                            }
                        }));
                    });

                that.totalResults(m.TotalRecords || 0);
                that.results(results);

                that.resizeContentContainer();
            };

            var failure = function() {
                that.totalResults(0);
                that.results([]);

                that.resizeContentContainer();
            };

            var pager = componentFactory.resolve('PagingControl');
            if (pager == null) {
                return null;
            }

            pager.pageSize = 50;

            var params = {
                contentItemId: settings.contentItemId || -1,
                sortColumn: that.sortColumn(),
                sortAscending: that.sortAscending(),
                searchText: that.searchText(),
                pageIndex: pager.page(),
                pageSize: pager.pageSize,
                tabId: context.tabId(),
                moduleId: context.moduleId(),
                groupId: context.isGroupPage() ? context.groupId() : -1,
                includeSelfContentItem: context.includeSelfContentItem()
            };

            that.service.post('SearchContentItems', params, success, failure, that.loading);
        };

        this.resizeContentContainer = function () {
            var maxVisibleRows = 5;
            var container = $('#parentsList');
            var rows = $('#parentsList tbody tr');

            var maxHeight = 1;
            for (var i = 0; i < Math.min(rows.length, maxVisibleRows) ; i++) {
                maxHeight += rows[i].clientHeight;
            }

            maxHeight = Math.max(maxHeight, 15);

            container.jScrollPane();
            container.css('height', maxHeight);

            var scrollContent = container;
            if (scrollContent.data('jsp')) {
                if (rows.length > 0) {
                    scrollContent.data('jsp').reinitialise();
                } else {
                    scrollContent.data('jsp').destroy();
                }
            } else {
                if (rows.length > 0) {
                    scrollContent.jScrollPane();
                }
            }
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
                if (typeof (that.searchTimeout) != 'undefined') {
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