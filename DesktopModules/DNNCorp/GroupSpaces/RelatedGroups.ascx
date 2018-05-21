<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="RelatedGroups.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.RelatedGroups" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <div class="dnnClear related-group-container" id="relatedGroups">
        <h6><%= LocalizeString("RelatedGroups") %></h6>

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
                    <td class="group-avatar">
                        <a data-bind="attr: { href: groupUrl }" class="avatar40">
                            <span>
                                <em>
                                    <img data-bind="attr: { src: imageUrl, alt: groupName, title: groupName }" />
                                </em>
                            </span>
                        </a>
                    </td>
                    <td class="group-name">
                        <a data-bind="attr: { href: groupUrl }" class="dnnSocialLink"><span data-bind="text: groupName"></span></a>
                        <br/>
                        <span>
                            <span data-bind="text: memberCount"></span>
                            <!-- ko if: memberCount > 1  -->
                            <span><%= LocalizeString("Members") %></span> 
                            <!-- /ko -->
                            <!-- ko if: memberCount <= 1  -->
                            <span><%= LocalizeString("Member") %></span> 
                            <!-- /ko -->
                        </span>
                    </td>
                </tr>
                <!-- /ko -->
            </tbody>
        </table>
    </div>
</asp:Panel>

<script type='text/javascript'>
    function relatedGroupsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new window.dnn.groupSpaces.RelatedGroups($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
