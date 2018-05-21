// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function(dnn) {
    'use strict';

    dnn.wiki.Contents = function Contents(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);

        this.structure = settings.tree;

        this.abbreviated = ko.observable(false);

        this.generateTree = function () {
            if (that.structure == null) {
                return null;
            }

            var maximum = -1;

            if (that.abbreviated()) {
                maximum = 4;
            }

            return that.generateSubtree(that.structure.ChildArray, maximum);
        };
        
        this.generateSubtree = function (list, max) {
            var markup = '<ol>';

            $.each(list,
                function (index, item) {
                    if (max >= 0) {
                        if (index + 1 > max) {
                            return true;
                        }
                    }

                    markup += '<li><a class="wiki-toc-item" path="{1}">{0}</a>'.format(item.Heading, item.Xpath);
                    if (item.ChildArray.length > 0) {
                        markup += that.generateSubtree(item.ChildArray);
                    }
                });

            markup += '</ol>';
            return markup;
        };

        this.tree = ko.computed(this.generateTree);

        this.reload = function () {
            var failure = function() {};

            var success = function(m) {
                that.structure(m);
            };

            var loading = function (b) {
                if (b) {
                    $(settings.moduleScope).addClass('loading');
                } else {
                    $(settings.moduleScope).removeClass('loading');
                }
            };

            var params = {
                contentItemId: settings.contentItemId
            };
            var service = social.getService('Content');
            service.get('GetContentsTable', params, success, failure, loading);
        };

        this.expand = function () {
            that.abbreviated(false);
        };

        this.collapse = function () {
            that.abbreviated(true);
        };

        this.xpathSelector = function (path) {
            var re = /(h\d+)\[(\d+)\]/;
            var m = re.exec(path);
            if (m) {
                var htmlTag = m[1];
                var position = m[2];
                var tags = $(htmlTag, $('#detailview-content-normal'));
                if (tags.length && tags.length >= position) {
                    return tags[position - 1];
                }
            }
            return null;
        };

        this.bindControls = function () {
            $('.wiki-toc-item').each(
                function () {
                    var element = that.xpathSelector($(this).attr('path'));
                    if (element) {
                        element.id = dnn.social.guid();
                        $(this).click(
                            function () {
                                location.href = '#' + element.id;
                                return false;
                            });
                    }
                });
        };
        
        dnn.social.ipc.register(settings, function (source, msg) {
            switch (msg.event) {
                case 'ViewSwitched':
                    if (msg.isMobileView) {
                        $(settings.moduleScope).hide();
                    } else {
                        $(settings.moduleScope).show();
                        that.bindControls();
                    }
                    break;
            }
        });

        this.binded = function() {
            this.bindControls();
        };
    };
})(window.dnn);
