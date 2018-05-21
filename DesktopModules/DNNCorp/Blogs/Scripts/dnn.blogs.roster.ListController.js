// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};
if (typeof dnn.blogs.roster === 'undefined') dnn.blogs.roster = {};

(function (dnn) {
    'use strict';

    dnn.blogs.roster.ListController = function ListController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('ListView');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);
        
        this.category = ko.observable(settings.category);
        
        this.loading = ko.observable(false);

        this.frozen = ko.observable(false);

        this.sequence = 0;

        this.page = function () {
            var paging = componentFactory.resolve('PagingControl');
            if (paging != null) {
                return paging.page();
            }

            return 0;
        };

        this.setPage = function (page) {
            var paging = componentFactory.resolve('PagingControl');
            if (paging != null) {
                paging.page(page);
            }
        };

        this.previousPage = 0;

        this.hasResults = ko.computed(
            function () {
                return that.results().length > 0;
            });

        this.load = function() {
            that.setPage(that.previousPage);
        };

        this.loadData = function () {
            that.previousPage = that.page();
          
            var localizer = social.getLocalizationController();
            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure =
                function () {
                    loadingContainer.removeClass('loading');
                };

            var success =
                function (m) {
                    if (m.Sequence != (that.sequence - 1)) {
                        return;
                    }

                    loadingContainer.removeClass('loading');

                    if (m.hasOwnProperty('Results') === false) {
                        $.dnnAlert({
                            title: localizer.getString('InvalidResponseCaption'),
                            text: localizer.getString('InvalidResponseText')
                        });

                        return;
                    }

                    var results = [];

                    $.each(m.Results,
                        function (index, model) {
                            results.push(new dnn.blogs.roster.BlogView($, ko, settings, social, model));
                        });

                    that.results(results);
                };

            loadingContainer.addClass('loading');
            
            var params = {
                groupId: settings.groupId,
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                sequence: that.sequence++
            };

            that.service.post('GetBlogRosterList', params, success, failure, that.loading);
        };

        this.loadStart = function () {
            var pagingController = social.getComponentFactory().resolve('PagingControl');
            if (pagingController != null) {
                if (pagingController.page() !== settings.pageIndex) {
                    pagingController.page(settings.pageIndex);
                } else {
                    that.loadData();
                }
            }
        };

        this.loadStatic = function () {
            var results = [];

            $.each(settings.initialSet || [],
                function (index, model) {
                    results.push(new dnn.blogs.roster.BlogView($, ko, settings, social, model));
                });

            that.totalResults(settings.totalRecords || 0);
            that.results(results);
        };

    };
})(window.dnn);