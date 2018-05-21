<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ListView.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.ListView" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="events" TagName="Wizard" Src="~/DesktopModules/DNNCorp/SocialEvents/Controls/Wizard.ascx" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear moduleContainer">
    <%-- NORMAL VIEW --%>
    <!-- ko ifnot: isMobileView -->
    <div class="moduleContainer-normalView ko-container">
        <div class="list-container dnnClear">
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function () { return $root.category('all'); }, attr: { 'class': selectedClass('all') }">
                        <span><%= LocalizeString("All") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('upcomingevents'); }, attr: { 'class': selectedClass('upcomingevents') }">
                        <span><%= LocalizeString("UpcomingEvents") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mycontentitems'); }, attr: { 'class': selectedClass('mycontentitems') }">
                        <span><%= LocalizeString("MyContentItems") %></span>
                    </a>
                    <a data-bind="click: function () { return $root.category('mycomments'); }, attr: { 'class': selectedClass('mycomments') }">
                        <span><%= LocalizeString("MyComments") %></span>
                    </a>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear static-row">
                <div class="dnnLeft">
                    <input type="text" placeholder="Filter by tag" class="dnnTagsInput" style="width: 190px" />
                </div>
                <div class="dnnLeft">
                    <select style="width: 193px">
                        <option><%= LocalizeString("SortByEventStartTime") %></option>
                    </select>
                </div>
            </div>
            <div class="sort-filter-container moduleTopInsetShadowBox dnnClear ko-container">
                <div class="dnnLeft">
                    <input type="text" class="sort-tags-input" />
                </div>
                <div class="dnnLeft" data-bind="with: componentFactory.resolve('ListController')">
                    <select data-bind="options: $root.sortOptions, optionsValue: 'value', optionsText: 'text', value: $root.sort"></select>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>
            <div class="list-tbl-container dnnClear">
                <table class='list-tbl loading-container'>
                    <tbody class="static-row">
                        <% foreach (var socialEvent in InitialSet)
                           { %>
                        <tr class="list-row">
                            <td class="idea-list-vote-panel">
                                <% if (socialEvent.StartTime.AddDays(1) > DateTime.Now && socialEvent.StartTime.AddDays(-1) < DateTime.Now)
                                   { %>
                                <div class="socialevents-todaylabel"><span><%= LocalizeString("Today") %></span></div>
                                <% } %>

                                <div class="attending-count">
                                    <span><%= socialEvent.Attending %></span>&nbsp;<span><%= LocalizeString("Attendees") %> </span>
                                </div>

                                <div class="attend-button">
                                    <a class="socialevent-attend-button dnnTertiaryAction">
                                        <% switch (socialEvent.RsvpStatus)
                                           {
                                               case 1:%>
                                        <%= LocalizeString("Attending") %>
                                        <% break;
                                        case 2: %>
                                        <%= LocalizeString("Maybe") %>
                                        <% break;
                                        case 3: %>
                                        <%= LocalizeString("Decline") %>
                                        <% break;
                                        case 4: %>
                                        <%= LocalizeString("Invited") %>
                                        <% break;
                                        default: %>
                                        <%= socialEvent.InvitationOnly? LocalizeString("InvitationOnly") : LocalizeString("Attend") %>
                                        <% break;
                                           } %>
                                    </a>
                                </div>

                                <div class="dnnClear"></div>
                            </td>
                            <td class="list-row-summary-container">
                                <div class="dnnClear">
                                    <ul class="dnnRight detail-social-actions">
                                        <li><a href="javascript:void(0)" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                                        <li><a href="javascript:void(0)" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                                        <li><a href="javascript:void(0)" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                                    </ul>
                                    <h3><a href='<%= socialEvent.DetailsUrl %>' class="dnnSocialLink"><span class="list-row-title"><%= socialEvent.ContentTitle %></span></a></h3>
                                    <span class="socialevents-displaytime"><%= socialEvent.StartDateString %></span>
                                    <span class="socialevents-displaytimezone"><%= socialEvent.TimeOffsetName %></span>
                                    <span class="socialevents-address"><%= socialEvent.CompleteAddress %></span>
                                </div>
                                <p class="list-row-content dnnClear"><%= socialEvent.ContentSummary %></p>
                                <div class="dnnClear">
                                    <% if (socialEvent.Tags.Any())
                                       {%>

                                    <span class="list-row-label">
                                        <%= LocalizeString("Tags") %>
                                    </span>

                                    <ul class="list-row-tags">
                                        <% foreach (var tag in socialEvent.Tags)
                                           { %>
                                        <li>
                                            <a href="<%= tag.TagUrl %>">
                                                <%: tag.Name %>
                                            </a>
                                        </li>
                                        <% } %>
                                    </ul>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                    <tbody class="ko-container">
                        <!-- ko with: $root.componentFactory.resolve('ListController') -->
                        <!-- ko foreach: results -->
                        <tr class="list-row">
                            <td class="idea-list-vote-panel">
                                <!-- ko if: showTodayLabel -->
                                <div class="socialevents-todaylabel"><span><%= LocalizeString("Today") %></span></div>
                                <!-- /ko -->

                                <div class="attending-count">
                                    <span data-bind="text: attending"></span>&nbsp;<span><%= LocalizeString("Attendees") %> </span>
                                </div>

                                <div class="attend-button">
                                    <a data-bind="click: $root.rsvp, text: userRSVPStatusLabel, attr: { 'class': 'socialevent-attend-button dnnTertiaryAction ' + userRSVPStyle() }" class=""></a>
                                </div>

                                <div class="dnnClear"></div>

                                <div data-bind="attr: { id: 'rsvp-panel-' + eventId() }" class="idea-vote-options">
                                    <div data-bind="with: voteButtons" style="display: inline-block">
                                        <div class="ie-shadow">
                                            <!-- ko foreach: buttons() -->
                                            <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type, 'title': title }">
                                                <span data-bind="text: text"></span>
                                            </a>
                                            <!-- /ko -->
                                        </div>
                                    </div>

                                    <!-- ko if: showGuestsToPublic() -->
                                    <div class="remaining">
                                        <%= LocalizeString("See") %> <a data-bind="attr: { href: viewAttendeesUrl }"><%= LocalizeString("WhoElseAttending") %></a>
                                    </div>
                                    <!-- /ko -->
                                </div>


                            </td>
                            <td class="list-row-summary-container">
                                <div class="dnnClear">
                                    <ul class="dnnRight detail-social-actions">
                                        <!-- ko if: liked -->
                                        <li><a href="javascript:void(0)" data-bind="click: unlike" class="dnnSocialLikeActive" title="<%= LocalizeString("UnlikeThis") %>"></a></li>
                                        <!-- /ko -->
                                        <!-- ko ifnot: liked -->
                                        <li><a href="javascript:void(0)" data-bind="click: like" class="dnnSocialLike" title="<%= LocalizeString("LikeThis") %>"></a></li>
                                        <!-- /ko -->
                                        <!-- ko if: bookmarked -->
                                        <li><a href="javascript:void(0)" data-bind="click: unbookmark" class="dnnSocialBookmarkActive" title="<%= LocalizeString("RemoveBookmark") %>"></a></li>
                                        <!-- /ko -->
                                        <!-- ko ifnot: bookmarked -->
                                        <li><a href="javascript:void(0)" data-bind="click: bookmark" class="dnnSocialBookmark" title="<%= LocalizeString("AddBookmark") %>"></a></li>
                                        <!-- /ko -->
                                        <!-- ko if: subscribed -->
                                        <li><a href="javascript:void(0)" data-bind="click: unsubscribe" class="dnnSocialSubscribeActive" title="<%= LocalizeString("Unsubscribe") %>"></a></li>
                                        <!-- /ko -->
                                        <!-- ko ifnot: subscribed -->
                                        <li><a href="javascript:void(0)" data-bind="click: subscribe" class="dnnSocialSubscribe" title="<%= LocalizeString("Subscribe") %>"></a></li>
                                        <!-- /ko -->
                                    </ul>
                                    <h3><a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink"><span data-bind="    html: contentTitle" class="list-row-title"></span></a></h3>
                                    <span data-bind="html: listviewEventDisplayTime" class="socialevents-displaytime"></span>
                                    <span data-bind="html: timeOffsetName" class="socialevents-displaytimezone"></span>
                                    <span data-bind="html: completeAddress" class="socialevents-address"></span>
                                    <span data-bind="html: seatsLabel" class="socialevents-seats"></span>
                                </div>
                                <p class="list-row-content dnnClear" data-bind="html: contentSummary"></p>
                                <div class="dnnClear">
                                    <!-- ko if: tags().length > 0 -->
                                    <span class="list-row-label">
                                        <%= LocalizeString("Tags") %>
                                    </span>

                                    <ul class="list-row-tags">
                                        <!-- ko foreach: tags -->
                                        <li>
                                            <a data-bind="click: function () { $root.searchTag(this) }">
                                                <span data-bind="text: name"></span>
                                            </a>
                                        </li>
                                        <!-- /ko -->
                                    </ul>
                                    <!-- /ko -->
                                </div>
                            </td>
                        </tr>
                        <!-- /ko -->
                        <!-- /ko -->
                    </tbody>
                </table>
                <div class="list-noresult ko-container" data-bind="visible: $root.componentFactory.resolve('ListController').results().length === 0">
                    <%= LocalizeString("NoRecords") %>
                </div>
            </div>
            <div class="pager-bottom moduleTopInsetShadowBox dnnClear">
                <% if (CanCreateEvent)
                   { %>
                <div class="bottom-create-btn dnnLeft">
                    <a class="dnnPrimaryAction" data-bind="click: addDialog"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/SocialEvents/App_LocalResources/Search.ascx.resx") %></a>
                </div>
                <% } %>
                <div class="dnnLeft">
                    <ul class="pager-ul" data-bind="html: pagingControl"></ul>
                </div>
                <div class="dnnRight">
                    <div class="dnnPagingCount dnnLeft">
                        <span data-bind="html: totalResults"></span>
                    </div>
                    <!-- ko if: $root.pager().totalPages() > 1 -->
                    <div class="dnnPagingButtons dnnRight">
                        <a data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
                        <a data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
                    </div>
                    <!-- /ko -->
                </div>
            </div>
        </div>
    </div>
    <!-- /ko -->
    <%-- END NORMAL VIEW --%>

    <%-- MOBILE VIEW --%>
    <!-- ko if: isMobileView -->
    <div class="moduleContainer-mobileView ko-container">
        <div class="dnnMobileListContainer dnnClear">
            <div class="dnnMobileStatusContainer dnnClear">
                <select data-bind="value: selectedMobileViewCategory">
                    <option value="all"><%= LocalizeString("All") %></option>
                    <option value="upcomingevents"><%= LocalizeString("UpcomingEvents") %></option>
                    <option value="mycontentitems"><%= LocalizeString("MyContentItems") %></option>
                    <option value="mycomments"><%= LocalizeString("MyComments") %></option>
                </select>
            </div>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('ListController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="dnnMobileIdeaVote dnnMobileEventVote">
                                <!-- ko if: showTodayLabel -->
                                <div class="socialevents-todaylabel"><span><%= LocalizeString("Today") %></span></div>
                                <!-- /ko -->
                                <div class="attending-count">
                                    <span data-bind="text: attending"></span>
                                    <span><%= LocalizeString("Attendees") %> </span>
                                </div>
                                <a data-bind="click: $root.rsvpMobileView, attr: { 'class': 'idea-vote-button dnnTertiaryAction ' + userRSVPStyle() }">
                                    <span data-bind="html: userRSVPStatusLabel"></span>
                                </a>
                            </td>
                            <td class="dnnMobileIdeaTitle dnnMobileEventTitle">
                                <a data-bind="attr: { href: detailsUrl }" class="dnnSocialLink">
                                    <span data-bind="html: contentTitle" class="list-row-title"></span>
                                </a>
                                <div>
                                    <span data-bind="html: listviewEventDisplayTime" class="socialevents-displaytime"></span>
                                    <span data-bind="html: timeOffsetName" class="socialevents-displaytimezone"></span>
                                    <span data-bind="html: completeAddress" class="socialevents-address"></span>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="dnnMobile-idea-vote-options dnnMobile-event-vote-options" data-bind="attr: { id: 'dnnMobile-vote-panel-' + eventId() }">
                                    <div data-bind="with: voteButtons">
                                        <!-- ko foreach: buttons() -->
                                        <a href="javascript:void(0)" data-bind="click: exec, attr: { 'class': 'button ' + type }">
                                            <span data-bind="text: text"></span>
                                        </a>
                                        <!-- /ko -->
                                        <div class="dnnClear"></div>
                                    </div>
                                    <!-- ko if: showGuestsToPublic() -->
                                    <div class="remaining dnnClear">
                                        <%= LocalizeString("See") %> <a data-bind="attr: { href: viewAttendeesUrl }"><%= LocalizeString("WhoElseAttending") %></a>
                                    </div>
                                    <!-- /ko -->
                                </div>
                            </td>
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <!-- ko if: resultsMobile().length === 0 -->
                <div class="list-noresult">
                    <%= LocalizeString("NoRecords") %>
                </div>
                <!-- /ko -->
                <!-- /ko -->
                <!-- ko if: $root.pager().totalPages() - 1 > $root.pager().page() -->
                <a data-bind="click: loadMore" class="dnnMobileLoadMoreLink">
                    <span><%= LocalizeString("MoreEvents") %></span>
                </a>
                <!-- /ko -->
            </div>
            <% if (CanCreateEvent)
               { %>
            <a class="dnnMobileCreateNewButton" data-bind="click: addDialogMobileView"><%= Localization.GetString("SearchCreate", "~/DesktopModules/DNNCorp/SocialEvents/App_LocalResources/Search.ascx.resx") %></a>
            <% } %>
        </div>
    </div>
    <!-- /ko -->
    <%-- END MOBILE VIEW --%>
    <div class="editor-dialog" data-bind="stopBindings: true" style="display: none;">
        <events:Wizard ID="CtlEditor" runat="server" />
    </div>
</asp:Panel>

<input type="hidden" name="evoq_social_tab_id" value="<%= ModuleContext.TabId %>"/>
<input type="hidden" name="evoq_social_module_id" value="<%= ModuleContext.ModuleId %>"/>
<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function socialeventsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.socialevents.ListView(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
