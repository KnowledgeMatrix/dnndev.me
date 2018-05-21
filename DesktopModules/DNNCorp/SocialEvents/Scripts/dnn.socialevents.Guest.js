// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.Guest = function ($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.service = social.getService('Detail');

        this.friend = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            
            var success = function () {
                that.friendStatus(3);
            };
            
            var fail = function () {
            };
            
            var params = {
                userId: this.userId()
            };

            this.service.post('friend', params, success, fail);
        };

        this.unfriend = function () {
            var success = function () {
                that.friendStatus(1);
            };
            
            var fail = function () {
            };
            
            var params = {
                userId: this.userId()
            };

            this.service.post('unfriend', params, success, fail);
        };
    };
})(window.dnn);

