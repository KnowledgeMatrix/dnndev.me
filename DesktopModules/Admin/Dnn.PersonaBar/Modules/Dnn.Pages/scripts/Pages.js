define(['jquery', 'knockout', 'main/extension', 'main/config', './viewModelExtension', 'jquery-ui.min', 'dnn.jquery', './pages.thumbnails'],
    function ($, ko, ext, cf, viewModelExtension) {
    'use strict';
    window.ko = ko;

    var isMobile;
    var config = cf.init();
    function loadScript() {
        var url = "modules/dnn.pages/scripts/bundles/pages-bundle.js";
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }
    var init = function (wrapper, util, params, callback) {
	
        window.dnn.pages = window.dnn.pages || {};
        window.dnn.pages.apiController = "EvoqPages";
        window.dnn.pages.viewModelExtension = viewModelExtension;
        window.dnn.pages.pageHierarchyManagerOptions = {
            onRefresh: function (panel) {
                dnn.dnnPageThumbnails.init(panel);
                dnn.dnnPageThumbnails.updateThumbnails();
            },
            onUnload: function(panel) {
                dnn.dnnPageThumbnails.init(panel);
                dnn.dnnPageThumbnails.removeThumbnailLoader();
            }
        };
        
        $.extend(util.resx.Pages, util.resx.EvoqPages);
        window.dnn.initPages = function initializePages() {
            if (typeof callback === 'function') {
                callback();
            }

            return {
                utilities: util,
                moduleName: "Pages",
                config: config,
                viewName: params.viewName,
                viewParams: params.viewParams,
                settings: params.settings
            };
        };
        loadScript();
    };

    var initMobile = function (wrapper, util, params, callback) {
        isMobile = true;
        this.init(wrapper, util, params, callback);
    };

    var load = function (params, callback) {
        window.dnn.pages.load({
            viewName: params.viewName,
            viewParams: params.viewParams,
            settings: params.settings
        });
		if (window.dnn.pages.pageHierarchyManager &&
            window.dnn.pages.pageHierarchyManager._initialized) {
            window.dnn.pages.pageHierarchyManager._resizeContentContainer(true);
        }
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
