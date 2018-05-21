// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.blogs === 'undefined') dnn.blogs = {};

(function(dnn, $, ko) {
    'use strict';

    dnn.blogs.EntryView = function EntryView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.blogs.Entry($, ko, this.settings, this.social, this.dataModel);
        this.register(this, 'PrimaryView');
        this.service = this.social.getService('Relationships');
        this.init();
    };
    
    dnn.blogs.EntryView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.blogs.EntryView.prototype.init = function () {
        var self = this;
        this.showCommentsTitle = ko.observable(false);
        this.commentCount = ko.observable(self.settings.commentCount);
        this.isFollowed = ko.observable(self.settings.isFollowed);
        this.followLinkText = ko.computed(function () { return self.isFollowed() ? self.getString('Unfollow') : self.getString('Follow'); });
        dnn.social.DetailView.prototype.init.apply(this);
    };
    
    dnn.blogs.EntryView.prototype.editEntry = function () {
        window.location = this.settings.editUrl;
    };
    
    dnn.blogs.EntryView.prototype.deleteEntry = function () {
        if (dnn.social.authorizationRequired(this.settings)) return;
        var self = this;
        var title = self.getString('ConfirmTitle');
        var text = self.getString('DeleteEntryConfirm');

        var callbackTrue = function () {
            var failure = function (xhr, status) {
                $.dnnAlert({
                    title: self.getString('DeleteFailureTitle'),
                    text: self.getString('DeleteFailure').format(status || self.getString('UnknownError'))
                });
            };
            var success = function () {
                window.location.href = self.settings.blogUrl;
            };
            var params = {
                blogId: self.settings.blogId,
                entryId: self.settings.entryId
            };
            self.social.getService('EntryView').post('DeleteEntry', params, success, failure);
        };

        var dialogOptions = {
            autoOpen: true,
            buttons: [
                {
                    text: self.getString('Yes'),
                    click: function () {
                        confirmDialog.dialog("close");
                        callbackTrue();
                    },
                    'class': 'dnnPrimaryAction'
                },
                {
                    text: self.getString('No'),
                    click: function () {
                        confirmDialog.dialog("close");
                    },
                    'class': 'dnnSecondaryAction'
                }
            ],
            modal: true,
            dialogClass: 'dnnFormPopup dnnClear',
            title: title,
            resizable: false
        };
        var confirmDialog = $("<div class='dnnDialog'></div>").html(text).dialog(dialogOptions);
    };
    
    dnn.blogs.EntryView.prototype.follow = function () {
        var self = this;
        var failure = function (xhr, status) {
            $.dnnAlert({
                title: self.getString('FollowErrorTitle'),
                text: self.getString('FollowError').format(status || self.getString('UnknownError'))
            });
        };

        var success = function () { self.isFollowed(!self.isFollowed()); };

        var params = { userId: self.settings.authorUserId };

        var method = self.isFollowed() ? 'Unfollow' : 'Follow';
        self.service.post(method, params, success, failure);
    };
    
    dnn.blogs.EntryView.prototype.showModerationPopup = function () {
        var options = {
            modal: true,
            autoOpen: true,
            dialogClass: 'dnnFormPopup',
            title: '',
            minWidth: 650,
            closeOnEscape: false,
            resizable: false
        };
        $('.editor-dialog.moderation-dialog').dialog(options);
    };
    
    dnn.blogs.EntryView.prototype.hideModerationPopup = function () {
        $('.editor-dialog.moderation-dialog').dialog('close');
    };

    dnn.blogs.EntryView.prototype.binded = function () {
        $("#blogArchive").hide();
        this.switchedView();
        if ($('.editor-dialog.moderation-dialog').length) {
            this.showModerationPopup();
        }
    };
})(window.dnn, window.jQuery, window.ko);