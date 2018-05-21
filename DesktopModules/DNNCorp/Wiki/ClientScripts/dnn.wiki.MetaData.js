// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function(dnn) {
    'use strict';

    dnn.wiki.MetaData = function MetaData(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);

        var componentFactory = social.getComponentFactory();

        var controller = componentFactory.register(new dnn.wiki.MetaDataController(settings, social));

        this.image = ko.observable();

        this.caption = ko.observable();

        this.metadata = ko.observable();
        
        var pattern = new RegExp();
        pattern.compile(/[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi);

        this.metaValue = function (value) {
            var localizer = social.getLocalizationController();
            
            if (value == 'True') {
                return localizer.getString('Yes');
            } else if (value == 'False') {
                return localizer.getString('No');
            } else {
                return that.replaceUrls(value);
            }
        };

        this.replaceUrls = function (s) {
            return s.replace(pattern, "<a href='$&' class='dnnSocialLink'>$&</a>");
        };

        this.load = function () {
            var success = function (image, m) {
                if ($(settings.moduleScope).is(':visible') == false) {
                    $(settings.moduleScope).fadeIn('fast');
                }

                that.image(image);

                that.metadata(dnn.social.komodel(m));
            };

            var failure = function (xhr, status) {
                if (typeof settings.canModerate !== 'boolean' || !settings.canModerate) {
                    $(settings.moduleScope).hide();
                }

                that.image(undefined);
                that.metadata(undefined);
            };

            var loading = function (b) {
                if (b) {
                    $(settings.moduleScope).addClass('loading');
                } else {
                    $(settings.moduleScope).removeClass('loading');
                }
            };

            controller.load(success, failure, loading);
        };

        this.bindControls = function() {
            that.load();

            dnn.social.ipc.register(settings, function(source, msg) {
                switch (msg.event) {
                    case 'LoadMetadata':
                        that.load();
                        break;
                    case 'ViewSwitched':
                        if (msg.isMobileView) {
                            $(settings.moduleScope).hide();
                        } else {
                            $(settings.moduleScope).show();
                        }
                        break;
                }
            });
        };

        this.binded = function() {
            this.bindControls();
        };
    };
})(window.dnn);
