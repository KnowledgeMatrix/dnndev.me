<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.Cart.Standard14.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
	    jQuery(document).ready(function ()
	    {
	        jQuery('#CartOptionSectionPanel').dnnPanels();
	    });
	    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
	    {
	        jQuery('#CartOptionSectionPanel').dnnPanels();
	    });

	    function ShowCrosssellProductDialog()
	    {
	        jQuery("#<%= CrosssellProductPanel.ClientID %>").dialog({ closeOnEscape: true, dialogClass: 'dnnFormPopup', height: 'auto', maxHeight: '90%', maxWidth: '90%', minWidth: 200, modal: true, position: 'center', resizable: true, width: 'auto', close: function (event, ui) {  } });
	    }
	</script>

</asp:PlaceHolder>
<asp:Panel ID="CartPanel" runat="server" CssClass="rvdsfCartContainer">
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <div class="rvdUpdateProgressContainer">
                <asp:Image ID="UpdateProgressImage" runat="server" ImageUrl="~/Images/Loading.gif" CssClass="rvdUpdateProgress" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="CrosssellProductPanel" runat="server" CssClass="rvdsfCrosssellProductContainer" style="display:none" >
                <asp:ListView ID="CrosssellProductListView" runat="server" GroupItemCount="1" OnItemDataBound="CrosssellProductListView_ItemDataBound">
			        <LayoutTemplate>
				        <div class="rvdsfCrosssellProductProductList">
					        <div runat="server" id="groupPlaceholder" />
				        </div>
			        </LayoutTemplate>
			        <GroupTemplate>
				        <div class="rvdsfCrosssellProductProductGroup">
					        <div runat="server" id="itemPlaceholder" />
				        </div>
			        </GroupTemplate>
			        <ItemTemplate>
                        <h3>
                            <asp:Label ID="CrosssellProductTitleLabel" runat="server" Text='<%# Eval("CrosssellProductTitleLabel_Text") %>'></asp:Label>
                        </h3>
                        <asp:Label ID="CrosssellProductDescriptionLabel" CssClass="rvdsfCrosssellProductDescription" runat="server" Text='<%# Eval("CrosssellProductDescriptionLabel_Text") %>'></asp:Label>
                        <div class="rvdsfCrosssellProductItem">
							<div class="rvdsfCrosssellProductItemAbstractContainer">
								<asp:HyperLink ID="CrosssellProductGalleryHyperLink" runat="server" NavigateUrl='<%# Eval("CrosssellProductGalleryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductDisplayGalleryThumbnail">
									<asp:Image ID="CrosssellProductGalleryImage" AlternateText='<%# Eval("CrosssellProductGalleryImage_AlternateText") %>' ImageUrl='<%# Eval("CrosssellProductGalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("CrosssellProductGalleryImage_Visible")) %>' runat="server" /></asp:HyperLink>
							</div>
							<div class="rvdsfCrosssellProductItemInfoContainer">
								<asp:HyperLink ID="CrosssellProductHyperLink" runat="server" NavigateUrl='<%# Eval("CrosssellProductHyperLink_NavigateUrl") %>' Text='<%# Eval("CrosssellProductHyperLink_Text") %>' CssClass="rvdsfProductDisplayName"></asp:HyperLink>
								<dnn2:DnnRating ID="CrosssellProductReviewAverageOverallRatingDnnRating" CssClass="rvdsfProductDisplayRating" runat="server" Value='<%# Eval("CrosssellProductReviewAverageOverallRatingDnnRating_Value") %>' ReadOnly="true" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductReviewAverageOverallRatingDnnRating_Visible")) %>' />
                                <asp:Panel ID="CrosssellProductSalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductSalePricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="CrosssellProductSalePriceLabelControl" runat="server" />
									<asp:Label ID="CrosssellProductSalePriceValueLabel" runat="server" Text='<%# Eval("CrosssellProductSalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="CrosssellProductSaleRecurringLabel" runat="server" Text='<%# Eval("CrosssellProductSaleRecurringLabel_Text") %>' ></asp:Label>
								</asp:Panel>
                                <asp:Panel ID="CrosssellProductPricePanel" CssClass='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("CrosssellProductPriceValueLabel_CssClass")) %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductPricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="CrosssellProductPriceLabelControl" runat="server" />
									<asp:Label ID="CrosssellProductPriceValueLabel" runat="server" Text='<%# Eval("CrosssellProductPriceValueLabel_Text") %>'></asp:Label><asp:Label ID="CrosssellProductRecurringLabel" runat="server" Text='<%# Eval("CrosssellProductRecurringLabel_Text") %>'></asp:Label>
								</asp:Panel>
								<asp:Panel ID="CrosssellProductQuantityPanel" runat="server" CssClass="dnnFormItem" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductQuantityPanel_Visible")) %>'>
									<dnn1:LabelControl ID="CrosssellProductQuantityLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="CrosssellProductQuantityRequiredFieldValidator" runat="server" resourcekey="CrosssellProductQuantityRequiredFieldValidator" ControlToValidate="CrosssellProductQuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CrosssellProductDisplayTemplateControl" ></asp:RequiredFieldValidator>
									<asp:RangeValidator ID="CrosssellProductQuantityRangeValidator" runat="server" resourcekey="CrosssellProductQuantityRangeValidator" ControlToValidate="CrosssellProductQuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue='<%# Eval("CrosssellProductQuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("CrosssellProductQuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="CrosssellProductDisplayTemplateControl"></asp:RangeValidator>
									<dnn2:DnnNumericTextBox ID="CrosssellProductQuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" MinValue="1" CssClass="rvdQuantityInput dnnFormRequired" Value='<%# Eval("CrosssellProductQuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Enabled='<%# Convert.ToBoolean(Eval("CrosssellProductQuantityDnnNumericTextBox_Enabled")) %>'>
									</dnn2:DnnNumericTextBox>
								</asp:Panel>
								<div class="rvdsfProductDisplayActions">
									<asp:LinkButton ID="CrosssellProductSeeDetailsLinkButton" runat="server" resourcekey="CrosssellProductSeeDetailsLinkButton" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductSeeDetailsLinkButton_Visible")) %>' ValidationGroup="CrosssellProductDisplayTemplateControl" OnClientClick='<%# Eval("CrosssellProductSeeDetailsLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdSeeDetailsAction" CausesValidation="False" />
									<asp:LinkButton ID="CrosssellProductAddToCartLinkButton" runat="server" resourcekey="CrosssellProductAddToCartLinkButton" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductAddToCartLinkButton_Visible")) %>' ValidationGroup="CrosssellProductDisplayTemplateControl" OnClientClick='<%# Eval("CrosssellProductAddToCartLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfAddToCartAction" />
                                    <asp:LinkButton ID="CrosssellProductBuyNowLinkButton" runat="server" resourcekey="CrosssellProductBuyNowLinkButton" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductBuyNowLinkButton_Visible")) %>' ValidationGroup="CrosssellProductDisplayTemplateControl" OnClientClick='<%# Eval("CrosssellProductBuyNowLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfBuyNowAction" />
									<asp:LinkButton ID="CrosssellProductAddToQuoteLinkButton" runat="server" resourcekey="CrosssellProductAddToQuoteLinkButton" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductAddToQuoteLinkButton_Visible")) %>' ValidationGroup="CrosssellProductDisplayTemplateControl" OnClientClick='<%# Eval("CrosssellProductAddToQuoteLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfAddToQuoteAction" />
                                    <asp:LinkButton ID="CrosssellProductQuoteNowLinkButton" runat="server" resourcekey="CrosssellProductQuoteNowLinkButton" Visible='<%# Convert.ToBoolean(Eval("CrosssellProductQuoteNowLinkButton_Visible")) %>' ValidationGroup="CrosssellProductDisplayTemplateControl" OnClientClick='<%# Eval("CrosssellProductQuoteNowLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfQuoteNowAction" />
								</div>
							</div>
						</div>
                    </ItemTemplate>
                </asp:ListView>
                <div class="dnnForm">
                    <ul class="dnnActions">
					    <li>
						    <asp:LinkButton ID="CloseCrosssellProductDialogLinkButton" runat="server" resourcekey="CloseCrosssellProductDialogLinkButton" CssClass="dnnPrimaryAction rvdCloseAction" CausesValidation="False" OnClick="CheckoutLinkButton_Click" />
					    </li>
				    </ul>
                </div>
            </asp:Panel>
	        <asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
	        <div class="rvdsfCheckoutBreadcrumb">
		        <asp:LinkButton ID="ViewCartNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" CssClass="rvdsfCheckoutBreadcrumbSelected" resourcekey="ViewCartNavigationLinkButton"></asp:LinkButton>
		        <span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		        <asp:LinkButton ID="BillingAndShippingNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="BillingAndShippingNavigationLinkButton"></asp:LinkButton>
		        <span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		        <asp:LinkButton ID="PlaceOrderNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="PlaceOrderNavigationLinkButton"></asp:LinkButton>
		        <span class="rvdsfCheckoutBreadcrumbSeparator"></span>
		        <asp:LinkButton ID="ConfirmationNavigationLinkButton" runat="server" CausesValidation="False" Enabled="False" resourcekey="ConfirmationNavigationLinkButton"></asp:LinkButton>
	        </div>
	        <asp:Panel ID="CartDetailViewPanel" runat="server" CssClass="dnnForm">
		        <h2 class="dnnFormSectionHead">
			        <asp:Label ID="ViewCartSectionLabel" runat="server" resourcekey="ViewCartSectionLabel"></asp:Label>
		        </h2>
		        <asp:GridView ID="SalesOrderDetailGridView" CssClass="dnnGrid rvdsfSalesOrderDetailGrid" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID" OnSelectedIndexChanged="SalesOrderDetailGridView_SelectedIndexChanged" OnRowDeleting="SalesOrderDetailGridView_RowDeleting">
			        <HeaderStyle CssClass="dnnGridHeader" />
			        <RowStyle CssClass="dnnGridItem" />
			        <AlternatingRowStyle CssClass="dnnGridAltItem" />
			        <SelectedRowStyle CssClass="dnnGridSelectedItem" />
			        <FooterStyle CssClass="dnnGridFooter" />
			        <PagerStyle CssClass="dnnGridPager" />
			        <Columns>
				        <asp:TemplateField HeaderText="ItemHeaderSalesOrderDetailGridView">
					        <ItemTemplate>
						        <asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' CssClass="rvdsfCartGalleryThumbnail">
							        <asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
						        </asp:HyperLink>
						        <div class="rvdsfCartProduct">
							        <asp:HyperLink ID="ProductNameHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' Text='<%# Eval("ProductName") %>'></asp:HyperLink>
									<dl ID="BookingDescriptionList" class="rvdsfBookingDates" runat="server" visible='<%# Convert.ToBoolean(Eval("Booking_Visible")) %>'>
										<dt><asp:Label ID="BookingStartDateLabel" runat="server" resourcekey="BookingStartDateLabel"/></dt>
										<dd><%# Eval("BookingStartDate") %></dd>
										<dt><asp:Label ID="BookingStopDateLabel" runat="server" resourcekey="BookingStopDateLabel"/></dt>
										<dd><%# Eval("BookingStopDate") %></dd>
									</dl>
									<dl class="rvdsfProductParts">
								        <asp:Literal ID="ProductPartLiteral" runat="server" Text='<%# Eval("ProductPart") %>' />
							        </dl>
							        <dl class="rvdsfDynamicFormResults">
								        <asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
							        </dl>
						        </div>
					        </ItemTemplate>
				        </asp:TemplateField>
				        <asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailGridView" />
				        <asp:TemplateField HeaderText="QuantityHeaderSalesOrderDetailGridView">
					        <ItemTemplate>
						        <dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" MinValue="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Value='<%# Eval("Quantity_Value") %>' CssClass="dnnFormRequired rvdQuantityInput" ReadOnly='<%# Convert.ToBoolean(Eval("Quantity_ReadOnly")) %>'>
						        </dnn2:DnnNumericTextBox>
						        <asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Integer" ValidationGroup="CartDisplayTemplateControl"></asp:RangeValidator>
						        <asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CartDisplayTemplateControl"></asp:RequiredFieldValidator>
					        </ItemTemplate>
				        </asp:TemplateField>
				        <asp:CommandField ShowSelectButton="True" ButtonType="Link" SelectText="" ValidationGroup="CartDisplayTemplateControl" ControlStyle-CssClass="rvdUpdateGridAction" />
				        <asp:CommandField ButtonType="Link" DeleteText="" ShowDeleteButton="True" CausesValidation="False" ControlStyle-CssClass="rvdDeleteGridAction" />
				        <asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailGridView" />
			        </Columns>
		        </asp:GridView>
		        <dl class="rvdsfDynamicFormResults">
			        <asp:Literal ID="CheckoutDynamicFormResultLiteral" runat="server" />
		        </dl>
                <div id="CartOptionSectionPanel">
                <asp:Panel ID="CouponPanel" runat="server">
                    <h2 id="CouponFormSectionHead" class="dnnFormSectionHead">
		                    <a href="#" class="dnnSectionExpanded"><asp:Label ID="CouponSectionLabel" runat="server" resourcekey="CouponSectionLabel" /></a></h2>
	                <fieldset>
                        <div class="dnnFormItem">
                            <dnn1:LabelControl ID="CouponLabelControl" runat="server" />
                            <asp:CustomValidator id="CouponCodeCustomValidator" runat="server" OnServerValidate="CouponCodeCustomValidator_ServerValidate" ControlToValidate="CouponCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CouponCartDisplayTemplate"/>
                            <asp:TextBox ID="CouponCodeTextBox" runat="server" MaxLength="100"></asp:TextBox>
                            <asp:LinkButton ID="AddCouponLinkButton" runat="server" OnClick="AddCouponLinkButton_Click" ValidationGroup="CouponCartDisplayTemplate" CssClass="dnnPrimaryAction" CausesValidation="True" resourcekey="ApplyLinkButton" />
                            <asp:DataList ID="CouponDataList" CssClass="rvdsfCheckoutCouponList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                <ItemTemplate>
                                    <asp:LinkButton ID="DeleteCouponLinkButton" runat="server" CommandArgument='<%# Eval("Code") %>' OnClick="DeleteCouponLinkButton_Click" CausesValidation="False" CssClass="rvdDeleteGridAction" resourcekey="DeleteCouponLinkButton" />
                                    <asp:Label ID="CouponLabel" runat="server" Text='<%# Eval("Code") %>' />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                    </fieldset>
                </asp:Panel>
                <asp:Panel ID="EstimateShippingTaxPanel" runat="server" DefaultButton="EstimateShippingTaxLinkButton">
                    <h2 id="EstimateShippingTaxFormSectionHead" class="dnnFormSectionHead">
		                    <a href="#"><asp:Label ID="EstimateShippingTaxSectionLabel" runat="server" resourcekey="EstimateShippingTaxSectionLabel" /></a></h2>
	                <fieldset>
                        <div class="dnnFormItem">
                            <dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" CssClass="dnnFormRequired" />
                            <asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged" CssClass="dnnFormRequired"  ValidationGroup="EstimateShippingTaxCartDisplayTemplate">
                            </asp:DropDownList>
                        </div>
                        <div class="dnnFormItem">
                            <dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" />
                            <asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server" AutoPostBack="True"  ValidationGroup="EstimateShippingTaxCartDisplayTemplate">
                            </asp:DropDownList>
                        </div>
                        <div class="dnnFormItem">
                            <dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" CssClass="dnnFormRequired" />
                            <asp:RequiredFieldValidator ID="ShippingCityRequiredFieldValidator" runat="server" resourcekey="ShippingCityRequiredFieldValidator" ControlToValidate="ShippingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="EstimateShippingTaxCartDisplayTemplate"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired" ></asp:TextBox>
                        </div>
                        <div class="dnnFormItem">
                            <dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
                            <asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" runat="server" resourcekey="ShippingPostalCodeRequiredFieldValidator" ControlToValidate="ShippingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="EstimateShippingTaxCartDisplayTemplate"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired" ></asp:TextBox>
                        </div>
                        <div class="dnnForm">
				            <ul class="dnnActions">
					            <li>
						            <asp:LinkButton ID="EstimateShippingTaxLinkButton" runat="server" resourcekey="EstimateShippingTaxLinkButton" OnClick="EstimateShippingTaxLinkButton_Click" CssClass="dnnPrimaryAction rvdsfEstimateShippingAction" ValidationGroup="EstimateShippingTaxCartDisplayTemplate" />
					            </li>
				            </ul>
			            </div>
                        <div class="dnnFormItem">
                            <asp:PlaceHolder ID="EstimateShippingTaxMessagePlaceHolder" runat="server"></asp:PlaceHolder>
                        </div>   
                        <asp:Panel ID="ShippingMethodSelectionPanel" runat="server" CssClass="dnnFormItem rvdsfShippingMethodSelectionContainer">
                            <dnn1:LabelControl ID="ShippingMethodLabelControl" runat="server" />
                            <div class="rvdFormSubContainer">
                                <asp:Repeater ID="ShippingMethodRepeater" runat="server">
                                    <ItemTemplate>
                                        <div>
                                             <% if (ShippingMethodRepeater.Items.Count > 1) { %>
                                            <h3 class="dnnFormSectionHead"><%# Eval("SellerName") %></h3>
                                            <asp:BulletedList ID="ShippingMethodProductBulletedList" runat="server" DataSource='<%# Eval("SalesOrderDetails") %>' DataTextField="ProductName" CssClass="rvdsfShippingMethodProductList"></asp:BulletedList>
                                            <% } %>
                                            <asp:RadioButtonList ID="ShippingMethodRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingMethodRadioButtonList_SelectedIndexChanged" RepeatLayout="Flow" CssClass="dnnFormRadioButtons" DataSource='<%# Eval("ShippingMethods") %>' DataTextField="Name" DataValueField="ShippingMethodID" OnDataBound="ShippingMethodRadioButtonList_DataBound"></asp:RadioButtonList>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </asp:Panel>
                    </fieldset>
                </asp:Panel>
            </div>
		        <asp:Panel ID="TotalAmountPanel" runat="server" CssClass="rvdsfCartTotalAmountContainer">
                    <div class="dnnFormItem rvdsfTotalSalesOrderDetailDiscountAmount">
                        <dnn1:LabelControl ID="TotalSalesOrderDetailDiscountLabelControl" runat="server" />
                        <asp:Label ID="TotalSalesOrderDetailDiscountLabel" runat="server"></asp:Label>
                    </div>
			        <div class="dnnFormItem rvdsfSubTotalAmount">
				        <dnn1:LabelControl ID="SubTotalLabelControl" runat="server" />
				        <asp:Label ID="SubTotalLabel" runat="server" CssClass="" />
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
				        <asp:Label ID="TaxesLabel" runat="server" CssClass="" />
			        </div>
			        <div class="dnnFormItem rvdsfTotalAmount">
				        <dnn1:LabelControl ID="TotalLabelControl" runat="server" />
				        <asp:Label ID="TotalLabel" runat="server" />
			        </div>
                    <asp:Panel ID="TotalDiscountPanel" runat="server" CssClass="dnnFormItem rvdsfTotalDiscountAmount">
                        <dnn1:LabelControl ID="TotalDiscountLabelControl" runat="server" />
                        <asp:Label ID="TotalDiscountLabel" runat="server"></asp:Label>
                    </asp:Panel>
			        <asp:Panel ID="RewardsPointQualifiedPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
				        <dnn1:LabelControl ID="RewardsPointQualifiedLabelControl" runat="server" />
				        <asp:Label ID="RewardsPointQualifiedLabel" runat="server"></asp:Label>
			        </asp:Panel>
		        </asp:Panel>
	        </asp:Panel>
	        <asp:Label ID="EmptyCartLabel" runat="server" resourcekey="EmptyCartLabel" CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
	        <div class="rvdsfCartActions">
		        <asp:HyperLink ID="ContinueShoppingHyperLink" runat="server" resourcekey="ContinueShoppingHyperLink" CssClass="dnnPrimaryAction rvdsfContinueShoppingAction" />
		        <asp:LinkButton ID="ResetCartLinkButton" runat="server" resourcekey="ResetCartLinkButton" OnClick="ResetCartLinkButton_Click" ValidationGroup="CartDisplayTemplateControl" CssClass="dnnSecondaryAction rvdsfResetCartAction" CausesValidation="False" />
		        <asp:LinkButton ID="CheckoutLinkButton" runat="server" resourcekey="CheckoutLinkButton" OnClick="CheckoutLinkButton_Click" ValidationGroup="CartDisplayTemplateControl" CssClass="dnnPrimaryAction rvdsfCheckoutAction" />
	        </div>
            </ContentTemplate>
    </asp:UpdatePanel>
</asp:Panel>
