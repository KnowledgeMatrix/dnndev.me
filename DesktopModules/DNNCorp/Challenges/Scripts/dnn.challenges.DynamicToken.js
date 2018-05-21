// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function () {
    'use strict';
    dnn.challenges.DynamicToken = function () {
        dnn.social.DynamicToken.apply(this, Array.prototype.slice.call(arguments));
        this.init();
    };

    dnn.challenges.DynamicToken.prototype = Object.create(dnn.social.DynamicToken.prototype);

    dnn.challenges.DynamicToken.prototype.getPlugin = function () {
        var self = this;
        var isMobile = $('html').hasClass('mobileView');
        var loadChallengeCompletedArea = function($element, mobileView) {
            var challengeId = $element.data('challenge-id');
            self.apiCall('GET', 'GetCompletedUsersListBasic', { challengeId: challengeId, pageIndex: 0, pageSize: (mobileView ? 1 : 3) }, function (d) {
                if (d && d.TotalRecords) {
                    var results = d.Results;
                    var render, part1 = '', part2 = '';
                    for (var i = 0; i < results.length; i++) {
                        var u = results[i];
                        part1 += '<a class="challenge-completed-avatar" href="' + u.profileUrl + '" title="' + u.displayName + '"><em><img src="' + u.avatarUrl + '" /></em></a>';
                    }
                    var restCount = d.TotalRecords - (mobileView ? 1 : 3);
                    if (restCount > 0) {
                        render = self.resx.msg_ManyCompleted;
                        part2 = restCount > 1 ? self.resx.msg_Others.replace('[COUNT]', restCount): self.resx.msg_Other;
                        part2 = '<a class="likes' + (mobileView ? ' dnnMobileLike' : '')
                            + '" href="javascript:void(0)"><span>' + part2 + '</span><div class="tag-menu"></div></a>';
                        
                    } else {
                        render = self.resx.msg_OneCompleted;
                    }
                    render = render.replace('[PART1]', part1).replace('[PART2]', part2);
                    $element.html(render);
                    
                    // attach event
                    $('.likes', $element).qaTooltip({
                        asyncDelegate: function(callback) {
                            if (!this.hasClass('dnnMobileLike')) {
                                var tagMenu = $('.tag-menu', $element);
                                if (tagMenu.find('ul').length) {
                                    if (typeof callback == 'function') callback();
                                    return;
                                }
                                self.apiCall('GET', 'GetCompletedUsersListBasic', { challengeId: challengeId, pageIndex: 0, pageSize: 13 }, function (dd) {
                                    if (dd && dd.TotalRecords) {
                                        var results2 = dd.Results;
                                        var html = '<ul>';
                                        for (var ii = 3; ii < results2.length; ii++) {
                                            html += '<li>' + results2[ii].displayName + '</li>';
                                        }
                                        if (d.TotalRecords > 13) {
                                            html += '<li>' + (dd.TotalRecords - 13) + ' More...</li>';
                                        }
                                        html += '</ul>';
                                        $('.tag-menu', $element).html(html);
                                    }
                                    if (typeof callback == 'function') callback();
                                });
                            }
                        }
                    }).unbind('click')
                    .bind('click', function() {
                        var popup = $('#challenge-completed-list-dialog');
                        if (!popup.length) {
                            popup = $('<div class="like-popup" id="challenge-completed-list-dialog">' +
                                '<div class="like-popup-list">' +
                                '<table>' +
                                '<tbody data-bind="foreach: results">' +
                                '<tr>' +
                                '<td class="avatar-td">' +
                                '<div class="avatar40">' +
                                '<span>' +
                                '<em>' +
                                '<img data-bind="attr: { src: avatarUrl, title: displayName }"  />' +
                                '</em>' +
                                '</span>' +
                                '</div>' +
                                '</td>' +
                                '<td class="name-td">' +
                                '<a class="dnnSocialLink" data-bind="attr: { href:  profileUrl }, text: displayName" ></a>' +
                                '</td>' +
                                '</tr>' +
                                '</tbody>' +
                                '</table>' +
                                '<a data-bind="visible: showMore, click: getMore" class="like-popup-loadmore">' + self.resx.popup_LoadMore + '</a>' +
                                '</div>' +
                                '<a class="dnnPrimaryAction" data-bind="visible: isMobileView, click: closeDialog" style="width: 100%; margin: 0">Close</a>' +
                                '</div>');
                            $('document').append(popup);
                            // define view model
                            var viewModel = {
                                results: ko.observableArray([]),
                                totalResults: ko.observable(0),
                                pageIndex: ko.observable(0),
                                challengeId: ko.observable(challengeId),
                                isMobileView: ko.observable(false),
                                closeDialog: function() {
                                    $(".ui-dialog-content").dialog("close");
                                }
                            };
                            viewModel.showMore = ko.computed($.proxy(function() {
                                return this.totalResults() > this.pageIndex() + 1;
                            }, viewModel));
                            viewModel.getMore = $.proxy(function () {
                                var selfVm = this;
                                self.apiCall('GET', 'GetCompletedUsersListBasic',
                                    { challengeId: selfVm.challengeId(), pageIndex: selfVm.pageIndex(), pageSize: 20 }, function (m) {
                                        if (m && m.TotalRecords) {
                                            var rr = selfVm.results();
                                            for (var ii = 0; ii < m.Results.length; ii++) {
                                                rr.push(m.Results[ii]);
                                            }
                                            selfVm.results(rr);
                                            selfVm.pageIndex(selfVm.pageIndex() + 20);
                                        }
                                });
                            }, viewModel);
                            viewModel.getMore();
                            ko.applyBindings(viewModel, popup[0]);
                        }
                        var vm = ko.dataFor(popup[0]);
                        vm.isMobileView(isMobile);
                        var popupTitle = self.resx.popup_Title;
                        if (!isMobile) {
                            popup.dialog({
                                modal: true,
                                autoOpen: true,
                                dialogClass: 'dnnFormPopup',
                                title: popupTitle,
                                minWidth: 350,
                                resizable: false,
                                draggable: false,
                                open: $.ui.dialog.prototype.options.open,
                                close: $.ui.dialog.prototype.options.close,
                            });
                        } else {
                            var options = dnn.social.MobileView.dialogOptions({
                                title: popupTitle
                            });
                            popup.dialog(options);
                        }
                    });
                }
            });
        };
        var loadOAuthWindow = function (network) {
            switch (network) {
                case 'Facebook':
                    if (!self.facebookAppId || !self.facebookRedirectUrl) return null;
                    var fbUrl = dnn.social.generateFullUrl(self.facebookRedirectUrl);
                    var fbWindow = window.open("https://www.facebook.com/dialog/oauth?client_id=" + self.facebookAppId +
                        "&redirect_uri=" + fbUrl + "&scope=email,publish_actions,user_friends&response_type=token&display=popup", '_blank', 'width=580, height=400');
                    return fbWindow;
                case 'LinkedIn':
                    if (!self.linkedinAppId || !self.linkedinRedirectUrl) return null;
                    var liUrl = dnn.social.generateFullUrl(self.linkedinRedirectUrl);
                    var liWindow = window.open("https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=" + self.linkedinAppId +
                        "&redirect_uri=" + liUrl + "&scope=r_basicprofile%20w_share&state=123", '_blank', 'width=620, height=611');
                    return liWindow;
                case 'Twitter':
                    if (!self.twitterAppId || !self.twitterPopupUrl) return null;
                    var twWindow = window.open(self.twitterPopupUrl, '_blank', 'width=564, height=741');
                    return twWindow;
                default:
                    return null;
            }
        };
        
        return {
            init: function (settings) {
                self.settings = settings;
                self.serviceRoot = dnn.challenges.dynamicTokenSettings.serviceRoot;
                self.facebookAppId = dnn.challenges.dynamicTokenSettings.facebookAppId;
                self.facebookRedirectUrl = dnn.challenges.dynamicTokenSettings.facebookRedirectUrl;
                self.linkedinAppId = dnn.challenges.dynamicTokenSettings.linkedinAppId;
                self.linkedinRedirectUrl = dnn.challenges.dynamicTokenSettings.linkedinRedirectUrl;
                self.twitterAppId = dnn.challenges.dynamicTokenSettings.twitterAppId;
                self.twitterPopupUrl = dnn.challenges.dynamicTokenSettings.twitterPopupUrl;
                self.resx = dnn.challenges.dynamicTokenSettings.resx;
                
                // completed area init
                var currentIsMobile = $('html').hasClass('mobileView');
                $('div.challenge-completed-area').each(function () {
                    if (!$(this).data('initialized') || currentIsMobile !== isMobile) {
                        loadChallengeCompletedArea($(this), currentIsMobile);
                        $(this).data('initialized', true);
                    }
                });
                isMobile = currentIsMobile;

                // accept challenge buttons
                $("a.accept-challenge-button").each(function () {
                    if (!$(this).data("clickBinded")) {
                        $(this).click(function (e) {
                            if (!dnn.social.authorizationRequired(settings)) {
                                var moduleId = $(this).data('module-id');
                                var contentItemId = $(this).data('contentitem-id');
                                var that = $(this);
                                self.apiCall('POST', 'AcceptChallenge', { contentItemId: contentItemId, moduleId: moduleId }, function() {
                                    var href = that.attr('href');
                                    if (href == 'javascript:void(0)') {
                                        // inline social share challenge
                                        var detail = that.next().next();
                                        that.hide();
                                        that.next().hide();
                                        detail.fadeIn('slow');
                                        var networks = [];
                                        var buttons = detail.find('ul.challenge-socialnetwork-list > li');
                                        buttons.each(function() {
                                            networks.push($(this).data('name'));
                                        });
                                        self.apiCall('POST', 'GetNetworksStatus', { networks: networks.join(',') }, function(d) {
                                            if (d && d.success && d.results && d.results.length) {
                                                for (var i = 0; i < d.results.length; i++) {
                                                    var info = d.results[i];
                                                    var avatar = info.avatar;
                                                    var name = info.name;
                                                    var network = networks[i];
                                                    var btn = detail.find('ul.challenge-socialnetwork-list > li.socialnetwork-' + network);
                                                    var charCount = 0;
                                                    switch(network) {
                                                        case 'Twitter':
                                                            charCount = 117;
                                                            break;
                                                        case 'LinkedIn':
                                                            charCount = 256;
                                                            break;
                                                        case 'Facebook':
                                                            charCount = 2000;
                                                            break;
                                                        default:
                                                            charCount = 0;
                                                    }
                                                    btn.html('<div class="tag-menu"><p>Click to connect</p></div><span data-max-count=' + charCount + ' class="char-count">' + charCount + '</span>')
                                                        .hoverIntent(function() {
                                                            $(this).find(".tag-menu").fadeIn('fast', 'linear');
                                                        }, function() {
                                                            $(this).find(".tag-menu").fadeOut('fast', 'linear');
                                                        });
                                                    if (avatar && name) {
                                                        btn.addClass('connected').data('avatar', avatar).data('displayName', name);
                                                    }
                                                }
                                            }
                                        });
                                    } else {
                                        window.location.href = href;
                                    }
                                });
                            }
                            e.preventDefault();
                        });
                        $(this).data("clickBinded", true);
                    }
                });
                
                // connect socialnetwork buttons
                $('ul.challenge-socialnetwork-list > li').each(function () {
                    if (!$(this).data('clickBinded')) {
                        $(this).click(function (e) {
                            e.preventDefault();
                            var $this = $(this);
                            var network = $this.data('name');
                            var charCount = 0;
                            switch (network) {
                                case 'Twitter':
                                    charCount = 117;
                                    break;
                                case 'LinkedIn':
                                    charCount = 256;
                                    break;
                                case 'Facebook':
                                    charCount = 2000;
                                    break;
                                default:
                                    charCount = 0;
                            }
                            var textarea = $this.parents('.challenge-socialnetwork-box').siblings('.challenge-text-area');
                            if ($this.hasClass('connected')) {
                                // alread connected
                                var avatar = $this.data('avatar');
                                var name = $this.data('displayName');
                                if ($this.hasClass('selected')) {
                                    $this.empty().html('<div class="tag-menu"><p>' + self.resx.msg_ToConnected + '</p></div><span data-max-count=' + charCount + ' class="char-count">' + charCount + '</span>').removeClass('selected');
                                    textarea.keyup();
                                    if (!textarea.hasClass('disabled')) {
                                        $this.find('.char-count').show();
                                    }
                                } else {
                                    $this.html('<span><em><img src="' + avatar + '" alt="" /></em></span><div class="token"></div><div class="tag-menu"><p>' + self.resx.msg_Connected.replace('[SOCIALNETWORK]', dnn.social.socialNetworks[network]).replace('[DISPLAYNAME]', name) + '</p></div><span data-max-count=' + charCount + ' class="char-count">' + charCount + '</span>')
                                        .addClass('selected');
                                    textarea.keyup();
                                    if (!textarea.hasClass('disabled')) {
                                        $this.find('.char-count').show();
                                    }
                                }
                                if ($this.parent().find('li.selected').length)
                                    $this.parent().next().removeClass('disabled');
                                else
                                    $this.parent().next().addClass('disabled');
                            } else {
                                // not connected yet
                                var popupWindow = loadOAuthWindow(network);
                                if (!popupWindow) return;
                                var pollTimer = window.setInterval(function () {
                                    if (popupWindow.closed !== false) {
                                        window.clearInterval(pollTimer);
                                        // closed
                                        self.apiCall('POST', 'GetNetworksStatus', { networks: network }, function (d) {
                                            if (d && d.success && d.results && d.results.length) {
                                                var info = d.results[0];
                                                if (info && info.avatar && info.name) {
                                                    $this.html('<span><em><img src="' + info.avatar + '" alt="" /></em></span><div class="token"></div><div class="tag-menu"><p>' + self.resx.msg_Connected.replace('[SOCIALNETWORK]', dnn.social.socialNetworks[network]).replace('[DISPLAYNAME]', info.name) + '</p></div><span data-max-count=' + charCount + ' class="char-count">' + charCount + '</span>')
                                                        .addClass('connected').addClass('selected')
                                                        .data('avatar', info.avatar).data('displayName', info.name);
                                                    $this.parent().next().removeClass('disabled');
                                                    textarea.keyup();
                                                    return;
                                                }
                                            }
                                            $.dnnAlert({
                                                title: self.resx.err_ConnectFailTitle,
                                                text: self.resx.err_ConnectFailBody.replace('[SOCIALNETWORK]', dnn.social.socialNetworks[network])
                                            });
                                        });
                                    }
                                }, 200);
                            }
                        });
                        $(this).data("clickBinded", true);
                    }
                });

                $('.challenge-message-box').find('textarea').attr('disabled', true);
                $.fn.toggleAttr = function (a, b) {
                    var c = (b === undefined);
                    return this.each(function () {
                        if ((c && !$(this).is("[" + a + "]")) || (!c && b)) $(this).attr(a, a);
                        else $(this).removeAttr(a);
                    });
                };

                //Edit button
                $('i.edit-challenge-msg-btn').click(function() {
                    var textarea = $(this).siblings('textarea');
                    textarea.keyup();
                    textarea.toggleClass('disabled');
                    textarea.toggleAttr('disabled');
                        textarea.siblings('.challenge-socialnetwork-box').find('span.char-count').slideToggle(0, function () {
                            if ($(this).is(':visible'))
                                $(this).css('display', 'block');
                        });
                });

                $('textarea.challenge-text-area').keyup(function (e) {
                    var currentCharCount = $(this).val().length;
                    var textarea = $(this);
                    if (!textarea.hasClass('disabled')) {
                        textarea.siblings('.challenge-socialnetwork-box').find('span.char-count').show();
                    }
                    textarea.siblings('.challenge-socialnetwork-box').find('span.char-count').each(function (i, v) {                        
                        var maxCount = parseInt($(v).data('max-count'));

                        $(v).text(maxCount - currentCharCount);

                        if (currentCharCount > maxCount) {
                            $(v).addClass('exceeded');
                            setTimeout(function() {
                                if ($(v).parent().hasClass('selected')) {
                                    textarea.siblings('.challenge-socialnetwork-box').find('.dnnPrimaryAction').addClass('disabled');
                                }
                            }, 250);
                        } else {
                            $(v).removeClass('exceeded');
                            if(textarea.siblings('.challenge-socialnetwork-box').find('li[class^="socialnetwork-"]').hasClass('selected'))
                            {
                                textarea.siblings('.challenge-socialnetwork-box').find('.dnnPrimaryAction').removeClass('disabled');
                            }
                        }
                    });
                });

                // share button
                $('ul.challenge-socialnetwork-list + a.dnnPrimaryAction').each(function() {
                    if (!$(this).data('clickBinded')) {
                        $(this).click(function(e) {
                            e.preventDefault();
                            var $this = $(this);
                            if (!$this.hasClass('disabled')) {
                                $this.addClass('disabled');
                                var networks = [];
                                $this.prev().find('li.selected').each(function() {
                                    networks.push($(this).data('name'));
                                });
                                var detailView = $this.parents('.challenge-journal-detailview').first();
                                var acceptBtn = detailView.prev().prev();
                                var completedArea = detailView.prev();
                                var moduleId = acceptBtn.data('module-id');
                                var contentItemId = acceptBtn.data('contentitem-id');
                                var message = $this.parent().siblings(".challenge-text-area").val();
                                self.apiCall('POST', 'ShareOnNetwork',
                                    { networks: networks.join(','), contentItemId: contentItemId, moduleId: moduleId, message: message },
                                    function (d) {
                                        if (!d) {
                                            $.dnnAlert({
                                                title: 'Fatal error',
                                                text: 'A fatal error has occurred.'
                                            });
                                            return;
                                        }
                                        if (!d.success && d.message) {
                                            $.dnnAlert({
                                                title: self.resx.err_ShareFailTitle,
                                                text: d.message
                                            });
                                            return;
                                        }
                                        
                                        if (d.failed && d.failed.length) {
                                            var failednetworks = $.map(d.failed, function(o) { return dnn.social.socialNetworks[o]; });
                                            $.dnnAlert({
                                                title: self.resx.err_ShareFailTitle,
                                                text: self.resx.err_ShareFailBody.replace('[SOCIALNETWORKS]', failednetworks.join(', '))
                                            });

                                            // remove sucess networks and let user try unsuccess networks again
                                            detailView.find('ul.challenge-socialnetwork-list > li').each(function () {
                                                var $btn = $(this);
                                                var network = $btn.data('name');
                                                if ($.inArray(network, d.failed) < 0) $btn.remove();
                                                else $btn.empty().html('<div class="tag-menu"><p>' + self.resx.msg_ToConnected + '</p></div>').removeClass('selected').removeClass('connected');
                                            });
                                            return;
                                        }
                                        
                                        if (d.success) {
                                            detailView.remove();
                                            completedArea.show();
                                            isMobile = $('html').hasClass('mobileView');
                                            loadChallengeCompletedArea(completedArea, isMobile);
                                        } 
                                    });
                            }
                        });
                        $(this).data("clickBinded", true);
                    }
                });
            }
        };
    };

    var challengeDynamicToken = new dnn.challenges.DynamicToken();
})();