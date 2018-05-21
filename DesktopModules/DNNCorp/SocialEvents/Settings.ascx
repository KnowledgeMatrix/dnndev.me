<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.SocialEvents.Settings" CodeBehind="Settings.ascx.cs" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnForm" id="dnnSuggestSettings">
    <div class="msmsContent dnnClear">
        <h2 id="SuggestionSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%= Localization.GetString("General", LocalResourceFile) %></a></h2>
        <fieldset>
            <div class="dnnFormItem">
                <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode" />
                <asp:DropDownList runat="server" ID="ddlMode">
                    <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
                    <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn:label id="plMapProvider" runat="server" controlname="txtMapProvider" suffix=":" />
                <asp:DropDownList ID="ddlMapProvider" runat="server" Width="100" AutoPostBack="True">
                    <asp:ListItem Value="google" resourcekey="mapProviderGoogle"></asp:ListItem>
                    <asp:ListItem Value="bing" resourcekey="mapProviderBing"></asp:ListItem>
                    <asp:ListItem Value="none" resourcekey="mapProviderNone"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Panel CssClass="dnnFormItem" ID="pnlBing" runat="server">
                <dnn:label id="plBingCredentials" runat="server" controlname="txtBingCredentials" suffix=":" />
                <asp:TextBox ID="txbBingCredentials" runat="server" />
            </asp:Panel>
        </fieldset>
    </div>
</div>
