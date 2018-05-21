'use strict';
define(['jquery',
    'main/config',
    './formbuilder/tokenService',
    'main/loader',
    './formbuilder/eventListener',
    './formbuilder/filePicker'
],
    function ($, cf, tokenService, loader, eventListener, filePicker) {
        var utility;
        var initCallback;
        var settings;
        var isEnabled = false;

        var config = cf.init();

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

        function initFormBuilderServices(util, publicPath) {
            tokenService.init(util.sf);
            eventListener.init(util.sf);
            window.initFormBuilder = function initializeFormBuilder() {
                window.dnn.formBuilder.init({
                    publicPath: publicPath,
                    formTemplateChangedListener: eventListener.notifyFormTemplateChange,
                    getFormAssetFolderId: getFormAssetFolderId,
                    getToken: tokenService.getToken,
                    tokenKey: settings.tokenKey,
                    apiServiceUrl: settings.apiUrl,
                    smtpConfigured: settings.smtpConfigured,
                    libraryVersion: settings.libraryVersion,
                    loader: loader,
                    filePicker: filePicker,
                    links: {
                        termsAndConditions: settings.termsAndConditionsLink,
                        privacyPolicy: settings.privacyPolicyLink
                    },
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
            sf.moduleRoot = 'formbuilderlibrary';
            sf.controller = 'optin';
            sf.post('RequestFormBuilder', {})
                .success(success)
                .error(error);
            settings.requested = true;
        }

        function enableFeature(success, error) {
            var sf = utility.sf;
            sf.moduleRoot = 'PersonaBar';
            sf.controller = 'FormBuilder';
            sf.post('Enable', {})
                .success(function () {
                    isEnabled = true;
                    success();
                })
                .error(error);
        }

        function getFormAssetFolderId(formResponseId, fieldLabel, success, error) {
            var sf = utility.sf;
            sf.moduleRoot = 'PersonaBar';
            sf.controller = 'FormFolder';
            var _fieldLabel = encodeURI(fieldLabel);
            sf.get('GetFormAssetFolderId?formResponseId=' + formResponseId + '&fieldLabel=' + _fieldLabel, {})
                .success(function (data) {
                    if (data.FolderId !== -1) {
                        utility.loadPanel("Evoq.Assets", { folderId: data.FolderId });
                    }
                     if (typeof success === "function")
                        success(data);
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
            return settings.requested && !settings.canEnable ? "forms-wait" : "forms";
        }

        return {
            init: function (wrapper, util, params, callback) {
                initCallback = callback;
                utility = util;
                settings = params.settings;

                if (!settings) {
                    throw new Error("Form Builder settings are not defined in persona bar customSettings");
                }

                if (config.debugMode === true) {
                    window.__REACT_DEVTOOLS_GLOBAL_HOOK__ = window.parent.__REACT_DEVTOOLS_GLOBAL_HOOK__;
                }

                if (settings.enabled) {
                    var formsPublicPath = settings.uiUrl + "/dist/";
                    initFormBuilderServices(util, formsPublicPath);
                    loadScript(formsPublicPath);
                } else {
                    window.dnn.stopEscapeFromClosingPB = true;
                    var optInPublicPath = settings.optInUrl + "/dist/";
                    var mode = getOptInMode();
                    initOptInServices(optInPublicPath, mode);
                    loadScript(optInPublicPath);
                }
            },

            load: function (params, callback) {
                var fb = window.dnn.formBuilder;
                if (fb && fb.load) {
                    fb.load();
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


