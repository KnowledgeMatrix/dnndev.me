// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.ListController = function ListController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('List');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);
        
        this.resultsMobile = ko.observableArray([]);

        this.sort = ko.observable(settings.sort);

        this.order = ko.observable('ascending');

        this.category = ko.observable(settings.category);

        this.stateFilter = ko.observable(settings.category);

        this.searchFilter = ko.observable();

        this.tags = ko.observableArray([]);
        
        this.startDate = null;

        this.endDate = null;

        this.frozen = ko.observable(false);

        this.loading = ko.observable(false);

        this.sequence = 0;

        this.page = function () {
            var paging = componentFactory.resolve('PagingControl');
            if (paging != null) {
                return paging.page();
            }

            return 0;
        };

        this.load = function (appendToOriginalSets) {
            if (that.frozen()) {
                return;
            }

            var localizer = social.getLocalizationController();

            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure =
                function () {
                    loadingContainer.removeClass('loading');
                };

            var success =
                function (m) {
                    if (m.Sequence != that.sequence - 1) {
                        return;
                    }
                    
                    loadingContainer.removeClass('loading');

                    if (m.hasOwnProperty('Results') === false || m.hasOwnProperty('TotalRecords') === false) {
                        $.dnnAlert({
                            title: localizer.getString('InvalidResponseCaption'),
                            text: localizer.getString('InvalidResponseText')
                        });

                        return;
                    }

                    var results = [];

                    $.each(m.Results,
                        function (index, model) {
                            results.push(new dnn.socialevents.SocialEvent($, ko, settings, social, model));
                        });

                    that.totalResults(m.TotalRecords || 0);
                    
                    if (appendToOriginalSets) {
                        for (var i = 0; i < results.length; i++) {
                            var exists = false;
                            $.each(that.resultsMobile(),
                                function (index, p) {
                                    if (p.eventId() === results[i].eventId()) {
                                        exists = true;
                                        return false;
                                    }
                                    return true;
                                });

                            if (!exists)
                               that.resultsMobile().push(results[i]);
                        }

                    } else {
                        that.resultsMobile([]);
                        $.each(results, function (index, post) {
                            that.resultsMobile.push(post);
                        });
                    }

                    that.results([]);
                    $.each(results, function (index, post) {
                        that.results.push(post);
                    });
                };

            loadingContainer.addClass('loading');

            var category = that.category();
            if (category === 'all') {
                category = null;
            }
            
            if (that.selectedDate) {
                var dayAfterSelectedDate = new Date(that.selectedDate);
                dayAfterSelectedDate.setDate(dayAfterSelectedDate.getDate() + 1);
                that.startDate = '/Date(' + (that.selectedDate.getTime() - that.selectedDate.getTimezoneOffset() * 60 * 1000) + ')/';
                that.endDate = '/Date(' + (dayAfterSelectedDate.getTime() - that.selectedDate.getTimezoneOffset() * 60 * 1000) + ')/';
            } else {
                that.startDate = that.endDate = null;
            }

            that.setSortOrder();
            
            var params = {
                groupId: settings.groupId,
                category: category,
                searchFilter: that.searchFilter(),
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                sortColumn: that.sort(),
                sortAscending: that.order() === 'ascending',
                tags: that.tags(),
                startDate: that.startDate,
                endDate: that.endDate,
                sequence: that.sequence++
            };

            that.service.post('Query', params, success, failure);
        };

        this.loadStart = function () {
            var pagingController = componentFactory.resolve('PagingControl');
            if (pagingController != null) {
                if (pagingController.page() !== 0) {
                    pagingController.page(0);
                } else {
                    that.load();
                }
            }
        };

        this.loadStatic = function () {
            var results = [];

            $.each(settings.initialSet || [],
                function (index, model) {
                    results.push(new dnn.socialevents.SocialEvent($, ko, settings, social, model));
                });

            that.totalResults(settings.totalRecords || 0);

            that.results(results);

            that.resultsMobile(results);
            
            var tagInput = $('.sort-tags-input', settings.moduleScope);
            if ((settings.initialTags || '').length > 0 && tagInput.length > 0) {
                that.tags(settings.initialTags.split(','));
                tagInput.dnnImportTags(settings.initialTags);
            }
        };

        this.setSortOrder = function() {
            switch (that.sort().toLowerCase()) {
                case 'author':
                case 'title':
                case 'eventstarttime':
                    that.order('ascending');
                    break;
                case 'lastactive':
                case 'views':
                case 'createddate':
                    that.order('descending');
                    break;
                default:
                    break;
            }
        };

        var pager = componentFactory.resolve('PagingControl');
        if (pager != null) {
            pager.page.subscribe(
                function () {
                    that.load();
                });
        }
        
    };
})(window.dnn);
