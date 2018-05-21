// DotNetNuke® - http://www.dotnetnuke.com
// Copyright (c) 2002-2013
// by DotNetNuke Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};

(function (dnn, $, ko) {
    dnn.blogs.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        dnn.social.ipc.register(this.settings, $.proxy(function (source, message) {
            if (message.event === 'SelectedDate') {
                var selectedDate = message.selectedDate;
                var controller = this.listController();
                if (controller) {
                    controller.frozen(true);
                    controller.category('daterange');
                    var pager = this.pager();
                    if (pager) {
                        pager.page(0);
                    }
                    controller.selectedDate = selectedDate;
                    controller.frozen(false);
                    controller.loadStart();
                }
            }
        }, this));
        
        this.register(this, 'PrimaryView');
        this.register(new dnn.blogs.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, []));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }

        this.init();
    };

    try{
        dnn.blogs.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.blogs.ListView.prototype.init = function () {
        this.blogTitle = this.settings.blogTitle;
        this.blogId = this.settings.blogId;
        this.noRecordsMsg = this.settings.noRecordsMsg;
        this.selectedBlog = ko.observable();
        
        this.sortOptions = [
             { value: 'lastactive', text: this.getString('SortByActivity') },
             { value: 'createddate', text: this.getString('SortByCreatedDate') },
             { value: 'author', text: this.getString('SortByAuthor') },
             { value: 'title', text: this.getString('SortByTitle') },
             { value: 'views', text: this.getString('SortByViews') }
        ];
        
        dnn.social.ListView.prototype.init.apply(this);
    };

    dnn.blogs.ListView.prototype.validateCategory = function (c) {
        if (c === 'myentries' || c === 'mycomments')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

    dnn.blogs.ListView.prototype.addNewBlog = function () {
        var self = this;
        var sf = $.ServicesFramework(this.settings.moduleId);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('DNNCorp/Blogs') + "ListView/" + "GetBlog",
            beforeSend: sf.setModuleHeaders,
            data: { blogId: 0 },
            cache: false
        }).done(function (response) {
            self.selectedBlog(dnn.social.komodel(response));
            var localizer = self.localizer();
            var title = localizer.getString("CreateBlog");
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: title,
                minWidth: 600,
                minHeight: 300,
                closeOnEscape: false,
                resizable: false,
                open: $.ui.dialog.prototype.options.open,
                close: $.ui.dialog.prototype.options.close,
            };
            $('.editor-dialog').dialog(options);
        });
        
        return true;
    };
    
    dnn.blogs.ListView.prototype.blogEdit = function () {
        var self = this;
        var sb = this.blogId;
        if (!sb) return true;
        var sf = $.ServicesFramework(this.settings.moduleId);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('DNNCorp/Blogs') + "ListView/" + "GetBlog",
            beforeSend: sf.setModuleHeaders,
            data: { blogId: sb },
            cache: false
        }).done(function (response) {
            self.selectedBlog(dnn.social.komodel(response));
            var localizer = self.localizer();
            var title = localizer.getString("EditBlogSettings");
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: title,
                minWidth: 600,
                minHeight: 300,
                closeOnEscape: false,
                resizable: false
            };
            $('.editor-dialog').dialog(options);
        });
        return true;
    };
    
    dnn.blogs.ListView.prototype.addNewBlogMobileView = function () {
        var self = this;
        var sf = $.ServicesFramework(this.settings.moduleId);
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('DNNCorp/Blogs') + "ListView/" + "GetBlog",
            beforeSend: sf.setModuleHeaders,
            data: { blogId: 0 },
            cache: false
        }).done(function (response) {
            self.selectedBlog(dnn.social.komodel(response));
            var localizer = self.localizer();
            var options = dnn.social.MobileView.dialogOptions({
                title: localizer.getString('CreateBlog')
            });
            $('.editor-dialog').dialog(options);
            $('.dnnFormPopup.dnnFormPopupMobileView').css({ 'width': options.width, left: '20px' });
        });
        return true;
    };

})(window.dnn, window.jQuery, window.ko);