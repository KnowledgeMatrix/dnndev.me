// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};
    
(function(dnn) {
    'use strict';

    dnn.social.PagingControl = function PagingControl ($, ko, settings, social, controllerName) {
        var that = this;

        $.extend(this, dnn.social.PagingControl.DefaultSettings, settings);
        this.setStart = ko.observable(0);
        this.page = ko.observable(settings.pageIndex || 0);

        this.totalPages = function () {
            var controller = social.getComponentFactory().resolve(controllerName);
            if (controller != null) {
                var total;
                
                switch (typeof controller.totalResults) {
                    case 'function':
                        total = controller.totalResults();
                        break;
                    case 'undefined':
                    default:
                        total = controller.totalResults;
                        break;
                }

                if (total > 0) {
                    return Math.max(1, Math.ceil(total / that.pageSize));
                }
            }

            return 0;
        };

        this.first = function () {
            that.navigateTo(0);

            that.setStart(that.page());

            return true;
        };

        this.previous = function () {
            if (that.page() > 0) {
                that.navigateTo(that.page() - 1);
            }

            that.setStart(that.page());

            return true;
        };

        this.next = function () {
            if (that.page() + 1 < that.totalPages()) {
                that.navigateTo(that.page() + 1);
            }

            that.setStart(that.page());

            return true;
        };

        this.last = function () {
            if (that.totalPages() > 0) {
                that.navigateTo(that.totalPages() - 1);
                that.setStart(that.page());
            }

            return true;
        };

        this.setPage = function (page) {
            that.navigateTo(page);

            return true;
        };

        this.shiftSetRight = function () {
            if (that.totalPages() - that.setStart() > that.pageSetSize) {
                that.setStart(that.setStart() + that.pageSetSize);
            }
        };

        this.shiftSetLeft = function () {
            if (that.setStart() > 0) {
                var start = that.setStart() - that.pageSetSize + 1;
                if (start < 0) {
                    start = 0;
                }

                that.setStart(start);
            }
        };

        this.leftVisible = function () {
            var set = that.getVisibleSet();
            return set[0] > 0;
        };
        
        this.rightVisible = function () {
            var set = that.getVisibleSet();    
            return set[set.length - 1] + 1 < that.totalPages();
        };

        this.getVisibleSet = function () {
            var set = [];
            var currentPage = that.setStart() + 1;
            var totalPages = that.totalPages();
            var visibleSetNumber = totalPages > 4 ? 3: totalPages - 2;
            var i;
            if(currentPage < 4){                
                for(i = 0; i< visibleSetNumber; i++){
                    set.push(i + 2);
                }
            }
            else if (currentPage > totalPages - 3) {
                for (i = visibleSetNumber; i > 0; i--) {
                    set.push(totalPages - i);
                }
            }
            else {
                set.push(currentPage - 1);
                set.push(currentPage);
                set.push(currentPage + 1);
            }

            return set;
        };

        this.getString = function (key) {
            var controller = social.getLocalizationController();
            if (controller) {
                return controller.getString(key);
            }
            return key;
        };

      
        this.registerRootObject = function (uniqueId) {
            var key = 'pagingController{0}'.format(uniqueId);
            if (typeof window[key] === 'undefined') {
                window[key] = that;
            }
            return 'window[\'{0}\']'.format(key);
        };

        var root = that.registerRootObject('{0}_{1}_{2}'.format(settings.moduleId, controllerName, Math.random()));

        this.getPageUrl = function (page) {
            var data = social.getHistory().getState().data || {};
            data.page = page;
            return social.getHistory().getUrl(data);           
        };

        this.markup = function () {
            var total = that.totalPages();
            if (total > 1) {
                var currentPage = that.page();

                var html = new String();
                var currentPageIdx = currentPage + 1;
                var pageDesc = that.getString('PageDescription').format(currentPageIdx, total);
                html += '<li class="pager-ul-desc">' + pageDesc + '</li>';

                if (currentPageIdx > 1) {
                    html += '<li><a href="' + that.getPageUrl(0) + '" onclick="' + root + '.first(); return false;">1</a></li>';
                }
                else {
                    html += '<li><span class="disabled">1</span></li>';
                }

                var set = that.getVisibleSet();

                if (set.length > 0) {

                    if (set[0] > 2) {
                        html += '<li><a href="javascript:void(0)" onclick="' + root + '.shiftSetLeft(); return false;">&hellip;</a></li>';
                    }

                    for (var i = 0; i < set.length; i++) {
                        if (currentPageIdx == set[i]) {
                            html += '<li class="current"><span>' + currentPageIdx + '</span></li>';
                        }
                        else {
                            html += '<li><a href="' + that.getPageUrl(set[i] - 1) + '" onclick="' + root + '.setPage(' + (set[i] - 1) + '); return false;">' + set[i] + '</a></li>';
                        }
                    }

                    if (set[set.length - 1] < total - 1) {
                        html += '<li><a href="javascript:void(0)" onclick="' + root + '.shiftSetRight(); return false;">&hellip;</a></li>';
                    }
                }

                if (currentPageIdx < total) {
                    html += '<li class="pager-ul-last"><a href="' + that.getPageUrl(total - 1) + '" onclick="' + root + '.last(); return false;">' + total + '</a></li>';
                }
                else {
                    html += '<li class="pager-ul-last"><span class="disabled">' + total + '</span></li>';
                }

                return html;
            }

            return null;
        };

        this.navigateTo = function (page) {
            if (page + 1 > that.totalPages()) {
                return true;
            }
            
            that.page(page);
            social.getHistory().setNavigationProperty('page', page || 0);
            that.toTop();
            return true;
        };

        this.toTop = function () {
            var scope = $(settings.moduleScope).first();
            if (scope !== null && scope !== undefined) {
                var top = scope.offset().top;
                $(document).scrollTop(top);
            }
        };

        this.page.subscribe(
            function () {
                while (that.page() < that.setStart()) {
                    that.shiftSetLeft();
                }
                
                while (that.page() > that.setStart() + that.pageSetSize) {
                    that.shiftSetRight();
                }
            });
    };

    dnn.social.PagingControl.DefaultSettings = {
        pageSetSize: 5,
        pageSize: 10
    };
})(window.dnn);