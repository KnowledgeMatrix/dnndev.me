<%@ Control language="c#" CodeBehind="BPointAdmin.ascx.cs" Inherits="CartViper.Store.BPointProvider.BPointAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblMerchantNumber" runat="server" controlname="txtMerchantNumber" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtMerchantNumber" CssClass="Normal" runat="server" Width="300px" MaxLength="255"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtUsername" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtPassword" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblShopName" runat="server" controlname="txtShopName" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtShopName" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblBillerCode" runat="server" controlname="txtBillerCode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtBillerCode" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblIsTestMode" runat="server" controlname="chkIsTestMode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkIsTestMode" />
		</td>
	</tr>
</table>
