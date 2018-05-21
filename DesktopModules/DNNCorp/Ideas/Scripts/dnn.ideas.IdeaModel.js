// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.ideas === 'undefined') dnn.ideas = {};

(function (dnn) {
    'use strict';
  
    dnn.ideas.IdeaModel = function IdeaModel($, ko, settings, social, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.socialController = social.getSocialController(this.contentItemId(), this);
        this.service = social.getService('Detail');
        this.voteButtons = new dnn.ideas.VoteButtons($, ko, settings, social, this);

        if (typeof this.initialVotes === 'undefined') {
            this.initialVotes = function (v) {
                if (typeof v === 'number') {
                    that.voteButtons.initialVotes(v);
                } else {
                    return that.voteButtons.initialVotes();
                }
                return null;
            };
        }

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

        this.voteStyle = ko.computed(function () {
            var votesNum = that.userVotes();
            if (votesNum > 0)
                return 'idea-vote-button dnnTertiaryAction activeIndicator';
            return 'idea-vote-button dnnTertiaryAction';
        });
        
        this.voteStyleForDetailView = ko.computed(function () {
            var votesNum = that.userVotes();
            if (votesNum > 0)
                return 'idea-vote-button dnnPrimaryAction activeIndicator';
            return 'idea-vote-button dnnPrimaryAction';
        });

        this.lockedStyle = ko.computed(function() {
            return 'idea-vote-button dnnTertiaryAction dnnDisabled';
        });

        this.userVotesLabel = ko.computed(function () {
            var votesNum = that.userVotes();
            if (votesNum > 1)
                return votesNum + ' ' + that.getString("Votes");
            if (votesNum > 0)
                return votesNum + ' ' + that.getString("Vote");
            return that.getString("Vote");
        });

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
                if (that.views() >= 0) {
                    return that.views();
                }

                return 0;
            });

        this.bookmarked = ko.computed(
            function () {
                return that.socialController.bookmarked();
            });

        this.commentSingular = ko.computed(
            function () {
                return that.commentCount() == 1;
            });

        this.commentPlural = ko.computed(
            function () {
                return that.commentCount() != 1;
            });

        this.statusClass = ko.computed(
            function () {
                switch (that.status()) {
                    case 0:
                        return 'status-submitted';
                    case 5:
                        return 'status-underreview';
                    case 33:
                        return 'status-reviewed';
                    case 15:
                        return 'status-accepted';
                    case 20:
                        return 'status-scheduled';
                    case 25:
                        return 'status-delivered';
                    case 30:
                        return 'status-duplicate';
                    default:
                        return new String();
                }
            });

        this.getLikeClass = function () {
            return that.liked() ? 'idea-comments-like-liked' : 'idea-comments-like';
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

        this.getLikeControlId = function() {
            return 'likes_{0}'.format(this.contentItemId());
        };
        
        this.getLikeControlMobileId = function () {
            return 'likes_{0}_mobile'.format(this.contentItemId());
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
        
        this.lock = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: that.getString('ProtectFailureTitle'),
                    text: that.getString('ProtectFailure').format(status || that.getString('UnknownError'))
                });
            };

            var success = function (m) {
                window.location.reload();
            };

            var params = {
                IdeaId: that.ideaId()
            };

            that.service.post('Protect', params, success, failure);
        };
        
        // Mobile View Properties
        this.userVotesLabelMobileView = ko.computed(function () {
            var votesNum = that.userVotes();
            if (votesNum > 1)
                return votesNum + '<br/>' + that.getString("Votes");
            if (votesNum > 0)
                return votesNum + '<br/>' + that.getString("Vote");
            return that.getString("Vote");
        });
    };
})(window.dnn);