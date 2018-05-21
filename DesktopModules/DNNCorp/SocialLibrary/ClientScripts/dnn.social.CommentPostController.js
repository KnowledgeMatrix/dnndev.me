// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';
    
    dnn.social.CommentPostController = function CommentPostController ($, ko, settings, social, contentItemId) {
        var that = this;

        var componentFactory = social.getComponentFactory();

        this.service = componentFactory.resolve('ServiceCaller');

        this.control = componentFactory.resolve('CommentControl');

        this.pager = componentFactory.resolve('PagingControl');

        this.comment = ko.observable();

        this.replyText = ko.observable();

        this.authoring = ko.observable(false);

        this.tagged = ko.observableArray();

        this.inlineLoginPost = function () {
            
            var localizer = social.getLocalizationController();

            var replyText = that.replyText();

            var inlineLoginAction = that.control.inlineLoginAction();

            var loginUserName = that.control.inlineLoginUserName();
            
            var loginPassword = that.control.inlineLoginPassword();

            var registrationUserName = that.control.inlineRegistrationUserName();
            
            var registrationEmail = that.control.inlineRegistrationEmail();

            var invalid = typeof that.comment() === 'undefined' || String.isEmpty(that.comment());

            if (!invalid && typeof replyText === 'string') {
                var rawComment = that.comment().replace(replyText, '');
                invalid = String.isEmpty(rawComment);
            }
            
            if (invalid) {
                $.dnnAlert({
                    title: localizer.getString('NoCommentTitle'),
                    text: localizer.getString('NoComment')
                });
                return;
            }
            
          
            if (inlineLoginAction === 'login') {
                if (!loginUserName || !loginPassword) {
                    $.dnnAlert({
                        title: localizer.getString('NoCommentTitle'),
                        text: localizer.getString('CommentIncompleteLogin')
                    });
                    return;
                }
            }
            
            if (inlineLoginAction === 'registration') {
                
                if (!registrationEmail) {
                    $.dnnAlert({
                        title: localizer.getString('NoCommentTitle'),
                        text: localizer.getString('CommentIncompleteEmail')
                    });
                    return;
                }
                
                var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (!re.test(registrationEmail)) {
                    $.dnnAlert({
                        title: localizer.getString('NoCommentTitle'),
                        text: localizer.getString('CommentInvalidEmail')
                    });
                    return;
                }
            }

            var failure = function (xhr, status) {
                var msg = status || localizer.getString('UnknownError');

                $.dnnAlert({
                    title: localizer.getString('PostCommentFailureTitle'),
                    text: localizer.getString('PostCommentFailure').format(msg)
                });
            };

            var success = function (m) {
                if (typeof m === 'undefined' ||
                        typeof m.Comment === 'undefined' ||
                        typeof m.Comment.CommentId === 'undefined' ||
                        m.Comment.CommentId < 0) {

                    var errorMessage = typeof m === 'string' ? m : localizer.getString('PostCommentFailure').format(localizer.getString('UnknownError'));
                    $.dnnAlert({
                        title: localizer.getString('PostCommentFailureTitle'),
                        text: errorMessage
                    });

                    return;
                }

                if (m.Message) {
                    $.dnnAlert({
                        title: 'Comment Posted',
                        text: m.Message,
                        callback: function() {
                            window.location.hash = 'commentPage=' + m.PageIndex;
                            window.location.reload();
                        }
                    });
                    
                    return;
                }

                window.location.hash = 'commentPage=' + m.PageIndex;
                window.location.reload();
            };

            var params = {
                action: settings.actions.posted,
                journalTypeId: settings.journalTypeId || -1,
                contentItemId: contentItemId,
                groupId: settings.groupId || -1,
                objectKey: settings.objectKey || null,
                comment: that.comment(),
                pageSize: settings.pageSize || 5,
                context: that.tagged(),
                canModerate: settings.canModerate
            };

            var method = 'PostCommentWithLogin';
            
            if (inlineLoginAction == 'login') {
                params.username = loginUserName;
                params.password = loginPassword;
            }
            
            if (inlineLoginAction == 'registration') {
                params.username = registrationUserName;
                params.email = registrationEmail;
                method = 'PostCommentWithRegistration';
            }
            
            that.service.post(method, params, success, failure, that.posting);
        };

        this.post = function (data, event) {
            
            if(event && event.target) $(event.target).addClass('disabled');

            var localizer = social.getLocalizationController();

            var replyText = that.replyText();

            var invalid = typeof that.comment() === 'undefined' || String.isEmpty(that.comment());
            
            if (!invalid && typeof replyText === 'string') {
                var rawComment = that.comment().replace(replyText, '');
                invalid = String.isEmpty(rawComment);
            }

            if (invalid) {
                if (event && event.target) $(event.target).removeClass('disabled');
                $.dnnAlert({
                    title: localizer.getString('NoCommentTitle'),
                    text: localizer.getString('NoComment')
                });
                return;
            }

            var failure = function (xhr, status) {
                if (event && event.target) $(event.target).removeClass('disabled');
                var msg = status || localizer.getString('UnknownError');
                
                $.dnnAlert({
                    title: localizer.getString('PostCommentFailureTitle'),
                    text: localizer.getString('PostCommentFailure').format(msg)
                });
            };

            var success = function (m) {
                if (event && event.target) $(event.target).removeClass('disabled');
                if (!m || !m.Comment || !m.Comment.CommentId || m.Comment.CommentId < 0) {
                    $.dnnAlert({
                        title: localizer.getString('PostCommentFailureTitle'),
                        text: localizer.getString('PostCommentFailure').format(localizer.getString('UnknownError'))
                    });
                    return;
                }
                
                that.comment(new String());
                if (typeof settings.autoreload === 'undefined' || settings.autoreload === true) {
                    that.control.frozen(true);
                    if (that.control.mostRecentFirst()) {
                        that.pager.page(0);
                    } else {
                        if (that.pager.page() != m.PageIndex) {
                            that.pager.page(m.PageIndex);
                        }
                    }
                    
                    that.control.frozen(false);
                    that.control.load();
                } else {
                    that.control.comments.push(new dnn.social.Comment($, ko, settings, social, settings.contentItemId, m.Comment));
                    that.control.sort();
                    if (!that.control.isMobileView()) {
                        $('html body').animate({ scrollTop: $(settings.moduleScope).offset().top + ($(settings.moduleScope).height() * 1.5) }, 350, 'swing');
                    }
                    that.control.initEditControls();
                }

                that.cancel();
                
                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }
                
                dnn.social.EventQueue.push(function () {
                    dnn.social.ipc.post({}, settings.moduleRoot, { event: 'PostComment' });
                });
            };
            
            var params = {
                action: settings.actions.posted,
                journalTypeId: settings.journalTypeId || -1,
                contentItemId: contentItemId,
                groupId: settings.groupId || -1,
                objectKey: settings.objectKey || null,
                comment: that.comment(),
                pageSize: settings.pageSize || 5,
                context: that.tagged(),
                canModerate: settings.canModerate
            };

            that.service.post('PostComment', params, success, failure, that.posting);
        };

        this.posting = function (b) {
            var c = $('.comment-post', settings.moduleScope);
            if (b) {
                c.addClass('loading');
            }
            else {
                c.removeClass('loading');
            }
        };

        this.updatePost = function (updatedComment, newComment, contextTag, contextText) {
            
            var localizer = social.getLocalizationController();

            var invalid = !updatedComment || typeof newComment === 'undefined' || !newComment || String.isEmpty(newComment);

            if (!invalid && typeof contextText === 'string') {
                var rawComment = newComment.replace(contextText, '');
                invalid = String.isEmpty(rawComment);
            }

            if (invalid) {
                $.dnnAlert({
                    title: localizer.getString('NoCommentTitle'),
                    text: localizer.getString('NoComment')
                });
                return;
            }
            
            var failure = function (xhr, status) {
                var msg = status || localizer.getString('UnknownError');

                $.dnnAlert({
                    title: localizer.getString('PostCommentFailureTitle'),
                    text: localizer.getString('PostCommentFailure').format(msg)
                });
            };

            var success = function () {
                if (typeof settings.autoreload === 'undefined' || settings.autoreload === true) {
                    that.control.load();
                } else {
                    if (!that.control.rolledup()) {
                        that.control.load(null, that.control.totalResults());
                    } else {
                        that.control.load();
                    }
                }
                that.control.cancelUpdate();
            };

            var params = {
                contentItemId: contentItemId,
                comment: newComment,
                commentId: updatedComment.commentId(),
                context: contextTag
            };

            that.service.post('UpdateComment', params, success, failure, that.updatePosting);

        };
        
        this.updatePosting = function (b) {
            var c = dnn.social.editDialog;
            if (b) {
                c.addClass('loading');
            }
            else {
                c.removeClass('loading');
            }
        };

        this.toggle = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }

            that.authoring(!that.authoring());

            return false;
        };

        this.reply = function (tagged, replyText) {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
         
            that.tagged(tagged);

            that.replyText(replyText);

            that.authoring(true);

            return false;
        };

        this.cancel = function () {
            that.authoring(false);
        };

        this.authoring.subscribe(
            function () {
                if (typeof dnn.social.hideCommentContext === 'function') {
                    dnn.social.hideCommentContext();
                }
                if (that.authoring()) {
                    $.each(dnn.social.postControllers,
                        function (index, controller) {
                            if (controller != that) {
                                controller.authoring(false);
                            }
                        });
                }

                setTimeout(function() {
                    for (var i = 0; i < dnn.social.postControllers.length; i++) {
                        if (dnn.social.postControllers[i].authoring()) {
                            that.control.authoring(true);
                            return;
                        }
                    }
                    that.control.authoring(false);
                }, 200);
            });
        
        var idx = dnn.social.postControllers.indexOf(this);
        if (idx < 0) {
            dnn.social.postControllers.push(this);
        }
    };
    
    dnn.social.postControllers = [];
    
})(window.dnn);
