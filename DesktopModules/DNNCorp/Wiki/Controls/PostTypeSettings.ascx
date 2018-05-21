<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PostTypeSettings.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.PostTypeSettings" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="post-type-container">
    <div class="post-type">
        <asp:DropDownList runat="server" ID="ctlPostTypes" AutoPostBack="True" OnSelectedIndexChanged="OnPostTypeSelected" />
    </div>
    <div class="post-type-metadata">
        <asp:CheckBoxList runat="server" ID="ctlMetdataList" />
    </div>
</asp:Panel>