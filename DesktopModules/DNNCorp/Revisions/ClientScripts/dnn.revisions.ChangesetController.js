// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.revisions === 'undefined') dnn.revisions = {};

(function(dnn) {
    'use strict';

    dnn.revisions.ChangesetController = function ChangesetController(settings, contentItemId, contentItemType, childItemId) {
        var that = this;
        
        var social = new dnn.social.Module(settings);

        this.totalResults = ko.observable(0);

        this.load = function (pageIndex, completionHandler, failureHandler, loadingHandler) {
            var localizer = social.getLocalizationController();

            var failure = function (xhr, status) {
                if (typeof failureHandler === 'function') {
                    failureHandler(status || localizer.getString('UnknownError'));
                }
            };

            var success = function (model) {
                that.totalResults(model.TotalRecords || 0);

                if (typeof completionHandler === 'function') {
                    completionHandler(model);
                }
            };

            if (typeof that.static === 'undefined') {
                that.static = new Object();

                var response = {
                    Records: settings.initialSet || [],
                    TotalRecords: settings.totalRecords || 0,
                    DetailsUrl: settings.detailsUrl
                };

                that.totalResults(settings.totalRecords || 0);

                completionHandler(response);
            } else {
                var params = {
                    contentItemId: contentItemId || settings.contentItemId || -1,
                    contentItemType: contentItemType || settings.contentItemType || 0,
                    childItemId: childItemId || settings.childItemId || 0,
                    pageIndex: pageIndex || 0,
                    pageSize: settings.pageSize,
                    detailsUrl: settings.detailsUrl
                };

                var service = social.getService('RevisionsService');
                service.get('GetRevisions', params, success, failure, loadingHandler);
            }
        };
    };
})(window.dnn);