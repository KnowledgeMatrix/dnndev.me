// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';

    dnn.activities.UserBadgesController = function UserBadgesController($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = social.getService('UserBadges');

        this.results = ko.observableArray([]);

        this.totalResults = ko.observable(0);

        this.loading = ko.observable(false);

        this.sequence = 0;

        this.isMore = ko.computed(function() { return that.totalResults() > that.results().length; }, this);

        this.getMore = function() {
            var pager = componentFactory.resolve('PagingControl');
            pager.next();
        };

        this.page = function () {
            var pager = componentFactory.resolve('PagingControl');
            return pager ? pager.page() : 0;
        };

        this.startPosition =
            function () {
                var pager = componentFactory.resolve('PagingControl');
                if (pager && that.results().length > 0) {
                    return pager.page() * pager.pageSize + 1;
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

        this.hasResults = ko.computed(function () {
            return that.results().length > 0;
        });

        this.load = function () {

            var localizer = social.getLocalizationController();

            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure =
                function (xhr, status) {
                    loadingContainer.removeClass('loading');
                };

            var success =
                function (m) {
                    if (m.Sequence !== that.sequence - 1) {
                        console.log('Ignoring out-of-sequence search response (seq {0} vs expected {1})'
                            .format(m.Sequence, that.sequence - 1));
                        return;
                    }

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
                            results.push(new dnn.activities.Badge($, ko, settings, social, model));
                        });

                    that.totalResults(m.TotalRecords || 0);

                    that.results(that.results().concat(results));

                };

            loadingContainer.addClass('loading');

            var params = {
                pageIndex: that.page(),
                pageSize: settings.pageSize,
                viewUserId: settings.viewUserId,
                sequence: that.sequence++
            };

            that.service.post('GetBadges', params, success, failure, that.loading);

            return null;
        };
        
        dnn.social.EventQueue.push(
            function () {
                var pagingControl = social.getComponentFactory().resolve('PagingControl');
                if (pagingControl != null) {
                    pagingControl.page.subscribe(function () { that.load(); });
                }
                
                that.load();
            });

    };
})(window.dnn);
