<%@ Control language="c#" CodeBehind="QBMSAdmin.ascx.cs" Inherits="CartViper.Store.Cart.QBMSProvider.QBMSAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
    <tr>
		<td class="NormalBold" style="width:250px; vertical-align:top;">
			<dnn:label id="lblUseSandBox" runat="server" controlname="chkUseSandBox" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkUseSandBox" />
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblApplicationLogin" runat="server" controlname="txtApplicationLogin" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtApplicationLogin" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblConnectionTicket" runat="server" controlname="txtConnectionTicket" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtConnectionTicket" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
</table>
