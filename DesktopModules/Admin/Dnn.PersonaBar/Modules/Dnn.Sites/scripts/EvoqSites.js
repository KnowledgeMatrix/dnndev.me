'use strict';
define(['jquery', 'main/config', './sites.thumbnails',
    './exportables/Sites/SitesListView'
], function ($, cf, siteThumbnails) {
    var utility;
    var config = cf.init();

    function loadScript() {
        var url = "modules/dnn.sites/scripts/bundles/evoqsites-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    return {
        init: function (wrapper, util, params, callback) {
            window.dnn.initSites = function initializeSites() {
                return {
                    siteThumbnails: siteThumbnails,
                    params: params
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


