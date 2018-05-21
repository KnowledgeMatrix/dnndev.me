// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.answers === 'undefined') dnn.answers = {};

(function (dnn, $, ko) {
    dnn.answers.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        this.register(this, 'PrimaryView');
        this.register(new dnn.answers.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }
        this.init();
    };

    try{
        dnn.answers.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.answers.ListView.prototype.init = function () {

        this.sortOptions = [
            { value: 'votes', text: this.getString('SortByMostVotes') },
            { value: 'answers', text: this.getString('SortByMostAnswers') },
            { value: 'lastactive', text: this.getString('SortByRecentActivity') },
            { value: 'createddate', text: this.getString('SortByDateCreated') },
            { value: 'views', text: this.getString('SortByViews') },
            { value: 'title', text: this.getString('SortByTitle') }
        ];
        
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.answers.ListView.prototype.validateCategory = function (c) {
        if (c === 'myquestions' || c === 'myanswers')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

})(window.dnn, window.jQuery, window.ko);