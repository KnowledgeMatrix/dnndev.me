// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.EditorView = function EditorView($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.manage = function () {
            var control = $('.related-content-edit');
            
            var localizer = that.social.getLocalizationController();

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: localizer.getString('ManageRelatedContent'),
                minWidth: 950,
                resizable: false,
                buttons: [
                    {
                        priority: 'primary',
                        'class': 'dnnPrimaryAction',
                        text: localizer.getString('OK'),
                        click: that.cancel
                    }
                ]
            };

            control.dialog(options);

            var cf = ko.contextFor($('.related-content-edit > div')[0]);
            if (cf != null) {
                var root = cf.$root;
                if (root != null) {
                    root.load();
                }
            }
        };

        this.cancel = function () {
            var control = $('.related-content-edit');

            control.dialog('close');

            window.location.reload();
        };
    };
})(window.dnn);