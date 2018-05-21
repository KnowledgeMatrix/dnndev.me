<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductList.Standard8.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfProductListContainer">
	<asp:HiddenField ID="OverrideCategoryIDHiddenField" runat="server" Value="" />
	<asp:HiddenField ID="OverrideManufacturerIDHiddenField" runat="server" Value="" />
	<span class="rvdsfProductListDescription">
		<asp:Literal ID="DescriptionLiteral" runat="server"></asp:Literal>
	</span>
	<asp:ListView ID="SubCategoryListView" runat="server" GroupItemCount="1">
		<LayoutTemplate>
			<div class="rvdsfProductListSubCategoryList">
				<div runat="server" id="groupPlaceholder" />
			</div>
		</LayoutTemplate>
		<GroupTemplate>
			<div class="rvdsfProductListSubCategoryGroup">
				<div runat="server" id="itemPlaceholder" />
			</div>
		</GroupTemplate>
		<ItemTemplate>
			<div class="rvdsfProductListSubCategoryItem">
				<asp:HyperLink ID="ThumbnailImageSubCategoryHyperLink" runat="server" NavigateUrl='<%# Eval("ThumbnailImageSubCategoryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductListSubCategoryGalleryThumbnail">
					<asp:Image ID="ThumbnailImageSubCategoryImage" AlternateText='<%# Eval("ThumbnailImageSubCategoryImage_AlternateText") %>' ImageUrl='<%# Eval("ThumbnailImageSubCategoryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("ThumbnailImageSubCategoryImage_Visible")) %>' runat="server" />
				</asp:HyperLink>
				<asp:HyperLink ID="SubCategoryHyperLink" runat="server" NavigateUrl='<%# Eval("SubCategoryHyperLink_NavigateUrl") %>' Text='<%# Eval("SubCategoryHyperLink_Text") %>' CssClass="rvdsfProductListSubCategoryName" />
			</div>
		</ItemTemplate>
	</asp:ListView>
	<div class="dnnForm rvdsfProductListToolbar">
		<div class="dnnFormItem rvdsfPageViewModeInput">
			<dnn1:LabelControl ID="PageViewModeLabelControl" runat="server" />
			<asp:DropDownList ID="PageViewModeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageViewModeDropDownList_SelectedIndexChanged">
				<asp:ListItem resourcekey="GridPageViewModeListItem" Value="Grid">Grid</asp:ListItem>
				<asp:ListItem resourcekey="ListPageViewModeListItem" Value="List">List</asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem rvdsfPageViewDisplayOrderInput">
			<dnn1:LabelControl ID="PageViewDisplayOrderLabelControl" runat="server" />
			<asp:DropDownList ID="PageViewDisplayOrderDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageViewDisplayOrderDropDownList_SelectedIndexChanged">
				<asp:ListItem Value="1" resourcekey="RecommendedPageViewDisplayOrderListItem">Recommended</asp:ListItem>
				<asp:ListItem Value="8" resourcekey="DateNewOldPageViewDisplayOrderListItem">Date: Newest</asp:ListItem>
				<asp:ListItem Value="9" resourcekey="DateOldNewPageViewDisplayOrderListItem">Date: Oldest</asp:ListItem>
				<asp:ListItem Value="4" resourcekey="PriceLowHighPageViewDisplayOrderListItem">Price: Low to High</asp:ListItem>
				<asp:ListItem Value="5" resourcekey="PriceHighLowPageViewDisplayOrderListItem">Price: High to Low</asp:ListItem>
				<asp:ListItem Value="2" resourcekey="ProductNameAZPageViewDisplayOrderListItem">Product Name: A to Z</asp:ListItem>
				<asp:ListItem Value="3" resourcekey="ProductNameZAPageViewDisplayOrderListItem">Product Name: Z to A</asp:ListItem>
				<asp:ListItem Value="6" resourcekey="RatingLowHighPageViewDisplayOrderListItem">Rating: Low to High</asp:ListItem>
				<asp:ListItem Value="7" resourcekey="RatingHighLowPageViewDisplayOrderListItem">Rating: High to Low</asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem rvdsfPageViewSizeInput">
			<dnn1:LabelControl ID="PageViewSizeLabelControl" runat="server" />
			<asp:DropDownList ID="PageViewSizeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageViewSizeDropDownList_SelectedIndexChanged">
				<asp:ListItem Value="10" resourcekey="TenPageViewSizeListItem">10</asp:ListItem>
				<asp:ListItem Value="20" resourcekey="TwentyPageViewSizeListItem">20</asp:ListItem>
				<asp:ListItem Value="50" resourcekey="FiftyPageViewSizeListItem">50</asp:ListItem>
				<asp:ListItem Value="100000" resourcekey="AllPageViewSizeListItem">All</asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="rvdPager">
			<asp:DataPager ID="ProductListDataPager" runat="server" PagedControlID="ProductListListView" EnableViewState="False" PageSize="4" OnPreRender="ProductListDataPager_PreRender">
				<Fields>
					<asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="False" ShowPreviousPageButton="True" ShowFirstPageButton="False" RenderDisabledButtonsAsLabels="False" ButtonCssClass="rvdPreviousAction" />
					<asp:NumericPagerField NumericButtonCssClass="rvdNumericAction" NextPreviousButtonCssClass="rvdNextPreviousAction" />
					<asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="True" ShowPreviousPageButton="False" ShowLastPageButton="False" ButtonCssClass="rvdNextAction" />
				</Fields>
			</asp:DataPager>
		</div>
	</div>

	<script type="text/javascript">
		function ProductComparisonCheckedChanged(id, toInclude)
		{
			dnn.xmlhttp.callControlMethod('Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductList.Standard.Display', 'SetProductComparison', { productVariantID: id, include: toInclude }, null, null);
		}
	</script>

	<asp:Panel ID="PageViewModePanel" runat="server">
		<asp:ListView ID="ProductListListView" runat="server" GroupItemCount="2" OnPagePropertiesChanging="ProductListListView_PagePropertiesChanging" OnItemDataBound="ProductListListView_ItemDataBound" DataKeyNames="ProductVariantID" OnItemCommand="ProductListListView_ItemCommand">
			<LayoutTemplate>
				<div class="rvdsfProductListProductList">
					<div runat="server" id="groupPlaceholder" />
				</div>
			</LayoutTemplate>
			<GroupTemplate>
				<div class="rvdsfProductListProductGroup">
					<div runat="server" id="itemPlaceholder" />
				</div>
			</GroupTemplate>
			<ItemTemplate>
				<div class="rvdsfProductListProductItem">
					<div class="rvdsfProductDisplayContainer">
						<div class="dnnForm rvdsfProductDisplayAbstractContainer">
							<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("GalleryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductDisplayGalleryThumbnail">
								<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" BorderStyle="None" />
							</asp:HyperLink>
							<asp:Panel ID="ProductComparisonPanel" runat="server" Visible='<%# Convert.ToBoolean(Eval("ProductComparisonPanel_Visible")) %>' CssClass="rvdsfProductComparisonInput">
								<asp:CheckBox ID="ProductComparisonCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("ProductComparisonCheckBox_Checked")) %>' OnClick='<%# Eval("ProductComparisonCheckBox_OnClick", "ProductComparisonCheckedChanged({0}, this.checked)") %>' /><asp:HyperLink ID="ProductComparisonHyperLink" runat="server" resourcekey="ProductComparisonHyperLink.Text" NavigateUrl='<%# Eval("ProductComparisonHyperLink_NavigateUrl") %>' />
							</asp:Panel>
						</div>
						<div class="dnnForm rvdsfProductDisplayInfoContainer">
							<asp:HyperLink ID="ProductHyperLink" runat="server" NavigateUrl='<%# Eval("ProductHyperLink_NavigateUrl") %>' Text='<%# Eval("ProductHyperLink_Text") %>' CssClass="rvdsfProductDisplayGalleryThumbnail" />
							<span class="rvdsfProductDisplaySummary">
								<asp:Literal ID="SummaryLiteral" runat="server" Text='<%# Eval("SummaryLiteral_Text") %>' />
							</span>
							<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" runat="server" ReadOnly="true" Value='<%# Eval("ProductReviewAverageOverallRatingDnnRating_Value") %>' Visible='<%# Convert.ToBoolean(Eval("ProductReviewAverageOverallRatingDnnRating_Visible")) %>' CssClass="rvdsfProductDisplayRating" />
							<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount" Visible='<%# Convert.ToBoolean(Eval("SalePricePanel_Visible")) %>'>
								<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" />
								<asp:Label ID="SalePriceValueLabel" runat="server" Text='<%# Eval("SalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="SaleRecurringLabel" runat="server" Text='<%# Eval("SaleRecurringLabel_Text") %>'></asp:Label>
							</asp:Panel>
							<asp:Panel ID="PricePanel" CssClass='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("PriceValueLabel_CssClass")) %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("PricePanel_Visible")) %>'>
								<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
								<asp:Label ID="PriceValueLabel" runat="server" Text='<%# Eval("PriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RecurringLabel_Text") %>'></asp:Label>
							</asp:Panel>
							<asp:Panel ID="MSRPPricePanel" runat="server" CssClass="dnnFormItem rvdsfMSRPPriceAmount" Visible='<%# Convert.ToBoolean(Eval("MSRPPricePanel_Visible")) %>'>
								<dnn1:LabelControl ID="MSRPLabelControl" runat="server"  />
								<asp:Label ID="MSRPValueLabel" runat="server" Text='<%# Eval("MSRPValueLabel_Text") %>'></asp:Label>
								<asp:Label ID="MSRPRecurringLabel" runat="server" Text='<%# Eval("MSRPRecurringLabel_Text") %>' ></asp:Label>
							</asp:Panel>
							<asp:Panel ID="SavingsPanel" runat="server" CssClass="dnnFormItem rvdsfSavingsAmount" Visible='<%# Convert.ToBoolean(Eval("SavingsPanel_Visible")) %>'>
								<dnn1:LabelControl ID="SavingsLabelControl" runat="server" />
								<asp:Label ID="SavingsValueLabel" runat="server" Text='<%# Eval("SavingsValueLabel_Text") %>'></asp:Label>
							</asp:Panel>
							<asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem" Visible='<%# Convert.ToBoolean(Eval("QuantityPanel_Visible")) %>'>
								<dnn1:LabelControl ID="QuantityLabelControl" runat="server" CssClass="dnnFormRequired"/>
								<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" Display="Dynamic" ValidationGroup="ProductListDisplayTemplateControl" CssClass="dnnFormMessage dnnFormError"></asp:RequiredFieldValidator>
								<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" Display="Dynamic" MaximumValue='<%# Eval("QuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("QuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="ProductListDisplayTemplateControl" CssClass="dnnFormMessage dnnFormError"></asp:RangeValidator>
								<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="rvdQuantityInput dnnFormRequired" MinValue="1" Value='<%# Eval("QuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Enabled='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Enabled")) %>'>
								</dnn2:DnnNumericTextBox>
							</asp:Panel>
							<div class="rvdsfProductDisplayActions">
								<asp:LinkButton ID="AddToCartLinkButton" runat="server" resourcekey="AddToCartLinkButton" Visible='<%# Convert.ToBoolean(Eval("AddToCartLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="AddToCart" CssClass="dnnPrimaryAction rvdsfAddToCartAction" />
								<asp:LinkButton ID="BuyNowLinkButton" runat="server" resourcekey="BuyNowLinkButton" Visible='<%# Convert.ToBoolean(Eval("BuyNowLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="BuyNow" CssClass="dnnPrimaryAction rvdsfBuyNowAction" />
                                <asp:LinkButton ID="SeeDetailsLinkButton" runat="server" resourcekey="SeeDetailsLinkButton" Visible='<%# Convert.ToBoolean(Eval("SeeDetailsLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="SeeDetails" CssClass="dnnPrimaryAction rvdSeeDetailsAction" />
							</div>
						</div>
					</div>
				</div>
			</ItemTemplate>
		</asp:ListView>
	</asp:Panel>
	<div class="dnnForm">
		<div class="rvdPager">
			<asp:DataPager ID="FooterProductListDataPager" runat="server" PagedControlID="ProductListListView" EnableViewState="False" PageSize="4" OnPreRender="ProductListDataPager_PreRender">
				<Fields>
					<asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="False" ShowPreviousPageButton="True" ShowFirstPageButton="False" RenderDisabledButtonsAsLabels="False" ButtonCssClass="rvdPreviousAction" />
					<asp:NumericPagerField NumericButtonCssClass="rvdNumericAction" NextPreviousButtonCssClass="rvdNextPreviousAction" />
					<asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="True" ShowPreviousPageButton="False" ShowLastPageButton="False" ButtonCssClass="rvdNextAction" />
				</Fields>
			</asp:DataPager>
		</div>
	</div>
</div>
