// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};

(function (dnn) {
    'use strict';

    dnn.groupDirectory.ListController = function ListController($, ko, settings, social) {
        var self = this;
        var componentFactory = social.getComponentFactory();

        this.social = social;
        this.primaryView = componentFactory.resolve('PrimaryView');
        this.service = self.social.getService('List');
        this.totalResults = ko.observable(0);
        this.results = ko.observableArray([]);
        this.resultsMobile = ko.observableArray([]);
        this.sort = ko.observable(settings.sort);
        this.category = ko.observable(settings.category || 'allgroups');
        this.searchFilter = ko.observable();
        this.tags = ko.observableArray([]);
        this.frozen = ko.observable(false);
        this.loading = ko.observable(false);
        this.sequence = 0;
        

        this.loadGroupToolTips = function () {
            var options = {
                tooltipSelector: '.groupToolTip',
                asyncDelegate: function (callback) {
                    setTimeout(callback, 100);
                },
                postRender: function () {
                    this.find('.groupToolTip').height(this.find('.groupToolTipContent').height());
                }
            };
            setTimeout(function () { $('.groupTooltip', settings.moduleScope).qaTooltip(options); }, 100);
        };

        this.closeToolTip = function () {
            $('.groupToolTip').hide();
        };

        this.page = function () {
            var paging = componentFactory.resolve('PagingControl');
            if (paging != null) {
                return paging.page();
            }
            return 0;
        };

        this.load = function (appendToOriginalStes) {
            if (self.frozen()) {
                return;
            }
            var loadingContainer = $('.loading-container', settings.moduleScope);

            var failure =
                function (xhr, status) {
                    loadingContainer.removeClass('loading');
                    $.dnnAlert({
                        title: self.primaryView.getString('FailedToLoadGroupDirectoryTitle'),
                        text: self.primaryView.getString('FailedToLoadGroupDirectory').format(status)
                    });
                };

            var success =
                function (data) {
                    if (data.Sequence != self.sequence - 1) {
                        return;
                    }
                    
                    loadingContainer.removeClass('loading');

                    if (data.hasOwnProperty('Results') === false || data.hasOwnProperty('TotalRecords') === false) {
                        return;
                    }
                    
                    var results = [];
                    
                    $.each(data.Results,
                        function (index, group) {
                            var groupParams = {
                                GroupId: group.groupId,
                                GroupKey: group.groupKey,
                                Name: group.groupName,
                                Description: group.description,
                                ImageUrl: group.imageUrl,
                                IconFile: group.iconFile,
                                MemberCount: group.memberCount,
                                Url: group.url,
                                CreatedOnDate: group.createdOnDate,
                                IsMember: group.isMember,
                                MembershipPending: group.membershipPending,
                                IsPublic: group.isPublic,
                                Rating: group.rating,
                                IsPendingToBeApproved: group.isPendingToBeApproved,
                                UserCanViewGroup: group.userCanViewGroup,
                                FolderId: group.folderId
                            };
                            results.push(new dnn.groupDirectory.GroupInfo($, ko, settings, social, groupParams));
                        });

                    if (appendToOriginalStes) {
                        for (var i = 0; i < results.length; i++) {
                            var exists = false;
                            $.each(self.resultsMobile(),
                                function(index, p) {
                                    if (p.GroupId === results[i].GroupId) {
                                        exists = true;
                                        return false;
                                    }
                                    return true;
                                });

                            if (!exists)
                                self.resultsMobile.push(results[i]);
                        }
                    } else {
                        self.resultsMobile([]);
                        $.each(results, function (index, post) {
                            self.resultsMobile.push(post);
                        });
                    }

                    self.results([]);
                    $.each(results, function (index, post) {
                        self.results.push(post);
                    });

                    self.totalResults(data.TotalRecords || 0);
                    self.loadGroupToolTips();
                };

            loadingContainer.addClass('loading');

            var params = {
                roleGroupId: settings.roleGroupId,
                tags: self.tags(),
                category: self.category(),
                searchFilter: self.searchFilter(),
                pageIndex: self.page(),
                pageSize: settings.pageSize,
                sortField: self.sort(),
                sequence: self.sequence++
            };

            self.service.post('Query', params, success, failure, self.loading);
        };

        this.loadStart = function () {
            var pagingController = componentFactory.resolve('PagingControl');
            if (pagingController != null) {
                if (pagingController.page() !== 0) {
                    pagingController.page(0);
                } else {
                    self.load();
                }
            }
        };

        this.loadStatic = function() {
            var results = [];
            $.each(settings.initialSet || [],
                 function (index, group) {
                     var groupParams = {
                         GroupId: group.groupId,
                         GroupKey: group.groupKey,
                         Name: group.groupName,
                         Description: group.description,
                         ImageUrl: group.imageUrl,
                         IconFile: group.iconFile,
                         MemberCount: group.memberCount,
                         Url: group.url,
                         CreatedOnDate: group.createdOnDate,
                         IsMember: group.isMember,
                         MembershipPending: group.membershipPending,
                         IsPublic: group.isPublic,
                         Rating: group.rating,
                         IsPendingToBeApproved: group.isPendingToBeApproved,
                         UserCanViewGroup: group.userCanViewGroup,
                         FolderId: group.folderId
                     };
                     results.push(new dnn.groupDirectory.GroupInfo($, ko, settings, social, groupParams));
                 });

            self.totalResults(settings.totalRecords || 0);

            self.results(results);

            self.resultsMobile(results);

            var tagInput = $('.sort-tags-input', settings.moduleScope);
            if ((settings.initialTags || '').length > 0 && tagInput.length > 0) {
                self.tags(settings.initialTags.split(','));
                tagInput.dnnImportTags(settings.initialTags);
            }
            
        };
        
        // Load new data on page change.
        var pager = componentFactory.resolve('PagingControl');
        if (pager != null) {
            pager.page.subscribe(
                function () {
                    self.load();
                });
        }    
    };
})(window.dnn);