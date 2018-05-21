<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="GroupOverview.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.GroupOverview" %>
<%@ Register TagPrefix="dnn" TagName="GroupEditWizard" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/GroupEditWizard.ascx" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear scopeWrapper">
    <!-- ko if: !isMobileView() -->
    <div class="return-groupDirectory ko-container">
        <a href="<%=GroupDirectoryUrl%>"><span><%= LocalizeString("ReturnToDirectory") %></span></a>
    </div>
    <!-- /ko -->
    <!-- ko if: !isMobileView() && IsMember() && !IsMembershipPending() && !IsGroupOwner() -->
    <div class="ko-container">
        <a id="leave" class="leave-group" href="javascript:void(0)"><%= LocalizeString("Leave") %></a>
    </div>
    <!-- /ko -->
    <div class="groupOverview-container dnnClear" id="groupOverview">
        <div class="moduleContainer dnnClear">
            <div data-bind="stopBindings: true" class="group-edit-dialog" style="display: none;">
                <dnn:GroupEditWizard ID="EditGroupWizard" runat="server" />
            </div>

            <%-- NORMAL VIEW --%>
            <!-- ko ifnot: isMobileView -->
            <div class="moduleContainer-normalView ko-container">
            <div class="groupOverview-main">
                <div class="groupOverview-primary">     
                    <div class="groupOverview-imageContainer">
                        <div class="group-image">
                            <span>
                                <em>
                                    <img src="<%= GroupInfo.ImageUrl %>" alt="" />
                                </em>
                            </span>
                        </div>
                        <div class="ko-container">
                            <!-- ko ifnot: $root.IsGroupPendingToBeApproved -->
                                <!-- ko if: !$root.IsMember() -->
                                <% if (!LimitedGroupViewer)
                                   { %>
                                <a class="invite-button dnnPrimaryAction" data-bind="click: join"><%= LocalizeString("Join") %></a>
                                <% } %>
                                <!-- /ko -->
                                <!-- ko if: $root.IsMembershipPending() -->
                                <span class="invite-button groupStatusLabel"><%= LocalizeString("Pending") %></span>
                                <!-- /ko -->
                            <!-- /ko -->
                            <!-- ko if: $root.IsGroupPendingToBeApproved -->
                                <span class="invite-button groupStatusLabel"><%= LocalizeString("GroupPending") %></span>
                            <!-- /ko -->
                        </div>
                    </div>

                    <div class="groupOverview-infoContainer">
                        <div class="group-summary">
                            <div class="group-name">
                                <span><%= GroupInfo.GroupName %></span>
                            </div>
                            <br />
                            <div class="group-description">
                                <span><%= GroupInfo.Description %></span>
                            </div>

                            <div class="group-stats">
                                <div class="members">
                                    <span class="stat" data-bind="html: GroupMemberStat"><%= GroupInfo.MemberCount %></span>
                                    <br />
                                    <span class="statName"><%= LocalizeString("StatMembers") %></span>
                                </div>
                                <div class="activity">
                                    <span class="stat">xx</span>
                                    <br />
                                    <span class="statName"><%= LocalizeString("StatActivity") %></span>
                                </div>
                                <div class="score">
                                    <span class="stat">xx</span>
                                    <br />
                                    <span class="statName"><%= LocalizeString("StatScore") %></span>
                                </div>
                                <div class="created">
                                    <span class="statDate" data-bind="html: GroupCreatedStat"></span>
                                    <br />
                                    <span class="statName"><%= LocalizeString("StatEstablished") %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% if (!TokenUserView)
                   { %>
                <div class="groupOverview-nav">
                    <div id="navHome" class="groupOverview-nav-button navHome inactive" data-bind="click: navHomeClick"></div>
                    <div id="navSettings" runat="server" class="groupOverview-nav-button navSettings inactive" Visible="false" data-bind="click: navSettingsClick"></div>
                    <% if (!LimitedGroupViewer)
                       { %>
                    <div id="navSearch" class="groupOverview-nav-button navSearch inactive" data-bind="click: navSearchClick"></div>
                    <% } %>
                </div>
                <% } %>
            </div>

            <!-- ko with: $root.componentFactory.resolve('SearchController') -->
            <div data-bind="escapeKey: $root.hideResults">
                <div class="groupOverview-search">
                    <div class="txtWrapper">
                        <input type="text" id="groupOverview-txtShare" class="group-search-input" data-bind="value: query, escapeKey: $root.hideResults, valueUpdate: 'afterkeydown'" placeholder="<%= LocalizeString("SearchHint") %>" autocomplete="off" />
                    </div>
                    <div class="actionWrapper">
                        <a class="dnnPrimaryAction" data-bind="click: submitSearch"><%= LocalizeString("Search") %></a>
                    </div>
                    <div class="dnnClear"></div>
                </div>
            </div>
            <div class="groups-search-results" data-bind="escapeKey: $root.hideResults">
                <div class="triangle"></div>
                <div class="groups-search-results-title pinkLink">
                    <%= LocalizeString("SearchResults") %>(<span data-bind="text: totalRecords"></span>)
                </div>
                <div>
                    <ul class='groups-results-list'>
                        <!-- ko foreach: groupedResults-->
                        <li class="grouped-result">
                            <span data-bind="html: tabName"></span>
                            <ul>
                                <!-- ko foreach: results -->
                                <li>
                                    <a class='dnnSocialLink' data-bind="attr: { href: url }">
                                        <span data-bind="html: title"></span>
                                    </a>
                                </li>
                                <!-- /ko -->
                            </ul>
                        </li>
                        <!-- /ko -->
                    </ul>
                </div>
            </div>
            <!-- /ko -->
            </div>
            <!-- /ko -->
            <%-- END NORMAL VIEW --%>

            <%-- MOBILE VIEW --%>
            <!-- ko if: isMobileView -->
            <div class="dnnMobile-groupOverview-main moduleContainer-mobileView ko-container">
                <% if (!TokenUserView)
                   { %>
                <div class="dnnMobile-groupOverview-nav">
                    <div id="dnnMobile-navHome" class="navHome inactive" data-bind="click: navHomeClickMobile"></div>
                    <% if (!LimitedGroupViewer)
                    { %>
                    <div id="dnnMobile-navSearch" class="navSearch inactive" data-bind="click: navSearchClickMobile"></div>
                    <% } %>
                </div>
                <% } %>
                <div class="dnnClear"></div>
                <!-- ko with: $root.componentFactory.resolve('SearchController') -->
                <div class="dnnMobile-groupOverview-search">
                    <div>
                        <input type="text" data-bind="value: query, escapeKey: $root.hideResultsMobile, valueUpdate: 'afterkeydown'" placeholder="<%= LocalizeString("SearchHint") %>" autocomplete="off" />
                    </div>
                </div>
                <div class='dnnMobileGroupSearchResult'>
                    <ul>
                        <!-- ko foreach: groupedResults -->
                        <li class="grouped-result">
                            <span data-bind="html: tabName"></span>
                            <ul>
                                <!-- ko foreach: results -->
                                <li>
                                    <a class='dnnSocialLink' data-bind="attr: { href: url }">
                                        <span data-bind="html: title"></span>
                                    </a>
                                </li>
                                <!-- /ko -->
                            </ul>
                        </li>
                        <!-- /ko -->
                    </ul>
                </div>
                <!-- /ko -->
                <div class="dnnMobile-groupOverview-primary">
                    <div class="groupOverview-imageContainer">
                        <div class="group-image">
                            <span>
                                <em>
                                    <img data-bind="attr: { src: GroupImageUrl }" alt="" />
                                </em>
                            </span>
                        </div>
                    </div>
                    <div class="groupOverview-infoContainer">
                        <span runat="server" class="group-name" data-bind="html: GroupName"></span>
                        <span class="statDate" data-bind="html: GroupCreatedStat"></span>

                        <!-- ko ifnot: $root.IsGroupPendingToBeApproved -->
                            <!-- ko if: !$root.IsMember() -->
                            <% if (!LimitedGroupViewer)
                               { %>
                            <a class="dnnPrimaryAction" data-bind="click: join"><%= LocalizeString("Join") %></a>
                            <% } %>
                            <!-- /ko -->
                            <!-- ko if: $root.IsMembershipPending() -->
                            <span class='groupStatusLabel'><%= LocalizeString("Pending") %></span>
                            <!-- /ko -->
                        <!-- /ko -->
                        <!-- ko if: $root.IsGroupPendingToBeApproved -->
                            <span class="groupStatusLabel"><%= LocalizeString("GroupPending") %></span>
                        <!-- /ko -->
                    </div>
                    <div class="dnnClear"></div>
                </div>
                
                <div class="dnnMobile-groupOverview-stats">
                     <div>
                        <span class="stat" data-bind="html: GroupMemberStat"></span>
                        <span class="statName"><%= LocalizeString("StatMembers") %></span>
                    </div>
                </div>

            </div>
            <!-- /ko -->
            <%-- END MOBILE VIEW --%>
            
            <%-- PLACEHOLDER FOR GROUP NAV MOBILE VIEW --%>
            <div id="groupNavContainer"></div>
        </div>
    </div>
</asp:Panel>

<script type='text/javascript'>
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function groupOverviewInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new dnn.groupSpaces.GroupOverview($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
