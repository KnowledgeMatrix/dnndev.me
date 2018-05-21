// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function (dnn) {
    'use strict';

    dnn.wiki.Revisions = function Revisions(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);

        this.mutedData = function () {
            var subcontext = window.ko.contextFor($(settings.changeScope)[0]).$root;
            if (subcontext == null) {
                return false;
            }

            if (typeof subcontext.mutedData === 'function') {
                return subcontext.mutedData();
            } else if (typeof subcontext.mutedData !== 'undefined') {
                return subcontext.mutedData;
            }

            return false;
        };

        this.history = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
            that.dialog();
            return false;
        };

        this.dialog = function () {
            var subcontext = window.ko.contextFor($(settings.changeScope)[0]).$root;
            if (subcontext == null) {
                return;
            }

            var localizer = social.getLocalizationController();
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                closeOnEscape: false,
                title: localizer.getString('History'),
                resizable: false,
                minWidth: 625,
                buttons:
                [
                    {
                        priority: 'secondary',
                        'class': 'dnnPrimaryAction',
                        text: localizer.getString('OK'),
                        click: that.close
                    }
                ]
            };
            subcontext.moderator(settings.moderator || false); // in case undefined
            subcontext.modal(true);
            subcontext.bindControls();
            $(settings.moduleScope).dialog(options);
        };

        this.close = function () {
            $(settings.moduleScope).dialog('close');

            if (that.mutedData()) {
                dnn.social.EventQueue.push(
                    function () {
                        window.location.reload(); // due to changes
                    });
            }
        };
    };
})(window.dnn);