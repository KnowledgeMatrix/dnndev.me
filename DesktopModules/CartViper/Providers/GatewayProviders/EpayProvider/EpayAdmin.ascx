﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EpayAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.EpayProvider.EpayAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblAccountNumber" runat="server" controlname="txtInstallationId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox width="400px" runat="server" ID="txtAccountNumber"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" ErrorMessage="Required" Display="Dynamic" ControlToValidate="txtAccountNumber"></asp:RequiredFieldValidator>
	    </td>
	</tr>
     <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblUseSandbox" runat="server" controlname="chkUseSandbox" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkUseSandbox" />
		</td>
	</tr>
</table>