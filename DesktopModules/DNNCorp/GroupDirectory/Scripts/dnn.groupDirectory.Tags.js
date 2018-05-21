// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};

(function (dnn) {
    'use strict';

    dnn.groupDirectory.TagController = function TagController($, ko, settings, social) {
        var self = this;

        this.social = social;
        this.service = social.getService('Tags');
        this.results = ko.observableArray([]);
        
        this.load = function () {
            var success = function (m) {
                var results = [];

                $.each(m.Results,
                    function (index, model) {
                        results.push({ Name: model.name, totalTermUsage: model.totalTermUsage });
                    });

                self.results(results);
            };

            var failure = function () {
                self.results([]);
            };

            var params = {
                roleGroupId: settings.roleGroupId,
                pageIndex: 0,
                pageSize: settings.pageSize
            };

            self.service.get('GetTags', params, success, failure);
        };
    };

    dnn.groupDirectory.Tags = function Tags($, ko, settings) {
        var self = this;

        this.social = new dnn.social.Module(settings);
        this.tagController = new dnn.groupDirectory.TagController($, ko, settings, this.social);
        this.results = ko.computed(function() {
            var results = self.tagController.results();
            if (results.length == 0)
                return settings.initialSet;

            return results;
        });
        
        dnn.social.ipc.register(settings, function(src, msg) {
            if (msg.event == 'Refresh') {
                self.tagController.load();
            }
        });

    };
})(window.dnn);