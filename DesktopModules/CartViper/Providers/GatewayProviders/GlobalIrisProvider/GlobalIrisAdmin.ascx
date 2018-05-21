<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GlobalIrisAdmin.ascx.cs" Inherits="CartViper.Store.Cart.GlobalIrisProvider.GlobalIrisAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">

    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" 
                    resourcekey="rf" Display="Dynamic" ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPassword" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" 
                resourcekey="rf" Display="Dynamic" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblAutoSettle" runat="server" controlname="chkAutoSettle" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkAutoSettle" />
		</td>
	</tr>


    <tr>
        <td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblResponseSuccessUrl" runat="server" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:label runat="server" ID="lblRedirectUrl" />
		</td><td></td>
    </tr>
</table>