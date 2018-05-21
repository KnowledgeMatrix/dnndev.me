<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FirstDataConnectAdmin.ascx.cs" Inherits="CartViper.Store.Cart.FirstDataConnectProvider.FirstDataConnectAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPostUrl" runat="server" controlname="txtPostUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtPostUrl" Width="350"></asp:TextBox>
            <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPostUrl"></asp:RequiredFieldValidator>
	    </td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblStoreId" runat="server" controlname="txtStoreId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtStoreId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtStoreId"></asp:RequiredFieldValidator>
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
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblPaymentMode" runat="server" controlname="ddlPaymentMode" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddlPaymentMode"></asp:DropDownList>
	    </td>
	</tr>
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblTimeZone" runat="server" controlname="ddlTimeZone" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddlTimeZone">
                <asp:ListItem Text="GMT" Value="GMT" />
                <asp:ListItem Text="EST" Value="EST" />
                <asp:ListItem Text="CST" Value="CST" />
                <asp:ListItem Text="MST" Value="MST" />
                <asp:ListItem Text="PST" Value="PST" />
            </asp:DropDownList>
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