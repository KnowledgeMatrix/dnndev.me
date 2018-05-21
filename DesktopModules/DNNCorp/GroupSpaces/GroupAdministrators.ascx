<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="GroupAdministrators.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.GroupAdministrators" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <div class="dnnClear group-administrators-container" id="groupAdmins">
        <h6><%= LocalizeString("GroupAdministrators") %></h6>

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
                                        <a data-bind="attr: { href: profileUrl }" >
                                            <img data-bind="attr: { src: avatar, alt: displayName, title: displayName }" />
                                        </a>
                                    </em>
                                </span>
                            </div>
                        </td>
                        <td class="group-name">
                            <div class="user">
                                <a data-bind="attr: { href: profileUrl }" class="dnnSocialLink"><span data-bind="text: displayName"></span></a>
                            </div>
                        </td>
                    </tr>
                 <!-- /ko -->
            </tbody>
        </table>
    </div>
</asp:Panel>

<script type='text/javascript'>
    function groupAdministratorsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        if (!settings.moduleScope) return;
        try {
            window.dnn.social.applyBindings(new window.dnn.groupSpaces.GroupAdministrators($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
