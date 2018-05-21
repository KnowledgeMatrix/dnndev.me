// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function (dnn) {
    'use strict';

    dnn.wiki.MetaDataController = function MetaDataController(settings, social) {
        var that = this;

        this.metadata = [];

        this.image = null;

        this.totalResults = 0;

        this.load = function (completionHandler, errorHandler, loading) {
            if (typeof that.static === 'undefined') {
                that.static = new Object();

                that.metadata = settings.metadata;

                that.image = settings.image;

                if (typeof completionHandler === 'function') {
                    completionHandler(that.image, that.metadata);
                }
            } else {
                var failure = function (xhr, status) {
                    if (typeof errorHandler === 'function') {
                        var localizer = social.getLocalizationController();

                        errorHandler(xhr, status || localizer.getString('UnknownError'));
                    }
                };

                var success = function (results) {
                    that.metadata = results;

                    if (typeof completionHandler === 'function') {
                        completionHandler(results.image, results.metadata);
                    }
                };

                var params = {
                    articleId: settings.articleId
                };

                var service = social.getService('Content');

                service.get('GetMetaData', params, success, failure, loading);
            }
        };
    };
})(window.dnn);
