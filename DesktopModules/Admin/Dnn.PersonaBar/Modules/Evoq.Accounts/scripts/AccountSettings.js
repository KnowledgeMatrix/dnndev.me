define(['jquery', 'main/extension'], function ($, ext) {
    'use strict';
    var identifier;

    var init = function (wrapper, util, params, callback) {
        identifier = params.identifier;

        if (typeof callback === 'function') {
            callback();
        }
    };

    var load = function (params, callback) {
        if (typeof callback === 'function') {
            callback();
        }
    };

    return {
        init: init,
        load: load
    };
});
