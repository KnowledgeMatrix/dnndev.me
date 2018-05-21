// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.CompactView = function CompactView($, ko, settings) {
        var that = this;
        
        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.profile = new dnn.status.Profile($, ko, settings, this.social);

        var componentFactory = this.social.getComponentFactory();

        componentFactory.register(this, 'PrimaryView');
        componentFactory.register(this.profile);
        componentFactory.register(new dnn.status.SharedView($, ko, settings, this.social));

        this.service = this.social.getService('Collection');

        this.builtins = ko.observableArray([]);

        this.collections = ko.observableArray([]);

        this.loading = function (b) {
            var control = $('.status-collections-container', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.loadCollections = function () {
            var failure = function () {};

            var success = function (collections) {
                var b = [];
                var c = [];

                $.each(collections,
                    function (index, collection) {
                        if (collection.builtin) {
                            b.push(new dnn.status.Collection($, ko, settings, that.social, collection));
                        }
                        else {
                            c.push(new dnn.status.Collection($, ko, settings, that.social, collection));
                        }
                    });

                that.builtins(b);
                
                that.collections(c);
            };

            that.service.get('GetCollectionList', undefined, success, failure, that.loading);
        };

        this.editProfile = function () {
            that.profile.editProfile();
        };
        
        if (!settings.anonymous) {
            this.loadCollections();
        }
    };
})(window.dnn);