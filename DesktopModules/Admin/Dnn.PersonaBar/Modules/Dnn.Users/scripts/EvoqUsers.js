'use strict';
define(['jquery', 'main/extension', 'main/config', './exportables/Users/UsersCommon'], function ($, ext, cf) {
    var utility;
    var config = cf.init();

    function loadScript() {
        var url = "modules/dnn.users/scripts/bundles/evoqusers-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    return {
        init: function (wrapper, util, params, callback) {
            utility = util;
            window.dnn.initUsers = function initializeUsers() {
                return {
                    utility: utility,
                    settings: params.settings,
                    moduleName: 'EvoqUsers'
                };
            };
            loadScript();

            if (config.debugMode === true) {
                window.__REACT_DEVTOOLS_GLOBAL_HOOK__ = window.parent.__REACT_DEVTOOLS_GLOBAL_HOOK__;
            }

            if (typeof callback === 'function') {
                callback();
            }
        },

        initMobile: function (wrapper, util, params, callback) {
            this.init(wrapper, util, params, callback);
        },

        load: function (params, callback) {
            if (typeof callback === 'function') {
                callback();
            }
        },

        loadMobile: function (params, callback) {
            this.load(params, callback);
        }
    };
});


