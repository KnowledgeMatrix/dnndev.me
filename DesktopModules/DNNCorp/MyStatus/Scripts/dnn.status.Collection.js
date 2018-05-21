// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.Collection = function Collection ($, ko, settings, social, collection) {
        var that = this;

        $.extend(this, dnn.social.komodel(collection));

        var componentFactory = social.getComponentFactory();

        var controller = componentFactory.register(this, 'Status{0}'.format(this.collectionKey()));

        this.service = social.getService('Collection');

        this.pager = social.getPagingControl(controller);

        this.blinking = false;

        this.expanded = ko.observable(false);

        this.loading = ko.observable(false);

        this.records = ko.observableArray([]);

        this.frozen = ko.observable(false);

        this.totalResults = ko.computed(
            function () {
                return that.count();
            });

        this.getContainer = function () {
            return $('.status-collection-{0}'.format(that.collectionKey()), settings.moduleScope);
        };

        this.loadingCallback = function (b) {
            var control = that.getContainer();

            if ((that.records() || []).length > 0) {
                control.addClass('data');
            } else {
                control.removeClass('data');
            }
            
            if (b) {
                control.addClass('loading');
            } else {
                control.removeClass('loading');
            }

            that.loading(b);
        };

        this.load = function (completionHandler) {
            if (that.frozen()) {
                return null;
            }

            var failure = undefined;

            var success = function (m) {
                var records = [];

                $.each(m.Collection,
                    function (index, collectionItem) {
                        records.push(new dnn.status.CollectionItem($, ko, settings, social, collectionItem));
                    });

                that.count(m.TotalRecords || records.length);

                that.records(records);

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(completionHandler);
                }
            };

            var params = {
                collectionKey: that.collectionKey(),
                pageIndex: that.pager.page()
            };

            that.service.get('GetCollection', params, success, failure, that.loadingCallback);
        };

        this.expand = function () {
            if (that.expanded()) {
                that.expanded(false);
            } else {
                that.load(
                    function () {
                        that.expanded(true);
                    });
            }
        };

        this.prev = function () {
            if (that.prevClass() !== 'disabled') {
                that.pager.page(that.pager.page() - 1);
            }
        };

        this.next = function () {
            if (that.expanded()) {
                if (that.nextClass() !== 'disabled') {
                    that.pager.page(that.pager.page() + 1);
                }
            } else {
                that.expand();
            }
        };

        this.prevClass = ko.computed(
            function () {
                if (that.pager.page() == 0) {
                    return 'disabled';
                }

                return 'enabled';
            });

        this.nextClass = ko.computed(
            function () {
                if (that.expanded()) {
                    if (that.pager.totalPages() == that.pager.page() + 1) {
                        return 'disabled';
                    }
                }

                return 'enabled';
            });
        
        this.truncateTitle = function(title) {
            if (!title) return '';
            if (title.length <= 25) return title;
            var words = title.split(' ');
            var truncated = '';
            for (var i = 0; i < words.length; i++) {
                if (truncated.length + words[i].length > 25)
                    return truncated + '&hellip;';
                if (i == 0)
                    truncated += words[i];
                else
                    truncated += ' ' + words[i];
            }

            return truncated;
        };
        
        this.itemCreated = function (model) {
            
            var collectionItem = {
                id: model.contentItemId,
                title: that.truncateTitle(model.title),
                targetUrl: model.detailsUrl,
                createdOnDate: model.createdOnDate,
                lastModifiedOnDate: model.lastModifiedOnDate
            };

            that.count(that.count() + 1);
            
            if (!that.expanded()) {
                that.frozen(true);
                that.pager.page(0);
                that.frozen(false);

                that.load(
                    function () {
                        that.expanded(true);
                        
                        that.animateItem(collectionItem.id);
                    });

                return null;
            }

            if (that.pager.page() == 0) {
                that.records.unshift(new dnn.status.CollectionItem($, ko, settings, social, collectionItem));

                while (that.records().length > settings.pageSize) {
                    that.records.pop();
                }

                that.animateItem(collectionItem.id);
            }
            else {
                
                that.frozen(true);
                that.pager.page(0);
                that.frozen(false);
                
                that.load(
                    function () {
                        that.animateItem(collectionItem.id);
                    });
            }
        };

        this.itemUpdated = function () {
        };

        this.itemRemoved = function (model) {
            if (that.count() > 0) {
                that.count(that.count() - 1);
            }
            
            if (that.expanded() == false) {
                return null;
            }

            $.each(that.records(),
                function (index, item) {
                    if (item.id() == model.contentItemId) {
                        that.load();

                        return false;
                    }

                    return true;
                });
        };

        this.animateItem = function (id) {
            var element = $('#collection-item-{0}'.format(id));
            if (element.length == 0) {
                return null;
            }

            var label = $('span', element);

            dnn.social.EventQueue.push(
                function () {
                    label.css({ 'color': '#000000' });

                    label.animate({ 'color': '#ff5f76' }, 1000,
                        function () {
                            var animationMs = 1500;

                            var blinkHandle = undefined;

                            if (that.blinking) {
                                var blinkInterval = 550;

                                blinkHandle = setInterval(
                                    function () {
                                        var visibility =
                                            element.css('visibility') == 'hidden'
                                                ? 'visible'
                                                : 'hidden';

                                        element.css('visibility', visibility);
                                    }, blinkInterval);
                            }

                            setTimeout(
                                function () {
                                    if (typeof blinkHandle !== 'undefined') {
                                        clearInterval(blinkHandle);
                                    }

                                    element.css('visibility', 'visible');
                                }, animationMs);
                        });
                });
        };
        
        that.pager.page.subscribe(
            function () {
                that.load(
                    function () {
                        that.expanded(true);
                    });
            });
    };
})(window.dnn);