// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved


if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';

    dnn.groupSpaces.GroupFeatures = function GroupFeatures($, ko, settings) {
        var self = this;

        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('GroupSpacesService');
        this.GroupId = ko.observable(settings.groupId);
        this.componentFactory = this.social.getComponentFactory();
        this.componentFactory.register(this, 'PrimaryView');
        this.localizer = function () { return self.social.getLocalizationController(); };
        
        this.loadGroupTabs = function () {
            if (settings.groupId > -1) {
                var failure = function () { };
                var success = function (data) {
                    self.tabs(data);
                    var mobileTabs = $.grep(data, function(value) {
                        return value.tabId !== settings.tabId;
                    });
                    
                    self.mobileTabs(mobileTabs);
                };
                var params = { groupId: settings.groupId };
                self.service.getsync('GetGroupPages', params, success, failure, self.loading);
            }
        };

        this.tabs = ko.observableArray(settings.groupPages);

        this.tabNavigate = function (tab) {
            var failure = function () { };
            var success = function (data) {
                window.location.href = data.Url;
            };
            
            var params = { groupId: self.GroupId(), tabId: tab.tabId };
            self.service.getsync('GetGroupTabUrl', params, success, failure, self.loading);
        };

        this.editTabs = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return true;
            }
            var primaryView = self.social.getComponentFactory().resolve('PrimaryView');
            if (primaryView != null) {
                var localizer = self.localizer();
                var options = {
                    modal: true,
                    autoOpen: true,
                    dialogClass: 'dnnFormPopup',
                    title: localizer.getString('GroupFeatures'),
                    width: 750,
                    resizable: false,
                    close: function () {
                        self.loadGroupTabs();
                        self.bindControls();
                    }
                };
                $('.edit-tabs-dialog').dialog(options);
                var editTabsModel = ko.contextFor($(settings.editTabsId)[0]).$root;
                if (editTabsModel != null) { editTabsModel.bindControls(); }
            }
            return true;
        };

        this.bindControls = function () {
            $('#dnnGroupSpaces').dnnTabs();
            $("#tabNavTab-" + settings.currentTabName).addClass("tabNavCurrentTab");

            var ul = $("#dnnAdminTabNav");
            var fixedTabBarWidth = $("#dnnAdminTabNav").width();
            ul.wrapInner('<div id="fixedTabContainer" class="fixedTabContainer"><div id="moveableTabContainer" class="moveableTabContainer"></div></div>');

            //Left Arrorw
            ul.append('<li class="tabNavTab tabscroll-left tabscroll"></li>');
            var leftArrow = ul.children().last();
            //Right Arrow
            ul.append('<li class="tabNavTab tabscroll-right tabscroll"></li>');
            var rightArrow = ul.children().last();

            var moveable = ul.find('.moveableTabContainer').first();

            leftArrow.click(function () {
                var offset = 100;
                var currentPosition = moveable.css('left').replace('px', '') / 1;

                if (currentPosition + offset >= 0) {
                    moveable.stop().animate({ left: '0' }, 'fast');
                }
                else {
                    moveable.stop().animate({ left: currentPosition + offset + 'px' }, 'fast');
                }
            });

            rightArrow.click(function () {
                var offset = 100;
                var currentPosition = moveable.css('left').replace('px', '') / 1;
                var originalWidth = 0;
                
                ul.find('li').each(function (index, element) {
                    originalWidth += $(element).width();
                    originalWidth += ($(element).css('margin-right').replace('px', '') / 1);
                });

                originalWidth *= -1;

                if (currentPosition - fixedTabBarWidth > originalWidth - 100) {
                    moveable.stop().animate({ left: currentPosition - offset + 'px' }, 'fast');
                }
            });
            
            $('#moveableTabContainer').css({ 'left': '0px' });
            var accumWidth = 0;
            $('#dnnAdminTabNav').find('li').each(function () {
                accumWidth += $(this).width();
            });
            if (accumWidth > $('#fixedTabContainer').width()) {
                $('.tabscroll').show();
            }
            else {
                $('.tabscroll').hide();
            }
        };
        
        // Mobile View
        this.mobileTabs = ko.observableArray(settings.groupPages);
        this.currentTabName = ko.observable('');
        this.currentTab = null;
        
        this.toggleNavBarMobile = function() {
            if ($('.dnnMobileGroupsTab').is(':visible')) {
                $('.dnnMobileGroupsTab').slideUp('fast');
            } else {
                $('.dnnMobileGroupsTab').slideDown('fast');
            }
        };
        
        this.switchingView = function () {
        };

        this.switchedView = function () {
            if (this.isMobileView()) {
                $('#dnnMobile-dnnGroupSpaces > div').appendTo('#groupNavContainer');
                if (!self.currentTab) {
                    var tabs = self.tabs();
                    for (var i = 0; i < tabs.length; i++) {
                        if (tabs[i].tabId === settings.tabId) {
                            self.currentTab = tabs[i];
                            break;
                        }
                    }
                }
                if (self.currentTab) {
                    self.currentTabName(self.currentTab.tabName);
                }
            } else {
                $('#groupNavContainer > div').appendTo('#dnnMobile-dnnGroupSpaces');
                this.bindControls();
            }
            $('#static-row-group-tabs').remove();
        };
        
        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);

        this.binded = function () {
            dnn.social.loaded(settings.moduleScope.id);
            this.switchedView();
        };
    };

})(window.dnn);