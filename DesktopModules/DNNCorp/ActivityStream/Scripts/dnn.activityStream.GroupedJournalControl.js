// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activityStream === 'undefined') dnn.activityStream = {};

(function (dnn) {
    'use strict';

    dnn.activityStream.GroupedJournalControl = function GroupedJournalControl($, ko, settings) {
        var that = this;

        this.social = new dnn.social.Module(settings);

        this.service = this.social.getService('Social'); 

        this.bindedToContainer = false;

        this.results = ko.observableArray([]);

        this.totalResults = ko.observable(0);

        this.pageIndex = ko.observable(0);

        this.journalId = ko.observable(0);

        this.isMobileView = ko.observable(false);
		
		this.pageSize = 20;

        this.showMore = ko.computed(function () {
			return that.totalResults() >= that.pageSize;			
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
            this.pageIndex(0);
            this.totalResults(0);
            this.results([]);
            $('.others-grouped-journal .tag-menu', scopeWrapper).html('');
        };

        var createGroupedJournalPerson = function (person) {
            var groupedJournalPerson = dnn.social.komodel(person);
            return groupedJournalPerson;
        };

        var getGroupedJournalBasic = function (journalId, control, service, callback) {
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
                pageIndex: 5,
                pageSize: 10
            };

            service.post('GetGroupedJournalBasic', params, success, failure);
        };

        var getGroupedJournalDetailed = function (journalId, control, service, callback) {
            if (journalId === that.journalId()) {
                callback();
                return;
            }
            var failure = function () {
            };
            var success = function (m) {
                var results = [];
                for (var i = 0; i < m.Results.length; i++) {
                    results.push(createGroupedJournalPerson(m.Results[i]));
                }
                that.results(results);
                that.totalResults(m.TotalRecords);
                that.pageIndex(that.pageSize + 1);
                callback();
            };

            var params = {
                journalId: journalId,
                pageIndex: 1,
                pageSize: that.pageSize
            };

            that.pageIndex(1);
            that.totalResults(0);
            that.journalId(journalId);
            service.post('GetGroupedJournalDetailed', params, success, failure);
        };

        this.bindControls = function (scope) {
            var scopeWrapper = scope || $(settings.parentScope);
            this.reset(scopeWrapper);
            $('.others-grouped-journal', scopeWrapper).qaTooltip({
                asyncDelegate: function (callback) {
                    if (!this.parent().hasClass('dnnMobileLike')) {
                        var journalId = this.data('journal-id') ? parseInt(this.data('journal-id'), 10) : 0;
                        var control = this;
                        getGroupedJournalBasic(journalId, control, that.service, callback);
                    }
                }
            }).unbind('click')
              .bind('click', function () {
                  var control = $(this);
                  var journalId = control.data('journal-id') ? parseInt(control.data('journal-id'), 10) : 0;
                  settings.popupTitle = control.data('popup-title') ? control.data('popup-title') : "";
                  that.isMobileView(control.parent().hasClass('dnnMobileLike'));
                  getGroupedJournalDetailed(journalId, control, that.service, function () {
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
                    results.push(createGroupedJournalPerson(m.Results[i]));
                }
                that.results(results);
                that.totalResults(m.TotalRecords);
                that.pageIndex(that.pageIndex() + that.pageSize);
            };

            var params = {
                journalId: that.journalId(),
                pageIndex: that.pageIndex(),
                pageSize: that.pageSize
            };

            this.service.post('GetGroupedJournalDetailed', params, success, failure);
        };

        this.closeDialog = function () {
            $(".ui-dialog-content").dialog("close");
        };
    };
})(window.dnn);