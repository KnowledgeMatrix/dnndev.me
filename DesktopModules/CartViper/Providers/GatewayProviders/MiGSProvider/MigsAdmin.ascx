<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MigsAdmin.ascx.cs" Inherits="CartViper.Store.Cart.MigsProvider.MigsAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblVpcUrl" runat="server" controlname="txtVpcUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtVpcUrl" Width="350"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtVpcUrl"></asp:RequiredFieldValidator>
	    </td>
	</tr><tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" resourcekey="rf" Display="Dynamic" ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblAccessCode" runat="server" controlname="txtAccessCode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtAccessCode" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtAccessCode"></asp:RequiredFieldValidator>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSharedSecret" runat="server" controlname="txtSharedSecret" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSharedSecret" runat="server" Width="200px" MaxLength="200" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" resourcekey="rf" Display="Dynamic" ControlToValidate="txtSharedSecret"></asp:RequiredFieldValidator>
		</td>
	</tr>
</table>