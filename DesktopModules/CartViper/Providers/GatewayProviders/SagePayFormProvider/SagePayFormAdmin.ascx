<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SagePayFormAdmin.ascx.cs" Inherits="CartViper.Store.Cart.SagePayFormProvider.SagePayFormAdmin" %>
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
			<dnn:label id="lblVendorId" runat="server" controlname="txtVendorId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtVendorId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
             <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtVendorId"></asp:RequiredFieldValidator>
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
        <td colspan="2"><strong>Advanced Settings</strong></td>
    </tr>
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblSendEmail" runat="server" controlname="ddlSendEmail" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddlSendEmail"></asp:DropDownList>
	    </td>
	</tr>
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblAVSCV2" runat="server" controlname="ddlAVSCV2" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddlAVSCV2"></asp:DropDownList>
	    </td>
	</tr>
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lbl3DSecure" runat="server" controlname="ddl3DSecure" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddl3DSecure"></asp:DropDownList>
	    </td>
	</tr>
    <tr>
	    <td class="NormalBold" style="width:180px; vertical-align:top;">
		    <dnn:label id="lblDescription" runat="server" controlname="txtDescription" suffix=":"></dnn:label>
	    </td>
	    <td style="vertical-align:top;">
            <asp:TextBox runat="server" ID="txtDescription" />
	    </td>
	</tr>
</table>