// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';

    dnn.groupSpaces.Result = function Result(title, url) {
        this.title = ko.observable(title);
        this.url = ko.observable(url);
    };

    dnn.groupSpaces.GroupedResults = function GroupedResults(tabId, tabName, results) {
        this.tabId = ko.observable(tabId);
        this.tabName = ko.observable(tabName);
        this.results = ko.observableArray(results);
    };

    dnn.groupSpaces.SearchController = function SearchController($, ko, settings, social) {
        var self = this;

        this.social = social;
        this.settings = settings;
        this.totalRecords = ko.observable(0);
        this.query = ko.observable('');
        this.groupedResults = ko.observableArray([]);

        this.timeout = undefined;
        this.maximumItems = settings.maximumSearchItems || 100;
        this.placeholder = $('#txtShare').attr('placeholder');

        this.submitSearch = function () {
            if (String.isEmpty(self.query()) || self.query() == self.placeholder) {
                self.totalRecords(0);
                self.groupedResults([]);
                return;
            }
            
            var primaryView = social.getComponentFactory().resolve('PrimaryView');
            var isMobileView = primaryView.isMobileView();
            if (!isMobileView) {
                if ($('.groups-results-list').is(':visible') == false) {
                    primaryView.toggleResults();
                }
            } else {
                if ($('.dnnMobileGroupSearchResult').is(':visible') == false) {
                    primaryView.toggleResultsMobile();
                }
            }

            var failure = function () {
                self.totalRecords(0);
                self.groupedResults([]);
            };
            var success = function (response) {
                var total = 0;
                self.groupedResults([]);
                for (var index = 0; index < response.results.length; index++) {

                    var contentItems = [];
                    $.each(response.results[index].results || [],
                        function (innerIndex, model) {
                            contentItems.push(new dnn.groupSpaces.Result(model.Title, model.Url));
                        });

                    self.groupedResults.push(new dnn.groupSpaces.GroupedResults(response.results[index].tabId, response.results[index].tabName, contentItems));
                    total = total + response.results[index].results.length;
                }

                self.totalRecords(total);
            };

            self.search(self.query(), success, failure, self.loading);
        };

        self.loading = function (b) {
            var control = $('.groups-search-results', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.query.subscribe(
            function () {
                if (typeof self.timeout !== 'undefined') {
                    clearTimeout(self.timeout);
                }

                self.timeout = setTimeout(self.submitSearch, 350);
            });

        var isPlaceHolderSupported = !!("placeholder" in document.createElement("input"));
        if (!isPlaceHolderSupported) {
            self.query(self.placeholder);
            $('#groupOverview-txtShare').addClass('placeHolder');
            $(function () {
                $('#groupOverview-txtShare').focus(function () {
                    if (self.query() == self.placeholder) {
                        self.query('');
                        $(this).removeClass('placeHolder');
                    }
                })
                .blur(function () {
                    if (String.isEmpty(self.query())) {
                        self.query(self.placeholder);
                        $(this).addClass('placeHolder');
                    }
                });
            });
        }

        this.search = function (keywords, successHandler, failureHandler, loading) {
            var failure = function () {
                if (typeof failureHandler === 'function') {
                    failureHandler();
                }
            };
            var success = function (m) {
                if (typeof successHandler === 'function') {
                    successHandler(m);
                }
            };

            var service = social.getService('GroupSpacesService');

            var params = {
                keywords: self.query(),
                max: self.maximumItems,
                groupId: settings.groupId === null ? -1 : settings.groupId,
                moduleId: settings.moduleId
            };

            service.get('SearchGroupContent', params, success, failure, loading);
        };
    };
})(window.dnn);