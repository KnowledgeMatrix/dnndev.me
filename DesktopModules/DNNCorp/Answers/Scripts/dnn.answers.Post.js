// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.answers === 'undefined') dnn.answers = {};

(function(dnn) {
    'use strict';

    dnn.answers.Post = function Post($, ko, settings, social, model) {
        
        $.extend(this, dnn.social.komodel(model));
        
        var that = this;
        
        this.search = social.getComponentFactory().resolve('DetailController');

        this.service = social.getService('Detail');
        
        var localizer = social.getLocalizationController();

        this.comments = ko.observable();

        this.like = function (data, event) {
            that.socialController.like(data, event);
        };

        this.unlike = function (data, event) {
            that.socialController.unlike(data, event);
        };
        
        this.toggleLike = function (data, event) {
            return that.socialController.toggleLike(data, event);
        };

        this.bookmark = function (data, event) {
            that.socialController.bookmark(data, event);
        };

        this.unbookmark = function (data, event) {
            that.socialController.unbookmark(data, event);
        };

        this.subscribe = function (data, event) {
            that.socialController.subscribe(data, event);
        };

        this.unsubscribe = function (data, event) {
            that.socialController.unsubscribe(data, event);
        };

        this.voting = function(b) {
            var control = $('.answer-vote', settings.moduleScope);
            if (b) {
                control.addClass('loading');
            } else {
                control.removeClass('loading');
            }
        };

        this.answerContainerCss = ko.observable("detail-main-container answer-comment dnnClear");
        
        this.editable = ko.computed(
          function () {
              if (settings.canEdit || (settings.hasEditOwn && settings.currentUserId === that.createdUserId())) {
                  return true;
              }
              return false;
          });

        this.acceptButtonVisible = ko.computed(
            function() {
                return settings.canAcceptAnswer;
            });

        this.isAcceptedAnswer = ko.computed(
            function() {
                return that.answerId() == that.postId();
            });

        this.upVoteText = ko.computed(function() {
            if (settings.anonymous) return localizer.getString('VoteNotLogin');
            if (settings.currentUserId == that.createdUserId()) return localizer.getString('VoteOwnPost');
            if (!settings.hasUpVote) return localizer.getString('NoUpVotePriv');
            if (that.parentId() <= 0) return localizer.getString('VoteUpQuestion');
            return localizer.getString('VoteUpAnswer');
        });

        this.downVoteText = ko.computed(function () {
            if (settings.anonymous) return localizer.getString('VoteNotLogin');
            if (settings.currentUserId == that.createdUserId()) return localizer.getString('VoteOwnPost');
            if (!settings.hasDownVote) return localizer.getString('NoDownVotePriv');
            if (that.parentId() <= 0) return localizer.getString('VoteDownQuestion');
            return localizer.getString('VoteDownAnswer');
        });

        this.hasUpVote = ko.computed(function() {
            if (settings.hasUpVote) {
                if (settings.currentUserId == that.createdUserId()) return false;
                if (that.userScore() == 1) return false;
                return true;
            }
            return false;
        });

        this.hasDownVote = ko.computed(function() {
            if (settings.hasDownVote) {
                if (settings.currentUserId == that.createdUserId()) return false;
                if (that.userScore() == -1) return false;
                return true;
            }
            return false;
        });

        this.upVoteCss = ko.computed(function() {
            return 'qaTooltip answer-vote-upbtn' + (that.hasUpVote() ? '' : ' nohover');
        });
        
        this.downVoteCss = ko.computed(function () {
            return 'qaTooltip answer-vote-downbtn' + (that.hasDownVote() ? '' : ' nohover');
        });

        this.showModerationMenu = ko.computed(function () {
            return that.editable() || that.acceptButtonVisible();
        });

        this.hasAcceptedAnswer = ko.computed(
            function() {
                return that.answerId() > 0 ? "answer-answer-count answer-accepted" : "answer-answer-count";
            });

        this.onVote = false;

        this.upvote = function () {
            if (dnn.social.authorizationRequired(settings)) return;
            if (!that.hasUpVote()) return;
            if (that.onVote) return;
            that.onVote = true;

            var failure = function (xhr, status) {
                that.onVote = false;
                $.dnnAlert({
                    title: localizer.getString('VoteFailureTitle'),
                    text: localizer.getString('VoteFailure').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.onVote = false;
                that.score(m.score);
                that.userScore(that.userScore() + 1);
                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }

                dnn.social.EventQueue.push(
                    function () {
                        dnn.social.ipc.post({}, settings.moduleRoot, { event: 'UpVotePost' });
                    });
            };

            var params = {
                postId: that.postId(),
                parentId: that.parentId(),
                groupId: that.groupId()
            };
            
            var method = that.userScore() == -1 ? 'Downvote' : 'Upvote';
            that.service.post(method, params, success, failure, that.voting);
        };

        this.downvote = function () {
            if (dnn.social.authorizationRequired(settings)) return;
            if (!that.hasDownVote()) return;
            if (that.onVote) return;
            that.onVote = true;
            
            var failure = function (xhr, status) {
                that.onVote = false;
                $.dnnAlert({
                    title: localizer.getString('VoteFailureTitle'),
                    text: localizer.getString('VoteFailure').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (m) {
                that.onVote = false;
                that.score(m.score);
                that.userScore(that.userScore() - 1);
                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }
            };

            var params = {
                postId: that.postId(),
                parentId: that.parentId(),
                groupId: that.groupId()
            };

            var method = that.userScore() == 1 ? 'Upvote' : 'Downvote';
            that.service.post(method, params, success, failure, that.voting);
        };

        this.toggleAcceptedAnswer = function() {
            var failure = function(xhr, status) {
                $.dnnAlert({
                    title: localizer.getString('AcceptAnswerFailureTitle'),
                    text: localizer.getString('AcceptAnswerFailure').format(status || localizer.getString('UnknownError'))
                });
            };

            var success = function (answer) {
                if (method == 'UnacceptAnswer') {
                    that.answerId(0);
                    that.search.question.answerId(0);
                } else {
                    that.answerId(answer.PostId || 0);
                    that.search.question.answerId(answer.PostId || 0);
                }
                that.search.loadStart();
            };

            var params = {
                postId: that.postId(),
                parentId: that.parentId(),
                groupId: that.groupId()
            };

            var method = that.isAcceptedAnswer() ? 'UnacceptAnswer' : 'AcceptAnswer';
            that.service.post(method, params, success, failure, that.accepting);
        };
        
        this.edit = function() {
            if (dnn.social.authorizationRequired(settings)) return true;

            var failure = function (xhr, status) {
                $.dnnContentNotFoundAlert(localizer, status);
            };

            var success = function (revision) {
                if (model.revisionSequence != revision.sequence) {
                    model.revisionSequence = revision.sequence;
                    //model.approved = revision.approved;
                }
                model.body = revision.latestContent;
                that.continueEdit();
            };

            var params = {
                postId: model.postId,
                sequence: model.revisionSequence
            };

            return that.service.get('GetLastSequence', params, success, failure);
        };

        this.continueEdit = function () {
            var title = localizer.getString((that.parentId() > 0) ? 'EditAnAnswer' : 'EditAQuestion');

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: title,
                minWidth: 650,
                closeOnEscape: false,
				open: function() {
					$('.editor-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            		var $input = $('#' + $(this).attr('id').replace('_tag', ''));
						if ($input.data('dnnTagInput')) {
							$(this).dnnResetAutosize($input.data('dnnTagInput'));
						}
					});
				},
                resizable: false
            };

            var editModel = ko.contextFor($(settings.editId)[0]).$root;
            if (editModel) editModel.bindControls(model);
            $('.editor-dialog').dialog(options);
            return true;
        };

        this.deletePost = function() {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
            var primaryView = social.getComponentFactory().resolve('PrimaryView');
            var detailController = social.getComponentFactory().resolve('DetailController');
            var isMobileView = primaryView.isMobileView();
            var title = localizer.getString('ConfirmTitle');
            var text = that.parentId() > 0 ? localizer.getString('DeleteAnswerConfirm') : localizer.getString('DeleteQuestionConfirm');
            var callbackTrue = function() {
                var failure = function (xhr, status) {
                    $.dnnAlert({
                        title: localizer.getString('DeleteFailureTitle'),
                        text: localizer.getString('DeleteFailure').format(status || localizer.getString('UnknownError'))
                    });
                };

                var success = function (m) {
                    if (!that.parentId()) {
                        window.location.href = m.ReturnUrl;
                    } else {
                        if (isMobileView) {
                            var originalResults = detailController.resultsMobile();
                            var spliceIdx = -1;
                            for (var i = 0; i < originalResults.length; i++) {
                                if (that.postId() == originalResults[i].postId()) {
                                    spliceIdx = i;
                                    break;
                                }
                            }
                            if (spliceIdx > -1) {
                                originalResults.splice(spliceIdx, 1);
                                detailController.resultsMobile(originalResults);
                            }

                            spliceIdx = -1;
                            originalResults = detailController.results();
                            for (var j = 0; j < originalResults.length; j++) {
                                if (that.postId() == originalResults[j].postId()) {
                                    spliceIdx = j;
                                    break;
                                }
                            }
                            if (spliceIdx > -1) {
                                originalResults.splice(spliceIdx, 1);
                                detailController.results(originalResults);
                            }
                        } else {
                            if (detailController.results().length === 1 && primaryView.pager().page() > 0) {
                                primaryView.prev();
                            } else {
                                detailController.load();
                            }
                        }
                    }
                };

                var params = {
                    postId: that.postId(),
                    parentId: that.parentId(),
                    groupId: that.groupId(),
                    contentItemId: that.contentItemId()
                };

                that.service.post('DeletePost', params, success, failure);
            };
            var dialogOptions = {
                autoOpen: true,
                open: $.ui.dialog.prototype.options.open,
                close: $.ui.dialog.prototype.options.close,
                buttons: [
                    {
                        text: localizer.getString('Yes'),
                        click: function () {
                            confirmDialog.dialog("close");
                            callbackTrue();
                        },
                        'class': 'dnnPrimaryAction'
                    },
                    {
                        text: localizer.getString('No'),
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
            
            if (isMobileView) {
                dialogOptions = dnn.social.MobileView.dialogOptions({
                    title: title,
                    autoOpen: true,
                    buttons: [
                    {
                        text: localizer.getString('Yes'),
                        click: function () {
                            confirmDialog.dialog("close");
                            callbackTrue();
                        },
                        'class': 'dnnPrimaryAction'
                    },
                    {
                        text: localizer.getString('No'),
                        click: function () {
                            confirmDialog.dialog("close");
                        },
                        'class': 'dnnSecondaryAction'
                    }
                    ]
                });
            } 

            var confirmDialog = $("<div class='dnnDialog'></div>").html(text)
                .dialog(dialogOptions);
            return true;
        };

        this.accepting = function(b) {
            var control = $('#answer-id-{0}'.format(that.postId()), settings.moduleScope);
            if (b) {
                control.addClass('accepting');
            } else {
                control.removeClass('accepting');
            }
        };

        this.reportComment = function() {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }

            dnn.social.reportComment(that.postId());
        };

        this.reportAnswer = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            dnn.social.reportContent(that.postId());
        };

        this.replyComment = function() {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            var control = that.getCommentControl();
            if (control == null) {
                return false;
            }

            var root = ko.contextFor(control).$root;
            if (root != null) {
                root.reply();
            }

            return false;
        };

        this.report = function() {
            if (dnn.social.authorizationRequired(settings)) {
                return;
            }
            dnn.social.reportContent(that.contentItemId());
        };

        this.showNoAnswer = ko.computed(
            function() {
                if (that.hasOwnProperty('totalAnswers')) {
                    return that.totalAnswers() == 0;
                }

                return true;
            });

        this.getObjectKey = function () {
            var contentType = settings.contentType;

            var subType;

            var priId, secId;
            
            if (that.parentId() > 0) {
                subType = 'answer';

                priId = that.parentId();
                secId = that.postId();
            } else {
                subType = 'question';

                priId = settings.moduleId;
                secId = that.postId();
            }

            return '{0}_{1}_{2}:{3}'.format(contentType, subType, priId, secId);
        };

        this.getCommentControl = function () {
            var container;
            var primaryView = social.getComponentFactory().resolve('PrimaryView');
            if (!primaryView || typeof primaryView.isMobileView !== 'function') return null;
            if (primaryView.isMobileView()) {
                if (that.parentId() > 0) {
                    container = $('#mobile-answer-id-{0}'.format(that.postId()));
                } else {
                    container = $('.mobile-info-panel');
                }
            } else {
                if (that.parentId() > 0) {
                    container = $('#answer-id-{0}'.format(that.postId()));
                } else {
                    container = $('.info-panel');
                }
            }
            
            if (container == null || container.length == 0) {
                return null;
            }

            return that.getChildControl($('.commentsControl'), container);
        };

        this.getChildControl = function (children, container) {
            var body = document.getElementsByTagName('body')[0];

            for (var i = 0; i < children.length; ++i) {
                var parent = $(children[i]).parent();

                while (parent[0] != body) {
                    if (parent.length > 0 && parent[0].id == container[0].id) {
                        return children[i];
                    }
                    parent = $(parent).parent();
                }
            }
            return null;
        };

        this.getLikeControlId = function () {
            return 'likes_{0}'.format(this.contentItemId());
        };

        this.getLikeControlMobileId = function() {
            return 'likes_{0}_mobile'.format(this.contentItemId());
        };

        this.socialController = social.getSocialController(this.contentItemId(), this, this.getObjectKey());
        
        // mobile properties
        this.answerCountListViewMobile = ko.computed(function () {
            var css = 'dnnMobileIdeaVote answer-answerCount';
            if (typeof that.totalAnswers === 'function' && that.totalAnswers() == 0) css += ' activeIndicator answer-noanswer';
            else if (typeof that.answerId === 'function' && that.answerId() > 0) css += ' activeIndicator answer-accepted';
            return css;
        });

        this.bindControls = function () {
            if (typeof dnn.social.initLikeControl === 'function') {
                dnn.social.initLikeControl().bindControls($('#' + this.getLikeControlId() + ',#' + this.getLikeControlMobileId()));
            }
            
            var primaryView = social.getComponentFactory().resolve('PrimaryView');
            var isMobile = primaryView.isMobileView();
            if (!isMobile) {
                $('.answer-moderator-menu').click(function (e) {
                    $(e.target).closest('ul.comment-actions-dropdown').hide();
                }).hoverIntent({
                    over: function () {
                        $('ul.comment-actions-dropdown', $(this)).show();
                    },
                    out: function () {
                        $('ul.comment-actions-dropdown', $(this)).hide();
                    },
                    timeout: 300,
                    interval: 150
                });
            }

            var control = that.getCommentControl();
            if (control == null) {
                return;
            }

            var hoverCardSettings = $.extend({}, settings);
            hoverCardSettings.moduleScope = $('.comment-context-card', control).parent()[0];
            var hoverCardSocial = new dnn.social.Module(settings);
            var hovercard = new dnn.social.HoverCard($, ko, hoverCardSettings, hoverCardSocial, $('.comment-context-card', hoverCardSettings.moduleScope));
            dnn.social.bindCommentContext = function (scope) {
                hovercard.bindScope(scope);
            };

            dnn.social.hideCommentContext = function () {
                hovercard.hide();
            };
            ko.applyBindings(hovercard, hoverCardSettings.moduleScope);

            var s = $.extend({}, settings);
            s.moduleScope = control;
            s.contentItemId = that.contentItemId();
            s.journalTypeId = -1;
            s.objectKey = that.getObjectKey();
            s.pageSize = 3;
            s.autoreload = false;
            s.canModerate = settings.canEdit;
            s.inline = true;
            s.actions = {};
            var isQuestion = that.parentId() <= 0;
            s.actions.posted = isQuestion ? "CommentedOnQuestion" : "CommentedOnAnswer";
            s.actions['delete'] = "DeletedPostComment";

            var commentcontrol = new dnn.social.CommentControl($, ko, s);
            ko.applyBindings(commentcontrol, s.moduleScope);
            commentcontrol.binded();
            
            $('.qaTooltip', settings.moduleScope).qaTooltip();
        };

        this.moveAnswerToComment = function () {
            dnn.social.contentExchange({
                methodName: 'MoveChildToComment',
                actionTitle: localizer.getString('Move'),
                actionTitle2: localizer.getString('ToComment'),
                childId: that.postId(),
                summary: that.body(),
                sourceContentType: localizer.getString('Answer'),
                includeSelfContentItem: true,
                initalTextSearch: that.contentTitle()
            });
        };


        this.moveAnswer = function () {
            dnn.social.contentExchange({
                methodName: 'Move',
                actionTitle: localizer.getString('Move'),
                childId: that.postId(),
                summary: that.body(),
                sourceContentType: localizer.getString('Answer')
            });
        };

        this.copyAnswer = function () {
            dnn.social.contentExchange({
                methodName: 'Copy',
                actionTitle: localizer.getString('Copy'),
                childId: that.postId(),
                summary: that.body(),
                sourceContentType: localizer.getString('Answer')
            });
        };

        this.showNotificationWindow = function (isErrorMessage, textMessage) {
            if (isErrorMessage) {
                $.dnnNotif({
                    dialogClass: 'noTittle',
                    outline: 'none',
                    type: 'warning',
                    height: 50,
                    styleBlue: true,
                    text: textMessage,
                    buttons: {}
                });
            } else {
                $.dnnNotif({
                    dialogClass: 'noTittle',
                    outline: 'none',
                    height: 40,
                    styleBlue: true,
                    text: textMessage,
                    buttons: {}
                });
            }
        };

        this.createTicket = function (data, event) {
            var params = {
                postId: that.postId(),
                parentId: that.parentId(),
                groupId: that.groupId(),
                contentItemId: that.contentItemId()
            };
            $(event.srcElement).hide();

            that.service.post('CreateTicket', params,
                function () {
                    $(event.srcElement).show();
                    that.hasTicket(true);
                    that.showNotificationWindow(false, localizer.getString('TicketCreatedSuccessfully'));
                },
                function (xhr) {
                    $(event.srcElement).show();
                    var message = JSON.parse(xhr.responseText).Message;
                    that.showNotificationWindow(true, message);
                });
        };
    };
})(window.dnn);