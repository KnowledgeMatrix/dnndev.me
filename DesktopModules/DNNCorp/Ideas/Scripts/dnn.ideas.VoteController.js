// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function(dnn) {
    'use strict';

    dnn.ideas.VoteController = function VoteController($, ko, settings, social, model) {
        var that = this;

        this.componentFactory = social.getComponentFactory();

        this.service = social.getService('Detail');

        this.loading = function (b) {
            var control = $('.idea-vote-options');
            if (b) {
                control.addClass('voting');
            } else {
                control.removeClass('voting');
            }
        };

        this.onVoting = false;

        this.vote = function (value, completionHandler) {
            if (that.onVoting) return;
            that.onVoting = true;
            
            var success = function (m) {
                that.onVoting = false;
                var msg = {
                    event: 'SetVotesRemaining',
                    votesRemaining: m.VotesRemaining,
                    votesUsed: m.UserVotes.total
                };

                dnn.social.ipc.post(settings, 'DNNCorp/Ideas', msg);

                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                var postCompletionHandler = function() {
                    model.votes(m.Votes);
                    model.userVotes(m.UserVotes.votes);
                    that.setVotesRemaining(m.VotesRemaining);
                };
                
                if (typeof completionHandler === 'function') {
                    completionHandler(true, postCompletionHandler);
                }
            };

            var failure = function (xhr, status) {
                that.onVoting = false;
                if (typeof completionHandler === 'function') {
                    completionHandler(false, undefined, status);
                }
            };

            var params = {
                ideaId: model.ideaId(), vote: value, groupId: model.groupId()
            };

            that.service.post('Vote', params, success, failure, that.loading);
        };

        this.removeVotes = function (completionHandler) {
            if (that.onVoting) return;
            that.onVoting = true;
            
            var success = function (m) {
                that.onVoting = false;
                var msg = {
                    event: 'SetVotesRemaining',
                    votesRemaining: m.VotesRemaining,
                    votesUsed: m.UserVotes.total
                };

                dnn.social.ipc.post(settings, 'DNNCorp/Ideas', msg);

                var postCompletionHandler = function() {
                    model.votes(m.Votes);
                    model.userVotes(m.UserVotes.votes);
                    that.setVotesRemaining(m.VotesRemaining);
                };

                if (typeof completionHandler === 'function') {
                    completionHandler(true, postCompletionHandler);
                }
            };

            var failure = function (xhr, status) {
                that.onVoting = false;
                if (typeof completionHandler !== 'function') {
                    completionHandler(false, status);
                }
            };

            var params = {
                ideaId: model.ideaId()
            };

            that.service.post('RemoveVotes', params, success, failure, that.loading);
        };

        this.setVotesRemaining = function (votes) {
            var root = ko.contextFor($(settings.moduleScope)[0]).$root;

            if (typeof root !== 'undefined' &&
                typeof root.votesRemaining === 'function') {
                root.votesRemaining(votes < 0 ? 0 : votes);
            }
        };
    };
})(window.dnn);