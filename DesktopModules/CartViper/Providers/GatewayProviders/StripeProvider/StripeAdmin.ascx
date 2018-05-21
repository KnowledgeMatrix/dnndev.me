<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StripeAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.StripeProvider.StripeAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblApiKey" runat="server" controlname="txtApiKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtApiKey" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtApiKey"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSecretApiKey" runat="server" controlname="txtSecretApiKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtSecretApiKey" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtSecretApiKey"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblUseTestMode" runat="server" controlname="chkUseTestMode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
            <asp:CheckBox runat="server" ID="chkUseTestMode" />
	    </td>
    </tr>
</table>

<div class="infoCaption">
    <asp:Label runat="server" resourcekey="stripeWebHookCaption"></asp:Label>
    <p><asp:Label runat="server" ID="lblWebHookUrl" /></p>
</div>