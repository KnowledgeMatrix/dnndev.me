// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved


if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activityFilterBuilder === 'undefined') dnn.activityFilterBuilder = {};

(function (dnn) {
    'use strict';
    
    dnn.activityFilterBuilder.FilterItem = function (filterItemId, filterId, filterKey, filterValue) {
        var self = this;
        self.FilterItemId = filterItemId;
        self.FilterId = filterId;
        self.FilterKey = filterKey;
        self.FilterValue = filterValue;
    };
    
    dnn.activityFilterBuilder.UserInfo = function (userId, username, displayName) {
        var self = this;
        self.UserId = userId;
        self.Username = username;
        self.DisplayName = displayName;
    };
    
    dnn.activityFilterBuilder.GroupInfo = function (groupId, groupName) {
        var self = this;
        self.GroupId = groupId;
        self.GroupName = groupName;
    };
    
    dnn.activityFilterBuilder.FilterType = function (filterTypeId, filterType, selected) {
        var self = this;
        self.FilterTypeId = filterTypeId;
        self.FilterType = filterType;
        self.Selected = ko.observable(selected);
    };
    
    dnn.activityFilterBuilder.ViewModel = function ($, ko, settings, sf, params) {
        var self = this;

        self.UserId = params['userId'];
        self.Social = new dnn.social.Module(settings);
        self.Localizer = self.Social.getLocalizationController();
        self.FilterId = ko.observable('');
        self.FilterName = ko.observable('');
        self.FilterModuleId = params['moduleId'];
        self.FilterUserId = params['userId'];
        self.FilterItems = new Array();
        self.canDelete = ko.observable('');
        self.saveUpdateText = ko.observable('');
        self.saveUpdateAction = ko.observable('');
        self.FilterTypes = ko.observableArray([]);
        self.SeletedFilterTypeIds = new Array();
        self.FilterAuthors = ko.observableArray([]);
        self.FilterAuthorNames = new Array();
        self.FilterGroups = ko.observableArray([]);
        self.FilterGroupNames = new Array();
        
        self.SaveUpdate = function () {
            var serviceUrl;
            if (self.saveUpdateAction().toString().toLowerCase() == 'update') {
                serviceUrl = sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "UpdateFilter";
            }
            else if (self.saveUpdateAction().toString().toLowerCase() == 'save') {
                serviceUrl = sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "SaveFilter";
            }
            if (self.FilterName().length > 0) {
                self.SetFilters();
                $.ajax({
                    type: "POST",
                    url: serviceUrl,
                    beforeSend: sf.setModuleHeaders,
                    data: { filterId: self.FilterId, filterName: self.FilterName, moduleId: self.FilterModuleId, userId: self.FilterUserId, filterItems: self.FilterItems },
                    success: function() {
                        $('.ui-dialog-content').dialog('close');
                    },
                    error: function(xhr, status, error) {
                        alert(error);
                    }
                });
                self.ResetFields();
            } else {
                
                var errorSpan = $('#FilterName').parent().find('span.dnnFormError').hide();
                var appendError = function (errorMsg) {
                    if (errorSpan.length) {
                        errorSpan.html(errorMsg).show();
                    } else {
                        $('<span></span>').addClass('dnnFormError dnnFormMessage').html(errorMsg).insertAfter($('#FilterName'));
                    }
                };
                var val = $('#FilterName').val();                
                if (!val) {
                    appendError(self.Localizer.getString('ActivityFeedNameRequired'));
                }
                
            }
        };
        
        self.Delete = function () {
            $.ajax({
                type: "POST",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "DeleteFilter",
                beforeSend: sf.setModuleHeaders,
                data: { filterId: self.FilterId },
                success: function () {
                    $('.ui-dialog-content').dialog('close');
                },
                error: function (xhr, status, error) {
                    alert(error);
                }
            });
            self.ResetFields();
        };
        
        self.Cancel = function () {
            self.ResetFields();
            $('.ui-dialog-content').dialog('close');
        };
        
        self.SelectDeselectTypeFilter = function (filter) {
            if (!filter.Selected()) {
                filter.Selected(true);
            } else {
                filter.Selected(false);
            }
        };

        self.GetUserByUsernameDisplayName = function (usernamedisplayname) {
            var user;
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetUserByUsername",
                beforeSend: sf.setModuleHeaders,
                data: { username: usernamedisplayname.toString().substring(usernamedisplayname.toString().indexOf('(') + 1, usernamedisplayname.length - 1) },
                async: false,
                cache: false
            }).done(function (response) {
                user = response;
            });
            return user;
        };
        self.GetUserById = function (userId) {
            var user;
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetUserById",
                beforeSend: sf.setModuleHeaders,
                data: { userId: userId },
                async: false,
                cache: false
            }).done(function (response) {
                user = response;
            });
            return user;
        };
        self.GetGroupByName = function (groupName) {
            var group;
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetGroupByName",
                beforeSend: sf.setModuleHeaders,
                data: { groupName: groupName },
                async: false,
                cache: false
            }).done(function (response) {
                group = response;
            });
            return group;
        };
        self.GetGroupById = function (groupId) {
            var group;
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetGroupById",
                beforeSend: sf.setModuleHeaders,
                data: { groupId: groupId },
                async: false,
                cache: false
            }).done(function (response) {
                group = response;
            });
            return group;
        };
        self.FormatUserDisplayName = function(user)
        {
            return user.DisplayName + " (" + user.Username + ")";
        };
        self.SerializeAuthorGroupFilterItems = function (filterItems) {
            var list = [];
            $.each(filterItems,
                function (index, filterItem) {
                    list.push(new dnn.activityFilterBuilder.FilterItem(filterItem.FilterKey, filterItem.FilterValue));
                });
            return list;
        };
        
        self.PopulateAuthorTags = function () {
            $.each(self.FilterAuthorNames,
                      function (index, userDisplayName) {
                          $('#FilterAuthors').dnnAddTag(userDisplayName);
                      });
        };
        
        self.PopulateGroupTags = function () {
            $.each(self.FilterGroupNames,
                      function (index, groupName) {
                          $('#FilterGroups').dnnAddTag(groupName);
                      });
        };
        
        self.PopulateTypes = function () {
            self.FilterTypes.removeAll();            
            $.ajax({
                type: "GET",
                url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetAllowableFilterTypes",
                beforeSend: sf.setModuleHeaders,
                data: { moduleId: params['moduleId'] },
                cache: false,
                async: false
            }).done(function (response) {
                $.each(response, function (index) {
                    var selected = false;
                    if (self.SeletedFilterTypeIds.length > 0 && ($.inArray(response[index].JournalTypeId.toString(), self.SeletedFilterTypeIds) > -1)) {
                        selected = true;
                    }
                    self.FilterTypes.push(new dnn.activityFilterBuilder.FilterType(response[index].JournalTypeId, response[index].JournalType, selected));
                });
            });
        };
        
        self.SetFilters = function () {
            if (self.FilterAuthors().length > 0) {
                for (var i = 0; i < self.FilterAuthors().length; i++) {
                    self.FilterItems.push(new dnn.activityFilterBuilder.FilterItem(0, 0, params['authorKey'], self.FilterAuthors()[i].UserId));
                }
            }
            if (self.FilterGroups().length > 0) {
                for (var i = 0; i < self.FilterGroups().length; i++) {
                    self.FilterItems.push(new dnn.activityFilterBuilder.FilterItem(0, 0, params['groupKey'], self.FilterGroups()[i].GroupId));
                }
            }
            if (self.FilterTypes().length > 0) {
                for (var i = 0; i < self.FilterTypes().length; i++) {
                    if (self.FilterTypes()[i].Selected()) {
                        self.FilterItems.push(new dnn.activityFilterBuilder.FilterItem(0, 0, params['typeKey'], self.FilterTypes()[i].FilterTypeId));
                    }
                }
            }
        };
        
        self.ResetFields = function () {
            self.FilterId('');
            self.FilterName('');
            self.FilterItems = new Array();

            self.canDelete('');
            self.saveUpdateText('');
            self.saveUpdateAction('');

            self.FilterAuthors.removeAll();
            self.FilterAuthorNames = new Array();
            $('#FilterAuthors').val('');
            self.FilterGroups.removeAll();
            self.FilterGroupNames = new Array();
            $('#FilterGroups').val('');
            $('.tag').remove();

            self.SeletedFilterTypeIds = new Array();
            self.PopulateTypes();
        };
        
        self.BindAuthorFilters = function () {
            $('#FilterAuthors').val(self.SerializeAuthorGroupFilterItems(self.FilterAuthorNames));
            $('#FilterAuthors').dnnTagsInput({
                onAddTag:
                    function (usernamedisplayname) {
                        var user = self.GetUserByUsernameDisplayName(usernamedisplayname);
                        if (user != null) {
                            self.FilterAuthors.push(new dnn.activityFilterBuilder.UserInfo(user.UserId, user.Username, user.DisplayName));
                            self.FilterAuthorNames.push(user.DisplayName + ' (' + user.Username + ')');
                        } else {
                            $('#FilterAuthors').dnnRemoveTag(usernamedisplayname);
                        }
                    },
                onRemoveTag:
                    function (usernamedisplayname) {
                        $.each(self.FilterAuthors(),
                            function (index, author) {
                                if (author.Username === usernamedisplayname.toString().substring(usernamedisplayname.toString().indexOf('(') + 1, usernamedisplayname.length - 1)) {
                                    self.FilterAuthors.splice(index, 1);
                                    self.FilterAuthorNames.splice(index, 1);
                                    return false;
                                }
                                return true;
                            });
                    },
                minInputWidth: '200px',
                defaultText: self.Localizer.getString('AddAuthorTag'),
                autocomplete: {
                    moduleId: params['moduleId'],
                    selectFirst: true,
                    useCache: true
                },
                width: '57%',
                autocomplete_url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetUsernameDisplayNames"
            });           
            return null;
        };
        
        self.BindGroupFilters = function () {
            $('#FilterGroups').val(self.SerializeAuthorGroupFilterItems(self.FilterGroups()));
            $('#FilterGroups').dnnTagsInput({
                onAddTag:
                    function (groupName) {
                        var group = self.GetGroupByName(groupName);
                        if (group != null) {
                            self.FilterGroups.push(new dnn.activityFilterBuilder.GroupInfo(group.GroupId, group.GroupName));
                            self.FilterGroupNames.push(group.GroupName);
                        } else {
                            $('#FilterGroups').dnnRemoveTag(groupName);
                        }
                    },
                onRemoveTag:
                    function (groupName) {
                        $.each(self.FilterGroups(),
                            function (index, group) {
                                if (group.GroupName === groupName) {
                                    self.FilterGroups.splice(index, 1);
                                    self.FilterGroupNames.splice(index, 1);
                                    return false;
                                }
                                return true;
                            });
                    },
                minInputWidth: '200px',
                defaultText: self.Localizer.getString('AddGroupTag'),
                autocomplete: {
                    moduleId: params['moduleId'],
                    selectFirst: true,
                    useCache: true
                },
                width: '57%',
                autocomplete_url: sf.getServiceRoot('DNNCorp/ActivityStream') + "ActivityFilterServices/" + "GetGroupNames"
            });
            return null;
        };
        
        self.BindControls = function () {
            self.BindAuthorFilters();
            self.BindGroupFilters();
        };

        self.binded = function() {
            self.BindControls();
            $('.filterType').click(
               function () {
                   var cb = $(this).find("#checkboxImg")[0];
                   if ($(cb).hasClass('unchecked')) {
                       $(cb).removeClass('unchecked');
                       $(cb).addClass('checked');
                   } else {
                       $(cb).removeClass('checked');
                       $(cb).addClass('unchecked');
                   }
               }
           );
        };
    };
})(window.dnn);

