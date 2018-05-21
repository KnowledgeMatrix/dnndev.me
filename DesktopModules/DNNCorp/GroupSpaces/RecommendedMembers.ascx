<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="RecommendedMembers.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.RecommendedMembers" %>
<%@ Register TagPrefix="dnn" TagName="GroupInviteMembers" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/GroupInviteMembers.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <div class="group-invite-dialog" style="display: none;">
        <div class="group-invite-container" data-bind="stopBindings: true">
            <dnn:GroupInviteMembers ID="InviteMembers" runat="server" />
        </div>   
    </div>
    <div class="dnnClear recommended-members-container" id="recommendedMembers">
        <h6><%= LocalizeString("RecommendedMembers") %></h6>

        <!-- ko if: totalPages() > 1  -->
        <div class="dnnPagingButtons dnnRight">
            <a href="javascript:void(0)" data-bind="click: prev, attr: { 'class': 'pager-prev ' + prevClass() }"></a>
            <a href="javascript:void(0)" data-bind="click: next, attr: { 'class': 'pager-next ' + nextClass() }"></a>
        </div>
        <!-- /ko -->
        <table class="group-space-sidelist-tbl">
            <tbody>
                  <!-- ko foreach: members -->
                    <tr>
                        <td class="group-avatar">
                            <div class="avatar40">
                                <span>
                                    <em>
                                        <a data-bind="attr: { href: ProfileUrl }" >
                                            <img data-bind="attr: { src: Avatar, alt: DisplayName, title: DisplayName }" />
                                        </a>
                                    </em>
                                </span>
                            </div>
                        </td>
                        <td class="group-name">
                             <div class="user">
                                <a data-bind="attr: { href: ProfileUrl }" class="dnnSocialLink"><span data-bind="    text: DisplayName"></span></a>
                                <br/>
                                 <!-- ko if: $root.userCanInviteUsers -->
                                 <a data-bind="click: invite, attr: { id: 'recommendedInviteLink_User' + UserId() }" class="dnnPrimaryAction inviteButton"><%= LocalizeString("Invite") %></a>
                                 <!-- /ko -->
                            </div>
                        </td>
                    </tr>
                  <!-- /ko -->
            </tbody>
        </table>
        <!-- ko if: userCanInviteUsers -->
        <div class="invite-button-area">
            <a class="invite-button dnnSecondaryAction" data-bind="click: invite"><%= LocalizeString("InviteMembers") %></a>
        </div>
       <!-- /ko -->
    </div>
</asp:Panel>

<script type='text/javascript'>
    function recommendedMembersInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) return;
        var sf = $.ServicesFramework(settings.ModuleId);        
        try {
            window.dnn.social.applyBindings(new window.dnn.groupSpaces.RecommendedMembers($, sf, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
