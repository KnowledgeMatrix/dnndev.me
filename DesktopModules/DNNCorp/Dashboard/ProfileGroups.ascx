<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProfileGroups.ascx.cs" Inherits="DotNetNuke.Professional.Dashboard.ProfileGroups" %>
<asp:Panel runat="server" class="dnnClear moduleContainer dashboard-container" ID="ScopeWrapper">
    <span class="dashboard-profile-header strong-header" id="profileGroups">
        <%= LocalizeString("MyGroups") %>
    </span>

    <!-- ko if: totalPages() > 1  -->
    <div class="dnnPagingButtons dnnRight">
        <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
        <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
    </div>
    <!-- /ko -->
    <table class="group-space-sidelist-tbl">
        <tbody>
            <!-- ko foreach: results -->
            <tr>
                <td>
                    <div class="avatar40">
                        <span>
                            <em>
                                <a data-bind="attr: { href: GroupUrl }">
                                    <img data-bind="attr: { src: IconUrl, alt: RoleName }" />
                                </a>
                            </em>
                        </span>
                    </div>
                </td>
                <td class="group-name">
                    <div>
                        <a data-bind="attr: { href: GroupUrl }" class="dnnSocialLink"><span data-bind="    text: RoleName"></span></a>
                    </div>
                </td>
            </tr>
            <!-- /ko -->
        </tbody>
    </table>
</asp:Panel>
<script type="text/javascript">
    function dashboard_groupsinit(settings) {
        var moduleScope = $(settings.moduleScope);
        if (moduleScope.length < 1) return;
        settings.moduleScope = moduleScope[0];
        try {
        dnn.social.applyBindings(new dnn.dashboard.ProfileGroups(settings), settings.moduleScope);
        } catch (ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
