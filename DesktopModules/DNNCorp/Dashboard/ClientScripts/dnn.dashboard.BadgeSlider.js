// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function ($, window, document, undefined) {

    var pluginName = 'slider';

    var Slider = this.Slider = function (element, options) {
        this.element = element;
        this.options = options;

        this.init();
    };

    Slider.prototype = {

        constructor: Slider,

        init: function () {
            this.options = $.extend({}, Slider.defaults(), this.options);

            this.$this = $(this);
            this.$element = $(this.element);

            this.$container = this.options.containerSelector ? $(this.options.containerSelector) : $(this.$element.children[0]);

            this.$nextButton = $(this.options.nextButton);
            this.$prevButton = $(this.options.prevButton);

            this._onNextButtonClickHandler = $.proxy(this._onNextButtonClick, this);
            this._onPrevButtonClickHandler = $.proxy(this._onPrevButtonClick, this);
            this.$prevButton.on('click', this._onPrevButtonClickHandler);
            this.$nextButton.on('click', this._onNextButtonClickHandler);

            this._initialLeftMargin = this._getContainerLeftMargin();

            this._$completeLeft = $.proxy(this._complete, this, "left");
            this._$completeRight = $.proxy(this._complete, this, "right");
            this._$completeNoSlide = $.proxy(this._complete, this, "no-slide");
            this._$completeBusy = $.proxy(this._complete, this, "busy");

            this._inProgress = false;
        },

        _complete: function (param) {
            if (param !== "busy") {
                this._inProgress = false;
            }
            var e = $.Event('slide-completed');
            var dimension = this.dimensions();
            this.$this.trigger(e, [dimension, param]);
        },

        _onNextButtonClick: function (eventObject) {
            eventObject.preventDefault();
            this.slideLeft();
        },

        _onPrevButtonClick: function (eventObject) {
            eventObject.preventDefault();
            this.slideRight();
        },

        inProgress: function () {
            return this._inProgress;
        },

        slideLeft: function () {
            if (this._inProgress) {
                this._$completeBusy();
                return;
            }
            this._inProgress = true;
            var dimension = this.dimensions();
            if (dimension.onRight > 0) {
                var leftMargin = Math.min(dimension.displayAreaWidth, dimension.onRight);
                this.$container.animate({ marginLeft: -leftMargin - dimension.containerLeftMargin }, this.options.slidingSpeed, this._$completeLeft);
            }
            else {
                this._$completeNoSlide();
            }
        },

        slideRight: function () {
            if (this._inProgress) {
                this._$completeBusy();
                return;
            }
            this._inProgress = true;
            var dimension = this.dimensions();
            if (dimension.onLeft > 0) {
                var leftMargin = Math.min(dimension.displayAreaWidth, dimension.onLeft);
                this.$container.animate({ marginLeft: -dimension.containerLeftMargin + leftMargin }, this.options.slidingSpeed, this._$completeRight);
            }
            else {
                this._$completeNoSlide();
            }
        },

        canSlide: function () {
            var dimension = this.dimensions();
            return dimension.onLeft > 0 || dimension.onRight > 0;
        },

        _getContainerLeftMargin: function () {
            var leftMargin = this.$container.css("margin-left");
            if (leftMargin === "auto") {
                leftMargin = 0;
            }
            return (-parseInt(leftMargin));
        },

        dimensions: function () {
            var displayAreaWidth = this.$element.width();
            var containerWidth = this.$container.outerWidth();
            var containerLeftMargin = this._getContainerLeftMargin();

            return {
                displayAreaWidth: displayAreaWidth,
                containerWidth: containerWidth,
                containerLeftMargin: containerLeftMargin,
                onLeft: containerLeftMargin - this._initialLeftMargin,
                onRight: containerWidth - displayAreaWidth - (containerLeftMargin - this._initialLeftMargin)
            };
        }
    };

    Slider._defaults = {
        containerSelector: "",
        nextButton: null,
        prevButton: null,
        slidingSpeed: 600
    };

    Slider.defaults = function (settings) {
        if (!(typeof settings === "undefined")) {
            $.extend(Slider._defaults, settings);
        }
        return Slider._defaults;
    };


    $.fn[pluginName] = function (option) {

        return this.each(function () {
            var $this = $(this);
            var options = $.extend({}, typeof option === 'object' && option);
            var data = $this.data(pluginName);
            if (!data) {
                $this.data(pluginName, (data = new Slider(this, options)));
            }
        });
    };

}).apply(dnn, [jQuery, window, document]);

(function(dnn) {
    'use strict';

    dnn.dashboard.BadgeSlider = function BadgeSlider() {
        this.init();
    };

    dnn.dashboard.BadgeSlider.prototype = {
        init: function () {
            this.$nextButton = $(".dashboard-profile-badges .pager-next");
            this.$prevButton = $(".dashboard-profile-badges .pager-prev");
            this.slider = new dnn.Slider($(".dashboard-profile-badge-list")[0],
                {
                    containerSelector: ".dashboard-profile-badge-list ul",
                    nextButton: this.$nextButton,
                    prevButton: this.$prevButton
                });

            var dimensions = this.slider.dimensions();

            if (dimensions.onRight > 0) {
                this.$nextButton.show();
                this.$prevButton.show();
            }
            else {
                this.$nextButton.hide();
                this.$prevButton.hide();
            }
            var onCompletedHandler = $.proxy(this._onCompleted, this);
            $(this.slider).bind("slide-completed", onCompletedHandler);
            this._setState(dimensions);
        },

        _onCompleted: function (eventObject, dimensions, slideType) {
            if (slideType !== "no-slide" && slideType !== "busy") {
                this._setState(dimensions);
            }
        },

        _setState: function (dimensions) {
            if (dimensions.onRight > 0) {
                this.$nextButton.removeClass("disabled");
            }
            else {
                this.$nextButton.addClass("disabled");
            }
            if (dimensions.onLeft > 0) {
                this.$prevButton.removeClass("disabled");
            }
            else {
                this.$prevButton.addClass("disabled");
            }
        }
    };

})(window.dnn);
