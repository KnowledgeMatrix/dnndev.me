<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RaboOmniKassaAdmin.ascx.cs" Inherits="CartViper.Store.Cart.RaboOmniKassaProvider.RaboOmniKassaAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUrl" runat="server" controlname="txtUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtUrl" runat="server" Width="400px" MaxLength="512" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantId" runat="server" Width="300px" MaxLength="512" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblKeyVersion" runat="server" controlname="txtKeyVersion" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtKeyVersion" runat="server" Width="200px" MaxLength="20" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSecretKey" runat="server" controlname="txtSecretKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSecretKey" runat="server" Width="300px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
</table>