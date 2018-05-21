<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Confirmation.Standard11.Display" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="dnn2" %>
<asp:Panel ID="ConfirmationPanel" runat="server" CssClass="rvdsfConfirmationContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
	<div class="rvdsfCheckoutBreadcrumb">
		<asp:LinkButton ID="ViewCartNavigationLinkButton" runat="server" resourcekey="ViewCartNavigationLinkButton" CausesValidation="False" Enabled="False"></asp:LinkButton>
		<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		<asp:LinkButton ID="BillingAndShippingNavigationLinkButton" runat="server" resourcekey="BillingAndShippingNavigationLinkButton" CausesValidation="False" Enabled="False"></asp:LinkButton>
		<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		<asp:LinkButton ID="PlaceOrderNavigationLinkButton" runat="server" resourcekey="PlaceOrderNavigationLinkButton" CausesValidation="False" Enabled="False"></asp:LinkButton>
		<span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		<asp:LinkButton ID="ConfirmationNavigationLinkButton" runat="server" resourcekey="ConfirmationNavigationLinkButton" CausesValidation="False" Enabled="False" CssClass="rvdsfCheckoutBreadcrumbSelected"></asp:LinkButton>
	</div>
	<asp:Panel ID="OrderConfirmationPanel" runat="server" CssClass="dnnForm rvdPrintArea">
		<h2 class="dnnFormSectionHead">
			<asp:Label ID="OrderConfirmationSectionLabel" runat="server" resourcekey="OrderConfirmationSectionLabel"></asp:Label>
		</h2>
		<p>
			<asp:Label ID="ConfirmationMessageLabel" runat="server" resourcekey="ConfirmationMessageLabel"></asp:Label>
		</p>
		<div class="rvdsfConfirmationOrderInformationContainer">
			<h3 class="dnnFormSectionHead">
				<asp:Label resourcekey="OrderInformationLabel" ID="OrderInformationLabel" runat="server" />
			</h3>
			<div class="dnnFormItem rvdsfConfirmationOrderNumber">
				<dnn1:LabelControl ID="OrderNumberLabelControl" runat="server" />
				<asp:Label ID="OrderNumberLabel" runat="server"></asp:Label>
			</div>
			<asp:Panel ID="PurchaseOrderPanel" runat="server" CssClass="dnnFormItem">
				<dnn1:LabelControl ID="PurchaseOrderNumberLabelControl" runat="server" />
				<asp:Label ID="PurchaseOrderNumberLabel" runat="server"></asp:Label>
			</asp:Panel>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="OrderDateLabelControl" runat="server" />
				<asp:Label ID="OrderDateReceiptLabel" runat="server"></asp:Label>
			</div>
		</div>
		<div class="rvdsfConfirmationPaymentInformationContainer">
			<h3 class="dnnFormSectionHead">
				<asp:Label resourcekey="PaymentInformationLabel" ID="PaymentInformationLabel" runat="server" />
			</h3>
			<div>
				<dl class="rvdsfPaymentMethods">
					<asp:Literal ID="PaymentMethodLiteral" runat="server"></asp:Literal>
				</dl>
			</div>
		</div>
		<div class="rvdsfConfirmationBillingInformationContainer">
			<h3 class="dnnFormSectionHead">
				<asp:Label resourcekey="BillingInformationLabel" ID="BillingInformationLabel" runat="server" />
			</h3>
			<div>
				<asp:Label ID="BillingCompanyLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingFirstNameLabel" runat="server"></asp:Label>
				<asp:Label ID="BillingLastNameLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingStreetLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingCityLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingSubdivisionLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingCountryLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingPostalCodeLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingPhoneLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BillingEmailLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="BusinessTaxNumberLabel" runat="server"></asp:Label>
			</div>
		</div>
		<div class="rvdsfConfirmationShippingInformationContainer">
			<h3 class="dnnFormSectionHead">
				<asp:Label resourcekey="ShippingInformationLabel" ID="ShippingInformationLabel" runat="server" />
			</h3>
			<div>
				<asp:Label ID="ShippingCompanyLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingFirstNameLabel" runat="server"></asp:Label>
				<asp:Label ID="ShippingLastNameLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingStreetLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingCityLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingSubdivisionLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingCountryLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingPostalCodeLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingPhoneLabel" runat="server"></asp:Label>
			</div>
			<div>
				<asp:Label ID="ShippingEmailLabel" runat="server"></asp:Label>
			</div>
		</div>
		<asp:GridView ID="SalesOrderDetailReceiptGridView" CssClass="dnnGrid rvdsfSalesOrderDetailGrid dnnClear" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="ProductVariantID">
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:TemplateField HeaderText="ItemHeaderSalesOrderDetailReceiptGridView">
					<ItemTemplate>
						<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' CssClass="rvdsfCartGalleryThumbnail">
							<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
						</asp:HyperLink>
						<div class="rvdsfCartProduct">
							<asp:HyperLink ID="ProductNameHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' Text='<%# Eval("ProductName") %>'></asp:HyperLink>
							<dl class="rvdsfProductParts">
								<asp:Literal ID="ProductPartLiteral" runat="server" Text='<%# Eval("ProductPart") %>' />
							</dl>
							<dl class="rvdsfDynamicFormResults">
								<asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
							</dl>
						</div>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailReceiptGridView" />
				<asp:BoundField DataField="Quantity" HeaderText="QuantityHeaderSalesOrderDetailReceiptGridView" />
				<asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailReceiptGridView" />
			</Columns>
		</asp:GridView>
		<dl class="rvdsfDynamicFormResults">
			<asp:Literal ID="CheckoutDynamicFormResultLiteral" runat="server" />
		</dl>
		<div class="rvdsfCartTotalAmountContainer">
			<div class="dnnFormItem rvdsfTotalSalesOrderDetailDiscountAmount">
				<dnn1:LabelControl ID="TotalSalesOrderDetailDiscountLabelControl" runat="server" />
				<asp:Label ID="TotalSalesOrderDetailDiscountLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfSubTotalAmount">
				<dnn1:LabelControl ID="SubTotalLabelControl" runat="server" />
				<asp:Label ID="SubTotalLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfTotalShippingAmount">
				<dnn1:LabelControl ID="ShippingLabelControl" runat="server" />
				<asp:Label ID="ShippingLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfTotalHandlingAmount">
				<dnn1:LabelControl ID="HandlingLabelControl" runat="server" />
				<asp:Label ID="HandlingLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfTotalTaxesAmount">
				<dnn1:LabelControl ID="TaxesLabelControl" runat="server" />
				<asp:Label ID="TaxesLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfTotalAmount">
				<dnn1:LabelControl ID="TotalLabelControl" runat="server" />
				<asp:Label ID="TotalLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfTotalPaymentAmount">
				<dnn1:LabelControl ID="TotalPaymentLabelControl" runat="server" />
				<asp:Label ID="TotalPaymentLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem rvdsfBalanceDueAmount">
				<dnn1:LabelControl ID="BalanceDueLabelControl" runat="server" />
				<asp:Label ID="BalanceDueLabel" runat="server"></asp:Label>
			</div>
			<asp:Panel ID="TotalDiscountPanel" runat="server" CssClass="dnnFormItem rvdsfTotalDiscountAmount">
				<dnn1:LabelControl ID="TotalDiscountLabelControl" runat="server" />
				<asp:Label ID="TotalDiscountLabel" runat="server"></asp:Label>
			</asp:Panel>
			<asp:Panel ID="RewardsPointQualifiedPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
				<dnn1:LabelControl ID="RewardsPointQualifiedLabelControl" runat="server" />
				<asp:Label ID="RewardsPointQualifiedLabel" runat="server"></asp:Label>
			</asp:Panel>
		</div>
	</asp:Panel>
</asp:Panel>
