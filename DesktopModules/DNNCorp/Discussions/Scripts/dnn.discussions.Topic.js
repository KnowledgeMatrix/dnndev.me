// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.discussions === 'undefined') dnn.discussions = {};

(function (dnn) {
    'use strict';
    
    dnn.discussions.Topic = function Topic($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        var componentFactory = social.getComponentFactory();

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
        
        this.pin = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('PinFailureTitle'),
                    text: that.getString('PinFailure').format(status || that.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.pinned(m.pinned);
                that.lastModifiedOnDate(m.lastModifiedOnDate);
                that.lastModifiedByUserId(m.lastModifiedByUserId);
                that.lastActiveRelativeDate(m.lastActiveRelativeDate);
                that.lastActiveProfileUrl(m.lastActiveProfileUrl);
                dnn.social.loaded(settings.moduleScope.id);
            };

            var params = {
                topicId: that.topicId,
                contentItemId: that.contentItemId
            };

            that.service.post('PinTopic', params, success, failure);
        };

        this.protect = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('ProtectFailureTitle'),
                    text: that.getString('ProtectFailure').format(status || that.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.protected(m.protected);
                that.lastModifiedOnDate(m.lastModifiedOnDate);
                that.lastModifiedByUserId(m.lastModifiedByUserId);
                that.lastActiveRelativeDate(m.lastActiveRelativeDate);
                that.lastActiveProfileUrl(m.lastActiveProfileUrl);
                

            };

            var params = {
                topicId: that.topicId,
                contentItemId: that.contentItemId
            };

            that.service.post('ProtectTopic', params, success, failure);
        };
        
        this.lock = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('ProtectFailureTitle'),
                    text: that.getString('ProtectFailure').format(status || that.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.closed(m.closed);
                that.lastModifiedOnDate(m.lastModifiedOnDate);
                that.lastModifiedByUserId(m.lastModifiedByUserId);
                that.lastActiveRelativeDate(m.lastActiveRelativeDate);
                that.lastActiveProfileUrl(m.lastActiveProfileUrl);

                that.refresh();
            };

            var params = {
                topicId: that.topicId,
                contentItemId: that.contentItemId
            };

            that.service.post('LockTopic', params, success, failure);
        };

        this.getLikeControlId = function() {
            return 'likes_{0}'.format(this.contentItemId());
        };
        
        this.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(this.contentItemId());
        };

        this.showNotificationWindow = function (isErrorMessage, textMessage) {
            if (isErrorMessage) {
                $.dnnNotif({
                    dialogClass: 'noTittle',
                    outline: 'none',
                    type: 'warning',
                    height: 50,
                    styleBlue: true,
                    text: textMessage
                });
            } else {
                $.dnnNotif({
                    dialogClass: 'noTittle',
                    outline: 'none',
                    height: 40,
                    styleBlue: true,
                    text: textMessage
                });
            }
        };

        this.createTicket = function (data, event) {
            var params = {
                topicId: that.topicId(),
                contentItemId: that.contentItemId(),
                groupId: that.groupId()
            };

            $(event.srcElement).hide();

            that.service.post('CreateTicket', params,
                function () {
                    $(event.srcElement).show();
                    that.hasTicket(true);
                    that.showNotificationWindow(false, that.localizer().getString('TicketCreatedSuccessfully'));
                },
                function (xhr) {
                    $(event.srcElement).show();
                    var message = JSON.parse(xhr.responseText).Message;
                    that.showNotificationWindow(true, message);
                });
        };
    };
})(window.dnn);