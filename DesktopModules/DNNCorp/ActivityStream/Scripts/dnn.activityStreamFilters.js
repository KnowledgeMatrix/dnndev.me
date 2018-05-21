// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activityStreamFilters === 'undefined') dnn.activityStreamFilters = {};

(function (dnn) {
    'use strict';
    dnn.activityStreamFilters.Filter = function (filterId, filterName) {
        var self = this;
        self.FilterId = filterId;
        self.FilterName = filterName;
    };
   
    dnn.activityStreamFilters.ViewModel = function ($, ko, settings, sf, params) {
        var self = this;
        
        self.social = new dnn.social.Module(settings);
        
        self.Filters = ko.observableArray([]);
       
        $.ajax({
            type: "GET",
            url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetFilters",
            beforeSend: sf.setModuleHeaders,
            cache: false
        }).done(function (response) {
            $.each(response, function (index) {
                self.Filters.push(new dnn.activityStreamFilters.Filter(response[index].FilterId, response[index].FilterName));
            });
        });            
        
        self.showFilterEditor = function (filter) {
            var filterBuilderModel = ko.contextFor($(settings.filterBuilderId)[0]).$root;

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: self.social.getLocalizationController().getString('FilterBuilder'),
                minWidth: 650,
                resizable: false,
                closeOnEscape: false,
                close: function () {                    
                    filterBuilderModel.ResetFields();               
                    self.Filters.removeAll();
                    $.ajax({
                        type: "GET",
                        url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetFilters",
                        beforeSend: sf.setModuleHeaders,
                        cache: false
                    }).done(function(response) {
                        $.each(response, function(index) {
                            self.Filters.push(new dnn.activityStreamFilters.Filter(response[index].FilterId, response[index].FilterName, settings));
                        });
                    });
                }
            };
            
            $('#filterEditorContainer').dialog(options);
            
            if (filter.FilterId > 0) {
                filterBuilderModel.canDelete(true);
                filterBuilderModel.saveUpdateText(self.social.getLocalizationController().getString('Update'));
                filterBuilderModel.saveUpdateAction('Update');

                $.ajax({
                    type: "GET",
                    url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetFilterById",
                    beforeSend: sf.setModuleHeaders,
                    data: { filterId: filter.FilterId },
                    cache: false
                }).done(function (response) {
                    filterBuilderModel.FilterId(filter.FilterId);
                    filterBuilderModel.FilterName(filter.FilterName);
                    filterBuilderModel.FilterAuthorNames = new Array();
                    for (var i = 0; i < response.FilterItems.length; i++) {
                        if (response.FilterItems[i].FilterKey == 'user') {                            
                            filterBuilderModel.FilterAuthorNames.push(filterBuilderModel.FormatUserDisplayName(filterBuilderModel.GetUserById(response.FilterItems[i].FilterValue)));
                        }
                    }
                    filterBuilderModel.PopulateAuthorTags();
                    filterBuilderModel.FilterGroupNames = new Array();
                    for (var i = 0; i < response.FilterItems.length; i++) {
                        if (response.FilterItems[i].FilterKey == 'group') {
                            filterBuilderModel.FilterGroupNames.push(filterBuilderModel.GetGroupById(response.FilterItems[i].FilterValue).GroupName);
                        }
                    }
                    filterBuilderModel.PopulateGroupTags();
                    filterBuilderModel.SeletedFilterTypeIds = new Array();
                    for (var i = 0; i < response.FilterItems.length; i++) {
                        if (response.FilterItems[i].FilterKey == 'journalType') { filterBuilderModel.SeletedFilterTypeIds.push(response.FilterItems[i].FilterValue); };
                    }
                    filterBuilderModel.PopulateTypes();
                });
            } else {
                filterBuilderModel.ResetFields();
                filterBuilderModel.canDelete(false);
                filterBuilderModel.saveUpdateText(self.social.getLocalizationController().getString('Save'));
                filterBuilderModel.saveUpdateAction('Save');
            };

        };
        
        self.sendFilterMessage = function (filter) {
            dnn.social.ipc.post(settings, 'DNNCorp/ActivityStream', { ProfileId: params['userId'], FilterId: filter.FilterId, event: 'Filter' });
        };
    };   
})(window.dnn);
