define(['jquery', 'main/extension', 'main/config'], function ($, ext, cf) {
    'use strict';
    var isMobile;
    var identifier;
    var config = cf.init();
    function loadScript() {
        var url = "modules/dnn.pages/scripts/bundles/evoq-pages-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    var init = function (wrapper, util, params, callback) {
        identifier = params.identifier;
        window.dnn.initEvoqPages = function initEvoqPages() {
            if (typeof callback === 'function') {
                callback(wrapper);
            }

            return {
                utilities: util,
                moduleName: "EvoqPages",
                config: config
            };
        };

        loadScript();

        window.dnn.pages.setItemTemplate("evoq-pages-list-item-template");
        window.dnn.pages.setDragItemTemplate("evoq-pages-drag-item-template");
        if (window.dnn.pages.pageHierarchyManager &&
            window.dnn.pages.pageHierarchyManager._initialized) {
            window.dnn.pages.pageHierarchyManager._resizeContentContainer(true);
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
