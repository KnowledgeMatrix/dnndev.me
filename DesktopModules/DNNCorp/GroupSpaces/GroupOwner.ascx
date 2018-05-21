<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="GroupOwner.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.GroupOwner" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <div class="dnnClear group-owner-container" id="groupOwner">
        <h6><%= LocalizeString("GroupOwner") %></h6>
        <table class="group-space-sidelist-tbl">
            <tr>
                <td class="group-avatar">
                    <div class="avatar40">
                        <span>
                            <em>
                                <img src="<%= OwnerAvatarUrl %>" title="<%= OwnerDisplayName %>" alt="<%= OwnerDisplayName %>" />
                            </em>
                        </span>
                    </div>

                </td>
                <td class="group-name">
                    <a class="dnnSocialLink" href="<%= OwnerProfileUrl %>">
                        <span><%= OwnerDisplayName %></span>
                    </a>
                </td>
            </tr>
        </table>
    </div>
</asp:Panel>
