// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function(dnn) {
    'use strict';
    
    dnn.ideas.VoteSummaryView = function VoteSummaryView($, ko, settings) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Detail');

        this.votesRemaining = ko.observable(settings.votesRemaining || 0);

        this.votesUsed = ko.observable(settings.votesUsed || 0);

        this.helpText = ko.observable();

        this.votesRemainingDisplay = ko.computed(
            function () {
                var remaining = Math.max(0, parseInt(that.votesRemaining(), 10));

                if (remaining.toString().length == 1 && remaining > 0) {
                    remaining = '0' + remaining;
                }

                return remaining;
            });

        this.isMobileView = ko.observable(false);

        dnn.social.ipc.register(settings,
            function (source, message) {
                if (typeof message.event === 'undefined') {
                    console.log('Unable to process IPC message from source', source, message);
                    return;
                }

                switch (message.event) {
                    case "SetVotesRemaining":
                        that.votesRemaining(message.votesRemaining);
                        that.votesUsed(message.votesUsed);
                        break;
                    case "ViewSwitched":
                        that.isMobileView(message.isMobileView);
                        break;
                    default:
                        break;
                }
            });

        this.showMyVotes = function () {
            if (settings.isDetailView) {
                window.location = settings.myVotesUrl;
            }
            else {
                var msg = {
                    event: 'SwitchCategory',
                    category: 'myvotes'
                };

                dnn.social.ipc.post(settings, 'DNNCorp/Ideas', msg);
            }
        };

        this.closeHelp = function () {
            $(settings.moduleScope).dialog('close');
        };

        this.helpText.subscribe(function(txt) {
            $('.ideas-vote-help-dialog .ideas-vote-help-text').html(txt);
        });

        this.help = function (resourceKey) {
            var localizer = that.social.getLocalizationController();
            that.helpText(localizer.getString('VoteHelp_Text_{0}'.format(resourceKey)));
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup dnnClear',
                title: localizer.getString('VoteHelp_Title_{0}'.format(resourceKey)),
                minWidth: 600,
                buttons: [
                    {
                        priority: 'primary',
                        'class': 'dnnPrimaryAction',
                        text: localizer.getString('OK'),
                        click: function () {
                            $('.ideas-vote-help-dialog').dialog('close');
                        }
                    }
                ],

                closeOnEscape: false,
                resizable: false,
                open: $.ui.dialog.prototype.options.open,
                close: $.ui.dialog.prototype.options.close,
            };
            
            if (this.isMobileView()) {
                options = dnn.social.MobileView.dialogOptions({
                    title: localizer.getString('VoteHelp_Title_{0}'.format(resourceKey)),
                    buttons: [
                        {
                            priority: 'primary',
                            'class': 'dnnPrimaryAction',
                            text: localizer.getString('OK'),
                            click: function () {
                                $('.ideas-vote-help-dialog').dialog('close');
                            }
                        }
                    ]
                });
            }
            $('.ideas-vote-help-dialog').dialog(options);
        };
    };
})(window.dnn);