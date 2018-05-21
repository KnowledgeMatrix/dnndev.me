// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
'use strict';
define(['jquery', './social-dashboard-instance'], function ($, Dashboard) {

    var dashboardInstances = {};

    return {
        init: function (wrap, util, params, callback) {
            var dashboard = new Dashboard();
            var query = params.query;
            dashboardInstances[query] = dashboard;

            dashboard.init(wrap, util, params, callback);
        },

        load: function (params, callback) {
            var query = params.query;
            dashboardInstances[query].load(params, callback);
        }
    };
});