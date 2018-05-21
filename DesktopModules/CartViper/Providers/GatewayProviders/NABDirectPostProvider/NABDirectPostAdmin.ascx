<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NABDirectPostAdmin.ascx.cs" Inherits="CartViper.Store.NABDirectPostProvider.NABDirectPostAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtMerchantId"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
	    </td>
	</tr>

    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblTransactionPassword" runat="server" controlname="txtTransactionPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtTransactionPassword"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtTransactionPassword"></asp:RequiredFieldValidator>
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