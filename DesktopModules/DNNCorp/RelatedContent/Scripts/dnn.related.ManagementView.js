// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.ManagementView = function ManagementView ($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.componentFactory = this.social.getComponentFactory();

        this.localizer = this.social.getLocalizationController();

        var searchController = new dnn.related.SearchController($, ko, settings, this.social);

        this.componentFactory.register(searchController);
        
        this.componentFactory.register(new dnn.related.ContentTypesFilter($, ko, settings, this.social));

        var pager = this.social.getPagingControl('SearchController');
        if (pager != null) {
            pager.page.subscribe(searchController.load);
        }

        this.componentFactory.register(pager);
        
        this.pagingControl = ko.computed(
            function () {
                var pagingControl = that.componentFactory.resolve('PagingControl');
                if (pagingControl != null) {
                    return pagingControl.markup();
                }

                return new String();
            });

        this.load = function () {
            searchController.clear();
            searchController.loadStart();
        };
    };
})(window.dnn);