<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PayPayPayflowProAdmin.ascx.cs" Inherits="CartViper.Store.Cart.PayPalPayflowProProvider.PayPayPayflowProAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

    <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblHostUrl" runat="server" controlname="txtHostUrl" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
                <asp:TextBox runat="server" ID="txtHostUrl" Columns="35"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtHostUrl" 
                            ID="RequiredFieldValidator4" runat="server" resourcekey="RequiredFieldValidator3"></asp:RequiredFieldValidator>
	        </td>
	    </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top">
                <dnn:label id="lblUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtUsername"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtUsername" 
                            ID="RequiredFieldValidator3" runat="server" resourcekey="rfvUsername"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top">
                <dnn:label id="lblVendor" runat="server" controlname="txtVendor" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtVendor"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtVendor" ID="RequiredFieldValidator2" 
                        runat="server" resourcekey="rfvVendor"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top">
                <dnn:label id="lblPartner" runat="server" controlname="txtPartner" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPartner"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtPartner" ID="RequiredFieldValidator1" 
                        runat="server" resourcekey="rfvPartner"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top">
                <dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtPassword"></asp:TextBox>
                <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtPassword" ID="RequiredFieldValidator5" 
                        runat="server" resourcekey="rfvPassword"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
