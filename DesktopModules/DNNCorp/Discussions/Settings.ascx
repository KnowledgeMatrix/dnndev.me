<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.Discussions.Settings" CodeBehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnClear">
    <div class="dnnFormItem">
        <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode" />
        <asp:DropDownList runat="server" ID="ddlMode">
            <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
            <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
        </asp:DropDownList>
    </div>
</div>
