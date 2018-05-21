// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activityStream === 'undefined') dnn.activityStream = {};

(function (dnn, $, ko) {
    'use strict';
    var constants = {
        lastItemIndex: 'lastItem'
    }
    dnn.activityStream.ActivityType = function (name, id) {
        this.FilterType = name;
        this.FilterTypeId = id;
    };

    dnn.activityStream.ListView = function ListView(settings) {
        var that = this;
        var servicesFramework = $.ServicesFramework(settings.moduleId);
        this.social = new dnn.social.Module(settings);
        this.localization = that.social.getLocalizationController();
        this.activityStreamService = this.social.getService('ActivityStreamServices');
        this.subscriptionService = this.social.getService('Subscriptions');
        this.socialService = this.social.getService('Social');

        this.loadingMoreItems = ko.observable(false);
        this.morePagesToLoad = ko.observable(settings.initialMorePagesToLoad);
        this.isShowAllButtonVisible = ko.observable(false);
        this.isGetNewButtonVisible = ko.observable(false);
        this.isGetMoreButtonVisible = ko.computed(function () {
            return !settings.isContinuousScrollingEnabled && that.morePagesToLoad();
        });
        this.showNoMoreItemsToLoad = ko.computed(function () {
            return settings.isContinuousScrollingEnabled && !that.morePagesToLoad() && $('#journalItems > .journalrow').length > 0;
        });

        if (settings) {
            this.grouping = settings.grouping;
            this.nextListIndex = settings.initialNextListIndex;
        } else {
            this.grouping = false;
            this.nextListIndex = 1;
        }

        this.buildLikes = function (data, journalId) {
            var $likeButton = $('#like-' + journalId);
            var currLike = $likeButton.text();
            if (currLike === settings.resxLike) {
                $likeButton.fadeOut(function () {
                    $likeButton.text(settings.resxUnLike).fadeIn();
                });
            } else {
                $likeButton.fadeOut(function () {
                    $likeButton.text(settings.resxLike).fadeIn();
                });
            }
            $('#jid-' + journalId + ' > div.journalitem > div.likes').fadeOut(function () {
                var bigLikes = $(this).next();
                if (!bigLikes.length) return;
                var smallLikes = bigLikes.next();
                if (!smallLikes.length) return;
                bigLikes.html(data.LikeList.Big);
                smallLikes.html(data.LikeList.Small);
                var likeString = that.isMobileView() ? data.LikeList.Small : data.LikeList.Big;
                $(this).html(likeString).fadeIn(function () {
                    var likeControl = dnn.social.initLikeControl();
                    likeControl.bindControls($(this));
                });
            });
        };

        this.buildCommentLikes = function (data, commentId) {
            var currLike = $('#likecomment-' + commentId).text();
            if (currLike == settings.resxLike) {
                $('#likecomment-' + commentId).fadeOut(function () {
                    $(this).text(settings.resxUnLike).fadeIn();
                });
            } else {
                $('#likecomment-' + commentId).fadeOut(function () {
                    $(this).text(settings.resxLike).fadeIn();
                });
            }
            $('#cmt-' + commentId + ' .likes').fadeOut(function () {
                var bigLikes = $(this).next();
                if (!bigLikes.length) return;
                var smallLikes = bigLikes.next();
                if (!smallLikes.length) return;
                bigLikes.html(data.LikeList.Big);
                smallLikes.html(data.LikeList.Small);
                var likeString = that.isMobileView() ? data.LikeList.Small : data.LikeList.Big;
                $(this).html(likeString).fadeIn(function () {
                    var likeControl = dnn.social.initLikeControl();
                    likeControl.bindControls($(this));
                });
            });
        };


        this.reorderJournalItem = function ($journal, journalId, isPinned) {
            var isAdded = false;
            $('#journalItems .journalrow')
                .each(function () {
                    var $this = $(this);
                    var id = $this.data('id');
                    var isCurrentItemPinned = $this.data('pinned');
                    if ((isPinned && (!isCurrentItemPinned || (isCurrentItemPinned && (id < journalId)))) || (!isPinned && (!isCurrentItemPinned && (id < journalId)))) {
                        $this.before($journal);
                        $journal.fadeIn();
                        isAdded = true;
                        return false;
                    }
                });
            if (!isAdded) {
                if (this.showNoMoreItemsToLoad()) {
                    $('#journalItems').append($journal);
                    $journal.fadeIn();
                    return;
                }
                $journal.remove();
                that.nextListIndex--;
            }
        }

        this.togglePin = function (data, journalId) {
            var $journal = $('#jid-' + journalId);
            if (data.isPinned) {
                $journal.addClass('journal-row-pinned');
            } else {
                $journal.removeClass('journal-row-pinned');
            }
            $journal.data('pinned', data.isPinned);
            var $togglePinButton = $('.actStr_pinLink', $journal);
            var text = data.isPinned ? settings.resxUnPin : settings.resxPin;
            $togglePinButton.text(text);
            $journal.fadeOut(function () {
                //$journal = $journal.detach();
                that.reorderJournalItem($journal, journalId, data.isPinned);
            });
        }

        this.journalDelete = function (jid) {
            var data = {};
            data.JournalId = jid;
            that.journalPost('SoftDelete', data, that.journalRemove, jid);
        };

        this.journalRemove = function (data, jid) {
            $('#jid-' + jid).slideUp(function () {
                $(this).remove();
                var rows = $('#journalItems > .journalrow').length;
                if (rows === 0) {
                    $('#noActivityStreamPlaceHolder').show();
                    that.morePagesToLoad(true);
                }
            });
        };

        this.servicePost = function (service, method, data, callback, journalId) {
            var success = function (d) {
                if (typeof (callback) != "undefined") {
                    callback(d, journalId);
                }
            };
            var error = function (xhr, status, error) {
                alert(error);
            };

            service.post(method, data, success, error);
        };

        this.journalPost = function (method, data, callback, journalId) {
            that.servicePost(that.activityStreamService, method, data, callback, journalId);
        };

        this.socialPost = function (method, data, callback, journalId) {
            that.servicePost(that.socialService, method, data, callback, journalId);
        };

        this.getLargestJournalId = function () {
            var largestJournalId = 0;
            $('.journalrow')
                .each(function () {
                    var id = $(this).data('id');
                    if (largestJournalId < id) {
                        largestJournalId = id;
                    }
                });
            return largestJournalId;
        }

        this.scroll = function (direction) {
            if (that.loadingMoreItems()) {
                return;
            }
            var data = {
                ProfileId: settings.pid,
                GroupId: settings.gid,
                MaxRows: settings.pageSize,
                FilterId: $('#filterId').attr('value'),
                JournalTypeId: $('#journalTypeId').attr('value'),
            };
            var largestJournalId = that.getLargestJournalId();

            if (direction === 'up') {
                data.NewerThanJournalId = largestJournalId;
                data.RowIndex = 1;
            } else if (direction === 'down') {
                data.OlderThanJournalId = largestJournalId + 1;
                data.RowIndex = that.nextListIndex;
            }
            data.Grouping = that.grouping;
            that.getItems(direction, data);
        };

        this.getItems = function (direction, data) {
            var rows = $(".journalrow").get();
            var success = function (response) {
                if (response.NextListIndex && direction !== 'up') {
                    that.nextListIndex = parseInt(response.NextListIndex);
                }
                if (response.CssFiles && response.CssFiles.length) {
                    $.each(response.CssFiles,
                        function (i, url) {
                            dnn.social.loadCss(url);
                        });
                }
                var parallelLoadJs = [];
                if (response.JsFiles && response.JsFiles.length) {
                    $.each(response.JsFiles,
                        function (i, url) {
                            var func = function (cb) { dnn.social.loadScript(url, cb); };
                            parallelLoadJs.push(func);
                        });
                }
                dnn.social.asyncParallel(parallelLoadJs,
                    function () {
                        if (response.Settings && response.Settings.length) {
                            $.each(response.Settings,
                                function (i, s) {
                                    $('head').append(s);
                                });
                        }
                        if (response.Content.length > 0) {
                            switch (direction) {
                                case 'up':
                                    that.isGetNewButtonVisible(false);
                                    var olderJournalId = that.getLargestJournalId();
                                    var $content = $(response.Content).filter(function() {
                                        return $(this).data('id') > olderJournalId;
                                    });

                                    $("#journalItems").prepend($content);
                                    setTimeout(that.autoCheckNewItems, 20000);
                                    break;
                                case 'down':
                                    $("#journalItems").append(response.Content);
                                    break;
                                case 'new':
                                    that.isGetNewButtonVisible(false);
                                    that.isShowAllButtonVisible(false);
                                    $("#journalItems").html(response.Content);
                                    break;
                                default:
                            }
                            that.pluginInit();
                            var newRows = $(".journalrow").get();
                            var diff = (newRows.length - rows.length);
                            if (direction !== 'up') {
                                that.morePagesToLoad(diff >= settings.pageSize);
                            } else if (direction === 'up') {
                                that.nextListIndex += diff;
                            }

                        } else {
                            if (direction !== 'up') {
                                that.morePagesToLoad(false);
                            }
                        }


                        dnn.social.EventQueue.push(
                            function () {
                                dnn.social.bindCommentContext(document.getElementById(settings.journalListControlId));
                            });
                    });
            };
            var error = function (xhr, status, error) {
                if (error.length > 0) {
                    alert(error);
                }
            };
            that.activityStreamService.post('GetListForProfile', data, success, error, that.loadingMoreItems);
        };

        dnn.social.ipc.register(settings, function (source, message) {
            if (message.FilterId == undefined) {
                $('#filterId').attr('value', 0);
            } else {
                $('#filterId').attr('value', message.FilterId);
            }
            if (message.ProfileId == undefined) {
                $('#profileId').attr('value', 0);
            } else {
                $('#profileId').attr('value', message.ProfileId);
            }
            if (message.JournalTypeId == undefined) {
                $('#journalTypeId').attr('value', 0);
            } else {
                $('#journalTypeId').attr('value', message.JournalTypeId);
            }

            var data = {};
            data.ProfileId = settings.pid;
            data.GroupId = settings.gid;
            data.RowIndex = 0;
            data.MaxRows = settings.pageSize;
            data.FilterId = $('#filterId').attr('value');
            data.JournalTypeId = $('#journalTypeId').attr('value');
            $('#journalItems').children().remove('.journalrow');
            that.morePagesToLoad(false);
            data.Grouping = that.grouping;
            that.getItems('down', data);
        });

        if (settings.allowableFilterTypes && settings.allowableFilterTypes.length) {
            var allowableFilterTypes = [];
            $.each(settings.allowableFilterTypes, function (index) {
                allowableFilterTypes.push(
                    new dnn.activityStream.ActivityType(settings.allowableFilterTypes[index].JournalType,
                        settings.allowableFilterTypes[index].JournalTypeId));
            });
            this.allowableFilterTypes = ko.observableArray(allowableFilterTypes);
        } else {
            this.allowableFilterTypes = ko.observableArray([]);
        }

        this.selectedFilter = ko.observable('');
        this.selectActivityTypeCaption = ko.observable(that.localization.getString('SelectActivityType'));
        this.selectedFilter.subscribe(function () {
            dnn.social.ipc.post(settings, 'DNNCorp/ActivityStream', { JournalTypeId: that.selectedFilter()[0] });
        });

        this.switchingView = function () {
            $(".ui-dialog-content").dialog("close");
        };

        this.switchedView = function (fromPlugin) {
            if (that.dynamicPlugins && that.dynamicPlugins.length) {
                $.each(that.dynamicPlugins, function (i, p) {
                    p.init(settings);
                });
            }

            $('div.likes', settings.moduleScope).each(function () {
                var bigLikes = $(this).next();
                if (!bigLikes.length) return;
                var smallLikes = bigLikes.next();
                if (!smallLikes.length) return;
                var isMobile = that.isMobileView();
                var likeString = isMobile ? smallLikes.html() : bigLikes.html();
                $(this).html(likeString);
                isMobile ? $(this).addClass('dnnMobileLike') : $(this).removeClass('dnnMobileLike');
            });
            var likeControl = dnn.social.initLikeControl();
            likeControl.bindControls();

            $('span.journal-grouped-section', settings.moduleScope).each(function () {
                var bigGrouped = $(this).next();
                if (!bigGrouped.length) return;
                var smallGrouped = bigGrouped.next();
                if (!smallGrouped.length) return;
                var isMobile = that.isMobileView();
                var groupedString = isMobile ? smallGrouped.html() : bigGrouped.html();
                $(this).html(groupedString);
                isMobile ? $(this).addClass('dnnMobileLike') : $(this).removeClass('dnnMobileLike');
            });
            var groupedControl = dnn.activityStream.initGroupedJournalControl();
            groupedControl.bindControls();

            $('.journalrow .jlink > iframe').each(function () {
                var w = $(this).width();
                var h = $(this).height();
                var r = h / w;
                w = $(this).parent().width();
                h = w * r;
                $(this).css({ 'width': w, 'height': h });
            });

            var gallerySettings = { size: 180, margin: 10, isMobile: that.isMobileView(), count: 6 };
            $(".gallery-control").each(function () {
                if (fromPlugin)
                    dnn.social.initGalleryControl($(this), gallerySettings);
                else
                    dnn.social.reinitGalleryControl($(this), gallerySettings);
            });
        };

        this.pluginInit = function () {
            var $postCommentTemplate = $('#postCommentTemplate'),
                $urlPreviewerTemplate = $('#urlPreviewerTemplate'),
                $fileUploadAreaTemplate = $('#fileUploadAreaTemplate');


            var commentOpts = {
                activityStreamService: that.activityStreamService,
                addImageServiceUrl: servicesFramework.getServiceRoot('DNNCorp/ActivityStream') + 'FileUpload/UploadFile',
                deleteImageServiceUrl: servicesFramework.getServiceRoot('DNNCorp/ActivityStream') + 'FileUpload/DeleteFile',
                beforeSend: servicesFramework.setModuleHeaders,
                localization: that.social.getLocalizationController(),
                servicesFramework: servicesFramework,
                serverErrorMessage: settings.serverErrorMessage,
                maxLength: settings.maxLength,
                maxFiles: settings.maxFiles,
                maxFileSize: settings.maxUploadSize,
                $urlPreviewerTemplate: $urlPreviewerTemplate,
                $fileUploadAreaTemplate: $fileUploadAreaTemplate,
                $userFileManager: $('#userFileManager'),
                resxLike: settings.resxLike,
                resxConfirm: settings.confirmText,
                resxConfirmYes: settings.confirmYesText,
                resxConfirmNo: settings.confirmNoText,
                resxConfirmTitle: settings.confirmTitleText,
                isMobile: that.isMobileView
            };

            var $journalRows = $('.journalrow');
            $journalRows.each(function () {
                var $journalRow = $(this);
                if ($journalRow.data('pluginBinded')) {
                    return;
                }
                $journalRow.data('pluginBinded', true);

                var journalItemId = $journalRow.data('id');

                $('.actStr_journalSummary', $journalRow).each(function () {
                    var $this = $(this);
                    var emojiOneToShortHtml = emojione.toShort($this.html());
                    $this.html(emojione.shortnameToImage(emojiOneToShortHtml));
                });

                $('.jcmt', $journalRow).each(function () {
                    var $this = $(this);

                    $this.find('.actStr_commentContent').each(function () {
                        var $commentContentElement = $(this);
                        var commentContentHtml = $commentContentElement.html();
                        commentContentHtml = emojione.toShort(commentContentHtml);
                        commentContentHtml = emojione.shortnameToImage(commentContentHtml);
                        $commentContentElement.html(commentContentHtml);
                    });
                    if ($this.data('allowcomments')) {
                        var options = $.extend({}, { $postArea: $this }, commentOpts);
                        $this.append($postCommentTemplate.html());
                        ko.cleanNode(this);
                        ko.applyBindings(new dnn.activityStream.Comment(options), this);
                    }
                });

                $('#cmtbtn-' + journalItemId, $journalRow).each(function () {
                    $(this).click(function (e) {
                        e.preventDefault();
                        var $journalCommentArea = $(this).closest('.journalitem').find('>ul.jcmt');
                        $journalCommentArea.show();
                        $journalCommentArea.data('actStr_comment').toggleCommentEditableArea();
                    });
                });

                $('#cmtbtnUnsubscribe-' + journalItemId, $journalRow).each(function () {
                    var $this = $(this);
                    var subscribeText = that.localization.getString('SubscribeBtn'),
                        unsubscribeText = that.localization.getString('UnsubscribeBtn');
                    $this.click(function (e) {
                        e.preventDefault();

                        if ($this.data('isSendingRequest')) {
                            return false;
                        }

                        $this.data('isSendingRequest', true);

                        var isSubscribed = $this.data('subscribed');

                        var method = isSubscribed ? 'UnsubscribeFromPost' : 'SubscribeToPost';
                        var success = function () {

                            $this.data('subscribed', !isSubscribed);
                            if (isSubscribed) {
                                $this.text(subscribeText);
                            } else {
                                $this.text(unsubscribeText);
                            }
                            $this.data('isSendingRequest', false);
                        }
                        var error = function () {
                            $this.data('isSendingRequest', false);
                        }
                        var data = {
                            JournalItemId: journalItemId
                        }
                        that.subscriptionService.post(method, data, success, error);
                    });
                });

                $('#like-' + journalItemId, $journalRow).each(function () {
                    $(this).click(function (e) {
                        e.preventDefault();
                        var data = {
                            JournalId: journalItemId
                        };
                        that.journalPost('ToggleLike', data, that.buildLikes, journalItemId);
                    });
                });

                $('a[id^="likecomment-"]', $journalRow).each(function () {
                    $(this).click(function (e) {
                        e.preventDefault();
                        var id = $(this).attr('id');
                        var cid = id.replace('likecomment-', '');
                        var data = {};
                        data.commentId = cid;
                        var like = $(this).text() === settings.resxLike;
                        that.socialPost(like ? 'LikeComment' : 'UnlikeComment', data, that.buildCommentLikes, cid);
                    });
                });

                $(".journalitem-remove", $journalRow).each(function () {
                    $(this).dnnConfirm({
                        text: settings.confirmText,
                        yesText: settings.confirmYesText,
                        noText: settings.confirmNoText,
                        title: settings.confirmTitleText,
                        isButton: true,
                        callbackTrue: function () {
                            that.journalDelete(journalItemId);
                        }
                    });
                });

                $(".actStr_pinLink", $journalRow).on('click', function (e) {
                    e.preventDefault();
                    var data = {
                        JournalId: journalItemId
                    };

                    that.journalPost('TogglePin', data, that.togglePin, journalItemId);
                });

                $(".jlink a.journalVideoEmbed", $journalRow).each(function () {
                    $(this).click(function () {
                        var parent = $(this).parent();
                        var width = parent.width();
                        var height = Math.round(width / 1280 * 720);
                        var src = $(this).attr('href');
                        if (!src) return false;
                        if (src.indexOf('?') > 0) src += '&autoplay=1';
                        else src += '?autoplay=1';

                        parent.prepend('<iframe class="youtube-player" type="text/html" width="' + width + '" height="' + height + '" src="' + src + '" frameborder="0" allowfullscreen></iframe>');

                        $(this).remove();
                        return false;
                    });
                });
            });
            that.switchedView(true);
        };

        this.autoCheckNewItems = function () {
            var data = {
                profileId: settings.pid,
                groupId: settings.gid,
                filterId: $('#filterId').attr('value'),
                journalTypeId: $('#journalTypeId').attr('value'),
                newerThanJournalId: that.getLargestJournalId()
            };

            var success = function (d) {
                if (d > 0) {
                    that.isGetNewButtonVisible(true);
                    clearTimeout(that.autoCheckNewItems);
                } else {
                    setTimeout(that.autoCheckNewItems, 20000);
                }
            };

            var error = function () {
                clearTimeout(that.autoCheckNewItems);
            }

            that.activityStreamService.get('CheckNewUpdates', data, success, error);
        };

        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);
        this.binded = function () {

            $('.juser').click(function () {
                var uid = $(this).attr('id').replace('user-', '');
                window.location.href = settings.profilePage.replace('[uid]', uid);
            });
            that.isShowAllButtonVisible(settings.journalId > 0);

            $('a#activityStream_noActivityLink').click(function () {
                if (settings.showEditor) {
                    if ($('#journalContent').css('display') == 'none') {
                        $('#journalPlaceholder').click();
                    }
                    $('#jounalContent').focus();
                } else
                    window.location.href = settings.loginUrl;
            });
            var $userFileManager = $('#userFileManager');
            $userFileManager.userFileManager({
                title: settings.fileManagerTitle,
                cancelText: settings.fileManagerCancelText,
                attachText: settings.fileManagerAttachText,
                getItemsServiceUrl: servicesFramework.getServiceRoot('InternalServices') + 'UserFile/GetItems',
                nameHeaderText: settings.fileManagerNameHeaderText,
                typeHeaderText: settings.fileManagerTypeHeaderText,
                openTriggerSelector: '.actStr_openFromSite',
                lastModifiedHeaderText: settings.fileManagerLastModifiedHeaderText,
                fileSizeText: settings.fileManagerFileSizeText,
                templatePath: settings.fileManagerTemplatePath,
                templateName: 'Default',
                templateExtension: '.html',
                attachCallback: function (file) {
                    var attachCallback = $userFileManager.data('actStr_openFileManagerCallback');
                    if (typeof (attachCallback) === "function") {
                        attachCallback(file);
                    }
                }
            });


            var focusController = new dnn.social.FocusController($, ko, null, null, window.document, []);
            var hideCard = function () { dnn.social.hideCommentContext(); };
            $(window.document).bind('focused', hideCard);
            dnn.social.bindCommentContext(settings.moduleScope, this);

            if (settings.initialDynamicCss && settings.initialDynamicCss.length) {
                $.each(settings.initialDynamicCss, function (i, url) {
                    dnn.social.loadCss(url);
                });
            }

            var parallelLoadJs = [];
            if (settings.initialDynamicJs && settings.initialDynamicJs.length) {
                $.each(settings.initialDynamicJs, function (i, url) {
                    var func = function (cb) { dnn.social.loadScript(url, cb); };
                    parallelLoadJs.push(func);
                });
            }

            dnn.social.asyncParallel(parallelLoadJs, function () {
                that.pluginInit();
            });

            setTimeout(that.autoCheckNewItems, 20000);

            if ($.fn.dnnFileInput) {
                $.fn.dnnFileInput.defaultOptions = {
                    buttonClass: 'dnnSecondaryAction',
                    showSelectedFileNameAsButtonText: false
                };
            }
        };

        var postAreaOptions = {
            $postArea: $('#journalEditorArea'),
            $userFileManager: $('#userFileManager'),
            activityStreamService: that.activityStreamService,
            addImageServiceUrl: servicesFramework.getServiceRoot('DNNCorp/ActivityStream') + 'FileUpload/UploadFile',
            deleteImageServiceUrl: servicesFramework.getServiceRoot('DNNCorp/ActivityStream') + 'FileUpload/DeleteFile',
            beforeSend: servicesFramework.setModuleHeaders,
            isMobile: that.isMobileView,
            isSubscribedToWall: settings.isSubscribedToWall,
            listViewModel: that,
            localization: that.social.getLocalizationController(),
            servicesFramework: servicesFramework,
            serverErrorMessage: settings.serverErrorMessage,
            subscriptionService: that.subscriptionService,
            maxLength: settings.maxLength,
            maxFiles: settings.maxFiles,
            maxFileSize: settings.maxUploadSize,
            resxLike: settings.resxLike,
            resxConfirm: settings.confirmText,
            resxConfirmYes: settings.confirmYesText,
            resxConfirmNo: settings.confirmNoText,
            resxConfirmTitle: settings.confirmTitleText,
            wallProfileId: settings.pid,
            wallGroupId: settings.gid
        };
        this.postStatusArea = new dnn.activityStream.PostStatusArea(postAreaOptions);
        this.postArea = this.postStatusArea.postArea;

        this.getMoreItems = function () {
            that.scroll('down');
        }
        this.getNewItems = function () {
            that.scroll('up');
        }
        this.showAll = function () {
            var data = {
                ProfileId: settings.pid,
                GroupId: settings.gid,
                MaxRows: settings.pageSize,
                FilterId: $('#filterId').attr('value'),
                JournalTypeId: $('#journalTypeId').attr('value'),
                Grouping: that.grouping,
            };
            that.getItems("new", data);
        }

        if (settings.isContinuousScrollingEnabled) {
            var $journalBottomControlsArea = $('#journalBottomControls');
            var $window = $(window);
            $window.scroll(function () {
                if (!that.morePagesToLoad() || that.loadingMoreItems()) {
                    return;
                }
                if ($window.scrollTop() > ($journalBottomControlsArea.offset().top - $window.height())) {
                    that.scroll('down');
                }
            });

        }
        this.initLastJournalVisible();
    };

    dnn.activityStream.ListView.prototype.initLastJournalVisible = function() {
        var $window = $(window);
        var lastItemIndexPath = constants.lastItemIndex + '/';
        var windowPathName = window.location.pathname;
        var lastJournalId;
        var setLastItemIndexToBrowserHistory = function($journalItem) {
            
            var journalId = $journalItem.data('id');
            if (journalId === lastJournalId) {
                return;
            }
            lastJournalId = journalId;

            if (windowPathName.indexOf(lastItemIndexPath) > -1) {
                History.pushState(null, null, '' + journalId);
            } else {
                var lastItemParam = '?' + constants.lastItemIndex + '=';
                History.pushState(null, null, lastItemParam + journalId);
            }
        }
        $window.scroll(function () {
            $('#journalItems .journalrow').each(function () {
                var $journalItem = $(this);
                var minJournalHeight = 75;
                var scrollTop = $window.scrollTop();
                var offsetTop = $journalItem.offset().top;
                if (scrollTop < offsetTop) {
                    if (typeof (lastJournalId) !== "undefined") {
                        setLastItemIndexToBrowserHistory($journalItem);
                    }
                    return false;
                }
                if (scrollTop > offsetTop && scrollTop < (offsetTop + minJournalHeight)) {
                    setLastItemIndexToBrowserHistory($journalItem);
                    return false;
                }
            });

        });
    }
})(window.dnn, window.jQuery, window.ko);