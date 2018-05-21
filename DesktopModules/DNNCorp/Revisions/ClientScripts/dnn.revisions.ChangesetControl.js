// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.revisions === 'undefined') dnn.revisions = {};

(function(dnn) {
    'use strict';

    dnn.revisions.ChangesetControl = function ChangesetControl(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);

        var focus = social.getFocusController([]);

        var componentFactory = social.getComponentFactory();

        var controller = componentFactory.register(new dnn.revisions.ChangesetController(settings));

        this.pager = componentFactory.register(social.getPagingControl('ChangesetController'));

        this.detailsUrl = ko.observable();

        this.topRevision = ko.observable();

        this.revisions = ko.observableArray([]);

        this.selectedRevisions = [];

        this.modal = ko.observable(false);

        this.mutedData = ko.observable(false);

        this.moderator = ko.observable(false);
        
        this.loading = function(b) {
            if (b) {
                $(settings.moduleScope).addClass('loading');
            } else {
                $(settings.moduleScope).removeClass('loading');
            }
        };

        this.getRevisionStyle = function(r) {
            if (typeof r.selected === 'function') {
                if (r.selected()) {
                    return 'revision-selected';
                }
            }

            return new String();
        };

        this.load = function (contentItemId, contentItemType, childItemId) {
            settings.contentItemId = contentItemId;
            settings.contentItemType = contentItemType;
            settings.childItemId = childItemId;

            if (that.pager.page() != 0) {
                that.pager.page(0);
            } else {
                controller.load(0, that.completionEvent, undefined, that.loading);
            }
        };

        this.completionEvent = function(list) {
            var results = [];

            $.each(list.Records || [],
                function (unused, r) {
                    var revision = dnn.social.komodel(r);

                    revision.selected.subscribe(
                        function(selected) {
                            if (selected) {
                                that.selectedRevisions.push(revision);
                            } else {
                                var indexOf = that.selectedRevisions.indexOf(revision);
                                if (indexOf >= 0) {
                                    that.selectedRevisions.splice(indexOf, 1);
                                }
                            }

                            if (that.selectedRevisions.length > 2) {
                                var firstItem = that.selectedRevisions[0];
                                firstItem.selected(false);
                            }

                            var button = $('.revisions-compare-button', settings.moduleScope);
                            if (button.length == 0) {
                                button = $('.revisions-compare-button'); 
                            }

                            if (that.comparable()) {
                                button.removeAttr('disabled');
                            } else {
                                button.attr('disabled', 'disabled');
                            }
                        });
                    
                    results.push(revision);
                });

            that.revisions(results);
            
            if (typeof list.DetailsUrl === 'string') {
                that.detailsUrl(list.DetailsUrl);
            }
        };

        this.comparable = function() {
            var count = 0;

            $.each(that.revisions() || [],
                function(unused, r) {
                    if (r.selected()) {
                        count++;
                    }
                });

            return count > 1;
        };

        this.hoverIn = function (r, e) {
            if (typeof settings.hoverCompare === 'undefined' || !settings.hoverCompare) {
                return null;
            }

            that.hoverOut(r);

            if (focus.clickedWithinInput(e)) {
                return false;
            }

            that.hoverTimer = setTimeout(
                function () {
                    that.showCompareCard(r, e);

                    delete that.hoverTimer;
                }, 500);
        };

        this.hoverOut = function (r) {
            if (typeof that.hoverTimer !== 'undefined') {
                clearTimeout(that.hoverTimer);
                
                delete that.hoverTimer;
            } else {
                that.hideCompareCard();
            }
        };
        
        this.showCompareCard = function (r, e) {
            that.hideCompareCard(
                function() {
                    var root = ko.contextFor($(settings.compareScope)[0]).$root;
                    if (root != null) {
                        var lid = that.getRevisionId(r.sequence() - 1);
                        var rid = that.getRevisionId(r.sequence());
                        
                        root.load(lid, rid);
                    }
                    
                    $(settings.compareScope).css({ top: e.pageY - $(window).scrollTop(), left: e.pageX });
                    $(settings.compareScope).fadeIn();
                });
        };

        this.hideCompareCard = function (completeEvent) {
            var completion = function () {
                if (typeof completeEvent === 'function') {
                    completeEvent();
                }
            };

            if ($(settings.compareScope).is(':visible')) {
                $(settings.compareScope).slideUp('fast',
                    function () {
                        completion();
                    });
            } else {
                completion();
            }
        };

        this.compare = function() {
            if (that.comparable()) {

                var l = that.loCompare();
                var r = that.hiCompare();
                
                if (l != null && r != null) {
                    dnn.revisions.compare(l.revisionId(), r.revisionId());
                }
            }
        };

        this.loCompare = function () {
            var seq;

            $.each(that.selectedRevisions.reverse(),
                function (unused, r) {
                    if (typeof seq === 'undefined') {
                        seq = r;
                    }
                    else if (r.sequence() < seq.sequence()) {
                        seq = r;
                    }
                });

            return seq;
        };

        this.hiCompare = function () {
            var seq;

            $.each(that.selectedRevisions,
                function (unused, r) {
                    if (typeof seq === 'undefined') {
                        seq = r;
                    }
                    else if (r.sequence() > seq.sequence()) {
                        seq = r;
                    }
                });

            return seq;
        };

        this.getRevisionId = function (sequence) {
            for (var i = 0; i < that.revisions().length; ++i) {
                if (that.revisions()[i].sequence() == sequence) {
                    return that.revisions()[i].revisionId();
                }
            }

            return -1;
        };

        this.errorMessage = function(key, status) {
            var localizer = social.getLocalizationController();
            
            var text = localizer.getString(key);

            if (typeof status === 'string' && status.length > 0) {
                text += ': ';
                text += status;
            }

            $.dnnAlert({
                title: localizer.getString('Error'),
                text: text
            });
        };

        this['delete'] = function (r) {
            return that.stateTransition(r, 'Delete', 'UnableToDelete');
        };

        this.publish = function (r) {
            return that.stateTransition(r, 'Publish', 'UnableToPublish');
        };

        this.reject = function (r) {
            return that.stateTransition(r, 'Reject', 'UnableToReject');
        };

        this.undoReject = function (r) {
            return that.stateTransition(r, 'UndoReject', 'UnableToUndo');
        };

        this.undoDelete = function (r) {
            return that.stateTransition(r, 'UndoDelete', 'UnableToUndo');
        };
        
        this.rollback = function (r) {
            return that.stateTransition(r, 'Rollback', 'UnableToRollback');
        };

        this.stateTransition = function (r, method, errorKey) {
            var failure = function (xhr, status) {
                that.errorMessage(errorKey, status);
            };

            var success = function (model) {
                that.load(settings.contentItemId, settings.contentItemType, settings.childItemId);
                that.getLatest();
                that.mutedData(true);
            };

            var params = {
                revisionId: r.revisionId(),
                contentItemId: settings.contentItemId,
                contentItemType: settings.contentItemType,
                childItemId: settings.childItemId,
            };

            var service = social.getService('RevisionsService');
            return service.post(method, params, success, failure, that.loading);
        };

        this.mirror = function (o, n) {
            $.each(o,
                function (key) {
                    if (key in n) {
                        o[key](n[key]());
                    }
                });
        };

        this.read = function () {
            if (typeof that.detailsUrl() === 'string') {
                window.location = that.detailsUrl();
            }
        };

        this.getLatest = function () {
            var success = function (revisionId) {
                that.topRevision(revisionId);
            };

            var params = {
                contentItemId: settings.contentItemId,
                contentItemType: settings.contentItemType,
                childItemId: settings.childItemId,
            };

            var service = social.getService('RevisionsService');
            return service.get('GetLatestRevision', params, success, undefined, that.loading);
        };

        this.isLatest = function (revisionId) {
            return that.topRevision() < 0 || that.topRevision() == revisionId;
        };
        
        this.bindControls = function () {
            var pageIndex = that.pager.page();
            if (pageIndex < 0) {
                pageIndex = 0;
            }

            if (controller != null) {
                that.pager.page.subscribe(
                    function() {
                        controller.load(that.pager.page(), that.completionEvent, undefined, that.loading);
                    });
                
                controller.load(pageIndex, that.completionEvent, undefined, that.loading);
            }

            that.getLatest();
        };

        this.binded = function() {
            this.bindControls();
        };
        
    };
})(window.dnn);