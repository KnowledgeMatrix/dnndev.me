// DotNetNuke® - http://www.dotnetnuke.com
//
// Copyright (c) 2002-2013 DotNetNuke Corporation
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $, ko) {
    'use strict';
    
    dnn.social.SearchControl = function SearchControl(settings) {
        var that = this;

        this.moduleScope = settings.moduleScope;
        
        this.social = new dnn.social.Module(settings);
        
        this.results = ko.observableArray([]);

        this.totalRecords = ko.observable(0);
        
        this.timeout = undefined;

        this.query = ko.observable();
        
        this.query.subscribe(function () {
             if (typeof that.timeout !== 'undefined') {
                 clearTimeout(that.timeout);
             }
             that.timeout = setTimeout(that.search, 350);
         });

        this.search = function () {
            if (String.isEmpty(that.query()) || that.query() == settings.placeholder) {
                that.totalRecords(0);
                that.results([]);
                return;
            }
            
            var isMobileView = that.isMobileView();
            if (!isMobileView) {
                if (!$('.search-suggestion-list').is(':visible')) that.toggleSuggestions();
            } else {
                if (!$('.dnnMobileSocialSearchResult').is(':visible')) that.toggleSuggestionsMobileView();
            }

            var failure = function () {
                that.totalRecords(0);
                that.results([]);
            };

            var success = function (m) {
                var contentItems = [];

                $.each(m.results || [],
                    function (index, model) {
                        contentItems.push(new dnn.social.ContentItem(model));
                    });
                
                that.results(contentItems);
                that.totalRecords(m.totalRecords || 0);
            };

            var loading = function(b) {
                var control = $('.search-suggestion', settings.moduleScope);
                if (b) {
                    control.addClass('loading');
                } else {
                    control.removeClass('loading');
                }
            };
            
            var service = that.social.getService('Social');
            
            var params = {
                keywords: that.query(),
                contentTypeId: settings.contentTypeId,
                max: settings.maximumSearchItems || 5,
                groupId: settings.groupId || -1,
                roleGroupId: settings.roleGroupId
            };

            service.get('ContentSearch', params, success, failure, loading);
        };
        
        this.submit = function () {
            if (dnn.social.authorizationRequired(settings)) {
                return false;
            }
            if (that.query() == that.placeholder) that.query('');
            var query = that.query();
            if (that.isMobileView()) {
                that.hideSuggestionsMobileView(function() {
                    dnn.social.ipc.post({}, settings.moduleRoot, { event: 'addDialog', message: query });
                });
            } else {
                that.hideSuggestions(function () {
                    dnn.social.ipc.post({}, settings.moduleRoot, { event: 'addDialog', message: query });
                });
            }
          
            that.query('');
            return false;
        };

        this.showSuggestions = function() {
            var shadow = $('.suggestion-modalShadow');
            if (shadow.length === 0) {
                shadow = $('<div></div>')
                    .height($('html body')[0].scrollHeight)
                    .addClass('suggestion-modalShadow')
                    .appendTo($('body'));
            }

            shadow.fadeIn('fast');

            $('.dnnFilterSet')
                .css('width', $('.dnnFilterSet').width())
                .css('height', $('.dnnFilterSet').height())
                .addClass('suggestion-modalContainer');

            $('.search-suggestion')
                .addClass('suggestion-modalContainer')
                .css('width', $('.dnnFilterSet').width()).slideDown();
        };

        this.hideSuggestions = function (callback) {
            that.query('');
            if (!$('.search-suggestion').is(':visible')) {
                if (typeof callback === 'function') callback();
            }
            else {
                $('.search-suggestion').slideUp('fast',
                    function () {
                        $('.search-suggestion').removeClass('suggestion-modalContainer');
                        $('.dnnFilterSet').removeClass('suggestion-modalContainer');
                        $('.suggestion-modalShadow').fadeOut('fast');
                        if (typeof callback === 'function') callback();
                    });
            }
        };

        this.toSearchResultsPage = function() {
            var query = that.query();
            if (query && settings.searchUrl) {
                var url = settings.searchUrl, r = new RegExp(' ', 'g'), q = query.replace(r, '+');
                settings.searchUrl.indexOf('?') > 0 ? url += '&Search=' + q : url += '?Search=' + q;
                if (settings.moduleName) {
                    url += "&Scope=" + settings.moduleName;
                }

                window.location.href = url;
            }
        };

        this.toggleSuggestions = function () {
            $('.search-suggestion').is(':visible') ? that.hideSuggestions() : that.showSuggestions();
        };

        this.showSuggestionsMobileView = function() {
            $('.suggestion-modalShadow').remove();
            var shadow = $('<div></div>')
                    .height($('html body')[0].scrollHeight)
                    .addClass('suggestion-modalShadow')
                    .appendTo($('body'));

            shadow.fadeIn('fast');

            $('.dnnMobileFilterSet > input[type="text"]').css('width', '80%');
            $('.dnnMobileFilterSet > a.dnnMobileFilterSet-Cancel').show();

            $('.dnnMobileTableFilter')
                .css('width', $('.dnnMobileTableFilter').width())
                .css('height', $('.dnnMobileTableFilter').height())
                .addClass('suggestion-modalContainer');

            $('.dnnMobileSocialSearchResult')
                .addClass('suggestion-modalContainer')
                .css('width', $('.dnnMobileTableFilter').width()).slideDown();
        };

        this.hideSuggestionsMobileView = function (callback) {
            that.query('');
            if (!$('.dnnMobileSocialSearchResult').is(':visible')) {
                if (typeof callback === 'function') callback();
            }
            else {
                $('.dnnMobileSocialSearchResult').slideUp('fast',
                    function () {
                        $('.dnnMobileSocialSearchResult').removeClass('suggestion-modalContainer');
                        $('.dnnMobileTableFilter').removeClass('suggestion-modalContainer');
                        $('.suggestion-modalShadow').fadeOut('fast');
                        $('.dnnMobileFilterSet > a.dnnMobileFilterSet-Cancel').hide();
                        $('.dnnMobileFilterSet > input[type="text"]').css('width', '100%');
                        if (typeof callback === 'function') callback();
                    });
            }
        };
        
        this.toggleSuggestionsMobileView = function () {
            $('.dnnMobileSocialSearchResult').is(':visible') ? this.hideSuggestionsMobileView() : this.showSuggestionsMobileView();
        };
        
        this.searchBtnClicked = function () {
            that.toSearchResultsPage();
            that.toggleSuggestions();
        };

        this.switchingView = function () {
            this.hideSuggestions();
            this.hideSuggestionsMobileView();
        };

        this.switchedView = function() {
            $('#' + settings.moduleScope.id + ' .ko-container').removeClass('ko-container');
            $('#' + settings.moduleScope.id + ' input[type="text"]').on('keydown', function (e) {
                e = e || window.event;
                var charCode = e.charCode || e.keyCode;
                if (charCode == 13) {
                    that.toSearchResultsPage();
                    e.preventDefault();
                    e.stopPropagation();
                }
            });
        };
        
        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);

        this.binded = function() {
            this.switchedView();
        };
    };
    
    dnn.social.ContentItem = function ContentItem(contentItem) {
        $.extend(this, dnn.social.komodel(contentItem));
    };
    
})(window.dnn, window.jQuery, window.ko);