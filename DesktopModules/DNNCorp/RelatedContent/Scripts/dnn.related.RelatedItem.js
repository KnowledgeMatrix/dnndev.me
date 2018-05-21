// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.related === 'undefined') dnn.related = {};

(function(dnn) {
    'use strict';

    dnn.related.RelatedItem = function RelatedItem($, ko, settings, social, model) {
        var that = this;
        
        $.extend(this, dnn.social.komodel(model));

        this.loading = function (b) {
            var control = $('.related-content-container');
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };
        
        this.toggleSelection = function () {
            var service = social.getService('Related');
            
            that.isRelated(!that.isRelated());

            var params = {
                contentItemId: settings.contentItemId,
                relatedContentItemId: that.item().contentItemId
            };

            var success = undefined;

            var failure = function (xhr, status) {
                var localizer = social.getLocalizationController();

                $.dnnAlert({
                    text: localizer.getString('CannotRelate').format(status || localizer.getString('UnknownError')),
                    title: localizer.getString('Error')
                });
            };

            if (that.isRelated()) {
                service.post('CreateRelationship', params, success, failure, that.loading);
            }
            else {
                service.post('DissolveRelationship', params, success, failure, that.loading);
            }
        };

        this.rowStyle = ko.computed(
            function () {
                var styles = [];
                
                if (that.isRelated()) {
                    styles.push('related-item-selected');
                }

                return styles.join(' ');
            });
    };
})(window.dnn);