<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="EventCalendar.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.EventCalendar" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<div class="dnnClear" id="eventCalendar">
    <div class="custom-calendar-wrap">
        <h6><%= LocalizeString("EventCalendarHead") %></h6>
        <div id="custom-inner" class="custom-inner">
            <div class="custom-header clearfix">
                <span class="custom-month" id="custom-month"></span>
                <span class="custom-month-year-separate">, </span>
                <span class="custom-year" id="custom-year"></span>
                <ul class="dnnButtonGroup">
                    <li class="dnnButtonGroup-first"></li>
                    <li>
                        <a href="javascript:void(0);" class="custom-prev" id="custom-prev"></a>
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="custom-today" id="custom-today"><%= LocalizeString("Today") %></a>
                    </li>
                    <li>
                        <a href="javascript:void(0);" class="custom-next" id="custom-next"></a>
                    </li>
                </ul>
                <div class="dnnClear"></div>
            </div>
            <div id="custom-calendar" class="fc-calendar-container"></div>
        </div>
    </div>
</div>

<script type="text/javascript">
    dnn.socialevents.EventCalendar = '';
    dnn.socialevents.EventCalendarUpdate = function() {
        var cal = dnn.socialevents.EventCalendar;
        var settings = <%= ViewSettings.ToJson() %>;
            settings.moduleId = <%= SiblngModuleId %>;
            settings.groupId = <%= GroupId %>;
            var service = new dnn.social.ServiceCaller($, settings, 'list');             
            var success = function(data){
                if(data && data.length)
                    dnn.socialevents.EventCalendar.setData(data);
            };
            var fail = function(xhr){};
            service.get('geteventdates', { year: cal.getYear(), month: cal.getMonth(), groupId: settings.groupId }, success, fail);
        };

    $(function () {
        var codropsEvents = [<%= CurrentMonthEvents %>];
        var today = {
            year: <%= Today.Year %>,
            month: <%= Today.Month %>,
            day: <%= Today.Day %>
        };
        var settings = <%= ViewSettings.ToJson() %>;
        settings.moduleId = <%= SiblngModuleId %>;
        settings.groupId = <%= GroupId %>;

        var service = new dnn.social.ServiceCaller($, settings, 'list');
        $wrapper = $('#custom-inner');
        $calendar = $('#custom-calendar');
        cal = $calendar.calendario({
            onDayClick: function($el, hasEvent, dateProperties) {
                if (hasEvent) {
                    if (typeof dnn !== 'undefined' &&
                        typeof dnn.social !== 'undefined' &&
                        typeof dnn.social.ipc !== 'undefined') {
                        var clicked = $el.hasClass('fc-selected');
                        var event = {
                            event: 'SelectedDate',
                            selectedDate: clicked ? null : new Date(dateProperties.year, dateProperties.month - 1, dateProperties.day)
                        };

                        dnn.social.ipc.post({}, 'DNNCorp/SocialEvents', event);
                        $('div.fc-calendar-container div.fc-row > div').removeClass('fc-selected');
                        if (!clicked)
                            $el.addClass('fc-selected');
                    }
                }
            },
            monthabbrs: <%= LocalizedMonthsAbbr.ToJson() %>,
            weekabbrs: <%= LocalizedDays1Letter.ToJson() %>,
            caldata: codropsEvents,
            today: today,
            displayWeekAbbr: true,
            displayMonthAbbr: true
        });
        $month = $('#custom-month').html(cal.getMonthName());
        $year = $('#custom-year').html(cal.getYear());

        $('#custom-next').on('click', function () {
            cal.gotoNextMonth(updateMonthYear);
        });
        $('#custom-prev').on('click', function () {
            cal.gotoPreviousMonth(updateMonthYear);
        });
        $('#custom-today').on('click', function () {
            cal.gotoNow(updateMonthYear);
        });

        function updateMonthYear() {
            $month.html(cal.getMonthName());
            $year.html(cal.getYear());
            var success = function(data){
                if(data && data.length)
                    cal.setData(data);
            };
            var fail = function(xhr){
            };
            service.get('geteventdates', { year: cal.getYear(), month: cal.getMonth(), groupId: settings.groupId }, success, fail);
        }

        dnn.socialevents.EventCalendar = cal;
    });
</script>
