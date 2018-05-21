// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.getControlCoordinates = function (control) {
        if (control == null) {
            return null;
        }

        var $control = $(control);
        var offset = $control.offset();
        var p = {
            x: offset.left,
            y: offset.top
        };

        return p;
    };

    dnn.social.FocusController = function FocusController ($, ko, settings, social, container, children) {
        var that = this;

        this.getControlCoordinates = dnn.social.getControlCoordinates;

        this.mouseWithinControl = function (ev, control) {
            var coordinates = that.getControlCoordinates(control);
            if (coordinates == null) {
                return false;
            }

            var l = coordinates.x;
            var r = coordinates.x + $(control).outerWidth(true);
            var t = coordinates.y;
            var b = coordinates.y + $(control).outerHeight(true);

            if (ev.pageX >= l && ev.pageX <= r &&
                ev.pageY >= t && ev.pageY <= b) {
                return true;
            }

            return false;
        };

        this.isInputControl = function (element) {
            var tag = element.prop('tagName');
            if (tag == null || tag.length == 0) {
                return false;
            }
            
            switch (tag.toLowerCase()) {
                case 'a':
                case 'button':
                case 'input':
                case 'select':
                case 'textarea':
                    return true;
                default:
                    
                    if (that.isInputControl(element.parent())) {
                        return true;
                    }

                    return false;
            }
        };

        this.inputControl = function (element) {
            if (element == null) {
                return false;
            }

            return that.isInputControl($(element));
        };

        this.getFirstInput = function (element) {
            if (element == null) {
                return null;
            }

            if (that.inputControl(element)) {
                return element;
            }

            if (element.children.length === 0) {
                return null;
            }

            for (var i = 0; i < element.children.length; ++i) {
                var child = element.children[i];

                if (that.inputControl(child)) {
                    return child;
                }

                var recurse = that.getFirstInput(child);
                if (recurse != null) {
                    return recurse;
                }
            }

            return null;
        };

        this.clickedWithinInput = function (e) {
            if (e == null) {
                return false;
            }

            var target = e.target || e.srcElement || e.currentTarget;
            if (target) {
                return that.inputControl(target);
            }

            return false;
        };

        this.clickedWithinControl = function(e, parent) {
            if (e == null) {
                return false;
            }

            var target = e.target || e.srcElement || e.currentTarget;
            if (target) {
                if (target == $(parent)[0])
                    return true;
                
                var node = $(target);
                if (node.parents(parent).length)
                    return true;
            }
            return false;
        };

        this.processClick = function (e) {
            if (that.clickedWithinInput(e)) {
                return;
            }

            var childFocus = false;
            
            $.each(children,
                function (i, child) {
                    if (that.clickedWithinControl(e, child)) {
                        $(child).triggerHandler('focused');
                        childFocus = true;
                        return false;
                    }
                    return true;
                });
            
            if (!childFocus) {
                $(container).trigger('focused');
            }
        };

        $('html body').bind('click',
            function (e) {
                that.processClick(e);
            });
    };
})(window.dnn);