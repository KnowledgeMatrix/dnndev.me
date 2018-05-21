// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function (dnn) {
    'use strict';
    
    dnn.challenges.Challenge = function Challenge($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.socialController = social.getSocialController(this.contentItemId(), this);
        this.service = social.getService('Detail');
        
        this.refresh = function () {
            window.location.reload();
        };

        this.localizer = function () {
            return componentFactory.resolve('LocalizationController');
        };

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }

            return key;
        };

        this.likes = ko.computed(
            function () {
                return that.socialController.likes();
            });

        this.likeable = ko.computed(
            function () {
                return that.socialController.likeable();
            });

        this.liked = ko.computed(
            function () {
                return that.socialController.liked();
            });

        this.bookmarked = ko.computed(
            function () {
                return that.socialController.bookmarked();
            });

        this.commentSingular = ko.computed(
            function () {
                return that.commentCount() == 1;
            });

        this.commentPlural = ko.computed(
            function () {
                return that.commentCount() != 1;
            });

        this.getLikeClass = function () {
            return that.liked() ? 'idea-comments-like-liked' : 'idea-comments-like';
        };

        this.open = function () {
            if (that.hasOwnProperty('detailsUrl')) {
                window.location = that.detailsUrl();
            }
        };

        this.likes = ko.computed(
            function () {
                return that.socialController.likes();
            });

        this.toggleLike = function (data, event) {
            return that.socialController.toggleLike(data, event);
        };

        this.like = function (data, event) {
            return that.socialController.like(data, event);
        };

        this.unlike = function (data, event) {
            return that.socialController.unlike(data, event);
        };

        this.bookmark = function (data, event) {
            return that.socialController.bookmark(data, event);
        };

        this.unbookmark = function (data, event) {
            return that.socialController.unbookmark(data, event);
        };

        this.subscribe = function (data, event) {
            return that.socialController.subscribe(data, event);
        };

        this.unsubscribe = function (data, event) {
            return that.socialController.unsubscribe(data, event);
        };

        this.getLikeControlId = function() {
            return 'likes_{0}'.format(this.contentItemId());
        };
        
        this.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(this.contentItemId());
        };
    };
})(window.dnn);