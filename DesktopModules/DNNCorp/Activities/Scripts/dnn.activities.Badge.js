// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';

    dnn.activities.Badge = function Badge($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        var componentFactory = social.getComponentFactory();

        this.description = ko.observable(model.Description);

        this.service = social.getService('UserBadges');

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

        this.cardMobile = ko.observable();
        this.cardMobileLoaded = ko.observable(false);
        this.loadDetail = function () {
            if (!this.cardMobileLoaded()) {
                this.service.getsync('GetBadgeCard', { badgeId: that.badgeId() }, function(m) {
                    var cardMobile = dnn.social.komodel(Object.ToCamel(m));
                    cardMobile.completedByVisibleMobile = (cardMobile.userBadges() != null && cardMobile.userBadges().length > 0);
                    that.cardMobile(cardMobile);
                    that.cardMobileLoaded(true);
                });
                return false;
            }
            return true;
        };
        
        this.tierName = ko.observable();
        this.period = this.timeFrameInDays;

        if (this.timeFrameInDays() <= 0) {
            this.timeFrameInDays(30);
        }

        if (typeof(model.Tier) != 'undefined') {
            this.tier = ko.observable(dnn.social.komodel(model.Tier));
            
            switch (this.tier()) {
                case 1:
                    this.tierName(that.getString('Bronze'));
                    break;
                case 2:
                    this.tierName(that.getString('Silver'));
                    break;
                case 3:
                    this.tierName(that.getString('Gold'));
                    break;
            }
        } else {
            this.tier = ko.observable();
            this.tierName(that.getString('Silver'));
        }
    };
})(window.dnn);