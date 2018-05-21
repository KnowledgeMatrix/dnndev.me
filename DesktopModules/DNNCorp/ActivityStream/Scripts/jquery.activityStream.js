// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activityStream === 'undefined') dnn.activityStream = {};

(function ($) {
    "use strict";
    var blankImg = 'data:image/gif;base64,R0lGODlhAQABAJH/AP///wAAAMDAwAAAACH5BAEAAAIALAAAAAABAAEAAAICVAEAOw==';

    $(document).ready(function () {
        customEmojiPanel.init();
        try {
            // Remove resize handlers for icons in firefox.
            document.execCommand('enableObjectResizing', false, 'false');
        } catch (ex) {

        }
    });

    var actStr = {
        journalTypeDataName: 'actStr_journalType',
        urlPreviewerDataName: 'actStr_urlPreviewer',
        fileUploadDataName: 'actStr_fileUpload'
    },
        journalTypes = {
            link: 'link',
            video: 'video',
            file: 'file',
            photo: 'photo'
        },
        cancelRequest = false,
        uploadDocuments = false,
        videoEnabled = true;

    $.fn.setVideoEnabled = function (isVideoEnabled) {
        videoEnabled = isVideoEnabled;
    };

    $.isImage = function (value) {
        if (value != null) {
            return value.match(/^((jpg|png|gif|jpe|jpeg|tiff))$/i) != null;
        } else {
            return false;
        }
    };

    var supportAjaxUpload = function () {
        var xhr = new XMLHttpRequest;
        return !!(xhr && ('upload' in xhr) && ('onprogress' in xhr.upload));
    };


    dnn.activityStream.PostArea = function createPostArea(opts) {
        // normal
        var self = this,
            $postArea = opts.$postArea,
            $contentEditableDiv = $('[contenteditable=true]', $postArea),
            service = opts.servicesFramework,
            pastedTimeOut;
        var auxPostTex = ko.observable(''); // used to see whether we have to disable the 
        self.postText = ko.observable('');
        self.isSendingRequest = ko.observable(false);
        self.showPlaceHolder = ko.observable(true);
        self.isEmojiOpen = ko.observable(false);
        self.showContentEditable = ko.observable(false);
        self.journalType = ko.observable();
        self.savedRange = 0;

        self.urlPreviewer = new dnn.activityStream.Previewify(
        {
            $contentEditableDiv: $contentEditableDiv,
            service: opts.activityStreamService,
            journalTypeObserver: self.journalType,
            maxLength: opts.maxLength
        });

        self.fileUploader = new dnn.activityStream.FileUploadTool(
                {
                    $wrapperArea: $postArea,
                    $userFileManager: opts.$userFileManager,
                    localization: opts.localization,
                    maxFileSize: opts.maxUploadSize,
                    maxFiles: opts.maxFiles,
                    serverErrorMessage: opts.serverErrorMessage,
                    addImageServiceUrl: opts.addImageServiceUrl,
                    deleteImageServiceUrl: opts.deleteImageServiceUrl,
                    beforeSend: opts.beforeSend,
                    journalTypeObserver: self.journalType
                }
        );

        self.fileUploader.isAttachPanelOpen.subscribe(function (isOpen) {
            self.urlPreviewer.disablePreviewify = isOpen;
        });

        self.sendAjaxPost = function (method, data, success, error, complete) {
            self.isSendingRequest(true);

            $.ajax({
                type: "POST",
                url: service.getServiceRoot('DNNCorp/ActivityStream') + 'ActivityStreamServices/' + method,
                beforeSend: service.setModuleHeaders,
                data: data,
                success: success,
                error: error,
                complete: function (data) {
                    self.isSendingRequest(false);
                    if (typeof (complete) === "function") {
                        complete(data);
                    }
                }
            });
        }

        self.disablePostButton = ko.computed(function () {
            if (self.isSendingRequest()) {
                return true;
            }
            var hasFiles = self.fileUploader.files().length;
            if (hasFiles) {
                return false;
            }
            var hasEmojis = $('img[class^=emoji]', $contentEditableDiv).length > 0;
            if (hasEmojis) {
                return false;
            }

            var commentText = $.trim(auxPostTex() || self.postText());
            commentText = commentText.replace(/<(?:.|\n)*?>/gm, '').replace(/&nbsp;/g, '');
            return commentText === '';
        });
        self.toggleAttachImagePanel = function () {
            self.fileUploader.togglePanel(true);
        }
        self.toggleAttachFilePanel = function () {
            self.fileUploader.togglePanel(false);
        }

        self.showEmojiPanel = function (data, event) {
            var text = $contentEditableDiv.text();
            if (text.length >= opts.maxLength) {
                return;
            }

            var $emojiPanel = customEmojiPanel.$emojiPanel;
            if (self.isEmojiOpen()) {
                customEmojiPanel.close();
                return;
            }
            $emojiPanel.detach().appendTo(event.currentTarget.parentNode).show();
            self.isEmojiOpen(true);

            customEmojiPanel.callback = function (emojiCode) {
                var $spanEmoji = $(emojione.shortnameToImage(emojione.toShort(emojiCode)));
                var $emoji = $('<img  class="' + $spanEmoji.attr('class') + '" alt="' + $spanEmoji.text() + '" src="' + blankImg + '" unselectable="on" />');

                var $emojiPlaceHolder = $('.emojiPlaceHolder', $contentEditableDiv);

                if ($emojiPlaceHolder.parent().is('[class^=emojione-]')) {
                    $emojiPlaceHolder.insertAfter($emojiPlaceHolder.parent());
                }
                if ($emojiPlaceHolder.length > 0) {
                    $emoji.insertBefore($emojiPlaceHolder);
                } else {
                    $contentEditableDiv.append($emoji);
                }

                self.postText($contentEditableDiv.html());
                customEmojiPanel.close();
            };
            customEmojiPanel.closeCallback = function () {
                self.isEmojiOpen(false);
                $emojiPanel.detach().appendTo('body');
            };

        }
        $contentEditableDiv.on('keyup', function () {
            auxPostTex($contentEditableDiv.html());
        });
        $contentEditableDiv.on('keyup mouseup', function () {

            if (self.isEmojiOpen()) {
                return;
            }
            if (window.getSelection) { //non IE Browsers
                if (!window.getSelection().rangeCount > 0) {
                    return;
                }
                self.savedRange = window.getSelection().getRangeAt(0).cloneRange();
            } else if (document.selection) { //IE
                self.savedRange = document.selection.createRange();
            }
        });
        $contentEditableDiv.on('blur', function () {
            if (!self.savedRange || self.isEmojiOpen()) {
                return;
            }
            var $emojiPlaceHolder = $('.emojiPlaceHolder', $contentEditableDiv);
            $emojiPlaceHolder = $emojiPlaceHolder.length > 0 ? $emojiPlaceHolder.detach() : $('<img class="emojiPlaceHolder" src="' + blankImg + '"/>');
            self.savedRange.insertNode($emojiPlaceHolder[0]);
            var htmlText = $contentEditableDiv.html().replace(/<div>/g, '<br>');
            htmlText = htmlText.replace(/<\/div>/g, '');
            htmlText = htmlText.replace(/<p>/g, '<br>');
            htmlText = htmlText.replace(/<\/p>/g, '');
            var emojiShortCode = emojione.toShort(htmlText);
            $contentEditableDiv.find('[style]').each(function () {
                $(this).removeAttr('style');
            });
            $contentEditableDiv.html(emojione.shortnameToImage(emojiShortCode));

        });
        $contentEditableDiv.on('paste', function (e) {
            clearTimeout(pastedTimeOut);
            pastedTimeOut = setTimeout(function () {
                var html = self.getPostText().replace(/<br>/g, '%3Cbr%3E');
                var text = html.replace(/<(?:.|\n)*?>/gm, '').replace(/&nbsp;/g, ' ').substring(0, opts.maxLength);
                text = text.replace(/%3Cbr%3E/g, '<br>');
                $contentEditableDiv.html(emojione.shortnameToImage(emojione.toShort(text)));
                $contentEditableDiv.find('span[class^=emoji]').each(function () {
                    var $this = $(this);
                    $this.replaceWith('<img unselectable="on" class="' + $this.attr('class') + '" alt="' + $this.text() + '" src="' + blankImg + '" />');
                });
            }, 20);
        });
        self.getPostText = function () {
            var $postValue = $('<div>' + $contentEditableDiv.html() + '</div>');
            $postValue.find('img[class^=emojione-]').each(function () {
                var $this = $(this);
                $this.replaceWith($this.attr('alt'));
            });
            $postValue.find('img.emojiPlaceHolder').remove();
            return $postValue.html();
        }

        self.clearPostArea = function (showPlaceHolderCondition, showContentEditable, isCanceled) {
            self.showContentEditable(showContentEditable || false);
            self.showPlaceHolder(showPlaceHolderCondition);
            self.journalType('');
            self.postText('');
            auxPostTex('');
            self.urlPreviewer.clearUrlPreview();
            self.fileUploader.clearFileUploadArea(isCanceled);
        }

        $contentEditableDiv.mentionsInput({
            source: service.getServiceRoot('DNNCorp/ActivityStream') + 'Social/GetAvailableUsersForMentioning',
            showAtCaret: true
        });
    }

    dnn.activityStream.PostStatusArea = function createPostStatusArea(opts) {
        var self = this;
        self.postArea = new dnn.activityStream.PostArea(opts);
        self.subscriptionSwitcher = new dnn.activityStream.SubscriptionSwitcher(opts);
        self.isPostAreaOpen = ko.observable(false);
        self.listViewModel = opts.listViewModel;
        self.isSecurityMenuOpen = ko.observable(false);

        var $wrap = opts.$postArea,
            $toolsBar = $('#tbar'),
            $securityMenu = $wrap.find('.securityMenu'),
            $noActivityStreamPlaceHolder = $('#noActivityStreamPlaceHolder'),
            wallProfileId = opts.wallProfileId,
            wallGroupId = opts.wallGroupId,
            $contentEditableDiv = $wrap.find('.actStr_commentEditable[contenteditable]');

        self.showArea = function () {
            // disable button
            if (self.isPostAreaOpen()) {
                return;
            }
            $contentEditableDiv.animate({
                height: '+=65',
                'margin-bottom': '42px'
            }, 400, function () {
                self.postArea.showPlaceHolder(false);
                self.isPostAreaOpen(true);
            });
        }

        self.shareStatus = function () {
            if (self.postArea.disablePostButton()) {
                return;
            }
            var urlPreviewerItemData = self.postArea.urlPreviewer.getJournalItem().ItemData;

            var fileUploader = self.postArea.fileUploader;
            var journalType = self.postArea.journalType();
            if (journalType === journalTypes.file || journalType === journalTypes.photo) {
                journalType = fileUploader.fileIds.length > 0 ? journalType : '';
            }


            var data = {
                text: encodeURIComponent(self.postArea.getPostText()),
                profileId: wallProfileId,
                groupId: wallGroupId,
                journalType: journalType || 'status',
                securitySet: $securityMenu.find('input:checked').val() || 'E',
                files: fileUploader.fileIds,
                itemData: urlPreviewerItemData !== null ? JSON.stringify(urlPreviewerItemData) : '',
                subscribed: true // This parameter can't be changed right now, but maybe in future versions we want to allow the user unsubscribe by default when he posts something
            };
            var success = function (response) {

                $(response.Content).hide().prependTo("#journalItems").fadeIn();
                self.listViewModel.pluginInit();
                globalActivityStreamListView.nextListIndex++;
                self.clearStatusPostArea(false);
                $noActivityStreamPlaceHolder.hide();
            }
            var error = function (xhr, status, error) {
                var parseException = function (json) {
                    try {
                        var parsed = $.parseJSON(json) || { ExceptionMessage: 'Unknown error' };
                        var msg = null;
                        switch (typeof parsed) {
                            case 'undefined':
                                break;
                            case 'string':
                                msg = parsed;
                                break;
                            case 'object':
                                if (parsed.hasOwnProperty('ExceptionMessage')) {
                                    msg = parsed.ExceptionMessage;
                                } else if (parsed.hasOwnProperty('Message')) {
                                    msg = parsed.Message;
                                } else if (parsed.hasOwnProperty('Exception')) {
                                    msg = parsed.Exception;
                                }

                                if (String.isEmpty(msg)) {
                                    msg = 'Unknown error';
                                }
                                break;
                        }

                        return msg;
                    } catch (e) {
                        return null;
                    }
                };
                var parsedMessage = parseException(xhr.responseText);

                $.dnnAlert({
                    title: 'Error',
                    text: parsedMessage || error
                });
            }
            var complete = $.noop;
            self.postArea.sendAjaxPost('Create', data, success, error, complete);
        }

        self.toggleSecurityMenu = function () {
            var openSecurityMenu = !self.isSecurityMenuOpen();
            self.isSecurityMenuOpen(openSecurityMenu);
        }

        self.clearStatusPostArea = function (isCanceled) {
            $securityMenu.hide();

            self.isPostAreaOpen(false);
            $contentEditableDiv.animate({
                height: '25',
                'margin-bottom': 0
            }, 400, function () {
                self.postArea.clearPostArea(true, true, isCanceled);
            });
        }
        $contentEditableDiv.on('focus', self.showArea);
        $(' > span:not(#tbar-subscribe)', $toolsBar).on('click', self.showArea);
    }

    dnn.activityStream.SubscriptionSwitcher = function createSubscriptionSwitcher(opts) {
        var self = this,
            service = opts.subscriptionService,
            subscribeToUpdatesText = opts.localization.getString('SubscribeToUpdates'),
            unSubscribeFromUpdatesText = opts.localization.getString('UnsubscribeFromUpdates'),
            wallProfileId = opts.wallProfileId,
            wallGroupId = opts.wallGroupId;

        self.showTooltip = ko.observable(false);
        self.isSendingRequest = ko.observable(false);
        self.isSubscribed = ko.observable(opts.isSubscribedToWall);

        self.altText = ko.computed(function () {
            return self.isSubscribed() ? unSubscribeFromUpdatesText : subscribeToUpdatesText;
        });

        self.toggleSubscription = function () {
            if (self.isSendingRequest()) {
                return;
            }
            self.isSendingRequest(true);
            var isSubscribed = self.isSubscribed();
            var serviceMethod = isSubscribed ? 'UnsubscribeFromWall' : 'SubscribeToWall';
            var data = {
                GroupId: wallGroupId,
                WallUserId: wallProfileId
            }
            var success = function () {
                self.isSubscribed(!isSubscribed);
            }
            var error = function (error) {
                $.dnnAlert({
                    title: 'Error',
                    text: error.message
                });
            }
            service.post(serviceMethod, data, success, error, self.isSendingRequest);
        }

    }

    dnn.activityStream.Comment = function createComment(opts) {

        var self = this,
            $postArea = opts.$postArea,
            $contentEditableDiv = $('[contenteditable=true]', $postArea),
            commentExpanded = false,
            journalId = $postArea.data('id'),
            $textAreaRow = $('.cmteditarea', $postArea),
            $loadmore = $('#jcmt-' + journalId + '-loadmore', $postArea),
            $deleteButtons = $('.jcmt-remove', $postArea),
            numComments = $postArea.data('numcomments');

        self.postArea = new dnn.activityStream.PostArea(opts);
        $postArea.data('actStr_comment', self);
        $postArea.data("journalCommentsBinded", true);

        var slideToggleArea = function () {
            if (self.postArea.showPlaceHolder()) {
                $textAreaRow.css('overflow', 'hidden');
                $textAreaRow.animate({ 'max-height': 40, 'padding-top': 0, 'padding-bottom': 0 }, {
                    duration: 200,
                    complete: function () {
                        $textAreaRow.css('overflow', 'hidden');
                    },
                    queue: false
                });
            } else if (self.postArea.showContentEditable()) {
                $textAreaRow.parent().show();
                $textAreaRow.animate({ 'max-height': 1000, 'padding-top': 20, 'padding-bottom': 20 }, {
                    complete: function () {
                        $textAreaRow.css('overflow', 'visible');
                    },
                    duration: 200,
                    queue: false
                });
            } else {

                $textAreaRow.css('overflow', 'hidden');
                $textAreaRow.animate({ 'max-height': 0, 'padding-top': 0, 'padding-bottom': 0 }, {
                    duration: 200,
                    queue: false,
                    complete: function () {
                        $textAreaRow.css('overflow', 'hidden');
                        $textAreaRow.parent().hide();
                    }
                });
            }
        }

        var expandAllComments = function () {
            if (commentExpanded) {
                return;
            }
            commentExpanded = true;
            $('a.expand', $loadmore).remove();
            $('span', $loadmore).remove();
            $('#jcmt-' + journalId + ' > li[id^="cmt-"]').slideDown('fast');
            var gallerySettings = { size: 180, margin: 10, isMobile: opts.isMobile(), count: 6 };
            $(".gallery-control", $postArea).each(function () {
                dnn.social.reinitGalleryControl($(this), gallerySettings);
            });
        };

        var isMostRecentFirst = function () {
            return $('a.newest', $loadmore).hasClass('selected');
        };

        var sortComments = function (mostRecentFirst) {
            if (isMostRecentFirst() === mostRecentFirst) {
                return;
            }

            $('a.newest', $loadmore).toggleClass('selected', mostRecentFirst === true);
            $('a.oldest', $loadmore).toggleClass('selected', mostRecentFirst === false);

            var ul = $loadmore.parent();
            ul.children(":not(.jcmt-loadmore):not(.cmteditarea)").each(function (i, li) { ul.prepend(li) });
            ul.prepend(ul.children(".jcmt-loadmore"));

            expandAllComments();
        };

        var updateCommentsVisibility = function () {
            $loadmore.toggle(numComments > 1);
            $("a.sort", $loadmore).toggle(numComments > 1);
        }

        var bindDeleteButton = function ($deleteButton) {
            $deleteButton.dnnConfirm({
                text: opts.resxConfirm,
                yesText: opts.resxConfirmYes,
                noText: opts.resxConfirmNo,
                title: opts.resxConfirmTitle,
                isButton: true,
                callbackTrue: function () {
                    var commentId = $deleteButton.data('commentid');
                    self.deleteComment(commentId);
                }
            });
        }
        var commentComplete = function (data) {
            numComments++;
            self.clearComment(false);
            var emojiData = emojione.shortnameToImage(emojione.toShort(data));
            var $li = $(emojiData);
            if (isMostRecentFirst()) {
                $li.insertAfter($loadmore);
            } else {
                $li.insertBefore($textAreaRow);
            }

            updateCommentsVisibility();

            bindDeleteButton($li.find('.jcmt-remove'));
            var $postButton = $textAreaRow.closest('.journalitem').find('a[id^="cmtbtnUnsubscribe-"]');
            $postButton.removeClass('actStr_unsubscribed');
            $postButton.addClass('actStr_subscribed');

            $(".jlink a.journalVideoEmbed", $li).each(function () {
                var $this = $(this);
                if ($this.data("embedBinded")) return;
                $this.data("embedBinded", true);
                $this.click(function () {
                    var parent = $this.parent();
                    var width = parent.width();
                    var height = Math.round(width / 1280 * 720);
                    var src = $this.attr('href');
                    if (!src) return false;
                    if (src.indexOf('?') > 0) src += '&autoplay=1';
                    else src += '?autoplay=1';

                    parent.prepend('<iframe class="youtube-player" type="text/html" width="' + width + '" height="' + height + '" src="' + src + '" frameborder="0" allowfullscreen></iframe>');

                    $this.remove();
                    return false;
                });
            });
            $(".gallery-control", $li).each(function () {
                var gallerySettings = { size: 180, margin: 10, count: 6, isMobile: opts.isMobile() };
                dnn.social.initGalleryControl($(this), gallerySettings);
            });

            $li.find('a[id^="likecomment-"]').each(function () {
                var $this = $(this);
                if ($this.data("clickBinded")) {
                    return;
                }
                $this.data("clickBinded", true);
                $this.click(function (e) {
                    e.preventDefault();
                    var id = $this.attr('id');
                    var cid = id.replace('likecomment-', '');
                    var d = {};
                    d.commentId = cid;
                    var viewModel = window.ko.contextFor(document.getElementById('activityStream-ScopeWrapper'));
                    var like = $this.text() === opts.resxLike;
                    viewModel.$root.socialPost(like ? 'LikeComment' : 'UnlikeComment', d, viewModel.$root.buildCommentLikes, cid);
                });
            });
        };

        $('a.expand', $loadmore).on('click', expandAllComments);
        $('a.newest', $loadmore).on('click', function () { sortComments(true); });
        $('a.oldest', $loadmore).on('click', function () { sortComments(false); });

        $deleteButtons.each(function () {
            bindDeleteButton($(this));
        });

        self.showContentEditableSection = function () {
            expandAllComments();
            self.postArea.showPlaceHolder(false);
            self.postArea.showContentEditable(true);
            slideToggleArea();
        }
        $contentEditableDiv.on('focus', self.showContentEditableSection);

        self.postComment = function () {
            if (self.postArea.disablePostButton()) {
                return;
            }
            var urlPreviewerItemData = self.postArea.urlPreviewer.getJournalItem().ItemData;
            var journalType = self.postArea.journalType();
            var data = {
                comment: encodeURIComponent(self.postArea.getPostText()),
                fileIds: self.postArea.fileUploader.fileIds,
                itemData: urlPreviewerItemData !== null ? JSON.stringify(urlPreviewerItemData) : '',
                journalId: journalId,
                journalType: journalType
            };
            var error = function (xhr, status, error) {
                alert(error);
            }
            self.postArea.sendAjaxPost('CommentSave', data, commentComplete, error);
        }
        self.deleteComment = function (commentId) {
            var data = {
                JournalId: journalId,
                CommentId: commentId

            };
            var success = function () {
                var $comment = $postArea.find('li#cmt-' + data.CommentId);
                $comment.slideUp('fast', function () {
                    $comment.remove();
                });
                expandAllComments();
                numComments--;
                updateCommentsVisibility();
                if (numComments === 0) {
                    self.postArea.showPlaceHolder(false);
                    self.postArea.showContentEditable(false);
                    slideToggleArea();
                }
            }
            var error = function (xhr, status, error) {
                alert(error);
            }
            self.postArea.sendAjaxPost('CommentDelete', data, success, error);
        };
        self.toggleCommentEditableArea = function () {
            if (self.postArea.showContentEditable()) {
                self.clearComment(true);
            } else {
                self.showContentEditableSection();
            }
        }

        self.clearComment = function (isCanceled) {
            self.postArea.clearPostArea(numComments > 0, false, isCanceled);
            slideToggleArea();
            updateCommentsVisibility();
        }
        self.clearComment();
    }

    dnn.activityStream.Previewify = function createPreviewify(opts) {
        // Properties
        var self = this,
            $contentEditableDiv = opts.$contentEditableDiv,
            service = opts.service;
        // Observable Properties 
        self.journalTypeObserver = opts.journalTypeObserver;
        self.images = ko.observableArray([]);
        self.currentImgIndex = ko.observable(0);
        self.loadedUrl = ko.observable('');
        self.title = ko.observable('');
        self.description = ko.observable('');
        self.showPreviewer = ko.observable(false);
        self.disablePreviewify = false;
        self.videoUrl = '';
        self.url = '';


        self.nextImg = function loadNextImg() {
            var imgIndex = self.currentImgIndex();

            if (imgIndex === self.images().length - 1) {
                self.currentImgIndex(0);
            } else {
                self.currentImgIndex(imgIndex + 1);
            }
        }

        self.prevImg = function loadPrevImg() {
            var imgIndex = self.currentImgIndex();
            if (imgIndex === 0) {
                self.currentImgIndex(self.images().length - 1);
            } else {
                self.currentImgIndex(imgIndex - 1);
            }
        }
        var previewifyTimer;
        var checkUrl = function (text) {
            text = text.replace(/<(?:.|\n)*?>/gm, '').replace(/&nbsp;/g, ' ');
            if (!text) {
                return;
            }
            var urlPattern2 = /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/gim;

            var url = urlPattern2.exec(text);
            if (url) {
                var cleanUrl = url[0].replace(/[^\x00-\x7F]/g, "");
                if (self.loadedUrl() !== cleanUrl) {
                    self.loadedUrl(cleanUrl);
                }
            } else {
                self.clearUrlPreview();
            }
        }

        $contentEditableDiv.on('keydown', function (e) {
            var text = $contentEditableDiv.text();
            var isSpecial = /^(8|9|35|36|37|38|39|40|46)$/.test("" + e.which);
            if (!isSpecial && text.length >= opts.maxLength) {
                e.preventDefault();
            }
        });

        $contentEditableDiv.on('keyup', function findUrl(e) {
            if (self.disablePreviewify) {
                return true;
            }

            var text = $contentEditableDiv.html();
            var code = e.keyCode || e.which;
            if (code === 13 && code === 32) {
                clearTimeout(previewifyTimer);
                checkUrl(text);
                return true;
            }

            clearTimeout(previewifyTimer);
            previewifyTimer = setTimeout(function () {
                checkUrl(text);
            }, 350);

            return true;
        });

        var urlPreviewerRequest;
        self.loadedUrl.subscribe(function getUrlValues(newUrl) {
            if (!newUrl) {
                self.clearUrlPreview();
                return;
            }
            if (urlPreviewerRequest) {
                urlPreviewerRequest.abort();
            }
            cancelRequest = false;
            var success = function buildLinkPreview(response) {
                if (!response.Url || cancelRequest) {
                    self.clearUrlPreview();
                    cancelRequest = false;
                    return;
                }
                self.images(response.Images);
                self.currentImgIndex(0);
                self.title(response.Title || '');

                var description = response.Description ? response.Description.replace('&amp;', '&') : '';
                description = decodeURIComponent(description);
                self.description(description);


                self.showPreviewer(self.title() || self.description() || self.images().length > 0);
                self.videoUrl = (response.VideoUrl && videoEnabled) ? response.VideoUrl : '';
                self.url = response.Url;
                var journalType = (self.videoUrl) ? journalTypes.video : journalTypes.link;
                $contentEditableDiv.data(actStr.journalTypeDataName, journalType);
                self.journalTypeObserver(journalType);
            }
            if (newUrl.indexOf(',') > -1) {
                return;
            }
            var data = { Url: newUrl };
            urlPreviewerRequest = service.post('PreviewURL', data, success);

        });
        self.previewImageUrl = ko.computed(function () {

            if (self.images().length === 0) {
                return '';
            }
            return self.images()[self.currentImgIndex()].Url;

        });
        self.clearUrlPreview = function () {
            self.showPreviewer(false);
            self.images([]);
            self.currentImgIndex(0);
            self.loadedUrl('');
            self.title('');
            self.description('');
            self.videoUrl = '';
            self.url = '';
            $contentEditableDiv.data(actStr.journalTypeDataName, '');
        }
        self.getJournalItem = function () {
            var newJournalItem = new Object();
            if (!self.showPreviewer()) {
                newJournalItem.ItemData = null;
                return newJournalItem;
            }

            var images = self.images();
            newJournalItem.ItemData = {
                ImageUrl: images.length > 0 ? images[self.currentImgIndex()].Url : '',
                Title: self.title(),
                Description: self.description(),
                Url: (self.videoUrl) ? self.videoUrl : self.url
            };
            return newJournalItem;
        }
        $contentEditableDiv.data(actStr.urlPreviewerDataName, self);

    }

    dnn.activityStream.FileUploadTool = function createPhotoTool(opts) {
        var self = this;
        self.maxFiles = opts.maxFiles;
        var $wrapperArea = opts.$wrapperArea,
            $userFileManager = opts.$userFileManager,
            uploadedFilesCount = 0;

        var url = opts.addImageServiceUrl;
        if (!supportAjaxUpload()) {
            var antiForgeryToken = $('input[name="__RequestVerificationToken"]').val();
            url += '?__RequestVerificationToken=' + antiForgeryToken;
        }

        self.journalTypeObserver = opts.journalTypeObserver;
        self.isAttachPanelOpen = ko.observable(false);
        self.isAttachingPhoto = ko.observable(false);
        self.fileIds = [];
        self.files = ko.observableArray([]);
        self.errorMessage = ko.observable(opts.serverErrorMessage);

        self.showErrorMessage = ko.observable(false);
        self.showProgressBar = ko.observable(false);
        self.progress = ko.observable('0%');

        self.browseFromSiteText = ko.computed(function () {
            return self.isAttachingPhoto() ? opts.localization.getString('SelectPhoto') : opts.localization.getString('SelectFile');
        });
        self.isAttachAreaOpen = ko.computed(function () {
            return self.files().length === 0;
        });

        self.showError = function (message) {
            self.errorMessage(message);
            self.showErrorMessage(true);
            setTimeout((function () { self.showErrorMessage(false); }), 4000);
        }

        var deleteFile = function (file) {
            if (!file.isUploaded) {
                return;
            }
            $.ajax({
                type: "POST",
                url: opts.deleteImageServiceUrl,
                beforeSend: opts.beforeSend,
                data: { fileId: file.fileId },
                success: $.noop,
                error: $.noop,
                complete: $.noop
            });
        }

        self.clearFileUploadArea = function (isCanceled) {
            if (isCanceled) {

                $.each(self.files(), function (index, file) {
                    deleteFile(file);
                });
            }
            self.isAttachingPhoto(false);
            self.isAttachPanelOpen(false);
            self.files([]);
            self.fileIds = [];
            self.showProgressBar(false);
            self.showErrorMessage(false);
            self.journalTypeObserver('');
        }

        self.addFile = function (file, isUploaded) {
            self.fileIds.push(file.fileId);
            self.files.push({ fileId: file.fileId, fileName: file.name, path: file.url, isUploaded: isUploaded });
        }


        self.bindFileUpload = function () {
            var $fileUploadArea = $wrapperArea.find('.fileUploadArea');
            $fileUploadArea.on('fileuploadfail', function (e, data) {
                self.showError(opts.serverErrorMessage);
            });

            // success response
            $fileUploadArea.on('fileuploaddone', function (e, data) {

                var result;
                if (data.result && data.result[0]) {
                    if (data.result[0].body) {
                        result = $.parseJSON(data.result[0].body.innerText)[0];
                    } else {
                        result = data.result[0];
                    }

                    if (result.success) {
                        self.addFile({
                            fileId: result.file_id,
                            name: result.name,
                            url: self.isAttachingPhoto() ? result.url : result.thumbnail_url,
                            extension: result.extension
                        }, true);
                    }
                    else {
                        self.showError(result.message);
                    }
                }
            });

            $fileUploadArea.fileupload({
                dataType: 'json',
                url: url,
                maxFileSize: opts.maxFileSize,
                beforeSend: opts.beforeSend,
                add: function (e, data) {
                    var uploadFile = data.files[0];
                    if (!self.isAttachingPhoto() || (/\.(jpg|png|gif|jpe|jpeg|tiff)$/i).test(uploadFile.name)) {
                        uploadedFilesCount++;
                        if (uploadedFilesCount <= opts.maxFiles) {
                            self.showProgressBar(true);
                            data.submit();
                        }
                    }
                },
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    self.progress(progress + '%');
                },
                done: function (e, data) {
                    uploadedFilesCount = 0;

                    self.progress('100%');
                    setTimeout((function () {
                        self.showProgressBar(false);
                    }), 1000);

                }
            });
        }

        self.togglePanel = function (isAttachingPhoto) {

            var isOpen = self.isAttachPanelOpen();
            if (isOpen && self.isAttachingPhoto() !== isAttachingPhoto) {
                return;
            }
            self.isAttachPanelOpen(!isOpen);
            self.isAttachingPhoto(isAttachingPhoto);
            if (!self.isAttachPanelOpen()) {
                self.clearFileUploadArea(true);
            } else {
                var journalType = self.isAttachingPhoto() ? journalTypes.photo : journalTypes.file;
                self.journalTypeObserver(journalType);
            }
        }

        self.selectFromSite = function () {
            if (self.isAttachingPhoto()) {
                $userFileManager.userFileManager.setFileExtensions('jpg,png,gif,jpe,jpeg,tiff');
            } else {
                $userFileManager.userFileManager.setFileExtensions('');
            }

            var previousCallback = $userFileManager.data('actStr_openFileManagerCallback');

            $userFileManager.data('actStr_openFileManagerCallback', function (file) {
                self.addFile({
                    fileId: file.id,
                    name: file.name,
                    url: file.thumb_url,
                    extension: file.type
                });
                $userFileManager.data('actStr_openFileManagerCallback', previousCallback);
            });
            $('.actStr_openFromSite', $wrapperArea).trigger('click');
        }

        self.removeAttached = function (file) {
            var indexId = self.fileIds.indexOf(file.fileId);
            if (indexId > -1) {
                self.fileIds.splice(indexId, 1);
            }
            self.files.remove(file);
            deleteFile(file);
        }

    }

}(jQuery, window));
