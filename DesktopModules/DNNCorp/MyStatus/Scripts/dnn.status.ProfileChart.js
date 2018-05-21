// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.status === 'undefined') dnn.status = {};

(function(dnn) {
    'use strict';

    dnn.status.ProfileChart = function ProfileChart ($, ko, settings, social, profile) {
        var that = this;

        this.completed = ko.computed(
            function () {
                if (typeof profile.dynamic() !== 'undefined') {
                    return profile.dynamic().completed();
                }

                return 0;
            });

        this.bindControls = function () {
            var canvas = $('canvas.chart')[0];
            if (canvas == null || canvas.length == 0) {
                return null;
            }

            if (typeof canvas.getContext !== 'function') {
                return null;
            }

            var ctx = canvas.getContext('2d');
            if (ctx == null) {
                return null;
            }
            
            var grad = ctx.createRadialGradient(40, 30, 100, 60, 60, 4);
            grad.addColorStop(0.0, settings.profileColor1);
            grad.addColorStop(1.0, settings.profileColor2);
            ctx.strokeStyle = grad;

            var x = 70;
            var y = 75;
            var radius = 55;
            var startAngle = 1.5 * Math.PI;
            var endAngle = (1.5 + ((that.completed() / 100) * 2.0)) * Math.PI;
            
            ctx.beginPath();
            ctx.arc(x, y, radius, startAngle, endAngle, false);
            ctx.lineWidth = 30;
            ctx.stroke();

            if (that.completed() < 100) {
                grad = ctx.createRadialGradient(30, 30, 100, 30, 30, 1);
                grad.addColorStop(0.0, '#eee');
                grad.addColorStop(1.0, '#ccc');
                ctx.strokeStyle = grad;

                var emptyStartAngle = endAngle;
                var emptyEndAngle = 3.5 * Math.PI;

                ctx.beginPath();
                ctx.arc(x, y, radius, emptyStartAngle, emptyEndAngle, false);
                ctx.lineWidth = 30;
                ctx.stroke();
            }

            $('.qaTooltip', settings.moduleScope).qaTooltip();
        };
    };
})(window.dnn);