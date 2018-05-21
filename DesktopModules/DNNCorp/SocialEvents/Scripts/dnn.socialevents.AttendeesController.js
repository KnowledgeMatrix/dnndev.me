// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.AttendeesController = function AttendeesController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('Detail');

        this.totalResults = ko.observable(0);

        this.results = ko.observableArray([]);
        
        this.resultsMobile = ko.observableArray([]);

        this.category = ko.observable(1);

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
                            results.push(new dnn.socialevents.Guest($, ko, settings, social, model));
                        });

                    that.totalResults(m.TotalRecords || 0);
                    
                    if (appendToOriginalSets) {
                        for (var i = 0; i < results.length; i++) {
                            var exists = false;
                            $.each(that.resultsMobile(),
                                function (index, p) {
                                    if (p.guestId() === results[i].guestId()) {
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

            var params = {
                rsvpStatus: category,
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                contentItemId: settings.contentItemId,
                sequence: that.sequence++
            };

            that.service.get('GetAttendees', params, success, failure);
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

        var pager = componentFactory.resolve('PagingControl');
        if (pager != null) {
            pager.page.subscribe(
                function () {
                    that.load();
                });
        }
    };
})(window.dnn);
