// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social.RemoveUser === 'undefined') dnn.social.RemoveUser = {};

(function (dnn) {
    'use strict';

    dnn.social.RemoveUser = function ($, ko, settings) {
        var self = this;
        $.extend(this, settings);
        self.ko = ko;
        self.settings = settings;
        self.social = new dnn.social.Module(settings);
        self.service = self.social.getService('Social');
        self.localizer = self.social.getLocalizationController();
        self.userId = settings.userId;
        self.displayName = settings.displayName;
        self.removedUser = ko.observable(false);
        self.reason = ko.observable();
        self.removeAllContent = ko.observable();
        
        this.submit = function () {
            if (!self.validate($('#removeUserFields'))) {
                return;
            }

            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: self.localizer.getString('RemoveUserErrorTitle'),
                    text: self.localizer.getString('RemoveUserErrorBody').format(status || self.localizer.getString('UnknownError'))
                });
            };

            var success = function () {
                self.removedUser(true);
                $('.remove-user-dialog').dialog('close');
                var msg = (typeof self.removeAllContent() === 'undefined' || !self.removeAllContent()) ? self.localizer.getString('RemoveUserSuccessContentNotRemovedBody') : self.localizer.getString('RemoveUserSuccessContentRemovedBody'); 
                $.dnnAlert({
                    title: self.localizer.getString('RemoveUserSuccessTitle'),
                    text: String.format(msg, self.displayName)
                });
            };

            var params = {
                userId: self.userId,
                reason: self.reason,
                removeAllContent: self.removeAllContent
            };

            self.service.post('RemoveUser', params, success, failure);
        };

        this.cancel = function () {
            $('.remove-user-dialog').dialog('close');
        };
    };
})(window.dnn);