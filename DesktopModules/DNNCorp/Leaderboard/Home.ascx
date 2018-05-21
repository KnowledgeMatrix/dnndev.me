<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Home.ascx.cs" Inherits="DotNetNuke.Professional.Leaderboard.Home" %>
<%@ Import Namespace="DotNetNuke.Professional.Leaderboard.Components.Common" %>
<asp:Panel runat="server" ID="ScopeWrapper">
    <div class="dnnClear">
        <% if(UserId > 0 && BoardSettings.ShowModePanel) {%>
        
        <!-- ko ifnot: isMobileView -->
        <div class="dnnClear leaderboardSearch">
            <div class="dnnLeft">
                <input type="text" class="leaderboardSearchInput" data-bind="value: searchText, enterKey: search, valueUpdate: 'afterkeydown'"
                    placeholder="<%= LocalizeString("FindMember") %>" />                
            </div>
            <div class="dnnLeft">
                <a data-bind="click: search" class="dnnSecondaryAction">
                    <%= LocalizeString("Search") %>
                </a>
            </div>
            <div class="dnnRight"  data-bind="visible: showModeButtons">
                <a class="social-help-button leader-help" data-bind="click: function() { help('SearchPanel'); }"></a>
            </div>
            <div class="dnnRight leaderboardMode-me" data-bind="visible: isModeToMeEnabled">
                <a href="javascript:void(0)" class="dnnSecondaryAction" data-bind="click: switchModeToMe">
                    <%= LocalizeString("Me") %>
                </a>
            </div>
            <div class="dnnRight leaderboardMode" data-bind="visible: showModeButtons">
                <ul class="dnnButtonGroup">
                    <li class="dnnButtonGroup-first"></li>
                    <li data-mode="allusers">
                        <a href="javascript:void(0)" data-bind="click: switchModeToEveryone">
                            <%= LocalizeString("Everyone") %>
                        </a>
                    </li>
                    <li data-mode="friends">
                        <a href="javascript:void(0)" data-bind="click: switchModeToFriends">
                            <%= LocalizeString("Friends") %>
                        </a>
                    </li>
                    <li data-bind="visible: memberModeVisible" data-mode="members">
                        <a href="javascript:void(0)" data-bind="click: switchModeToMembers">
                            <%= LocalizeString("Members") %>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="dnnClear"></div>
        </div>
        <!-- /ko -->
        <!-- ko if: isMobileView -->
        <div class="dnnMobileTableFilter dnnClear">
            <div class="dnnMobileFilterSet">
                <input type="text" autocomplete="off" data-bind="value: searchText, enterKey: search, valueUpdate: 'afterkeydown'" placeholder="<%= LocalizeString("FindMember") %>"  />
            </div>
        </div>
        <!-- /ko -->

        <%} %>
        
        <!-- ko ifnot: isMobileView -->
        <div class="leaderboard">
            <div class="leader-contents dnnClear" data-bind="with: viewport">
                <div class="tableContainer">
                    <%= BoardSettings.Templates.Header %>
                    <%= BoardSettings.Templates.Footer %>
                </div>
            </div>
        </div>
        <!-- /ko -->
        
        <!-- ko if: isMobileView -->
        <div class="dnnMobileListContainer dnnClear">
            
            <% if (UserId > 0 && BoardSettings.ShowModePanel)
               { %>

            <div class="dnnMobileStatusContainer dnnClear" data-bind="visible: showModeButtons">
                <select data-bind="value: mode">
                    <option value="allusers"><%= LocalizeString("Everyone") %></option>
                    <option value="friends"><%= LocalizeString("Friends") %></option>
                    <option value="members" data-bind="visible: memberModeVisible"><%= LocalizeString("Members") %></option>
                </select>
            </div>

            <% } %>

            <div class='dnnMobileListTblContainer' data-bind="with: mobileViewport">
                  <%= MobileSettings.HeaderTemplate %>
                  <%= MobileSettings.FooterTemplate %>
                  <div class="dnnMobileBottomPager" data-bind="visible: totalPages() > 1">
	                <a class="dnnSecondaryAction" data-bind="visible: pageIndex() > 0, click: prev">PREV</a>
	                <a class="dnnSecondaryAction" data-bind="visible: pageIndex() < totalPages() - 1, click: next">NEXT</a>
                  </div>
            </div>
        </div>
        <!-- /ko -->

    </div>
    <div class="dnnClear"></div>
</asp:Panel>

<asp:Panel runat="server" ID="ScopeWrapper_Help" CssClass="leader-help-dialog">
    <div style="padding: 25px" data-bind="html: text"></div>
</asp:Panel>
<div class="dnnClear"></div>

<script type="text/javascript">
    function leaderboardInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        settings.helpScope = $(settings.helpScope)[0];
        try {
            window.dnn.social.applyBindings(new window.dnn.leaderboard.Home($, window.dnn, window.ko, settings), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>