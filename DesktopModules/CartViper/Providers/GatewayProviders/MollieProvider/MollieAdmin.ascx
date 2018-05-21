<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MollieAdmin.ascx.cs" Inherits="CartViper.Store.Cart.MollieProvider.MollieAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

    <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblMolliePartnerId" runat="server" controlname="txtPartnerId" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:textbox id="txtPartnerId" runat="server" cssclass="Normal"></asp:textbox>			
	        </td>
	    </tr>
         <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblReturnSuccessUrl" runat="server" controlname="txtReturnSuccessUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox  Width="300" id="txtReturnSuccessUrl" runat="server" cssclass="Normal"></asp:textbox>	
            <asp:Label runat="server" ID="Label1" CssClass="adminPercentageInfo" resourcekey="lblOptional"></asp:Label>	
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" resourcekey="regDomain" ValidationExpression="(http://.+|https://.+)" ControlToValidate="txtReturnSuccessUrl" Display="Dynamic" runat="server" ErrorMessage="RegularExpressionValidator"/>		
	    </td>
	</tr>
     <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblReturnFailUrl" runat="server" controlname="txtReturnFailUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox Width="300" id="txtReturnFailUrl" runat="server" cssclass="Normal"></asp:textbox>	
            <asp:Label runat="server" ID="lblOptional" CssClass="adminPercentageInfo" resourcekey="lblOptional"></asp:Label>		
            <asp:RegularExpressionValidator ID="regDomain" resourcekey="regDomain" ValidationExpression="(http://.+|https://.+)" ControlToValidate="txtReturnFailUrl" Display="Dynamic" runat="server" ErrorMessage="RegularExpressionValidator"/>
	    </td>
	</tr>
        <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblTestMode" runat="server" controlname="chkIsTestMode" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:CheckBox runat="server" ID="chkIsTestMode" />		
	        </td>
	    </tr>
    </table>