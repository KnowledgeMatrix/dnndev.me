define(['jquery', 'main/extension', 'main/config'], function ($, ext, cf, slv) {
    'use strict';
    var isMobile;
    var identifier;
    var config = cf.init();
    function loadScript() {
        var url = "modules/evoq.servers/scripts/bundles/evoq-servers-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }
    var init = function (wrapper, util, params, callback) {
        identifier = params.identifier;
        window.dnn.initEvoqServers = function initEvoqServers() {
            if (typeof callback === 'function') {
                callback(wrapper);
            }
            return {
                utilities: util,
                moduleName: "EvoqServers",
                config: config
            };
        };
        loadScript();
        if (config.debugMode === true) {
            window.__REACT_DEVTOOLS_GLOBAL_HOOK__ = window.parent.__REACT_DEVTOOLS_GLOBAL_HOOK__;
        }
    };

    var initMobile = function (wrapper, util, params, callback) {
        isMobile = true;
        this.init(wrapper, util, params, callback);
    };

    var load = function (params, callback) {
        if (typeof callback === 'function') {
            callback();
        }
    };

    var loadMobile = function (params, callback) {
        isMobile = true;
        this.load(params, callback);
    };

    return {
        init: init,
        load: load,
        initMobile: initMobile,
        loadMobile: loadMobile
    };
});
