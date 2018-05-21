define(function () {
    'use strict';
    var sf;
    var siteImageRoot;

    function getService () {
        sf.moduleRoot = "DNNCorp/EvoqLibrary";
        sf.controller = "Redactor";

        return sf;
    }
	
	function getServiceRoot(){
		return getService().getServiceRoot();
	}
    
    function processFileLink(fileLink) {
        var regex = /\?ver.*/g;
        fileLink = fileLink.replace(regex, "");

        var absolutePathRegex = new RegExp('^(?:[a-z]+:)?//', 'i');
        if (absolutePathRegex.test(fileLink)) {
            return fileLink;
        }

        var origin = window.location.origin || window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
        
        return origin + fileLink;
    }

    return {
        init: function init(serviceFramework) {
            sf = serviceFramework;
        },
        saveImage: function saveImage(image, actions, successCallback, errorCallback) {
            var data = {
                image: image.attr("src").replace("data:image/png;base64,", ""),
                name: image.data("name"),
                actions: actions
            };

            function onSuccessCallback(data) {
                if (data.success) {
                    data.filelink = processFileLink(data.filelink);
                    successCallback(data);
                } else {
                    errorCallback(data.message);
                }
            }

            getService().post('SaveImageStream', data, onSuccessCallback, errorCallback);
        },
        proxyImage: function proxyImage(imageUrl) {
            return getServiceRoot() + 'Redactor/ProxyImage?imageUrl=' + encodeURIComponent(imageUrl);
        }
    }
});
