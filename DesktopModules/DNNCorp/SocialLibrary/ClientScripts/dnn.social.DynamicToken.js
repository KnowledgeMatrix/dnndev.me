// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function () {
    'use strict';
    dnn.social.DynamicToken = function() {
        // constructor...
    };

    dnn.social.DynamicToken.prototype.init = function() {
        if (!window.globalActivityStreamListView) return;
        window.globalActivityStreamListView.dynamicPlugins = window.globalActivityStreamListView.dynamicPlugins || [];
        var plugin = this.getPlugin();
        if (plugin && typeof plugin.init === 'function') {
            window.globalActivityStreamListView.dynamicPlugins.push(plugin);
        }
    };
    
    dnn.social.DynamicToken.prototype.apiCall = function (httpMethod,
        method, params, onsuccess, onfailure, synchronous) {
        if (!this.serviceRoot || !this.settings) return null;
        var service = $.ServicesFramework(this.settings.moduleId);
        var beforeCallback = service.setModuleHeaders;
        var options = {
            url: '{0}{1}'.format(this.serviceRoot, method),
            beforeSend: beforeCallback,
            type: httpMethod,
            async: synchronous == false,
            success: function (d) {
                if (typeof onsuccess === 'function') {
                    onsuccess(d || {});
                }
                return true;
            },
            error: function (xhr, status) {
                if (typeof onfailure === 'function') {
                    onfailure(xhr, status);
                } else {
                    $.dnnAlert({
                        title: "Error",
                        text: xhr.responseText || 'A fatal error has occurred.'
                    });
                }
                return false;
            }
        };

        if (httpMethod == 'GET') {
            options.data = params;
        } else {
            options.contentType = 'application/json; charset=UTF-8';
            options.data = ko.toJSON(params);
            options.dataType = 'json';
        }
        return $.ajax(options);
    };
    
})();