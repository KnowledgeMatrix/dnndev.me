<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BizgateAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.BizgateProvider.BizgateAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblAccountNumber" runat="server" controlname="txtAccountNumber" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtAccountNumber" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPassword" runat="server" cssclass="Normal"></asp:textbox>			
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPathToPfx" runat="server" controlname="txtPathToPfx" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPathToPfx" Width="400px" runat="server" cssclass="Normal"></asp:textbox>	
            <span class="adminPercentageInfo">e.g. c:\\documents\\myfile.pfx</span>		
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPathToCer" runat="server" controlname="txtPathToCer" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtPathToCer" Width="400px" runat="server" cssclass="Normal"></asp:textbox>	
            <span class="adminPercentageInfo">e.g. c:\\documents\\myfile.cer</span>		
	    </td>
	</tr>
</table>