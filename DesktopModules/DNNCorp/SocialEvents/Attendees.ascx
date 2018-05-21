<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Attendees.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.Attendees" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear">

    <div class="moduleContainer">
        <%-- NORMAL VIEW --%>
        <!-- ko ifnot: isMobileView -->
        <div class="list-container dnnClear">
            <div class="moduleTitleContainer dnnClear">
                <div class="idea-title-container dnnLeft">
                    <h3>
                        <%= SocialEvent.ContentTitle %>
                    </h3>
                    <p class="idea-title-returnPrev">
                        <asp:HyperLink runat="server" ID="hlReturn" resourcekey="hlReturn" />
                    </p>
                </div>
            </div>
            <div class="status-container dnnClear">
                <div class="status-scroll dnnSocialTabs dnnLeft">
                    <a data-bind="click: function() { return $root.category(1); }, attr: { 'class': selectedClass(1) }">
                        <span><%= LocalizeString("Attending") %></span>
                    </a>
                    <a data-bind="click: function() { return $root.category(2); }, attr: { 'class': selectedClass(2) }">
                        <span><%= LocalizeString("MayAttend") %></span>
                    </a>
                    <a data-bind="click: function() { return $root.category(3); }, attr: { 'class': selectedClass(3) }">
                        <span><%= LocalizeString("NotAttending")%></span>
                    </a>
                    <a data-bind="click: function() { return $root.category(4); }, attr: { 'class': selectedClass(4) }">
                        <span><%= LocalizeString("Invited")%></span>
                    </a>
                </div>
            </div>

            <div class='list-tbl-container dnnClear'>
                <!-- ko if: $root.componentFactory.resolve('AttendeesController').results().length > 0 -->
                <table class='list-tbl loading-container'>
                    <tbody>
                        <!-- ko with: $root.componentFactory.resolve('AttendeesController') -->
                        <!-- ko foreach: results -->
                        <tr>
                            <td class="guest-list-avator-td">
                                <div class="avatar40">
                                    <span>
                                        <em>
                                            <img data-bind="attr: { src: avatarPath, title: guestDisplayName, alt: guestDisplayName }" />
                                        </em>
                                    </span>
                                </div>
                            </td>
                            <td class="guest-list-name-td">
                                <a class="dnnSocialLink" data-bind="attr: { href:  guestProfileUrl }, text: guestDisplayName"></a>
                            </td>
                            <td class="guest-list-friend-td">
                                <!--  ko ifnot: isMe() -->
                                <!-- ko if: friendStatus() == 2 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: unfriend"><%= LocalizeString("btnUnfriend") %></a>
                                <!-- /ko -->
                                <!-- ko if: friendStatus() == 3 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction disabled"><%= LocalizeString("btnFriendRequested") %></a>
                                <!-- /ko -->
                                <!-- ko if: friendStatus() == 1 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: friend"><%= LocalizeString("btnFriend") %></a>
                                <!-- /ko -->
                                <!-- /ko -->
                            </td>
                        </tr>
                        <!-- /ko -->
                        <!-- /ko -->
                    </tbody>
                </table>
                <!-- /ko -->
                <!-- ko if: $root.componentFactory.resolve('AttendeesController').results().length === 0 -->
                <div class="list-noresult">
                    <%= LocalizeString("NoGuests") %>
                </div>
                <!-- /ko -->
            </div>
            <div class="pager-bottom moduleTopInsetShadowBox dnnClear">
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
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>

        <%-- MOBILE VIEW --%>
        <!-- ko if: isMobileView -->
        <div class="dnnMobile-moduleThreadContainer dnnClear">

            <div class="dnnLeft">
                <asp:HyperLink runat="server" ID="hlReturnMobileView" CssClass="dnnMobile-detailViewReturn" />
            </div>

            <div class="dnnRight">
                <!-- ko with: model -->
                <a data-bind="attr: { 'class': 'idea-vote-button dnnTertiaryAction attendees-rsvp ' + userRSVPStyle() }, html: userRSVPStatusLabel" href="javascript:void(0)"></a>
                <!-- /ko -->
                <div class="dnnClear dnnRight">
                    <span data-bind="text: model.attending()"></span>
                    <span><%= LocalizeString("Attending") %></span>
                </div>
            </div>

            <div class="dnnClear">
                <h3>
                    <%= SocialEvent.ContentTitle %>
                </h3>
            </div>

            <div class="dnnClear">
                <span data-bind="text: model.listviewEventDisplayTime" class="socialevents-displaytime"></span>
            </div>

        </div>
        <div class="dnnMobileListContainer dnnClear" style="margin-top: 0">
            <div class="dnnMobileStatusContainer dnnClear">
                <select data-bind="value: selectedMobileViewCategory">
                    <option value="1"><%= LocalizeString("Attending") %></option>
                    <option value="2"><%= LocalizeString("MayAttend") %></option>
                    <option value="3"><%= LocalizeString("NotAttending") %></option>
                    <option value="4"><%= LocalizeString("Invited") %></option>
                </select>
            </div>
            <div class="dnnMobileTotalCountContainer dnnClear">
                <span data-bind="html: '<%= LocalizeString("Guests") %> (' + $root.componentFactory.resolve('AttendeesController').totalResults() + ')' "></span>
            </div>
            <div class='dnnMobileListTblContainer'>
                <!-- ko with: $root.componentFactory.resolve('AttendeesController') -->
                <table class='dnnMobileListTbl loading-container'>
                    <tbody>
                        <!-- ko foreach: resultsMobile -->
                        <tr>
                            <td class="guest-list-avator-td dnnMobileIdeaTitle">
                                <div>
                                    <span>
                                        <em>
                                            <img data-bind="attr: { src: avatarPath, title: guestDisplayName, alt: guestDisplayName }" />
                                        </em>
                                    </span>
                                </div>
                            </td>
                            <td class="guest-list-name-td dnnMobileIdeaTitle">
                                <a class="dnnSocialLink" data-bind="attr: { href:  guestProfileUrl }, text: guestDisplayName"></a>
                                <!--  ko ifnot: isMe() -->
                                <!-- ko if: friendStatus() == 2 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: unfriend"><%= LocalizeString("btnUnfriend") %></a>
                                <!-- /ko -->
                                <!-- ko if: friendStatus() == 3 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction disabled"><%= LocalizeString("btnFriendRequested") %></a>
                                <!-- /ko -->
                                <!-- ko if: friendStatus() == 1 -->
                                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: friend"><%= LocalizeString("btnFriend") %></a>
                                <!-- /ko -->
                                <!-- /ko -->
                            </td>
                        </tr>
                        <!-- /ko -->
                    </tbody>
                </table>
                <!-- ko if: resultsMobile().length === 0 -->
                <div class="list-noresult">
                    <%= LocalizeString("NoGuests") %>
                </div>
                <!-- /ko -->
                <!-- /ko -->
                <!-- ko if: $root.pager().totalPages() - 1 > $root.pager().page() -->
                <a data-bind="click: loadMore" class="dnnMobileLoadMoreLink">
                    <span><%= LocalizeString("MoreGuests") %></span>
                </a>
                <!-- /ko -->
            </div>
        </div>
        <!-- /ko -->
        <%-- END MOBILE VIEW --%>
    </div>



</asp:Panel>
<script type='text/javascript'>
    function seeAttendeesInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var model = <%= SerializedEventInfo() %>;
        model.groupId = settings.groupId;
        try {
            window.dnn.social.applyBindings(new window.dnn.socialevents.AttendeesView($, window.ko, settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        } 
    }
</script>
