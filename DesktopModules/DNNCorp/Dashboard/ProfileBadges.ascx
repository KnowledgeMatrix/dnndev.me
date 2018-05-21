<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileBadges.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileBadges" %>
<asp:Panel runat="server" class="dnnClear moduleContainer dashboard-container dashboard-profile-badges" ID="ScopeWrapper">
    <span class="dashboard-profile-header strong-header" id="profileBadges">
        <%= LocalizeString("Badges") %>
    </span>
    <!-- ko if: badges().length > 0 -->
    <span class="dashboard-profile-header strong-header" data-bind="text: '(' + badges().length + ')'"></span>
    <!-- /ko -->
    <div data-bind="attachSlider: true" class="dashboard-profile-badge-list">
        <!-- ko if: badges().length == 0 -->
        <div>
            <%= LocalizeString("UserHasNoBadges") %>
        </div>
        <!-- /ko -->

        <!-- ko if: badges().length > 0 -->
        <ul>
            <!-- ko foreach: badges -->
            <li>
                <img data-bind="attr: { src: badgeUrl, title: badgeName }" alt="" onerror="this.onerror = null; this.src = '<%= ResolveClientUrl(DotNetNuke.Mechanics.Components.Common.Constants.DefaultBadgeImage) %>'" />
            </li>
            <!-- /ko -->
        </ul>
        <!-- /ko -->
    </div>
    <div class="pager-rightside">
        <a class="pager-prev"></a>
         <a class="pager-next"></a>
    </div>
</asp:Panel>
<script type="text/javascript">
    function dashboard_badgesInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            dnn.social.applyBindings(new dnn.dashboard.ProfileBadges(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>