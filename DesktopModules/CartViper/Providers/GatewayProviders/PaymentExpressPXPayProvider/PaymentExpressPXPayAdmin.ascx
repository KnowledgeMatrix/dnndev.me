<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentExpressPXPayAdmin.ascx.cs" Inherits="CartViper.Store.Cart.PaymentExpressPXPayProvider.PXPayAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

     <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblPxPayUserId" runat="server" controlname="txtPxPayUserId" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			   <asp:TextBox runat="server" ID="txtPxPayUserId"></asp:TextBox>
		    </td>
	    </tr>
        <tr>
           <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblPxPayKey" runat="server" controlname="txtPxPayKey" suffix=":"></dnn:label>
		    </td>
            <td>
                 <asp:TextBox Width="300" runat="server" ID="txtPxPayKey"></asp:TextBox>
            </td>
        </tr>        
    </table>