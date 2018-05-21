<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PayOneEzConnectAdmin.ascx.cs" Inherits="CartViper.Store.Cart.PayOneEzConnectProvider.PayOneEzConnectAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

     <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			   <asp:TextBox runat="server" ID="txtMerchantId"></asp:TextBox>
		    </td>
	    </tr>
        <tr>
           <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblBankId" runat="server" controlname="txtBandId" suffix=":"></dnn:label>
		    </td>
            <td>
                 <asp:TextBox runat="server" ID="txtBandId"></asp:TextBox>
            </td>
        </tr>        
        <tr>
           <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblSecretKey" runat="server" controlname="txtSecretKey" suffix=":"></dnn:label>
		    </td>
            <td>
                 <asp:TextBox Width="300" runat="server" ID="txtSecretKey"></asp:TextBox>
            </td>
        </tr> 
        <tr>
           <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblUseSandbox" runat="server" controlname="chkUseSandbox" suffix=":"></dnn:label>
		    </td>
            <td>
                 <asp:CheckBox runat="server" ID="chkUseSandbox" />
            </td>
        </tr> 
    </table>