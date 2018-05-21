<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecurePayAdmin.ascx.cs" Inherits="CartViper.Store.Cart.SecurePayProvider.SecurePayAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPostUrl" runat="server" controlname="txtPostUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtPostUrl" Width="400"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPostUrl"></asp:RequiredFieldValidator>
	    </td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblVendorId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPassword" runat="server" Width="200px" MaxLength="200" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
		</td>
	</tr>
</table>