'use strict';
define(['jquery',
    'main/config',
    'main/loader',
    './analytics/tokenService'
],

function ($, cf, loader, tokenService) {
    var initCallback;
    var utility;
    var config = cf.init();

    if (!config.customSettings || !config.customSettings.analytics) {
        throw new Error("Analytics settings are not defined in persona bar customSettings");
    }
    var settings = config.customSettings.analytics;

    function getBundleLanguage(culture) {
        var fallbackLanguage = "en";
        var availableLanguages = ["en"];
        return availableLanguages.indexOf(culture) > 0 ? culture : fallbackLanguage;
    }

    function loadScript(basePath) {
        var normalizedCulture = config.culture.split("-")[0];
        var language = getBundleLanguage(normalizedCulture);
        var url = basePath + "/bundle-" + language + ".js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    function initContentServices(util, publicPath) {
        tokenService.init(util.sf);

        window.initAnalytics = function initializeAnalytics() {
            window.dnn.analytics.init({
                publicPath: publicPath,
                getToken: tokenService.getToken,
                tokenKey: settings.tokenKey,
                apiServiceUrl: settings.apiUrl,
                libraryVersion: settings.libraryVersion,
                loader: loader
            });

            if (typeof initCallback === 'function') {
                initCallback();
            }
        }
    }

    function enableFeature(success, error) {
        var sf = utility.sf;
        sf.moduleRoot = 'analyticslibrary';
        sf.controller = 'optin';
        sf.post('RequestAnalytics', {})
            .success(success)
            .error(error);
        settings.requested = true;
    }

    function closeModal() {
        utility.closePersonaBar();
    }

    function initOptInServices(publicPath, mode) {
        window.initOptIn = function initializeOptIn() {
            window.dnn.optIn.init({
                publicPath: publicPath,
                mode: mode,
                enableFeature: enableFeature,
                closeModal: closeModal
            });

            if (typeof initCallback === 'function') {
                initCallback();
            }
        }
    }

    function getOptInMode() {
        return settings.requested ? "analytics-wait" : "analytics";
    }

    return {
        init: function (wrapper, util, params, callback) {
            initCallback = callback;
            utility = util;

            if (config.debugMode === true) {
                window.__REACT_DEVTOOLS_GLOBAL_HOOK__ = window.parent.__REACT_DEVTOOLS_GLOBAL_HOOK__;
            }

            if (settings.enabled) {
                var analyticsPublicPath = settings.uiUrl + "/dist/";
                initAnalyticsServices(util, analyticsPublicPath);
                loadScript(analyticsPublicPath);
            } else {
                var optInPublicPath = settings.optInUrl + "/dist/";
                var mode = getOptInMode();
                initOptInServices(optInPublicPath, mode);
                loadScript(optInPublicPath);
            }
        },

        initMobile: function (wrapper, util, params, callback) {
            this.init(wrapper, util, params, callback);
        },

        load: function (params, callback) {
            var ea = window.dnn.analytics;
            if (ea && ea.load) {
                ea.load();
            }
            var optin = window.dnn.optIn;
            if (optin && optin.load) {
                var mode = getOptInMode();
                optin.load(mode);
            }

            if (typeof callback === 'function') {
                callback();
            }
        },

        loadMobile: function (params, callback) {
            this.load(params, callback);
        }
    };
});
