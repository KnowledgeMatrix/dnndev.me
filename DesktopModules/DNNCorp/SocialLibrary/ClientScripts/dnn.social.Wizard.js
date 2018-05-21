/// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.


if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {

    'use strict';

    dnn.social.PageControl = function ($, ko, social, root, name, index) {
        var that = this;

        this.index = index;
        this.step = $('#{0}-step'.format(name));
        this.page = $('#{0}-page'.format(name));

        this.step.hover(function () {

            if (that.step.hasClass('active'))
                return;

            that.step.addClass('hover');

            var wizardStep = $('.wizardStepArrow', that.step);

            if (wizardStep.length == 0) {
                // last step
                $('.wizard-tabs', root).attr('class', 'wizard-tabs hover');
            }
            else {
                if (wizardStep.hasClass('normal-active')) {
                    wizardStep.attr('class', 'wizardStepArrow hover-active');
                }
                else {
                    wizardStep.attr('class', 'wizardStepArrow hover-normal');
                }
            }

            if (that.index > 0) {
                var prevIndex = that.index - 1;
                var prevStep = $('.wizard-tabs > li:eq(' + prevIndex + ')', root);
                var prevWizardStep = $('.wizardStepArrow', prevStep);

                if (prevWizardStep.hasClass('active-normal')) {
                    prevWizardStep.attr('class', 'wizardStepArrow active-hover');
                }
                else {
                    prevWizardStep.attr('class', 'wizardStepArrow normal-hover');
                }
            }
        }, function () {

            if (that.step.hasClass('active'))
                return;

            that.step.removeClass('hover');

            var wizardStep = $('.wizardStepArrow', that.step);
            if (wizardStep.length == 0) {
                $('.wizard-tabs', root).attr('class', 'wizard-tabs');

            }
            else {
                var cssClass = wizardStep.attr('class');
                cssClass = cssClass.replace('hover', 'normal');
                wizardStep.attr('class', cssClass);
            }

            if (that.index > 0) {
                var prevIndex = that.index - 1;
                var prevStep = $('.wizard-tabs > li:eq(' + prevIndex + ')', root);
                var prevWizardStep = $('.wizardStepArrow', prevStep);
                var prevCssClass = prevWizardStep.attr('class');
                prevCssClass = prevCssClass.replace('hover', 'normal');
                prevWizardStep.attr('class', prevCssClass);
            }
        });

        this.switchTo = function (to, from, mobile) {
            switch (typeof (to)) {
                case 'undefined':
                    if (mobile) {

                    } else {
                        that.step.attr('class', 'active');
                        $('.wizardStepArrow', that.step).attr('class', 'wizardStepArrow active-normal');
                        that.page.fadeIn('fast');
                    }
                    break;
                case 'object':
                    if (to instanceof dnn.social.PageControl) {
                        if (!from) {
                            $('.wizardPage', root).hide();
                        }
                        
                        if (mobile) {
                            $('ul.wizard-tabs > li', root).removeClass('active').hide();
                            that.step.show();
                            that.showMobileWizardIndicator();
                            var offset = $('.dnnFormPopup.dnnFormPopupMobileView').offset();
                            var top = offset? offset.top : 0;
                            window.scrollTo(0, top);
                        } else {
                            that.removeMobileWizardIndicator();
                            $('ul.wizard-tabs > li', root).removeClass('active').show();
                            that.step.attr('class', 'active');

                            $('.wizardStepArrow').attr('class', 'wizardStepArrow normal-normal');
                            if (from)
                                $('.wizardStepArrow', from.step).attr('class', 'wizardStepArrow normal-active');

                            var wizardStep = $('.wizardStepArrow', that.step);
                            if (wizardStep.length == 0) {
                                $('.wizard-tabs', root).attr('class', 'wizard-tabs active');
                            }
                            else {
                                $('.wizardStepArrow', that.step).attr('class', 'wizardStepArrow active-normal');
                                $('.wizard-tabs', root).attr('class', 'wizard-tabs');
                            }
                        }
                        
                        to.page.fadeOut('fast',
                           function () {
                               that.page.fadeIn('fast');
                           });
                        
                    } else {
                        to.fadeOut('fast',
                        function () {
                            that.step.attr('class', 'active');
                            that.page.fadeIn('fast');
                        });
                    }
            }
        };

        this.hide = function () {
            that.page.hide();
        };

        this.hideError = function () {
            $('.dnnFormError', that.page).hide();
        };

        this.showMobileWizardIndicator = function() {
            var wizardIndicator = $('.dnnFormPopup.dnnFormPopupMobileView > .social-wizard-indicator');
            if (!wizardIndicator.length) {
                $('.dnnFormPopup.dnnFormPopupMobileView').append('<div class="social-wizard-indicator"></div>');
                wizardIndicator = $('.dnnFormPopup.dnnFormPopupMobileView > .social-wizard-indicator');
                var steps = $('ul.wizard-tabs > li', root).length;
                for (var i = 0; i < steps; i++) {
                    wizardIndicator.append('<span />');
                }
            }
            $('.dnnFormPopup.dnnFormPopupMobileView > .social-wizard-indicator > span').removeClass('active');
            $('.dnnFormPopup.dnnFormPopupMobileView > .social-wizard-indicator > span:eq(' + that.index + ')').addClass('active');
        };

        this.removeMobileWizardIndicator = function() {
            $('.dnnFormPopup.dnnFormPopupMobileView > .social-wizard-indicator').remove();
        };
    };

    dnn.social.Wizard = function ($, ko, social, options, initMobile) {
        var that = this;

        var defaultOptions = {
            moduleId: -1,
            stepIndex: 0,
            validate: function () {
                return true;
            }
        };

        $.extend(this, defaultOptions, options);

        this.controls = [];

        this.stepIndex = ko.observable(this.stepIndex);

        this.localization = social.getLocalizationController();
        
        this.init = function () {
            that.controls = [];
            $.each(that.pages,
                function (index, page) {
                    that.controls.push(new dnn.social.PageControl($, ko, social, that.root, page, index));
                    that.controls[that.controls.length - 1].hide();
                });

            that.enableControls();

            that.switchTo(0, initMobile);

            if (typeof (that.onInit) != 'undefined') {
                that.onInit();
            }
        };

        this.next = function () {
            if (that.stepIndex() >= that.controls.length - 1) {
                return that.finish();
            }
            var mobileView = typeof this.isMobileView === 'function' ? this.isMobileView() : false;
            return that.switchTo(that.stepIndex() + 1, mobileView);
        };
        
        this.finish = function () {
            if (!that.validate($(that.controls[that.stepIndex()].page), that.customValidator)) {
                return false;
            }

            return that.finished();
        };

        this.finished = function () {
            if (typeof (this.onFinish) != 'undefined') {
                if (!this.onFinish()) return false;
            }
            return true;
        };

        this.prev = function () {
            if (that.stepIndex() == 0) {
                that.cancel();
                return false;
            }
            var mobileView = typeof this.isMobileView === 'function' ? this.isMobileView() : false;
            return that.switchTo(that.stepIndex() - 1, mobileView);
        };

        this.cancel = function () {
            if (typeof (that.onCancel) != 'undefined') {
                that.onCancel();
            }
        };

        this.switchTo = function (page, mobile) {
            if (page == 0) {
                $('.dnnFormError.dnnFormMessage', this.control).hide();
            }

            if (typeof (that.onBeforeSwitch) != 'undefined') {
                var result = that.onBeforeSwitch(page, that.stepIndex());
                if (!result) return false;
            }

            if (page > that.stepIndex()) {
                for (var i = 0; i < page; ++i) {
                    if (!that.validate($(that.controls[i].page), that.customValidator)) {
                        return false;
                    }
                }
            }
            
            var prevControls = page > 0 ? that.controls[page - 1] : null;
            that.controls[page].switchTo(that.controls[that.stepIndex()], prevControls, mobile);

            that.stepIndex(page);
            that.enableControls();

            if (typeof (that.onSwitch) != 'undefined') {
                that.onSwitch(page, that.stepIndex());
            }

            return true;
        };

        this.switchTo0 = function () {
            that.switchTo(0);
        };

        this.switchTo1 = function () {
            that.switchTo(1);
        };

        this.switchTo2 = function () {
            that.switchTo(2);
        };

        this.enableControls = function () {
            var prev = $('#prev');
            var next = $('#next');

            if (that.stepIndex() == that.controls.length - 1) {
                next.text(that.localization.getString('Finish'));
            } else {
                next.text(that.localization.getString('Next'));
            }

            prev.text(that.localization.getString('Previous'));
        };
        
        this.init();
    };

})(dnn);