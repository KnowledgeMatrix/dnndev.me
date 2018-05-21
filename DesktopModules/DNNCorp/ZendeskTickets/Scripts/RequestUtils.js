window.dnn = dnn || {};
window.dnn.modules = dnn.modules || {};
window.dnn.modules.zendesktickets = dnn.modules.zendesktickets || {};

window.dnn.modules.zendesktickets.RequestUtils =
(function($) {
    "use strict";
    
    // private vars
    var serviceFramework, moduleId;

    // private methods
    var showError = function (xhr) {
        var r = JSON.parse(xhr.responseText);
        var message = "";

        if (xhr.status === 400) {
            for (var i = 0; i < r.length; i++) {
                message += r[i].ErrorMessage + "<br />";
            }
        } else {
            message = r.Message;
        }

        $.dnnAlert({
            title: "An error has occurred",
            text: message
        });
    };

    var init = function (moduleIdentifier) {
        serviceFramework = $.dnnSF.call(this, moduleIdentifier);
        moduleId = moduleIdentifier;
    };

    var getServiceUrl = function (serviceName, controller) {
        return serviceFramework.getServiceRoot(serviceName) + controller + "/";
    };

    var request = function (serviceName, controller, method, type, params, callback, errorCallBack, completeCallback, sync) {
        $("body").addClass('loading');

        $.ajax({
            url: getServiceUrl(serviceName, controller) + method,
            type: type,
            data: params,
            async: !sync,
            beforeSend: serviceFramework.setModuleHeaders,
            success: function(data) {
                if (typeof callback == "function") {
                    callback(data);
                }
            },
            error: function (xhr) {
                if (typeof errorCallBack == "function") {
                    errorCallBack(xhr);
                } else {
                    showError(xhr);
                }
            },
            complete: function(xhr, status) {
                $("body").removeClass('loading');

                if (typeof completeCallback == "function") {
                    completeCallback(xhr, status);
                }
            }
        });
    };

    var fileRequest = function (serviceName, controller, method, type, params, callback, errorCallBack, completeCallback, sync) {
        $("body").addClass('loading');

        $.ajax({
            url: getServiceUrl(serviceName, controller) + method,
            type: type,
            contentType: false,
            processData: false,
            cache: false,
            data: params,
            async: !sync,
            beforeSend: serviceFramework.setModuleHeaders,
            success: function (data) {
                if (typeof callback == "function") {
                    callback(data);
                }
            },
            error: function (xhr) {
                if (typeof errorCallBack == "function") {
                    errorCallBack(xhr);
                } else {
                    showError(xhr);
                }
            },
            complete: function (xhr, status) {
                $("body").removeClass('loading');

                if (typeof completeCallback == "function") {
                    completeCallback(xhr, status);
                }
            }
        });
    };

    return {
        request: request,
        fileRequest: fileRequest,
        init: init
    }

}(jQuery || $));