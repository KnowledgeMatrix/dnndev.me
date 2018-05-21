// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.dashboard === 'undefined') dnn.dashboard = {};

(function (dnn) {
    'use strict';

    dnn.dashboard.D3Heatmap = function Heatmap(settings, social, chartSettings) {
        var self = this;
        this.data = [];
        this.containerId = chartSettings.containerId;
        this.colors = ["#EEEEEE", "#FFD699", "#FFC266", "#FFAD33", "#FF9900"];
        this.load = function () {
            var failure = function () {
            };

            var success = function (m) {
                self.data = m;
                self.draw();
            };

            var service = social.getService('Charts');

            var params = {};

            if (typeof chartSettings.extendedOptions == 'function') {
                $.extend(params, chartSettings.extendedOptions());
            }

            service.get(chartSettings.method, params, success, failure);
        };

        this.loadDetail = function(date, count) {
            var failure = function () {
            };

            var success = function (m) {
                if (typeof chartSettings.detailCallback == 'function')
                    chartSettings.detailCallback(m, date);
            };

            if (count < 1) {
                success([]);
                return;
            }
            
            var service = social.getService('Charts');

            var splits = date.split('-');
            var year = splits[0];
            var month = splits[1];
            var day = splits[2];

            var params = { year: year, month: month, day: day };

            if (typeof chartSettings.extendedOptions == 'function') {
                $.extend(params, chartSettings.extendedOptions());
            }

            service.get(chartSettings.detailMethod, params, success, failure);
        };

        this.draw = function () {
            if (!self.data || !self.data.length) {
                return;
            }
            
            $('#' + this.containerId).empty();
            var margin = { top: 15, right: 0, bottom: 0, left: 15 },
                width = $('#' + self.containerId).width() - margin.left - margin.right,
                height = 150 - margin.top - margin.bottom;

            var rows = Math.floor(self.data.length / 7) + 1;
            var gridSize = Math.floor(width / rows);

            if (gridSize < 2) return;
            var colorCount = self.colors.length;
            var dmax = d3.max(self.data, function (d) { return d[1]; });
            dmax = dmax >= colorCount ? dmax : colorCount;
            var colorScale = d3.scale.quantile().domain([0, dmax]).range(self.colors);
            
            var getDay = function(d) {
                var format = d3.time.format("%Y-%m-%d");
                var t = format.parse(d);
                var day = t.getDay();
                if (day == 7) day = 0;
                return day;
            };
            
            var getMonth = function (d) {
                var format = d3.time.format("%Y-%m-%d");
                var t = format.parse(d);
                return t.getMonth();
            };
            var f = getDay(self.data[0][0]);
            
            var x = function (d, i) {
                var xPos = Math.floor((i + f) / 7) * gridSize + 1;
                var month = getMonth(d[0]);
                if (month != latestpushedmonth) {
                    months.push({ month: month, xPos: xPos });
                    latestpushedmonth = month;
                }
                return xPos;
            };
            
            var y = function(d) {
                var day = getDay(d[0]);
                return day * gridSize + 1;
            };

            var days = ['M', 'W', 'F'], months = [], latestpushedmonth = -1 ;
                
            var svg = d3.select("#" + self.containerId).append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
            
            svg.selectAll('.dayLabel')
                .data(days).enter().append('text')
                .text(function (d) { return d; })
                .attr('class', 'dayLabel')
                .attr('x', 0)
                .attr('y', function (d, i) { return (i * 2 + 1) * gridSize - 2; })
                .style("text-anchor", "end")
                .attr("transform", "translate(-6," + gridSize + ")");
            
            var hoverOn = false;
            svg.selectAll('.day').data(self.data).enter().append('rect')
                .attr('x', x)
                .attr('y', y)
                .attr("class", "day")
                .attr("width", gridSize - 2)
                .attr("height", gridSize - 2)
                .style("fill", function(d) { return colorScale(d[1]); })
                .on('mouseenter', function(d) {
                    var parent = $(this).parent().parent();
                    var m = d3.mouse(parent[0]);
                    var count = d[1];
                    var date = d[0];
                    var activity = count == 1 ? 'activity' : 'activities';
                    var c = count == 0 ? 'No ' : count + ' ';
                    $('.tag-menu.heatmap-tag-menu')
                        .html('<p><b>' + c + activity + '</b> on ' + date + '</p>')
                        .css({
                            top: m[1] - 45,
                            left: m[0] - 25
                        })
                        .show();
                    hoverOn = true;
                })
                .on('mouseout', function(d) {
                    hoverOn = false;
                    setTimeout(function() {
                        if (!hoverOn) {
                            $('.tag-menu.heatmap-tag-menu').hide();
                        }
                    }, 300);
                })
                .on('click', function (d) {
                    self.loadDetail(d[0], d[1]);
                    return false;
                });

            var monthLabels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            // here I adds a logic to remove first or last month label based on what date is today
            var ddd = new Date().getDate();
            if (ddd > 15) {
                months.shift();
            } else {
                months.pop();
            }
            
            svg.selectAll('.monthLabel')
                .data(months).enter().append('text')
                .text(function (d) { return monthLabels[d.month]; })
                .attr('class', 'monthLabel')
                .attr('x', function (d) { return d.xPos; })
                .attr('y', '0')
                .style("text-anchor", "middle")
                .attr("transform", "translate(" + gridSize / 2 + ", -4)");

            
            svg.selectAll(".legend")
               .data(self.colors)
               .enter().append("rect")
               .attr("class", "legend")
               .attr("x", function (d, i) { return gridSize * (rows - colorCount + i - 2) - 3; })
               .attr("y", function (d) { return gridSize * 9;  })
               .attr("width", gridSize - 2)
               .attr("height", gridSize - 2)
               .style("fill", function (d, i) { return self.colors[i]; });

            svg.append('text')
                .text('Less')
                .attr('class', 'legendLabel')
                .attr('x', gridSize * (rows - colorCount - 2) - 6)
                .attr('y', gridSize * 10 - 3)
                .style("text-anchor", "end");
            
            svg.append('text')
               .text('More')
               .attr('class', 'legendLabel')
               .attr('x', gridSize * rows)
               .attr('y', gridSize * 10 - 3)
               .style("text-anchor", "end");
        };
    };

})(window.dnn);