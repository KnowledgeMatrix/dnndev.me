<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileScore.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileScore" %>
<asp:Panel runat="server" class="dnnClear moduleContainer dashboard-container" ID="ScopeWrapper">
    <span class="dashboard-profile-header strong-header" id="profileScore">
        <%= LocalizeString("Points") %>
    </span>
    <span class="dashboard-profile-header-tip" data-bind="visible: showHelpPoints">
        <a data-bind="click: helpPoints">
            <%= LocalizeString("HowDoIWinPoints") %>
        </a>
    </span>
    <div class="points-list" style="display: none">
        <div class="points-list-item">
            <span class="points-header">
                <%= LocalizeString("Today") %>
            </span>
            <div class="points-value" data-bind="html: pointsToday"></div>
        </div>
        <div class="points-list-item">
            <span class="points-header">
                <%= LocalizeString("Best") %>
            </span>
            <div class="points-value" data-bind="html: pointsBest"></div>
        </div>
        <div class="points-list-item">
            <span class="points-header">
                <%= LocalizeString("Total") %>
            </span>
            <div class="points-value" data-bind="html: pointsTotal"></div>
        </div>
    </div>
</asp:Panel>
<script type="text/javascript">
    function dashboard_scoreInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.dashboard.ProfileScore(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
