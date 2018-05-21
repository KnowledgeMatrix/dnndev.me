// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

// Knockout
ko.bindingHandlers.visibleAnimation = {
    update: function (element, valueAccessor, allBindingsAccessor,
                viewModel, context) {
        var args = ko.utils.unwrapObservable(valueAccessor());
        var show = typeof (args.condition) === "function" ? args.condition() : args.condition;
        if (show) {
            if (args.effect) {
                $(element).show(args.effect, args.options || {});

            } else {
                $(element).show();
            }
        } else {
            if (args.effect) {
                $(element).hide(args.effect, args.options || {});
            } else {
                $(element).hide();
            }
        }
    }
};
ko.bindingHandlers.editableEmojiHtml = {
    init: function (element, valueAccessor) {
        $(element).on('blur', function () {
            var observable = valueAccessor();
            observable($(this).html());
        });
    },
    update: function (element, valueAccessor) {
        var value = ko.utils.unwrapObservable(valueAccessor());
        $(element).html(emojione.toImage(value));
    }
};

// emojiOne
emojione.imageType = 'png';
emojione.sprites = true;
emojione.ascii = true;
var customEmojiPanel = {
    instance: null,
    $emojiPanel: {},
    $emojiHeader: {},
    $emojiBody: {},
    $emojiCategories: {},
    callback: $.noop,
    closeCallback: $.noop,
    init: function () {
        var self = this;
        if (self.instance != null) {
            return self.instance;
        }

        self.$emojiPanel = $('#emojiPanel');
        self.$emojiHeader = $('#emojiHeader');
        self.$emojiBody = $('#emojiBody');
        var $categoryLinks = $('> a', self.$emojiHeader);
        $categoryLinks.first().addClass('selected');
        var $categoryBodys = $('> div', self.$emojiBody);
        $categoryBodys.first().show();
        $categoryLinks.on('click', function (e) {
            e.preventDefault();
            var $element = $(this);
            if ($element.hasClass('selected')) {
                return;
            }
            var target = $element.data('target');
            $categoryLinks.removeClass('selected');
            $categoryBodys.hide();
            $('> div#' + target, self.$emojiBody).show();
            $element.addClass('selected');
            return false;
        });
        $(' > span', $categoryBodys).on('click', function (e) {
            e.preventDefault();
            if (typeof (self.callback) !== "function") {
                return false;
            }
            var $element = $(this).find('span[title]');
            var emojiCode = $element.attr('title');
            self.callback(emojiCode);
            return false;
        });

        $('body').mouseup(function (e) {
            if (!self.$emojiPanel.is(e.target) // if the target of the click isn't the container...
                && self.$emojiPanel.has(e.target).length === 0) // ... nor a descendant of the container
            {
                var $target = $(e.target);
                if ($target.hasClass('actStr_addEmoji')) {
                    if ($target.parent().hasClass('selected')) {
                        return;
                    }
                }

                self.close();
            }

        });
    },
    close: function () {
        customEmojiPanel.$emojiPanel.hide();
        if (typeof (customEmojiPanel.closeCallback) === "function") {
            customEmojiPanel.closeCallback();
        }
    }
}