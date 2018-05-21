// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.HoverCard = function HoverCard ($, ko, settings, social, container) {
        var that = this;
        var div = $(container);

        this.loading = ko.observable(true);
        this.profile = ko.observable();
        this.comment = ko.observable();
        this.commentId = ko.observable();
        this.userId = ko.observable();
        this.userIsDeleted = ko.observable();

        this.commentHoverEvent = function (commentId, pos, left) {
            if (that.commentId() != commentId) {
                that.profile(undefined);
                that.comment(undefined);

                var styles = { top: pos.top - div.height(), left: pos.left + left };
                div.animate(styles).fadeIn('fast');

                that.loadCommentContext(commentId);
            }
        };

        this.loadUserProfile = function (userId) {
            that.privateLoadContext(userId, undefined);
        };

        this.loadCommentContext = function (commentId) {
            that.privateLoadContext(undefined, commentId);
        };

        this.commentSummarized = ko.observable(false);

        this.commentSummary = ko.observable('');        

        this.seeFullComment = function () {
            if (that.commentSummarized()) {
                that.commentSummary(that.comment().decodedContent());
                that.commentSummarized(false);
            }
        };

        this.notMe = ko.observable(false);

        this.isFollowed = ko.observable(false);

        this.follow = function () {
            var service = social.getService('Social');
            
            var success = function () {
                that.isFollowed(!that.isFollowed());
            };
            
            var failure = function (xhr, status) {
                div.fadeOut('fast');
            };

            var method = null;
            if (that.isFollowed()) {
                method = 'Unfollow';
            }
            else {
                method = 'Follow';
            }

            var params = {
                userId: that.profile().userId()
            };

            service.post(method, params, success, failure, that.loading);
        };

        this.privateLoadContext = function (userId, commentId) {
            var service = social.getService('Social');

            var success = function (m) {
                if (typeof m.User !== 'undefined') {
                    that.profile(dnn.social.komodel(m.User));
                }
                
                that.isFollowed(m.IsFollowed);
                that.notMe(!m.IsMe);
                that.userIsDeleted(m.UserIsDeleted);
                
                if (typeof m.Comment !== 'undefined') {
                    that.comment(new dnn.social.Comment($, ko, settings, social, -1, m.Comment));
                    
                    var comment = that.comment();
                    that.commentSummarized(false);
                    if (comment) {
                        var content = comment.decodedContent();
                        var ret = '';
                        var array = content.split(' ');
                        for (var i = 0; i < array.length; i++) {
                            var word = array[i];
                            if ((ret.length + word.length + 1) < 250) {
                                ret += ret.length > 0 ? ' ' + word : word;
                            }
                            else {
                                that.commentSummarized(true);
                                ret += '...';
                                break;
                            }
                        }
                        that.commentSummary(ret);
                    }
                }
            };

            var failure = function (xhr, status) {
                div.fadeOut('fast');
            };

            var params = undefined;
            
            if (typeof commentId !== 'undefined') {
                that.commentId(commentId);
                that.userId(undefined);

                params = {
                    commentId: that.commentId()
                };
            }
            else if (typeof userId === 'number') {
                that.commentId(undefined);
                that.userId(userId);

                params = {
                    userId: userId
                };
            }

            service.get('GetCommentContext', params, success, failure, that.loading);
        };

        this.hide = function () {
            if (!div.is(':visible')) {
                return;
            }

            div.fadeOut('fast',
                function () {
                    that.userId(undefined);
                    that.commentId(undefined);
                    that.comment(undefined);
                    that.profile(undefined);
                });
        };
        
        this.bindScope = function (scope, root) {
            if (root && root.isMobileView && root.isMobileView()) {
                return;
            }
            $('.comment-context', scope).each(
                function() {
                    var commentId = $(this).attr('post-context');
                    $(this).unbind('mouseover').on('mouseover',
                        function (e) {
                            that.showContext(commentId, this);
                        });
                });
        };

        this.showContext = function (commentId, ctrl) {
            var pos = $(ctrl).position();
            var left = $(ctrl).outerWidth();
            that.commentHoverEvent(commentId, pos, left);
            return false;
        };
    };
})(window.dnn);