// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.


if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    
    'use strict';

    dnn.social.Validator = function($, ko, settings) {
        var that = this;

        $.extend(this, settings);

        if (typeof(settings) !== 'undefined')
            this.social = new dnn.social.Module(settings);

        this.getErrorString = function (localizer, resourceName, defaultStr) {
            return localizer ? localizer.getString(resourceName) : defaultStr;
        };

        this.selector = 'input, textarea, select';

        this.validate = function(container, customValidators) {
            var valid = true;

            $(that.selector, container).each(function (index, input) {
                var $input = $(input);
                var errorSpan = $input.hasClass('validateErrorAfterParent') ?
                    $input.parent().parent().find('span.dnnFormError').hide() :
                    $input.parent().find('span.dnnFormError').hide();
                var ctrlValid = true;

                var required = $input.hasClass('required');
                var minlength = $input.attr('minlength') ? $input.attr('minlength') : 0;
                var maxlength = $input.attr('maxlength') ? $input.attr('maxlength') : 0;
                var isNumber = $input.hasClass('number');
                var isNonNegativeNumber = $input.hasClass('nonnegativenumber');
                var isPositiveNumber = $input.hasClass('positivenumber');
                var isEmail = $input.hasClass('email');
                var isCustomValidate = $input.hasClass('customValidate');

                var appendError = function(errorMsg) {
                    if (errorSpan.length) {
                        errorSpan.html(errorMsg).show();
                    } else {
                        if ($input.hasClass('validateErrorAfterParent')) {
                            $('<span></span>').addClass('dnnFormError dnnFormMessage').html(errorMsg).insertAfter($input.parent()).click(function () {
                                $(this).hide();
                                return false;
                            });
                        } else {
                            $('<span></span>').addClass('dnnFormError dnnFormMessage').html(errorMsg).insertAfter($input).click(function () {
                                $(this).hide();
                                return false;
                            });
                        }
                        $input.bind('focus', function() {
                            $input.parent().find('span.dnnFormError').hide();
                        });
                    }
                };
                
                var localizer = null;
                if (typeof(that.social) !== 'undefined')
                    localizer = that.social.getLocalizationController();

                var val = $input.val();
                if (val && typeof val === 'string') val = val.trim();
                if (required) {
                    if (!val) {
                        appendError(that.getErrorString(localizer, 'FieldIsRequired', 'Text is required'));
                        ctrlValid = false;
                    }
                    else if ($input.hasClass('validateErrorAfterParent')) {
                        var html = $input.dnnRedactor('code.getCleanHtml');
                        var $temp = $("<div></div>").html(html);
                        var text = $temp.text();
                        text = text.replace(/(&nbsp;|<br>|\s)+/g, '');
                        if (!text) {
                            if (!$input.hasClass('imageIsNotEmptyContent') || !$temp.find('img').length) {
                                appendError(that.getErrorString(localizer, 'FieldIsRequired', 'Text is required'));
                                ctrlValid = false;
                            }
                        }
                    }
                }

                if (ctrlValid && minlength > 0) {
                    var intMinLength = parseInt(minlength);
                    if (val.length < intMinLength) {
                        var minLengthMsg = that.getErrorString(localizer, 'FieldMinLenRequired', 'Text must be at least {0} chars');
                        appendError(minLengthMsg.replace('{0}', intMinLength.toString()));
                        ctrlValid = false;
                    }
                }
                
                if (ctrlValid && maxlength > 0) {
                    var intMaxLength = parseInt(maxlength);
                    if (val.length > intMaxLength) {
                        var maxLengthMsg = that.getErrorString(localizer, 'FieldMaxLenRequired', 'Text must not be more than {0} chars');
                        appendError(maxLengthMsg.replace('{0}', intMaxLength.toString()));
                        ctrlValid = false;
                    }
                }

                if (ctrlValid && isNumber) {
                    if (!/^-?\d+$/.test(val)) {
                        ctrlValid = false;
                    }

                    if (!ctrlValid) {
                        if (/^-?\d+\.?\d+$/.test(val))
                            appendError(that.getErrorString(localizer, 'FieldIsNonDecimalNumeric', 'Decimal numbers are not allowed'));
                        else
                            appendError(that.getErrorString(localizer, 'FieldIsNumeric', 'Only numbers are allowed'));
                    }
                    
                    if (ctrlValid) {
                        var minAttr = $input.attr('min');
                        if (minAttr) {
                            var min = parseInt(minAttr, 10);
                            var intMin = parseInt(val, 10);
                            if (intMin < min) {
                                var belowMinMsg = that.getErrorString(localizer, 'FieldIsBelowMin', 'Number cannot be smaller than {0}');
                                appendError(belowMinMsg.replace('{0}', min.toString()));
                                ctrlValid = false;
                            }
                        }
                    }
                    
                    if (ctrlValid) {
                        var maxAttr = $input.attr('max');
                        if (maxAttr) {
                            var max = parseInt(maxAttr, 10);
                            var intMax = parseInt(val, 10);
                            if (intMax > max) {
                                var overMaxMsg = that.getErrorString(localizer, 'FieldIsOverMax', 'Number cannot be larger than {0}');
                                appendError(overMaxMsg.replace('{0}', max.toString()));
                                ctrlValid = false;
                            }
                        }
                    }
                }
                
                if (ctrlValid && isNonNegativeNumber) {
                    if (!/^\d+$/.test(val)) {
                        appendError(that.getErrorString(localizer, 'FieldIsNonNegativeNumeric', 'Negative numbers are not allowed'));
                        ctrlValid = false;
                    }
                }
                
                if (ctrlValid && isPositiveNumber) {
                    if (/^-?\d+$/.test(val)) {
                        var number = parseInt(val);
                        if (number <= 0) {
                            appendError(that.getErrorString(localizer, 'FieldIsPositiveNumeric', 'Only positive numbers are allowed'));
                            ctrlValid = false;
                        }
                        else {
                            ctrlValid = true;
                        }
                    }
                    else
                        ctrlValid = false;
                }
                
                if (ctrlValid && isEmail) {
                    if (!/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(val)) {
                        appendError(that.getErrorString(localizer, 'FieldIsEmail', 'Only valid email is allowed'));
                        ctrlValid = false;
                    }
                }

                if (ctrlValid && isCustomValidate) {
                    if (customValidators) {
                        for (var i = 0; i < customValidators.length; i++) {
                            var customValidator = customValidators[i];
                            var validatorName = customValidator.name;
                            if ($input.hasClass(validatorName)) {
                                if (!customValidator.validate(val, input)) {
                                    appendError(customValidator.errorMsg);
                                    ctrlValid = false;
                                }
                            }
                        }
                    }
                }

                valid = valid && ctrlValid;
            });

            return valid;
        };
    };
    
    dnn.social.internalValidator = new dnn.social.Validator($);
    dnn.social.validate = function (container, customValidator) {
        return dnn.social.internalValidator.validate(container, customValidator);
    };
})(window.dnn);