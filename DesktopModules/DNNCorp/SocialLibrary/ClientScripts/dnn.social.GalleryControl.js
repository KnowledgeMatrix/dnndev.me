// DotNetNuke® - http://www.dotnetnuke.com
//
// Copyright (c) 2002-2013 DotNetNuke Corporation
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $) {
    'use strict';

    var defaultSettings = {
        size: 200,
        margin: 15,
        isMobile: false,
        count: 6
    };

    dnn.social.attachOwlCarousel = function (images) {
        
        var mobileDialog = $('#gallery-image-zoom-mobile');
        if (!mobileDialog.length) {
            mobileDialog = $('<div id="gallery-image-zoom-mobile"></div>');
            $('body').append(mobileDialog);
        }

        mobileDialog.empty();
        $.each(images, function (n, v) {
            var m = $('<div class="item"><img class="lazyOwl" data-src="' + v.href + '" /></div>');
            mobileDialog.append(m);
        });

        var scrollTop = $('body').scrollTop();

        mobileDialog.dialog(dnn.social.MobileView.dialogOptions()).css({
            'margin': 0,
            'border-radius': 0
        }).prev().hide().parent().css({
            'padding': 0,
            'border-radius': 0
        });

        var closeOwlCarousel = function () {
            $('html').css({ background: 'inherit' });
            mobileDialog.dialog('close');
            var owl = mobileDialog.data('owlCarousel');
            if (owl) owl.destroy();
            mobileDialog.remove();
            $('body').scrollTop(scrollTop);
        };
        
        setTimeout(function () {
            mobileDialog.owlCarousel({
                navigation: false,
                autoHeight: true,
                lazyLoad: true,
                singleItem: true,
                startDragging: function () {
                    $('html').off('click', closeOwlCarousel);
                    mobileDialog.find('img').off('click', closeOwlCarousel);
                }
            });
            
            mobileDialog.append('<div class="gallery-bottom"><a>CLOSE</a></div>');
            mobileDialog.find('.gallery-bottom > a').off('click').on('click', closeOwlCarousel);

        }, 200);
       
        mobileDialog.on('click', function (e) {
            e.stopPropagation();
            return false;
        });

        $('html').css({ background: 'rgba(0,0,0,0.65)' });
    };

    dnn.social.attachPhotoLightbox = function (images, startIndex) {
        $(document).off('keydown');
        if (!images || !(images instanceof Array) || !images.length || images.length < startIndex) return;
        var imageUrl = images[startIndex].href;
        var img = $('<img />');
        img.attr('src', imageUrl).load(function () {
            var picRealWidth = this.width;
            var picRealHeight = this.height;
            var viewportWidth = Math.max(document.documentElement.clientWidth, window.innerWidth || 0) - 80;
            var viewportHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0) - 80;
            if (viewportWidth > 1024) viewportWidth = 1024;
            if (viewportHeight > 768) viewportHeight = 768;
            if (picRealWidth > picRealHeight) {
                if (picRealWidth > viewportWidth) {
                    picRealHeight = Math.round(picRealHeight / picRealWidth * viewportWidth);
                    picRealWidth = viewportWidth;
                    img.css({
                        'width': picRealWidth,
                        'height': picRealHeight
                    });
                }
            } else {
                if (picRealHeight > viewportHeight) {
                    picRealWidth = Math.round(picRealWidth / picRealHeight * viewportHeight);
                    picRealHeight = viewportHeight;
                    img.css({
                        'width': picRealWidth,
                        'height': picRealHeight
                    });
                }
            }

            var dialog = $('#gallery-image-zoom');
            if (!dialog.length) {
                dialog = $('<div id="gallery-image-zoom"></div>');
                $('body').append(dialog);
            }

            dialog.empty().append(img).dialog({
                width: 'auto',
                height: 'auto',
                modal: true,
                draggable: false,
                resizable: false,
                closeOnEscape: false,
                dialogClass: 'dnnFormPopup'
            }).css({
                'margin': 0,
                'border-radius': 0,
                'min-height': 1
            }).prev()
            .css({
                margin: 0,
                padding: 0,
                height: 0
            }).show()
            .find('button')
            .css({
                top: -10,
                right: -10,
                backgroundColor: '#333',
                zIndex: 10000,
                outline: 'none'
            }).off('click').on('click', function () {
                dialog.dialog('close');
                $(document).off('keydown');
            }).parent().parent()
            .css({
                'padding': 0,
                'border-radius': 0
            });

            var navigation = dialog.parent().find('div.evoq-gallery-navigation');
            if (!navigation.length) {
                navigation = $('<div class="evoq-gallery-navigation"></div>');
                dialog.parent().append(navigation);
            }
            navigation.empty();

            if (images.length > 1) {
                var leftArrow = $('<a class="evoq-gallery-navigation-left"><</a>');
                var rightArrow = $('<a class="evoq-gallery-navigation-right">></a>');
                var navLabel = $('<span>' + (startIndex + 1) + ' of ' + images.length + '</span>');

                navigation.append(leftArrow).append(rightArrow).append(navLabel);

                if (startIndex == 0) leftArrow.hide();
                if (startIndex == images.length - 1) rightArrow.hide();

                leftArrow.on('click', function () {
                    if(startIndex -1  > -1) dnn.social.attachPhotoLightbox(images, startIndex - 1);
                    return false;
                });

                rightArrow.on('click', function () {
                    if(startIndex + 1 < images.length) dnn.social.attachPhotoLightbox(images, startIndex + 1);
                    return false;
                });

                $(document).on('keydown', function(e) {
                    if (e.keyCode == 37) { // left
                        leftArrow.trigger('click');
                    } else if (e.keyCode == 39) { // right
                        rightArrow.trigger('click');
                    }
                });
            }

            $('.ui-widget-overlay').unbind('click').bind('click', function() {
                dialog.dialog('close');
                $(document).off('keydown');
            });
           
        });
    };

    dnn.social.initGalleryControl = function(scopeElement, settings) {
        if (scopeElement.data('images')) return;
        dnn.social.reinitGalleryControl(scopeElement, settings);
    };
    
    dnn.social.reinitGalleryControl = function (scopeElement, settings) {
        settings = $.extend(defaultSettings, settings);
        var images = [];
        if (!scopeElement.data('images')) {
            var links = scopeElement.find('a');
            links.each(function() {
                var href = $(this).attr('href');
                var dataThumb = $(this).attr('data-thumb');
                if (href) images.push({
                    href: href,
                    dataThumb: dataThumb ? dataThumb : href
                });
            });
        } else {
            images = scopeElement.data('images');
        }
        scopeElement.empty();
        var count = settings.isMobile ? 1 : Math.min(settings.count, images.length);
        var scopeContainer = $('<div class="evoq-gallery-container"></div>');
        for (var i = 0; i < count; i++) {
            var image = images[i];
            var imageElement = $('<div class="evoq-gallery-thumbnail"><a href="' + image.href + '"><img src="' + image.dataThumb + '" /></a></div>');
            scopeContainer.append(imageElement);
            imageElement.css({
                width: settings.isMobile ? '100%' : settings.size,
                marginRight: settings.isMobile ? 0 : settings.margin,
                marginBottom: settings.isMobile ? 0 : settings.margin
            });
        }
        scopeElement.append(scopeContainer);

        scopeElement.append($('<div class="dnnClear"></div>'));
        if (count < images.length) {
            var footer = $('<a href="javascript:void(0)" class="evoq-gallery-footer">' + (images.length - count) + ' more images</a>');
            scopeElement.append(footer);
            scopeElement.append($('<div class="dnnClear"></div>'));
        }

        scopeElement.find('a').each(function(index) {
            $(this).on('click', function () {
                if (settings.isMobile)
                    dnn.social.attachOwlCarousel(images);
                else
                    dnn.social.attachPhotoLightbox(images, index);
                
                return false;
            });
        });
         
        scopeElement.addClass('evoq-gallery-control').show().data('images', images);
        if (!settings.isMobile) {
            scopeContainer.imagesLoaded(function() {
                scopeContainer.masonry({
                    columnWidth: settings.size + settings.margin,
                    itemSelector: '.evoq-gallery-thumbnail'
                });
            });
        }
    };
})(window.dnn, window.jQuery);