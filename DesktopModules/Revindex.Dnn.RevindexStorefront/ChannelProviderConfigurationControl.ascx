<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChannelProviderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ChannelProviderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Channel provider</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<fieldset>
		<asp:MultiView ID="DetailsMultiView" runat="server">
			<asp:View ID="eBayView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ChannelProvidereBayDevIDLabelControl" runat="server" Text="Dev ID:" />
					<asp:TextBox ID="ChannelProviderseBayDevIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ChannelProvidereBayAppIDLabelControl" runat="server" Text="App ID:" />
					<asp:TextBox ID="ChannelProviderseBayAppIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ChannelProvidereBayCertIDLabelControl" runat="server" Text="Cert ID:" />
					<asp:TextBox ID="ChannelProviderseBayCertIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ChannelProvidereBayAuthTokenLabelControl" runat="server" Text="Auth token:" />
					<asp:TextBox ID="ChannelProviderseBayAuthTokenTextBox" runat="server" MaxLength="2000"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ChannelProvidereBayTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if you have been provided you with a separate test account. Under test mode, the system will attempt to transact with the provider's sandbox server." />
					<asp:CheckBox ID="ChannelProviderseBayTestModeCheckBox" runat="server"></asp:CheckBox>
				</div>
			</asp:View>
		</asp:MultiView>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
		<li>
			<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
		<li>
			<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
		</li>
	</ul>
</asp:Panel>
