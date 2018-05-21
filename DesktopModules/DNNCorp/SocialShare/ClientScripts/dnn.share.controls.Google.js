// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};
if (typeof dnn.share.controls === 'undefined') dnn.share.controls = {};

(function(dnn) {
    'use strict';

    
    dnn.share.controls.Google = function Google($, ko, settings, serviceSettings, social, root) {

        this.settings = serviceSettings;

        this.share = function () {
            var completion = function (transformed) {
                var target = 'https://plus.google.com/share?url={0}'.format(encodeURI(transformed));
                
                window.open(target, '', 'menubar=no,toolbar=no,height=600,width=600');
              
                var service = social.getService('Share');

                var params = {
                    contentItemId: settings.contentItemId,
                    groupId: settings.groupId === null ? -1 : settings.groupId,
                    context: undefined,
                    network: 'googleplus',
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