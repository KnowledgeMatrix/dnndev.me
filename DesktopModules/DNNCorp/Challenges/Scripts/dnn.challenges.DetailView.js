// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved


if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.challenges === 'undefined') dnn.challenges = {};

(function (dnn, $, ko) {
    'use strict';
    dnn.challenges.DetailView = function DetailView() {
        dnn.social.DetailView.apply(this, Array.prototype.slice.call(arguments));
        this.model = new dnn.challenges.Challenge($, ko, this.settings, this.social, this.dataModel);
        this.analysisData = this.settings.analysisData;
        this.register(this, 'PrimaryView');
        this.register(this.social.getService('Detail'));
        this.register(this.social.getPagingControl('DetailController'));
        this.register(new dnn.challenges.DetailController($, ko, this.settings, this.social, this.model));
        this.init();
    };

    dnn.challenges.DetailView.prototype = Object.create(dnn.social.DetailView.prototype);

    dnn.challenges.DetailView.prototype.init = function () {
        this.showCommentsTitle = ko.observable(false);
        this.commentCount = ko.observable(this.settings.commentCount);
        var mapUsers = function (users) {
            var map = [];
            for (var i = 0; i < users.length; i++) {
                var u = users[i];
                u.navigate = $.proxy(function() {
                    window.location.href = this.profileUrl;
                }, u);
                map.push(u);
            }
            return map;
        };
        this.participatingUsers = {
            topAcceptedUsers: mapUsers(this.analysisData.topAcceptedUsers),
            topCompletedUsers: mapUsers(this.analysisData.topCompletedUsers)
        };
        dnn.social.DetailView.prototype.init.apply(this);
    };

    dnn.challenges.DetailView.prototype.drawLineChart = function() {
        var data = [
            {
                values: this.analysisData.acceptedActivities,
                key: "ACCEPTED",
                color: "#004b7a"
            },            
            {
                values: this.analysisData.completedActivities,
                key: "COMPLETED",
                color: "#0996d8"
            }
        ];

        var axisLabels = [];
        for (var i = 0; i < this.analysisData.acceptedActivities.length; i++) {
            axisLabels.push(this.analysisData.acceptedActivities[i].axisLabel);
        }
        
        var w = $(this.moduleScope).parent().width();
        w = w > 40 ? w - 40 : w;
        var h = Math.round(w / 3);
        if (this.isMobileView()) h *= 2;
        
        var margin = { top: 20, right: 15, bottom: 20, left: 40 },
            width = w - margin.left - margin.right,
            height = h - margin.top - margin.bottom;

        var legendSelector = this.isMobileView() ? "#challenge-detailview-participation-legend-mobile" : "#challenge-detailview-participation-legend";
        var container = this.isMobileView() ? '#challenge-detailview-participation-mobile svg' : '#challenge-detailview-participation svg';
        var chart = dnn.challenges.lineChart(true, margin, width, height)
                    .labels(axisLabels)
                    .legendSelector(legendSelector)
                    .legendSettings([])
                    .updateLegendSettings(function(u) {});
        
        if (!this.isMobileView()) {
            chart.tooltipSelector("#challenge-detailview-participation > div.line-chart-tooltip").tooltipLabel("[COUNT] users");
        }

        window.d3.select(container)
            .datum(data)
            .call(chart);
    };
    
    dnn.challenges.DetailView.prototype.drawDonutChart = function (wrapper, info, tooltipSelector, legendSelector, ratioSelector) {
        wrapper.find('svg').remove();
        var data = [
            { values: info.values, colors: info.colors, labels: info.labels }
        ];
        
        wrapper.prepend('<svg class="donut-chart"></svg>');
        var w = $(this.moduleScope).parent().width();
        w = w > 40 ? w - 40 : w;
        w = this.isMobileView() ? w : Math.round(w / 2);
        var chart = dnn.challenges.donutChart(true, 5, 100, 100)
            .width(w - 10).height(w - 10)
            .radius((w / 4) + 30).thickness(30)
            .tooltipSelector(tooltipSelector)
            .legendSelector(legendSelector)
            .ratioSelector(ratioSelector);
        
        window.d3.select('#' + wrapper[0].id + ' svg')
            .datum(data)
            .call(chart);
    };

    dnn.challenges.DetailView.prototype.customisedSwitchedView = function () {
        var self = this;
        if (!self.isMobileView()) {
            $('a#deleteChallenge').dnnConfirm({
                text: self.getString('ConfirmText'),
                yesText: self.getString('Yes'),
                noText: self.getString('No'),
                title: self.getString('ConfirmTitle'),
                callbackTrue: function() {
                    var service = self.social.getService('Edit');
                    var success = function(m) {
                        window.location.href = m.ReturnUrl;
                    };
                    var params = {
                        challengeId: self.model.challengeId(),
                        contentItemId: self.model.contentItemId(),
                        groupId: self.model.groupId()
                    };
                    service.post('Delete', params, success);
                }
            });
        }

        // draw line chart
        self.drawLineChart();

        if (true) return; //SOCIAL-3497 Removed to be added back in a later revision
        

        // draw social follower chart
        var socialFollowersData = self.analysisData.followersVsNonFollowers;
        if (socialFollowersData && socialFollowersData.values.length) {
            var container1 = this.isMobileView() ? '#challenge-detailview-socialfollowers-svg-mobile' : '#challenge-detailview-socialfollowers-svg';
            var tooltip1 = this.isMobileView() ? '' : "#challenge-detailview-socialfollowers > div.line-chart-tooltip";
            var legend1 = this.isMobileView() ? "#challenge-detailview-socialfollowers-legend-mobile" : "#challenge-detailview-socialfollowers-legend";
            var ratio1 = this.isMobileView() ? "#challenge-detailview-socialfollowers-ratio-mobile" : "#challenge-detailview-socialfollowers-ratio";
            self.drawDonutChart($(container1), {
                values: socialFollowersData.values,
                labels: socialFollowersData.labels,
                colors: ["#9d8edb", "#a13c57"]
            }, tooltip1, legend1, ratio1);
        }
            
        // draw social networks chart
        var socialNetworksData = self.analysisData.socialNetworks;
        if (socialNetworksData && socialNetworksData.values.length) {
            var container2 = this.isMobileView() ? '#challenge-detailview-socialnetworks-svg-mobile' : '#challenge-detailview-socialnetworks-svg';
            var tooltip2 = this.isMobileView() ? '' : "#challenge-detailview-socialnetworks > div.line-chart-tooltip";
            var legend2 = this.isMobileView() ? "#challenge-detailview-socialnetworks-legend-mobile" : "#challenge-detailview-socialnetworks-legend";
            var ratio2 = this.isMobileView() ? "#challenge-detailview-socialnetworks-ratio-mobile" : "#challenge-detailview-socialnetworks-ratio";
            self.drawDonutChart($(container2), {
                values: socialNetworksData.values,
                labels: $.map(socialNetworksData.labels, function(l) { return dnn.social.socialNetworks[l]; }),
                colors: ["#004b7a", "#0996d8", "#b5958a", "#f26b5e"]
            }, tooltip2, legend2, ratio2);
        }
    };

})(window.dnn, window.jQuery, window.ko);