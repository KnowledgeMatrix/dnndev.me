<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OgoneAdmin.ascx.cs" Inherits="CartViper.Store.Cart.OgoneProvider.OgoneAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

    <table style="text-align:left;">
	    <tr>
		    <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblAffiliationName" runat="server" controlname="txtAffiliationName" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:textbox id="txtAffiliationName" runat="server" cssclass="Normal"></asp:textbox>	
                <asp:RequiredFieldValidator runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtAffiliationName"></asp:RequiredFieldValidator>		
	        </td>
	    </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblPassPhraseIn" runat="server" controlname="txtPassPhraseIn" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:textbox id="txtPassPhraseIn" runat="server" cssclass="Normal"></asp:textbox>	
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPassPhraseIn"></asp:RequiredFieldValidator>		
	        </td>
        </tr>
        <tr>
            <td class="NormalBold" style="width:150px; vertical-align:top;">
			    <dnn:label id="lblPassPhraseOut" runat="server" controlname="txtPassPhraseOut" suffix=":"></dnn:label>
		    </td>
		    <td style="vertical-align:top;">
			    <asp:textbox id="txtPassPhraseOut" runat="server" cssclass="Normal"></asp:textbox>	
                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" resourcekey="rf" Display="Dynamic" ControlToValidate="txtPassPhraseOut"></asp:RequiredFieldValidator>		
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
         <tr>
        <td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSurcharge" runat="server" controlname="txtSurcharge" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSurcharge" runat="server" Columns="5" cssclass="Normal"></asp:textbox>
            <asp:Label runat="server" ID="lblSurchargeHelp" resourcekey="lblSurchargeHelp" CssClass="adminPercentageInfo"></asp:Label>
		</td>
    </tr>
     <tr>
        <td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSurchargeApplied" runat="server" controlname="rdSurchargeAsPercentage" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:RadioButton runat="server" ID="rdSurchargeAsPercentage" resourcekey="rdSurchargeAsPercentage" GroupName="surcharge" />
            <asp:RadioButton runat="server" ID="rdFixedAmount" resourcekey="rdFixedAmount" GroupName="surcharge" />
		</td>
    </tr>
    </table>