<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WorldPayAdmin.ascx.cs" Inherits="CartViper.Store.WorldPayProvider.WorldPayAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblInstallationId" runat="server" controlname="txtInstallationId" suffix=":"></dnn:label>
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
    <tr>
        <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblResponseSuccessUrl" runat="server" controlname="lblResponseSuccessUrlValue" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:Label runat="server" ID="lblResponseSuccessUrlValue" />
	    </td>
    </tr>
</table>