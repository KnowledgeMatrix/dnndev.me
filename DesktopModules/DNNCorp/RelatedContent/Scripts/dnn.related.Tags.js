// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.TagController = function TagController($, ko, settings, social) {
        var that = this;
        this.social = social;
        this.service = social.getService('Related');
        this.results = ko.observableArray([]);
        this.load = function () {
            var success = function (m) {
                var results = [];

                $.each(m.Results,
                    function (index, model) {
                        results.push({ name: model.name, totalTermUsage: model.totalTermUsage });
                    });
                that.results(results);
            };

            var failure = function () {
                that.results([]);
            };

            var params = {
                pageIndex: 0,
                pageSize: settings.pageSize
            };

            that.service.get('GetTags', params, success, failure);
        };
    };

    dnn.related.Tags = function Tags($, ko, settings) {
        var that = this;
        this.social = new dnn.social.Module(settings);
        this.tagController = new dnn.related.TagController($, ko, settings, this.social);
        this.results = ko.computed(function() {
            var results = that.tagController.results();
            return results.length > 0 ? results : settings.initialSet;
        });
        dnn.social.ipc.register(settings, function(src, msg) {
            if (msg.event == 'Refresh') {
                that.tagController.load();
            }
        });
    };
})(window.dnn);