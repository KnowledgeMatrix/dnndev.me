'use strict';
define(['jquery',
        'main/config',
        'main/loader',
        './siteanalytics/tokenService'
],
function ($, cf, loader, tokenService) {
    var initCallback;
    var utility;
    var settings;
    var config = cf.init();
    var isEnabled = false;

    function loadScript(basePath) {
        var h = window.location.protocol + "//" + window.location.host;
		var path = decodeURIComponent(settings.currentUrl).substring(h.length);
        var url = basePath + "evoqanalytics.js?accountcode=" + settings.accountCode + "&path=" + path;
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    function getBundleLanguage(culture) {
        var fallbackLanguage = "en";
        var availableLanguages = ["en"];
        return availableLanguages.indexOf(culture) > 0 ? culture : fallbackLanguage;
    }

    function loadOptInScript(basePath) {
        var normalizedCulture = config.culture.split("-")[0];
        var language = getBundleLanguage(normalizedCulture);
        var url = basePath + "/bundle-" + language + ".js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    function initSiteAnalytics(util, publicPath) {
        tokenService.init(util.sf);

        window.initSiteAnalytics = function initializeSiteAnalytics() {
            window.dnn.cloudAnalytics.init({
                publicPath: publicPath,
                getToken: tokenService.getToken,
                tokenKey: settings.tokenKey,
                apiServiceUrl: settings.apiUrl,
                libraryVersion: settings.libraryVersion,
                loader: loader,
                notifier: {
                    confirm: util.confirm,
                    notify: util.notify,
                    notifyError: util.notifyError
                }
            });
        }
    }

    function requestFeature(success, error) {
        var sf = utility.sf;
        sf.moduleRoot = 'AnalyticsLibrary';
        sf.controller = 'OptIn';
        sf.post('RequestAnalytics', {})
            .success(success)
            .error(error);
        settings.requested = true;
    }

    function enableFeature(success, error) {
        var sf = utility.sf;
        sf.moduleRoot = 'PersonaBar';
        sf.controller = 'Analytics';
        sf.post('Enable', {})
            .success(function () {
                isEnabled = true;
                success();
            })
            .error(error);
    }

    function closeModal() {
        window.dnn.stopEscapeFromClosingPB = false;
        if (isEnabled) {
            window.parent && window.parent.location.reload();
        } else {
            utility.closePersonaBar();
        }
    }

    function initOptInServices(publicPath, mode) {
        window.initOptIn = function initializeOptIn() {
            window.dnn.optIn.init({
                publicPath: publicPath,
                mode: mode,
                canEnable: settings.canEnable,
                enableFeature: settings.canEnable ? enableFeature : requestFeature,
                closeModal: closeModal
            });

            if (typeof initCallback === 'function') {
                initCallback();
            }
        }
    }

    function getOptInMode() {
        return settings.requested && !settings.canEnable ? "site-analytics-wait" : "site-analytics";
    }

    return {
        init: function (wrapper, util, params, callback) {
            initCallback = callback;
            utility = util;
            settings = params.settings;

            if (!settings) {
                throw new Error("Analytics settings are not defined in persona bar customSettings");
            }

            if (settings.enabled) {
                var analyticsPublicPath = settings.uiUrl + "/dist/";
                initSiteAnalytics(util, analyticsPublicPath);
                loadScript(analyticsPublicPath);
            } else {
                window.dnn.stopEscapeFromClosingPB = true;
                var optInPublicPath = settings.optInUrl + "/dist/";
                var mode = getOptInMode();
                initOptInServices(optInPublicPath, mode);
                loadOptInScript(optInPublicPath);
            }

            if (typeof callback === 'function') {
                callback();
            }
        },

        initMobile: function (wrapper, util, params, callback) {
            this.init(wrapper, util, params, callback);
        },

        load: function (params, callback) {
            var analytics = window.dnn.SiteAnalytics;
            if (analytics && analytics.load) {
                analytics.load();
            }
            /*
            var optin = window.dnn.optIn;
            if (optin && optin.load) {
                var mode = getOptInMode();
                optin.load(mode);
            }
            */
            if (typeof callback === 'function') {
                callback();
            }
        },

        loadMobile: function (params, callback) {
            this.load(params, callback);
        }
    };
});
