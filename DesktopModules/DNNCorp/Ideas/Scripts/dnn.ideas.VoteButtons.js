// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function(dnn) {
    'use strict';

    dnn.ideas.VoteButtons = function VoteButtons($, ko, settings, social, model) {
        var that = this;
        
        $.extend(this, settings);

        var componentFactory = social.getComponentFactory();

        this.model = model;

        this.initialVotes = ko.observable((settings.initialVotes !== 'undefined') ? settings.initialVotes : 0);

        this.initialVotes.subscribe(
            function() {
                that.updateSelectedVotes();
            });

        this.changeInitialVotes = function (m) {
            that.initialVotes(m.value);
        };

        this.voteController = new dnn.ideas.VoteController($, ko, settings, social, model);

        this.maxVotes = settings.votesPerIdea;

        this.getButtonClass = function (i, disabled) {
            var votes = that.initialVotes();

            if (that.model.ideaId() != -1) {
                votes = model.userVotes();
            }

            var selectedClass = votes == i ? "selectedVotes " : "";
            
            switch (i) {
                case 1:
                    if (that.maxVotes == 1) {
                        selectedClass = selectedClass + 'single';
                    }

                    selectedClass = selectedClass + 'left';
                    break;
                case that.maxVotes:
                    selectedClass = selectedClass + 'vright';
                    break;
                default:
                    selectedClass = selectedClass + 'center';
            }

            if (disabled) {
                selectedClass = selectedClass + ' disabled';
            }
            
            return selectedClass;
        };
        
        this.updateSelectedVotes = function () {
            var elements = '.' + that.buttonsContainerClass + ' a';

            $(elements).each(
                function() {
                    if ($(this).hasClass("disabled"))
                        return true;

                    var i = $(this).attr('data-vote');

                    if (parseInt(i) == that.initialVotes())
                        $(this).addClass('selectedVotes');
                    else
                        $(this).removeClass('selectedVotes');

                    return true;
                });

            return true;
        };

        this.showRemoveButton = ko.computed(
            function () {
                var ideaUser = model.createdByUserId();

                if (settings.currentUserId != ideaUser) {
                    return model.userVotes() > 0;
                }
                
                return model.userVotes() > 1;
            });

        this.getVotesRemaining = function () {
            var root = ko.contextFor($(settings.moduleScope)[0]).$root;

            var remaining = 0;
            
            if (typeof root !== 'undefined' && root != null) {
                remaining = root.votesRemaining() < 0 ? 0 : root.votesRemaining();
            }

            return remaining;
        };
         
        this.buttons = function () {
            var localizer = social.getLocalizationController();

            var list = [];

            var votesRemaining = that.getVotesRemaining();
            
            var numValidVotes = votesRemaining > that.maxVotes ? that.maxVotes : votesRemaining;

            for (var i = 1; i < that.maxVotes + 1; ++i) {
                var disabledBtn = (numValidVotes == 0) ? (i > model.userVotes()) : (i > numValidVotes + model.userVotes());

                var text;
                if (i > 1) {
                    text = i + ' ' + localizer.getString('Votes');
                } else {
                    text = i + ' ' + localizer.getString('Vote');
                }

                var title;
                if (disabledBtn) {
                    title = localizer.getString('DisabledVotes');
                } else {
                    title = text;
                }

                var b = {
                    value: i,
                    title: title,
                    disabled: disabledBtn,
                    type: that.getButtonClass(i, disabledBtn),
                    text: text,
                    textMobileView: i.toString(),
                    exec:
                        function () {
                            that.voteController.vote(this.value, that.completionHandler);
                        }
                };

                list.push(b);
            }
            
            return list;
        };

        this.removeVotes = function () {
            that.voteController.removeVotes(that.completionHandler);
        };

        this.completionHandler = function (success, postCompletion, status) {
            var localizer = componentFactory.resolve('LocalizationController');
            if (localizer == null) {
                return null;
            }

            if (success == false) {
                $.dnnAlert({
                    title: localizer.getString('VoteFailure'),
                    text: localizer.getString('VoteFailureText').format(status || localizer.getString('UnknownError'))
                });
            }

            var primaryView = componentFactory.resolve('PrimaryView');
            if (primaryView != null) {
                try {
                    primaryView.voteHandler(success, postCompletion);
                } catch (e) {
                    console.log('Uncaught exception in vote handler', e);
                }
            }

            dnn.social.EventQueue.push(
                function () {
                    dnn.social.ipc.post({}, settings.moduleRoot, { event: 'VoteIdea' });
                });
            
            return null;
        };
    };

    dnn.ideas.VoteButtons.setPanelSize = function(control) {
        setTimeout(
            function() {
                if (control.is(':visible') == false) {
                    return null;
                }

                var width = 0;

                var blocks = $('.ie-shadow > a', control);

                var buttonNumber = blocks.length;

                width = buttonNumber * 63;

                if ($('.idea-remove-button', control).is(':visible')) {
                    width += $('.idea-remove-button', control).width();
                }

                if (width < 155) width = 155;

                $(control).width(width);

                return null;
            }, 0);
    };
    
})(window.dnn);