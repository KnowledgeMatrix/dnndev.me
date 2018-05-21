// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.VoteButtons = function($, ko, settings, social, model) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.model = model;

        this.settings = settings;

        this.voteController = new dnn.socialevents.VoteController($, ko, settings, social, model);

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

        this.getButtonClass = function (i, isSelected) {
            var selectedClass = isSelected?  "selectedVotes " : "";
            
            switch (i) {
                case 1:                    
                    selectedClass = selectedClass + 'left';
                    break;
                case 3:
                    selectedClass = selectedClass + 'vright';
                    break;
                default:
                    selectedClass = selectedClass + 'center';
            }

            return selectedClass;
        };

        
        this.buttons = function () {
            var list = [];

            var rsvp = that.model.rsvpStatus();

            list.push({
                value: 1,
                title: that.getString('Attend'),
                type: that.getButtonClass(1, rsvp == 1),
                text: that.getString('Attend'),
                exec: function () {
                    if (rsvp == 1) return;
                    that.voteController.changeAttendStatus(1, rsvp, that.completionHandler);
                }
            });

            list.push({
                value: 2,
                title: that.getString('Maybe'),
                type: that.getButtonClass(2, rsvp == 2),
                text: that.getString('Maybe'),
                exec: function () {
                    if (rsvp == 2) return;
                    that.voteController.changeAttendStatus(2, rsvp, that.completionHandler);
                }
            });

            list.push({
                value: 3,
                title: that.getString('Decline'),
                type: that.getButtonClass(3, rsvp == 3),
                text: that.getString('Decline'),
                exec: function () {
                    if (rsvp == 3) return;
                    that.voteController.changeAttendStatus(3, rsvp, that.completionHandler);
                }
            });

            return list;           
        };

        this.completionHandler = function (success, rsvpStatus, status) {
           
            if (success == false) {
                $.dnnAlert({
                    title: that.getString('OverMaxAttendeesTitle'),
                    text: that.getString('OverMaxAttendeesText')
                });

                return null;
            }

            var originalRsvpStatus = that.model.rsvpStatus();
            that.model.rsvpStatus(rsvpStatus);
            if (originalRsvpStatus == 1 && rsvpStatus != 1)
                that.model.attending(that.model.attending() - 1);
            
            if (originalRsvpStatus != 1 && rsvpStatus == 1)
                that.model.attending(that.model.attending() + 1);

            if (that.model.guestLoaded()) {
                that.model.guestLoaded(false);
                that.model.loadGuests();
            }

            var primaryView = componentFactory.resolve('PrimaryView');
            if (primaryView != null) {
                primaryView.voteHandler(success);
            }

            if (typeof dnn.social.refreshUser === 'function') {
                dnn.social.refreshUser();
            }

            if (rsvpStatus == 1) // Attending
            {
                dnn.social.EventQueue.push(
                    function () {
                        dnn.social.ipc.post({}, settings.moduleRoot, { event: 'AttendEvent' });
                    });
            }

            return null;

        };
    };
})(window.dnn);