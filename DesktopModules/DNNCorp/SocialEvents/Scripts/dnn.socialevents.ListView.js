// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.socialevents === 'undefined') dnn.socialevents = {};

(function(dnn, $, ko) {
    dnn.socialevents.ListView = function ListView() {
        dnn.social.ListView.apply(this, Array.prototype.slice.call(arguments));
        dnn.social.ipc.register(this.settings, $.proxy(function (source, message) {
            var selectedDate = message.selectedDate;
            var controller = this.listController();
            if (controller) {
                controller.frozen(true);
                this.category('all');
                var pager = this.pager();
                if (pager) pager.page(0);
                controller.selectedDate = selectedDate;
                controller.frozen(false);
                controller.loadStart();
            }
        }, this));
        this.register(this, 'PrimaryView');
        this.register(new dnn.socialevents.ListController($, ko, this.settings, this.social));
        this.register(new dnn.social.FocusController($, ko, this.settings, this.social, window.document, ['.idea-vote-options']));
        var pagingControl = this.social.getPagingControl('ListController');
        if (pagingControl) {
            pagingControl.page(this.settings.pageIndex || 0);
            this.register(pagingControl);
        }

        this.init();
    };

    try{
        dnn.socialevents.ListView.prototype = Object.create(dnn.social.ListView.prototype);
    } catch (ex) {
        location.reload();//avoid script load error when module injected from ajax panel call.
    }

    dnn.socialevents.ListView.prototype.init = function () {
        var self = this;
        this.sortOptions = [
            { value: 'eventstarttime', text: this.getString('SortByEventStartTime') },
            { value: 'lastactive', text: this.getString('SortByActivity') },
            { value: 'createddate', text: this.getString('SortByCreatedDate') },
            { value: 'title', text: this.getString('SortByTitle') },
            { value: 'views', text: this.getString('SortByViews') }
        ];
        
        dnn.social.ListView.prototype.init.apply(this);

        this.hideRsvp = function () {
            var $voteOptions = self.isMobileView() ? $('.dnnMobile-idea-vote-options') : $('.idea-vote-options');
            $voteOptions.each(
                function (index, element) {
                    if ($(element).is(':visible')) {
                        $(element).fadeOut();
                    }
                });
        };

        this.voteHandler = function (success) {
            if (success) {
                setTimeout(function () {
                    self.hideRsvp();
                }, 100);
            }
        };

        this.rsvp = function (socialEvent) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (socialEvent.invitationOnly() && socialEvent.rsvpStatus() == 0) return true;
            $('.idea-vote-options', self.settings.moduleScope).hide();
            var control = $('#rsvp-panel-{0}'.format(socialEvent.eventId()), self.settings.moduleScope);
            var visible = control.is(':visible');
            if (!visible) control.fadeIn();
            return false;
        };
        
        this.rsvpMobileView = function (socialEvent) {
            if (dnn.social.authorizationRequired(self.settings)) return true;
            if (socialEvent.invitationOnly() && socialEvent.rsvpStatus() == 0) return true;
            $('.dnnMobile-idea-vote-options', self.settings.moduleScope).hide();
            $('td.dnnMobileIdeaVote > a').removeClass('voting');

            var control = $('#dnnMobile-vote-panel-{0}'.format(socialEvent.eventId()), self.settings.moduleScope);
            if (!control.is(':visible')) {
                control.prev().addClass('voting');
                control.fadeIn();
            }
            return false;
        };
    };

    dnn.socialevents.ListView.prototype.validateCategory = function (c) {
        if (c === 'mycontentitems' || c === 'mycomments')
            return !dnn.social.authorizationRequired(this.settings);
        return true;
    };

    dnn.socialevents.ListView.prototype.windowsFocused = function () {
        if ($('.idea-vote-options').is(':visible')) {
            $('.idea-vote-options').fadeOut();
        }

        if ($('.dnnMobile-idea-vote-options').is(':visible')) {
            $('td.dnnMobileIdeaVote > a').removeClass('voting');
            $('.dnnMobile-idea-vote-options').fadeOut();
        }
    };
    
    dnn.socialevents.ListView.prototype.addDialog = function (query) {
        var dialog;

        var localizer = this.localizer();
        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: localizer.getString('CreateNewEvent'),
            minWidth: 800,
            closeOnEscape: false,
            resizable: false,
            open: function () {
	            if ($.ui.dialog.prototype.options.open) {
		            $.ui.dialog.prototype.options.open.apply(this, arguments);
	            }

	            $('.editor-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	            	var $input = $('#' + $(this).attr('id').replace('_tag', ''));
					if ($input.data('dnnTagInput')) {
						$(this).dnnResetAutosize($input.data('dnnTagInput'));
					}
	            });
                setTimeout(function(){
                    window.dnn.social.unbindEventsThatConflictWithJQueryDialog(dialog);
                },0);
            },
            close: $.ui.dialog.prototype.options.close,
        };
        var editModel = window.ko.contextFor($(this.settings.editId)[0]).$root;
        if (typeof query === 'string') {
            editModel.setSuggestedTitle(query);
        }
        editModel.switchTo(0);
        editModel.bindControls();
        dialog = $('.editor-dialog').dialog(options);
        return true;
    };
    
    dnn.socialevents.ListView.prototype.addDialogMobileView = function (query) {
        var localizer = this.localizer();
        var options = dnn.social.MobileView.dialogOptions({
            title: localizer.getString('CreateAnEvent')
        });
                
        $('.editor-dialog').dialog(options);
        $('.dnnFormPopup.dnnFormPopupMobileView').css({ 'width': options.width, left: '20px' });
              
        var editModel = window.ko.contextFor($(this.settings.editId)[0]).$root;
        if (editModel != null) {
            if (typeof query === 'string') {
                editModel.setSuggestedTitle(query);
            }
            editModel.switchTo(0, true);
            editModel.bindControls();
        }
         
        return true;
    };
    
})(window.dnn, window.jQuery, window.ko);
