// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.ContentTypesFilter = function ContentTypesFilter ($, ko, settings, social) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.contentTypes = ko.observableArray([]);

        this.load = function () {
            var search = componentFactory.resolve('SearchController');
            if (search != null) {
                search.loadStart();
            }
        };

        this.bindControls = function () {
            that.control = $('.related-content-types-input', settings.moduleScope);

            var localizer = social.getLocalizationController();
            if (localizer == null) {
                return null;
            }

            var options = {
                theme: 'facebook',
                minChars: 0,
                preventDuplicates: true,
                hintText: new String(),
                noResultsText: localizer.getString('NoResults'),
                searchingText: localizer.getString('Searching'),
                onAdd:
                    function (item) {
                        that.contentTypes.push(item.id);
                        that.load();
                    },
                onDelete:
                    function (item) {
                        var index = $.inArray(item.id, that.contentTypes());
                        if (index >= 0) {
                            that.contentTypes.splice(index, 1);
                        }

                        that.load();
                    },
                onError:
                    function () {
                    },
                resultsFormatter:
                    function (item) {
                        return "<li class='contentType'><span>" + item.name + '</span></li>';
                    }
            };

            var service = social.getService('Related');

            var query = '{0}GetContentTypes'.format(service.getRoot());

            that.control.tokenInput(query, options);
        };

        dnn.social.EventQueue.push(
            function () {
                that.bindControls();
            });
    };
})(window.dnn);