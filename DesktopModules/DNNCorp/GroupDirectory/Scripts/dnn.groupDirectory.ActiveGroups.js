// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.groupDirectory === 'undefined') dnn.groupDirectory = {};

(function (dnn) {
    'use strict';

    dnn.groupDirectory.ActiveGroups = function ($, ko, settings) {
        var self = this;

        this.settings = settings;        
        this.social = new dnn.social.Module(settings);
        this.service = this.social.getService('List');
        this.results = ko.observableArray([]);

        this.load = function () {
            var results = [];
            $.each(settings.initialSet,
                function (index, group) {
                    var groupParams = {
                        GroupId: group.groupId,
                        Name: group.groupName,
                        Description: group.description,
                        ImageUrl: group.imageUrl,
                        IconFile: group.iconFile,
                        MemberCount: group.memberCount,
                        Url: group.url,
                        CreatedOnDate: group.createdOnDate,
                        IsMember: group.isMember,
                        MembershipPending: group.membershipPending,
                        Rating: group.rating,
                        IsPendingToBeApproved: group.isPendingToBeApproved,
                        IsPublic: group.isPublic,
                    };
                    results.push(new dnn.groupDirectory.GroupInfo($, ko, self.settings, self.social, groupParams));
                });

            self.results(results);
        };

        this.binded = function() {
            this.load();
            dnn.social.loaded(settings.moduleScope.id);
        };
    };
})(window.dnn);