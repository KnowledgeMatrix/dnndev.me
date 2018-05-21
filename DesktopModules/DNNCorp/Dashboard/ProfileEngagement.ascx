<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileEngagement.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileEngagement" %>
<asp:Panel class="dnnClear moduleContainer dashboard-container" runat="server" ID="ScopeWrapper">
    <h6 class="dashboard-profile-header strong-header" id="profileEngagement">
        <%= LocalizeString("Engagement") %>
    </h6>
    <div class="dnnClear"></div>
    <div class="dashboard-single-line-bar">
        <div class="dashboard-engagement-progress"></div>
    </div>
    <div class="dashboard-single-line-bar-value">
        <span data-bind="text: engagement"></span>
    </div>
    <div class="dnnClear"></div>

    <span class="dashboard-profile-header strong-header">
        <%= LocalizeString("Influence") %>
    </span>
    <div class="dnnClear"></div>
    <div class="dashboard-single-line-bar">
        <div class="dashboard-influence-progress"></div>
    </div>
    <div class="dashboard-single-line-bar-value">
        <span data-bind="text: influence"></span>
    </div>
    <div class="dnnClear"></div>
</asp:Panel>
<script type="text/javascript">
    function dashboard_engagementInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.dashboard.ProfileEngagement(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
