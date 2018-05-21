<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageOrder.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageOrder" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(function ($)
		{
			jQuery('#SalesOrderDetailsViewTabPanel').dnnTabs();
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});

	    function ACHAgreementCustomValidator_ClientValidate(sender, e) {
	        e.IsValid = jQuery("input[id$='ACHAgreementCheckBox']").is(':checked');
	    }
	</script>

</asp:PlaceHolder>
<div class="rvdsfManageOrderContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer" DefaultButton="SearchLinkButton">
				<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">
						<asp:Label ID="SearchSectionLabel" runat="server" resourcekey="SearchSectionLabel" /></a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl runat="server" ID="OrderNumberSearchLabelControl"></dnn1:LabelControl>
						<asp:TextBox ID="SearchSalesOrderIDTextBox" runat="server"></asp:TextBox>
					</div>
					<div class="rvdActions">
						<asp:LinkButton ID="SearchLinkButton" runat="server" OnClick="SearchLinkButton_Click" CausesValidation="False" resourcekey="SearchLinkButton" CssClass="dnnPrimaryAction rvdSearchAction"></asp:LinkButton>
					</div>
				</fieldset>
			</asp:Panel>
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="SalesOrderGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDataBound="SalesOrderGridView_RowDataBound" DataKeyNames="SalesOrderGUID">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="OrderDate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="DateHeaderSalesOrderGridView" SortExpression="OrderDate" />
						<asp:BoundField DataField="SalesOrderNumber" HeaderText="OrderNumberHeaderSalesOrderGridView" SortExpression="SalesOrderNumber" />
						<asp:BoundField DataField="Status" HeaderText="StatusHeaderSalesOrderGridView" SortExpression="Status" />
						<asp:BoundField DataField="SalesPaymentStatus" HeaderText="PaymentStatusHeaderSalesOrderGridView" SortExpression="SalesPaymentStatus" />
						<asp:BoundField DataField="ShippingStatus" HeaderText="ShippingStatusHeaderSalesOrderGridView" SortExpression="ShippingStatus" />
						<asp:BoundField DataField="TotalAmount" HeaderText="AmountHeaderSalesOrderGridView" SortExpression="TotalAmount" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="SalesOrderObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCountByUser" SelectMethod="GetAllByUser" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.SalesOrderController">
					<SelectParameters>
						<asp:Parameter Name="sortExpression" Type="String" />
						<asp:Parameter Name="maximumRows" Type="Int32" />
						<asp:Parameter Name="startRowIndex" Type="Int32" />
						<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
						<rvd1:UserControlParameter Name="userID" PropertyName="UserId" />
						<asp:ControlParameter ControlID="SearchSalesOrderIDTextBox" Name="salesOrderNumber" PropertyName="Text" Type="String" />
					</SelectParameters>
				</asp:ObjectDataSource>
				<asp:Label ID="SalesOrderIDHiddenLabel" runat="server" Visible="False"></asp:Label>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<div id="SalesOrderDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav dnnClear">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" resourcekey="GeneralDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= OrderDetailDetailsViewPanel.ClientID %>">
						<asp:Label ID="OrderDetailDetailsViewTabLabel" runat="server" resourcekey="OrderDetailDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= BillingDetailsViewPanel.ClientID %>">
						<asp:Label ID="BillingDetailsViewTabLabel" runat="server" resourcekey="BillingDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
						<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" resourcekey="ShippingDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= TaxDetailsViewPanel.ClientID %>">
						<asp:Label ID="TaxDetailsViewTabLabel" runat="server" resourcekey="TaxDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= PaymentDetailsViewPanel.ClientID %>">
						<asp:Label ID="PaymentDetailsViewTabLabel" runat="server" resourcekey="PaymentDetailsViewTabLabel" /></a></li>
					<li><a href="#<%= RelatedDetailsViewPanel.ClientID %>">
						<asp:Label ID="RelatedDetailsViewTabLabel" runat="server" resourcekey="RelatedDetailsViewTabLabel" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SalesOrderNumberLabelControl" runat="server"></dnn1:LabelControl>
							<asp:Label ID="SalesOrderNumberLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SalesOrderGUIDLabelControl" runat="server" />
							<asp:Label ID="SalesOrderGUIDLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="StatusLabelControl" runat="server" />
							<asp:Label ID="StatusLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="OrderDateLabelControl" runat="server" />
							<asp:Label ID="OrderDateLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PurchaseOrderNumberLabelControl" runat="server" />
							<asp:Label ID="PurchaseOrderNumberLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CustomerNotesLabelControl" runat="server" />
							<asp:Literal ID="CustomerNotesLiteral" runat="server"></asp:Literal>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="OrderDetailDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem rvdsfSubTotalAmount">
							<dnn1:LabelControl ID="SubTotalAmountLabelControl" runat="server" />
							<asp:Label ID="SubTotalAmountLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
					<fieldset>
						<asp:GridView ID="SalesOrderDetailGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID" CssClass="dnnGrid" GridLines="None" OnRowDataBound="SalesOrderDetailGridView_RowDataBound">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:TemplateField HeaderText="ProductHeaderSalesOrderDetailGridView" SortExpression="ProductName">
									<ItemTemplate>
										<asp:HyperLink ID="ProductNameHyperLink" runat="server" Text='<%# Eval("ProductName") %>' Target="_blank"></asp:HyperLink>
										<dl id="BookingDescriptionList" class="rvdsfBookingDates" runat="server" visible="false">
											<dt>
												<asp:Label ID="BookingStartDateLabel" runat="server" resourcekey="BookingStartDateLabel" /></dt>
											<dd><asp:Label ID="BookingStartDateValueLabel" runat="server" /></dd>
											<dt>
												<asp:Label ID="BookingStopDateLabel" runat="server" resourcekey="BookingStopDateLabel" /></dt>
											<dd><asp:Label ID="BookingStopDateValueLabel" runat="server" /></dd>
										</dl>
										<dl class="rvdsfProductParts">
											<asp:Literal ID="ProductPartLiteral" runat="server" />
										</dl>
										<dl class="rvdsfDynamicFormResults">
											<asp:Literal ID="DynamicFormResultLiteral" runat="server" />
										</dl>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="SKU" HeaderText="SKUHeaderSalesOrderDetailGridView" SortExpression="SKU" />
								<asp:BoundField DataField="Quantity" HeaderText="QuantityHeaderSalesOrderDetailGridView" SortExpression="Quantity" />
								<asp:BoundField DataField="TotalAmount" HeaderText="AmountHeaderSalesOrderDetailGridView" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="SalesOrderDetailObjectDataSource" runat="server" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.SalesOrderDetailController" EnablePaging="True">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:ControlParameter ControlID="SalesOrderIDHiddenLabel" Name="salesOrderID" PropertyName="Text" Type="Int32" />
								<asp:Parameter Name="parentSalesOrderDetailID" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CheckoutDynamicFormResultLabelControl" runat="server" />
							<div class="rvdFormSubContainer">
								<dl class="rvdsfDynamicFormResults">
									<asp:Literal ID="CheckoutDynamicFormResultLiteral" runat="server" />
								</dl>
							</div>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="BillingDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingFirstNameLabelControl" runat="server" />
							<asp:Label ID="BillingFirstNameLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingLastNameLabelControl" runat="server" />
							<asp:Label ID="BillingLastNameLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingCompanyLabelControl" runat="server" />
							<asp:Label ID="BillingCompanyLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingCountryLabelControl" runat="server" />
							<asp:Label ID="BillingCountryLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingStreetLabelControl" runat="server" />
							<asp:Label ID="BillingStreetLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingCityLabelControl" runat="server" />
							<asp:Label ID="BillingCityLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingSubdivisionLabelControl" runat="server" Text="State/Province:" />
							<asp:Label ID="BillingSubdivisionLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingPostalCodeLabelControl" runat="server" />
							<asp:Label ID="BillingPostalCodeLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingPhoneLabelControl" runat="server" />
							<asp:Label ID="BillingPhoneLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="BillingEmailLabelControl" runat="server" />
							<asp:Label ID="BillingEmailLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingStatusLabelControl" runat="server" />
							<asp:Label ID="ShippingStatusLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingAmountLabelControl" runat="server" />
							<asp:Label ID="ShippingAmountLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingMethodNameLabelControl" runat="server" />
							<asp:Label ID="ShippingMethodNameLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingTrackingCodeLabelControl" runat="server" />
							<asp:Label ID="ShippingTrackingCodeLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" />
							<asp:Label ID="ShippingFirstNameLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" />
							<asp:Label ID="ShippingLastNameLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" />
							<asp:Label ID="ShippingCompanyLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" />
							<asp:Label ID="ShippingCountryLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" />
							<asp:Label ID="ShippingStreetLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" />
							<asp:Label ID="ShippingCityLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" />
							<asp:Label ID="ShippingSubdivisionLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" />
							<asp:Label ID="ShippingPostalCodeLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" />
							<asp:Label ID="ShippingPhoneLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" />
							<asp:Label ID="ShippingEmailLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="TaxDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="TaxesLabelControl" runat="server" />
							<asp:Label ID="TaxesLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="PaymentDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="SalesPaymentStatusLabelControl" runat="server" />
							<asp:Label ID="SalesPaymentStatusLabel" runat="server"></asp:Label>
						</div>
					</fieldset>
					<fieldset>
						<div class="dnnFormItem rvdsfTotalAmount">
							<dnn1:LabelControl ID="TotalAmountLabelControl" runat="server" />
							<asp:Label ID="TotalAmountLabel" runat="server"></asp:Label>
						</div>
						<div class="dnnFormItem rvdsfTotalPaymentAmount">
							<dnn1:LabelControl ID="TotalPaymentLabelControl" runat="server" />
							<asp:Label ID="TotalPaymentLabel" runat="server"></asp:Label>
						</div>
						<asp:Panel ID="BalanceDuePanel" runat="server" CssClass="dnnFormItem rvdsfBalanceDueAmount">
							<dnn1:LabelControl ID="BalanceDueLabelControl" runat="server" />
							<asp:Label ID="BalanceDueLabel" runat="server"></asp:Label>
						</asp:Panel>
					</fieldset>
					<fieldset>
						<asp:Panel ID="GroupTotalAmountPanel" runat="server" CssClass="dnnFormItem rvdsfTotalAmount">
							<dnn1:LabelControl ID="GroupTotalAmountLabelControl" runat="server" />
							<asp:Label ID="GroupTotalAmountLabel" runat="server"></asp:Label>
						</asp:Panel>
						<asp:Panel ID="GroupTotalPaymentPanel" runat="server" CssClass="dnnFormItem rvdsfTotalPaymentAmount">
							<dnn1:LabelControl ID="GroupTotalPaymentLabelControl" runat="server" />
							<asp:Label ID="GroupTotalPaymentLabel" runat="server"></asp:Label>
						</asp:Panel>
						<asp:Panel ID="GroupBalanceDuePanel" runat="server" CssClass="dnnFormItem rvdsfBalanceDueAmount">
							<dnn1:LabelControl ID="GroupBalanceDueLabelControl" runat="server" />
							<asp:Label ID="GroupBalanceDueLabel" runat="server"></asp:Label>
						</asp:Panel>
					</fieldset>
					<fieldset>
						<asp:GridView ID="SalesPaymentGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="SalesPaymentID" OnRowDataBound="SalesPaymentGridView_RowDataBound" CssClass="dnnGrid" GridLines="None">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:BoundField DataField="CreateDate" HeaderText="DateHeaderSalesPaymentGridView" SortExpression="CreateDate" DataFormatString="{0:yyyy-MM-dd}" />
								<asp:BoundField DataField="TransactionType" HeaderText="TypeHeaderSalesPaymentGridView" SortExpression="TransactionType" />
								<asp:BoundField DataField="PaymentMethod" HeaderText="PaymentMethodHeaderSalesPaymentGridView" SortExpression="PaymentMethod" />
								<asp:BoundField HeaderText="AmountHeaderSalesPaymentGridView" DataField="Amount" SortExpression="Amount" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="SalesPaymentObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.SalesPaymentController">
							<SelectParameters>
								<asp:Parameter Name="sortExpression" Type="String" />
								<asp:Parameter Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:ControlParameter ControlID="SalesOrderIDHiddenLabel" Name="salesOrderID" PropertyName="Text" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<asp:Panel ID="PayNowPanel" runat="server">
							<fieldset>
								<asp:Panel ID="VoucherPanel" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="VoucherLabelControl" runat="server" />
										<asp:TextBox ID="VoucherCodeTextBox" runat="server" MaxLength="100" AutoCompleteType="Disabled" />
										<asp:LinkButton ID="AddVoucherLinkButton" runat="server" OnClick="AddVoucherLinkButton_Click" ValidationGroup="ManageOrderDetailsViewControl" CausesValidation="False" CssClass="rvdAddNewGridAction" />
										<asp:DataList ID="VoucherDataList" CssClass="rvdsfManageOrderVoucherList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
											<ItemTemplate>
												<asp:LinkButton ID="DeleteVoucherLinkButton" runat="server" CommandArgument='<%# Eval("Code") %>' OnClick="DeleteVoucherLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteVoucherLinkButton" />
												<asp:Label ID="VoucherCodeLabel" runat="server" Text='<%# String.Format("{0} - {1}", Eval("Code"), Eval("Amount")) %>' />
											</ItemTemplate>
										</asp:DataList>
									</div>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PaymentMethodLabelControl" runat="server" />
									<asp:RadioButtonList ID="PaymentMethodRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PaymentMethodRadioButtonList_SelectedIndexChanged" CssClass="dnnFormRadioButtons" RepeatLayout="Flow">
										<asp:ListItem resourcekey="NonePaymentMethodListItem" Value="7">None</asp:ListItem>
                                        <asp:ListItem resourcekey="ACHPaymentMethodListItem" Value="23">ACH</asp:ListItem>
										<asp:ListItem resourcekey="AuthorizeNetCIMPaymentMethodListItem" Value="18">Authorize.Net CIM</asp:ListItem>
										<asp:ListItem resourcekey="AuthorizeNetSIMPaymentMethodListItem" Value="13">Authorize.Net SIM</asp:ListItem>
										<asp:ListItem resourcekey="CreditCardPaymentMethodListItem" Value="3">Credit Card</asp:ListItem>
										<asp:ListItem resourcekey="DotpayPaymentMethodListItem" Value="21">Dotpay</asp:ListItem>
										<asp:ListItem resourcekey="MasterCardIGSHostedPaymentMethodListItem" Value="14">MasterCard virtual payment</asp:ListItem>
										<asp:ListItem resourcekey="MolliePaymentMethodListItem" Value="11">Mollie</asp:ListItem>
										<asp:ListItem resourcekey="PaymentExpressPaymentMethodListItem" Value="22">Payment Express</asp:ListItem>
										<asp:ListItem resourcekey="PayFastPaymentMethodListItem" Value="8">PayFast</asp:ListItem>
										<asp:ListItem resourcekey="PayPalPaymentMethodListItem" Value="6">PayPal</asp:ListItem>
										<asp:ListItem resourcekey="Paystation3PartyPaymentMethodListItem" Value="15">Paystation</asp:ListItem>
										<asp:ListItem resourcekey="PayUBusinessPaymentMethodListItem" Value="19">PayU Business</asp:ListItem>
										<asp:ListItem resourcekey="SagePayFormPaymentMethodListItem" Value="17">Sage Pay</asp:ListItem>
										<asp:ListItem resourcekey="SuomenVerkkomaksutPaymentMethodListItem" Value="12">Suomen Verkkomaksut</asp:ListItem>
										<asp:ListItem resourcekey="TowahPaymentMethodListItem" Value="9">Towah</asp:ListItem>
										<asp:ListItem resourcekey="VirtualCardServicesPayPaymentMethodListItem" Value="20">Virtual Card Services Pay</asp:ListItem>
									</asp:RadioButtonList>
								</div>
                                <asp:Panel ID="ACHPanel" runat="server">
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="InstitutionNameLabelControl" Text="Bank name:" runat="server" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="InstitutionNameRequiredFieldValidator" resourcekey="InstitutionNameRequiredFieldValidator" runat="server" ControlToValidate="InstitutionNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="InstitutionNameTextBox" runat="server" CssClass="dnnFormRequired" />
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="InstitutionNumberLabelControl" Text="Routing Number:" runat="server" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="InstitutionNumberRequiredFieldValidator" resourcekey="InstitutionNumberRequiredFieldValidator" runat="server" ControlToValidate="InstitutionNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="InstitutionNumberRegularExpressionValidator" runat="server" ControlToValidate="InstitutionNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d]{6,20}" ValidationGroup="SalesPaymentDetailsViewControl" resourcekey="InstitutionNumberRegularExpressionValidator"></asp:RegularExpressionValidator>
                                        <asp:TextBox ID="InstitutionNumberTextBox" runat="server" CssClass="dnnFormRequired" />
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="AccountTypeLabelControl" Text="Account type:" runat="server" CssClass="dnnFormRequired" />
                                        <asp:DropDownList ID="AccountTypeDropDownList" runat="server">
						                    <asp:ListItem resourcekey="CheckingAccountTypeListItem" Value="1" />
						                    <asp:ListItem resourcekey="SavingsAccountTypeListItem" Value="2" />
					                    </asp:DropDownList>
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="AccountNumberLabelControl" runat="server" Text="Account Number:" CssClass="dnnFormRequired" />
                                        <asp:RequiredFieldValidator ID="AccountNumberRequiredFieldValidator" runat="server" ControlToValidate="AccountNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl" resourcekey="AccountNumberRequiredFieldValidator"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="AccountNumberRegularExpressionValidator" runat="server" ControlToValidate="AccountNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d]{6,20}" ValidationGroup="SalesPaymentDetailsViewControl" resourcekey="AccountNumberRegularExpressionValidator"></asp:RegularExpressionValidator>
                                        <asp:TextBox ID="AccountNumberTextBox" runat="server" MaxLength="24" CssClass="dnnFormRequired" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                    <div class="dnnFormItem">
                                        <dnn1:LabelControl ID="ACHAgreementLabelControl" runat="server" />
                                        <asp:CustomValidator runat="server" ID="ACHAgreementCustomValidator" EnableClientScript="true" ClientValidationFunction="ACHAgreementCustomValidator_ClientValidate" ValidationGroup="SalesPaymentDetailsViewControl" CssClass="dnnFormMessage dnnFormError" resourcekey="ACHAgreementCustomValidator" Display="Dynamic" />
                                        <div class="rvdFormSubContainer">
                                            <asp:CheckBox ID="ACHAgreementCheckBox" runat="server" ValidationGroup="CheckoutDisplayTemplate"/><asp:Label ID="ACHAgreementLabel" runat="server" resourcekey="ACHAgreementLabel" />
                                        </div>
                                    </div>
                                </asp:Panel>
								<asp:Panel ID="CreditCardPanel" runat="server">
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="CreditCardNumberLabelControl" runat="server" CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="CreditCardNumberRequiredFieldValidator" resourcekey="CreditCardNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator ID="CreditCardRegularExpressionValidator" resourcekey="CreditCardRegularExpressionValidator" runat="server" ControlToValidate="CreditCardNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[\d ]{13,24}" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RegularExpressionValidator>
										<asp:TextBox ID="CreditCardNumberTextBox" runat="server" MaxLength="24" AutoCompleteType="Disabled" autocomplete="off" CssClass="dnnFormRequired"></asp:TextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="CreditCardExpiryLabelControl" runat="server" CssClass="dnnFormRequired" />
										<asp:DropDownList ID="ExpirationMonthDropDownList" runat="server" CssClass="dnnFormRequired rvdsfCreditCardExpiryMonthInput">
											<asp:ListItem>01</asp:ListItem>
											<asp:ListItem>02</asp:ListItem>
											<asp:ListItem>03</asp:ListItem>
											<asp:ListItem>04</asp:ListItem>
											<asp:ListItem>05</asp:ListItem>
											<asp:ListItem>06</asp:ListItem>
											<asp:ListItem>07</asp:ListItem>
											<asp:ListItem>08</asp:ListItem>
											<asp:ListItem>09</asp:ListItem>
											<asp:ListItem>10</asp:ListItem>
											<asp:ListItem>11</asp:ListItem>
											<asp:ListItem>12</asp:ListItem>
										</asp:DropDownList>
										<asp:DropDownList ID="ExpirationYearDropDownList" runat="server" CssClass="dnnFormRequired rvdsfCreditCardExpiryYearInput">
										</asp:DropDownList>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="CreditCardVerificationNumberLabelControl" runat="server" CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="CreditCardVerificationNumberRequiredFieldValidator" resourcekey="CreditCardVerificationNumberRequiredFieldValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RequiredFieldValidator>
										<asp:RegularExpressionValidator ID="CreditCardVerificationNumberRegularExpressionValidator" resourcekey="CreditCardVerificationNumberRegularExpressionValidator" runat="server" ControlToValidate="CreditCardVerificationNumberTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\d+" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RegularExpressionValidator>
										<asp:TextBox ID="CreditCardVerificationNumberTextBox" runat="server" MaxLength="5" AutoCompleteType="Disabled" autocomplete="off" CssClass="dnnFormRequired rvdsfCreditCardVerificationNumberInput"></asp:TextBox>
									</div>
								</asp:Panel>
								<asp:Panel ID="PaymentProfilePanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="PaymentProfileLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="PaymentProfileRequiredFieldValidator" resourcekey="PaymentProfileRequiredFieldValidator" runat="server" ControlToValidate="PaymentProfileRadioButtonList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPaymentDetailsViewControl">Payment profile is required.</asp:RequiredFieldValidator>
									<div class="rvdFormSubContainer">
										<asp:RadioButtonList ID="PaymentProfileRadioButtonList" runat="server" CssClass="dnnFormRadioButtons dnnFormRequired" RepeatLayout="Flow" ValidationGroup="SalesPaymentDetailsViewControl"></asp:RadioButtonList>
										<div class="rvdActions">
											<asp:LinkButton ID="CreatePaymentLinkButton" runat="server" OnClick="CreatePaymentLinkButton_Click" CausesValidation="False" resourcekey="CreatePaymentLinkButton" CssClass="dnnPrimaryAction rvdAddNewAction" />
											<asp:LinkButton ID="EditPaymentLinkButton" runat="server" OnClick="EditPaymentLinkButton_Click" CausesValidation="False" resourcekey="EditPaymentLinkButton" CssClass="dnnPrimaryAction rvdEditAction" />
											<asp:LinkButton ID="DeletePaymentLinkButton" runat="server" OnClick="DeletePaymentLinkButton_Click" CausesValidation="False" resourcekey="DeletePaymentLinkButton" CssClass="dnnSecondaryAction rvdDeleteAction" />
											<asp:LinkButton ID="UpdatePaymentLinkButton" runat="server" OnClick="UpdatePaymentLinkButton_Click" CausesValidation="False" resourcekey="UpdatePaymentLinkButton" CssClass="dnnSecondaryAction" Style="display: none" />
										</div>
									</div>
								</asp:Panel>
							</fieldset>
							<ul class="dnnActions dnnClear">
								<li>
									<asp:LinkButton ID="PayNowLinkButton" runat="server" Text="Pay now" OnClick="PayNowLinkButton_Click" ValidationGroup="SalesPaymentDetailsViewControl" CssClass="dnnPrimaryAction rvdPayNowAction" />
								</li>
							</ul>
						</asp:Panel>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="RelatedDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<asp:GridView ID="RelatedSalesOrderGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderID" CssClass="dnnGrid" GridLines="None" OnRowDataBound="RelatedSalesOrderGridView_RowDataBound">
							<AlternatingRowStyle CssClass="dnnGridAltItem" />
							<HeaderStyle CssClass="dnnGridHeader" />
							<RowStyle CssClass="dnnGridItem" />
							<SelectedRowStyle CssClass="dnnGridSelectedItem" />
							<FooterStyle CssClass="dnnGridFooter" />
							<PagerStyle CssClass="dnnGridPager" />
							<Columns>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="SalesOrderNumber" HeaderText="OrderNumberHeaderRelatedSalesOrderGridView" SortExpression="SalesOrderNumber" />
								<asp:BoundField DataField="Status" HeaderText="StatusHeaderRelatedSalesOrderGridView" SortExpression="Status" />
								<asp:BoundField DataField="SalesPaymentStatus" HeaderText="PaymentStatusHeaderRelatedSalesOrderGridView" SortExpression="SalesPaymentStatus" />
								<asp:BoundField DataField="ShippingStatus" HeaderText="ShippingStatusHeaderRelatedSalesOrderGridView" SortExpression="ShippingStatus" />
								<asp:BoundField DataField="TotalAmount" HeaderText="AmountHeaderRelatedSalesOrderGridView" SortExpression="TotalAmount" />
								<asp:TemplateField HeaderText="ParentHeaderRelatedSalesOrderGridView">
									<ItemTemplate>
										<asp:CheckBox ID="ParentCheckBox" runat="server" Enabled="false" />
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
						</asp:GridView>
					</fieldset>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="EmailReceiptLinkButton" runat="server" resourcekey="EmailReceiptLinkButton" OnClick="EmailReceiptLinkButton_Click" ValidationGroup="ManageOrderDetailsViewControl" CssClass="dnnPrimaryAction rvdEmailAction" />
					</li>
					<li>
						<asp:LinkButton ID="EmailInvoiceLinkButton" runat="server" resourcekey="EmailInvoiceLinkButton" OnClick="EmailInvoiceLinkButton_Click" ValidationGroup="ManageOrderDetailsViewControl" CssClass="dnnPrimaryAction rvdEmailAction" />
					</li>
					<li>
						<asp:HyperLink ID="PrintReceiptHyperLink" runat="server" resourcekey="PrintReceiptHyperLink" Target="_blank" CssClass="dnnPrimaryAction rvdPrintAction" />
					</li>
					<li>
						<asp:HyperLink ID="PrintInvoiceHyperLink" runat="server" resourcekey="PrintInvoiceHyperLink" Target="_blank" CssClass="dnnPrimaryAction rvdPrintAction" />
					</li>
					<li>
						<asp:HyperLink ID="ViewCartHyperLink" runat="server" resourcekey="ViewCartHyperLink" CssClass="dnnPrimaryAction rvdsfViewCartAction" />
					</li>
					<li>
						<asp:LinkButton ID="ReorderLinkButton" runat="server" resourcekey="ReorderLinkButton" OnClick="ReorderLinkButton_Click" ValidationGroup="ManageOrderDetailsViewControl" CssClass="dnnSecondaryAction rvdsfReorderAction" CausesValidation="False" />
					</li>
					<li>
						<uc1:BackControl ID="BackControl" runat="server" Text="Cancel" ResourceKey="BackControl" />
					</li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
