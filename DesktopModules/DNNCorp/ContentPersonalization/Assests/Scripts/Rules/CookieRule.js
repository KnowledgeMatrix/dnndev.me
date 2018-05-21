// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

﻿/*
  LICENSE
 */

/***
 * @class CookieRule
 *
 * This implements the Cookie rule model
 *
 * @depends jQuery
 * @depends knockout
 *
 * @param {function} onDeleteRuleCallback (null), method that will be executed when the rule is deleted. This function
 *                          receives as parameter the id of the deleted rule .
 * @param {object} resx, localization resources.
 *
 */

// personalizedTabs
window.dnn = dnn || {};
window.dnn.personalizedTabs = dnn.personalizedTabs || {};
window.dnn.personalizedTabs.rules = dnn.personalizedTabs.rules || {};

(function IIFE() {
    var CookieRuleClass;

    CookieRuleClass = (function IIFE() {
        'use strict';

        // var CONSTANT;
        var HTML_PATH = "Assests/Html/Rules/CookieRuleTemplate.html";

        // var _privateVar;
        var _templateLoader, _resx;

        // var privateMethod
        var getViewModel, remove;

        /* Class properties */
        CookieRule.class = 'CookieRule';
        CookieRule.type = 'Class'; // If class only has Class Methods put Static Class here
        CookieRule.template;
        CookieRule.allowMultipleInstances = true; 

        /* Private Constants and Properties */

        /* Constructor */
        function CookieRule(onDeleteRuleCallback, resx) {
            _resx = resx;

            this._id = "";
            this._viewModel = {};
            this._ruleElement = null;
            this.onDeleteRuleCallback = onDeleteRuleCallback;
            // Add the instance rule's attributes 

            _templateLoader = window.dnn.personalizedTabs.TemplateLoader;
            if (!CookieRule.template) {
                _templateLoader.readHtmlTemplate(
                    dnn.getVar('dnn_content_personalization_resourceroot') + HTML_PATH,
                    function (template) {
                        CookieRule.template = template;
                    }
                );
            }
        }

        /* Private Methods */
        getViewModel = function (self, data) {
            self._viewModel = {
                id: self._id,
                remove: remove,
                self: self,
                resx: _resx,
                name: ko.observable("").trimmed().extend({
                    required: true,
                    pattern: {
                        message: _resx.RulesCookieNameValidationError,
                        params: /^([a-zA-Z0-9\!\#\$\%\&\'\*\+\-\.\^_\`\|\~])+$/
                    }
                }),
                matchingType: ko.observable("Equals"),
                matchingText: ko.observable("").trimmed().extend({ 
                    required: true
                })         
            };

            if (data) {
                self._viewModel.name(data.Name);
                self._viewModel.matchingType(data.MatchingType);
                self._viewModel.matchingText(data.MatchingText);
            };

            self._viewModel.validationObservable = ko.validatedObservable({
                name: self._viewModel.name,
                matchingText: self._viewModel.matchingText
            });
        };

        remove = function () {
            if (this.self.onDeleteRuleCallback && typeof this.self.onDeleteRuleCallback === 'function') {
                this.self.onDeleteRuleCallback(this.id);
            }
        };

        /* Class Methods */
        // ex: CookieRule.method = function () {};
        CookieRule.getId = function () {
            return "CookieRule";
        };

        CookieRule.getName = function (resx) {
            return resx.RulesCookieName;
        };

        CookieRule.loadTemplate = function (callback) {
            if (!CookieRule.template) {
                _templateLoader.readHtmlTemplate(
                    dnn.getVar('dnn_content_personalization_resourceroot') + HTML_PATH,
                    function (template) {
                        CookieRule.template = template;
                        callback();
                    }
                );
            } else {
                callback();
            }
        }

        /* Public Methods */
        CookieRule.prototype.getId = function () {
            return this._id;
        };

        /* Params:
         *  @param {object} parenteElemente, parent in which the rule will be injected.
         *  @param {function} afterInjectCallback (ruleId), function called after inject the rule that receives 
         *              as parameter (the rule, parentElement, validationObservable) (ko object associated 
         *              with the validation of the rule)
        */
        CookieRule.prototype.injectRule = function (parentElement, afterInjectCallback, data) {
            var self = this;
            CookieRule.loadTemplate(function () {
                var dateNow = new Date().getTime();
                var html = CookieRule.template.replace(/\{0\}/g, dateNow);
                parentElement.append(html);

                self._id = dateNow;

                self._ruleElement = $("#{0}".replace(/\{0\}/g, self._id));

                getViewModel(self, data);

                ko.applyBindings(self._viewModel, self._ruleElement[0], { decorateElement: true, insertMessages: true, deep: true });
                afterInjectCallback(self, parentElement, self._viewModel.validationObservable);
            });
        }

        CookieRule.prototype.getDataToBeSent = function () {
            if (!this._viewModel) {
                return;
            }

            return {
                type: "CookieRule",
                name: this._viewModel.name(),
                matchingType: this._viewModel.matchingType(),
                matchingText: this._viewModel.matchingText() 
            };
        }

        CookieRule.prototype.freeContext = function () {
            var element = $("#{0}".replace(/\{0\}/g, this._id));
            ko.cleanNode(element);
        }

        CookieRule.prototype.doesRuleAllowMultipleInstances = function () {
            return CookieRule.allowMultipleInstances;
        };

        CookieRule.prototype.getRuleClass = function () {
            return CookieRule.class;
        };

        /* test-code */
        // Expose private Methods for test when class is finished
        // CookieRule.prototype.privateMethodTest = privateMethod;
        /* end-test-code */

        return CookieRule;
    })();

    window.dnn.personalizedTabs.rules.CookieRule = CookieRuleClass;

}).call(this);
