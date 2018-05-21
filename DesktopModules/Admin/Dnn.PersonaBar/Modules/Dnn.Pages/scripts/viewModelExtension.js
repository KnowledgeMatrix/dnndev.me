define(['jquery', 'knockout'], function ($, ko) {
    'use strict';

    var delayTime = 500;

    function _mouseOverThumbnailHandler(pageData, e) {
        if (this._showPreviewTimeoutHandler) {
            clearTimeout(this._showPreviewTimeoutHandler);
        }

        if (pageData.pageType === "normal") {
            
            this._showPreviewTimeoutHandler = setTimeout(
                $.proxy(_showPreview, this, pageData, e.target), delayTime);
        }
    }

    function _mouseOutThumbnailHandler () {
        if (this._showPreviewTimeoutHandler) {
            clearTimeout(this._showPreviewTimeoutHandler);
        }

        _hidePreview(this._previewContainer, this._mouseOnPreview);
    }

    function _showPreview(pageData, element) {
        var handler = this;

        if (!this._previewContainer) {
            this._previewContainer = $('<div class="pages-preview"><img src="" /></div>');
            this._previewContainer.mouseenter(function () {
                handler._mouseOnPreview = true;
            }).mouseleave(function (e) {
                handler._mouseOnPreview = false;
                _hidePreview(this._previewContainer, handler._mouseOnPreview);
            });
            $(document.body).append(this._previewContainer);
        }
        this._previewContainer.find('img').attr('src', pageData.largeThumbnail);

        _calcPreviewPosition(element, this._previewContainer);

        this._previewContainer.show('fast');
    }

    function _hidePreview(previewContainer, mouseOnPreview) {
        if (previewContainer && !mouseOnPreview) {
            previewContainer.hide('fast');
        }
    }

    function _calcPreviewPosition(element, previewContainer) {
        var pos, $element, previewHeight, elementWidth, elementHeight, windowHeight, offset;

        pos = {};
        $element = $(element);
        previewHeight = previewContainer.outerHeight();
        elementWidth = $element.width();
        elementHeight = $element.height();
        windowHeight = $(window).height();
        offset = $element.offset();

        pos.left = offset.left + elementWidth - 25;
        pos.top = offset.top - previewHeight / 2 + elementHeight / 2;

        if (pos.top < 0) {
            previewContainer.removeClass('bottom').addClass('top');
            pos.top = $element.offset().top;
        }else if (pos.top + previewHeight > windowHeight) {
            previewContainer.removeClass('top').addClass('bottom');
            pos.top = offset.top - previewHeight + elementHeight;
        } else {
            previewContainer.removeClass('top bottom');
        }

        previewContainer.css({
            left: pos.left,
            top: pos.top
        });
    }

    function changeView(view) {
        switch (view) {
            case "listView":
                dnn.pages.pageHierarchyManager._viewModel.inDrag(true);
                break;
            case "cardView":
                dnn.pages.pageHierarchyManager._viewModel.inDrag(false);
                break;
        }
    }
     
    var viewModel = {
        changeView: changeView,
        mouseOverThumbnail: _mouseOverThumbnailHandler,
        mouseOutThumbnail: _mouseOutThumbnailHandler
    };
    
    return viewModel;
});