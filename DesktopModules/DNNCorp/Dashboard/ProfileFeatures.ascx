<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileFeatures.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileFeatures" %>
<asp:Panel class="dnnClear moduleContainer dashboard-features" runat="server" ID="ScopeWrapper">
    <div id="profileFeatures">
        <%-- NORMAL VIEW --%>
        <!-- ko ifnot: isMobileView -->
        <div class="ko-container">
            <ul class="dnnAdminTabNav tabNav dnnClear">
                <% foreach (var t in ProfilePages)
                   { %>
                <% if (t.TabID != CurrentTab.TabID)
                   { %>
                <li class="tabNavTab">
                    <a href="<%= DotNetNuke.Common.Globals.NavigateURL(t.TabID, string.Empty, UrlParam) %>">
                        <span><%= t.TabName %></span>
                    </a>
                </li>
                <% }
                   else
                   { %>
                 <li class="tabNavTab tabNavCurrentTab">
                    <a href="javascript:void(0)">
                        <span><%= t.TabName %></span>
                    </a>
                </li>
                <% } %>
                <% } %>
            </ul>
        </div>
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>

        <%-- MOBILE VIEW --%>
        <!-- ko if: isMobileView -->
        <div class="ko-container">
            <div class="dnnMobileGroupSpaces activeIndicator">
                <a class="dnnMobileGroupSpaces-indicator" href="javascript:void(0)" data-bind="click: toggleNavBarMobile"></a>
                <a class="dnnMobileGroupSpaces-label" href="javascript:void(0)" data-bind="click: toggleNavBarMobile"><%= CurrentTab.TabName %></a>
                <div class="dnnClear"></div>
            </div>

            <ul class="dnnMobileGroupsTab">
                <% foreach (var t in ProfilePages)
                   { %>
                <li class="tabNavTab">
                    <a href="<%= DotNetNuke.Common.Globals.NavigateURL(t.TabID, string.Empty, UrlParam) %>">
                        <span><%= t.TabName %></span>
                    </a>
                </li>
                <% } %>
            </ul>
        </div>
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>
    </div>
</asp:Panel>
<script type="text/javascript">
    function dashboard_featuresInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.dashboard.ProfileFeatures(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
