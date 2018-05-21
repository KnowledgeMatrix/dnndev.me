define(['jquery', 'main/extension'], function ($, ext) {
    'use strict';
    var identifier;

    var init = function (wrapper, util, params, callback) {
        identifier = params.identifier;

        var $panel = $('#' + util.getPanelIdFromPath(params.path));
        $panel.on('init.extension', function() {
            $('#communityanalytics-extensions > div').eq(0).addClass('selected');
        });

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
