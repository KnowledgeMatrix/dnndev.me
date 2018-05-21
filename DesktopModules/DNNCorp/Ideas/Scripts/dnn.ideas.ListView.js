// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn, $, ko) {
    
    dnn.ideas.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        dnn.social.ipc.register(this.settings, $.proxy(function (source, message) {
            if (!message || !message.event) return;
            switch (message.event) {
                case 'SwitchCategory':
                    this.category(message.category || 'topideas');
                    break;
            }
        }, this));
        
        this.register(this, 'PrimaryView');
        this.register(new dnn.ideas.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, ['.idea-vote-options']));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }

        this.init();
    };

    try{
        dnn.ideas.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.ideas.ListView.prototype.init = function () {
        var self = this;
        this.statusList = [
            { value: 'all', status: this.getString('Status.All') },
            { value: 'submitted', status: this.getString('Status.Submitted') },
            { value: 'underreview', status: this.getString('Status.UnderReview') },
            { value: 'reviewed', status: this.getString('Status.Reviewed') },
            { value: 'accepted', status: this.getString('Status.Accepted') },
            { value: 'scheduled', status: this.getString('Status.Scheduled') },
            { value: 'delivered', status: this.getString('Status.Delivered') },
            { value: 'duplicate', status: this.getString('Status.Duplicate') }
        ];

        this.sortOptions = [
            { value: 'votes', text: this.getString('SortByMostVotes') },
            { value: 'views', text: this.getString('SortByMostViews') },
            { value: 'lastactive', text: this.getString('SortByRecentActivity') },
            { value: 'createddate', text: this.getString('SortByDateCreated') },
            { value: 'author', text: this.getString('SortByAuthor') },
            { value: 'title', text: this.getString('SortByTitle') }
        ];

        this.votesRemaining = ko.observable(this.settings.votesRemaining || 0);
        this.allowNewIdeas = ko.observable(this.settings.allowNewIdeas);
        this.votingEnabled = this.settings.votingEnabled;
        this.votesPerIdea = this.settings.votesPerIdea;
        
        dnn.social.ListView.prototype.init.apply(this);

        this.vote = function(idea) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            $('.idea-vote-options', self.settings.moduleScope).hide();
            var control = $('#vote-panel-{0}'.format(idea.ideaId()), self.settings.moduleScope);
            if (!control.is(':visible')) {
                dnn.ideas.VoteButtons.setPanelSize(control);
                control.fadeIn();
            }
            return false;
        };
        
        this.voteMobileView = function (idea) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (!self.votingEnabled) return true;
            if (idea.isClosed() || idea.protected()) return true;

            $('.dnnMobile-idea-vote-options', self.settings.moduleScope).hide();
            $('td.dnnMobileIdeaVote > a').removeClass('voting');
            var control = $('#dnnMobile-vote-panel-{0}'.format(idea.ideaId()), self.settings.moduleScope);
            if (!control.is(':visible')) {
                control.prev().addClass('voting');
                control.fadeIn();
            }
            return false;
        };
    };

    dnn.ideas.ListView.prototype.addDialog = function(query) {
        var localizer = this.localizer();
        if ((this.votesRemaining() || 0) < 1 && this.votingEnabled) {
            $.dnnAlert({
                title: localizer.getString('RequiresVotesTitle'),
                text: localizer.getString('RequiresVotesText')
            });
            return false;
        }

        return dnn.social.ListView.prototype.addDialog.apply(this, [query]);
    };

    dnn.ideas.ListView.prototype.validateCategory = function (c) {
        if (c === 'myideas' || c === 'myvotes' || c === 'mycomments')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

    dnn.ideas.ListView.prototype.hideVote = function(callback) {
        var $voteOptions = this.isMobileView() ? $('.dnnMobile-idea-vote-options') : $('.idea-vote-options');
        $voteOptions.each(
            function (index, element) {
                if ($(element).is(':visible')) {
                    $(element).fadeOut(
                        function () {
                            if (typeof callback === 'function') callback();
                        });
                }
            });
    };

    dnn.ideas.ListView.prototype.voteHandler = function(success, callback) {
        if (success) {
            setTimeout($.proxy(function () {
                this.hideVote(callback);
            }, this), 100);
        }
    };

    dnn.ideas.ListView.prototype.windowsFocused = function() {
        if ($('.idea-vote-options').is(':visible')) {
            $('.idea-vote-options').fadeOut();
        }

        if ($('.dnnMobile-idea-vote-options').is(':visible')) {
            $('td.dnnMobileIdeaVote > a').removeClass('voting');
            $('.dnnMobile-idea-vote-options').fadeOut();
        }
    };

    dnn.ideas.ListView.prototype.addDialogMobileView = function (query) {
        var localizer = this.localizer();
        if ((this.votesRemaining() || 0) < 1 && this.votingEnabled) {
            $.dnnAlert({
                title: localizer.getString('RequiresVotesTitle'),
                text: localizer.getString('RequiresVotesText')
            });
            return false;
        }
        return dnn.social.ListView.prototype.addDialogMobileView.apply(this, [query]);
    };
    
    dnn.ideas.ListView.prototype.switchedView = function () {
        dnn.social.ListView.prototype.switchedView.apply(this);
        this.notifyViewSwitched();
    };

    dnn.ideas.ListView.prototype.notifyViewSwitched = function() {
        var msg = {
            event: 'ViewSwitched',
            isMobileView: this.isMobileView()
        };
        dnn.social.ipc.post(this.settings, 'DNNCorp/Ideas', msg);
    };
    
    dnn.ideas.ListView.prototype.binded = function () {
        dnn.social.ListView.prototype.binded.apply(this);
        this.notifyViewSwitched();
    };

})(window.dnn, window.jQuery, window.ko);
