// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn) {
    'use strict';
	
    dnn.social.LocalizationControllerCache = {};
    dnn.social.LocalizationController = function LocalizationController ($, settings, social) {
        var that = this;

        this.showMissingKeys = settings.showMissingKeys || false;

        this.service = social.getService('Social');

        this.stringTable = {};

        this.localStorageAllowed = (function() {
            var mod = 'DNN_localStorageTEST';
            try {
                window.localStorage.setItem(mod, mod);
                window.localStorage.removeItem(mod);
                return true;
            } catch(e) {
                return false;
            }
        })();

        this.loadTable = function () {
            var timeStampKey = "ResxTimeStamp." + settings.desktopModuleId + "." + settings.culture;
            var resxKey = "Resx." + settings.desktopModuleId + "." + settings.culture;
            if (that.localStorageAllowed) {
                var resxTimeStamp = settings.resxTimeStamp;
                if (resxTimeStamp) {
                    if (window.localStorage[timeStampKey] === resxTimeStamp) {
                        var t = window.localStorage[resxKey];
                        if (t) {
                            that.stringTable = JSON.parse(t);
                            return true;
                        }
                    } else {
                        window.localStorage.removeItem(timeStampKey);
                        window.localStorage.removeItem(resxKey);
                    }
                }
            }
            
            var worked = false;
            var success = function (m) {
                $.each(m.Table,
                    function (index, entry) {
                        if (!that.stringTable.hasOwnProperty(index)) {
                            that.stringTable[index] = entry;
                        }
                    });

                if (that.localStorageAllowed) {
                    try {
                        window.localStorage[timeStampKey] = settings.resxTimeStamp;
                        window.localStorage[resxKey] = JSON.stringify(that.stringTable);
                    } catch (ex) {
                        if (ex.name === "QuotaExceededError") {
                            console.log("Local Storage might be full.");
                        }
                        console.log(ex);
                        if (window.localStorage[timeStampKey]) {
                            window.localStorage.removeItem(timeStampKey);
                        }
                        if (window.localStorage[resxKey]) {
                            window.localStorage.removeItem(resxKey);
                        }
                    }                     
                }
                worked = true;				
            };
            var failure = function (m) {
                console.log('Unable to load string translations: ' + (m.ErrorMessage || 'Unknown error'));
            };
            var params = {
                culture: settings.culture
            };

            that.service.getsync('GetLocalizationTable', params, success, failure);
            return worked;
        };

        this.getString = function (key) {
            var value = that.stringTable[key];
            if ((value || '').length == 0) {
                if (that.showMissingKeys) {
                    return '[L]{0}'.format(key);
                }

                return key;
            }
            return value;
        };
        this.loadTable();
		dnn.social.LocalizationControllerCache[settings.moduleRoot] = this;
    };
})(window.dnn);