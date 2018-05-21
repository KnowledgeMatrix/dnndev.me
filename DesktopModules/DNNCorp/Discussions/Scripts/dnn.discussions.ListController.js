// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.discussions === 'undefined') dnn.discussions = {};

(function (dnn) {
    'use strict';

    dnn.discussions.ListController = function ListController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('List');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);
        
        this.resultsMobile = ko.observableArray([]);

        this.sort = ko.observable(settings.sort);

        this.order = ko.observable('descending');

        this.category = ko.observable(settings.category);

        this.searchFilter = ko.observable();

        this.tags = ko.observableArray([]);

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

        this.hasResults = ko.computed(
            function() {
                return that.results().length > 0;
            });

        this.load = function (appendToOriginalSets) {
            if (that.frozen()) {
                return;
            }
            
            var localizer = social.getLocalizationController();

            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure =
                function () {
                    $('.loading-container', settings.moduleScope).removeClass('loading');
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
                            results.push(new dnn.discussions.Topic($, ko, settings, social, model));
                        });

                    that.totalResults(m.TotalRecords || 0);
                    
                    if (appendToOriginalSets) {
                        for (var i = 0; i < results.length; i++) {
                            var exists = false;
                            $.each(that.resultsMobile(),
                                function (index, p) {
                                    if (p.topicId() === results[i].topicId()) {
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

            var category = that.category();
            if (category === 'all') {
                category = null;
            }

            var params = {
                category: category,
                searchFilter: that.searchFilter(),
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                groupId: settings.groupId,
                sortColumn: that.sort(),
                sortAscending: that.order() === 'ascending',
                tags: that.filterTagList(that.tags()),
                sequence: that.sequence++
            };
            
            that.service.post('Query', params, success, failure, that.loading);
        };

        this.loadStart = function () {
            var pagingController = social.getComponentFactory().resolve('PagingControl');
            if (pagingController != null) {
                if (pagingController.page() !== settings.pageIndex) {
                    pagingController.page(settings.pageIndex);
                } else {
                    that.load();
                }
            }
        };

        this.loadStatic = function() {
            var results = [];

            $.each(settings.initialSet || [],
                function (index, model) {
                    results.push(new dnn.discussions.Topic($, ko, settings, social, model));
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

        this.filterTagList = function (f) {
            var list = [];
            $.each(that.tags(),
                function (i, tag) {
                    if (String.isEmpty(tag) == false) {
                        list.push(tag);
                    }
                });

            return list;
        };

        this.category.subscribe(
            function () {
                switch (that.category().toLowerCase()) {
                    case 'all':
                        that.order('descending');
                        break;
                }
            });

        this.sort.subscribe(
            function () {
                switch (that.sort().toLowerCase()) {
                    case 'author':
                    case 'title':
                        that.order('ascending');
                        break;
                    case 'lastactive':
                    case 'createddate':
                    case 'likes':
                    case 'views':
                        that.order('descending');
                        break;
                    default:
                        break;
                }
            });

        var pager = componentFactory.resolve('PagingControl');
        if (pager != null) {
            pager.page.subscribe(
            function () {
                that.load();
            });
        }
    };
})(window.dnn);