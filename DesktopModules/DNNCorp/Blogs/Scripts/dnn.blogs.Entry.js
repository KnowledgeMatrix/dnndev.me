// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};

(function(dnn) {
    'use strict';

    dnn.blogs.Entry = function($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.socialController = social.getSocialController(this.contentItemId(), this);

        this.likes = ko.computed(
            function() {
                return that.socialController.likes();
            });

        this.toggleLike = function() {
            if (that.liked()) {
                return that.unlike();
            } else {
                return that.like();
            }
        };

        this.open = function() {
            if (that.hasOwnProperty('detailsUrl')) {
                window.location = that.detailsUrl();
            }
        };

        this.openAuthor = function() {
            if (that.hasOwnProperty('authorUrl')) {
                window.location = that.authorUrl();
            }
        };
        
        this.getLikeControlId = function () {
            return 'likes_{0}'.format(this.contentItemId());
        };
        
        this.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(this.contentItemId());
        };

        this.like = function (data, event) {
            that.socialController.like(data, event);
        };

        this.unlike = function (data, event) {
            that.socialController.unlike(data, event);
        };

        this.bookmark = function (data, event) {
            that.socialController.bookmark(data, event);
        };

        this.unbookmark = function (data, event) {
            that.socialController.unbookmark(data, event);
        };

        this.subscribe = function (data, event) {
            that.socialController.subscribe(data, event);
        };

        this.unsubscribe = function (data, event) {
            that.socialController.unsubscribe(data, event);
        };
    };
})(window.dnn);