// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.ExtendedView = function ExtendedView($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.moduleScope = settings.moduleScope;

        this.profile = new dnn.status.Profile($, ko, settings, this.social);

        this.profileUserId = settings.profileUserId;

        this.canModerate = ko.observable(settings.canModerate);

        this.userIsMe = ko.computed(function () { return settings.userIsMe; });

        this.service = this.social.getService('Relationships');

        this.localizer = function () { return that.social.getLocalizationController(); };

        this.builtins = ko.observableArray([]);

        this.collections = ko.observableArray([]);

        var componentFactory = this.social.getComponentFactory();
        componentFactory.register(this, 'PrimaryView');
        componentFactory.register(this.profile);
        componentFactory.register(new dnn.status.SharedView($, ko, settings, this.social));

        this.sendMessage = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return false;
            }
            return true;
        };

        $(settings.moduleScope).dnnComposeMessage({
            openTriggerScope: "body",
            openTriggerSelector: ".ComposeMessage",
            canTrigger: function () { return !settings.anonymous; },
            onPrePopulate: function (target) {
                var context = ko.contextFor(target);
                var prePopulatedRecipients = [{ id: "user-" + context.$data.userId(), name: context.$data.displayName()}];
                return prePopulatedRecipients;
            },
            servicesFramework: this.service.services
        });

        this.friend = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }

            var failure = function (xhr, status) {
                
            };

            var success = function () {
                var properties = that.profile.dynamic();
                if (properties != null) {
                    properties.isFriend(!properties.isFriend());

                    if (!properties.isFriend()) {
                        properties.isFriendRequested(false);

                        if (properties.friends() > 0) {
                            properties.friends(properties.friends() - 1);
                        }
                        if (properties.links && properties.links() > 1) {
                            properties.links(properties.links() - 2);
                        }
                    }
                    else {
                        properties.isFriendRequested(true);
                        properties.links && properties.links(properties.links() + 1);
                    }
                }
            };

            var params = {
                userId: settings.profileUserId
            };

            var method;
            if (that.profile.dynamic().isFriend()) {
                method = 'Unfriend';
            }
            else {
                method = 'Friend';
            }

            that.service.post(method, params, success, failure);
        };

        this.follow = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }

            var failure = function (xhr, status) {
            };

            var success = function () {
                var properties = that.profile.dynamic();
                if (properties != null) {
                    properties.isFollowed(!properties.isFollowed());

                    if (!properties.isFollowed()) {
                        if (properties.followers() > 0) {
                            properties.followers(properties.followers() - 1);
                        }
                        if (properties.links && properties.links() > 0) {
                            properties.links(properties.links() - 1);
                        }
                    } else {
                        properties.followers(properties.followers() + 1);
                        properties.links && properties.links(properties.links() + 1);
                    }
                }
            };

            var params = {
                userId: settings.profileUserId
            };

            var method;
            if (that.profile.dynamic().isFollowed()) {
                method = 'Unfollow';
            } else {
                method = 'Follow';
            }

            that.service.post(method, params, success, failure);
        };

        this.reportUser = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            dnn.social.reportUser(that.profileUserId);
        };
        
        this.editProfile = function () {
            that.profile.editProfile();
        };

        this.messages = function () {

        };

        this.showTwitter = function () {
            var properties = that.profile.properties();
            var regex = /^(?:(?:http|https):\/\/)?(?:www.)?twitter.com\//i;
            return (typeof properties["twitter"] == 'function' && regex.test(properties.twitter()));
        };

        this.twitter = function () {
            if (that.showTwitter()) {
                window.location.href = that.prefixUrl(that.profile.properties().twitter());
            }
        };

        this.showFacebook = function () {
            var properties = that.profile.properties();
            var regex = /^(?:(?:http|https):\/\/)?(?:www.)?facebook.com\//i;
            return (typeof properties["facebook"] == 'function' && regex.test(properties.facebook()));
        };

        this.facebook = function () {
            if (that.showFacebook()) {
                window.location.href = that.prefixUrl(that.profile.properties().facebook());
            }
        };

        this.showLinkedin = function () {
            var properties = that.profile.properties();
            var regex = /^(?:(?:http|https):\/\/)?(?:www.)?linkedin.com\//i;
            return (typeof properties["linkedIn"] == 'function' && regex.test(properties.linkedIn()));
        };

        this.linkedin = function () {
            if (that.showLinkedin()) {
                window.location.href = that.prefixUrl(that.profile.properties().linkedIn());
            }
        };

        this.showGooglePlus = function() {
            var properties = that.profile.properties();
            var regex = /^(?:(?:http|https):\/\/)?plus.google.com\//i;
            return (typeof properties["googlePlus"] == 'function' && regex.test(properties.googlePlus()));
        };

        this.googlePlus = function() {
            if (that.showGooglePlus()) {
                window.location.href = that.prefixUrl(that.profile.properties().googlePlus());
            }
        };

        this.notImplemented = function () {
            $.dnnAlert({
                title: that.localizer().getString('NotImplementedTitle'),
                text: that.localizer().getString('NotImplementedBody')
            });
        };

        this.switchingView = function() {
            $(".ui-dialog-content").dialog("close");
        };

        this.switchedView = function() {
            dnn.social.loaded(settings.moduleScope.id);
            if (!this.isMobileView()) {
                $('#moderator-actions-menu', settings.moduleScope).click(function (e) {
                    $(e.target).closest('ul.comment-actions-dropdown').hide();
                }).hoverIntent({
                    over: function() {
                        $('ul.comment-actions-dropdown', $(this)).show();
                    },
                    out: function() {
                        $('ul.comment-actions-dropdown', $(this)).hide();
                    },
                    timeout: 300,
                    interval: 150
                });
            }
            if (this.profile.chart != null)
                this.profile.chart.bindControls();
        };

        this.prefixUrl = function (url) {
            var regex = /^https?:\/\//i;
            if (!regex.test(url))
                url = "http://" + url;
            return url;
        };

        this.removeUser = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;               
            }
            
            if (settings.userIsMe) {
                return $.dnnAlert({
                    title: that.localizer().getString('Error'),
                    text: that.localizer().getString('CantDeleteSelf')
                });
            }
            
            var primaryView = that.social.getComponentFactory().resolve('PrimaryView');
            if (primaryView != null) {
                var options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: that.localizer().getString('RemoveUser'),
                    width: 515,
                    resizable: false,
                    close: function () {
                        if ($('#removeUserFields')[0] != undefined) {
                            if (ko.contextFor($('#removeUserFields')[0]).$data.removedUser()) {
                                that.profile.isDeleted(true);
                                $('.userRemoved').show();
                                $('.userRemovedMsg').show();
                                $('.reportUser').hide();
                            }
                        }
                    }
                };
                $('.remove-user-dialog').dialog(options);
            }
            return true;
        };

        this.showModerateMenu = function () {
            if (that.canModerate() && !that.profile.isDeleted()) {
                that.switchedView();
                return true;
            } else {
                return false;
            }            
        };

        this.binded = function() {
            that.switchedView();
        };

        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);
    };
})(window.dnn);