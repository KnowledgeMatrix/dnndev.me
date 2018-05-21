// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.Profile = function Profile ($, ko, settings, social) {
        var that = this;
        var isCanvasSupported = function () {
            var elem = document.createElement('canvas');
            return !!(elem.getContext && elem.getContext('2d'));
        };

        this.service = social.getService('Profile');

        this.dynamic = ko.observable();

        this.properties = ko.observable(dnn.social.komodel(settings.profileCollection || {}));

        this.profileUrl = ko.observable(settings.profileUrl);

        this.compactViewPhotoUrl = ko.observable(settings.compactViewPhotoUrl);

        this.expandViewPhotoUrl = ko.observable(settings.expandViewPhotoUrl);

        this.bioExpanded = ko.observable(false);

        this.isDeleted = ko.observable(settings.profileIsDeleted);

        this.userIsMe = ko.computed(function() {
            return settings.userIsMe;
        });

        this.displayName = ko.computed(
            function () {
                if(!String.isEmpty(that.properties().displayName())){
                    return that.properties().displayName();
                }
                if (!String.isEmpty(that.properties().firstName()) &&
                    !String.isEmpty(that.properties().lastName())) {
                    return '{0} {1}'.format(that.properties().firstName(), that.properties().lastName());
                }
                else if (!String.isEmpty(that.properties().firstName())) {
                    return that.properties().firstName();
                }

                return null;
            });

        this.location = ko.computed(
            function () {
                if ((that.properties().city != undefined && that.properties().country != undefined) && (!String.isEmpty(that.properties().city()) && !String.isEmpty(that.properties().country()))) {
                    return '{0}, {1}'.format(that.properties().city(), that.properties().country());
                }
                else if ((that.properties().city != undefined && that.properties().region != undefined) && (!String.isEmpty(that.properties().city()) && !String.isEmpty(that.properties().region()))) {
                    return '{0}, {1}'.format(that.properties().city(), that.properties().region());
                }
                else if ((that.properties().region != undefined && that.properties().country != undefined) && (!String.isEmpty(that.properties().region()) && !String.isEmpty(that.properties().country()))) {
                    return '{0}, {1}'.format(that.properties().region(), that.properties().country());
                }
                else if (that.properties().city != undefined && !String.isEmpty(that.properties().city())) {
                    return that.properties().city();
                }
                else if (that.properties().region != undefined && !String.isEmpty(that.properties().region())) {
                    return that.properties().region();
                }
                else if (that.properties().country != undefined && !String.isEmpty(that.properties().country())) {
                    return that.properties().country();
                }
                return '';
            });

        this.userId = ko.computed(
            function () {
                if (that.dynamic() != null) {
                    return that.dynamic().userId();
                }
                return 0;
            });

        this.isFriend = ko.computed(
            function () {
                if (that.dynamic() != null && that.dynamic().isFriend()) {
                    return true;
                }

                return false;
            });

        this.isFriendRequested = ko.computed(
            function () {
                if (that.dynamic() != null && that.dynamic().isFriendRequested()) {
                    return true;
                }

                return false;
            });

        this.reputationPoints = ko.computed(
            function () {
                return (that.dynamic() && that.dynamic().reputationPoints()) || 0;
            });

        this.isFollowed = ko.computed(
            function () {
                if (that.dynamic() != null && that.dynamic().isFollowed()) {
                    return true;
                }

                return false;
            });
        
        this.biography = ko.computed(
            function () {
                if (that.bioExpanded()) {
                    if(typeof that.properties().biography == 'function' )
                        return dnn.social.decodeHtml(that.properties().biography());

                    return '';
                }

                if (that.dynamic() != null) {
                    return that.dynamic().truncatedBiography();
                }

                return null;
            });

        this.showMore = ko.computed(
            function () {
                if (that.dynamic() == null || String.isEmpty(that.dynamic().truncatedBiography())) {
                    return false;
                }

                return that.dynamic().truncatedBiography().length < that.properties().biography().length;
            });

        this.showBio = ko.computed(function () {
            if (typeof that.properties().biography == 'function' && !String.isEmpty(that.properties().biography())) {
                return true;
            }
            return false;
        });
        
        this.showMessageCount = ko.computed(
            function () {
                return that.dynamic() != null && that.dynamic().messageCount() > 0;
            });

        this.showNotificationCount = ko.computed(
            function () {
                return that.dynamic() != null && that.dynamic().notificationCount() > 0;
            });

        this.displayMessageCount = ko.computed(function () {
            return that.dynamic() ? that.dynamic().messageCount() > 99 ? '99+' : that.dynamic().messageCount() : null;
        });

        this.displayNotificationCount = ko.computed(function () {
            return that.dynamic() ? that.dynamic().notificationCount() > 99 ? '99+' : that.dynamic().notificationCount() : null;
        });

        if (isCanvasSupported()) {
            this.chart = new dnn.status.ProfileChart($, ko, settings, social, this);
        }
        else {
            this.chart = null;
        }
        
        this.loading = function (b) {
            var control = $('.status-profile-container', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.load = function (completionHandler, failureHandler) {
            var localizer = social.getLocalizationController();
            
            var failure = function (xhr, status) {
                if (typeof failureHandler === 'function') {
                    failureHandler();
                }
                
                $.dnnAlert({
                    title: localizer.getString('LoadProfileFailureTitle'),
                    text: localizer.getString('LoadProfileFailure').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.dynamic(dnn.social.komodel(m));
                that.properties(dnn.social.komodel(m.properties));

                if (that.chart != null) {
                    dnn.social.EventQueue.push(
                        function () {
                            that.chart.bindControls();
                        });
                }

                $('.badgeTooltip', settings.moduleScope).qaTooltip();

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(
                        function () {
                            completionHandler();
                        });
                }
            };

            var params = {
                userId: settings.profileUserId
            };

            that.service.get('GetProfile', params, success, failure, that.loading);
        };

        this.isPointsUrlValid = ko.computed(function() {
            return !String.isEmpty(settings.pointsUrl);
        });

        this.help = function () {
            if (this.isPointsUrlValid()) {
                window.location = settings.pointsUrl;
            }
        };

        this.toggleMore = function () {
            that.bioExpanded(!that.bioExpanded());
        };

        this.getControlKey = function (c) {
            var index = c.lastIndexOf('_');
            if (index < 0) {
                return c;
            }

            return c.substr(index + 1);
        };
    };
})(window.dnn);
