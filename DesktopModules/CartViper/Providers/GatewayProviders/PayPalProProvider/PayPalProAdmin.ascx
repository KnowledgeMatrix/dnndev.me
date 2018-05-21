<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PayPalProAdmin.ascx.cs" Inherits="CartViper.Store.Cart.PayPalProProvider.PayPalProAdmin" %>
    
    <%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

        <table style="text-align:left;">
	        <tr>
		        <td class="NormalBold" style="width:150px; vertical-align:top;">
			        <dnn:label id="lblUseSandbox" runat="server" controlname="lblUseSandbox" suffix=":"></dnn:label>
		        </td>
		        <td style="vertical-align:top;">
			        <asp:checkbox id="chkUseSandbox" runat="server" cssclass="Normal" Checked="false"></asp:checkbox>
	            </td>
	        </tr>
            <tr>
                <td class="NormalBold" style="width:150px; vertical-align:top">
                    <dnn:label id="lblApiUsername" runat="server" controlname="txtApiUserame" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtApiUserame"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtApiUserame" 
                                ID="RequiredFieldValidator3" runat="server" resourcekey="RequiredFieldValidator3"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="width:150px; vertical-align:top">
                    <dnn:label id="lblApiPassword" runat="server" controlname="txtApiPassword" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtApiPassword"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtApiPassword" ID="RequiredFieldValidator2" 
                            runat="server" resourcekey="RequiredFieldValidator2"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="width:150px; vertical-align:top">
                    <dnn:label id="lblApiSignature" runat="server" controlname="txtApiSignature" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtApiSignature"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtApiSignature" ID="RequiredFieldValidator1" 
                           runat="server" resourcekey="RequiredFieldValidator1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="width:150px; vertical-align:top">
                    <dnn:label id="lblMaxFailedRecurring" runat="server" controlname="txtMaxFailedRecurring" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtMaxFailedRecurring"></asp:TextBox>
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtMaxFailedRecurring" ID="RequiredFieldValidator4" 
                           runat="server" resourcekey="RequiredFieldValidator1"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="width:150px; vertical-align:top">
                    <dnn:label id="lblAcceptAmexCards" runat="server" controlname="chkAcceptAmexCards" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkAcceptAmexCards" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="infoCaption">
                        <asp:Literal runat="server" ID="ltIpnHelp" />
                    </div>
                </td>
            </tr>
        </table>

    