// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn, $, ko) {
    'use strict';
    dnn.socialevents.DetailView = function DetailView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.socialevents.SocialEvent($, ko, this.settings, this.social, this.dataModel);
        this.register(this, 'PrimaryView');
        this.register(this.social.getService('Detail'));
        this.register(this.social.getPagingControl('DetailController'));
        this.register(new dnn.socialevents.DetailController($, ko, this.settings, this.componentFactory));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, ['.idea-vote-options']));
        this.init();
    };

    dnn.socialevents.DetailView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.socialevents.DetailView.prototype.init = function () {
        var self = this;
        this.voteButtons = new dnn.socialevents.VoteButtons($, ko, this.settings, this.social, this.model);
        this.mapProvider = this.settings.mapProvider;
        this.showCommentsTitle = ko.observable(false);
        this.commentCount = ko.observable(self.settings.commentCount);
        this.voted = ko.observable(0);
        this.voteClass = ko.computed(function () { return self.voteButtons.voteController.loading() ? 'voting' : new String(); });

        // below 2 methods invoked by ko, thus 'this' inside method is another prototype, so I have to keep those 3 methods in here and use 'self'
        this.rsvp = function (socialEvent) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (socialEvent.invitationOnly() && socialEvent.rsvpStatus() == 0) return true;
            var control = $('#rsvp-panel-{0}'.format(socialEvent.eventId()), self.settings.moduleScope);
            var visible = control.is(':visible');
            if (visible == false) control.fadeIn();
            return false;
        };
        this.rsvpMobileView = function(socialEvent) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (socialEvent.invitationOnly() && socialEvent.rsvpStatus() == 0) return true;
            var options = $('.dnnMobile-idea-vote-options', self.settings.moduleScope);
            if (options.is(':visible')) {
                options.fadeOut();
            } else {
                options.fadeIn();
            }
            return false;
        };
        
        dnn.social.DetailView.prototype.init.apply(this);
    };

    dnn.socialevents.DetailView.prototype.voteHandler = function (success) {
        var self = this;
        if (success) {
            setTimeout(
                function () {
                    var options = $('.idea-vote-options', self.settings.moduleScope);
                    if (options.is(':visible')) {
                        options.fadeOut();
                    }
                }, 850);
        }
    };

    dnn.socialevents.DetailView.prototype.getMap = function () { return this.model.getMap(); };

    dnn.socialevents.DetailView.prototype.vote = function() {
        if (dnn.social.authorizationRequired(this.settings)) return true;
        if ($('.idea-vote-button', this.settings.moduleScope).hasClass('disabled')) return false;

        var options = $('.idea-vote-options', this.settings.moduleScope);
        if (options.is(':visible')) {
            options.fadeOut();
        } else {
            options.fadeIn();
        }
        return false;
    };
    
    dnn.socialevents.DetailView.prototype.bindControls = function () {
        $(window.document).bind('focused',
               function () {
                   if ($('.idea-vote-options').is(':visible')) {
                       $('.idea-vote-options').fadeOut();
                   }

                   if ($('.dnnMobile-idea-vote-options').is(':visible')) {
                       $('.dnnMobile-idea-vote-options').fadeOut();
                   }
               });
        dnn.social.DetailView.prototype.bindControls.apply(this);
    };
    
    dnn.socialevents.DetailView.prototype.customisedSwitchedView = function () {
        var self = this;
        if (!self.isMobileView()) {
            $("a#deleteEvent").dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                isButton: false,
                callbackTrue: function() {
                    var service = self.social.getService('Edit');
                    var success = function(m) {
                        window.location.href = m.ReturnUrl;
                    };
                    var params = {
                        eventId: self.model.eventId(),
                        contentItemId: self.model.contentItemId(),
                        userId: self.settings.userId,
                        groupId: self.model.groupId()
                    };
                    service.post('Delete', params, success);
                }
            });
        }
    };
   
    dnn.socialevents.DetailView.prototype.binded = function () {
        this.bindControls();
        if (this.model.showGuestsToPublic()) this.model.loadGuests();

        $("#eventCalendar").hide();
        this.switchedView();

        if (this.settings.mapProvider === 'bing') this.getMap();
    };
    
})(window.dnn, window.jQuery, window.ko);