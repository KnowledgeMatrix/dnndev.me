<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MultiSafePayAdmin.ascx.cs" Inherits="CartViper.Modules.Store.Cart.MultiSafePayAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUseTest" runat="server" controlname="chkUseTest" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:checkbox id="chkUseTest" runat="server" cssclass="Normal" Checked="false"></asp:checkbox>
	    </td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblAccountId" runat="server" controlname="txtAccountId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtAccountId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSiteId" runat="server" controlname="txtSiteId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSiteId" runat="server" Width="200px" MaxLength="50" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSiteCode" runat="server" controlname="txtSiteCode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtSiteCode" runat="server" Width="300px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblApiUrl" runat="server" controlname="txtApiUrl" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtApiUrl" runat="server" Width="300px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblNotificationMessage" runat="server" controlname="txtNotificationMessage" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:textbox id="txtNotificationMessage" runat="server" TextMode="MultiLine" Rows="2" Width="300px" MaxLength="255" cssclass="Normal"></asp:textbox>
		</td>
	</tr>
    <tr>
        <td class="NormalBold" style="width:150px; vertical-align:top;">
            <dnn:label id="lblIncludeReturnLink" runat="server" controlname="chkIncludeReturnLink" suffix=":"></dnn:label>
        </td>
        <td style="vertical-align:top;">
			<asp:checkbox id="chkIncludeReturnLink" runat="server" cssclass="Normal"></asp:checkbox>
        </td>
    </tr>
    <tr>
        <td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblBackOfficeNotificationUrlCaption" runat="server" controlname="lblBackOfficeNotificationUrl" suffix=":"></dnn:label>
        </td>
        <td style="vertical-align:top;">
            <asp:Label ID="lblBackOfficeNotificationUrl" style="display:block;" CssClass="infoCaption" runat="server"></asp:Label>
        </td>
    </tr>
	<tr>
	    <td colspan="2">
	        <asp:Label ID="lblError" runat="server" Font-Bold="true" ForeColor="red"></asp:Label>
	    </td>
	</tr>
</table>