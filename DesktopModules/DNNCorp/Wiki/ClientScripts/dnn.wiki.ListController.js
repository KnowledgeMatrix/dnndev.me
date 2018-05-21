// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function (dnn) {
    'use strict';

    dnn.wiki.ListController = function ListController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();
        
        this.service = social.getService('List');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);
        
        this.resultsMobile = ko.observableArray([]);
        
        this.sort = ko.observable(settings.sort);

        this.order = ko.observable('descending');

        this.totalResults = ko.observable(0);
        
        this.category = ko.observable(settings.category);
        
        this.tags = ko.observableArray([]);

        this.frozen = ko.observable(false);

        this.loading = ko.observable(false);
        
        this.sequence = 0;
        
        this.hasResults = ko.computed(
          function () {
              if (that.sequence == 0) {
                  return true;
              }

              return that.results().length > 0;
          });
        
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
            
            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure = function () {
                loadingContainer.removeClass('loading');
            };

            var success = function (m) {
                if (m.Sequence != that.sequence - 1) {
                    return;
                }
                
                loadingContainer.removeClass('loading');

                var results = [];
                
                $.each(m.Results,
                       function (index, model) {
                           var article = dnn.social.komodel(model);
                           results.push(article);
                       });
                
                if (appendToOriginalSets) {
                    for (var i = 0; i < results.length; i++) {
                        var exists = false;
                        $.each(that.resultsMobile(),
                            function (index, p) {
                                if (p.articleId() === results[i].articleId()) {
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
                
                that.totalResults(m.TotalRecords || 0);
            };

            var params = {
                category: that.category(),
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                sortColumn: that.sort(),
                sortAscending: that.order() === 'ascending',
                tags: that.filterTagList(that.tags()),
                groupId: settings.groupId,
                sequence: that.sequence++
            };

            loadingContainer.addClass('loading');

            this.service.post('Query', params, success, failure, that.loading);
        };
        
        this.loadStart = function () {
            var pagingController = social.getComponentFactory().resolve('PagingControl');
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
                     var article = dnn.social.komodel(model);
                     results.push(article);
                 });

            that.totalResults(settings.totalRecords || 0);

            that.results(results);
            
            that.resultsMobile(results);
            
            var tagsInput = $('.sort-tags-input', settings.moduleScope);
            if ((settings.initialTags || '').length > 0 && tagsInput.length > 0) {
                that.tags(settings.initialTags.split(','));
                tagsInput.dnnImportTags(settings.initialTags);
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
                 case 'draftonly':
                     that.order('descending');
                     that.sort('lastactive');
                     break;
             }
         });

        this.sort.subscribe(
            function () {
                switch (that.sort().toLowerCase()) {
                    case 'title':
                        that.order('ascending');
                        break;
                    case 'lastactive':
                    case 'createddate':
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