<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InternetSecureAdmin.ascx.cs" Inherits="CartViper.Store.Cart.InternetSecure.InternetSecureAdmin" %>
    <%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

     <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblTestMode" runat="server" controlname="chkIsTest" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:CheckBox runat="server" ID="chkIsTest" />
		    </td>
	    </tr>
        <tr>
           <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblMerchantId" runat="server" controlname="chkIsTest" suffix=":"></dnn:label>
		    </td>
            <td>
                 <asp:TextBox runat="server" ID="txtMerchantId"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rfRequiredField" ControlToValidate="txtMerchantId" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblPaymentGatewayUrl" runat="server" controlname="txtPaymentGatewayUrl" suffix=":"></dnn:label>
		    </td>
            <td>
                <asp:TextBox runat="server" Width="400px" ID="txtPaymentGatewayUrl"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ID="rfRequiredField" resourcekey="rfRequiredField" ControlToValidate="txtPaymentGatewayUrl" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>