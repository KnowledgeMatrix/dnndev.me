// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function (dnn) {
    'use strict';

    dnn.social.Comment = function Comment($, ko, settings, social, contentItemId, model) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));

        this.service = social.getService('Social');
        this.localizer = social.getLocalizationController();

        this.control = social.getComponentFactory().resolve('CommentControl');

        this.poster = new dnn.social.CommentPostController($, ko, settings, social, contentItemId);

        this.likesCount = ko.computed(function () {
            return that.likes() > 0 ? that.likes() : '';
        });

        this.canDelete = ko.computed(function () {
            return model.CanDelete || settings.canModerate;
        });

        this.canEdit = ko.computed(function () {
            return model.CanEdit;
        });

        this.canModerate = ko.observable(settings.canModerate);

        this.approved = ko.observable(model.approved);

        this.like = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.liked() == false) {
                var success = function (m) {
                    if (m && m.LikeList) {
                        that.likeString(m.LikeList);
                    } else {
                        that.likeString({ Big: '', Small: '' });
                    }

                    bindLikeControl();

                    dnn.social.EventQueue.push(
                        function () {
                            dnn.social.ipc.post({}, settings.moduleRoot, { event: 'LikeComment' });
                        });
                };

                var failure = function () {
                    that.liked(false);
                    that.likes(that.likes() - 1);
                };

                that.liked(true);
                that.likes(that.likes() + 1);

                that.call('LikeComment', undefined, success, failure);
            }

            return false;
        };

        this.unlike = function (data, event) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            if (that.liked() == true) {
                var success = function (m) {
                    $(event.srcElement).show();
                    if (m && m.LikeList) {
                        that.likeString(m.LikeList);
                    } else {
                        that.likeString({ Big: '', Small: '' });
                    }

                    bindLikeControl();
                };

                var failure = function () {
                    $(event.srcElement).show();
                    that.liked(true);
                    that.likes(that.likes() + 1);
                };

                that.liked(false);
                if (that.likes() > 0) {
                    that.likes(that.likes() - 1);
                }

                $(event.srcElement).hide();
                that.call('UnlikeComment', undefined, success, failure);
            }

            return false;
        };

        this.toggleLike = function (data, event) {
            if (that.liked()) {
                that.unlike(data, event);
            } else {
                that.like(data, event);
            }
        };

        this.report = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }

            dnn.social.reportComment(that.commentId());
        };

        this.reply = function () {
            var text = that.getReplyText();

            that.poster.comment(text);

            that.poster.reply(that.getReplyContext(), text);

            dnn.social.EventQueue.push(
                function () {
                    var control = $('#social-comment-{0} textarea.message'.format(that.commentId()));
                    if (control.length > 0) {
                        dnn.social.setControlCursor(control, text.length);
                    }
                });
        };

        this.remove = function () {
            if (!that.canDelete()) {
                $.dnnAlert({
                    title: that.localizer.getString('CannotDeleteCommentTitle'),
                    text: that.localizer.getString('CannotDeleteComment').format(localizer.getString('PermissionDenied'))
                });
            } else {
                var text = that.localizer.getString('ConfirmDeleteComment');
                var title = that.localizer.getString('ConfirmDeleteCommentTitle');

                var callback = function () {
                    var success = function () {
                        var indexOf = that.control.comments().indexOf(that);
                        var indexOfMobileView = that.control.commentsMobileView.indexOf(that);
                        if (indexOf >= 0) {
                            that.control.comments.splice(indexOf, 1);
                            that.control.commentsMobileView.splice(indexOfMobileView, 1);
                            that.control.totalResults(that.control.totalResults() - 1);

                            if (that.control.comments().length === 0) {
                                var pager = social.getComponentFactory().resolve('PagingControl');
                                if (pager && pager.page() > 0) {
                                    pager.page(pager.page() - 1);
                                    that.control.load();
                                    return;
                                }
                            }
                            that.control.toggleCommentsControlTitle(that.control.comments().length > 0);
                        }
                    };

                    var failure = function (xhr, status) {
                        $.dnnAlert({
                            title: that.localizer.getString('CannotDeleteCommentTitle'),
                            text: that.localizer.getString('CannotDeleteComment')
                                .format(status || that.localizer.getString('UnknownError'))
                        });
                    };

                    var params = {
                        commentId: that.commentId(),
                        contentItemId: settings.contentItemId,
                        groupId: settings.groupId === null ? -1 : settings.groupId,
                        action: settings.actions['delete']
                    };

                    that.service.post('DeleteComment', params, success, failure, that.working);
                };

                var dialogOptions = {
                    autoOpen: true,
                    open: $.ui.dialog.prototype.options.open,
                    close: $.ui.dialog.prototype.options.close,
                    buttons: [
                        {
                            text: that.localizer.getString('Yes'),
                            click: function () {
                                confirmDialog.dialog("close");
                                callback();
                            },
                            'class': 'dnnPrimaryAction'
                        },
                        {
                            text: that.localizer.getString('No'),
                            click: function () {
                                confirmDialog.dialog("close");
                            },
                            'class': 'dnnSecondaryAction'
                        }
                    ],
                    modal: true,
                    dialogClass: 'dnnFormPopup dnnClear',
                    title: title,
                    resizable: false
                };

                if (that.control.isMobileView()) {
                    dialogOptions = dnn.social.MobileView.dialogOptions({
                        title: title,
                        autoOpen: true,
                        buttons: [
                            {
                                text: that.localizer.getString('Yes'),
                                click: function () {
                                    confirmDialog.dialog("close");
                                    callback();
                                },
                                'class': 'dnnPrimaryAction'
                            },
                            {
                                text: that.localizer.getString('No'),
                                click: function () {
                                    confirmDialog.dialog("close");
                                },
                                'class': 'dnnSecondaryAction'
                            }
                        ]
                    });
                }

                var confirmDialog = $("<div class='dnnDialog'></div>").html(text).dialog(dialogOptions);
            }
        };

        this.approve = function () {
            var text = that.localizer.getString('ConfirmApproveComment');
            var title = that.localizer.getString('ConfirmApproveCommentTitle');

            var callback = function () {
                var success = function () {
                    that.approved(true);
                };

                var failure = function (xhr, status) {
                    $.dnnAlert({
                        title: that.localizer.getString('CannotApproveCommentTitle'),
                        text: that.localizer.getString('CannotApproveComment')
                            .format(status || that.localizer.getString('UnknownError'))
                    });
                };

                var params = {
                    commentId: that.commentId(),
                    contentItemId: settings.contentItemId,
                    groupId: settings.groupId === null ? -1 : settings.groupId,
                    action: settings.actions.posted
                };

                that.service.post('ApproveComment', params, success, failure, that.working);
            };

            var confirmDialog = $("<div class='dnnDialog'></div>").html(text)
                .dialog({
                    autoOpen: true,
                    buttons: [
                        {
                            text: that.localizer.getString('Yes'),
                            click: function () {
                                confirmDialog.dialog("close");
                                callback();
                            },
                            'class': 'dnnPrimaryAction'
                        },
                        {
                            text: that.localizer.getString('No'),
                            click: function () {
                                confirmDialog.dialog("close");
                            },
                            'class': 'dnnSecondaryAction'
                        }
                    ],
                    modal: true,
                    dialogClass: 'dnnFormPopup dnnClear',
                    title: title,
                    resizable: false
                });
        };

        this.getLastSequence = function (continueWith) {
            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(that.localizer, status);
            };

            var success = function (revision) {
                if (model.Sequence != revision.sequence) {
                    $.dnnRevisionChangePrompt(that.localizer, continueWith);
                } else {
                    continueWith();
                }
            };

            var params = {
                commentId: model.CommentId,
                sequence: model.Sequence
            };

            that.service.get('GetLastCommentSequence', params, success, failure);
        };

        this.saveComment = function (newComment) {
            that.getLastSequence(function () {
                that.continueSaveComment(newComment);
            });
        };

        this.continueSaveComment = function (newComment) {
            var originalComment = this.decodedContent();
            var originalCommentObject = $('<div>' + originalComment + '</div>');
            var contextLink = originalCommentObject.find('a.comment-context');
            var contextTag = [];
            var contextText = '';
            if (contextLink.length) {
                contextTag.push(parseInt(contextLink.attr('post-context')));
                contextText = contextLink[0].innerHTML;
            }

            this.poster.updatePost(this, newComment, contextTag, contextText);
        };

        this.edit = function () {
            if (model.CommentId == -1) {
                that.continueEdit();
                return;
            }

            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(that.localizer, status);
            };

            var success = function (revision) {
                if (model.Sequence != revision.sequence) {
                    that.sequence = model.Sequence = revision.sequence;
                    that.comment(model.Comment = revision.latestContent);
                    that.approved(model.approved = revision.approved);
                }
                that.continueEdit();
            };

            var params = {
                commentId: model.CommentId,
                sequence: model.Sequence
            };

            that.service.get('GetLastCommentSequence', params, success, failure);
        };

        this.continueEdit = function () {
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: "Update Comment",
                minWidth: 465,
                resizable: false
            };

            dnn.social.editDialog = $($('.comment-update-dialog')[0]);
            dnn.social.editCommentModel = this;
            var $message = $('.message', dnn.social.editDialog);
            var decodedForEditContent = this.decodeForEdit(this.decodedContent());
            if ($message.is('textarea')) {
                $message.val(decodedForEditContent);
            } else {
                options.open = function () {
                    dnn.social.initUserMentions($message, settings.moduleId, settings.moduleName, true);
                },
                $message.html(decodedForEditContent);
            }
            dnn.social.editDialog.dialog(options);
        };

        this.working = function (b) {
            var control = $('#social-comment-{0}'.format(that.commentId()));
            if (b) {
                control.addClass('loading');
            } else {
                control.removeClass('loading');
            }
        };

        this.navigateToAuthor = function () {
            if (String.isEmpty(that.authorProfileUrl()) == false) {
                window.location = that.authorProfileUrl();
            }
        };

        this.getReplyText = function () {
            return '@{0} '.format(that.displayName());
        };

        this.getReplyContext = function () {
            return [that.commentId()];
        };

        this.decodedContent = ko.computed(
            function () {
                return that.comment();
            });

        this.decodeForEdit = function (s) {
            if ((s || new String()).length == 0) {
                return s;
            }
            //s = s.replace(/<br\s*\/>/g, "\n");
            // TODO: User Mentions need html, we need to check where the comments can have html and replace everything but user mentions links.
            //var decoded = $('<div />').html(s).text();
            return s;
        };

        this.likeClass = ko.computed(
            function () {
                if (that.liked()) {
                    return 'comment-like-liked';
                } else {
                    return 'comment-like';
                }
            });

        this.authoringClass = ko.computed(
            function () {
                return that.poster.authoring() ? ' authoring' : '';
            });

        this.call = function (method, args, successHandler, failureHandler) {
            var success = function (m) {
                if (typeof successHandler === 'function') {
                    successHandler(m);
                }
            };

            var failure = function (xhr, status) {
                if (typeof failureHandler === 'function') {
                    failureHandler(xhr, status);
                }
            };

            var params = {
                commentId: that.commentId()
            };

            if (typeof args !== 'undefined') {
                $.extend(params, args);
            }

            that.service.post(method, params, success, failure);
        };

        this.getLikeControlId = function () {
            return 'commentlikes_{0}'.format(this.commentId());
        };

        this.getLikeControlMobileId = function () {
            return 'commentlikes_{0}_mobile'.format(this.commentId());
        };

        this.bindControls = function () {

        };

        var bindLikeControl = function () {
            if (typeof dnn.social.initLikeControl === 'function') {
                var container = '';
                if (typeof that.getLikeControlId === 'function') container = '#' + that.getLikeControlId();
                if (typeof that.getLikeControlMobileId === 'function') container += ', #' + that.getLikeControlMobileId();

                if (container) {
                    dnn.social.initLikeControl().bindControls($(container));
                } else {
                    dnn.social.initLikeControl().bindControls();
                }
            }
        };

        this.moveComment = function () {
            dnn.social.contentExchange({
                methodName: 'MoveComment',
                actionTitle: that.localizer.getString('Move'),
                commentId: model.CommentId,
                summary: model.Comment,
                sourceContentType: that.localizer.getString('Comment')
            });
        };

        this.copyComment = function () {
            dnn.social.contentExchange({
                methodName: 'CopyComment',
                actionTitle: that.localizer.getString('Copy'),
                commentId: model.CommentId,
                summary: model.Comment,
                sourceContentType: that.localizer.getString('Comment')
            });
        };

    };
})(window.dnn);