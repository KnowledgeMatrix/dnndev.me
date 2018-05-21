<%@ Control language="c#" CodeBehind="FirstDataE4Admin.ascx.cs" Inherits="CartViper.Store.FirstDataE4Provider.FirstDataE4Admin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblGateway" runat="server" controlname="txtGateway" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtGateway" CssClass="Normal" runat="server" Width="350px" MaxLength="255"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblUsername" runat="server" controlname="txtUsername" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtUsername" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtPassword" CssClass="Normal" runat="server" Width="150px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblTestMode" runat="server" controlname="cbTest" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox id="cbTest" runat="server" CssClass="Normal"></asp:CheckBox>
		</td>
	</tr>

    <tr>
        <td colspan="2">
            <div runat="server" id="divRelay" class="infoCaption">
                
            </div>
        </td>
    </tr>

</table>
