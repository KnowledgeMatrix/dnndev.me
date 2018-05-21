// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function (dnn) {
    'use strict';

    dnn.social.ContentExchangeSearchItem = function ContentExchangeSearchItem($, ko, settings, social, model, context) {
        var that = this;

        $.extend(this, dnn.social.komodel(model));
        this.context = context;

        this.loading = function (b) {
            var control = $('.social-content-exchange');
            if (b) {
                control.addClass('loading');
            }
            else {
                control.removeClass('loading');
            }
        };

        this.toggleSelection = function () {
            that.isSelected(!that.isSelected());

            if (that.context && that.context.toggleSelectionHandler) {
                that.context.toggleSelectionHandler(that.context.itemId, that.isSelected());
            };
        };

        this.rowStyle = ko.computed(
            function () {
                var styles = [];

                if (that.isSelected()) {
                    styles.push('content-exchange-search-item-selected');
                }

                return styles.join(' ');
            });
    };
})(window.dnn);