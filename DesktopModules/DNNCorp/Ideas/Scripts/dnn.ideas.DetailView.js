// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn, $, ko) {
    'use strict';
    
    dnn.ideas.DetailView = function DetailView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.ideas.IdeaModel($, ko, this.settings, this.social, this.dataModel);
        this.register(this, 'PrimaryView');
        this.register(this.social.getService('Detail'));
        this.register(this.social.getPagingControl('DetailController'));
        this.register(new dnn.ideas.DetailController($, ko, this.settings, this.componentFactory));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, ['.idea-vote-options']));
        this.init();
    };

    dnn.ideas.DetailView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.ideas.DetailView.prototype.init = function () {
        var self = this;
        this.service = this.social.getService('Detail');
        this.voteDisplay = this.settings.voteDisplay;
        this.votingEnabled = this.settings.votingEnabled;
        this.voteButtons = new dnn.ideas.VoteButtons($, ko, this.settings, this.social, this.model);
        this.votesRemaining = ko.observable(this.settings.votesRemaining || 0);
        this.responseHistories = ko.observableArray();
        this.showCommentsTitle = ko.observable(false);
        this.commentCount = ko.observable(this.settings.commentCount);
        this.voted = ko.observable(0);
        this.totalSupporters = 0;
        this.averageVotesPerUser = '';
        this.supporterControlPageIndex = 0;
        this.supportersControl = {
            results: ko.observableArray([]),
            showMore: ko.observable(false),
            getMore: function () {
                self.supporterControlPageIndex++;
                self.loadSupporters(self.supporterControlPageIndex);
            }
        };
        this.supportersControlInitialized = false;
        this.userVotesLabel = ko.computed(function () { return self.model.userVotesLabel(); });
        this.lockedLabel = ko.computed(function () { return self.getString('Locked'); });
        dnn.social.DetailView.prototype.init.apply(this);
    };

    dnn.ideas.DetailView.prototype.customisedSwitchedView = function () {
        var self = this;
        if (!self.isMobileView()) {
            $('a#deleteTopic').dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                callbackTrue: function () {
                    var service = self.social.getService('Edit');
                    var success = function (m) {
                        window.location.href = m.ReturnUrl;
                    };
                    var params = {
                        topicId: self.model.topicId(),
                        contentItemId: self.model.contentItemId(),
                        groupId: self.model.groupId()
                    };
                    service.post('Delete', params, success);
                }
            });
        }
    };
    
    dnn.ideas.DetailView.prototype.initSuportersControl = function () {
        this.totalSupporters = 0;
        this.averageVotesPerUser = '';
        this.supportersControl.results([]);
    };
    
    dnn.ideas.DetailView.prototype.viewSupporters = function () {
        var self = this;
        var callback = function () {
            var popup = $('#idea-supporters-dialog');
            popup.dialog({
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: 'Supporters of this Idea',
                minWidth: 350,
                resizable: false,
                draggable: false
            });

            var parent = popup.parent();
            var totalSupportersDiv = '<span class="idea-total-supporters">' + self.totalSupporters + '</span>';
            var avgVotesPerUserDiv = '<span class="idea-avg-votes">(' + self.averageVotesPerUser + ' Avg)</span>';
            parent.find('.idea-total-supporters').remove();
            parent.find('.idea-avg-votes').remove();
            parent.find('.ui-dialog-title').before(totalSupportersDiv);
            parent.find('.ui-dialog-title').after(avgVotesPerUserDiv);
        };

        if (self.supportersControl.results().length > 0)
            callback();
        else
            self.loadSupporters(0, callback);
    };

    dnn.ideas.DetailView.prototype.moveContent = function () {
        dnn.social.contentExchange({
            methodName: 'Move',
            actionTitle: this.getString('Move'),
            actionTitle2: '',
            summary: this.model.contentTitle()
        });
    };

    dnn.ideas.DetailView.prototype.moveContentToComment = function () {
        dnn.social.contentExchange({
            methodName: 'MoveToComment',
            actionTitle: this.getString('Move'),
            actionTitle2: this.getString('ToComment'),
            summary: this.model.contentTitle()
        });
    };

    dnn.ideas.DetailView.prototype.copyContent = function () {
        dnn.social.contentExchange({
            methodName: 'Copy',
            actionTitle: this.getString('Copy'),
            actionTitle2: '',
            summary: this.model.contentTitle()
        });
    };

    dnn.ideas.DetailView.prototype.loadSupporters = function (pageIndex, callback) {
        var self = this;
        var failure = function () {
        };
        var success = function (m) {
            var supporters = pageIndex == 0 ? [] : self.supportersControl.results();
            for (var i = 0; i < m.Results.length; i++) {
                supporters.push(m.Results[i]);
            }
            self.supportersControl.results(supporters);
            self.totalSupporters = m.Total;
            self.averageVotesPerUser = m.Average;
            self.supportersControl.showMore(Math.ceil(self.totalSupporters / 10) - 1 > self.supporterControlPageIndex);
            if (typeof callback === 'function') callback();
        };

        var params = {
            ideaId: self.model.ideaId(),
            pageIndex: pageIndex
        };
        self.service.get('GetIdeaVotesDetail', params, success, failure);
    };
    
    dnn.ideas.DetailView.prototype.getResponseHistory = function () {
        var self = this;
        var loadingContainer = $('.loading-container', self.settings.moduleScope);
        var failure = function () {
            loadingContainer.removeClass('loading');
        };

        var success = function (m) {
            loadingContainer.removeClass('loading');

            var results = [];

            $.each(m.Results,
                function (index, mdl) {
                    results.push(new dnn.social.komodel(mdl));
                });

            self.responseHistories(results);

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: self.getString('ViewResponseHistory'),
                minWidth: 550,
                closeOnEscape: false,
                resizable: false
            };

            $('.idea-response-history').dialog(options);
        };

        loadingContainer.addClass('loading');

        var params = {
            ideaId: self.model.ideaId
        };

        self.service.get('GetResponseHistory', params, success, failure);

        return false;
    };

    dnn.ideas.DetailView.prototype.getEditParams = function() {
        return {
            ideaId: this.model.ideaId(),
            sequence: this.model.revisionSequence()
        };
    };
    
    dnn.ideas.DetailView.prototype.addResponse = function () {
        var self = this;
        if (dnn.social.authorizationRequired(this.settings)) return true;

        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: self.getString('AddResponse'),
            minWidth: 550,
            closeOnEscape: false,
            resizable: false
        };

        $('.idea-response-add-dialog').dialog(options);
        var editModel = ko.contextFor($(settings.editId)[0]).$root;
        if (editModel) dnn.social.EventQueue.push(editModel.bindControls); 
        return true;
    };
    
    dnn.ideas.DetailView.prototype.bindControls = function () {
        $(window.document).bind('focused',
               function () {
                   if ($('.idea-vote-options').is(':visible')) {
                       $('.idea-vote-options').fadeOut();
                   }

                   if ($('.dnnMobile-idea-vote-options').is(':visible')) {
                       $('.dnnMobile-idea-vote-options').fadeOut();
                   }
               });

        if (!this.votingEnabled) return;

        dnn.social.DetailView.prototype.bindControls.apply(this);
    };
    
    dnn.ideas.DetailView.prototype.remove = function () {
        var self = this;
        var failure = function (xhr, status) {
            $.dnnAlert({
                title: self.getString('DeleteErrorTitle'),
                text: self.getString('DeleteError').format(status || self.getString('UnknownError'))
            });
        };

        var success = function () {
            window.location = self.settings.deleteReturnUrl;
        };

        var params = {
            ideaId: self.model.ideaId()
        };

        var editService = self.social.getService('Edit');
        editService.post('Delete', params, success, failure);
    };
    
    dnn.ideas.DetailView.prototype.voteMobileView = function () {
        var self = this;
        if (dnn.social.authorizationRequired(self.settings)) return true; 
        if (!self.votingEnabled) return true;
        var options = $('.dnnMobile-idea-vote-options', self.settings.moduleScope);
        if (options.is(':visible')) {
            options.fadeOut();
        } else {
            options.fadeIn();
        }
        return false;
    };
    
    dnn.ideas.DetailView.prototype.customisedSwitchedView = function () {
        var self = this;
        if (!self.isMobileView()) {
            $("#btnDelete").dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                isButton: false,
                callbackTrue: function () { self.remove(); }
            });
        }
    };
    
    dnn.ideas.DetailView.prototype.notifyViewSwitched = function () {
        var msg = {
            event: 'ViewSwitched',
            isMobileView: this.isMobileView()
        };
        dnn.social.ipc.post(this.settings, 'DNNCorp/Ideas', msg);
    };
    
    dnn.ideas.DetailView.prototype.vote = function () {
        if (dnn.social.authorizationRequired(this.settings)) return true;
        if ($('.idea-vote-button', this.settings.moduleScope).hasClass('disabled')) return false;
        var options = $('.idea-vote-options', this.settings.moduleScope);
        if (options.is(':visible')) {
            options.fadeOut();
        } else {
            dnn.ideas.VoteButtons.setPanelSize(options);
            options.fadeIn();
        }
        return false;
    };

    dnn.ideas.DetailView.prototype.voteHandler = function (success, postCompletion) {
        var self = this;
        if (success) {
            setTimeout(
                function () {
                    self.initSuportersControl();
                    var voteOptionClass = self.isMobileView() ? '.dnnMobile-idea-vote-options' : '.idea-vote-options';
                    var options = $(voteOptionClass, self.settings.moduleScope);
                    if (options.is(':visible')) {
                        options.fadeOut(
                            function () {
                                if (typeof postCompletion === 'function') postCompletion();
                            });
                    }
                }, 0);
        }
    };


})(window.dnn, window.jQuery, window.ko);