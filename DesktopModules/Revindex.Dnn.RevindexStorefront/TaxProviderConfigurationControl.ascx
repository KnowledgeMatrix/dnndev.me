<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TaxProviderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.TaxProviderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Tax provider</h2>
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
			<asp:View ID="AvaTaxView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderAvalaraTaxAccountNumberLabelControl" runat="server" Text="Account number:" />
					<asp:TextBox ID="TaxProvidersAvalaraTaxAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderAvalaraTaxLicenseKeyLabelControl" runat="server" Text="License key:" />
					<asp:TextBox ID="TaxProvidersAvalaraTaxLicenseKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderAvalaraTaxCompanyCodeLabelControl" runat="server" Text="Company code:" />
					<asp:TextBox ID="TaxProvidersAvalaraTaxCompanyCodeTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderAvalaraTaxProviderUrlLabelControl" runat="server" Text="Provider URL:" HelpText="Leave blank unless you wish to use a different provider URL." />
					<asp:TextBox ID="TaxProvidersAvalaraTaxProviderUrlTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderAvalaraTaxTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="TaxProvidersAvalaraTaxTestModeCheckBox" runat="server"></asp:CheckBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="AvalaraTaxTestConnectionLabelControl" runat="server" Text="" />
					<asp:LinkButton ID="AvalaraTaxTestConnectionLinkButton" runat="server" CssClass="dnnSecondaryAction" OnClick="TestConnectionLinkButton_Click" CommandArgument="AvaTax">Test connection</asp:LinkButton>
				</div>
			</asp:View>
			<asp:View ID="Zip2TaxView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderZip2TaxUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="TaxProvidersZip2TaxUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="TaxProviderZip2TaxPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="TaxProvidersZip2TaxPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="Zip2TaxTestConnectionLabelControl" runat="server" Text="" />
					<asp:LinkButton ID="Zip2TaxTestConnectionLinkButton" runat="server" CssClass="dnnSecondaryAction" OnClick="TestConnectionLinkButton_Click" CommandArgument="Zip2Tax">Test connection</asp:LinkButton>
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
