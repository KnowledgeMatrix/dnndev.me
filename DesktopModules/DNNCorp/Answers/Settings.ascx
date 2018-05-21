<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.Answers.Settings" Codebehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnClear dnnForm">
    <div class="dnnFormItem">
        <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode"  />
        <asp:DropDownList runat="server" ID="ddlMode">
            <Items>
            <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
            <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
            </Items>
        </asp:DropDownList>
    </div>
</div>