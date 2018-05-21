<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="ArchiveSettings.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.ArchiveSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnTagSettings dnnClear">
    <div class="dnnFormItem">
        <dnn:label id="lblDisplayMode" runat="server" controlname="ddlDisplayMode" suffix=":" />
        <asp:DropDownList ID="ddlDisplayMode" runat="server">
            <asp:ListItem Value="List" resourcekey="List" />
            <asp:ListItem Value="Calendar" resourcekey="Calendar" />
        </asp:DropDownList>
    </div>
    <div class="dnnFormItem" id="divListMode" style="display: none;">
        <dnn:label id="lblListMode" runat="server" controlname="ddlListMode" suffix=":" />
        <asp:DropDownList ID="ddlListMode" runat="server">
            <asp:ListItem Value="DropDown" resourcekey="DropDown" />
            <asp:ListItem Value="UL" resourcekey="UL" />
        </asp:DropDownList>
    </div>
</div>