// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    
    dnn.activities.BadgeCardView = function BadgeCardView($, ko, settings, element) {
        var that = this;
        this.card = ko.observable();
        this.loading = ko.observable(false);
        this.error = ko.observable("");
        this._ko = ko;
        this._element = element;

        this._onBadgeLoadedHandler = $.proxy(this.onBadgeLoaded, this);
        this._onBadgeFailedHandler = $.proxy(this.onBadgeFailed, this);

        this._social = new dnn.social.Module(settings);
        this._service = this._social.getService('UserBadges');
        this.completedByVisible = ko.computed(function () {
            return (that.card() != null && that.card().userBadges() != null && that.card().userBadges().length > 0);
        });
    };

    dnn.activities.BadgeCardView.prototype = {

        loadDetails:function (badgeId) {
            this.error("");
            this._service.getsync('GetBadgeCard', { badgeId: badgeId }, this._onBadgeLoadedHandler, this._onBadgeFailedHandler, this.loading);
        },

        onBadgeLoaded: function (model) {
            this.card(dnn.social.komodel(Object.ToCamel(model)));           
        },

        onBadgeFailed: function (xhr, status) {
            this.error(status);
        },
    };

})(window.dnn);
