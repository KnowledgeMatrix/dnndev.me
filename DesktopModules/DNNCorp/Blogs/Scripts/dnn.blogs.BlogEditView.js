// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};

(function (dnn) {

    'use strict';

    dnn.blogs.BlogEditView = function BlogEditView($, ko, settings) {

        var that = this;

        $.extend(this, settings);
        
        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('BlogEdit');

        this.primaryView = settings.primaryView;

        this.isMobileView = ko.computed(function () {
            if(that.primaryView && typeof that.primaryView.isMobileView === 'function')
                return that.primaryView.isMobileView();
            return false;
        });

        this.blogId = ko.computed(function () {
            return that.primaryView.blogId;
        });
        
        var localizer = this.social.getLocalizationController();

        this.editMode = ko.computed(function () {
            if (that.primaryView != null && that.primaryView.selectedBlog() != null) {
                return parseInt(that.primaryView.selectedBlog().blogId(), 10) > 0;
            }
            return false;
        });
        
        this.authorMode = [
            { value: 0, mode: localizer.getString('AuthorMode.Personal') },
            { value: 1, mode: localizer.getString('AuthorMode.Ghost') },
            { value: 2, mode: localizer.getString('AuthorMode.Blogger') }
        ];

        this.visibilityOptions = [
            { value: false, text: 'Private' },
            { value: true, text: 'Public' }
        ];

        this.save = function () {
            if (!that.validate($('#postFields', settings.moduleScope))) {
                return false;
            }

            if (!that.submit()) {
                return false;
            }
            return true;
        };

        this.getJumpUrl = function (m) {
            if (typeof m.detailsUrl === 'string' && m.detailsUrl.length > 0) {
                return m.detailsUrl;
            }

            return settings.returnUrl;
        };

        this.submit = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('SaveBlogFailedTitle'),
                    text: localizer.getString('SaveBlogFailed').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                window.location = m.blogUrl;
            };

            var selectedBlog = that.primaryView.selectedBlog();
            var params = {
                blogId: selectedBlog.blogId(),
                groupId: that.groupId,
                authorized: selectedBlog.authorized(),
                title: selectedBlog.title(),
                description: selectedBlog.description(),
                allowComments: selectedBlog.allowComments(),
                syndicated: selectedBlog.syndicated(),
                authorMode: selectedBlog.authorMode()
            };

            var httpMethod;

            if (selectedBlog.blogId() < 1)
                httpMethod = 'Create';
            else
                httpMethod = 'Update';

            that.service.post(httpMethod, params, success, failure, that.loading);
        };

        this.remove = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('DeleteBlogErrorTitle'),
                    text: localizer.getString('DeleteBlogError').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.cancel();
                window.location = m.entryListUrl;
            };

            var selectedBlog = that.primaryView.selectedBlog();
            var params = {
                blogId: selectedBlog.blogId(),
                groupId: that.groupId
            };
            that.service.post('Delete', params, success, failure, that.loading);
            
        };

        this.cancel = function () {
            $('.editor-dialog').dialog('close');
        };

        this.loading = function(b) {
            if (b) {
                $(settings.moduleScope).addClass('loading');
            } else {
                $(settings.moduleScope).removeClass('loading');
            }
        };
        
        this.bindControls = function () {
            $('.blog-edit-title', settings.moduleScope).focus();
        };

        this.binded = function() {
            this.bindControls();
        };
    };

})(window.dnn);