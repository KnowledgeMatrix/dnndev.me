// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};
 if (typeof dnn.share.controls === 'undefined') dnn.share.controls = {};

(function(dnn) {
    'use strict';
    dnn.share.controls.LinkedIn = function LinkedIn($, ko, settings, serviceSettings, social, root) {
        this.settings = serviceSettings;

        this.share = function () {
            var completion = function (transformed) {
                var url = 'http://www.linkedin.com/shareArticle?mini=true&url={0}&title={1}&summary={2}'
                    .format(
                        encodeURIComponent(transformed),
                        encodeURIComponent(settings.caption),
                        encodeURIComponent(settings.description));

                window.open(url,
                    'linkedinwindow',
                    'height=400,width=1024,directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no');

                var service = social.getService('Share');

                var params = {
                    contentItemId: settings.contentItemId,
                    groupId: settings.groupId === null ? -1 : settings.groupId,
                    context: undefined,
                    network: 'LinkedIn',
                    url: transformed
                };

                var success = function () {
                    // Update MyStatus points
                    if (typeof dnn.social.refreshUser === 'function') {
                        dnn.social.refreshUser();
                    }
                };

                service.post('ShareCompletion', params, success, undefined);
            };

            root.transformUrl(completion);
        };
    };
})(window.dnn);