<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="GroupFeatures.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.GroupFeatures" %>
<%@ Register TagPrefix="groupSpaces" TagName="EditTabs" Src="~/DesktopModules/DNNCorp/GroupSpaces/Controls/EditTabs.ascx" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear">
    <div class="moduleContainer dnnClear" id="groupFeatures">
        
        <div data-bind="stopBindings: true" class="edit-tabs-dialog" style="display: none;">
            <groupSpaces:EditTabs ID="EditGroupTags" runat="server" />
        </div>
      
        <div class="dnnForm dnnGroupSpaces dnnClear" id="dnnGroupSpaces">
            <%-- NORMAL VIEW --%>
            <!-- ko ifnot: isMobileView -->
            <div class="static-row" id="static-row-group-tabs">
                <ul class="dnnAdminTabNav tabNav dnnClear moduleContainer-normalView">
                    <% foreach (var t in GroupPages) { %>
                    <li class="tabNavTab">
                        <a>
                            <span><%= t.TabName %></span>
                        </a>
                    </li>
                    <% } %>
                </ul>
            </div>
            <div class="ko-container">
                <ul id="dnnAdminTabNav" class="dnnAdminTabNav tabNav dnnClear moduleContainer-normalView">
                    <!-- ko foreach: tabs -->
                    <li data-bind="click: $root.tabNavigate, css: { 'tabNavTab': true, 'tabNavCurrentTab': currentTab }">
                        <a>
                            <span data-bind="html: tabName"></span>
                        </a>
                    </li>
                    <!-- /ko -->
                    <li id="addTab" runat="server" Visible="false" class="tabNavTab addTab"><a data-bind="click: $root.editTabs">+</a></li>
                </ul>
            </div>
            <!-- /ko -->
            <%-- END NORMAL VIEW --%>

        </div>
        
        <div id="dnnMobile-dnnGroupSpaces">
            <div>
                <%-- MOBILE VIEW --%>
                <!-- ko if: isMobileView -->
                <div class="moduleContainer-mobileView ko-container">
                    <div class="dnnMobileGroupSpaces activeIndicator">
                        <a class="dnnMobileGroupSpaces-indicator" href="javascript:void(0)" data-bind="click: toggleNavBarMobile"></a>
                        <a class="dnnMobileGroupSpaces-label" href="javascript:void(0)" data-bind="click: toggleNavBarMobile, html: currentTabName"></a>
                        <div class="dnnClear"></div>
                    </div>
                    <!-- ko if: mobileTabs().length > 0 -->
                    <ul class="dnnMobileGroupsTab">
                         <!-- ko foreach: mobileTabs -->
                        <li data-bind="click: $root.tabNavigate, css: { 'tabNavTab': true, 'tabNavCurrentTab': currentTab }">
                            <a>
                                <span data-bind="html: tabName"></span>
                            </a>
                        </li>
                        <!-- /ko -->
                    </ul>
                    <!-- /ko -->
                </div>
                <!-- /ko -->
                <%-- END NORMAL VIEW --%>
            </div>
        </div>
    </div>
</asp:Panel>
<script type="text/javascript">
    dnn.social.loading('<%= ScopeWrapper.ClientID %>');
    function groupSpaceInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) return;
        settings.currentTabName = '<%=CurrentTab.TabName%>';
        try {
            window.dnn.social.applyBindings(new dnn.groupSpaces.GroupFeatures($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
