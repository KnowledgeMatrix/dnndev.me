define(['jquery', 'main/config'], function formBuilderStructuredContentConnector($, cf) {
        'use strict';

        var config = cf.init();
        var connectorSettings = null;
        var sf = null;

        function getBundleLanguage(culture) {
            var fallbackLanguage = "en";
            var availableLanguages = ["en"];
            return availableLanguages.indexOf(culture) > 0 ? culture : fallbackLanguage;
        }

        function loadScript(basePath) {
            var normalizedCulture = config.culture.split("-")[0];
            var language = getBundleLanguage(normalizedCulture);
            var url = basePath + "/dist/bundle-" + language + ".js";
            $.ajax({
                dataType: "script",
                cache: true,
                url: url
            });
        }
    
        function getToken(success, error, forceNewToken) {
            if (!sf) {
                throw new Error('Service Framework is not defined');
            }
            sf.moduleRoot = 'formbuilderstructuredcontentconnector';
            sf.controller = 'authorization';
            sf.post('GetAuthorizationToken', { forceNewToken: forceNewToken })
                .success(function onSuccess(data) {
                    var token = data.token;
                    success(token);
                })
                .error(function onError(err) {
                    error(err);
                });
        }

        function init(wrapper, util, params, callback) {
            sf = util.sf;

            connectorSettings = params.settings;
            if (!connectorSettings) {
                throw new Error("Form Builder / Structured Content connector settings are not defined in persona bar customSettings");
            }

            if (connectorSettings.isStructuredContentEnabled) {
                var connectorOptions = {};
                connectorOptions.getToken = getToken;
                connectorOptions.tokenKey = connectorSettings.tokenKey;
                connectorOptions.endpoints = {
                    structuredContentEndPointUrl: connectorSettings.structuredContentApiUrl,
                    connectorEndPointUrl: connectorSettings.apiUrl
                }
                window.dnn.formBuilderStructuredContentConnector = {
                    init: function initHandler() {
                        var connector = window.dnn.formBuilderStructuredContentConnector.getConnector(connectorOptions);
                        window.dnn.formBuilder.registerConnector(connector);
                    },
                    getConnector: function getConnectorHandler() {
                        throw new Error("this function needs to be overridden by the connector script");
                    }
                };
                loadScript(connectorSettings.uiUrl);
            }

            if (typeof callback === 'function') {
                callback(wrapper);
            }
        }

        function load(params, callback) {
            if (typeof callback === 'function') {
                callback();
            }
        }

        return {
            init: init,
            load: load,
            initMobile: init,
            loadMobile: load
        };
    });