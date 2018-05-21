// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
'use strict';
define(['jquery', 'knockout',
    'd3', 'pikaday', 'moment',
    './d3charts', 'main/config',
    'main/pager', 'main/scroller',
    './analytics', 'jquery.qatooltip',
    './koComponents/communityUsers'], function ($, ko, d3, pikaday, moment, d3Charts, cf, pager, scroller, analytics) {
    var dashboardClass = function() {
        var graphColors = ["#004b7a", "#0996d8", "#b5958a", "#f26b5e", "#9d8edb", "#a13c57", "#799e61"];
        var utility = null;
        var config = cf.init();
        var thisModuleName = '';
        var legendSettings = [];
        var comparativeTerms = {
            'Year': '1 y',
            'Month': '1 m',
            'Week': '1 w',
            'Day': '1 d'
        };
        var analyticsModuleInstance = new analytics();

        var TOPCOMMUNITY_MAX_USERS = 5;

        var wrapper;

        var pikerStart = null, pikerEnd = null, pikerContainer = null;

        var getComparativeOptions = function(period) {
            var options = [];
            $.each(comparativeTerms, function(i, v) {
                if (i === period) {
                    options.push(v);
                    return false;
                }
                options.push(v);
            });

            return options;
        };

        var getComparativeTerm = function(period) {
            return comparativeTerms[period];
        };

        var updateLegendSettings = function(update) {
            utility.persistent.save({ legends: update });
        };

        var periodLabel = ko.observable("");
        var areas = ko.observableArray([]);
        var modulePerformance = ko.observableArray([]);
        var topSpectators = ko.observableArray([]);
        var mostActiveUsers = ko.observableArray([]);
        var powerRankings = ko.observableArray([]);
        var totalViews = ko.observable('0');
        var totalViewsDetail = ko.observable('0');

        var create = {
            count: ko.observable('0'),
            countDetail: ko.observable('0'),
            progress: ko.observable(0),
            tooltip: ko.observable('')
        };

        var engagement = {
            percent: ko.observable(0),
            progress: ko.observable(0),
            tooltip: ko.observable(''),
            totals: ko.observableArray([])
        };

        var popularContentViewModel = {
            results: ko.observableArray([]),
            totalResults: ko.observable(0)
        };

        var tagStatsViewModel = {
            totalResults: ko.observable(0),
            max: -1,
            results: ko.observableArray([])
        };

        var adoptionParticipation = {
            totalAdoption: ko.observable('0'),
            totalAdoptionDetail: ko.observable('0'),
            totalParticipation: ko.observable('0'),
            totalParticipationDetail: ko.observable('0'),
            totalSpectators: ko.observable('0'),
            totalSpectatorsDetail: ko.observable('0')
        };

        var activities = {
            results: ko.observableArray([])
        };

        var getSumOfSeriesValues = function(series) {
            var sum = 0;

            if (series && series.length) {
                for (var i = 0; i < series.length; i++) {
                    sum += series[i].count;
                }
            }

            return sum;
        };

        var updateActivitiesTotals = function(dataSets) {
            var data = [];

            if (!dataSets) {
                activities.results(data);
                return;
            }

            for (var i = 0; i < dataSets.length; i++) {
                var totalValue = getSumOfSeriesValues(dataSets[i].activityStats);
                data.push(
                {
                    total: utility.formatAbbreviateBigNumbers(totalValue),
                    totalDetail: utility.formatCommaSeparate(totalValue),
                    label: dataSets[i].moduleName.toUpperCase()
                });
            };

            activities.results(data);
        };

        var updateSeriesCountFormat = function(series) {
            if (!series) {
                return;
            }

            for (var i = 0; i < series.length; i++) {
                series[i].count = utility.formatCommaSeparate(series[i].count);
            }
        };

        var updateActivitiesFormats = function(dataSets) {

            if (!dataSets) {
                return;
            }

            for (var i = 0; i < dataSets.length; i++) {
                dataSets[i].createCountAbbreviate = utility.formatAbbreviateBigNumbers(dataSets[i].createCount);
                dataSets[i].createCountDetail = utility.formatCommaSeparate(dataSets[i].createCount);
                dataSets[i].viewCountAbbreviate = utility.formatAbbreviateBigNumbers(dataSets[i].viewCount);
                dataSets[i].viewCountDetail = utility.formatCommaSeparate(dataSets[i].viewCount);
                updateSeriesCountFormat(dataSets[i].activityStats);
            };
        };

        var updateAdoptionsAndParticipationsTotals = function(adoptions, participations, spectators) {
            var totalAdoption = getSumOfSeriesValues(adoptions);
            var totalParticipation = getSumOfSeriesValues(participations);
            var totalSpectators = getSumOfSeriesValues(spectators);

            adoptionParticipation.totalAdoption(utility.formatAbbreviateBigNumbers(totalAdoption));
            adoptionParticipation.totalAdoptionDetail(utility.formatCommaSeparate(totalAdoption));
            adoptionParticipation.totalParticipation(utility.formatAbbreviateBigNumbers(totalParticipation));
            adoptionParticipation.totalParticipationDetail(utility.formatCommaSeparate(totalParticipation));
            adoptionParticipation.totalSpectators(utility.formatAbbreviateBigNumbers(totalSpectators));
            adoptionParticipation.totalSpectatorsDetail(utility.formatCommaSeparate(totalSpectators));
        };

        var updateAdoptionsAndParticipationsFormats = function(adoptions, participations, spectators) {
            updateSeriesCountFormat(adoptions);
            updateSeriesCountFormat(participations);
            updateSeriesCountFormat(spectators);
        };

        var updateEngagementTotals = function(dataSets) {
            var data = [];

            if (!dataSets) {
                engagement.totals(data);
                return;
            }

            for (var i = 0; i < dataSets.length; i++) {
                var total = getSumOfSeriesValues(dataSets[i].engagementStats);
                data.push(
                {
                    total: utility.formatAbbreviateBigNumbers(total),
                    totalDetail: utility.formatCommaSeparate(total),
                    label: dataSets[i].engagementName
                });
            };

            engagement.totals(data);
        };

        var updateEngagementFormat = function(dataSets) {
            if (!dataSets) {
                return;
            }

            for (var i = 0; i < dataSets.length; i++) {
                updateSeriesCountFormat(dataSets[i].engagementStats);
            };
        };

        var updateCreateViewsFormat = function(create, views) {
            updateSeriesCountFormat(create);
            updateSeriesCountFormat(views);
        };

        var addEmptyUsersToFitMaxSize = function(users) {
            var missedElementCountToFitPage = TOPCOMMUNITY_MAX_USERS - users.length;
            if (missedElementCountToFitPage !== TOPCOMMUNITY_MAX_USERS) {
                for (var i = 0; i < missedElementCountToFitPage; i++) {
                    users.push({
                        avatarUrl: "",
                        displayName: "-",
                        value: '0',
                        valueTooltip: '',
                        navigate: null,
                        isEmpty: true
                    });

                }
            }
        }

        var getTagStats = function() {
            var params = {
                period: viewModel.period(),
                comparativeTerm: viewModel.comparativeTerm(),
                moduleName: thisModuleName,
                startDate: viewModel.startDate(),
                endDate: viewModel.endDate(),
                pageIndex: tagStatsViewModel.pageIndex(),
                pageSize: tagStatsViewModel.pageSize
            };
            utility.sf.moduleRoot = 'personabar';
            utility.sf.controller = 'CommunityAnalytics';
            var method = thisModuleName ? 'GetModuleTagStats' : 'GetTagStats';
            utility.sf.get(method, params, function(data) {
                    var results = data;
                    if (results) updateTagsGraph(results, true);
                },
                function() {
                    // failed...
                });
        };

        var getPopularContent = function() {
            var params = {
                period: viewModel.period(),
                comparativeTerm: viewModel.comparativeTerm(),
                moduleName: thisModuleName,
                startDate: viewModel.startDate(),
                endDate: viewModel.endDate(),
                pageIndex: popularContentViewModel.pageIndex(),
                pageSize: popularContentViewModel.pageSize
            };
            utility.sf.moduleRoot = 'personabar';
            utility.sf.controller = 'CommunityAnalytics';
            var method = thisModuleName ? 'GetModulePopularContent' : 'GetPopularContent';
            utility.sf.get(method, params, updatePopularContent,
                function() {
                    // failed...
                });
        };

        var sequence = -1, lastCallStatus = null;
        var getDashboardInfo = function(cb) {
            utility.sf.moduleRoot = 'personabar';
            utility.sf.controller = 'CommunityAnalytics';
            var method = thisModuleName ? 'GetModuleDashboardInfo' : 'GetDashboardInfo';
            sequence++;

            var comparativeTerm = viewModel.period() == 'Custom' ? 'c' : viewModel.comparativeTerm();

            utility.sf.get(method, {
                    period: viewModel.period(),
                    startDate: viewModel.startDate(),
                    endDate: viewModel.endDate(),
                    comparativeTerm: comparativeTerm,
                    moduleName: thisModuleName,
                    sequence: sequence
                },
                function(data) {
                    if (!data) return;
                    if (!data.data) return;
                    if (data.sequence !== sequence) return;
                    updateGraphs(data.data, function() {
                        if (data.data.isPending) {
                            // analytic data incomplete, we need to try it again...
                            lastCallStatus = data.data;
                            setTimeout(function() {
                                getDashboardInfo(cb);
                            }, 5000);
                        }

                        if (typeof cb === 'function') cb();
                    });
                }, function() {
                    // failed...
                });
        };

        var getDashboardInfoStart = function(cb) {
            lastCallStatus = null;
            getDashboardInfo(cb);
        };

        var refreshDashboard = function() {
            if (!triggerComparativeTerm) return;
            viewModel.tagStats.pageIndex(0);
            viewModel.tagStats.maxWidth = 0;
            viewModel.tagStats.widthPixel = 0;
            viewModel.popularContent.pageIndex(0);
            getDashboardInfoStart(function() {
                bindScrollbar();
            });
            utility.persistent.save({
                period: viewModel.period(),
                startDate: viewModel.startDate(),
                endDate: viewModel.endDate(),
                comparativeOptions: viewModel.comparativeOptions(),
                comparativeTerm: viewModel.comparativeTerm()
            });
        };

        var updateGraphs = function(data, cb) {
            // common parts -
            periodLabel(data.periodLabel || '');

            if (data.tagStats)
                updateTagsGraph(data.tagStats,
                (lastCallStatus == null || lastCallStatus.isPendingTrending) && (!data.isPendingTrending));

            updatePopularContent(data.popularContent);
            topSpectators(buildRankedUsers(data.topSpectators || []));
            mostActiveUsers(buildRankedUsers(data.mostActiveUsers || []));
            powerRankings(buildRankedUsers(data.powerRankings || []));

            if (thisModuleName) {

                updateModuleEngagementGraph(data.labels || [], data.engagementStats || [],
                (lastCallStatus == null || lastCallStatus.isPendingEngagement) && (!data.isPendingEngagement));

                updateModuleCreateGraph(data.labels || [], data.create || [], data.views || [],
                (lastCallStatus == null || lastCallStatus.isPendingCreate) && (!data.isPendingCreate));

                create.count(utility.formatAbbreviateBigNumbers(data.createCount || 0));
                create.countDetail(utility.formatCommaSeparate(data.createCount || 0));
                create.progress(data.createCountProgress || 0);
                create.tooltip(createComparativeTooltip(data.createCountProgress || 1, data.createCount || 0, true));

                engagement.percent(utility.formatAbbreviateBigNumbers(data.engagementPercent) || 0);
                engagement.progress(data.engagementPercentProgress || 1);
                engagement.tooltip(createComparativeTooltip(data.engagementPercentProgress || 1, data.engagementPercent || 0));

                updateEngagementTotals(data.engagementStats || []);
                updateEngagementFormat(data.engagementStats || []);
                updateCreateViewsFormat(data.create || [], data.views || []);

                totalViews(utility.formatAbbreviateBigNumbers(data.totalViews || 0));
                totalViewsDetail(utility.formatCommaSeparate(data.totalViews || 0));
                if (koBinded) {
                    wrapper.find('.chart-statistics .percent-progress').qaTooltip();
                }

                var areaStats = [];
                $.each(data.areaStats || [], function(i, v) {
                    v.isNA = v.percent == -1;
                    v.statusClass = v.healthStatus == 1 ? 'engagement-star' :
                    (v.healthStatus == -1 ? 'engagement-warning' : '');
                    areaStats.push(v);
                });

                areas(areaStats);
                updateAreaGraph(data.areaStats || []);

            } else {

                updateActivityByModuleGraph(data.labels || [], data.moduleStats || [],
                (lastCallStatus == null || lastCallStatus.isPendingActivity) && (!data.isPendingActivity));

                updateAdoptionsAndParticipationGraph(data.labels || [], data.adoptions || [], data.participation || [], data.spectatorsChart || [],
                (lastCallStatus == null || lastCallStatus.isPendingAdoption) && (!data.isPendingAdoption));

                updateAdoptionsAndParticipationsTotals(data.adoptions || [], data.participation || [], data.spectatorsChart || []);
                updateAdoptionsAndParticipationsFormats(data.adoptions || [], data.participation || [], data.spectatorsChart || []);
                updateActivitiesTotals(data.moduleStats || []);
                updateActivitiesFormats(data.moduleStats || []);

                var moduleStats = [];
                $.each(data.moduleStats || [], function(i, v) {
                    v.percentProgressCss = v.percentProgress == 1 ? 'higher' : (v.percentProgress == -1 ? 'lower' : 'hidden');
                    v.loadModuleDashboard = function(vv, e) {
                        e.preventDefault();
                        if (!isWP8) utility.loadModuleDashboard(vv.moduleName);
                    };
                    v.tooltip = createComparativeTooltip(v.percentProgress, v.engagementPercent);
                    moduleStats.push(v);
                });

                modulePerformance(moduleStats);
                if (koBinded) {
                    wrapper.find('.module-performance-card .percent-progress').qaTooltip();
                }
            }
            if (typeof cb === 'function') cb();
        };

        var buildRankedUsers = function(users) {
            var results = [];
            $.each(users, function(i, v) {
                var user = v;
                user.navigate = function(data, e) {
                    var params = { displayName: data.displayName };
                    utility.loadPanel('users', params);

                };
                user.isEmpty = false;
                user.valueTooltip = utility.formatCommaSeparate(user.value);
                user.value = utility.formatAbbreviateBigNumbers(user.value);
                results.push(user);
            });

            if (results.length > 0) {
                addEmptyUsersToFitMaxSize(results);
            }

            return results;
        };

        var updatePopularContent = function(data) {
            var results = [];
            var element = wrapper.find('ul.popular-content-list')[0];
            var width = 295;
            var totalResults = 0;
            if (data) {
                $.each(data.results || [], function(i, v) {
                    var title = v.title;
                    title = utility.trimContentToFit(title, width);
                    v.title = title;
                    v.tooltip = createComparativeTooltip(v.percentProgress, v.percent);
                    results.push(v);
                });
                totalResults = data.totalResults || 0;
            }

            popularContentViewModel.results(results);
            popularContentViewModel.totalResults(totalResults);
            if (koBinded) {
                wrapper.find('ul.popular-content-list .percent-progress').qaTooltip();
            }
        };

        var applyCustomDates = function () {
            if (wrapper.find('.pika-calendar-apply-btn').hasClass('disabled')) {
                return; //IE 10 and below does not support pointer-events css rule
            }
            viewModel.period('Custom');
            viewModel.choosePeriod(false);

            viewModel.startDate(utility.serializeCustomDate(pikerStart.getDate()));
            viewModel.endDate(utility.serializeCustomDate(pikerEnd.getDate()));
            viewModel.tagStats.pageIndex(0);
            viewModel.tagStats.maxWidth = 0;
            viewModel.tagStats.widthPixel = 0;
            viewModel.popularContent.pageIndex(0);
            getDashboardInfoStart(function() {
                bindScrollbar();
            });
            utility.persistent.save({
                period: viewModel.period(),
                startDate: viewModel.startDate(),
                endDate: viewModel.endDate(),
                comparativeOptions: viewModel.comparativeOptions(),
                comparativeTerm: viewModel.comparativeTerm()
            });
        };

        var createComparativeTooltip = function(percentProgress, percent, removePercentageSymbol) {
            var key, tooltip, period = viewModel.period(), change = percentProgress == 1 ? 'Up_' : 'Down_';
            var formattedPercent = utility.formatAbbreviateBigNumbers(Math.abs(percent));
            if (viewModel.period() === 'Custom') {
                var startDate = utility.deserializeCustomDate(viewModel.startDate());
                var endDate = utility.deserializeCustomDate(viewModel.endDate());
                var days = Math.floor((endDate.getTime() - startDate.getTime()) / (3600 * 1000 * 24)) + 1;
                var compareStartDate = utility.moment(startDate).add('days', -days).format('D MMM YYYY');
                var compareEndDate = utility.moment(startDate).add('days', -1).format('D MMM YYYY');
                key = 'tooltip_' + change + period;
                tooltip = utility.resx.CommunityAnalytics[key].replace('{0}', formattedPercent)
                    .replace('{1}', viewModel.startDate())
                    .replace('{2}', viewModel.endDate())
                    .replace('{3}', compareStartDate)
                    .replace('{4}', compareEndDate);
            } else {
                var keys = {
                    '1 y': 'OnYear',
                    '1 m': 'OnMonth',
                    '1 w': 'OnWeek',
                    '1 d': 'OnDay'
                };
                key = 'tooltip_' + change + period + '_' + keys[viewModel.comparativeTerm()];
                tooltip = utility.resx.CommunityAnalytics[key].replace('{0}', formattedPercent);
            }
            return removePercentageSymbol ? tooltip.replace('%', '') : tooltip;
        };

        // below for mobile view
        var isWP8 = navigator.userAgent.indexOf('Windows Phone') > -1;
        var getColor = function(i) {
            return graphColors[i % graphColors.length];
        };

        var paginatedDonutChartViewModel = function(wrap) {
            var self = this;

            self.values = ko.observableArray([]);
            self.selectedIndex = ko.observable();
            self.selectedValue = ko.observable({
                label: "",
                values: []
            });
            self.count = ko.computed(function() {
                return self.values().length;
            });
            self.selectNext = function() {
                if (!self.hasNext()) return;

                self.selectedIndex(self.selectedIndex() + 1);
                self.selectedValue(self.values()[self.selectedIndex()]);
            };
            self.selectPrev = function() {
                if (!self.hasPrev()) return;

                self.selectedIndex(self.selectedIndex() - 1);
                self.selectedValue(self.values()[self.selectedIndex()]);
            };
            self.hasNext = ko.computed(function() {
                return self.selectedIndex() < self.values().length - 1;
            });
            self.hasPrev = ko.computed(function() {
                return self.selectedIndex() > 0;
            });
            self.selectedValue.subscribe(function(value) {
                updateDonutGraph($('#' + wrap), value);
            });

            return self;
        };

        var updateDonutGraph = function(wrapper, info) {
            wrapper.find('svg').remove();

            if (info == null) return;

            var values = [];
            var total = 0;
            for (var i = 0; i < info.values.length; i++) {
                var value = info.values[i].value;
                total += value;
                values.push(value);
            }

            var data;
            if (total == 0) {
                data = getEmptyDonutChartData();
            } else {
                data = [
                    { values: values, colors: graphColors }
                ];
            }

            wrapper.prepend('<svg class="donut-chart"></svg>');
            var width = wrapper.width();
            var chart = d3Charts.donutChart()
                .width(width - 10).height(width - 10).radius((width / 4) + 50).thickness(50);
            d3.select('[id="' + wrapper[0].id + '"] svg')
                .datum(data)
                .call(chart);
        };

        var getEmptyDonutChartData = function() {
            return [
                { values: [1], colors: ["#ccc"] }
            ];
        };

        tagStatsViewModel.results.subscribe(function(data) {
            if (data) updateTagsGraph(data);
        });

        var updateTags = function(data) {
            tagStatsViewModel.totalResults(data.totalResults || 0);
            tagStatsViewModel.results(data.results || []);
        };

        var moduleEngagement = new paginatedDonutChartViewModel('module-engagement-donut');
        var updateModuleEngagement = function(dataSets) {
            var data = [];

            if (dataSets.length == 0) {
                moduleEngagement.values([]);
                moduleEngagement.selectedIndex();
                moduleEngagement.selectedValue(null);
                return;
            }

            var ds = dataSets[0];
            for (var i = 0; i < ds.engagementStats.length; i++) {
                var vm = {
                    label: ds.engagementStats[i].label,
                    values: []
                };

                for (var j = 0; j < dataSets.length; j++) {
                    vm.values.push({
                        key: dataSets[j].engagementName.toUpperCase(),
                        value: dataSets[j].engagementStats[i].count,
                        color: getColor(j),
                        valueLabel: utility.formatAbbreviateBigNumbers(dataSets[j].engagementStats[i].count)
                    });
                }

                data.push(vm);
            };

            moduleEngagement.values(data);
            moduleEngagement.selectedIndex(0);
            moduleEngagement.selectedValue(data[0]);
        };

        var adoptionsAndParticipationViewModel = new paginatedDonutChartViewModel('adoptions-and-participation-donut');
        var updateAdoptionsAndParticipation = function(adoptions, participation, spectators) {
            var data = [];
            for (var i = 0; i < adoptions.length; i++) {
                var vm = {
                    label: adoptions[i].label,
                    values: [
                        {
                            key: utility.resx.CommunityAnalytics.label_Adoptions.toUpperCase(),
                            value: adoptions[i].count,
                            color: getColor(0),
                            valueLabel: utility.formatAbbreviateBigNumbers(adoptions[i].count)
                        },
                        {
                            key: utility.resx.CommunityAnalytics.label_Participation.toUpperCase(),
                            value: participation[i].count,
                            color: getColor(1),
                            valueLabel: utility.formatAbbreviateBigNumbers(participation[i].count)
                        },
                        {
                            key: utility.resx.CommunityAnalytics.label_Spectators.toUpperCase(),
                            value: spectators[i].count,
                            color: getColor(2),
                            valueLabel: utility.formatAbbreviateBigNumbers(spectators[i].count)
                        }
                    ]
                };
                data.push(vm);
            }

            adoptionsAndParticipationViewModel.values(data);
            if (data.length == 0) {
                adoptionsAndParticipationViewModel.selectedIndex();
                adoptionsAndParticipationViewModel.selectedValue(null);
            } else {
                adoptionsAndParticipationViewModel.selectedIndex(0);
                adoptionsAndParticipationViewModel.selectedValue(data[0]);
            }
        };

        var moduleCreateViewAndView = new paginatedDonutChartViewModel('module-create-donut');
        var updateModuleCreateAndView = function(createInfo, viewInfo) {
            var data = [];
            for (var i = 0; i < createInfo.length; i++) {
                var vm = {
                    label: createInfo[i].label,
                    values: [
                        {
                            key: utility.resx.CommunityAnalytics.label_Create.toUpperCase(),
                            value: createInfo[i].count,
                            color: getColor(0),
                            valueLabel: utility.formatAbbreviateBigNumbers(createInfo[i].count)
                        },
                        {
                            key: utility.resx.CommunityAnalytics.label_View.toUpperCase(),
                            value: viewInfo[i].count,
                            color: getColor(1),
                            valueLabel: utility.formatAbbreviateBigNumbers(viewInfo[i].count)
                        }
                    ]
                };
                data.push(vm);
            }

            moduleCreateViewAndView.values(data);
            if (data.length == 0) {
                moduleCreateViewAndView.selectedIndex();
                moduleCreateViewAndView.selectedValue(null);
            } else {
                moduleCreateViewAndView.selectedIndex(0);
                moduleCreateViewAndView.selectedValue(data[0]);
            }
        };

        var activityByModuleViewModel = new paginatedDonutChartViewModel('activity-by-module-donut');
        var updateActivityByModule = function(dataSets) {
            var data = [];

            if (dataSets.length == 0) {
                activityByModuleViewModel.values([]);
                activityByModuleViewModel.selectedIndex();
                activityByModuleViewModel.selectedValue(null);
                return;
            }

            var ds = dataSets[0];
            for (var i = 0; i < ds.activityStats.length; i++) {
                var vm = {
                    label: ds.activityStats[i].label,
                    values: []
                };

                for (var j = 0; j < dataSets.length; j++) {
                    vm.values.push({
                        key: dataSets[j].moduleName.toUpperCase(),
                        value: dataSets[j].activityStats[i].count,
                        color: getColor(j),
                        valueLabel: utility.formatAbbreviateBigNumbers(dataSets[j].activityStats[i].count)
                    });
                }
                data.push(vm);
            };
            activityByModuleViewModel.values(data);
            activityByModuleViewModel.selectedIndex(0);
            activityByModuleViewModel.selectedValue(data[0]);
        };

        var updateModuleEngagementGraph = function (labels, dataSets, animation) {
            wrapper.find('.module-engagement-legend').empty();
            var $moduleEngagement = wrapper.find('.module-engagement');
            $moduleEngagement.find('svg').remove();
            $moduleEngagement.append('<svg class="line-chart"></svg>');

            var data = [];
            for (var i = 0; i < dataSets.length; i++) {
                data.push({ values: dataSets[i].engagementStats, key: dataSets[i].engagementName.toUpperCase(), color: graphColors[i] });
            };

            var width = $moduleEngagement[0].clientWidth - 10;
            var height = width / 2.5;
            var chart = d3Charts.lineChart(animation, width, height)
                .labels(labels)
                .legendSelector('#' + wrapper.attr('id') +  ' .module-engagement-legend')
                .legendSettings(legendSettings)
                .updateLegendSettings(updateLegendSettings)
                .tooltipSelector('#' + wrapper.attr('id') +  ' .module-engagement > div.line-chart-tooltip')
                .tooltipLabel(utility.resx.CommunityAnalytics.tooltip_ActivityByModule)
                .yAxisFormatter(function(value) { return utility.formatCommaSeparate(value); });;

            d3.select('[id="' + wrapper.attr('id') +  '"] .module-engagement svg')
                .datum(data)
                .call(chart);
        };

        var updateModuleCreateGraph = function(labels, createValue, viewsValue, animation) {
            wrapper.find('.module-create-legend').empty();
            var $moduleCreate = wrapper.find('.module-create');
            $moduleCreate.find('svg').remove();
            $moduleCreate.append('<svg class="line-chart"></svg>');

            var data = [
                { values: createValue, key: utility.resx.CommunityAnalytics.label_Create.toUpperCase(), color: graphColors[0], tooltipLabel: utility.resx.CommunityAnalytics.tooltip_CreateSeries },
                { values: viewsValue, key: utility.resx.CommunityAnalytics.label_View.toUpperCase(), color: graphColors[1] }
            ];

            var width = $moduleCreate[0].clientWidth - 10;
            var height = width / 2.5;
            var chart = d3Charts.lineChart(animation, width, height)
                .labels(labels)
                .legendSelector('#' + wrapper.attr('id') +  ' .module-create-legend')
                .legendSettings(legendSettings)
                .updateLegendSettings(updateLegendSettings)
                .tooltipSelector('#' + wrapper.attr('id') +  ' .module-create > div.line-chart-tooltip')
                .tooltipLabel(utility.resx.CommunityAnalytics.tooltip_AdoptionsAndParticipations)
                .yAxisFormatter(function(value) { return utility.formatCommaSeparate(value); });


            d3.select('[id="' + wrapper.attr('id') +  '"] .module-create svg')
                .datum(data)
                .call(chart);
        };

        var updateAdoptionsAndParticipationGraph = function(labels, adoptions, participation, spectators, animation) {
            wrapper.find('.adoptions-and-participation-legend').empty();
            var $adoptionsAndParticipation = wrapper.find('.adoptions-and-participation');
            $adoptionsAndParticipation.find('svg').remove();
            $adoptionsAndParticipation.append('<svg class="line-chart"></svg>');

            var data = [
                { values: adoptions, key: utility.resx.CommunityAnalytics.label_Adoptions.toUpperCase(), color: graphColors[0] },
                { values: participation, key: utility.resx.CommunityAnalytics.label_Participation.toUpperCase(), color: graphColors[1] },
                { values: spectators, key: utility.resx.CommunityAnalytics.label_Spectators.toUpperCase(), color: graphColors[2] }
            ];

            var width = $adoptionsAndParticipation[0].clientWidth - 10;
            var height = width / 2.5;
            var chart = d3Charts.lineChart(animation, width, height)
                .labels(labels)
                .legendSelector('#' + wrapper.attr('id') +  ' .adoptions-and-participation-legend')
                .legendSettings(legendSettings)
                .updateLegendSettings(updateLegendSettings)
                .tooltipSelector('#' + wrapper.attr('id') +  ' .adoptions-and-participation > div.line-chart-tooltip')
                .tooltipLabel(utility.resx.CommunityAnalytics.tooltip_AdoptionsAndParticipations)
                .yAxisFormatter(function(value) { return utility.formatCommaSeparate(value); });

            d3.select('[id="' + wrapper.attr('id') + '"] .adoptions-and-participation svg')
                .datum(data)
                .call(chart);
        };

        var updateActivityByModuleGraph = function(labels, dataSets, animation) {
            wrapper.find('.activity-by-module-legend').empty();
            var $activityByModule = wrapper.find('.activity-by-module');
            $activityByModule.find('svg').remove();
            $activityByModule.append('<svg class="line-chart"></svg>');

            var data = [];
            for (var i = 0; i < dataSets.length; i++) {
                data.push({ values: dataSets[i].activityStats, key: dataSets[i].moduleName.toUpperCase(), color: graphColors[i] });
            };

            var width = $activityByModule[0].clientWidth - 10;
            var height = width / 2.5;
            var chart = d3Charts.lineChart(animation, width, height)
                .labels(labels)
                .legendSelector('#' + wrapper.attr('id') +  ' .activity-by-module-legend')
                .legendSettings(legendSettings)
                .updateLegendSettings(updateLegendSettings)
                .tooltipSelector('#' + wrapper.attr('id') +  ' .activity-by-module > div.line-chart-tooltip')
                .tooltipLabel(utility.resx.CommunityAnalytics.tooltip_ActivityByModule)
                .yAxisFormatter(function(value) { return utility.formatCommaSeparate(value); });

            d3.select('[id="' + wrapper.attr('id') + '"] .activity-by-module svg')
                .datum(data)
                .call(chart);
        };

        var updateTagsGraph = function(data, animation) {
            var $tagsContainer = wrapper.find('.trending-tags');
            $tagsContainer.html('');

            var width = 370;
            var results;

            tagStatsViewModel.totalResults(data.totalResults || 0);
            results = data.results || [];

            if (tagStatsViewModel.totalResults() < 1) {
                $tagsContainer.append('<p>' + utility.resx.CommunityAnalytics.txt_NoTrendingTags + '</p>');
                return;
            }

            $tagsContainer.append('<svg class="horizontal-bar-chart"></svg>');
            var max = d3.max(results, function(d) { return d.count; }) || 0;
            var tagsWidth;
            if (tagStatsViewModel.max < max) {
                tagStatsViewModel.max = max;
                tagsWidth = width;
            } else {
                tagsWidth = Math.round((width / tagStatsViewModel.max) * max);
            }

            for (var i = 0; i < results.length; i++) {
                results[i].valueLabel = utility.formatAbbreviateBigNumbers(results[i].count);
                results[i].valueTooltip = utility.formatCommaSeparate(results[i].count);
            }

            var chart = d3Charts.horizontalBarChart(tagsWidth, animation).width(width);
            d3.select('[id="' + wrapper.attr('id') + '"] .trending-tags svg')
                .datum(results)
                .call(chart);
        };

        var updateAreaGraph = function(d) {
            var $problemChartArea = wrapper.find('.problemarea-chart-area');
            $problemChartArea.find('svg').remove();
            $problemChartArea.prepend('<svg class="donut-chart"></svg>');

            var data = [];
            $.each(d, function(i, v) {
                if (v.isNA) {
                    data.push({ values: [1], colors: ['#ccc'] });
                } else {
                    var p = v.percent;
                    data.push({ values: [p, 100 - p], colors: graphColors });
                }
            });

            var chart = d3Charts.areaDonutChart();
            d3.selectAll('#' + wrapper.attr('id') + ' .problemarea-chart-area svg')
                .datum(data)
                .call(chart);
        };

        var bindScrollbar = function() {
            setTimeout(function() {
                var holder = wrapper.find('div.module-performance-card-holder');
                var cards = wrapper.find('div.module-performance-card', holder);
                var left = wrapper.find('a.module-performance-scroll-left');
                var right = wrapper.find('a.module-performance-scroll-right');
                var initialOffset = 45;
                var scrollOffset = 243;
                var maxWidth = wrapper.find(".module-performance").width();
                var visibleCount = wrapper.find('.module-performance-card').filter(function () {
                    return $(this).position().left + $(this).width() < maxWidth;
                }).length;
                scroller.init(holder, cards, left, right, initialOffset, scrollOffset, visibleCount);
            }, 100);
        };

        var $idown;
        var exportDashboard = function() {

            var comparativeTerm = viewModel.period() == 'Custom' ? 'c' : viewModel.comparativeTerm();

            var url = config.siteRoot + 'api/dnncorp/cmx/SpreadsheetExport/Excel?' +
                $.param({
                    period: viewModel.period(),
                    startDate: viewModel.startDate(),
                    endDate: viewModel.endDate(),
                    comparativeTerm: comparativeTerm,
                    moduleName: thisModuleName,
                });

            if ($idown) {
                $idown.attr('src', url);
            } else {
                $idown = $('<iframe>', { src: url }).hide().appendTo('body');
            }
        };

        var setModuleName = function() {
            var name = thisModuleName ? thisModuleName : utility.resx.CommunityAnalytics.nav_Dashboard;
            wrapper.find(".module-title").text(name);
        };

        var rebindOnResize = function() {
            $(window).resize(function() {
                if (thisModuleName) {
                    moduleEngagement.selectedValue.valueHasMutated();
                    moduleCreateViewAndView.selectedValue.valueHasMutated();
                } else {
                    activityByModuleViewModel.selectedValue.valueHasMutated();
                    adoptionsAndParticipationViewModel.selectedValue.valueHasMutated();
                }
                tagStatsViewModel.results.valueHasMutated();
            });
        };

        var refreshCarousel = function() {
            setTimeout(function() {
                var holder = wrapper.find(".module-performance-card-holder");
                if (holder.data('owlCarousel')) {
                    holder.data('owlCarousel').reinit();
                    return;
                }

                holder.owlCarousel({
                    itemsCustom: [[0, 1], [490, 2], [730, 3]],
                    navigation: false
                });
            }, 100);
        };
        // above for mobile view

        var viewModel = {};
        var triggerComparativeTerm = true;
        var koBinded = false;

        this.init = function (wrap, util, params, callback) {
            wrapper = wrap;
            utility = util;
            pager.init(popularContentViewModel, 5, getPopularContent, utility.resx.CommunityAnalytics);
            pager.init(tagStatsViewModel, 6, getTagStats, utility.resx.CommunityAnalytics);
            thisModuleName = params.query;

            var userSettings = utility.persistent.load();
            legendSettings = userSettings['legends'] || [];

            var periods = [
              { value: 'Year', label: utility.resx.CommunityAnalytics.opt_Year },
              { value: 'Month', label: utility.resx.CommunityAnalytics.opt_Month },
              { value: 'Week', label: utility.resx.CommunityAnalytics.opt_Week },
              { value: 'Day', label: utility.resx.CommunityAnalytics.opt_Day }
            ];

            var socialModules = [
                { value: 'Answers', label: utility.resx.CommunityAnalytics.Answers },
                { value: 'Blogs', label: utility.resx.CommunityAnalytics.Blogs },
                { value: 'Challenges', label: utility.resx.CommunityAnalytics.Challenges },
                { value: 'Discussions', label: utility.resx.CommunityAnalytics.Discussions },
                { value: 'Social Events', label: utility.resx.CommunityAnalytics.Events },
                { value: 'Ideas', label: utility.resx.CommunityAnalytics.Ideas },
                { value: 'Wiki', label: utility.resx.CommunityAnalytics.Wiki }
            ];

            var switchModule = function(data) {
                //communityanalytics-extensions CommunityAnalytics_Answers-extension
                var $modulePanes = $('#communityanalytics-extensions > div');
                $modulePanes.removeClass('selected');

                $('[id="Evoq.CommunityAnalytics_' + data.value.replace(" ", "") + '-extension"]').addClass('selected');
            }

            var userSettingsPeriod = userSettings.period;
            var defaultDate = utility.serializeCustomDate(new Date(new Date().toUTCString()));

            viewModel = {
                resx: utility.resx.CommunityAnalytics,
                periods: periods,
                periodLabel: periodLabel,
                period: ko.observable(userSettingsPeriod),
                startDate: ko.observable(userSettings.startDate || defaultDate),
                endDate: ko.observable(userSettings.endDate || defaultDate),
                startDateLabel: ko.observable(),
                endDateLabel: ko.observable(),
                applyCustomDates: applyCustomDates,
                comparativeTerm: ko.observable(userSettings.comparativeTerm),
                comparativeOptions: ko.observableArray(getComparativeOptions(userSettingsPeriod)),
                choosePeriod: ko.observable(false),
                socialModules: socialModules,
                moduleName: thisModuleName,
                switchModule: switchModule,
                showPeriodSelect: function () {
                    viewModel.choosePeriod(true);
                    var hideFunc = function() {
                        viewModel.choosePeriod(false);

                        $(window).off('click', hideFunc);
                    };
                    $(window).on('click', hideFunc);
                },
                changePeriod: function (data, event) {
                    if (!data) return;
                    var newPeriod = $(event.target).data('value');
                    var oldPeriod = this.period();
                    var oldComparativeTerm = this.comparativeTerm();
                    this.period(newPeriod);
                    triggerComparativeTerm = false;
                    this.comparativeOptions(getComparativeOptions(newPeriod));
                    var newComparativeTerm = getComparativeTerm(newPeriod);
                    this.comparativeTerm(newComparativeTerm);
                    triggerComparativeTerm = true;
                    // we manually trigger it
                    if (newPeriod !== oldPeriod || newComparativeTerm !== oldComparativeTerm) {
                        refreshDashboard();
                    }
                },
                showCustomCalendar: function () {
                    // SOCIAL-3584: sync custom calender with period
                    var period = this.period();
                    if (period == 'Custom' && viewModel.startDate() && viewModel.endDate()) {
                        viewModel.initialStartDate = new Date(viewModel.startDate());
                        viewModel.initialEndDate = new Date(viewModel.endDate());
                        viewModel.initialStartDate.setHours(0, 0, 0, 0);
                        viewModel.initialEndDate.setHours(0, 0, 0, 0);
                        pikerStart.setDate(utility.deserializeCustomDate(viewModel.startDate()));
                        pikerEnd.setDate(utility.deserializeCustomDate(viewModel.endDate()));
                    } else {
                        var now = new Date(new Date().toUTCString());
                        now.setDate(now.getDate() - 1);
                        viewModel.initialEndDate = new Date(now.getTime());
                        viewModel.initialEndDate.setHours(0, 0, 0, 0);
                        pikerEnd.setDate(now);
                        switch (period) {
                            case "Week":
                                now.setDate(now.getDate() - 6);
                                break;
                            case "Month":
                                now.setMonth(now.getMonth() - 1);
                                now.setDate(now.getDate() + 1);
                                break;
                            case "Year":
                                now.setYear(now.getFullYear() - 1);
                                now.setDate(now.getDate() + 1);
                                break;
                        }
                        viewModel.initialStartDate = new Date(now.getTime());
                        viewModel.initialStartDate.setHours(0, 0, 0, 0);
                        pikerStart.setDate(now);
                    }
                    wrapper.find('.pika-calendar-apply-btn').addClass('disabled');

                    pikerContainer.show();
                    var hidePikerHandler = function () {
                        pikerContainer.hide();
                        viewModel.changePeriod(false);
                        $(window).off('click', hidePikerHandler);
                    };
                    $(window).on('click', hidePikerHandler);
                },
                percentProgress: {
                    higher: 1,
                    equal: 0,
                    lower: -1
                },
                tagStats: tagStatsViewModel,
                popularContent: popularContentViewModel,
                topSpectators: topSpectators,
                mostActiveUsers: mostActiveUsers,
                powerRankings: powerRankings,
                create: create,
                engagement: engagement,
                totalViews: totalViews,
                totalViewsDetail: totalViewsDetail,
                areas: areas,
                moduleEngagement: moduleEngagement,
                moduleCreateViewAndView: moduleCreateViewAndView,
                adoptionsAndParticipation: adoptionsAndParticipationViewModel,
                activityByModule: activityByModuleViewModel,
                modulePerformance: modulePerformance,
                moduleDashboard: ko.observable(thisModuleName && thisModuleName.length > 0),
                dashboardTitle: ko.observable(''),
                exportDashboard: exportDashboard,
                pikerStart: pikerStart,
                pikerEnd: pikerEnd,
                pikerContainer: pikerContainer,
                adoptionParticipation: adoptionParticipation,
                activities: activities
            };

            viewModel.fullDateFilter = ko.computed(function () {
                return this.period() + " " + this.startDate() + " " + this.endDate() + " " + this.comparativeTerm();
            }, viewModel);

            thisModuleName ? viewModel.dashboardTitle(thisModuleName) : viewModel.dashboardTitle(utility.resx.CommunityAnalytics.nav_Dashboard);
            utility.asyncParallel([
                function (cb1) {
                    getDashboardInfoStart(cb1);
                }
            ], function () {
                viewModel.fullDateFilter.subscribe(refreshDashboard);

                bindScrollbar();
                setTimeout(function () {
                    wrapper.find('.dashboard-panel .percent-progress').qaTooltip();
                }, 300);

                params = $.extend({}, params, {
                    mode: "site",
                    pageId: -1
                });
                analyticsModuleInstance.init(wrapper, util, params, callback, viewModel);

                if (typeof callback === 'function') callback(wrapper);
            });
        }

        this.load = function (params, callback) {
            var userSettings = utility.persistent.load();
            thisModuleName = params.query;
            legendSettings = userSettings['legends'] || [];
            thisModuleName ? viewModel.dashboardTitle(thisModuleName) : viewModel.dashboardTitle(utility.resx.CommunityAnalytics.nav_Dashboard);
            viewModel.moduleDashboard(thisModuleName && thisModuleName.length > 0);
            viewModel.tagStats.pageIndex(0);
            viewModel.tagStats.maxWidth = 0;
            viewModel.tagStats.widthPixel = 0;
            viewModel.popularContent.pageIndex(0);
            var userSettingsPeriod = userSettings.period;
            var defaultDate = utility.serializeCustomDate(new Date(new Date().toUTCString()));

            triggerComparativeTerm = false;
            viewModel.periodLabel("");
            viewModel.period(userSettingsPeriod);
            viewModel.startDate(userSettings.startDate || defaultDate);
            viewModel.endDate(userSettings.endDate || defaultDate);
            viewModel.comparativeOptions(getComparativeOptions(userSettingsPeriod));
            viewModel.comparativeTerm(userSettings.comparativeTerm);
            triggerComparativeTerm = true;

            getDashboardInfoStart(function () {
                bindScrollbar();
                if (typeof callback === 'function') callback();
            });
        }
    };

    return dashboardClass;
});