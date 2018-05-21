// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (jQuery) {
    jQuery.fn.extend({
        center: function (host) {

            var $host = host ? jQuery(host) : jQuery(window);

            return this.each(function () {
                var $this = jQuery(this);
                var top = ($host.height() - $this.outerHeight(true)) / 2 + $host.scrollTop();
                top = top > 0 ? top : 0;
                var left = ($host.width() - $this.outerWidth(true)) / 2 + $host.scrollLeft();
                left = left > 0 ? left : 0;
                $this.css({ position: "absolute", margin: 0, top: top + "px", left: left + "px" });
                return $this;
            });
        },
        removeCssProperties: function () {
            var propertyNames = arguments;
            return this.each(function () {
                var jQueryThis = jQuery(this);
                jQuery.grep(propertyNames, function (propertyName) {
                    propertyName = propertyName.trim();
                    var style = jQueryThis.attr('style');
                    if (style) {
                        return jQueryThis.attr('style',
                                jQuery.grep(jQueryThis.attr('style').split(";"),
                                function (cssPropertyName) {
                                    if (cssPropertyName.toLowerCase().indexOf(propertyName.toLowerCase() + ':') < 0) {
                                        return cssPropertyName;
                                    }
                                    return "";
                                }
                            ).join(";"));
                    }
                    else {
                        return jQueryThis;
                    }
                });
            });
        }

    });
})(jQuery);

(function ($, window, document, undefined) {

    var pluginName = 'tooltip';

    var Tooltip = this.Tooltip = function (element, options) {
        this.element = element;
        this.options = options;

        this.init();
    };

    Tooltip.prototype = {

        constructor: Tooltip,

        init: function () {
            this.options = $.extend({}, Tooltip.defaults(), this.options);

            this.$this = $(this);
            this.$element = $(this.element);

            this.$element.removeAttr('title').removeAttr('alt');

            var onMouseEnterHandler = $.proxy(this._onMouseEnter, this);
            var onMouseLeaveHandler = $.proxy(this._onMouseLeave, this, this.options.closeOnMouseLeave);
            var onMouseClickHandler = $.proxy(this._onMouseClick, this);
            this._onCloseButtonClickHandler = $.proxy(this._onCloseButtonClick, this);
            this.$element.on('mouseenter', onMouseEnterHandler).on('mouseleave', onMouseLeaveHandler).on('click', onMouseClickHandler);
            var onDocumentClickHandler = $.proxy(this._onDocumentClick, this);
            $(document).on('click', onDocumentClickHandler);
        },

        _onMouseEnter: function (eventObject) {
            if (this._showTimeoutId) {
                clearTimeout(this._showTimeoutId);
            }
            this._hoverState = "mouse-enter";
            var self = this;
            var show = function () { if (self._hoverState === "mouse-enter") { self._show(); } };
            this._showTimeoutId = setTimeout(show, this.options.showIn);
        },

        _onMouseLeave: function (closeOnMouseLeave, eventObject) {
            eventObject.stopPropagation();
            if (this._showTimeoutId) {
                clearTimeout(this._showTimeoutId);
                this._showTimeoutId = undefined;
            }
            if (closeOnMouseLeave) {
                this._hoverState = "mouse-leave";
                var self = this;
                var hide = function () { if (self._hoverState === "mouse-leave") { self._hide(); } };
                this._showTimeoutId = setTimeout(hide, this.options.hideIn);
            }
        },

        _onCloseButtonClick: function (eventObject) {
            eventObject.preventDefault();
            eventObject.stopPropagation();
            if (this._showTimeoutId) {
                clearTimeout(this._showTimeoutId);
                this._showTimeoutId = undefined;
            }
            this._hide();
        },

        _hide: function () {
            var index = $.inArray(this, Tooltip.displayedTooltips);
            if (index >= 0) {
                Tooltip.displayedTooltips.splice(index, 1);
                if (this._$tooltip) {
                    this._$tooltip.fadeOut(this.options.fadeOutDuration);
                }
            }
        },

        _onMouseClick: function (eventObject) {
            eventObject.stopPropagation();
            if (Tooltip.isDisplayed(this)) {
                this._hide();
            }
            else {
                this._show();
            }
        },

        _isjQuery: function (obj) {
            return obj && obj.jquery;
        },

        _getViewPort: function () {
            var $window = $(window);
            var viewPort = {
                top: $window.scrollTop(),
                left: $window.scrollLeft(),
                width: $window.width(),
                height: $window.height(),
                right: function () { return this.left + this.width; },
                bottom: function () { return this.top + this.height; },
            };
            return viewPort;
        },

        _createTooltip: function () {
            var $tooltip;
            $tooltip = $(this.options.template || '<div>').addClass(this.options.cssClass).hide();
            if (this.options.id) {
                $tooltip.attr('id', this.options.id);
            }

            var tooltipMarkup = this.options.getTooltipMarkup.call(this, this.element);
            if (tooltipMarkup.nodeType || this._isjQuery(tooltipMarkup)) {
                $tooltip.append(tooltipMarkup);

                if (this.options.closeButtonSelector) {
                    $(tooltipMarkup).find(this.options.closeButtonSelector).on('click', this._onCloseButtonClickHandler);
                }
            }
            else {
                $tooltip.html(tooltipMarkup);
            }

            $tooltip.on('mouseleave', $.proxy(this._onMouseLeave, this, true));
            $tooltip.on('click', function (e) { e.stopPropagation(); });

            return $tooltip;
        },

        _inContainer: function ($container, element) {
            return $container && $container.length !== 0 && ($.contains($container[0], element) || $container[0] === element);
        },

        _onDocumentClick: function (eventObject) {
            var clickedElement = eventObject.target;
            if (this._$tooltip && !this._inContainer(this._$tooltip, clickedElement)) {
                this._hide();
            }
        },

        _show: function () {
            var index = 0;
            var isDisplayed = false;
            while (Tooltip.displayedTooltips.length > index) {
                if (Tooltip.displayedTooltips[index] === this) {
                    isDisplayed = true;
                    index++;
                }
                else if (this.options.singleDisplay) {
                    Tooltip.displayedTooltips[index]._hide();
                }
                else {
                    index++;
                }
            }

            if (isDisplayed) {
                return;
            }

            Tooltip.displayedTooltips.push(this);

            if (!this._$tooltip) {
                this._$tooltip = this._createTooltip();
            }
            this._setTooltipOffset();
        },

        _setTooltipOffset: function () {

            this._$tooltip.detach().removeCssProperties("height", "width", "left", "top").css({ display: "block" });
            if (this.options.container) {
                this._$tooltip.appendTo(this.options.container);
            }
            else {
                this._$tooltip.insertAfter(this.$element);
            }

            var placement = (typeof this.options.placement == 'function' ?
                this.options.placement.call(this, this._$tooltip[0], this.element) : this.options.placement);

            var elementPosition = this._getPosition();

            var tooltipWidth = this._$tooltip.outerWidth();
            var tooltipHeight = this._$tooltip.outerHeight();
            var tooltipPosition;

            switch (placement) {
                case 'top':
                    tooltipPosition = { top: elementPosition.top - tooltipHeight, left: elementPosition.left + 10/*+ (elementPosition.width - tooltipWidth) / 2 */ };
                    break;
                case 'bottom':
                    tooltipPosition = { top: elementPosition.top + elementPosition.height, left: elementPosition.left + 10 /*+ (elementPosition.width - tooltipWidth) / 2 */ };
                    break;
                case 'left':
                    tooltipPosition = { top: elementPosition.top + (elementPosition.height - tooltipHeight) / 2, left: elementPosition.left - tooltipWidth };
                    break;
                case 'right':
                    tooltipPosition = { top: elementPosition.top + (elementPosition.height - tooltipHeight) / 2, left: elementPosition.left + elementPosition.width };
                    break;
                default:
                    tooltipPosition = { top: elementPosition.top + this.options.top, left: elementPosition.left + this.options.left };
            }

            var viewPort = this._getViewPort();

            var offScreenLength = (tooltipPosition.left + tooltipWidth) - viewPort.right();
            if (offScreenLength > 0) {
                tooltipPosition.left = Math.max(viewPort.left, tooltipPosition.left - offScreenLength);
            }

            offScreenLength = (tooltipPosition.top + tooltipHeight) - viewPort.bottom();
            if (offScreenLength > 0) {
                tooltipPosition.top = Math.max(viewPort.top, tooltipPosition.top - offScreenLength);
            }

            this._$tooltip.offset(tooltipPosition).fadeIn(this.options.fadeInDuration); // show();
            if (this.options.animateOnOpen) {
                var originalSize = { height: this._$tooltip.height(), width: this._$tooltip.width() };
                this._$tooltip.css({ height: 0, width: 0 }).animate(originalSize, this.options.fadeInDuration);
            }
        },

        _removeTooltip: function () {
            if (this._$tooltip) {
                var complete = function () {
                    $(this).remove();
                };
                this._$tooltip.stop().fadeOut(this.options.fadeOutDuration, complete);
                this._$tooltip = null;
            }
        },

        _getPosition: function () {
            return $.extend({}, (typeof this.element.getBoundingClientRect === 'function') ? this.element.getBoundingClientRect() : {
                width: this.element.offsetWidth,
                height: this.element.offsetHeight
            }, this.$element.offset());
        }

    };

    Tooltip._defaults = {
        fade: false,
        cssClass: "",
        top: 15,
        left: 15,
        fadeInDuration: 400,
        fadeOutDuration: 400,
        closeOnMouseLeave: true,
        animateOnOpen: false,
        container: null,
        showIn: 400,
        hideIn: 100,
        template: "<div></div>"
    };

    Tooltip.defaults = function (settings) {
        if (!(typeof settings === "undefined")) {
            $.extend(Tooltip._defaults, settings);
        }
        return Tooltip._defaults;
    };

    Tooltip.displayedTooltips = [];

    Tooltip.isDisplayed = function (tooltip) {
        return $.inArray(tooltip, Tooltip.displayedTooltips) >= 0;
    };

    $.fn[pluginName] = function (option) {

        return this.each(function () {
            var $this = $(this);
            var options = $.extend({}, typeof option === 'object' && option);
            var data = $this.data(pluginName);
            if (!data) {
                $this.data(pluginName, (data = new Tooltip(this, options)));
            }
        });
    };

}).apply(dnn, [jQuery, window, document]);

(function (dnn) {
    'use strict';
    
    dnn.activities.UserBadgesView = function UserBadgesView($, ko, settings) {
        var that = this;
    
        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.componentFactory = this.social.getComponentFactory();
    
        this.componentFactory.register(new dnn.activities.UserBadgesController($, ko, settings, this.social, this));
        this.componentFactory.register(new dnn.activities.BadgeSearchController($, ko, settings, this.social));
        this.componentFactory.register(this.social.getPagingControl('UserBadgesController'));
        this.componentFactory.register(this, 'PrimaryView');

        this.localizer = function () {
            return that.social.getLocalizationController();
        };

        this.pager = function () {
            return that.componentFactory.resolve('PagingControl');
        };
        
        this.searcher = function () {
            return that.componentFactory.resolve('UserBadgesController');
        };
        
        this.rootUrl = this.social.getService('Social').getRoot();
        
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

                return localizer.getString('ResultCount').format(search.totalResults());
            }
        );

        this.pagingControl = ko.computed(
            function () {
                var pager = that.pager();
                if (pager != null) {
                    return pager.markup();
                }
                return new String();
            }
        );
 
        this.prev = function () {
            var controller = that.pager();
            if (controller != null) {
                controller.previous();
            }
        };

        this.next = function () {
            var controller = that.pager();
            if (controller != null) {
                controller.next();
            }
        };

        this.refresh = function () {
            var controller = that.searcher();
            if (controller != null) {
                controller.load();
            }
        };
        
        this.badges = ko.observableArray([]);

        dnn.social.MobileView.init($, ko, this, null, null);

    };
})(window.dnn);