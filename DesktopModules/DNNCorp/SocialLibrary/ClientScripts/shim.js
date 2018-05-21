// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

﻿(function () {
    // fix for IE8
    if (!document.getElementsByClassName) {
        document.getElementsByClassName = function (className) {
            return this.querySelectorAll("." + className);
        };
        Element.prototype.getElementsByClassName = document.getElementsByClassName;
        var bodyClassName = document.body.className ? ' IE8' : 'IE8';
        document.body.className += bodyClassName;
    }

    if (!Array.prototype.indexOf) {
        Array.prototype.indexOf = function(obj, start) {
            for (var i = (start || 0), j = this.length; i < j; i++) {
                if (this[i] === obj) {
                    return i;
                }
            }
            return -1;
        };
    }
    
    if (!document.getSelection) {
        document.getSelection = function() {
            return document.selection.createRange();
        };
    }

    Object.keys = Object.keys || function (o) {
        var result = [];
        for (var name in o) {
            if (o.hasOwnProperty(name))
                result.push(name);
        }
        return result;
    };

    Object.create = Object.create || (function() {
        function f() {}

        return function(o) {
            if (arguments.length != 1) {
                throw new Error('Object.create implementation only accepts one parameter.');
            }
            f.prototype = o;
            return new f();
        };
    })();
    
    // Extensions to core JavaScript types
    String.prototype.format = function () {
        var s = this;
        var i = arguments.length;
        while (i--) {
            s = s.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
        }
        return s;
    };

    String.isEmpty = function (s) {
        if (s == null) return true;
        if (typeof s === 'string')
            return s.trim().length === 0;

        return s.length === 0;
    };

    Object.isNullOrUndefined = function (value) {
        return (typeof (value) === "undefined" || value === null);
    };

    String.isNullOrEmpty = function (value) {
        return (Object.isNullOrUndefined(value) || value === "");
    };

    if (typeof String.prototype.startsWith !== 'function') {
        String.prototype.startsWith = function (str) {
            return this.slice(0, str.length) === str;
        };
    }

    if (typeof Number.isPositiveInteger === "undefined") {
        Number.isPositiveInteger = function (value) {
            var isInteger = !isNaN(value) && isFinite(value);
            if (typeof value === 'string') {
                isInteger = isInteger && (value.indexOf('.') === -1) && (value.indexOf(',') === -1);
            }
            else {
                isInteger = isInteger && (typeof value === 'number' && value % 1 === 0);
            }
            return isInteger && (value - 0) > 0;
        };
    };

    if (typeof (Object.prototype.hasOwnProperty) === 'undefined') {
        Object.prototype.hasOwnProperty = function (k) {
            return Array.indexOf(Object.keys(this) || [], k) >= 0;
        };
    };

    if (typeof String.toCamel === "undefined") {
        String.toCamel = function (text) {
            return String.isNullOrEmpty(text) ? text : (text.charAt(0).toLowerCase() + text.substr(1));
        };
    };

    if (typeof Object.ToCamel === "undefined") {
        Object.ToCamel = function (o) {
            var camelizedObject = {};
            var propertyValue;
            for (var propertyName in o) {
                if (Object.prototype.hasOwnProperty.call(o, propertyName) && typeof (propertyName) === "string") {
                    propertyValue = o[propertyName];
                    if (typeof (propertyValue) === "object" && propertyValue !== null && propertyValue.constructor !== Array) { 
                        propertyValue = Object.ToCamel(propertyValue);
                    }
                    camelizedObject[String.toCamel(propertyName)] = propertyValue;
                }
            }
            return camelizedObject;
        };
    };
    
})();