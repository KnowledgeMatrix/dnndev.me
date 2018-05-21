// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};

(function(dnn) {
    'use strict';

    dnn.blogs.ListController = function ListController($, ko, settings, social) {
        var that = this;

        this.category = ko.observable(settings.category);

        this.componentFactory = social.getComponentFactory();

        this.service = social.getService('EntryList');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);

        this.resultsMobile = ko.observableArray([]);

        this.tags = ko.observableArray([]);

        this.startDate = null;

        this.endDate = null;

        this.selectedDate = null;

        this.frozen = ko.observable(false);

        this.sequence = 0;

        this.page = function() {
            var paging = that.componentFactory.resolve('PagingControl');
            if (paging != null) {
                return paging.page();
            }

            return 0;
        };

        this.load = function(appendToOriginalSets) {
            if (that.frozen()) {
                return;
            }
            
            var localizer = social.getLocalizationController();

            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure = function () {
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

                    $.each(m.Results, function(index, model) {
                        results.push(new dnn.blogs.Entry($, ko, settings, social, model));
                    });

                    that.totalResults(m.TotalRecords || 0);

                    if (appendToOriginalSets) {
                        for (var i = 0; i < results.length; i++) {
                            var exists = false;
                            $.each(that.resultsMobile(),
                                function (index, p) {
                                    if (p.entryId() === results[i].entryId()) {
                                        exists = true;
                                        return false;
                                    }
                                    return true;
                                });

                            if (!exists)
                                that.resultsMobile.push(results[i]);
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

            if (that.selectedDate) {
                var dayAfterSelectedDate = new Date(that.selectedDate);
                dayAfterSelectedDate.setDate(dayAfterSelectedDate.getDate() + 1);
                that.startDate = '/Date(' + (that.selectedDate.getTime() - that.selectedDate.getTimezoneOffset() * 60 * 1000) + ')/';
                that.endDate = '/Date(' + (dayAfterSelectedDate.getTime() - that.selectedDate.getTimezoneOffset() * 60 * 1000) + ')/';
            } else {
                that.startDate = that.endDate = null;
            }

            var params = {
                groupId: settings.groupId,
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                tags: that.tags(),
                blogId: settings.blogId,
                authorId: settings.authorId,
                startDate: that.startDate || settings.startDate,
                endDate: that.endDate || settings.endDate,
                filterString: that.category(),
                sequence: that.sequence++
            };
            
            that.service.post('Query', params, success, failure);
        };

        this.loadStatic = function() {
            var results = [];

            $.each(settings.initialSet || [],
                function(index, model) {
                    results.push(new dnn.blogs.Entry($, ko, settings, social, model));
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

        this.loadStart = function() {
            var pagingController = that.componentFactory.resolve('PagingControl');
            if (pagingController != null) {
                if (pagingController.page() !== 0) {
                    pagingController.page(0);
                } else {
                    that.load();
                }
            }
        };

        var pager = that.componentFactory.resolve('PagingControl');
        if (pager != null) {
            pager.page.subscribe(
                function() {
                    that.load();
                });
        }
    };
    
})(window.dnn);