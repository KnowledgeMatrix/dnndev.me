// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';

    dnn.social.History = function History ($) {
        var that = this;

        this.history = window.History;

        if (typeof (this.history) === 'undefined' || typeof (this.history.Adapter) === 'undefined') {
            throw new Error('You must load history.js in order to use the History controller');
        }

        this.handler = null;
        this.bind = function (handler) {
            that.handler = handler;
            that.history.Adapter.bind(window, 'statechange',
                function () {
                    var state = that.history.getState();

                    if (typeof (state) !== 'undefined') {
                        if (typeof (handler) === 'function') {
                            handler(state.data);
                        }
                    }
                });
        };
        
        this.navigate = function (state) {
            that.history.pushState(state, window.document.title, that.getUrl(state));
        };

        this.setNavigationProperty = function (property, value) {
            var state = that.history.getState();
            state.data[property] = value.toString();
            that.history.pushState(state.data, window.document.title, that.getUrl(state.data));
        };

        this.getUrl = function (state) {
            var queryString = new String();

            if (state != null) {
                $.each(state,
                    function (index, argument) {
                        if (queryString.length > 0) {
                            queryString += '&';
                        }

                        queryString += '{0}={1}'.format(index, encodeURIComponent(argument));
                    });
            }

            return '?{0}'.format(queryString);
        };

        this.getState = function () {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars[hash[0]] = hash[1];
            }
            return vars;
        };

        this.triggerStateChange = function (state) {
            if (that.handler) {
                that.handler(state);
            }
        };
    };
})(window.dnn);