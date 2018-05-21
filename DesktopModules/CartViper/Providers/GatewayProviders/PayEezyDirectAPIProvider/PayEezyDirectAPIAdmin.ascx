<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PayEezyDirectAPIAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.PayEezyDirectAPIProvider.PayEezyDirectAPIAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblSandbox" runat="server" controlname="chkSandbox" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox runat="server" ID="chkSandbox" ></asp:CheckBox>
        </td>
    </tr>
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblApiKey" runat="server" controlname="txtApiKey" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtApiKey" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtApiKey"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblApiSecret" runat="server" controlname="txtApiSecret" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtApiSecret" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="RequiredFieldValidator2" resourcekey="rf" Display="Dynamic" ControlToValidate="txtApiSecret"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblToken" runat="server" controlname="txtToken" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
           <asp:TextBox CssClass="txtToken" runat="server" ID="txtToken" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtToken"></asp:RequiredFieldValidator>
	    </td>
    </tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblPaymentType" runat="server" controlname="ddlPaymentType" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
            <asp:DropDownList runat="server" ID="ddlPaymentType">
                <asp:ListItem Text="Auth" Value="Auth" />
                <asp:ListItem Text="AuthAndCapture" Value="AuthAndCapture" />
            </asp:DropDownList>
	    </td>
    </tr>
</table>

