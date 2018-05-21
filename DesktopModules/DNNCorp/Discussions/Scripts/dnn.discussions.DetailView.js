// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved


if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.discussions === 'undefined') dnn.discussions = {};

(function (dnn, $, ko) {
    'use strict';
    dnn.discussions.DetailView = function DetailView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.discussions.Topic($, ko, this.settings, this.social, this.dataModel);
        this.register(this, 'PrimaryView');
        this.register(this.social.getService('Detail'));
        this.register(this.social.getPagingControl('DetailController'));
        this.register(new dnn.discussions.DetailController($, ko, this.settings, this.social, this.model));
        this.init();
    };

    dnn.discussions.DetailView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.discussions.DetailView.prototype.init = function () {
        this.showCommentsTitle = ko.observable(false);
        this.commentCount = ko.observable(this.settings.commentCount);
        dnn.social.DetailView.prototype.init.apply(this);
    };

    dnn.discussions.DetailView.prototype.customisedSwitchedView = function () {
        var self = this;
        var localizer = this.social.getLocalizationController();
        if (!self.isMobileView()) {
            $('a#deleteTopic').dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                callbackTrue: function() {
                    var service = self.social.getService('Edit');
                    var success = function(m) {
                        window.location.href = m.ReturnUrl;
                    };
                    var failure = function(xhr, status) {
                        var r = JSON.parse(xhr.responseText);
                        $.dnnAlert({
                            title: r.Title || localizer.getString('DeleteTopicFailedTitle'),
                            text: status || localizer.getString('DeleteTopicFailed')
                        });
                    };

                    var params = {
                        topicId: self.model.topicId(),
                        contentItemId: self.model.contentItemId(),
                        groupId: self.model.groupId()
                    };
                    service.post('Delete', params, success, failure);
                }
            });
        }
    };

    dnn.discussions.DetailView.prototype.moveContent = function () {
        dnn.social.contentExchange({
            methodName: 'Move',
            actionTitle: this.getString('Move'),
            summary: this.model.contentTitle()
        });
    };

    dnn.discussions.DetailView.prototype.moveContentToComment = function () {
        dnn.social.contentExchange({
            methodName: 'MoveToComment',
            actionTitle: this.getString('Move'),
            actionTitle2: this.getString('ToComment'),
            summary: this.model.contentTitle()
        });
    };

    dnn.discussions.DetailView.prototype.copyContent = function () {
        dnn.social.contentExchange({
            methodName: 'Copy',
            actionTitle: this.getString('Copy'),
            summary: this.model.contentTitle()
        });
    };

})(window.dnn, window.jQuery, window.ko);

