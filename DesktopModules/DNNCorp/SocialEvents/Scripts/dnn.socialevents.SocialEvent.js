// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.SocialEvent = function($, ko, settings, social, model) {
        var that = this;
        
        $.extend(this, dnn.social.komodel(model));
        this.socialController = social.getSocialController(this.contentItemId(), this);
        this.service = social.getService('Detail');
        this.voteButtons = new dnn.socialevents.VoteButtons($, ko, settings, social, this);      
       
        if (typeof $.datepicker !== 'undefined') {
            $.datepicker._defaults.firstDay = 1;
            $.datepicker._defaults.dayNamesMin = settings.days1L;
            $.datepicker._defaults.monthNames = settings.months;
            $.datepicker._defaults.dateFormat = settings.dateFormatForJquery;
        }

        if (typeof $.timepicker !== 'undefined') {
            $.timepicker._defaults.showPeriod = settings.timeFormatShowPeriod;
            $.timepicker._defaults.showLeadingZero = settings.timeFormatShowLeadingZero;
            $.timepicker._defaults.timeSeparator = settings.timeFormatSeparator;
            $.timepicker._defaults.periodSeparator = settings.timeFormatPeriodSeparator;
            $.timepicker._defaults.amPmText = settings.timeFormatAMPMText;
        }
        
        var parseTime = function (dateString, timeString) {
            var date = $.datepicker.parseDate(settings.dateFormatForJquery, dateString);
            var time = $.timepicker.parseTime({ settings: {
                    showPeriod: settings.timeFormatShowPeriod,
                    showLeadingZero: settings.timeFormatShowLeadingZero,
                    timeSeparator: settings.timeFormatSeparator,
                    periodSeparator: settings.timeFormatPeriodSeparator,
                    amPmText: settings.timeFormatAMPMText
                }
            }, timeString);

            var year = date.getFullYear();
            var month = date.getMonth();
            var day = date.getDate();
            var hour = time.hours;
            var minutes = time.minutes;
            var result = new Date(year, month, day, hour, minutes);
            return result;
        };

        this.startTime = parseTime(that.startDateString(), that.startTimeString());
        this.endTime = parseTime(that.endDateString(), that.endTimeString());
        this.localizer = function () {
            return social.getLocalizationController();
        };

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }
            return key;
        };        

        this.listviewEventDisplayTime = ko.computed(function () {
            if (that.isFullDayEvent()) {
                return settings.months[that.startTime.getMonth()] + ' ' + that.startTime.getDate() + ', ' + that.startTime.getFullYear();
            }
            if (that.startTime.getYear() == that.endTime.getYear() &&
                that.startTime.getMonth() == that.endTime.getMonth() &&
                that.startTime.getDate() == that.endTime.getDate()) {
                var timeFormatInst = {
                    settings: {
                        showPeriod: settings.timeFormatShowPeriod,
                        showLeadingZero: settings.timeFormatShowLeadingZero,
                        timeSeparator: settings.timeFormatSeparator,
                        periodSeparator: settings.timeFormatPeriodSaperator,
                        amPmText: settings.timeFormatAMPMText
                    }
                };
                timeFormatInst.hours = that.startTime.getHours();
                timeFormatInst.minutes = that.startTime.getMinutes();
                var startTimeString = $.timepicker._getParsedTime(timeFormatInst);
                
                timeFormatInst.hours = that.endTime.getHours();
                timeFormatInst.minutes = that.endTime.getMinutes();
                var endTimeString = $.timepicker._getParsedTime(timeFormatInst);
                
                return startTimeString + ' - ' + endTimeString +
                    ' ' + settings.months[that.startTime.getMonth()] + ' '
                    + that.startTime.getDate() + ', ' + that.startTime.getFullYear();
            }

            if (that.startTime.getYear() == that.endTime.getYear() &&
                that.startTime.getMonth() == that.endTime.getMonth())
                return settings.months[that.startTime.getMonth()] + ' ' + that.startTime.getDate() + ' - ' + that.endTime.getDate() + ', ' + that.startTime.getFullYear();

            if (that.startTime.getYear() == that.endTime.getYear())
                return settings.months[that.startTime.getMonth()] + ' ' + that.startTime.getDate() + ' - ' +
                    settings.months[that.endTime.getMonth()] + ' ' + that.endTime.getDate() + ' ' + that.startTime.getFullYear();

            return that.startDateString() + ' - ' + that.endDateString();

        });

        this.showTodayLabel = ko.computed(function () {
            var today = new Date();

            return that.startTime.getYear() == today.getYear() &&
                   that.startTime.getMonth() == today.getMonth()  &&
                   that.startTime.getDate() == today.getDate();
        });

        this.userRSVPStyle = ko.computed(function () {
            var rsvp = that.rsvpStatus();
            return rsvp > 0 ? 'activeIndicator' : that.invitationOnly() ? 'disabled' : '';
        });

        this.userRSVPStatusLabel = ko.computed(function () {
            var rsvp = that.rsvpStatus();
            switch (rsvp) {
                case 1:
                    return that.getString("Attending");
                case 2:
                    return that.getString("Maybe");
                case 3:
                    return that.getString("Decline");
                case 4:
                    return that.getString("Invited");
                default:
                    return that.invitationOnly()? that.getString('InvitationOnly'): that.getString("Attend");
            }
        });

        this.googleMapLink = ko.computed(function () {
            var q = that.completeAddress();
            var c = q.split(', ');
            for (var i = 0; i < c.length; i++)
                c[i] = c[i].replace(/&/gi, '&amp;').replace(/\s+/gi, '+');

            q = c.join('+');

            return 'http://maps.google.ca/maps?f=q&source=s_q&hl=en&z=14&output=embed&iwloc=near&q=' + q;

        });

        this.seatsLabel = ko.computed(function () {
            var bookedSeats = that.attending() + that.mayAttend();
            var remainingSeats = that.maxAttendees() - bookedSeats;
            if (remainingSeats < 0) remainingSeats = 0;
            var str = that.maxAttendees() == 0 ? that.getString('SeatsLabelUnlimited'):
                    that.maxAttendees() + ' (' + remainingSeats + ' ' + that.getString('SeatsLabelRemaining') + ')';

            return that.getString('SeatsLabel') + str;
        });
        
        this.guestLoaded = ko.observable(false);
        this.attendingGuests = [];
        this.invitedGuests = [];
        this.showAttendingGuestsMore = false;
        this.showInvitedGuestsMore = false;
		this.sequence = 0;
        this.loadGuests = function (rsvpStatus) {
            var success = function (m) {
				if (m.Sequence != that.sequence - 1) {
					return;
				}
                that.attendingGuests = [];
                that.invitedGuests = [];

                if (m.hasOwnProperty('Results') === false || m.hasOwnProperty('TotalRecords') === false) {
                    $.dnnAlert({
                        title: localizer.getString('InvalidResponseCaption'),
                        text: localizer.getString('InvalidResponseText')
                    });

                    return null;
                }

                $(m.Results).each(function (i, n) {
                    if (n.RsvpStatus == 1 || n.RsvpStatus == 2){
                        if (that.attendingGuests.length < 3)
                            that.attendingGuests.push(n);
                        else
                            that.showAttendingGuestsMore = true;
                    }
                    else if (n.RsvpStatus == 4) {
                        if (that.invitedGuests.length < 3)
                            that.invitedGuests.push(n);
                        else
                            that.showInvitedGuestsMore = true;
                    }
                });

                that.guestLoaded(true);
            };
            var failure = function (xhr, status) {
                that.guestLoaded(true);
            };

            var params = {
                contentItemId: that.contentItemId(),
                rsvpStatus: 0,
                pageIndex: 0,
                pageSize: 4,
				sequence: that.sequence++
            };

            if (that.showGuestsToPublic() && !that.guestLoaded())
                that.service.get('GetAttendees', params, success, failure);
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

        this.viewCount = ko.computed(
            function () {
                if (that.viewCount() >= 0) {
                    return that.viewCount();
                }

                return 0;
            });

        this.bookmarked = ko.computed(
            function () {
                return that.socialController.bookmarked();
            });

        this.getLikeClass = function () {
            switch (that.liked()) {
                case true:
                    return 'idea-comments-like-liked';
                case false:
                    return 'idea-comments-like';
            }
        };

        this.getLikeControlId = function() {
            return 'likes_{0}'.format(this.contentItemId());
        };
        
        this.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(this.contentItemId());
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

        this.showGuestsToPublic = function () {
            return that.canModerate() || that.showGuests() || that.rsvpStatus() > 0;
        };

        this.getMap = function () {
            $('#mapDiv, #mapDivMobileView').on('click', function() {
                return false; // !important - dont bubble event
            });
            
            var addressLine = that.street(); // Street Address
            var locality = that.city(); // City or town name
            var adminDistrict = that.region(); // County
            var country = that.country(); // Country, obviously
            var postalCode = that.postalCode(); //Postcode
            
            var geocodeRequest = "http://dev.virtualearth.net/REST/v1/Locations"
                + "?countryRegion=" + country
                + "&addressLine=" + addressLine
                + "&locality=" + locality
                + "&adminDistrict=" + adminDistrict
                + "&postalCode=" + postalCode
                + "&disableBirdseye=true"
                + "&key=" + settings.bingCredentials
                + "&jsonp=window.geocodeCallback"; 
            
            this.callRestService(geocodeRequest);
        };

        this.callRestService = function (request) {
            var script = document.createElement("script");
            script.setAttribute("type", "text/javascript");
            script.setAttribute("src", request);
            var dochead = document.getElementsByTagName("head").item(0);
            dochead.appendChild(script);
        };

        this.bindControls = function (isMobileView) {
            if (typeof window.geocodeCallback === 'undefined' && settings.mapProvider === 'bing') {
                window.geocodeCallback = function (result) {
                    if (result && result.resourceSets && result.resourceSets.length > 0
                        && result.resourceSets[0].resources
                        && result.resourceSets[0].resources.length > 0) {
                        var coords = result.resourceSets[0].resources[0].point.coordinates;
                        var centerPoint = new window.Microsoft.Maps.Location(coords[0], coords[1]);
                        var mapElement = isMobileView ? document.getElementById("mapDivMobileView") : document.getElementById("mapDiv");
                        var map = new window.Microsoft.Maps.Map(mapElement,
                            {
                                credentials: settings.bingCredentials,
                                center: centerPoint,
                                mapTypeId: window.Microsoft.Maps.MapTypeId.road,
                                zoom: 15,
                                showScalebar: false,
                                showMapTypeSelector: false,
                                showDashboard: false,
                                fixedMapPosition: true,
                                disableTouchInput: true,
                                useInertia: false,
                                width: 350,
                                height: 200,
                                enableSearchLogo: false,
                                enableClickableLogo: false
                            });
                        var pushpin = new window.Microsoft.Maps.Pushpin(map.getCenter());
                        map.entities.push(pushpin);
                    }
                };
            }
        };
    };
})(window.dnn);

