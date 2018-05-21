// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $, ko) {
    'use strict';
    
    dnn.social.loading = function (scopeWrapperClientId, callback) {
        var parent = document.getElementById(scopeWrapperClientId);
        if (parent && parent.offsetWidth > 600) {
            var normalView = parent.getElementsByClassName('moduleContainer-normalView');
            if(normalView && normalView.length > 0)
                normalView[0].style.display = 'block';
        }
        if (typeof callback === 'function') callback();
    };

    dnn.social.loaded = function(scopeWrapperClientId) {
        $('#' + scopeWrapperClientId + ' .static-row').remove();
        $('#' + scopeWrapperClientId + ' .ko-container').removeClass('ko-container');
    };

    dnn.social.guid = function() {
        var s4 = function() {
            return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
        };
        return (s4() + s4() + "-" + s4() + "-4" + s4().substr(0, 3) + "-" + s4() + "-" + s4() + s4() + s4()).toLowerCase();
    };
    
    var koQueue = 0,
        koCallback = [];
    dnn.social.koQueue = {
        registerCallback: function (callback) {
            if (typeof callback === 'function') {
                koCallback.push(callback);
            }
        },
        invokeCallback: function() {
            if (koQueue === 0) {
                for (var i = 0; i < koCallback.length; i++) {
                    koCallback[i]();
                }
                koCallback = [];
            }
        },
        push: function() {
            koQueue++;
        },
        pop: function () {
            if(koQueue > 0) koQueue--;
            dnn.social.koQueue.invokeCallback();
        }
    };

    dnn.social.applyBindings = function (viewModel, moduleScope) {
        if (!moduleScope || !viewModel) return;
        if (typeof viewModel.binded === 'function') {
            dnn.social.koQueue.registerCallback(function () {
                setTimeout($.proxy(viewModel.binded, viewModel), 0);
            });
        }

        try {
            ko.applyBindings(viewModel, moduleScope);
        } catch (ex) {
            
        }
        dnn.social.koQueue.invokeCallback();
    };

    var supportedRgba = null;
    dnn.social.supportedRGBA = function () {
        if (supportedRgba == null) {
            var scriptElement = document.getElementsByTagName('script')[0];
            var prevColor = scriptElement.style.color;
            var testColor = 'rgba(0, 0, 0, 0.5)';
            if (prevColor == testColor) {
                supportedRgba = true;
            }
            else {
                try {
                    scriptElement.style.color = testColor;
                } catch (e) { }
                supportedRgba = scriptElement.style.color != prevColor;
                scriptElement.style.color = prevColor;
            }
        }
        return supportedRgba;
    };

    dnn.social.flashOnElement = function (element, color, fallbackColor) {        
        if (dnn.social.supportedRGBA()) {
            color = color.join(',') + ',';
            var transparency = 1,
            timeout = setInterval(function () {
                if (transparency >= 0) {
                    element.style.backgroundColor = 'rgba(' + color + (transparency -= 0.015) + ')';
                } else {
                    clearInterval(timeout);
                }
            }, 40); 
        } else { 
            element.style.backgroundColor = fallbackColor;
            setTimeout(function () {
                element.style.backgroundColor = 'transparent';
            }, 1000);
        }
    };

    dnn.social.EventQueue = {
        push: function (action) {
            return setTimeout(action, 0);
        },
        cancel: function (action) {
            clearTimeout(action);
        }
    };

    dnn.social.authorizationRequired = function (settings) {
        if (settings.anonymous) {
            if (settings.usePopup) {
                window.dnnModal.show(settings.authorizationUrl + '&popUp=true', true, 300, 650, true, '');
            }
            else {
                window.location = settings.authorizationUrl;
            }
            return true;
        }
        return false;
    };
    
    dnn.social.komodel = function (model) {
        var obj = {};

        if (typeof (model) !== 'undefined') {
            var convert =
                function (key, value) {
                    var k = dnn.social.toCamelCase(key);

                    if (value === null || typeof (value) === 'undefined') {
                        obj[k] = ko.observable();
                    } else if (value instanceof Array) {
                        var list = [];

                        $.each(value,
                            function (index, element) {
                                list.push(dnn.social.komodel(element));
                            });

                        obj[k] = ko.observableArray(list);
                    } else {
                        obj[k] = ko.observable(value);
                    }
                };

            if (model != null) {
                switch (typeof(model)) {
                    case 'undefined':
                        break;
                    case 'string':
                    case 'number':
                        obj = model;
                        break;
                    case 'object':
                        var keys = Object.keys(model);

                        $.each(keys,
                            function (unused, key) {
                                convert(key, model[key]);
                            });
                        
                        break;
                    case 'array':
                        obj = ko.observableArray(model);
                        break;
                    default:
                        console.log('Unknown object type ({0})'.format(typeof (model)));
                        break;
                }
            }
        }

        return obj;
    };

    dnn.social.toCamelCase = function (key) {
        if (typeof key === 'number') {
            return key;
        }
        
        var k = key[0].toLowerCase();

        if (key.length > 1) {
            return k + key.substr(1);
        }

        return k;
    };

    dnn.social.decodeHtml = function (s) {
        if ((s || new String()).length == 0) {
            return s;
        }

        return $('<div />').html(s.replace(/<br([ \/>]+)(<[ \/]+br>)?/g, "\n")).text();
    };

    dnn.social.toDateFromDotNetJson = function(dotNetDateJson) {
        if (typeof dotNetDateJson === 'string') {
            if (dotNetDateJson.length > 6) {
                try {
                    var src = parseInt(dotNetDateJson.substr(6));
                    return new Date(src);
                } catch(e) {
                }
            }
        }
        return new Date();
    };
    
    dnn.social.setControlCursor = function (control, offset) {
        control.focus();
        var input = $(control)[0];
        if (input.createTextRange) {
            var range = input.createTextRange();
            range.collapse(true);
            range.moveEnd('character', offset);
            range.moveStart('character', offset);
            range.select();
        } else if (input.setSelectionRange) {
            input.setSelectionRange(offset, offset);
        }

        input.focus();
    };

    dnn.social.notImplemented = function () {
        var localizer = social.getLocalizationController();
        $.dnnAlert({
            title: localizer.getString('NotImplementedTitle'),
            text: localizer.getString('NotImplementedBody')
        });
    };

    var setRedactorResources = function (culture, resxRedactor, module)
    {
        var DEFAULT_LANG_IN_REDACTOR = 'en';
        if (culture && Object.keys(resxRedactor).length > 0) {
            $.dnnRedactor.opts.langs[culture] = $.dnnRedactor.opts.langs[culture] || {};

            if (Object.keys($.dnnRedactor.opts.langs[culture]).length === 0){
                $.extend($.dnnRedactor.opts.langs[culture], 
                    $.dnnRedactor.opts.langs[DEFAULT_LANG_IN_REDACTOR]);
            }

            $.extend($.dnnRedactor.opts.langs[culture], resxRedactor);
            $.dnnRedactor.opts.lang = culture;
        }
    };


    dnn.social.unbindEventsThatConflictWithJQueryDialog = function unbindEventsThatConflictWithJQueryDialogHandler(dialog){
        var eventNamespace = "";

        if (dialog && dialog.data() && dialog.data().uiDialog) {
            eventNamespace = dialog.data().uiDialog.eventNamespace;
        }
        
        $(document).off("focusin" + eventNamespace);
    };

    dnn.social.initRedactor = function initRedactorHandler(module, options, editorMode, mobileView, serviceRoot, editorSettings, initCallback)
    {
        dnn.social.loadRedactorResources(module,
            function (culture) {
                var redactorOptions = options || dnn.social.redactorOptions(editorMode, mobileView, serviceRoot, editorSettings);

                redactorOptions.modalOpenedCallback = function(){
                    if (window.jQuery && window.jQuery.ui.dialog) {
                        $(document).unbind("focusin");
                    }
                };

                if (!redactorOptions.initCallback) {
                    redactorOptions.initCallback = function () {
                        var $dialog = this.$editor.closest('.ui-dialog').find('.ui-dialog-content');
                        if ($dialog.data('ui-dialog')) {
                            var position = $dialog.dialog('option', 'position');
                            $dialog.dialog('option', 'position', position);
                        }
                    };
                }

                redactorOptions.lang = culture;
                var redactor = module.dnnRedactor(redactorOptions);
                if (typeof initCallback == "function"){
                    initCallback(redactor);
                }
            });
    };

    dnn.social.loadRedactorResources = function loadRedactorResourcesHandler(module, loadCallback) {
        var localizationOptionsRedactor;
        // Get redactor and plugins localization
        if (!window.dnn.social.resx || !window.dnn.social.resx.redactor) {
            window.dnn.social.resx = window.dnn.social.resx || {};
            window.dnn.social.resx.redactor = true;
            localizationOptionsRedactor = {
                service: 'DNNCorp/EvoqLibrary',
                controller: 'Localization',
                resxName: 'RedactorResx',
                resourceSettings: {
                    method: 'GetRedactorSettings',
                    callback200: function(data) {
                        if (!window.dnn.social.resx.culture) {
                            window.dnn.social.resx.culture = data.culture;
                        }
                    }
                },
                resources: {
                    method: 'GetRedactor',
                    paramName: 'localization',
                    callback200: function(data) {
                        window.dnn.social.resx.redactor = data.localization;
                        window.dnn.social.resx.culture = window.dnn.social.resx.culture || 'en';
                        setRedactorResources(window.dnn.social.resx.culture, window.dnn.social.resx.redactor, module);
                        loadCallback(window.dnn.social.resx.culture);
                    },
                    callbackError: function(data) { console.log('Error', data); }
                }
            };

            new dnn.utils.Localization(localizationOptionsRedactor);
        } else {
            setRedactorResources(window.dnn.social.resx.culture, window.dnn.social.resx.redactor, module);
            loadCallback(window.dnn.social.resx.culture);
        }
    };

    dnn.social.redactorOptions = function(editorMode, mobileView, serviceRoot, settings) {
        var redactorOptions;
        var ie8 = $('body').hasClass('IE8');
        var deniedTags = ['html', 'head', 'link', 'body', 'meta', 'style', 'applet', 'input', 'select', 'form', 'h1'];
        if (ie8 || editorMode.toLowerCase() != 'rich') {
            redactorOptions = {
                shortcuts: [],
                toolbar: false,
                paragraphy: false,
                convertDivs: false,
                linebreaks: false,
                tabFocus: false,
                allowImageEditor: false
            };
            
            // for ie8 and non rich text editor, we deny most of tags
            deniedTags.push('h2');
            deniedTags.push('h3');
            deniedTags.push('h4');
            deniedTags.push('h5');
            deniedTags.push('iframe');
            deniedTags.push('script');
            deniedTags.push('object');
            deniedTags.push('embed');
        }
        else {
            var antiForgeryToken = $('input[name="__RequestVerificationToken"]').val();
            var uploadUrl = serviceRoot + 'postimages?__RequestVerificationToken=' + antiForgeryToken;
            var buttons = settings.toolbar.split(',');
            if (mobileView) buttons = ["bold","italic","|","unorderedlist","orderedlist","outdent","indent","|","image"];
            var allowIframe = settings.allowIframe;
            var allowScript = settings.allowScript;
            var allowEmbed = settings.allowEmbed;
            
            redactorOptions = {
                shortcuts: [],
                buttons: buttons,
                imageUpload: uploadUrl,
                imageGetJson: serviceRoot + 'getimages'
            };
            
            if (buttons.indexOf('formatting') > -1) {
                redactorOptions.formatting = ['p', 'blockquote', 'pre', 'h2', 'h3', 'h4', 'h5'];
            } else {
                // non formatting options we does not allow h2 - h5
                deniedTags.push('h2');
                deniedTags.push('h3');
                deniedTags.push('h4');
                deniedTags.push('h5');
            }

            if (!allowIframe) deniedTags.push('iframe');
            if (!allowScript) deniedTags.push('script');
            if (!allowEmbed) {
                deniedTags.push('object');
                deniedTags.push('embed');
            }
        }
        
        redactorOptions.deniedTags = deniedTags;
        redactorOptions.allowImageEditor = !mobileView;
        redactorOptions.plugins = ['dnnImageUpload'];
        redactorOptions.buttonsHide = ['image'];
        
        redactorOptions.imageTypes = ['image/png', 'image/jpeg', 'image/gif', 'image/bmp'];

        return redactorOptions;
    };
    
    dnn.social.topLevelExceptionHandler = function (settings, ex) {
        $.dnnAlert({
            title: 'Fatal error',
            text: 'A fatal error has occurred.'
        });

        throw ex;
    };

    dnn.social.generateFullUrl = function(path) {
        var url = window.location.href;
        var arr = url.split("/");
        return arr[0] + "//" + arr[2] + (window.location.port ? ':' + window.location.port : '') + path;
    };

    dnn.social.socialNetworks = {
        "Facebook": "Facebook",
        "LinkedIn": "LinkedIn",
        "Twitter": "Twitter",
        "Google": "Google+"
    };

    dnn.social.ipc = {
        register: function (settings, receiver) {
            if (!settings.moduleRoot) return this;
            if (typeof receiver !== 'function') return this;
            var moduleRoot = settings.moduleRoot;
            $(window).on(moduleRoot, function (e, params) {
                if (params) receiver(params.source, params.message);
            });
            return this;
        },
        post: function (settings, moduleFolder, message) {
            if (!moduleFolder) return this;
            $(window).trigger(moduleFolder, [{ source: settings, message: message }]);
            return this;
        }
    };

    dnn.social.loadScript = function (url, callback) {
        if ($('script').filter(function() {
            return ($(this).attr('scr') == url);
        }).length == 0) {
            $.ajax({
                url: url,
                dataType: 'script',
                success: callback,
                async: true
            });
        }
    };

    dnn.social.loadCss = function (url) {
        if ($('link').filter(function() {
            return ($(this).attr('rel') == 'stylesheet' && $(this).attr('type') == 'text/css' && $(this).attr('href') == url);
        }).length == 0) {
            var cssLink = $("<link rel='stylesheet' type='text/css' href='" + url + "'>");
            $("head").append(cssLink);
        }
    };

    dnn.social.asyncParallel = function (deferreds, callback) {
        if (!deferreds) {
            callback();
            return;
        }
        var i = deferreds.length;
        if (i === 0) callback();
        var call = function() {
            i--;
            if (i === 0) {
                callback();
            }
        };

        $.each(deferreds, function(ii, d) {
            d(call);
        });
    };

    dnn.social.asyncWaterfall = function (deferreds, callback) {
        if (!deferreds) {
            callback();
            return;
        }
        var call = function() {
            var deferred = deferreds.shift();
            if (!deferred) {
                callback();
                return;
            }
            deferred(call);
        };
        call();
    };

    dnn.social.htmlDecode = function (text) {
        if (!text) return '';
        var rgx =  /<br\s*[\/]?>/gi;
        text = text.replace(rgx, "\n");
        return $('<div/>').html(text).text();
    };
    
    // jquery ui dialog position center fix -- removed it after 7.3.3
    if ($ && $.ui && $.ui.dialog) {
        $.ui.dialog.prototype.options.open = function() {
            var htmlElement = $(document).find('html');
            htmlElement.css('overflow', 'hidden');
            var cacheScrollTop = htmlElement.find('body').scrollTop();
            if (cacheScrollTop > 0) {
                htmlElement.scrollTop(0);
                var target = $(this);
                target.data('cacheScrollTop', cacheScrollTop);
            }
            
            var uiDialog = $(this).closest('.ui-dialog');
            if (!$('html').hasClass('mobileView')) {
                var maxHeight = $(window).height();
                var dialogHeight = uiDialog.outerHeight();
                var $dialog = uiDialog.find('.ui-dialog-content');
                if (maxHeight - 20 < dialogHeight && $dialog.data('ui-dialog')) {
                    $dialog.dialog('option', 'position', { my: "center top", at: "top", of: window });
                    uiDialog.css({
                        maxHeight: (maxHeight - 20) + 'px',
                        overflow: 'auto'
                    });
                }
            } 
        };
        $.ui.dialog.prototype.options.beforeClose = function () {
            var htmlElement = $(document).find('html');
            htmlElement.css('overflow', '');
            var cacheScrollTop = $(this).data('cacheScrollTop');
            if (cacheScrollTop) {
                htmlElement.find('body').scrollTop(cacheScrollTop);
                $(this).data('cacheScrollTop', null);
            }
            var uiDialog = $(this).closest('.ui-dialog');
            uiDialog.css({ overflow: 'initial' });
        };
    }

    dnn.social.attachFileUploaded = function (callback) {
        if (!window.dnn.dnnFileUpload) return;
        window.dnn.dnnFileUpload.Files_Changed = function(node, sender) {
            var settings = window.dnn.dnnFileUpload.getSettings(sender);
            if (!settings) return;

            if (node) {
                var fileId = node.key;
                var service = $.dnnSF();
                var url = service.getServiceRoot('internalservices') + 'fileupload/loadimage';
                if (fileId) {
                    $.ajax({
                        url: url,
                        type: 'GET',
                        data: { fileId: fileId },
                        success: function (d) {
                            if (!d) {
                                $('#' + settings.dropZoneId + ' img').remove();
                                return;
                            }
                            var img = new Image();
                            $(img).load(function() {
                                $('#' + settings.dropZoneId + ' img').remove();
                                $(img).css({ 'max-width': 180, 'max-height': 150 }).insertBefore($('#' + settings.dropZoneId + ' span'));
                            });
                            img.src = d;
                        },
                        error: function() {
                        }
                    });
                    var numberFileId = parseInt(fileId, 10);
                    if (typeof callback === 'function') callback(settings, numberFileId, node.value);
                } else
                    $('#' + settings.dropZoneId + ' img').remove();
            }
        };
    };

    dnn.social.getCookieValueByName = function getCookieValueByNameHandler(name) {
        var value = "; " + document.cookie;
        var parts = value.split("; " + name + "=");
        if (parts.length == 2)
            return parts.pop().split(";").shift();

        return null;
    };

    // custom bindings
    ko.bindingHandlers.slideVisible = {
        init: function (element, valueAccessor) {
            var value = valueAccessor();

            if (ko.utils.unwrapObservable(value)) {
                $(element).show();
            } else {
                $(element).hide();
            }
        },
        update: function (element, valueAccessor) {
            var value = valueAccessor();

            if (ko.utils.unwrapObservable(value)) {
                $(element).slideDown('fast',
                    function () {
                        var textarea = $('textarea:visible', $(element));
                        if (textarea.length > 0) {
                            $('html body').scrollTop($(textarea)[0].offsetTop);

                            dnn.social.EventQueue.push(
                                function () {
                                    $(textarea).focus();
                                });
                        }
                    });
            } else {
                $(element).hide();
            }
        }
    };

    ko.bindingHandlers.fadeVisible = {
        init: function (element, valueAccessor) {
            var value = valueAccessor();

            if (ko.utils.unwrapObservable(value)) {
                $(element).show();
            } else {
                $(element).hide();
            }
        },
        update: function (element, valueAccessor) {
            var value = valueAccessor();

            if (ko.utils.unwrapObservable(value)) {
                $(element).fadeIn('fast');
            } else {
                $(element).hide();
            }
        }
    };

    ko.bindingHandlers.stopBindings = {
        init: function () {
            return { controlsDescendantBindings: true };
        }
    };

    ko.bindingHandlers.escapeKey = {
        init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
            var allBindings = allBindingsAccessor();
            var handler = function (event) {
                var keyCode = event.which ? event.which : event.keyCode;
                if (keyCode === 27) {
                    allBindings.escapeKey.call(viewModel);
                    return false;
                }
                return true;
            };
            $(element).keydown(handler);
        }
    };

    ko.bindingHandlers.enterKey = {
        init: function (element, valueAccessor, allBindingsAccessor, viewModel) {
            var allBindings = allBindingsAccessor();
            var handler = function (event) {
                var keyCode = event.which ? event.which : event.keyCode;
                if (keyCode === 10 || keyCode == 13) {
                    if (event.shiftKey) {
                        return true;
                    }
                    allBindings.enterKey.call(viewModel);
                    return false;
                }
                return true;
            };
            $(element).keydown(handler);
        }
    };
    
})(window.dnn, window.jQuery, window.ko);

(function($) {
    $.dnnContentNotFoundAlert = function(localizer, status) {
        $.dnnAlert({
            title: localizer.getString('Error'),
            text: localizer.getString('ItemNotFound').format(status || localizer.getString('UnknownError'))
        });
    };

    $.dnnRevisionChangePrompt = function(localizer, callback) {
        $.dnnConfirm({
            text: localizer.getString('ChangedByOther_Desc'),
            yesText: localizer.getString('ButtonYesSave'),
            noText: localizer.getString('ButtonNoDiscard'),
            title: localizer.getString('ChangedByOther_Title'),
            callbackTrue: function() {
                if ($.isFunction(callback)) {
                    callback();
                }
            }
        });
    };
})(jQuery);
