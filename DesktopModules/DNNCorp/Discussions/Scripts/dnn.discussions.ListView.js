// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.discussions === 'undefined') dnn.discussions = {};

(function (dnn, $, ko) {
    'use strict';
    dnn.discussions.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        this.register(this, 'PrimaryView');
        this.register(new dnn.discussions.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }
        this.init();
    };

    try{
        dnn.discussions.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.discussions.ListView.prototype.init = function () {
        
        this.sortOptions = [
             { value: 'lastactive', text: this.getString('SortByActivity') },
             { value: 'createddate', text: this.getString('SortByCreatedDate') },
             { value: 'author', text: this.getString('SortByAuthor') },
             { value: 'title', text: this.getString('SortByTitle') },
             { value: 'views', text: this.getString('SortByViews') }
        ];
     
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.discussions.ListView.prototype.validateCategory = function (c) {
        if (c === 'mycontentitems' || c === 'mycomments')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

})(window.dnn, window.jQuery, window.ko);
