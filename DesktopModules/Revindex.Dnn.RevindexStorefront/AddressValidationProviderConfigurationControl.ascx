<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddressValidationProviderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.AddressValidationProviderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Address validation provider</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<fieldset>
		<asp:MultiView ID="DetailsMultiView" runat="server">
			<asp:View ID="AvaTaxView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AddressValidationProviderAvalaraTaxAccountNumberLabelControl" runat="server" Text="Account number:" />
					<asp:TextBox ID="AddressValidationProvidersAvalaraTaxAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AddressValidationProviderAvalaraTaxLicenseKeyLabelControl" runat="server" Text="License key:" />
					<asp:TextBox ID="AddressValidationProvidersAvalaraTaxLicenseKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AddressValidationProviderAvalaraTaxProviderUrlLabelControl" runat="server" Text="Provider URL:" HelpText="Leave blank unless you wish to use a different provider URL." />
					<asp:TextBox ID="AddressValidationProvidersAvalaraTaxProviderUrlTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AddressValidationProviderAvalaraTaxTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="AddressValidationProvidersAvalaraTaxTestModeCheckBox" runat="server"></asp:CheckBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AvalaraAddressValidationTestConnectionLabelControl" runat="server" Text="" />
					<asp:LinkButton ID="AvalaraAddressValidationTestConnectionLinkButton" runat="server" CssClass="dnnSecondaryAction" OnClick="TestConnectionLinkButton_Click" CommandArgument="AvaTax">Test connection</asp:LinkButton>
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
