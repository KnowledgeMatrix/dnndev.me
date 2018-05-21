<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VirtualMerchantAdmin.ascx.cs" Inherits="CartViper.Store.Cart.VirtualMerchant.VirtualMerchantAdmin" %>
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
			<dnn:label id="lblUserId" runat="server" controlname="txtUserId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtUserId" runat="server"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtUserId"></asp:RequiredFieldValidator>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPin" runat="server" controlname="txtPin" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPin" runat="server"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPin"></asp:RequiredFieldValidator>
		</td>
	</tr>
     <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPostUrl" runat="server" controlname="txtCertificateLocation" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPostUrl" runat="server"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPostUrl"></asp:RequiredFieldValidator>
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