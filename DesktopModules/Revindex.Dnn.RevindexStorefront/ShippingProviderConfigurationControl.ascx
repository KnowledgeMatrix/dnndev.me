<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingProviderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ShippingProviderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Shipping provider</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
			<dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
		</div>
	</fieldset>
</asp:Panel>
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<fieldset>
		<asp:MultiView ID="DetailsMultiView" runat="server">
			<asp:View ID="ABFView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersABFSecureIDLabelControl" runat="server" Text="Secure ID:" />
					<asp:TextBox ID="ShippingProvidersABFSecureIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="AustraliaPostView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersAustraliaPostAPIKeyLabelControl" runat="server" Text="API Key:" />
					<asp:TextBox ID="ShippingProvidersAustraliaPostAPIKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersAustraliaPostTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersAustraliaPostTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="CanadaPostView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCanadaPostCustomerNumberLabelControl" runat="server" Text="Customer number:" />
					<asp:TextBox ID="ShippingProvidersCanadaPostCustomerNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCanadaPostUserIDLabelControl" runat="server" Text="User ID:" />
					<asp:TextBox ID="ShippingProvidersCanadaPostUserIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCanadaPostPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersCanadaPostPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCanadaPostContractIDLabelControl0" runat="server" Text="Contract ID:" />
					<asp:TextBox ID="ShippingProvidersCanadaPostContractIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCanadaPostTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersCanadaPostTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="CouriersPleaseView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCouriersPleaseAccountNumberLabelControl" runat="server" Text="Account number:" />
					<asp:TextBox ID="ShippingProvidersCouriersPleaseAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCouriersPleaseAPIKeyLabelControl" runat="server" Text="API key:" />
					<asp:TextBox ID="ShippingProvidersCouriersPleaseAPIKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersCouriersPleaseTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersCouriersPleaseTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="FedExView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExKeyLabelControl" runat="server" Text="Key:" />
					<asp:TextBox ID="ShippingProvidersFedExKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersFedExPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExAccountNumberLabelControl" runat="server" Text="Account number:" />
					<asp:TextBox ID="ShippingProvidersFedExAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExMeterNumberLabelControl" runat="server" Text="Meter number:" />
					<asp:TextBox ID="ShippingProvidersFedExMeterNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExFreightAccountNumberLabelControl" runat="server" Text="Freight account number:" HelpText="Enter the shipper freight account number if you intend to use FedEx Freight services." />
					<asp:TextBox ID="ShippingProvidersFedExFreightAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersFedExTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersFedExTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="ShipwireView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersShipwireUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="ShippingProvidersShipwireUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersShipwirePasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersShipwirePasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersShipwireTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersShipwireTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="SoutheasternView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersSoutheasternUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="ShippingProvidersSoutheasternUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersSoutheasternPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersSoutheasternPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersSoutheasternCustomerAccountLabelControl" runat="server" Text="Customer account:" />
					<asp:TextBox ID="ShippingProvidersSoutheasternCustomerAccountTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="UnishippersView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUnishippersUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="ShippingProvidersUnishippersUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUnishippersPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersUnishippersPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUnishippersCustomerNumberLabelControl" runat="server" Text="Customer number:" />
					<asp:TextBox ID="ShippingProvidersUnishippersCustomerNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUnishippersUPSAccountNumberLabelControl" runat="server" Text="UPS account number:" />
					<asp:TextBox ID="ShippingProvidersUnishippersUPSAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="UPSView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUPSAccessKeyLabelControl" runat="server" Text="Access key:" />
					<asp:TextBox ID="ShippingProvidersUPSAccessKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUPSUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="ShippingProvidersUPSUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUPSPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersUPSPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUPSShipperNumberLabelControl0" runat="server" Text="Shipper number:" />
					<asp:TextBox ID="ShippingProvidersUPSShipperNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUPSTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersUPSTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="USPSView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUSPSUserIDLabelControl" runat="server" Text="User ID:" />
					<asp:TextBox ID="ShippingProvidersUSPSUserIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUSPSPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="ShippingProvidersUSPSPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="ShippingProvidersUSPSTestModeLabelControl" runat="server" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." Text="Test mode:" />
					<asp:CheckBox ID="ShippingProvidersUSPSTestModeCheckBox" runat="server" />
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
