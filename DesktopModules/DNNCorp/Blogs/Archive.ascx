<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Archive.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.Archive" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>

<div class="dnnClear" id="blogArchive">
    <h6><%= LocalizeString("lblArchive") %></h6>
    <div class="custom-calendar-wrap" style="display: none">
        <div id="custom-inner" class="custom-inner dnnClear">
            <div class="custom-header">
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
    <div class="archiveMonths dnnClear">
        <asp:Repeater ID="repeatMonths" runat="server">
            <HeaderTemplate>
                <ul class="qaRecentTags">
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <asp:HyperLink runat="server" ID="lnkMonthYear" />
                    <span>
                        <asp:HyperLink runat="server" ID="lnkBlogRSS" Visible="False" Target="_blank">
                            <asp:Image ID="lnkBlogRSSIcon" runat="server" ImageUrl="~/desktopmodules/Blog/Images/feed-icon-12x12.gif" />
                        </asp:HyperLink>
                    </span>
                </li>
            </ItemTemplate>
            <FooterTemplate></ul></FooterTemplate>
        </asp:Repeater>
        <asp:Label runat="server" ID="lblNoRecords"><%= LocalizeString("NoEntries") %></asp:Label>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        var codropsEvents = [<%= CurrentMonthBlogEntries %>];
        var today = {
            year: <%= Today.Year %>,
            month: <%= Today.Month %>,
            day: <%= Today.Day %>
            };
        
	    var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
        settings.blogId = <%= BlogId %>;
        settings.groupId = <%= GroupId %>;
        settings.authorId = <%= AuthorId %>;
        var cid = <%= ContentItemId.HasValue ? ContentItemId.Value : Null.NullInteger %>;
        var service = new dnn.social.ServiceCaller($, settings, 'entrylist'),
        $calendar = $('#custom-calendar'),
        cal = $calendar.calendario({
            onDayClick: function ($el, hasEvent, dateProperties) {
                if (hasEvent) {                    
                    if(typeof dnn !== 'undefined' && 
                        typeof dnn.social !== 'undefined' &&
                        typeof dnn.social.ipc !== 'undefined') {
                        var clicked = $el.hasClass('fc-selected');
                        var event  = {
                            event: 'SelectedDate',
                            selectedDate: clicked? null : new Date(dateProperties.year, dateProperties.month - 1, dateProperties.day)
                        };

                        dnn.social.ipc.post({}, 'DNNCorp/Blogs', event);
                        $('div.fc-calendar-container div.fc-row > div').removeClass('fc-selected');
                        if(!clicked)
                            $el.addClass('fc-selected');
                    }
                }
            },
            monthabbrs: <%= LocalizedMonthsAbbr.ToJson() %>,
            weekabbrs: <%= LocalizedDays1Letter.ToJson() %>,
            today: today,
            caldata: codropsEvents,
            displayWeekAbbr: true,
            displayMonthAbbr: true
        }),
        $month = $('#custom-month').html(cal.getMonthName()),
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
            
            var date = new Date(cal.getYear(), cal.getMonth() - 1, 1);
            if(date < new Date()){
                var success = function(data){
                    if(data && data.length)
                        cal.setData(data);
                };
                var fail = function(xhr){
                };
                service.get('getentrydates', { blogId: settings.blogId, authorId: settings.authorId, groupId: settings.groupId, year: cal.getYear(), month: cal.getMonth() }, success, fail);
            }
        }
        if (cid < 1) {
            $(".custom-calendar-wrap").show();
            $(".archiveMonths").hide();
        } 
    });
</script>
