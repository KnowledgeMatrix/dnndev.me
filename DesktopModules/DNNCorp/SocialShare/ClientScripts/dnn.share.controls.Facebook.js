// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};
if (typeof dnn.share.controls === 'undefined') dnn.share.controls = {};

(function(dnn) {
    'use strict';

    dnn.share.controls.Facebook = function Facebook($, ko, settings, serviceSettings, social, root) {
        var that = this;

        this.settings = serviceSettings;

        this.share = function () {
            var completion = function (transformed) {
                if (String.isEmpty(serviceSettings.applicationId())) {
                    that.genericSubmit(transformed);
                }
                else {
                    that.applicationSubmit(transformed);
                }
            };

            root.transformUrl(completion);
        };

        this.applicationSubmit = function(transformed) {
            var request = {
                method: 'feed',
                link: transformed,
                picture: settings.image,
                name: settings.name,
                caption: settings.caption || settings.name,
                description: settings.description
            };

            var callback = function (response) {
                var service = social.getService('Share');
                var context = '';
                if (typeof response !== 'undefined' && response != null) {
                    context = response['post_id'];
                }
                var params = {
                    contentItemId: settings.contentItemId,
                    groupId: settings.groupId === null ? -1 : settings.groupId,
                    context: context,
                    network: 'Facebook',
                    url: transformed
                };
                service.post('ShareCompletion', params, undefined, undefined);
            };
            FB.ui(request, callback);
        };

        this.genericSubmit = function(transformed) {
            var target = 'https://www.facebook.com/share.php?u={0}'.format(encodeURIComponent(transformed));
            window.open(target, '', 'menubar=no,toolbar=no,height=225,width=600');
            var service = social.getService('Share');
            var params = {
                contentItemId: settings.contentItemId,
                groupId: settings.groupId === null ? -1 : settings.groupId,
                context: undefined,
                network: 'Facebook',
                url: transformed
            };

            var success = function () {
                if (typeof dnn.social.refreshUser === 'function') {
                    dnn.social.refreshUser();
                }
            };

            service.post('ShareCompletion', params, success, undefined);
        };

        this.bindControls = function () {
            dnn.share.facebookInitialize(serviceSettings.applicationId());
            setTimeout(
                function() {
                    $(settings.moduleScope).removeClass('loading');
                }, 600);
        };
        dnn.social.EventQueue.push(this.bindControls);
    };
})(window.dnn);