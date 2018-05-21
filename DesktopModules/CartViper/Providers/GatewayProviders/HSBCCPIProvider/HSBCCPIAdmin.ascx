<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HSBCCPIAdmin.ascx.cs" Inherits="CartViper.Store.Cart.HSBCCPIProvider.HSBCCPIAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblStoreFrontId" runat="server" controlname="txtStoreFrontId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtStoreFrontId" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSharedSecret" runat="server" controlname="txtSharedSecret" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtSharedSecret" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUseSandbox" runat="server" controlname="chkUseSandbox" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkUseSandbox" />
		</td>
	</tr>
</table>