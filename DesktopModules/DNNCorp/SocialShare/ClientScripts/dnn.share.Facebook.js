// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};

(function(dnn) {
    'use strict';

    dnn.share.facebookInitialize = function(appId) {
        if (typeof dnn.share.facebookInitialized !== 'undefined') {
            return null;
        }

        if (typeof FB === 'undefined') {
            return null;
        }

        if (!appId) return null;

        dnn.share.facebookInitialized = true;
        
        FB.init({
            appId: appId,
            status: true,
            cookie: true,
            xfbml: true,
            oauth: true
        });
    };
})(window.dnn);