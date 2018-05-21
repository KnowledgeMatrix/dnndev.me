// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved


if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupSpaces === 'undefined') dnn.groupSpaces = {};

(function (dnn) {
    'use strict';

    dnn.groupSpaces.EditTabs = function EditTabs($, ko, settings) {
        var self = this;

        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('GroupSpacesService');
        this.localizer = this.social.getLocalizationController();
        this.selectedTabs = ko.observableArray([]);
        this.homeTabId = ko.observable(settings.homeTabId);

        // Group Tabs
        this.updateSelectedTabs = function (checkboxTabId) {
            var tabs = self.selectedTabs().filter(function (tab) { return tab.showTab == true; });

            if (checkboxTabId != undefined) {
                var tabCheckbox = $('#' + checkboxTabId);
                if (tabCheckbox.length > 0) {
                    var tabChecked = tabCheckbox[0].checked;
                    var tabId = tabCheckbox[0].value;

                    if (tabChecked) {
                        self.addTabToSelectedTabs(self.groupTabs(), tabs, tabId);
                    } else {
                        self.removeTabFromSelectedTabs(tabs, tabId);
                    }
                }
            } else {
                self.updateTabCheckBoxes();
            }

            self.selectedTabs(tabs.sort(function (a, b) { if (a.tabId < b.tabId) return -1; if (a.tabId > b.tabId) return 1; return 0; }));

            return true;
        };

        this.addTabToSelectedTabs = function (sourceTabList, destinationTabList, tabId)
        {
            for (var i = 0; i < sourceTabList.length; i++) {
                if (sourceTabList[i].tabId == tabId) {
                    var alreadyExistsTab = false;
                    for (var j = 0; j < destinationTabList.length; j++) {
                        if (destinationTabList[j].tabId == tabId) {
                            alreadyExistsTab = true;
                            destinationTabList[j].showTab = true;
                        }
                    }
                    if (!alreadyExistsTab) {
                        sourceTabList[i].showTab = true;
                        destinationTabList.push(sourceTabList[i]);
                    }

                    break;
                }
            }
        };

        this.removeTabFromSelectedTabs = function (destinationTabList, tabId) {
            var tabIndexToRemove = -1;
            for (var i = 0; i< destinationTabList.length; i++) {
                if (destinationTabList[i].tabId == tabId) {
                    destinationTabList[i].showTab = false;
                    tabIndexToRemove = i;
                    break;
                }
            }

            if (tabIndexToRemove >= 0 && tabIndexToRemove < destinationTabList.length) {
                destinationTabList.splice(tabIndexToRemove, 1);
            }
        };

        this.updateTabCheckBoxes = function() {
            for (var i = 0; i < self.groupTabs().length; i++) {
                $('#tab_' + self.groupTabs()[i].tabId)[0].checked = self.groupTabs()[i].showTab;
            }
        };

        this.groupTabs = ko.observableArray([]);

        this.savedGroupTabs = function () {
            if (settings.groupId > -1) {
                var failure = function () { };
                var success = function (data) {
                    self.selectedTabs(data);
                    self.groupTabs(data);
                    self.updateSelectedTabs();

                    if (data.length < 1) {
                        $('.groupFeatures').hide();
                        $('.noGroupFeatures').show();                        
                        $('#save').hide();
                    }
                    self.groupTabs(data);
                    $('#tab_' + settings.homeTabId).attr("disabled", "disabled");
                };
                var params = { groupId: settings.groupId };
                self.service.get('GetAllGroupPages', params, success, failure, self.loading);
            }
        };

        this.bindControls = function (m) {
            self.savedGroupTabs();
        };

        this.updateGroupTabs = function () {
            var failure = function (data, status) {
                $.dnnAlert({
                    title: self.localizer.getString('SaveTabsFailedTitle'),
                    text: self.localizer.getString('SaveTabsFailed') + JSON.parse(data.responseText)["ErrorMessage"] || status
                });
            };
            var success = function () {
                dnn.social.EventQueue.push(
                    function () {
                        var saveSuccess = function (data) {
                            window.location.href = data.Url;
                        };
                        var redirectParams = { groupId: settings.groupId };
                        self.service.getsync('GetGroupHomeUrl', redirectParams, saveSuccess, failure, self.loading);
                    });
            };

            if (self.selectedTabs().length < 1) {
                $.dnnAlert({
                    title: self.localizer.getString('SaveTabsFailedTitle'),
                    text: self.localizer.getString('MustSelectOneGroupFeature')
                });
                return;
            }
            
            var params = {
                groupId: settings.groupId,
                tabs: self.groupTabs(),
                homeTabId: self.homeTabId()
            };
            self.service.postsync("SaveGroupTabs", params, success, failure);
        };

        this.cancel = function () {
            $('.edit-tabs-dialog').dialog({ close: '' });
            $('.edit-tabs-dialog').dialog('close');
        };

    };
})(window.dnn);