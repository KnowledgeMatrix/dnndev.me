<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FirstDataAdmin.ascx.cs" Inherits="CartViper.Modules.Store.Cart.FirstDataAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUrl" runat="server" controlname="txtUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtUrl" runat="server" Width="300px" MaxLength="512" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblCertificatePath" runat="server" controlname="txtCertificatePath" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtCertificatePath" runat="server" Width="300px" MaxLength="512" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtUsername" runat="server" Width="200px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPassword" runat="server" Width="300px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblIsTestMode" runat="server" controlname="chkIsTestMode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkIsTestMode" />
		</td>
	</tr>
</table>