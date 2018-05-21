(function () {
    dnn.social.initUserMentions = function initSocialUserMention($element, moduleId, moduleApiName, cleanHtmlOnPaste, redactor) {
        var servicesFramework = $.ServicesFramework(moduleId);
        var $parentElement = $element.parent();
        if ($parentElement.hasClass('redactor-box')) {
            $element = $('.redactor-editor[contenteditable="true"]', $parentElement);
        }
        if ($element.hasClass('ui-autocomplete-input')) {
            $element.mentionsInput('destroy');
        }
        var redactorInstance = redactor && redactor.data("redactor") ? redactor.data("redactor") : null; 
        moduleApiName = moduleApiName.replace(/\s/g, '');
        $element.mentionsInput({
            source: servicesFramework.getServiceRoot('DNNCorp/' + moduleApiName) + 'Social/GetAvailableUsersForMentioning',
            showAtCaret: true,
            redactor: redactorInstance
        });
        if (cleanHtmlOnPaste) {
            $element.on('paste', function (e) {
                var text = '';
                var that = $(this);

                if (e.clipboardData)
                    text = e.clipboardData.getData('text/plain');
                else if (window.clipboardData)
                    text = window.clipboardData.getData('Text');
                else if (e.originalEvent.clipboardData)
                    text = $('<div></div>').text(e.originalEvent.clipboardData.getData('text'));

                if (document.queryCommandSupported('insertText')) {
                    document.execCommand('insertHTML', false, $(text).html());
                    return false;
                }
                else { // IE > 7
                    that.find('*').each(function () {
                        $(this).addClass('within');
                    });

                    setTimeout(function () {
                        // nochmal alle durchlaufen
                        that.find('*').each(function () {
                            // wenn das element keine klasse 'within' hat, dann unwrap
                            // http://api.jquery.com/unwrap/
                            $(this).not('.within').contents().unwrap();
                        });
                    }, 1);
                }
            });
        }
    }

    ko.bindingHandlers.userMentions = {
        init: function (element, valueAccessor) {
            var args = ko.utils.unwrapObservable(valueAccessor());
            var $element = $(element);
            dnn.social.initUserMentions($element, args.moduleId, args.moduleApiName, true);
            $element.on('blur', function () {
                var observable = args.value;
                observable($(this).html());
            });

            $element.focus();
        },
        update: function (element, valueAccessor) {
            var args = ko.utils.unwrapObservable(valueAccessor());
            var value = args.value();
            var $container = $('<div/>');
            $container.append(value).find('font[color]').each(function () {
                var $this = $(this);
                $this.replaceWith($this.text());
            });
            $(element).html($container.html());
        }
    };
})()