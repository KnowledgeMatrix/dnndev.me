<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BuckarooAdmin.ascx.cs" Inherits="CartViper.Store.Cart.BuckarooProvider.BuckarooAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblMerchantKey" runat="server" controlname="txtMerchantKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantKey" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSecretKey" runat="server" controlname="txtSecretKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSecretKey" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
     <tr style="display:none">
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPostUrl" runat="server" controlname="txtPostUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPostUrl" Text="https://payment.buckaroo.nl/gateway/payment.asp" Width="300" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
        <td class="NormalBold" style="width:150px; vertical-align:top;">
            <dnn:label id="lblLanguage" runat="server" controlname="ddlLanguage" suffix=":"></dnn:label>
        </td>
        <td>
            <asp:DropDownList runat="server" ID="ddlLanguage"></asp:DropDownList>
        </td>
    </tr>
     <tr>
        <td class="NormalBold" style="width:150px; vertical-align:top;">
            <dnn:label id="lblSupportedPaymentMethods" runat="server" controlname="chkCreditCard" suffix=":"></dnn:label>
        </td>
        <td>
            <asp:RadioButton runat="server" GroupName="method" ID="chkCreditCard" resourcekey="chkCreditCard" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkIdeal" resourcekey="chkIdeal" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkOnceOnly" resourcekey="chkOnceOnly" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkGiftCard" resourcekey="chkGiftCard" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkGiroPay" resourcekey="chkGiroPay" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkPaypal" resourcekey="chkPaypal" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkPaySafeCard" resourcekey="chkPaySafeCard" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkCashTicket" resourcekey="chkCashTicket" /><br />
            <asp:RadioButton runat="server" GroupName="method" ID="chkBankTransfer" resourcekey="chkBankTransfer" />
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
</table>