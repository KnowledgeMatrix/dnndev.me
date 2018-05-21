// DotNetNuke® - http://www.dotnetnuke.com
//
// Copyright (c) 2002-2013 DotNetNuke Corporation
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $, ko) {
    'use strict';

    // common list viewmodel
    dnn.social.ListView = function (settings) {
        this.settings = settings;
        this.moduleScope = settings.moduleScope;
        this.social = new dnn.social.Module(settings);
        this.rootUrl = this.social.getService('Social').getRoot();
        this.disableHistoryNavigation = true;
        this.componentFactory = this.social.getComponentFactory();

        // register common ipc
        dnn.social.ipc.register(settings, $.proxy(function (source, message) {
            switch (message.event.toString()) {
                case 'addDialog':
                    var title = message.message;
                    var method = this.isMobileView() ? 'addDialogMobileView' : 'addDialog';
                    this[method].call(this, title);
                    break;
            }
        }, this));
    };

    dnn.social.ListView.prototype.init = function () {
        var self = this;
        
        // set ko properties
        var listController = this.listController();
        var localizer = this.localizer();
        if (!listController || !localizer) return;
        
        if (typeof listController.stateFilter === 'function')
            this.stateFilter = ko.observable(this.settings.stateFilter || this.settings.category);
        
        if (typeof listController.sort === 'function')
            this.sort = ko.observable(this.settings.sort);

        if(typeof this.category === 'function')
            this.selectedMobileViewCategory = ko.observable(self.category());
        
        // set ko computed properties
        this.totalResults = ko.computed(
             function () {
                 var localString = listController.totalResults() === 1 ? 'SingleResultCount' : 'ResultCount';
                 return localizer.getString(localString).format(listController.totalResults());
             });
        
        this.pagingControl = ko.computed(
             function () {
                 var controller = self.pager();
                 return controller ? controller.markup() : '';
             });

        // set ko subscribes
        if (typeof this.sort === 'function') {
            this.sort.subscribe(function(s) {
                if (typeof s !== 'undefined') {
                    listController.sort(s);
                    if (!self.disableHistoryNavigation) {
                        var history = self.social.getHistory();
                        if (history) history.navigate(self.getState());
                    }
                }
                return listController.sort();
            });
        }

        if (typeof this.stateFilter === 'function') {
            this.stateFilter.subscribe(
                function() {
                    if (!self.disableHistoryNavigation) {
                        var history = self.social.getHistory();
                        if (history) history.navigate(self.getState());
                    }
                });
        }

        if (typeof this.selectedMobileViewCategory === 'function') {
            this.selectedMobileViewCategory.subscribe(function(s) {
                self.category(s);
            });
        }

        // bind history js
        var historyController = this.social.getHistory();
        if (historyController) {
            historyController.bind(
                function (state) {
                    self.disableHistoryNavigation = true;
                    listController.frozen(true);
                    
                    if (typeof listController.stateFilter === 'function')
                        listController.stateFilter(state.stateFilter || self.settings.stateFilter);
                    
                    if (typeof listController.category === 'function')
                        listController.category(state.category || self.settings.category);
                    
                    if (typeof listController.tags === 'function')
                        listController.tags((state.tags || self.settings.initialTags).split(','));
                    
                    if (typeof listController.sort === 'function')
                        listController.sort(state.sort || self.settings.sort);
                    
                    var tagInput = $('.sort-tags-input', self.settings.moduleScope);
                    tagInput.dnnImportTags(state.tags || self.settings.initialTags);

                    var pager = self.pager();
                    if (pager) {
                        if (state.hasOwnProperty('page')) {
                            pager.page(parseInt(state.page, 10));
                        } else {
                            pager.page(parseInt(self.settings.pageIndex, 10));
                        }
                    }

                    if (typeof listController.stateFilter === 'function')
                        self.stateFilter(listController.stateFilter());
                    
                    if (typeof listController.sort === 'function')
                        self.sort(listController.sort());
                    
                    listController.frozen(false);
                    self.disableHistoryNavigation = false;
                    listController.load();
                });
        }

        // responsive screen detect
        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);
    };

    dnn.social.ListView.prototype.register = function(obj, key) {
        this.componentFactory.register(obj, key);
    };

    dnn.social.ListView.prototype.localizer = function() {
        return this.social.getLocalizationController();
    };

    dnn.social.ListView.prototype.pager = function() {
        return this.componentFactory.resolve('PagingControl');
    };
    
    dnn.social.ListView.prototype.listController = function () {
        return this.componentFactory.resolve('ListController');
    };
    
    dnn.social.ListView.prototype.getString = function (key) {
        var localizer = this.localizer();
        return localizer ? localizer.getString(key) : key;
    };

    dnn.social.ListView.prototype.prev = function () {
        var controller = this.pager();
        if (controller) controller.previous();
    };
    
    dnn.social.ListView.prototype.next = function () {
        var controller = this.pager();
        if (controller) controller.next();
    };
    
    dnn.social.ListView.prototype.refresh = function () {
        var controller = this.listController();
        if (controller) controller.load();
    };
    
    dnn.social.ListView.prototype.getState = function () {
        var state = {
            page: 0  
        };

        if (typeof this.stateFilter === 'function')
            state.stateFilter = this.stateFilter();

        if (typeof this.category === 'function')
            state.category = this.category();
        
        if (typeof this.sort === 'function')
            state.sort = this.sort();

      
        state.tags = '';
        if (this.tags().length > 0) {
            var tags = this.tags();
            var filterTags = [];
            $.each(tags, function(i, a) {
                if (a !== ' ') {
                    var arr = a.split(',');
                    arr = $.map(arr, function(b) {
                        return b.trim();
                    });
                    filterTags.push(arr.join(','));
                }
            });
            state.tags = filterTags.join(',');
        }

        if (!state.tags) state.tags = ' ';
        return state;
    };

    dnn.social.ListView.prototype.tags = function (t) {
        var controller = this.listController();
        if (!controller) return null;
        if (typeof t !== 'undefined') {
            if (!this.disableHistoryNavigation) {
                var history = this.social.getHistory();
                if (history) history.navigate(this.getState());
            }
        }
        return controller.tags();
    };
    
    dnn.social.ListView.prototype.category = function (s) {
        var controller = this.listController();
        if (!controller) return null;
        if (typeof this.validateCategory === 'function' && this.validateCategory(s)) {
            if (typeof s !== 'undefined') {
                controller.category(s);
                if (!this.disableHistoryNavigation) {
                    var history = this.social.getHistory();
                    if (history) history.navigate(this.getState());
                }
            }
        }
        return controller.category();
    };
    
    dnn.social.ListView.prototype.selectedClass = function (f) {
        var controller = this.listController();
        if (!controller || controller.category() !== f) return '';
        return 'selected';
    };

    dnn.social.ListView.prototype.nextClass = function () {
        var controller = this.pager();
        if (!controller || controller.page() + 1 < controller.totalPages()) return '';
        return 'disabled';
    };
    
    dnn.social.ListView.prototype.prevClass = function () {
        var controller = this.pager();
        if (!controller || controller.page() > 0) return '';
        return 'disabled';
    };
    
    dnn.social.ListView.prototype.addTag = function (t) {
        var controller = this.listController();
        if (controller) controller.tags.push(t);
        this.sanitizeTags();
    };
    
    dnn.social.ListView.prototype.removeTag = function (t) {
        var controller = this.listController();
        if (controller) {
            var indexOf = Array.indexOf(controller.tags(), t);
            if (indexOf >= 0) controller.tags.splice(indexOf, 1);
        }
        this.sanitizeTags();
    };
    
    dnn.social.ListView.prototype.sanitizeTags = function () {
        var controller = this.listController();
        if (!controller) return;

        var splices = [];
        for (var i = 0; i < (controller.tags() || []).length; ++i) {
            var tag = controller.tags()[i];
            if (!tag || tag.length == 0) splices.push(i);
        }

        $.each(splices.reverse(),
            function (unused, index) {
                controller.tags.splice(index, 1);
            });

        var history = this.social.getHistory();
        if (history) history.navigate(this.getState());
    };
    
    dnn.social.ListView.prototype.searchTag = function (t) {
        var controller = this.listController();
        if (!controller) return;
        controller.tags([t.name()]);
        if (!this.disableHistoryNavigation) {
            var history = this.social.getHistory();
            if (history) history.navigate(this.getState());
        }
    };
    
    dnn.social.ListView.prototype.bindTagsInput = function () {
        var localize = this.localizer();
        if (!localize) return;

        var defaultText = localize.getString('AddFilterTag');
        $('.sort-tags-input', this.settings.moduleScope).dnnTagsInput({
            onAddTag: $.proxy(this.addTag, this),
            onRemoveTag: $.proxy(this.removeTag, this),
            width: '190px',
            minInputWidth: '120px',
            defaultText: defaultText
        });
    };
    
    dnn.social.ListView.prototype.addDialog = function (query) {
        var dialog;

        if (dnn.social.authorizationRequired(this.settings)) return;
        var localizer = this.localizer();
        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: localizer.getString('DialogTitle'),
            minWidth: 650,
            closeOnEscape: false,
            resizable: false,
            open: function () {
	            if ($.ui.dialog.prototype.options.open) {
		            $.ui.dialog.prototype.options.open.apply(this, arguments);
	            }

	            $('.editor-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            	var $input = $('#' + $(this).attr('id').replace('_tag', ''));
					if ($input.data('dnnTagInput')) {
						$(this).dnnResetAutosize($input.data('dnnTagInput'));
					}
	            });

                setTimeout(function(){
                    window.dnn.social.unbindEventsThatConflictWithJQueryDialog(dialog);
                },0);
            },
            close: $.ui.dialog.prototype.options.close
        };
        
        var editModel = window.ko.contextFor($(this.settings.editId)[0]).$root;
        if(typeof query === 'string') editModel.setSuggestedTitle(query);
        editModel.bindControls();
        dialog = $('.editor-dialog').dialog(options);
    };
    
    dnn.social.ListView.prototype.bindControls = function () {
        this.bindTagsInput();
        $(window.document).bind('focused',
            $.proxy(function () {
                if ($('.search-suggestion').is(':visible')) {
                    $('.search-suggestion').slideUp('fast', function () {
                        $('.search-suggestion').removeClass('suggestion-modalContainer');
                        $('.dnnFilterSet').removeClass('suggestion-modalContainer');
                        $('.suggestion-modalShadow').fadeOut('fast');
                    });
                }
                if (typeof this.windowsFocused === 'function') this.windowsFocused();
            }, this));

        var listController = this.componentFactory.resolve('ListControlller');
        if (listController) listController.loadStart();
    };
    
    dnn.social.ListView.prototype.loadMore = function () {
        var controller = this.pager();
        if (controller) {
            var page = controller.page();
            controller.page(page + 1);
            this.listController().load(true);
        }
    };
    
    dnn.social.ListView.prototype.addDialogMobileView = function (query) {
        if (dnn.social.authorizationRequired(this.settings)) return;
        var localizer = this.localizer();
        var options = dnn.social.MobileView.dialogOptions({
            title: localizer.getString('DialogTitle')
        });

        $('.editor-dialog').dialog(options);

        var editModel = window.ko.contextFor($(this.settings.editId)[0]).$root;
        if (editModel != null) {
            if (typeof query === 'string') editModel.setSuggestedTitle(query);
            editModel.bindControls();
        }
    };
    
    dnn.social.ListView.prototype.switchingView = function () {
        $(".ui-dialog-content").dialog("close");
    };
    
    dnn.social.ListView.prototype.switchedView = function () {
        if (this.isMobileView()) {
            var controller = this.listController();
            controller.frozen(true);
            this.selectedMobileViewCategory(this.category());
            controller.frozen(false);
        } else {
            this.bindTagsInput();
        }
        dnn.social.loaded(this.settings.moduleScope.id);
    };
    
    dnn.social.ListView.prototype.binded = function () {
        this.bindControls();
        this.listController().loadStatic();
        dnn.social.loaded(this.settings.moduleScope.id);
        var controller = this.pager();
        if (controller) controller.page(this.settings.pageIndex);
        var history = this.social.getHistory();
        if (history) this.disableHistoryNavigation = false;
    };
    
})(window.dnn, window.jQuery, window.ko);
