// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';
    var constants = {
        i18n: {
            errorSavingSubscriptionPreferences: 'errorSavingSubscriptionPreferences',
            subscriptionPreferencesSaved: 'SubscriptionPreferencesSaved',
            subscribeToMentions: 'SubscribeToMentions',
            unsubscribeFromMentions: 'UnsubscribeFromMentions'
        },
        services: {
            SUBSCRIPTIONS: 'Subscriptions'
        },
        methods: {
            TOGGLE_SUBSCRIPTIONS: 'ToggleUserMentionsSubscription'
        }
    }
    dnn.dashboard.Subscriptions = function UserSubscriptions(settings) {
        var self = this;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService(constants.services.SUBSCRIPTIONS);
        self.localizer = self.social.getLocalizationController();

        self.isError = ko.observable(false);
        self.message = ko.observable('');
        self.loading = ko.observable(false);
        self.showMessage = ko.observable(false);

        self.isSubscribedToUserMentions = ko.observable(settings.isSubscribedToUserMentions);
        self.userMentionSubscriptionLabel = ko.computed(function() {
            if (self.isSubscribedToUserMentions()) {
                return self.localizer.getString(constants.i18n.unsubscribeFromMentions);
            }
            return self.localizer.getString(constants.i18n.subscribeToMentions);

        });

        var messageTimeout;
        var setMessage = function (success) {
            var message = success
                ? self.localizer.getString(constants.i18n.subscriptionPreferencesSaved)
                : self.localizer.getString(constants.i18n.errorSavingSubscriptionPreferences);
            self.isError(!success);
            self.message(message);
            clearTimeout(messageTimeout);

            self.showMessage(true);
            messageTimeout = setTimeout(function () {
                self.showMessage(false);
            }, 3000);
        }


        self.toggleUserMentionsSubscription = function () {
            if (self.loading()) {
                return;
            }
            var success = function (result) {
                if (result.success) {
                    self.isSubscribedToUserMentions(result.isSubscribedToUserMentions);
                }
                setMessage(result.success);
            }
            var error = function () {
                setMessage(false);
            }
            self.service.post(constants.methods.TOGGLE_SUBSCRIPTIONS, {}, success, error, self.loading);
        }
    };
})(window.dnn);