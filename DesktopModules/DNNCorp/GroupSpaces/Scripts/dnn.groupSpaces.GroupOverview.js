// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';
    dnn.groupSpaces.GroupOverview = function GroupOverview($, ko, settings) {
        var self = this;
        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('GroupSpacesService');
        this.componentFactory = this.social.getComponentFactory();
        this.componentFactory.register(this, 'PrimaryView');
        this.localizer = self.social.getLocalizationController();
        this.componentFactory.register(new dnn.groupSpaces.SearchController($, ko, settings, self.social));
        this.componentFactory.register(new dnn.social.FocusController($, ko, settings, this.social, window.document, []));
        this.GroupId = ko.observable(settings.groupInfo.groupId);
        this.GroupKey = settings.groupKey;
        this.GroupImageUrl = ko.observable(settings.groupInfo.imageUrl);
        this.GroupName = ko.observable(settings.groupInfo.groupName);
        this.GroupDescription = ko.observable(settings.groupInfo.description);
        this.GroupMemberStat = ko.observable(settings.groupInfo.memberCount);
        this.IsGroupPendingToBeApproved = ko.observable(settings.groupInfo.isPendingToBeApproved);
        this.IsMember = ko.observable(settings.groupInfo.isMember);
        this.IsPublic = ko.observable(settings.groupInfo.isPublic);
        this.IsMembershipPending = ko.observable(settings.groupInfo.membershipPending);
        this.IsGroupOwner = ko.observable(settings.groupInfo.isGroupOwner);
        this.Rating = ko.observable(settings.groupInfo.rating);
        var date = dnn.social.toDateFromDotNetJson(settings.groupInfo.createdOnDate);
        this.GroupCreatedStat = ko.observable(date.toDateString());
        this.GroupActivityStat = ko.observable();
        this.GroupScoreStat = ko.observable();

        this.join = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return false;
            }

            var success = function (data) {
                if (settings.tokenUserView) {
                    var url = window.location.href;
                    window.location.href = url.split('?')[0];
                    return false;
                }
                self.IsMember(true);
                self.IsMembershipPending(data.Pending);
                if (self.IsMembershipPending()) {
                    $("#pending").visible = true;
                    $("#invite").visible = false;
                    $("#join").visible = false;
                }
                else if (self.IsMember()) {
                    self.GroupMemberStat(self.GroupMemberStat() + 1);
                    $("#invite").visible = true;
                    $("#pending").visible = false;
                    $("#join").visible = false;
                }
                self.bindControls();
                self.notifyJoinGroup();
            };
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: self.localizer.getString('FailedToJoinGroupTitle'),
                    text: self.localizer.getString('FailedToJoinGroup').format(status)
                });
            };

            var groupParams = {
                groupId: self.GroupId(),
                groupKey: self.GroupKey
            };
            self.service.post('JoinGroup', groupParams, success, failure);
            return false;
        };

        this.leave = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return false;
            }
            var success = function () {
                window.location.href = settings.returnUrl;
            };
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: self.localizer.getString('FailedToLeaveGroupTitle'),
                    text: self.localizer.getString('FailedToLeaveGroup').format(status)
                });
            };
            var groupParams = {
                groupId: self.GroupId()
            };
            self.service.post('LeaveGroup', groupParams, success, failure);
            return false;
        };

        this.notifyJoinGroup = function () {
            var msg = {
                event: 'UserJoinsGroup',
                groupId: self.GroupId()
            };
            dnn.social.ipc.post(self.settings, 'DNNCorp/GroupSpaces', msg);
        };

        this.navHomeClick = function () {
            self.redirectToHomeTab();
        };

        this.navAnalyticsClick = function () {
            if ($('#navAnalytics').hasClass('inactive')) {
                $('#navAnalytics').removeClass('inactive').addClass('active');
                //TODO: IMPLEMENT
            }
        };

        this.navSettingsClick = function () {
            if ($('.navSettings').hasClass('inactive')) {
                $('.navSettings').removeClass('inactive').addClass('active');
                self.openEditWizardDialog();
            }
            else {
                $('.navSettings').removeClass('active').addClass('inactive');
            }
        };

        this.navSearchClick = function () {
            if ($('#navSearch').hasClass('inactive')) {
                $('#navSearch').removeClass('inactive').addClass('active');
                $('.groupOverview-search').fadeIn();
            }
            else {
                $('#navSearch').removeClass('active').addClass('inactive');
                $('.groupOverview-search').fadeOut();
                self.hideResults();
            }
        };

        this.redirectToHomeTab = function () {
            var success = function (data) {
                window.location.href = data.Url;
            };
            var failure = function () {};
            var groupParams = {
                groupId: self.GroupId()
            };
            self.service.get('GetGroupHomeUrl', groupParams, success, failure);
        };
     
        this.openEditWizardDialog = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
            var primaryView = self.social.getComponentFactory().resolve('PrimaryView');
            if (primaryView != null) {
                var options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: self.localizer.getString('EditGroup'),
                    width: 850,
                    resizable: false,
                    close: function () {
                        //reset navtab css
                        $('.navSettings').removeClass('active');
                        $('.navSettings').addClass('inactive');
                    }
                };
                $('.group-edit-dialog').dialog(options);
                var editGroupModel = ko.contextFor($(settings.editGroupWizardId)[0]).$root;
                if (editGroupModel != null) { editGroupModel.bindControls(); }
            }
            return true;
        };
      
        this.showResults = function () {
            var shadow = $('.results-modalShadow');
            if (shadow.length === 0) {
                shadow = $('<div></div>')
                    .height($('html body')[0].scrollHeight)
                    .addClass('results-modalShadow')
                    .appendTo($('body'));
            }

            shadow.fadeIn('fast');

            $('#navSearch')
                .addClass('nav-searchContainer');
            $('.groupOverview-search')
                .css('width', $('.groupOverview-search').width())
                .css('height', $('.groupOverview-search').height())
                .addClass('groups-searchContainer');
            $('.groups-search-results')
                .addClass('groups-searchContainer')
                .css('width', $('.groupOverview-search').width()).slideDown();
        };
        
        this.hideResults = function (completionHandler) {
            if ($('.groups-search-results').is(':visible') == true) {
                $('.groups-search-results').slideUp('fast',
                    function () {
                        $('.groups-search-results').removeClass('groups-searchContainer');
                        $('.groupOverview-search').removeClass('groups-searchContainer');
                        $('.results-modalShadow').fadeOut('fast');
                        
                        var searchController = self.componentFactory.resolve('SearchController');
                        searchController.query('');
                        
                        if (typeof completionHandler === 'function') {
                            completionHandler();
                        }
                    });
            }
        };
        
        this.toggleResults = function () {
            if ($('.groups-search-results').is(':visible')) {
                self.hideResults();
            }
            else {
                self.showResults();
            }
        };
        
        // Mobile View
        this.navHomeClickMobile = function () {
            if ($('#dnnMobile-navHome').hasClass('inactive')) {
                self.redirectToHomeTab();
            }
        };

        this.navSearchClickMobile = function () {
            if ($('#dnnMobile-navSearch').hasClass('inactive')) {
                $('#dnnMobile-navHome').removeClass('active').addClass('inactive');
                $('#dnnMobile-navSearch').removeClass('inactive').addClass('active');
                $('.dnnMobile-groupOverview-search').show();
            }
            else {
                this.hideResultsMobile(function() {
                    $('#dnnMobile-navSearch').removeClass('active').addClass('inactive');
                    if (settings.tabId == settings.homeTabId) $('#dnnMobile-navHome').removeClass('inactive').addClass('active');
                    $('.dnnMobile-groupOverview-search').hide();
                });
            }
        };
        
        this.showResultsMobile = function () {
            $('.suggestion-modalShadow').remove();
            var shadow = $('<div></div>')
                    .height($('html body')[0].scrollHeight)
                    .addClass('suggestion-modalShadow')
                    .appendTo($('body'));

            shadow.fadeIn('fast');
            
            $('#dnnMobile-navSearch')
                .addClass('nav-searchContainer');

            $('.dnnMobile-groupOverview-search')
                .css('width', $('.dnnMobile-groupOverview-search').width())
                .css('height', $('.dnnMobile-groupOverview-search').height())
                .addClass('groups-searchContainer');

            $('.dnnMobileGroupSearchResult')
                .css('width', $('.dnnMobile-groupOverview-search').width()).slideDown()
                .addClass('groups-searchContainer');
        };

        this.hideResultsMobile = function(completionHandler) {
            if ($('.dnnMobileGroupSearchResult').is(':visible') == false) {
                if (typeof completionHandler === 'function') {
                    completionHandler();
                }
            }
            else {
                $('.dnnMobileGroupSearchResult').slideUp('fast',
                    function () {
                        $('.dnnMobileGroupSearchResult').removeClass('groups-searchContainer');
                        $('.dnnMobile-groupOverview-search').removeClass('groups-searchContainer');
                        $('.suggestion-modalShadow').fadeOut('fast');

                        var searchController = self.componentFactory.resolve('SearchController');
                        searchController.query('');
                        
                        if (typeof completionHandler === 'function') {
                            completionHandler();
                        }
                    });
            }
        };

        this.toggleResultsMobile = function() {
            if ($('.dnnMobileGroupSearchResult').is(':visible')) {
                self.hideResultsMobile();
            } else {
                self.showResultsMobile();
            }
        };
        
        this.switchingView = function () {
            $('.groupOverview-search, .dnnMobile-groupOverview-search').hide();
            this.hideResults();
            this.hideResultsMobile();
        };

        this.switchedView = function () {
            $('.groupOverview-nav > div, .dnnMobile-groupOverview-nav > div').removeClass('active').addClass('inactive');
            if (settings.tabId == settings.homeTabId) {
                $('#navHome, #dnnMobile-navHome').removeClass('inactive').addClass('active');
            }
        };

        $('.loading-loader', settings.moduleScope).removeClass('loading');
        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);

        this.bindControls = function () {
            $('#leave').dnnConfirm({
                title: self.localizer.getString('LeaveGroupTitle'),
                text: self.localizer.getString('LeaveGroupCaption'),
                yesText: self.localizer.getString('Yes'),
                noText: self.localizer.getString('No'),
                callbackTrue: function () {
                    self.leave();
                }
            });
            
            if (settings.tabId == settings.homeTabId) {
                $('#navHome, #dnnMobile-navHome').removeClass('inactive').addClass('active');
            }

            if (settings.groupInfo.groupId < 0) {
                self.GroupId(-1);
                self.GroupImageUrl("");
                self.GroupName(self.localizer.getString('SampleGroupName'));
                self.GroupDescription(self.localizer.getString('SampleGroupDescription'));
                self.GroupMemberStat(0);
                self.IsMember(false);
                self.IsMembershipPending(false);
                self.Rating("");
                var today = new Date();
                self.GroupCreatedStat(today.toDateString());
            }

            dnn.social.loaded(settings.moduleScope.id);
            $(window.document).bind('focused',
               function () {
                   if ($('.groups-search-results').is(':visible')) {
                       self.hideResults();
                   }
               });
        };
        
        this.binded = function () {
            this.bindControls();                  
        };
    };
})(window.dnn);