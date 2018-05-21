<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BarclaysEPDQAdmin.ascx.cs" Inherits="CartViper.Store.Cart.BarclaysEPDQProvider.BarclaysEPDQAdmin" %>
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
    </table>