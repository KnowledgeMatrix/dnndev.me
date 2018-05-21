// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.ReportControl = function ReportControl($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.reason = ko.observable();

        this.otherText = ko.observable();

        this.commentId = ko.observable(-1);

        this.reportedUserId = ko.observable(-1);

        this.postId = ko.observable(-1);

        this.title = ko.computed(
            function () {
                var localizer = that.social.getLocalizationController();
                if (that.commentId() >= 0) {
                    return localizer.getString('ReportCommentReason');
                } else if (that.reportedUserId() > -1) {
                    return localizer.getString('ReportUserReason');
                }
                return localizer.getString('ReportReason');
            });

        this.raise = function () {
            var localizer = that.social.getLocalizationController();
            that.displayModeration(false);

            var title;
            if (that.commentId() >= 0) {
                title = localizer.getString('ReportAComment');
            } else if (that.reportedUserId() > -1) {
                title = localizer.getString('ReportUser');
            }
            else {
                title = localizer.getString('ReportContent');
            }

            var options;
            var isMobileView = false;
            if (settings.parentControlScopeId) {
                var root = ko.contextFor($('#' + settings.parentControlScopeId)[0]);
                if (root && root.$root && root.$root.isMobileView) {
                    isMobileView = root.$root.isMobileView();
                }
            }

            if (isMobileView) {
                options = dnn.social.MobileView.dialogOptions({
                    title: title,
                    buttons: [
                        {
                            priority: 'primary',
                            'class': 'dnnPrimaryAction',
                            text: localizer.getString('CancelReport'),
                            click: that.cancel
                        },
                        {
                            priority: 'secondary',
                            'class': 'dnnSecondaryAction',
                            text: localizer.getString('SubmitReport'),
                            click: that.submit
                        }
                    ]
                });
            } else {
                options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: title,
                    minWidth: 475,
                    resizable: false,
                    buttons: [
                        {
                            priority: 'primary',
                            'class': 'dnnPrimaryAction',
                            text: localizer.getString('CancelReport'),
                            click: that.cancel
                        },
                        {
                            priority: 'secondary',
                            'class': 'dnnSecondaryAction',
                            text: localizer.getString('SubmitReport'),
                            click: that.submit
                        }
                    ],
                    open: $.ui.dialog.prototype.options.open,
                    close: $.ui.dialog.prototype.options.close,
                };
            }
            
            $('.social-report-content').dialog(options);
        };
        
        this.raiseContent = function (postId) {
            $('.social-report-other').hide();
            that.commentId(undefined);
            that.postId(postId);
            that.reason('0'); // need a default reason
            that.otherText(undefined);
            that.raise();
        };

        this.raiseComment = function (commentId) {
            $('.social-report-other').hide();
            that.commentId(commentId);
            that.reason('0'); // need a default reason
            that.otherText(undefined);
            that.raise();
        };
        
        this.raiseUser = function (userId) {
            $('.social-report-other').hide();
            that.reportedUserId(userId);
            that.reason('4'); // need a default reason
            that.otherText(undefined);
            that.raise();
        };
        
        this.loading = function (b) {
            var control = $('.social-report-content');
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.cancel = function () {
            $('.social-report-content').dialog('close');
        };

        this.displayModeration = function (show) {
            var titleContainer = $('.social-report-content > h3');
            var listContainer = $('.social-report-reason-list');
            var otherContainer = $('.social-report-other');
            var moderationContainer = $('.content-reported');
            var buttonsContainer = $('.ui-dialog-buttonpane');
            var btnClose = $('#btnClose');

            if (show) {
                titleContainer.hide();
                buttonsContainer.hide();
                listContainer.hide();
                otherContainer.hide();
                moderationContainer.show();
                btnClose.show();

            } else {
                titleContainer.show();
                buttonsContainer.show();
                listContainer.show();
                moderationContainer.hide();
                btnClose.hide();
            }
        };

        this.submit = function () {
            var localizer = that.social.getLocalizationController();
            if (typeof that.reason() === 'undefined' || that.reason() === 'unknown') {
                $.dnnAlert({
                    title: localizer.getString('ReportNoReasonTitle'),
                    text: localizer.getString('ReportNoReason')
                });
                return;
            }

            var success = function () {
                that.displayModeration(true);
            };
            
            var failure = function (xhr, status) {
                $.dnnAlert({
                    text: localizer.getString('ReportFailure').format(status || localizer.getString('UnknownError')),
                    title: localizer.getString('Error')
                });
            };

            var service = that.social.getService(settings.controller || 'NoControllerSet');

            var request, params;
            if (that.commentId() >= 0) {
                request = 'SubmitCommentReport';
                params = {
                    contentItemId: settings.contentItemId,
                    referenceId: that.commentId(),
                    reason: that.reason(),
                    reasonText: that.otherText()
                };
            } else if (that.reportedUserId() > -1) {
                request = 'SubmitUserReport';
                params = {
                    contentItemId: settings.contentItemId,
                    reportedUserId: that.reportedUserId(),
                    reason: that.reason(),
                    reasonText: that.otherText()
                };
            }
            else {
                request = 'SubmitReport';
                params = {
                    contentItemId: settings.contentItemId,
                    referenceId: that.postId(),
                    reason: that.reason(),
                    reasonText: that.otherText()
                };
            }

            service.post(request, params, success, failure, that.loading);
        };

        this.reason.subscribe(
            function () {
                var control = $('.social-report-other');
                if (that.reason() == '3') {
                    control.slideDown(
                        function () {
                            $('.social-report-other textarea').focus();
                            $('.social-report-content').dialog('option', 'position', 'center');
                        });
                }
                else {
                    if (control.is(':visible')) {
                        control.slideUp();
                    }
                }
            });
    };
})(window.dnn);