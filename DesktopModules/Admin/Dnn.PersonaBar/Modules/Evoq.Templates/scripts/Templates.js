/*
DotNetNuke® - http://www.dotnetnuke.com
Copyright (c) 2002-2016
by DotNetNuke Corporation
All Rights Reserved
*/

/*
* Module responsible to manage content of the Template panel
*/
define(['jquery', 'knockout', 'knockout.mapping', 'knockout.validation.min',
    './templatesCreateManager',
    'jquery-ui.min',
    'main/koBindingHandlers/jScrollPane',
    'main/koBindingHandlers/slideToggleVisible',
	'dnn.jquery',
	'dnn.extensions',
	'dnn.jquery.extensions',
	'jquery.tokeninput',
	'dnn.jScrollBar',
	'css!./../css/templates-settings.css',
	'css!./../css/templates-hierarchy.css',
	'css!main/../css/tags-input.css',
	'css.jScrollBar'], function ($, ko, koMapping, validation, templatesCreateManager) {
    'use strict';

    var isMobile, utility, container, resx;

    var init, initMobile, load, loadMobile,
        initializeView, showTemplateList;

    isMobile = false;
    utility = null;

    ko.mapping = koMapping;

    var creationManager = templatesCreateManager;
        
    init = function (wrapper, util, params, callback) {
        utility = util;
        container = wrapper;

        if (typeof dnn === 'undefined' || typeof dnn.dnnTemplatesHierarchy === 'undefined') {
            window.Sys = !window.Sys ? window.top.Sys : window.Sys;
            window.dnn = !window.dnn ? window.top.dnn : window.dnn;
            window.String = !window.String ? window.top.String : window.String;
            window.String.format = !window.String.format ? window.top.String.format : window.String.format;
        } 
		creationManager.init(utility.sf, params, utility.resx.Templates);
		initializeView();

        if (typeof callback === 'function') callback();
    };

    initMobile = function (wrapper, util, params, callback) {
        isMobile = true;
        this.init(wrapper, util, params, callback);
    };

    load = function (params, callback) {
        creationManager.refreshConfiguration();
        
        initializeView();

        if (dnn && dnn.dnnTemplatesHierarchy) {
            dnn.dnnTemplatesHierarchy.load();
        }
    };

    loadMobile = function (params, callback) {
        isMobile = true;
        this.load(params, callback);
    };

    initializeView = function (callback) {
        setTimeout(function showTemplates() {
            showTemplateList(callback);
        }, 100); // Why 100?
    };

    showTemplateList = function (callback) {
        if (typeof dnn.dnnTemplatesHierarchy === 'undefined') {
            window.require(['main/../modules/evoq.templates/scripts/templatesHierarchy'], function () {
                dnn.dnnTemplatesHierarchy = dnn.dnnTemplatesHierarchy || {};
                dnn.dnnTemplatesHierarchy.resx = utility.resx.Templates;
                dnn.dnnTemplatesHierarchy.utility = utility;
                dnn.dnnTemplatesHierarchy._viewModel = creationManager.getViewModel();
                dnn.dnnTemplatesHierarchy.init(container, callback, creationManager.onDeleteCallback);

                $(window).trigger('resize');
            });
        } else {
            if (typeof callback === "function") {
                callback.call(dnn.dnnTemplatesHierarchy);
            }
            $(window).trigger('resize');
        }
    };

    return {
        init: init,
        load: load,
        initMobile: initMobile,
        loadMobile: loadMobile
    };
});
