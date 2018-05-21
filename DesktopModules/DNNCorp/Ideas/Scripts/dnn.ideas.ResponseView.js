// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn) {
    'use strict';

    dnn.ideas.ResponseView = function ResponseView($, ko, settings, model) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Response');

        var localizer = this.social.getLocalizationController();

        this.moderator = settings.moderator || false;

        this.model = ko.observable(dnn.social.komodel(model));

        this.loading = ko.observable(false);

        this.status = ko.observable();

        this.companyResponse = ko.observable();

        this.enableSubmit = ko.observable(true);

        this.enableSubmit.subscribe(function (newValue) {
            var submitBtn = $('.ui-dialog-buttonset .dnnPrimaryAction', settings.moduleScope);
            if (newValue) {
                submitBtn.removeAttr('disabled');
            }
            else {
                submitBtn.attr('disabled', 'disabled');
            }

        });
        
        this.statusList = [
            { value: 0, status: localizer.getString('Status.Submitted') }, 
            { value: 5, status: localizer.getString('Status.UnderReview') },
            { value: 33, status: localizer.getString('Status.Reviewed') },
            { value: 15, status: localizer.getString('Status.Accepted') },
            { value: 20, status: localizer.getString('Status.Scheduled') },
            { value: 25, status: localizer.getString('Status.Delivered') },
            { value: 30, status: localizer.getString('Status.Duplicate') }
        ];

        this.completionEvent = function (m) {
            if ((settings.parentId || '').length > 0) {
                var root = ko.contextFor($(settings.parentId)[0]);

                if (typeof root !== 'undefined' &&
                    typeof root.$root !== 'undefined') {
                    if (typeof root.$root.refresh === 'function') {
                        root.$root.refresh();
                    }

                    that.cancel();
                    that.enableSubmit(true);
                }
                return true;
            }
            return false;
        };

        this.save = function () {
            if (!that.enableSubmit())
                return false;

            that.enableSubmit(false);

            if (!that.validate($('#ideaResponseFields'))) {
                that.enableSubmit(true);
                return false;
            }

            if (!that.submit()) {
                return false;
            }

            return true;
        };

        this.submit = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('SaveFailedTitle'),
                    text: localizer.getString('SaveFailed').format(status || localizer.getString('UnknownError'))
                });
                that.enableSubmit(true);
            };

            var success = function (m) {
                dnn.social.EventQueue.push(
                    function () {
                        that.completionEvent(m);
                    });
            };

            var params = {
                ideaId: that.model().ideaId(),
                status: that.status(),
                response: that.companyResponse()
               
            };

            that.service.post('AddResponse', params, success, failure, that.loading);
        };

        this.cancel = function () {
            $('.idea-response-add-dialog').dialog('close');
        };

        this.decodeContent = function (s) {
            if ((s || new String()).length == 0) {
                return s;
            }

            s = s.replace(/<br \/>/g, "\n");

            var decoded = $('<div />').html(s).text();

            return decoded;
        };

        this.loading.subscribe(
            function () {
                if (that.loading()) {
                    $(settings.moduleScope).addClass('loading');
                }
                else {
                    $(settings.moduleScope).removeClass('loading');
                }
            });
    };
    
})(window.dnn); 