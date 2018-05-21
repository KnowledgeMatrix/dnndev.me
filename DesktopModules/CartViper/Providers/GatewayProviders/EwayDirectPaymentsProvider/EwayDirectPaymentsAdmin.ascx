<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EwayDirectPaymentsAdmin.ascx.cs" Inherits="CartViper.Store.Cart.EwayDirectPaymentsProvider.EwayDirectPaymentsAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblEwayInstallationId" runat="server" controlname="txtInstallationId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtInstallationId"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtInstallationId"></asp:RequiredFieldValidator>
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