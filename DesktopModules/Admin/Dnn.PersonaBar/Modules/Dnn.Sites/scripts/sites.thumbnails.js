// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

﻿if (typeof dnn === "undefined" || dnn === null) { dnn = {}; };

define(['jquery', 'knockout', 'main/config'], function ($, ko, cf) {
    var config = cf.init();

    var siteThumbnails = function (options) {
        this.options = options;

    };


    var siteThumbnailsDefaultOptions = {
        delayTime: 500,
        requestDelayTime: 2000,
        requestTimeout: 4000,
        defaultThumbnail: 'fallback-thumbnail.png'
    };

    siteThumbnails.prototype = {
        constructor: siteThumbnails,

        init: function($panel) {
            this.options = $.extend({}, siteThumbnailsDefaultOptions, this.options);
            this.container = $panel;
            this.wrapper = $('.thumbnails-loader-wrapper');
            this._abort = false;

            $(document.body).on('thumbnailcreated', $.proxy(this._thumbnailCreated, this));
        },

        updateThumbnails: function () {
            if (!this.container.is(':visible')) {
                return;
            }

            var handler = this;
            var defaultName = this.options.defaultThumbnail;

            //if loading img, then ignore
            if (this.container.find('img[src$="' + defaultName + '"][class~="loading"]').length > 0) {
                return;
            }

            var $defaultImg = this.container.find('img[src$="' + defaultName + '"][class~="list"]')
								.filter(':not([class~="loading"])')
								.filter(':not([class~="failed"])')
								.filter(':not([class~="disabled"])').eq(0);

            if ($defaultImg.length == 0) {
                this.removeThumbnailLoader();
                return;
            }

            var $parent = $defaultImg.parent();
            var portalId = $parent.data('id');
            var portalUrl = $parent.data('url');
            if (typeof portalId === "number") {
                //ignore skin templates
                if (portalId < 0) {
                    $defaultImg.addClass('failed').parent().addClass('failed');

                    this.updateThumbnails();
                    return;
                }

                //if external url then doesn't create thumbnail.
                var protocol = portalUrl.indexOf('://');
                var checkUrl = portalUrl.substr(protocol > -1 ? protocol + 3 : 0);
                if (checkUrl.toLowerCase().indexOf(location.host) !== 0) {
                    $defaultImg.addClass('failed').parent().addClass('failed');

                    this.updateThumbnails();
                    return;
                }

                $defaultImg.addClass('loading');
                $defaultImg.parent().addClass('loading');

                var url = portalUrl
                    + (portalUrl.indexOf('?') === -1 ? '?' : '&')
                    + 'dnnprintmode=true&sitethumbnail=true&userid=' + config.userId;
                this._abort = false;
                $.get(url, function (data) {
                    if (handler._abort) {
                        return;
                    }
                    handler.removeThumbnailLoader();

                    var thumbnailLoader = $('<iframe class="thumbnail-loader"></iframe>');

                    thumbnailLoader.css({
                        width: $(window).width(),
                        height: $(window).height(),
                        zIndex: -1,
                        visibility: 'hidden'
                    });
                    thumbnailLoader.load($.proxy(handler._thumbnailLoaderLoaded, handler));
                    thumbnailLoader.data('listitem', $defaultImg.parent());
                    thumbnailLoader.attr('data-currentid', portalId);

                    handler.wrapper.append(thumbnailLoader);

                    var iframeDoc = thumbnailLoader[0].contentWindow.document;

                    var ie = (function(){

                        var undef,
                            v = 3,
                            div = document.createElement('div'),
                            all = div.getElementsByTagName('i');

                        while (
                            div.innerHTML = '<!--[if gt IE ' + (++v) + ']><i></i><![endif]-->',
                            all[0]
                        );

                        return v > 4 ? v : undef;

                    }());

                    if (ie && ie < 10) {
                        var wrapper = $('<div></div>');
                        wrapper.html(data);
                        wrapper.find('script').each(function() {
                            if ($(this).html() != '') {
                                $(this).attr('defer', 'defer');
                            }
                        });

                        data = wrapper.html();
                    }

                    var baseUrl = url;
                    if (baseUrl.indexOf('?') > -1) {
                        baseUrl = baseUrl.substr(0, baseUrl.indexOf('?'));
                    }

                    //replace anchor links to full url with base url, and update iframe's location info to base url.
                    //so that can avoid jquery tabs error.
                    data = data.replace(/href=(['"])#(.+?)\1/gi, "href=$1" + baseUrl + "#$2$1");
                    data = data.replace('</head>', '<base href="' + baseUrl + '" /><script type="text/javascript">if(window.history){ window.history.pushState({},"", "' + baseUrl + '");};</script></head>');

                    iframeDoc.write(data);
                    iframeDoc.close();

	                thumbnailLoader.data('contentloaded', true);
                }).fail(
                    function errorCallback(e){
                        $defaultImg.removeClass('loading');
                        $defaultImg.parent().removeClass('loading');
                        $defaultImg.addClass('failed').parent().addClass('failed');

                        setTimeout(function() {
                            handler.updateThumbnails();
                        }, 0);
                    }
                );
            };
        },

        _thumbnailCreated: function (e, data) {
            var $loader = this.wrapper.find('iframe[data-currentid=' + data.portalId + ']');
            var $listItem = $loader.data('listitem');
            if ($listItem) {
                $listItem.find('img.thumbnail')
                    .attr('src', data.thumbnails[2])
                    .removeClass('loading').parent().removeClass('loading');
            } else {
                this.wrapper.find('iframe.thumbnail-loader').data('listitem').find('img.thumbnail')
                    .attr('src', data.thumbnails[2])
                    .removeClass('loading').parent().removeClass('loading');
            }

            if (typeof this.options.onThumbnailCreated === "function") {
                this.options.onThumbnailCreated(data);
            }
            var handler = this;
            setTimeout(function() {
                handler.updateThumbnails();
            }, 0);
        },

        _thumbnailLoaderLoaded: function (e) {
            var loader = e.target;
            if (!$(loader).data('contentloaded') || !loader.contentWindow || !loader.contentWindow.document || !loader.contentWindow.document.body.innerHTML) {
                return;
            }

            var dnnPage = true;

            try {
            	var contentWindow = loader.contentWindow;
	            if (typeof contentWindow['dnn'] == "undefined" || typeof contentWindow['WebSiteThumbnailGenerator'] == "undefined") {
                    dnnPage = false;
                }
            } catch (e) {
                dnnPage = false;
            }

            if (!dnnPage) {
                var $listItem = $(e.target).data('listitem');
                $listItem.find('img.thumbnail').removeClass('loading').parent().removeClass('loading');
                $listItem.find('img.thumbnail').addClass('failed').parent().addClass('failed');

                this.removeThumbnailLoader();

				var handler = this;
				setTimeout(function() {
					handler.updateThumbnails();
				}, 0);
            }
        },

        removeThumbnailLoader: function () {
            this.wrapper.find('iframe').each(function () {
                var loader = $(this);
                $.removeData(loader);

                try {
                    var iframeDoc = loader[0].contentWindow.document;
                    iframeDoc.write('');
                    iframeDoc.close();
                } catch (ex) {
                    
                }
                
                loader.remove();
                loader = null;
            });

            this._abort = true;
        },

        _getVar: function (name) {
            var dnn = window != window.top ? window.top['dnn'] : window['dnn'];
            return dnn.getVar(name);
        }
    };

    return siteThumbnails;
});