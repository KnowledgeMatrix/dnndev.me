// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};
if (typeof dnn.blogs.roster === 'undefined') dnn.blogs.roster = {};

(function (dnn) {
    'use strict';

    dnn.blogs.roster.BlogView = function BlogView($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.selected = ko.computed(function() {
            return that.blogId() === settings.currentBlogId;
        });
    };
})(window.dnn);