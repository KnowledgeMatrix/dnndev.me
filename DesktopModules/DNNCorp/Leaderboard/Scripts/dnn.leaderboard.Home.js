// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.leaderboard === 'undefined') dnn.leaderboard = {};

(function(dnn) {
    'use strict';
    
    dnn.leaderboard.Home = function Home ($, dnn, ko, settings) {
        var that = this;

        $.extend(this, settings);

        this.social = new dnn.social.Module(settings);

        this.localizer = that.social.getLocalizationController();

        this.mode = ko.observable(settings.mode);

        this.searchText = ko.observable();

        this.placeholder = $('.leaderboardSearchInput', settings.moduleScope).attr('placeholder');

        var viewportSettings = {
            mode: this.mode
        };

        this.viewport = new dnn.leaderboard.PagedBoard($, ko, settings, that.social, viewportSettings, that);

        this.mobileViewport = new dnn.leaderboard.MobileBoard($, ko, settings, that.social, viewportSettings, that);

        this.refresh = function () {
            var searchText = that.searchText() || '';
            if (searchText == that.placeholder) {
                searchText = '';
            }

            if (!that.isMobileView()) {

                that.viewport.resetCache();
                that.viewport.searchText = searchText;

                that.viewport.loadLeaders(
                    function() {
                        $('.leaderboard-badge-tooltip', settings.moduleScope).qaTooltip();
                    });
            } else {

                that.mobileViewport.searchText = searchText;
                that.mobileViewport.loadLeaders();
            }
        };

        this.isModeToMeEnabled = ko.computed(function () {
            return that.viewport.canScrollToMe();
        });

        this.switchModeToMe = function () {
            that.viewport.scrollToMe();            
        };

        var modeChanged = function(m) {
            if (m && !that.isMobileView()) {
                $('.leaderboardMode > ul.dnnButtonGroup > li').removeClass('selected');
                $('.leaderboardMode > ul.dnnButtonGroup > li[data-mode="' + m + '"]').addClass('selected');
            }
            that.refresh();
        };

        this.mode.subscribe(function(m) {
            modeChanged(m);
        });

        this.switchModeToEveryone = function () {
            that.rankMode = settings.rankMode;
            that.mode('allusers');
        };

        this.switchModeToFriends = function () {
            that.rankMode = settings.rankMode;
            that.mode('friends');
        };

        this.switchModeToMembers = function () {
            that.rankMode = settings.rankMode;
            that.mode('members');
        };

        this.memberModeVisible = ko.computed(
            function () {
                return that.groupId >= 0;
            });

        this.search = function () {
            that.rankMode = settings.rankMode;
            that.refresh();
        };

        this.closeHelp = function () {
            $(settings.helpScope).dialog('close');
        };

        this.helpBinded = false;
        this.help = function (resourceKey) {
            var localizer = that.social.getLocalizationController();
            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                title: localizer.getString('LeaderboardTitle_{0}'.format(resourceKey)),
                minWidth: 800,
                buttons: [
                    {
                        priority: 'primary',
                        'class': 'dnnPrimaryAction',
                        text: localizer.getString('OK'),
                        click: that.closeHelp
                    }
                ]
            };

            var viewModel = {
                text: localizer.getString('LeaderboardHelp_{0}'.format(resourceKey))
            };

            if (!that.helpBinded) {
                ko.applyBindings(viewModel, settings.helpScope);
                that.helpBinded = true;
            }

            $(settings.helpScope).dialog(options);
        };
        
        this.searchText.subscribe(
            function () { 
                if (typeof that.searchTimeout !== 'undefined') {
                    clearTimeout(that.searchTimeout);
                }

                that.searchTimeout = setTimeout(
                    function () {
                        delete that.searchTimeout;
                        that.refresh();
                    }, 350);
            });
 
        var isPlaceHolderSupported = !!("placeholder" in document.createElement("input"));
        if (!isPlaceHolderSupported) {           
            that.searchText(that.placeholder);
            $('.leaderboardSearchInput', settings.moduleScope).addClass('placeHolder');
            $(function () {
                $('.leaderboardSearchInput', settings.moduleScope).focus(function () {
                    if (that.searchText() == that.placeholder) {
                        that.searchText('');
                        $(this).removeClass('placeHolder');
                    }
                })
                .blur(function () {
                    if (String.isEmpty(that.searchText())) {
                        that.searchText(that.placeholder);
                        $(this).addClass('placeHolder');
                    }
                });
            });
        }

        this.switchingView = function() {
        };

        this.switchedView = function() {
            this.refresh();
            if (!this.isMobileView()) {
                var m = this.mode();
                $('.leaderboardMode > ul.dnnButtonGroup > li').removeClass('selected');
                $('.leaderboardMode > ul.dnnButtonGroup > li[data-mode="' + m + '"]').addClass('selected');
            }
        };
        
        if(this.template !== 'Sidebar')
            dnn.social.MobileView.init($, ko, this, this.switchingView, this.switchedView);
        else
            this.isMobileView = ko.observable(false);

        this.binded = function () {
            var localizer = this.localizer;
            Date.prototype.toRelativeTime = function () {
                
                function processOptions(arg) {
                    if (!arg) {
                        arg = 0;
                    }
                    if (typeof arg === 'string') {
                        arg = parseInt(arg, 10);
                    }
                    if (typeof arg === 'number') {
                        if (isNaN(arg)) {
                            arg = 0;
                        }
                        return { nowThreshold: arg };
                    }
                    return arg;
                }

                function toSmartDays(date, now) {
                    var day;
                    var weekday = date.getDay(),
                        dayDiff = weekday - now.getDay();
                    if (dayDiff == 0) day = localizer.getString('Today');
                    else if (dayDiff == -1) day = localizer.getString('Yesterday');
                    else if (dayDiff == 1 && date > now) day = localizer.getString('Tomorrow');
                    else day = weekdays[weekday];
                    return day + ' ' + localizer.getString('At') + ' ' + date.toLocaleTimeString();
                }

                function _(options) {
                    var opts = processOptions(options);

                    var now = opts.now || new Date();
                    var delta = now - this;
                    var future = (delta <= 0);
                    delta = Math.abs(delta);

                    if (delta <= opts.nowThreshold) {
                        return localizer.getString('Now');
                    }
                    if (opts.smartDays && delta <= 6 * millisecondsInDay) {
                        return toSmartDays(this, now);
                    }

                    var units = null;
                    for (var key in conversions) {
                        if (delta < conversions[key])
                            break;
                        units = key;
                        delta = delta / conversions[key];
                    }

                    delta = Math.floor(delta);
                    if (delta !== 1) {
                        units += 's';
                    }
                    return [delta, units, future ? localizer.getString('FromNow') : localizer.getString('Ago')].join(' ');
                }

                var conversions = {
                    millisecond: 1, // ms    -> ms
                    second: 1000,   // ms    -> sec
                    minute: 60,     // sec   -> min
                    hour: 60,       // min   -> hour
                    day: 24,        // hour  -> day
                    month: 30,      // day   -> month (roughly)
                    year: 12        // month -> year
                };

                var millisecondsInDay = conversions.millisecond * conversions.second * conversions.minute * conversions.hour * conversions.day;

                var weekdays = [
                    localizer.getString('Sunday'),
                    localizer.getString('Monday'),
                    localizer.getString('Tuesday'),
                    localizer.getString('Wednesday'),
                    localizer.getString('Thursday'),
                    localizer.getString('Friday'),
                    localizer.getString('Saturday')
                ];

                return _;
            };
            
            Date.fromString = function (str) {
                return new Date(Date.parse(str));
            };

            modeChanged(this.mode());
        };
    };
})(window.dnn);