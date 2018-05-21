// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function(dnn) {
    'use strict';
    
    dnn.activities.PrivilegeView = function PrivilegeView($, ko, settings) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Privilege');

        this.desktopModules = ko.observableArray([]);

        this.desktopModuleId = ko.observable(-1);

        this.privileges = ko.observableArray([]);

        this.privilege = ko.observable();

        this.getPrivileges = function() {
            var success = function(m) {
                var privileges = [];

                $.each(m,
                    function(index, p) {
                        privileges.push(dnn.social.komodel(p));
                    });

                that.privileges(privileges);
            };

            var failure = function(xhr, status) {
                console.log('Failed to retrieve list of Privileges: ' + (status || 'Unknown error'));
            };

            var params = {
                desktopModuleId: that.desktopModuleId()
            };

            that.service.get('GetPrivileges', params, success, failure);
        };

        this.select = function(p) {
            that.privilege(p);
        };

        this.binded = function() {
            this.getPrivileges();
        };
    };
})(window.dnn);