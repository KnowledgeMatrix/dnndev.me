define(['jquery', 'main/extension', 'main/config'], function ($, ext, cf, slv) {
    'use strict';
    var isMobile;
    function loadScript() {
        if (window.dnn.siteImportExport) {
            window.dnn.siteImportExport.registerItemToExport({
                name: "Content Library",
                category: "ContentLibrary",
                defaultSelected: true
            });
        }
    }
    var init = function (wrapper, util, params, callback) {
        loadScript();
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

