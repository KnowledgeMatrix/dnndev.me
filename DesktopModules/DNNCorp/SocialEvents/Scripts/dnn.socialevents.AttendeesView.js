// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn) {
    'use strict';

    dnn.socialevents.AttendeesView = function AttendeeView($, ko, settings, model) {
        var that = this;   
        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.componentFactory = this.social.getComponentFactory();
        this.componentFactory.register(new dnn.socialevents.AttendeesController($, ko, settings, this.social));
        this.componentFactory.register(this.social.getPagingControl('AttendeesController'));
        this.componentFactory.register(this, 'PrimaryView');
        this.model = new dnn.socialevents.SocialEvent($, ko, settings, this.social, model);

        this.localizer = function () {
            return that.social.getLocalizationController();
        };

        this.pager = function () {
            return that.componentFactory.resolve('PagingControl');
        };

        this.searcher = function () {
            return that.componentFactory.resolve('AttendeesController');
        };

        this.getString = function (key) {
            var localizer = that.localizer();
            if (localizer != null) {
                return localizer.getString(key);
            }

            return key;
        };

        this.totalResults = ko.computed(
            function () {
                var localizer = that.localizer();
                if (localizer == null) {
                    return null;
                }

                var search = that.searcher();
                if (search == null) {
                    return null;
                }

                var localString = 'GuestCount';

                if (search.totalResults() == 1) {
                    localString = 'SingleGuestCount';
                }

                return localizer.getString(localString).format(search.totalResults());
            });

        this.pagingControl = ko.computed(
            function () {
                var controller = that.pager();
                if (controller != null) {
                    return controller.markup();
                }
                return null;
            });

        this.prev = function () {
            var controller = that.pager();
            if (controller != null) {
                if (that.prevClass() !== 'disabled') {
                    controller.previous();
                }
            }
        };

        this.next = function () {
            var controller = that.pager();
            if (controller != null) {
                if (that.nextClass() !== 'disabled') {
                    controller.next();
                }
            }
        };

        this.refresh = function () {
            var controller = that.searcher();
            if (controller != null) {
                controller.load();
            }
        };

        this.getState = function () {
            return {
                page: 0,
                category: that.category(),
            };
        };

        this.disableHistoryNavigation = true;

        this.initialState = function () {
            var history = that.social.getHistory();
            if (history) {
                var state = history.getState();
                state = $.extend(that.getState(), state);
                that.category(state.category);
                return state;
            }
            return that.getState();
        };

        this.category = function (s) {     
            var controller = that.searcher();
            if (controller != null) {
                if (typeof (s) !== 'undefined') {
                    controller.category(s);
                    if (!that.disableHistoryNavigation) {
                        var history = that.social.getHistory();
                        if (history != null) {
                            history.navigate(that.getState());
                        }
                    }
                }

                return controller.category();
            }
            return null;
        };

        this.selectedClass = function (filter) {   
            if (that.category() == filter) {
                return 'selected';
            }           
            return new String();
        };

        this.nextClass = function () {
            var controller = that.pager();
            if (controller != null) {
                if (controller.page() + 1 >= controller.totalPages()) {
                    return 'disabled';
                }
            }

            return new String();
        };

        this.prevClass = function () {
            var controller = that.pager();
            if (controller != null) {
                if (controller.page() == 0) {
                    return 'disabled';
                }
            }

            return new String();
        };

        var historyController = that.social.getHistory();
        if (historyController != null) {
            historyController.bind(
                function (state) {
                    var controller = that.searcher();
                    if (controller != null) {
                        controller.frozen(true);
                        controller.category(state.category || controller.category());
                        controller.frozen(false);

                        if (state.hasOwnProperty('page')) {
                            var pager = that.pager();
                            if (pager != null) {
                                pager.page(parseInt(state.page, 10));
                            }
                        }

                        controller.load();
                    }
                });
        }
        
        this.selectedMobileViewCategory = ko.observable(that.category());
        
        this.selectedMobileViewCategory.subscribe(function (s) {
            that.category(s);
        });
        
        this.loadMore = function () {
            var controller = that.pager();
            if (controller != null) {
                var page = controller.page();
                controller.page(page + 1);
                this.searcher().load(true);
            }
        };

        this.switchingView = function() {
            $(".ui-dialog-content").dialog("close");
        };

        this.switchedView = function() {
            if (this.isMobileView()) {
                var controller = that.searcher();
                controller.frozen(true);
                this.selectedMobileViewCategory(this.category());
                controller.frozen(false);
            } 
        };

        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);

        this.binded = function() {
            var state = that.initialState();
            var history = that.social.getHistory();
            if (history) {
                history.triggerStateChange(state);
                that.disableHistoryNavigation = false;
            }
            this.switchedView();
        };
    };
    
})(window.dnn);
