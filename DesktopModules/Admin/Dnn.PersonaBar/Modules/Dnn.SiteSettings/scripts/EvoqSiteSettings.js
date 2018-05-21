// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
'use strict';
define(['jquery'], function ($) {
    function loadEvoqSiteSettingsScript() {
        var url = "modules/dnn.sitesettings/scripts/bundles/evoq-site-settings-bundle.js";

        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    function loadSiteSettingsScript() {
        var url = "modules/dnn.sitesettings/scripts/bundles/site-settings-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    var init = function (wrapper, util, params, callback) {

        window.dnn.initSiteSettings = function initializeSiteSettings() {
            return {
                utility: util,
                settings: params.settings,
                moduleName: 'EvoqSiteSettings',
                identifier: params.identifier
            };
        };

        window.dnn.SiteSettings = {};

        loadEvoqSiteSettingsScript();

        wrapper.on('init.extension', function () {
            if (!window.dnn.SiteSettings.bundleLoaded) {
                setTimeout(function () {
                    loadSiteSettingsScript();
                }, 0);
            }
        });

        if (typeof callback === "function") {
            callback();
        }
    };

    var initMobile = function (wrapper, util, params, callback) {
        if (typeof callback === "function") {
            callback();
        }
    };

    var load = function (params, callback) {
        if (typeof callback === "function") {
            callback();
        }
    }

    var loadMobile = function (params, callback) {
        if (typeof callback === "function") {
            callback();
        }
    }

    return {
        init: init,
        initMobile: initMobile,
        load: load,
        loadMobile: loadMobile
    };
});