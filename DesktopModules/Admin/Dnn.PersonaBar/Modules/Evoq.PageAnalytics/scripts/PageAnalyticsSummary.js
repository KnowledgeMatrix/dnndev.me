'use strict';
define(['jquery', 'knockout', 'main/config', './analytics/tokenService', 'main/loader', 'jquery.hoverIntent.min'], function ($, ko, cf, tokenService, loader) {
    var config = cf.init();
    var settings;
    var mainFrame = window.parent.document.getElementById("personaBar-iframe");
    var personaBarWidth = 80;
    var util = null;
    var menuIdentifier = 'Evoq.PageAnalytics';

    var getSummaryContainer = function () {
        var $summary = $('#pageanalytics-summary');
        if (!$summary.length) {
            $summary = $('' +
                '<div id="pageanalytics-summary"  data-init-callback="initPageAnalyticsSummary" class="analytics-summary hoverSummaryMenu">' +
                '</div>');

            $('#personabar').find('li[id="' + menuIdentifier + '"]').append($summary);
        }

        return $summary;
    }

    var showSummary = function () {
        mainFrame.style.width = '100%';
        $('.hoverSummaryMenu, .hovermenu').hide();
        getSummaryContainer().addClass('shown');
    }

    var hideSummary = function () {
        if (!$('.hovermenu:visible').length && !$('.socialpanel:visible').length) {
            mainFrame.style.width = personaBarWidth + "px";
        }
        getSummaryContainer().removeClass('shown');
    }

    var initPageAnalyticsSummary = function (util, publicPath) {
        tokenService.init(util.sf);

        window.initPageAnalyticsSummary = function () {
            window.dnn.cloudAnalytics.init({
                publicPath: publicPath,
                getToken: tokenService.getToken,
                tokenKey: settings.tokenKey,
                apiServiceUrl: settings.apiUrl,
                libraryVersion: settings.libraryVersion,
                loader: loader,
                notifier: {
                    confirm: util.confirm,
                    notify: util.notify,
                    notifyError: util.notifyError
                }
            });
        }
    }

    var loadScript = function (basePath) {
        var h = window.location.protocol + "//" + window.location.host;
        var path = decodeURIComponent(settings.currentUrl).substring(h.length);
        var url = basePath + "evoqanalytics.js?accountcode=" + settings.accountCode + "&path=" + path;
        $.ajax({
            dataType: "script",
            cache: true,
            url: url
        });
    }

    var initialize = function () {
        if (!settings.enabled) return;
        if (!util.resx) {
            setTimeout(initialize, 500);
            return;
        }

        var contentPublicPath = settings.uiUrl + "/dist/";
        var $menu = $('#personabar').find('li[id="' + menuIdentifier + '"]');
        var $summaryContainer = getSummaryContainer();

        $summaryContainer.click(function(e) {
            e.stopPropagation();
        });

        $menu.hoverIntent({
            over: function() {
                showSummary();
            },
            out: function() {
                hideSummary();
            },
            timeout: 200
        });

        initPageAnalyticsSummary(util, contentPublicPath);
        loadScript(contentPublicPath);
    }

    return {
        init: function (utility) {
            util = utility;
            settings = util.findMenuSettings(menuIdentifier);
            initialize();
        },
        load: function () {

        },
        leave: function() {

        }
    }
});