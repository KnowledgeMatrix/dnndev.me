// DotNetNuke® - http://www.dotnetnuke.com
//
// Copyright (c) 2002-2013 DotNetNuke Corporation
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function(dnn, $, ko) {
    'use strict';

    // common detail viewmodel
    dnn.social.DetailView = function(settings, model) {
        this.settings = settings;
        this.moduleScope = settings.moduleScope;
        this.dataModel = model;
        this.social = new dnn.social.Module(settings);
        this.rootUrl = this.social.getService('Social').getRoot();
        this.componentFactory = this.social.getComponentFactory();
    };

    dnn.social.DetailView.prototype.init = function() {
        // common ipc registration
        var self = this;
        dnn.social.ipc.register(self.settings,
          function (source, message) {
              if (!message || !message.event) return;
              switch (message.event) {
                  case 'RefreshCommentCount':
                      if (typeof self.commentCount == 'function')
                          self.commentCount(message.count);
                      break;
              }
          });
        
        // responsive screen detect
        $('.loading-container', this.settings.moduleScope).removeClass('loading');
        dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);
        
        // attachments
        this.attachmentsHtml = ko.observable('');
        this.attachmentsHtmlMobileView = ko.observable('');
        this.hideAttachments = ko.observable(true);
        this.hideAttachmentsMobileView = ko.observable(true);
        this.showToggleAttachments = ko.observable(false);
        this.removeAttachment = function(data) {
            var fileId = data.fileId();
            var fileName = data.fileName();
            $.dnnConfirm({
                text: 'Do you want to remove ' + fileName + '?',
                callbackTrue: function () {
                    var service = self.social.getService('Edit');
                    var params = {
                        fileId: fileId,
                        contentItemId: self.model.contentItemId()
                    };
                    var failure = function (xhr, status) {
                        $.dnnContentNotFoundAlert(self.localizer(), status);
                    };
                    var success = function() {
                        var attachments = self.model.attachments();
                        var index = -1;
                        $.each(attachments, function (i, v) {
                            if (v.fileId() === fileId) {
                                index = i;
                                return false;
                            }
                            return true;
                        });
                        if (index > -1) {
                            attachments.splice(index, 1);
                            self.model.attachments(attachments);
                            self.initAttachments(true);
                            
                            // notify edit dialog to update its attachments
                            dnn.social.ipc.post(self.settings, self.settings.moduleRoot, {
                                event: 'RemoveAttachment',
                                attachments: attachments
                            });
                        }
                    };
                    service.post('RemoveAttachment', params, success, failure);
                }
            });
        };
    };

    dnn.social.DetailView.prototype.register = function(obj, key) {
        this.componentFactory.register(obj, key);
    };

    dnn.social.DetailView.prototype.pager = function() {
        return this.componentFactory.resolve('PagingControl');
    };
    
    dnn.social.DetailView.prototype.localizer = function () {
        return this.social.getLocalizationController();
    };
    
    dnn.social.DetailView.prototype.getString = function (key) {
        var localizer = this.localizer();
        return localizer ? localizer.getString(key) : key;
    };

    dnn.social.DetailView.prototype.edit = function () {
        var self = this;
        if (dnn.social.authorizationRequired(self.settings)) {
            return true;
        }

        var failure = function (xhr, status) {
            $.dnnContentNotFoundAlert(self.localizer(), status);
        };

        var success = function (revision) {
            if (self.model.revisionSequence() != revision.sequence) {
                self.model.revisionSequence(revision.sequence);
            }
            self.model.content(revision.latestContent);
            if(typeof self.continueEdit == 'function') self.continueEdit();
        };

        var params = typeof self.getEditParams === 'function' ? self.getEditParams() : {
            contentItemId: self.model.contentItemId(),
            sequence: self.model.revisionSequence()
        };

        var service = self.social.getService('Edit');
        return service.get('GetLastSequence', params, success, failure);
    };

    dnn.social.DetailView.prototype.continueEdit = function () {
        var self = this;
        var dialog;
        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: self.getString('EditDialogTitle'),
            minWidth: 650,
            closeOnEscape: false,
            resizable: false,
            open: function () {
				$('.editor-dialog').find('div.dnnTagsInput input[id$="_tag"]').each(function() {
					var $input = $('#' + $(this).attr('id').replace('_tag', ''));
					if ($input.data('dnnTagInput')) {
						$(this).dnnResetAutosize($input.data('dnnTagInput'));
					}
				});

				setTimeout(function () {
				    window.dnn.social.unbindEventsThatConflictWithJQueryDialog(dialog);
				}, 0);
			}
        };

        var editModel = ko.contextFor($(self.settings.editId)[0]).$root;
        if (editModel) {
            editModel.bindControls(self.model.revisionSequence(), self.model.content());
            dialog = $('.editor-dialog').dialog(options);
        }
        
        return true;
    };
    
    dnn.social.DetailView.prototype.report = function () {
        var self = this;
        if (dnn.social.authorizationRequired(self.settings)) return;
        dnn.social.reportContent(self.model.contentItemId());
    };

    dnn.social.DetailView.prototype.bindControls = function () {
    };

    dnn.social.DetailView.prototype.switchingView = function () {
        var self = this;
        if(self.settings.commentId) $(self.settings.commentId, self.moduleScope).appendTo($('.comments-container-common', self.moduleScope));
        $(".ui-dialog-content").dialog("close");
    };

    dnn.social.DetailView.prototype.switchedView = function () {
        var self = this;
        if (typeof dnn.social.initLikeControl === 'function') {
            dnn.social.initLikeControl().bindControls();
        }

        if (self.settings.commentId && !self.inlineCommentControl) {
            var commentControl = $(self.settings.commentId, self.moduleScope);
            if (commentControl && commentControl.length) {
                var commentContext = ko.contextFor(commentControl[0]);
                commentContext.$root.isMobileView(self.isMobileView());
                commentContext.$root.bindHoverCard();
                commentContext.$root.initEditControls();
                var commentContainer = self.isMobileView() ? '.comments-container-mobileview' : '.comments-container-normalview';
                commentControl.appendTo($(commentContainer, self.moduleScope));
            }
        }

        var content = $('#detailview-content-common', self.moduleScope);
        if (content.length) {
            var contentContainer = self.isMobileView() ? '#detailview-content-mobile' : '#detailview-content-normal';
            $(contentContainer, self.moduleScope).html(content.html());
        }

        if (!self.isMobileView()) {
            $('#detail-content-moderator-menu', $(self.settings.moduleScope)).click(function (e) {
                $(e.target).closest('ul.comment-actions-dropdown').hide();
            }).hoverIntent({
                over: function () {
                    $('ul.comment-actions-dropdown', $(this)).show();
                },
                out: function () {
                    $('ul.comment-actions-dropdown', $(this)).hide();
                },
                timeout: 300,
                interval: 150
            });
        }

        self.initAttachments();

        if (typeof self.customisedSwitchedView == 'function')
            self.customisedSwitchedView.apply(self);
        
        dnn.social.loaded(self.settings.moduleScope.id);

        if (typeof self.notifyViewSwitched == 'function')
            self.notifyViewSwitched.apply(self);
    };

    dnn.social.DetailView.prototype.binded = function() {
        this.bindControls();
        this.switchedView();
    };
    
    dnn.social.DetailView.prototype.reply = function () {
        if (this.settings.commentId) {
            var control = $(this.settings.commentId, this.settings.moduleScope)[0];
            if (control) {
                var model = window.ko.contextFor(control);
                if (model && model.$root && model.$root.reply) {
                    model.$root.reply();
                }
            }
        }
    };

    dnn.social.DetailView.prototype.refresh = function () {
        window.location.reload();
    };

    dnn.social.DetailView.prototype.initAttachments = function (expand) {
        if (typeof this.model === 'undefined' || typeof this.model.attachments !== 'function')
            return;

        var self = this;
        var attachments = this.model.attachments();
        var results = attachments.length == 0 ? '' :
                         attachments.length == 1 ? 'Attachment: {0}' : 'Attachments: {0} {1}';
        var resultsMobile = attachments.length == 0 ? '' :
                         attachments.length == 1 ? '{0}' : '<a class="detail-attachments-toggle">{1} attachments</a>';

        if (results) {
            var replace1 = "<a href='" + attachments[0].fileUrl() + "' target='_blank'>" + attachments[0].fileName() + "</a>";
            var replace2 = "and <a class='detail-attachments-toggle'>" + (attachments.length - 1) + " more</a>";
            results = results.replace("{0}", replace1);
            results = results.replace("{1}", replace2);
            
            resultsMobile = resultsMobile.replace("{0}", replace1);
            resultsMobile = resultsMobile.replace("{1}", attachments.length);
        }
        
        this.attachmentsHtml(results);
        this.attachmentsHtmlMobileView(resultsMobile);
        
        if (expand)
            this.hideAttachments(false);
        else
            this.hideAttachments(attachments.length > 1);
        
        this.hideAttachmentsMobileView(attachments.length > 0);
        
        this.showToggleAttachments(attachments.length > 1);

        $(this.moduleScope).find('a.detail-attachments-toggle').unbind('click').bind('click', function() {
            self.hideAttachments(!self.hideAttachments());
            self.hideAttachmentsMobileView(!self.hideAttachmentsMobileView());
            return false;
        });
    };

})(window.dnn, window.jQuery, window.ko);
