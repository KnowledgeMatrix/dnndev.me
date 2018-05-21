// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.social === 'undefined') dnn.social = {};

(function (dnn) {
    'use strict';

    dnn.social.LikeControl = function LikeControl($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Social');

        this.bindedToContainer = false;

        this.results = ko.observableArray([]);

        this.totalResults = ko.observable(0);

        this.pageIndex = ko.observable(0);

        this.journalId = ko.observable(0);

        this.commentId = ko.observable(0);

        this.isMobileView = ko.observable(false);

        this.showMore = ko.computed(function () {
            return that.totalResults() > that.pageIndex() + 1;
        });

        this.bindToContainer = function () {
            if (!this.bindedToContainer) {
                ko.applyBindings(this, settings.moduleScope);
                this.bindedToContainer = true;
            }
        };

        this.reset = function (scope) {
            var scopeWrapper = scope || $(settings.parentScope);
            this.journalId(0);
            this.commentId(0);
            this.pageIndex(0);
            this.totalResults(0);
            this.results([]);
            $('.others-like .tag-menu', scopeWrapper).html('');
        };

        var createLikePerson = function(person, service) {
            var likePerson = dnn.social.komodel(person);
            likePerson.friend = function () {
                if (dnn.social.authorizationRequired(settings)) {
                    return;
                }

                var self = this;
                service.post('friend', { userId: self.userId() }, function () {
                    self.friendStatus(1);
                }, function () {

                });
            };
            likePerson.unfriend = function () {
                if (dnn.social.authorizationRequired(settings)) {
                    return;
                }

                var self = this;
                service.post('unfriend', { userId: self.userId() }, function () {
                    self.friendStatus(0);
                }, function () {

                });

            };
            
            return likePerson;
        };

        var getLikesBasic = function (journalId, commentId, control, service, callback) {
            var tagMenu = $('.tag-menu', control);
            if (tagMenu.find('ul').length) {
                callback();
                return;
            }
            var failure = function () {
            };
            var success = function (m) {
                if (m && m.TotalRecords) {
                    var html = '<ul>';
                    for (var i = 0; i < m.Results.length; i++) {
                        html += '<li>' + m.Results[i] + '</li>';
                    }
                    if (m.TotalRecords > 13) {
                        html += '<li>' + (m.TotalRecords - 13) + ' More...</li>';
                    }
                    html += '</ul>';
                    $('.tag-menu', control).html(html);
                    callback();
                }
            };


            var params = {
                journalId: journalId,
                commentId: commentId,
                pageIndex: 4,
                pageSize: 10
            };
            
            service.post('GetLikesBasic', params, success, failure);
        };

        var getLikesDetailed = function (journalId, commentId, control, service, callback) {
            if (journalId === that.journalId() && commentId == that.commentId()) {
                callback();
                return;
            }
            var failure = function () {
            };
            var success = function (m) {
                var results = [];
                for (var i = 0; i < m.Results.length; i++) {
                    results.push(createLikePerson(m.Results[i], service));
                }
                that.results(results);
                that.totalResults(m.TotalRecords);
                that.pageIndex(21);
                callback();
            };

            var params = {
                journalId: journalId,
                commentId: commentId,
                pageIndex: 0,
                pageSize: 20
            };

            that.pageIndex(0);
            that.totalResults(0);
            that.journalId(journalId);
            that.commentId(commentId);
            service.post('GetLikesDetailed', params, success, failure);
        };

        this.bindControls = function (scope) {
            var scopeWrapper = scope || $(settings.parentScope);
            this.reset(scopeWrapper);
            $('.others-like', scopeWrapper).qaTooltip({
                asyncDelegate: function (callback) {
                    if (!this.parent().hasClass('dnnMobileLike')) {
                        var journalId = this.data('journal-id') ? parseInt(this.data('journal-id'), 10) : 0;
                        var commentId = this.data('comment-id') ? parseInt(this.data('comment-id'), 10) : 0;
                        var control = this;
                        getLikesBasic(journalId, commentId, control, that.service, callback);
                    }
                }
            }).unbind('click')
              .bind('click', function () {
                  var control = $(this);
                  var journalId = control.data('journal-id') ? parseInt(control.data('journal-id'), 10) : 0;
                  var commentId = control.data('comment-id') ? parseInt(control.data('comment-id'), 10) : 0;
                  that.isMobileView(control.parent().hasClass('dnnMobileLike'));
                  getLikesDetailed(journalId, commentId, control, that.service, function () {
                      that.bindToContainer();
                      var popup = $(settings.moduleScope).parent('.like-popup');
                      if (!that.isMobileView()) {
                          popup.dialog({
                              modal: true,
                              autoOpen: true,
                              dialogClass: 'dnnFormPopup',
                              title: settings.popupTitle,
                              minWidth: 350,
                              resizable: false,
                              draggable: false,
                              open: $.ui.dialog.prototype.options.open,
                              close: $.ui.dialog.prototype.options.close,
                          });
                      } else {
                          var options = dnn.social.MobileView.dialogOptions({
                              title: settings.popupTitle
                          });
                          popup.dialog(options);
                      }
                  });
              });
        };

        this.getMore = function () {
            var failure = function () {
            };
            var success = function (m) {
                var results = that.results();
                for (var i = 0; i < m.Results.length; i++) {
                    results.push(createLikePerson(m.Results[i], that.service));
                }
                that.results(results);
                that.pageIndex(that.pageIndex() + 20);
            };

            var params = {
                journalId: that.journalId(),
                commentId: that.commentId(),
                pageIndex: that.pageIndex(),
                pageSize: 20
            };

            this.service.post('GetLikesDetailed', params, success, failure);
        };

        this.closeDialog = function() {
            $(".ui-dialog-content").dialog("close");
        };
    };
})(window.dnn);