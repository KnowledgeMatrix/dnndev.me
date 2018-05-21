// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.VoteController = function($, ko, settings, social, model) {
        var that = this;

        this.componentFactory = social.getComponentFactory();

        this.service = social.getService('Detail');

        this.loading = ko.observable(false);

        this.model = model;

        this.localizer = function () {
            return that.componentFactory.resolve('LocalizationController');
        };

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }

            return key;
        };

        this.onChangingStatus = false;

        this.changeAttendStatus = function (value, oldvalue, completionHandler) {
            var allowChangeStatus = false;
            if (that.model.maxAttendees() < 1) allowChangeStatus = true; // no max attendees so allowed
            if (!allowChangeStatus && value != 1 && value != 2) allowChangeStatus = true; // not set attending or maybe attend so allowed
            if (!allowChangeStatus && (oldvalue == 1 || oldvalue == 2)) allowChangeStatus = true; // change attending to maybe or change maybe to attending so allowed
            if (!allowChangeStatus && (that.model.attending() + that.model.mayAttend() < that.model.maxAttendees())) allowChangeStatus = true; // current guests(attending + maybe) smaller than max attendees so allowed

            if (allowChangeStatus) {
                if (that.onChangingStatus) return;
                that.onChangingStatus = true;
                
                var success = function (m) {
                    that.onChangingStatus = false;
                    if (typeof completionHandler === 'function') {
                        completionHandler(true, m.RsvpStatus);
                    }
                };

                var failure = function (xhr, status) {
                    that.onChangingStatus = false;
                    if (typeof completionHandler === 'function') {
                        completionHandler(false, value, status);
                    }
                };

                var params = {
                    eventId: that.model.eventId(),
                    contentItemId: that.model.contentItemId(),
                    userId: settings.userId,
                    rsvpStatus: value
                };

                that.service.post('ChangeAttendStatus', params, success, failure, that.loading);
            }
            else
                $.dnnAlert({
                    title: that.getString('OverMaxAttendeesTitle'),
                    text: that.getString('OverMaxAttendeesText')
                });
        };       
    };
})(window.dnn);