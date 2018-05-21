'use strict';
define(['jquery',
    'main/config',
    'main/loader',
    './content/tokenService',
    './content/eventListener',
    './content/filePicker',
    './content/imagesService'
],

function ($, cf, loader, tokenService, eventListener, filePicker, imagesService) {
    var initCallback;
    var utility;
    var settings;
    var config = cf.init();
    var isEnabled = false;

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
        eventListener.init(util.sf);
        imagesService.init(util.sf);

        window.initStructuredContent = function initializeStructuredContent() {
            window.dnn.structuredContent.init({
                publicPath: publicPath,
                contentItemChangedListener: eventListener.notifyContentItemChange,
                contentTypeChangedListener: eventListener.notifyContentTypeChange,
                visualizerChangedListener: eventListener.notifyVisualizerChange,
                getToken: tokenService.getToken,
                tokenKey: settings.tokenKey,
                apiServiceUrl: settings.apiUrl,
                multichannelPublishingApiServiceUrl: settings.multichannelPublishingApi,
                libraryVersion: settings.libraryVersion,
                canManageContentTypes: config.isContentManager,
                canManageApiKeys: settings.canManageApiKeys,
                config: config,
                assets: {
                    imageEditing: {
                        proxyImage: imagesService.proxyImage,
                        saveImage: imagesService.saveImage,
                        thumbnailService: config.siteRoot + "dnnimagehandler.ashx?mode=file&size=xxl&url="
                    }
                },
                loader: loader,
                filePicker: filePicker,
                notifier: {
                    confirm: util.confirm,
                    notify: util.notify,
                    notifyError: util.notifyError
                }
            });
            
            if (typeof initCallback === 'function') {
                initCallback();
            }
        }
    }

    function requestFeature(success, error) {
        var sf = utility.sf;
        sf.moduleRoot = 'structuredcontentlibrary';
        sf.controller = 'optin';
        sf.post('RequestStructuredContent', {})
            .success(success)
            .error(error);
        settings.requested = true;
    }

    function enableFeature(success, error) {
        var sf = utility.sf;
        sf.moduleRoot = 'PersonaBar';
        sf.controller = 'StructuredContent';
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
        return settings.requested && !settings.canEnable ? "content-wait" : "content";
    }

    return {
        init: function (wrapper, util, params, callback) {
            initCallback = callback;
            utility = util;
            settings = params.settings;

            if (!settings) {
                throw new Error("Structured Content settings are not defined in persona bar customSettings");
            }

            if (config.debugMode === true) {
                window.__REACT_DEVTOOLS_GLOBAL_HOOK__ = window.parent.__REACT_DEVTOOLS_GLOBAL_HOOK__;
            }

            if (settings.enabled) {
                var contentPublicPath = settings.uiUrl + "/dist/";
                initContentServices(util, contentPublicPath);
                loadScript(contentPublicPath);
            } else {
                window.dnn.stopEscapeFromClosingPB = true;
                var optInPublicPath = settings.optInUrl + "/dist/";
                var mode = getOptInMode();
                initOptInServices(optInPublicPath, mode);
                loadScript(optInPublicPath);
            }
        },

        load: function (params, callback) {
            var sc = window.dnn.structuredContent;
            if (sc && sc.load) {
                sc.load();
            }
            var optin = window.dnn.optIn;
            if (optin && optin.load) {
                var mode = getOptInMode();
                optin.load(mode);
            }

            if (typeof callback === 'function') {
                callback();
            }
        }
    };
});
