<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ElavonHostedPaymentAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.ElavonHostedPaymentProvider.ElavonHostedPaymentAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox width="400px" runat="server" ID="txtMerchantId"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" ErrorMessage="Required" Display="Dynamic" ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSecretKey" runat="server" controlname="txtSecretKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox width="400px" runat="server" ID="txtSecretKey"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ErrorMessage="Required" Display="Dynamic" ControlToValidate="txtSecretKey"></asp:RequiredFieldValidator>
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