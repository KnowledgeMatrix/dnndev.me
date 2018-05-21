<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CCAvenueBillingPageAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.CCAvenueBillingPageProvider.CCAvenueBillingPageAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblMerchantKey" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtMerchantId" Columns="5" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblAccessCode" runat="server" controlname="txtAccessCode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtAccessCode" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblWorkingCode" runat="server" controlname="txtWorkingCode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtWorkingCode" runat="server" cssclass="Normal"></asp:textbox>			
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
			<dnn:label id="lblTestMode" runat="server" controlname="chkIsTestMode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkIsTestMode" />		
	    </td>
	</tr>
</table>