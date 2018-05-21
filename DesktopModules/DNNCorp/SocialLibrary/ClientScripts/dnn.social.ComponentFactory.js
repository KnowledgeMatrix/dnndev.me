// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.ComponentFactory = function ComponentFactory (moduleId) {
        var that = this;

        this.moduleId = moduleId;

        this.components = { };

        this.getModuleId = function () {
            return that.moduleId;
        };

        this.getType = dnn.social.ComponentFactory.getType;
        
        this.register = function (object, component) {
            if (typeof component === 'undefined') {
                component = that.getType(object);
            }

            if (typeof that.components[component] !== 'undefined') {
                var c = that.components[component];

                switch (typeof that.components[component]['dispose']) {
                case 'undefined':
                    break;
                case 'function':
                    try {
                        c.dispose();
                    } catch (e) {
                        console.log('Failure to dispose of component: {0}: {1}'.format(component, e.message));
                    }
                    break;
                default:
                    console.log(
                        'Nonconforming dispose method on {0}: dispose is a {1}, not a function'.format(component, typeof (c.dispose).toString()));
                    break;
                }

                delete that.components[component];
            }

            that.components[component] = object;

            return object;
        };
        
        this.resolve = function (component) {
            if (that.components.hasOwnProperty(component)) {
                return that.components[component];
            }

            return undefined;
        };

        this.hasComponent = function (component) {
            return that.components.hasOwnProperty(component);
        };
    };
    
    dnn.social.ComponentFactory.getType = function (obj) {
        if (obj.constructor != null &&
            obj.constructor.name != null &&
            obj.constructor.name.length > 0) {
            return obj.constructor.name;
        }

        // IE
        var results = /function ([a-zA-Z]+)/.exec(obj.constructor.toString());
        if (results != null && results.length > 1) {
            return results[1];
        }

        return Object.prototype.toString.call(obj).match(/^\[object (.*)\]$/)[1];
    };
})(window.dnn);