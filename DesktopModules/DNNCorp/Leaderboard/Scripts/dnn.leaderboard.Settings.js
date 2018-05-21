// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.leaderboard === 'undefined') dnn.leaderboard = {};

(function(dnn) {
    'use strict';

    dnn.leaderboard.Settings = function Settings ($, ko, settings) {
        var that = this;

        $.extend(this, settings);

        this.roleMap = {};

        this.social = new dnn.social.Module(settings);

        this.localizer = this.social.getLocalizationController();

        this.mode = ko.observable();

        this.roles = ko.observableArray([]);

        this.selectedGroup = ko.observable();

        this.getSystemRoles = function () {
            var success = function (m) {
                var noneModel = {
                    Name: that.localizer.getString('None'),
                    RoleId: -1
                };
                
                that.roleMap[noneModel.RoleId] = noneModel.Name;

                that.roles.push(dnn.social.komodel(noneModel));

                $.each(m.Roles,
                    function (index, role) {
                        if ((role.Name || new String()).length == 0) {
                            return true;
                        }

                        that.roleMap[role.RoleId] = role.Name;

                        that.roles.push(dnn.social.komodel(role));

                        return true;
                    });
            };

            var failure = function (xhr, status) {
                console.log('Unable to retrieve list of system roles: ' + (status || 'Unknown error'));
            };

            var service = that.social.getService('Settings');

            service.getsync('GetSystemRoles', {}, success, failure);
        };

        this.getRoleId = function (role) {
            var id = undefined;

            $.each(that.roleMap,
                function (key, value) {
                    if (value == role) {
                        id = key;

                        return false;
                    }

                    return true;
                });

            return id;
        };

        this.mode.subscribe(
            function () {
                that.hiddenMode.value = that.mode();
            });

        this.mode(settings.mode);

        this.selectedGroup(settings.selectedRole);
        
        this.selectedGroup.subscribe(
                function () {
                    that.hiddenSelectedRoleId.value = that.selectedGroup();
                }
            );

        this.getSystemRoles();
    };
})(window.dnn);