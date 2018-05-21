﻿// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

(function ($, window) {

    'use strict';

    $.Calendario = function (options, element) {
        this.$el = $(element);
        this._init(options);
    };

    // the options
    $.Calendario.defaults = {
        /*
        you can also pass:
        month : initialize calendar with this month (1-12). Default is today.
        year : initialize calendar with this year. Default is today.
        caldata : initial data/content for the calendar.
        caldata format:
        {
        'MM-DD-YYYY' : 'HTML Content',
        'MM-DD-YYYY' : 'HTML Content',
        'MM-DD-YYYY' : 'HTML Content'
        ...
        }
        */
        weeks: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
        weekabbrs: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
        months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
        monthabbrs: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        // choose between values in options.weeks or options.weekabbrs
        displayWeekAbbr: false,
        // choose between values in options.months or options.monthabbrs
        displayMonthAbbr: false,
        // left most day in the calendar
        // 0 - Sunday, 1 - Monday, ... , 6 - Saturday
        startIn: 1,
        onDayClick: function () { return false; },
        caldataFormat: 'MM-dd-yyyy'
    };

    $.Calendario.prototype = {
        _init: function (options) {
            this.options = $.extend(true, {}, $.Calendario.defaults, options);
            this.today = new Date(); 
            if (this.options.today)
                this.today = new Date(this.options.today.year, this.options.today.month - 1, this.options.today.day);

            this.month = (isNaN(this.options.month) || this.options.month == null) ? this.today.getMonth() : this.options.month - 1;
            this.year = (isNaN(this.options.year) || this.options.year == null) ? this.today.getFullYear() : this.options.year;
            this.caldata = this.options.caldata || [];
            this._generateTemplate();
            this._initEvents();
        },
        
        _initEvents: function () {
            var self = this;
            this.$el.on('click.calendario', 'div.fc-row > div', function (e) {
                var $cell = $(this),
                hasEvent = $cell.hasClass('fc-content'),
                inThisMonth = $cell.find('span.fc-date').length > 0;
                var day = inThisMonth ? $cell.children('span.fc-date').text() : $cell.children('span.other-month').text();
                var month = inThisMonth ? self.month + 1 : parseInt($cell.children('span.other-month').attr('data-other-month'));
                var year = inThisMonth ? self.year : parseInt($cell.children('span.other-month').attr('data-other-year'));

                var dateProp = {
                    day: day,
                    month: month,
                    year: year
                };

                if (dateProp.day) {
                    self.options.onDayClick($cell, hasEvent, dateProp);
                }
                if(e) e.stopPropagation();
                if(window.event) window.event.cancelBubble = true;
                return false;
            });

        },
        
        _generateTemplate: function (callback) {
            var head = this._getHead(),
            body = this._getBody(),
            rowClass;
            switch (this.rowTotal) {
                case 4: rowClass = 'fc-four-rows'; break;
                case 5: rowClass = 'fc-five-rows'; break;
                case 6: rowClass = 'fc-six-rows'; break;
            }
            
            this.$cal = $('<div class="fc-calendar ' + rowClass + '">').append(head, body);
            this.$el.find('div.fc-calendar').remove().end().append(this.$cal);
            if (callback) { callback.call(); }
        },
        
        _getHead: function () {
            var html = '<div class="fc-head">';
            for (var i = 0; i <= 6; i++) {
                var pos = i + this.options.startIn,
                j = pos > 6 ? pos - 6 - 1 : pos;

                html += '<div>';
                html += this.options.displayWeekAbbr ? this.options.weekabbrs[j] : this.options.weeks[j];
                html += '</div>';
            }

            html += '</div>';
            return html;
        },
        
        _formatCalDataStr: function(m, d, y) {
            var dformat = this.options.caldataFormat;
            var month = (m + 1 < 10 ? '0' + (m + 1) : m + 1) + '';
            var day = (d < 10 ? '0' + d : d) + '';
            var year = y;

            var result = dformat.replace(/MM/g, month);
            result = result.replace(/dd/g, day);
            result = result.replace(/yyyy/g, year);

            return result;
        },
        
        _getBody: function () {

            var d = new Date(this.year, this.month + 1, 0),
            monthLength = d.getDate(),
            firstDay = new Date(this.year, this.month, 1);

            this.startingDay = firstDay.getDay();

            var html = '<div class="fc-row">',
            day = 1;
            
            for (var i = 0; i < 7; i++) {
                for (var j = 0; j <= 6; j++) {
                    var pos = this.startingDay - this.options.startIn,
                    p = pos < 0 ? 6 + pos + 1 : pos,
                    inner = '',
                    today = this.month === this.today.getMonth() && this.year === this.today.getFullYear() && day === this.today.getDate(),
                    strdate;

                    if (day <= monthLength && (i > 0 || j >= p)) {
                        inner += '<span class="fc-date">' + day + '</span>';
                        strdate = this._formatCalDataStr(this.month, day, this.year);
                        ++day;
                    }
                    else {
                        var date, otherMonth, otherYear;
                        if (i == 0) {
                            var z = p - j;
                            var d = new Date(this.year, this.month, 1);
                            d.setDate(d.getDate() - z);
                            date = d.getDate();
                            otherMonth = this.month;
                            otherYear = this.month == 0 ? this.year - 1 : this.year;
                        }
                        else {
                            date = day - monthLength;
                            otherMonth = this.month + 2;
                            otherYear = this.month == 11 ? this.year + 1 : this.year;
                            ++day;
                        }
                        otherMonth = otherMonth > 12 ? otherMonth - 12 : otherMonth == 0 ? otherMonth + 1 : otherMonth;
                        strdate = this._formatCalDataStr(otherMonth - 1, date, otherYear);
                        inner = '<span class="other-month" data-other-month="' + otherMonth + '" data-other-year="' + otherYear  + '" >' + date + '</span>';
                        today = false;
                    }

                    var cellClasses = today ? 'fc-today ' : '';
                    var dayData = this.caldata.indexOf(strdate) > -1;
                    if (dayData) {
                        cellClasses += 'fc-content';
                    }

                    html += cellClasses !== '' ? '<div class="' + cellClasses + '">' : '<div>';
                    html += inner;
                    html += '</div>';
                }
                
                if (day > monthLength) {
                    this.rowTotal = i + 1;
                    break;
                }
                else {
                    html += '</div><div class="fc-row">';
                }
            }
            
            html += '</div>';
            return html;
        },

        _isValidDate: function (date) {
            date = date.replace(/-/gi, '');
            var month = parseInt(date.substring(0, 2), 10),
            day = parseInt(date.substring(2, 4), 10),
            year = parseInt(date.substring(4, 8), 10);

            if ((month < 1) || (month > 12)) {
                return false;
            }
            else if ((day < 1) || (day > 31)) {
                return false;
            }
            else if (((month == 4) || (month == 6) || (month == 9) || (month == 11)) && (day > 30)) {
                return false;
            }
            else if ((month == 2) && (((year % 400) == 0) || ((year % 4) == 0)) && ((year % 100) != 0) && (day > 29)) {
                return false;
            }
            else if ((month == 2) && ((year % 100) == 0) && (day > 29)) {
                return false;
            }

            return {
                day: day,
                month: month,
                year: year
            };
        },
        
        _move: function (period, dir, callback) {
            if (dir === 'previous') {
                if (period === 'month') {
                    this.year = this.month > 0 ? this.year : --this.year;
                    this.month = this.month > 0 ? --this.month : 11;
                }
                else if (period === 'year') {
                    this.year = --this.year;
                }
            }
            else if (dir === 'next') {
                if (period === 'month') {
                    this.year = this.month < 11 ? this.year : ++this.year;
                    this.month = this.month < 11 ? ++this.month : 0;
                }
                else if (period === 'year') {
                    this.year = ++this.year;
                }
            }

            this._generateTemplate(callback);
        },
      
        getYear: function () {
            return this.year;
        },
        getMonth: function () {
            return this.month + 1;
        },
        getMonthName: function () {
            return this.options.displayMonthAbbr ? this.options.monthabbrs[this.month] : this.options.months[this.month];
        },
        getCell: function (day) {
            var row = Math.floor((day + this.startingDay - this.options.startIn) / 7),
            pos = day + this.startingDay - this.options.startIn - (row * 7) - 1;
            return this.$cal.find('div.fc-body').children('div.fc-row').eq(row).children('div').eq(pos).children('div');
        },
        
        setData: function (caldata) {

            caldata = caldata || [];
            $.extend(this.caldata, caldata);
            this._generateTemplate();

        },
        
        gotoNow: function (callback) {
            this.month = this.today.getMonth();
            this.year = this.today.getFullYear();
            this._generateTemplate(callback);
        },
        
        goto: function (month, year, callback) {
            this.month = month - 1;
            this.year = year;
            this._generateTemplate(callback);
        },
        gotoPreviousMonth: function (callback) {
            this._move('month', 'previous', callback);
        },
        gotoPreviousYear: function (callback) {
            this._move('year', 'previous', callback);
        },
        gotoNextMonth: function (callback) {
            this._move('month', 'next', callback);
        },
        gotoNextYear: function (callback) {
            this._move('year', 'next', callback);
        }
    };

    var logError = function (message) {
        if (window.console) {
            window.console.error(message);
        }
    };

    $.fn.calendario = function (options) {
        var instance = $.data(this, 'calendario');
        if (typeof options === 'string') {
            var args = Array.prototype.slice.call(arguments, 1);
            this.each(function () {
                if (!instance) {
                    logError("cannot call methods on calendario prior to initialization; " +
                    "attempted to call method '" + options + "'");
                    return;
                }
                if (!$.isFunction(instance[options]) || options.charAt(0) === "_") {
                    logError("no such method '" + options + "' for calendario instance");
                    return;
                }
                instance[options].apply(instance, args);
            });
        }
        else {
            this.each(function () {
                if (instance) {
                    instance._init();
                }
                else {
                    instance = $.data(this, 'calendario', new $.Calendario(options, this));
                }
            });
        }
        return instance;
    };
})(jQuery, window);