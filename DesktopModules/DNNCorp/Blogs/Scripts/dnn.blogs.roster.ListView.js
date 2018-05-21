// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};
if (typeof dnn.blogs.roster === 'undefined') dnn.blogs.roster = {};

(function (dnn, $, ko) {
    'use strict';
    dnn.blogs.roster.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        this.register(this, 'PrimaryView');
        this.register(new dnn.blogs.roster.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }
        this.init();
    };

    try{
        dnn.blogs.roster.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.blogs.roster.ListView.prototype.init = function () {
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.blogs.roster.ListView.prototype.prev = function () {
        var pager = this.componentFactory.resolve('PagingControl');
        if (pager.page() > 0) {
            pager.page(pager.page() - 1);
        }
        pager.setStart(pager.page());
        this.componentFactory.resolve('ListController').loadData();
    };

    dnn.blogs.roster.ListView.prototype.next = function () {
        var pager = this.componentFactory.resolve('PagingControl');
        if (pager.page() + 1 < pager.totalPages()) {
            pager.page(pager.page() + 1);
        }
        pager.setStart(pager.page());
        this.componentFactory.resolve('ListController').loadData();
    };
   

})(window.dnn, window.jQuery, window.ko);