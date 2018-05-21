// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.leaderboard === 'undefined') dnn.leaderboard = {};

(function(dnn) {
    'use strict';
    
    dnn.leaderboard.PagedBoard = function PagedBoard  ($, ko, settings, social, controlSettings, homeControl) {
        var that = this;

        this.loading = ko.observable(false);

        this.header = ko.observable();
        
        this.footer = ko.observable();

        this.total = ko.observable(-1);

        this.moduleScope = $(settings.moduleScope);

        this.localizer = social.getLocalizationController();

        this.searchText = '';

        this.userId = settings.userId;

        this.interval = settings.interval;

        this.scrollTrigger = true;

        this.records = {};

        this.height = 0;

        this.upScrollToY = function() {
            return that.height * Math.ceil(settings.pageSize * 4 / 5);
        };

        this.rowHeight = function() {
            if (that.height == 0)
                that.height = $('.leader-contents tbody tr td:first', settings.moduleScope).outerHeight();

            if (!that.height && typeof settings.template === 'string') {
                switch (settings.template.toLowerCase()) {
                    case 'default':
                        that.height = 58; 
                        break;
                    case 'sidebar':
                        that.height = 37;
                        break;
                    default:
                        break;
                }
            }

            return that.height;
        };

        this.scrollIncrement = function () {
            return that.rowHeight() * 3;
        };
        
        this.setHeight = function(length) {
            if ($('.dnnLeaderboard-scrollDiv', that.moduleScope).length > 0) {
                var rowHeight = that.rowHeight();

                var height = rowHeight * settings.pageSize + 36;

                if (that.totalPages() == 1) {
                    height = rowHeight * length + 36;
                }

                $('.leaderboard div.tableContainer', that.moduleScope).height(height);
            }
        };

        this.setScrollbar = function(length) {
            if ($('.dnnLeaderboard-scrollDiv', that.moduleScope).length > 0) {
                var rowHeight = that.rowHeight();
                var total = that.total();
                var pageSize = settings.pageSize;

                var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
                if (scrollApi) {
                    scrollApi.destroy();
                }

                if (total > pageSize) {
                    var viewportHeight = rowHeight * length;

                    var control = $('.dnnLeaderboard-scrollDiv', that.moduleScope);

                    var jspsettings = {
                        animateScroll: true,
                        contentWidth: 1,
                        keyboardSpeed: that.scrollIncrement(),
                        mouseWheelSpeed: that.scrollIncrement(),
                        speed: that.scrollIncrement()
                    };

                    control.height(viewportHeight).jScrollPane(jspsettings);
                    control.bind('jsp-scroll-y',
                        function (e, y, isAtTop, isAtBottom) {
                            if (that.scrollTrigger && !that.loading()) {                                
                                var pages = that.getAvailablePages();
                                if (isAtBottom) {
                                    if (pages[pages.length - 1] < that.totalPages()) {                                       
                                           that.load('down', pages[pages.length - 1] + 1);
                                    }
                                } else if (isAtTop) {                                    
                                    if (pages[0] > 0) {                                       
                                           that.load('up', pages[0] - 1);
                                    }
                                }
                            }
                        });
                    
                    var api = control.data('jsp');
                    var throttleTimeout;
                    var resizeFunc = function() {
                        if (!throttleTimeout) {
                            throttleTimeout = setTimeout(function() {
                                api.reinitialise();
                                throttleTimeout = null;
                            }, 50);
                        }
                    };
                    $(window).unbind('resize', resizeFunc).bind('resize', resizeFunc);
                } else {
                    $('.dnnLeaderboard-scrollDiv', that.moduleScope).css('height', 'auto');
                }
            }
        };

        this.firstPageReached = function() {
            return that.records.hasOwnProperty(0);
        };

        this.lastPageReached = function() {
            if (that.totalPages() <= 0) {
                return false;
            }

            return that.records.hasOwnProperty(that.totalPages() - 1);
        };

        this.getColumns = function() {
            try {
                var matches = that.header().match(/<th/gi);
                if (matches != null) {
                    return matches.length;
                }
            } catch(e) {
            }
            return 4;
        };

        this.totalPages = ko.computed(
            function() {
                return Math.max(Math.ceil(that.total() / settings.pageSize), 1);
            });

        this.insertWaypoints =
            function() {
                var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
                if (!scrollApi) return;
                var columns = that.getColumns();

                if (!that.firstPageReached()) {
                    var top = '<tr class="dnnLeaderboard-scrollWayPoint" style="height: {2}px;"><td colspan="{0}" align="center">{1}</td></tr>'
                        .format(columns, that.localizer.getString('DemandScrollUp'), that.rowHeight());

                    $('.leader-contents tbody', that.moduleScope).prepend(top);
                }

                if (!that.lastPageReached()) {
                    var bottom = '<tr class="dnnLeaderboard-scrollWayPoint" style="height: {2}px;"><td colspan="{0}" align="center">{1}</td></tr>'
                        .format(columns, that.localizer.getString('DemandScrollDown'), that.rowHeight());

                    $('.leader-contents tbody', that.moduleScope).append(bottom);
                }
            };

        this.loadLeaders = function (completionHandler) {
            var success = function (m) {
                that.header(m.Header || new String());
                that.footer(m.Footer || new String());
                that.total(m.Records || 0);

                that.pageIndex = m.PageIndex;
                that.initialOffset = m.PageOffset;

                that.records[m.PageIndex] = [];
                that.refresh(m.PageLeaders);
                that.loading(false);

                if (typeof completionHandler === 'function') {
                    dnn.social.EventQueue.push(completionHandler);
                }
            };

            var failure = function (xhr, status) {
                console.log('Unable to load leaderboard envelope:' + (status || 'Unknown error'));
            };

            var params = {
                mode: controlSettings.mode(),
                roleId: settings.groupId,
                searchText: that.searchText || '',
                userId: that.userId,
                interval: that.interval,
                rankMode: homeControl.rankMode,
                pageSize: settings.pageSize
            };

            that.loading(true);

            var service = social.getService('Leaderboard');

            service.get('GetLeaders', params, success, failure);
        };

        this.load = function(direction, pageIndex) {
            if (pageIndex < 0) {
                return false;
            }

            var success = function(m) {
                that.records[m.PageIndex] = [];
                switch (direction) {
                    case 'up':
                        that.prepend(m.PageLeaders);
                        break;
                    case 'down':
                        that.append(m.PageLeaders);
                        break;
                }
                $('.leaderboard-badge-tooltip', settings.moduleScope).qaTooltip();
                that.loading(false);
            };

            var failure = function(xhr, status) {
                console.log('Unable to load leaderboard page: ' + (status || 'Unknown error'));
            };

            that.loading(true);

            var params = {
                mode: controlSettings.mode(),
                searchText: that.searchText || '',
                roleId: settings.groupId,
                pageIndex: pageIndex,
                pageSize: settings.pageSize,
                interval: that.interval,
                userId: that.userId
            };

            var service = social.getService('Leaderboard');

            service.get('LoadPage', params, success, failure);

            return true;
        };
        
        this.append = function(rows) {
            var control = $('.leader-contents tbody', that.moduleScope);
            if (rows.length) {
                $($('tr.dnnLeaderboard-scrollWayPoint'), control).remove();
                control.append(rows.join(''));
                that.insertWaypoints();

                var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
                if (scrollApi) {
                    that.scrollTrigger = false;
                    scrollApi.reinitialise();
                    that.scrollTrigger = true;
                }
            }
        };

        this.prepend = function(rows) {
            var control = $('.leader-contents tbody', that.moduleScope);
            if (rows.length) {
                $($('tr.dnnLeaderboard-scrollWayPoint'), control).remove();
                control.prepend(rows.join(''));
                that.insertWaypoints();

                var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
                if (scrollApi) {
                    that.scrollTrigger = false;
                    scrollApi.reinitialise();
                    if (that.initialOffset) {
                        var highlightedRow = $('tr.dnnLeaderHighlighted', that.moduleScope);
                        if (highlightedRow.length)
                            scrollApi.scrollToElement(highlightedRow);
                        that.initialOffset = 0;
                    }
                    else {
                        scrollApi.scrollToY(that.upScrollToY());
                    }
                    that.scrollTrigger = true;
                }
            }
        };

        this.refresh = function(rows) {
            var control = $('.leader-contents tbody', that.moduleScope);
            control.html(rows.join(''));

            if (that.pageIndex != 0 && rows.length < settings.pageSize) {
                that.setHeight(settings.pageSize);
                that.setScrollbar(settings.pageSize);                
                that.load('up', that.pageIndex - 1);
                return;
            }
            that.setHeight(rows.length);
            that.setScrollbar(rows.length);
            that.insertWaypoints();

            var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
            if (scrollApi) {
                that.scrollTrigger = false;
                scrollApi.reinitialise();

                if (that.initialOffset) {
                    var highlightedRow = $('tr.dnnLeaderHighlighted', that.moduleScope);
                    if(highlightedRow.length)
                        scrollApi.scrollToElement(highlightedRow);
                    that.initialOffset = 0;
                } else {
                    if (that.pageIndex == 0) 
                        scrollApi.scrollToY(0);
                    else 
                        scrollApi.scrollToY(that.upScrollToY());
                }
                that.scrollTrigger = true;
            }

        };

        this.scrollToMe = function() {
            var scrollApi = $('.dnnLeaderboard-scrollDiv', that.moduleScope).data('jsp');
            if (scrollApi) {
                that.scrollTrigger = false;
                var highlightedRow = $('tr.dnnLeaderHighlighted', that.moduleScope);
                if (highlightedRow.length) {
                    scrollApi.scrollToElement(highlightedRow);
                    that.scrollTrigger = true;
                } else {
                    homeControl.rankMode = 'RelativeRanking';
                    homeControl.refresh();
                }
            }
        };

        this.canScrollToMe = ko.computed(function() {
            return that.total() > settings.pageSize;
        });

        this.getAvailablePages = function() {
            var pages = [];
            $.each(Object.keys(that.records),
                function(index, key) {
                    pages.push(parseInt(key, 10));
                });

            return pages.sort(function(a, b){
                return a - b;
            });
        };

        this.resetCache = function() {
            that.records = {};
        };

        this.loading.subscribe(
            function () {
                var control = $('.leaderboardSearchInput', settings.moduleScope);
                if (that.loading()) {
                    control.addClass('loading');
                } else {
                    control.removeClass('loading');
                }
            });
    };
})(window.dnn);