// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.revisions === 'undefined') dnn.revisions = {};

(function(dnn) {
    'use strict';

    dnn.revisions.CompareControl = function CompareControl(settings) {
        var that = this;

        var invalidComparison = '<p class="revision-invalid-compare"><strong>Invalid comparison</strong></p>';
        var social = new dnn.social.Module(settings);
        this.revisions = ko.observableArray([]);
        this.frozen = ko.observable(false);
        this.left = ko.observable();
        this.leftSequence = ko.observable(-1);
        this.leftRevisionId = ko.observable(-1);
        this.right = ko.observable();
        this.rightSequence = ko.observable(-1);
        this.rightRevisionId = ko.observable(-1);
        
        this.load = function (leftId, rightId) {
            if (that.frozen()) return;
            if (typeof leftId != "number" || typeof rightId != "number") return;
            if (leftId == rightId) {
                that.left(invalidComparison);
                that.right(invalidComparison);
                return;
            }
            
            var failure = function() {
                that.left(new String());
                that.leftSequence(-1);
                that.right(new String());
                that.rightSequence(-1);
            };

            var success = function(model) {
                that.left(model.LeftDocument);
                that.leftSequence(model.LeftSequence);
                
                that.right(model.RightDocument);
                that.rightSequence(model.RightSequence);

                that.frozen(true);
                
                if (that.revisions().length < 1) {
                    var list = [];
                    $.each(model.Revisions || [],
                        function(unused, r) {
                            list.push(dnn.social.komodel(r));
                        });

                    that.revisions(list);
                }
                
                if(that.leftRevisionId() != leftId) that.leftRevisionId(leftId);
                if (that.rightRevisionId() != rightId) that.rightRevisionId(rightId);
                
                that.frozen(false);
            };

            var params = {
                leftRevisionId: leftId,
                rightRevisionId: rightId
            };

            var service = social.getService('RevisionsService');
            service.get('Compare', params, success, failure);
        };

        this.close = function() {
            $(settings.moduleScope).dialog('close');
        };

        this.leftRevisionId.subscribe(
            function (m) {
                if (!that.frozen()) {
                    setTimeout(function() {
                        that.load(that.leftRevisionId(), that.rightRevisionId());
                    }, 50);
                }
            });

        this.rightRevisionId.subscribe(
            function (m) {
                if (!that.frozen()) {
                    setTimeout(function () {
                        that.load(that.leftRevisionId(), that.rightRevisionId());
                    }, 50);
                }
            });
    };
})(window.dnn);