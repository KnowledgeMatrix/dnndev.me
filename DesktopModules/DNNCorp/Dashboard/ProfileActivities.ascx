<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileActivities.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileActivities" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear moduleContainer dashboard-container">
    <span class="dashboard-profile-header strong-header" style="display: block" id="profileActivities"><%= Localization.GetString("MyActivity", LocalResourceFile) %></span>
    <div style="position: relative; margin: 20px 0 20px 0">
        <div class="tag-menu heatmap-tag-menu"></div>
        <div id="dashboard-profile-heatmap" class="dashboard-profile-heatmap"></div>
    </div>
    <div class="dashboard-profile-heatmap-list">
        <p data-bind="html: selectedDate"></p>
        <ul data-bind="visible: activities().length > 0, foreach: activities">
            <li>
                <a data-bind="html: ContentTitle, attr: { 'href': ContentLink }, visible: ContentLink != null && ContentLink.length > 0"></a>
                <div>
                    <span class="action" data-bind="html: Action"></span>
                    <span class="area" data-bind="html: Area"></span>
                    <span class="points" data-bind="html: 'points: ' + ReputationPoints"></span>
                </div>
            </li>
        </ul>
        <p data-bind="visible: activities().length == 0 && selectedDate().length > 0">No activites on this date</p>
    </div>
</asp:Panel>
<script type="text/javascript">
    function dashboard_activitiesInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.dashboard.ProfileActivities(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
