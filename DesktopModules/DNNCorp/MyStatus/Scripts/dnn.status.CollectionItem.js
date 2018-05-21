// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.CollectionItem = function CollectionItem($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));
    };
})(window.dnn);