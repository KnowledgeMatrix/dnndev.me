// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.share === 'undefined') dnn.share = {};
if (typeof dnn.share.controls === 'undefined') dnn.share.controls = {};

(function(dnn) {
    'use strict';
    dnn.share.controls.Pinterest = function Pinterest($, ko, settings, serviceSettings, social, root) {

        this.settings = serviceSettings;

        this.share = function () {
            var completion = function (transformed) {
                var meta_content_image = "";
                var meta_image = "";

	            var host = location.protocol + "//" + location.host + (location.port != '' ? (':' + location.port) : '');
                if ($('#detailview-content-normal img').length)
                    meta_image = $('#detailview-content-normal img').attr('src');
                else meta_image = $('meta[name="og:image"]').attr('content');
				if (meta_image[0] == '/') {
					meta_image = host + meta_image;
				}

                var target = 'http://pinterest.com/pin/create/button/?url={0}'.format(encodeURI(transformed)) + "&description=" + document.title + "&media=" + escape(meta_image);
                window.open(target, '', 'menubar=no,toolbar=no,height=400,width=600');
                
                var service = social.getService('Share');

                var params = {
                    contentItemId: settings.contentItemId,
                    groupId: settings.groupId === null ? -1 : settings.groupId,
                    context: undefined,
                    network: 'Pinterest',
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

            root.transformUrl(completion, 'pinterest');
        };
    };
})(window.dnn);