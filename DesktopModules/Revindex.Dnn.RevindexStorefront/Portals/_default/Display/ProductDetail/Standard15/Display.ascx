<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductDetail.Standard15.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<asp:HiddenField ID="OverrideProductIDHiddenField" runat="server" Value="" />
<asp:HiddenField ID="ProductVariantIDHiddenField" runat="server" />
<div class="rvdsfProductDetailContainer">
	<script type="text/javascript">
		function ProductComparisonCheckedChanged(id, toInclude)
		{
			dnn.xmlhttp.callControlMethod('Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductDetail.Standard.Display', 'SetProductComparison', { productVariantID: id, include: toInclude }, null, null);
		}

		function ShowDetailedGalleryWindow()
		{
			$find("<%= DetailedGalleryDnnWindow.ClientID %>").show();
		}

		function HideDetailedGalleryWindow()
		{
			$find("<%= DetailedGalleryDnnWindow.ClientID %>").close();
		}

		function ResizeDetailedGalleryWindow()
		{
			$find("<%= DetailedGalleryDnnWindow.ClientID %>").autoSize(true);
		}
	</script>
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
	<asp:Panel ID="ProductDetailPanel" runat="server">
		<div class="rvdsfProductDisplayContainer">
			<div class="dnnForm rvdsfProductDisplayAbstractContainer">
				<asp:HyperLink ID="DisplayGalleryHyperLink" CssClass="rvdsfProductDisplayGalleryDisplay" runat="server" />
				<asp:ListView ID="DisplayTileGalleryListView" GroupItemCount="5" runat="server">
					<LayoutTemplate>
						<div class="rvdsfProductDisplayGalleryTileList">
							<div runat="server" id="groupPlaceholder" />
						</div>
					</LayoutTemplate>
					<GroupTemplate>
						<div class="rvdsfProductDisplayGalleryTileGroup">
							<div runat="server" id="itemPlaceholder" />
						</div>
					</GroupTemplate>
					<ItemTemplate>
						<asp:Image ID="DisplayTileGalleryImage" runat="server" CssClass="rvdsfProductDisplayGalleryTile" ImageUrl='<%# Eval("DisplayTileGalleryImage_ImageUrl") %>' OnClick='<%# Eval("DisplayTileGalleryImage_OnClick") %>' AlternateText='<%# Eval("DisplayTileGalleryImage_AlternateText") %>' ToolTip='<%# Eval("DisplayTileGalleryImage_AlternateText") %>' />
					</ItemTemplate>
				</asp:ListView>
				<dnn2:DnnWindow ID="DetailedGalleryDnnWindow" CssClass="rvdModal" Skin="" runat="server" AutoSize="true" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true" VisibleTitlebar="false" VisibleStatusbar="false" Animation="None" EnableShadow="True" AnimationDuration="500">
					<ContentTemplate>
						<asp:Panel ID="DetailedGalleryPanel" runat="server" CssClass="rvdModalContainer">
							<div class="rvdModalToolbar dnnClear">
								<asp:LinkButton ID="CloseDetailedGalleryPanelLinkButton" runat="server" CssClass="rvdModalCloseAction" OnClientClick="HideDetailedGalleryWindow(); return false;" />
							</div>
							<asp:Image ID="DetailedGalleryImage" runat="server" CssClass="rvdsfProductDisplayGalleryDetailed" />
							<asp:ListView ID="DetailedTileGalleryListView" GroupItemCount="15" runat="server">
								<LayoutTemplate>
									<div class="rvdsfProductDisplayGalleryTileList">
										<div runat="server" id="groupPlaceholder" />
									</div>
								</LayoutTemplate>
								<GroupTemplate>
									<div class="rvdsfProductDisplayGalleryTileGroup">
										<div runat="server" id="itemPlaceholder" />
									</div>
								</GroupTemplate>
								<ItemTemplate>
									<asp:Image ID="DetailedTileGalleryImage" runat="server" CssClass="rvdsfProductDisplayGalleryTile" ImageUrl='<%# Eval("DetailedTileGalleryImage_ImageUrl") %>' OnClick='<%# Eval("DetailedTileGalleryImage_OnClick") %>' AlternateText='<%# Eval("DetailedTileGalleryImage_AlternateText") %>' ToolTip='<%# Eval("DetailedTileGalleryImage_AlternateText") %>' />
								</ItemTemplate>
							</asp:ListView>
						</asp:Panel>
					</ContentTemplate>
				</dnn2:DnnWindow>
				<asp:Panel ID="ProductComparisonPanel" runat="server" CssClass="rvdsfProductComparisonInput">
					<asp:CheckBox ID="ProductComparisonCheckBox" runat="server" /><asp:HyperLink ID="ProductComparisonHyperLink" runat="server" resourcekey="ProductComparisonHyperLink.Text" />
				</asp:Panel>
			</div>
			<div class="dnnForm rvdsfProductDisplayInfoContainer">
				<asp:Label ID="ProductNameLabel" runat="server" CssClass="rvdsfProductDisplayName" />
				<span class="rvdsfProductDisplaySummary">
					<asp:Literal runat="server" ID="ProductSummaryLiteral" EnableViewState="False"></asp:Literal>
				</span>
				<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" CssClass="rvdsfProductDisplayRating" runat="server" ReadOnly="True">
				</dnn2:DnnRating>
                <asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem rvdsfSeller">
					<dnn1:LabelControl ID="SellerLabelControl" runat="server" />
					<asp:HyperLink ID="SellerHyperLink" runat="server" />
				</asp:Panel>
				<asp:Panel ID="SKUPanel" runat="server" CssClass="dnnFormItem rvdsfSKU">
					<dnn1:LabelControl ID="SKULabelControl" runat="server" />
					<asp:Label ID="SKULabel" runat="server" />
				</asp:Panel>
				<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount">
					<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" />
					<asp:Label ID="SalePriceValueLabel" runat="server" />
					<asp:Label ID="SaleRecurringLabel" runat="server" />
				</asp:Panel>
				<asp:Panel ID="PricePanel" CssClass="dnnFormItem rvdsfPriceAmount" runat="server">
					<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
					<asp:Label ID="PriceValueLabel" runat="server" />
					<asp:Label ID="RecurringLabel" runat="server" />
				</asp:Panel>
				<asp:Panel ID="MSRPPricePanel" runat="server" CssClass="dnnFormItem rvdsfMSRPPriceAmount">
					<dnn1:LabelControl ID="MSRPLabelControl" runat="server" />
					<asp:Label ID="MSRPValueLabel" runat="server" />
					<asp:Label ID="MSRPRecurringLabel" runat="server" />
				</asp:Panel>
				<asp:Panel ID="SavingsPanel" runat="server" CssClass="dnnFormItem rvdsfSavingsAmount">
					<dnn1:LabelControl ID="SavingsLabelControl" runat="server" />
					<asp:Label ID="SavingsValueLabel" runat="server" />
				</asp:Panel>
				<asp:Panel ID="RewardsPointRewardPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
					<dnn1:LabelControl ID="RewardsPointRewardLabelControl" runat="server" />
					<asp:Label ID="RewardsPointRewardLabel" runat="server"></asp:Label>
				</asp:Panel>
				<asp:Panel ID="RequiredProductPanel" runat="server" Visible="False" CssClass="rvdsfProductDisplayRequiredProductContainer">
					<h3 class="dnnFormSectionHead">
						<dnn1:LabelControl ID="RequiredProductLabelControl" runat="server" />
					</h3>
					<asp:ListView ID="RequiredProductListView" runat="server">
						<LayoutTemplate>
							<div class="rvdsfProductDisplayRequiredProductList">
								<div id="groupPlaceholder" runat="server" />
							</div>
						</LayoutTemplate>
						<GroupTemplate>
							<div id="itemPlaceholder" runat="server" />
						</GroupTemplate>
						<ItemTemplate>
							<div class="dnnFormItem rvdsfProductDisplayRequiredProductItem">
								<asp:Label ID="RequiredProductNameLabel" runat="server" Text='<%# Eval("RequiredProductNameLabel_Text") %>' />
								<asp:Label ID="RequiredProductPriceValueLabel" runat="server" Text='<%# Eval("RequiredProductPriceValueLabel_Text") %>' />
							</div>
						</ItemTemplate>
					</asp:ListView>
				</asp:Panel>
				<asp:Panel ID="SelectOptionPanel" runat="server" CssClass="dnnFormItem rvdsfProductVariantInput">
					<dnn1:LabelControl ID="SelectOptionLabelControl" runat="server" />
					<asp:DropDownList ID="SelectOptionDropDownList" runat="server" />
				</asp:Panel>
				<asp:ListView ID="ProductVariantSelectionListView" runat="server" OnItemDataBound="ProductVariantSelectionListView_ItemDataBound" DataKeyNames="ProductVariantGroupID,ProductVariantGroupFieldType">
					<LayoutTemplate>
						<div runat="server" id="groupPlaceholder" />
					</LayoutTemplate>
					<GroupTemplate>
						<div runat="server" id="itemPlaceholder" />
					</GroupTemplate>
					<ItemTemplate>
						<div class="dnnFormItem rvdsfProductVariantGroupInput">
							<dnn1:LabelControl ID="SelectProductVariantLabelControl" runat="server" Text='<%# Eval("SelectProductVariantLabelControl_Text") %>' HelpText='<%# Eval("SelectProductVariantLabelControl_HelpText") %>' />
							<asp:DropDownList ID="SelectProductVariantDropDownList" runat="server" Visible="False">
							</asp:DropDownList>
							<asp:RadioButtonList ID="SelectProductVariantRadioButtonList" runat="server" RepeatDirection="Horizontal" Visible="False" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
							</asp:RadioButtonList>
							<asp:BulletedList ID="SelectProductVariantColorPickerBulletedList" runat="server" DisplayMode="HyperLink" CssClass="rvdFormColorPickerList">
							</asp:BulletedList>
						</div>
					</ItemTemplate>
				</asp:ListView>
				<asp:Panel ID="InventoryPanel" runat="server" CssClass="dnnFormItem rvdsfProductDisplayInventoryContainer">
					<dnn1:LabelControl ID="InventoryLabelControl" runat="server" />
					<asp:Label ID="InventoryLabel" runat="server" />
				</asp:Panel>
				<asp:ListView ID="DynamicFormListView" runat="server" GroupItemCount="1" OnItemCreated="DynamicFormListView_ItemCreated">
					<LayoutTemplate>
						<div runat="server" id="groupPlaceholder" />
					</LayoutTemplate>
					<GroupTemplate>
						<div runat="server" id="itemPlaceholder" />
					</GroupTemplate>
					<ItemTemplate>
						<div class="dnnFormItem rvdsfDynamicFormItem">
							<asp:PlaceHolder ID="LabelDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
							<asp:PlaceHolder ID="ValidatorDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
							<asp:PlaceHolder ID="InputControlDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
						</div>
					</ItemTemplate>
				</asp:ListView>
				<asp:PlaceHolder ID="DynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
                <asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem">
					<dnn1:LabelControl ID="OrderQuantityLabelControl" runat="server" CssClass="dnnFormRequired" />
					<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailDisplayTemplateControl"></asp:RequiredFieldValidator>
					<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Integer" ValidationGroup="ProductDetailDisplayTemplateControl" CultureInvariantValues="True"></asp:RangeValidator>
					<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="rvdQuantityInput dnnFormRequired" MinValue="1" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9">
					</dnn2:DnnNumericTextBox>
				</asp:Panel>
                <asp:Label ID="SoldOutLabel" runat="server" CssClass="dnnFormMessage dnnFormInfo rvdFormMessageSoldOut" Visible="False" resourcekey="SoldOutLabel" />
				<div class="rvdsfProductDisplayActions dnnClear">
					<asp:LinkButton ID="AddToCartLinkButton" runat="server" resourcekey="AddToCartLinkButton" Visible="false" OnClick="AddToCartLinkButton_Click" CssClass="dnnPrimaryAction rvdsfAddToCartAction" ValidationGroup="ProductDetailDisplayTemplateControl" />
					<asp:LinkButton ID="BuyNowLinkButton" runat="server" resourcekey="BuyNowLinkButton" Visible="false" OnClick="BuyNowLinkButton_Click" ValidationGroup="ProductDetailDisplayTemplateControl" CssClass="dnnPrimaryAction rvdsfBuyNowAction" />
					<asp:LinkButton ID="AddToWishListLinkButton" runat="server" OnMouseOver="AddToWishListLinkButton_OnMouseOver(this)" CssClass="dnnPrimaryAction rvdsfBuyNowAction" />
					<asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="dnnSecondaryAction rvdUpdateAction" resourcekey="UpdateLinkButton" ValidationGroup="ProductDetailDisplayTemplateControl" />
					<dnn2:DnnContextMenu ID="AddToWishListDnnContextMenu" runat="server" CssClass="rvdsfAddToWishListContextMenu">
					</dnn2:DnnContextMenu>

					<script type="text/javascript">
						function AddToWishListLinkButton_OnMouseOver(sender)
						{
							var currentBound = $telerik.getBounds(sender);
							var contextMenu = $find("<%= AddToWishListDnnContextMenu.ClientID %>");
							contextMenu.showAt(currentBound.x, currentBound.y + currentBound.height);
						}
					</script>

				</div>
			</div>

			<script type="text/javascript">
				jQuery(function($)
				{
					$('#<%= ProductDisplayDetailPanel.ClientID %>').dnnTabs();
				});
			</script>

			<asp:Panel ID="ProductDisplayDetailPanel" runat="server" CssClass="dnnForm rvdsfProductDisplayDetailContainer">
				<ul class="dnnAdminTabNav dnnClear">
					<li runat="server" id="OverviewTabListItem"><a href="#<%= OverviewDetailsViewPanel.ClientID %>">
						<asp:Label ID="OverviewDetailsViewTabLabel" runat="server" /></a></li>
					<li runat="server" id="SpecificationsTabListItem"><a href="#<%= SpecificationsDetailsViewPanel.ClientID %>">
						<asp:Label ID="SpecificationsDetailsViewTabLabel" runat="server" /></a></li>
					<li runat="server" id="TermsTabListItem"><a href="#<%= TermsDetailsViewPanel.ClientID %>">
						<asp:Label ID="TermsDetailsViewTabLabel" runat="server" /></a></li>
					<li runat="server" id="FAQTabListItem"><a href="#<%= FAQDetailsViewPanel.ClientID %>">
						<asp:Label ID="FAQDetailsViewTabLabel" runat="server" /></a></li>
					<li runat="server" id="BuyingGuideTabListItem"><a href="#<%= BuyingGuideDetailsViewPanel.ClientID %>">
						<asp:Label ID="BuyingGuideDetailsViewTabLabel" runat="server" /></a></li>
					<li runat="server" id="ReviewsTabListItem"><a href="#<%= ReviewsDetailsViewPanel.ClientID %>">
						<asp:Label ID="ReviewsDetailsViewTabLabel" runat="server" /></a></li>
				</ul>
				<asp:Panel ID="OverviewDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplayOverview">
					<asp:Literal ID="OverviewLiteral" runat="server" EnableViewState="False"></asp:Literal>
				</asp:Panel>
				<asp:Panel ID="SpecificationsDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplaySpecifications">
					<asp:Literal ID="SpecificationsLiteral" runat="server" EnableViewState="False"></asp:Literal>
					<asp:ListView ID="ProductAttributeListView" runat="server">
						<LayoutTemplate>
							<div class="rvdsfProductDisplayProductAttributeList">
								<div id="itemPlaceHolder" runat="server" />
							</div>
						</LayoutTemplate>
						<ItemTemplate>
							<h4 class="dnnFormSectionHead">
								<asp:Label ID="ProductAttributeGroupLabel" runat="server" Text='<%# Eval("ProductAttributeGroupLabel_Text") %>' Visible='<%# Convert.ToBoolean(Eval("ProductAttributeGroupLabel_Visible")) %>' />
							</h4>
							<div class="dnnFormItem">
								<dnn1:LabelControl ID="ProductAttributeDefinitionNameLabelControl" runat="server" Text='<%# Eval("ProductAttributeDefinitionNameLabelControl_Text") %>' HelpText='<%# Eval("ProductAttributeDefinitionNameLabelControl_HelpText") %>' />
								<asp:Literal ID="ProductAttributeValueLiteral" runat="server" Text='<%# Eval("ProductAttributeValueLiteral_Text") %>'></asp:Literal>
							</div>
						</ItemTemplate>
					</asp:ListView>
				</asp:Panel>
				<asp:Panel ID="TermsDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplayTerms">
					<asp:Literal ID="TermsLiteral" runat="server" EnableViewState="False"></asp:Literal>
				</asp:Panel>
				<asp:Panel ID="FAQDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplayFAQ">
					<asp:Literal ID="FAQLiteral" runat="server" EnableViewState="False"></asp:Literal>
				</asp:Panel>
				<asp:Panel ID="BuyingGuideDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplayBuyingGuide">
					<asp:Literal ID="BuyingGuideLiteral" runat="server" EnableViewState="False"></asp:Literal>
				</asp:Panel>
				<asp:Panel ID="ReviewsDetailsViewPanel" runat="server" CssClass="dnnClear rvdsfProductDisplayReviews">
					<asp:UpdatePanel ID="ProductReviewUpdatePanel" runat="server" UpdateMode="Conditional">
						<ContentTemplate>
							<asp:PlaceHolder ID="AddProductReviewMessagePlaceHolder" runat="server"></asp:PlaceHolder>
							<asp:LinkButton ID="AddProductReviewLinkButton" runat="server" resourcekey="AddProductReviewLinkButton" OnClick="AddProductReviewLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" />
							<asp:Panel ID="AddProductReviewPanel" runat="server" Visible="False" CssClass="dnnForm">
								<fieldset>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="AddProductReviewOverallRatingLabelControl" runat="server" />
										<dnn2:DnnRating ID="AddProductReviewOverallRatingDnnRating" CssClass="rvdsfProductDisplayRating" runat="server" Value="0">
										</dnn2:DnnRating>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="AddProductReviewTitleLabelControl" runat="server" CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="AddProductReviewTitleRequiredFieldValidator" runat="server" ControlToValidate="AddProductReviewTitleTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="AddProductReviewTitleRequiredFieldValidator" ValidationGroup="AddProductReviewDetailDisplayTemplateControl"></asp:RequiredFieldValidator>
										<asp:TextBox ID="AddProductReviewTitleTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="AddProductReviewCommentLabelControl" runat="server" />
										<asp:TextBox ID="AddProductReviewCommentTextBox" runat="server" Rows="8" TextMode="MultiLine"></asp:TextBox>
									</div>
									<asp:Panel ID="AddProductReviewAnonymousUserPanel" runat="server" >
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="AddProductReviewNameLabelControl" runat="server" CssClass="dnnFormRequired"/>
											<asp:RequiredFieldValidator ID="AddProductReviewNameRequiredFieldValidator" runat="server" ControlToValidate="AddProductReviewNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="AddProductReviewNameRequiredFieldValidator" ValidationGroup="AddProductReviewDetailDisplayTemplateControl"></asp:RequiredFieldValidator>
											<asp:TextBox ID="AddProductReviewNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="AddProductReviewEmailLabelControl" runat="server" CssClass="dnnFormRequired"/>
											<asp:RequiredFieldValidator ID="AddProductReviewEmailRequiredFieldValidator" runat="server" ControlToValidate="AddProductReviewEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="AddProductReviewEmailRequiredFieldValidator" ValidationGroup="AddProductReviewDetailDisplayTemplateControl"></asp:RequiredFieldValidator>
											<asp:RegularExpressionValidator ID="AddProductReviewEmailRegularExpressionValidator" runat="server" ControlToValidate="AddProductReviewEmailTextBox" CssClass="dnnFormMessage dnnFormError" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" resourcekey="AddProductReviewEmailRegularExpressionValidator" ValidationGroup="AddProductReviewDetailDisplayTemplateControl"></asp:RegularExpressionValidator>
											<asp:TextBox ID="AddProductReviewEmailTextBox" runat="server" MaxLength="256" CssClass="dnnFormRequired"></asp:TextBox>
										</div>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="AddProductReviewCaptchaLabelControl" runat="server" CssClass="dnnFormRequired"/>
											<dnn2:CaptchaControl ID="AddProductReviewCaptchaControl" CaptchaWidth="130" CaptchaHeight="40" runat="server" ErrorStyle-CssClass="dnnFormMessage dnnFormError dnnCaptcha" />
										</div>
									</asp:Panel>
								</fieldset>
								<ul class="dnnActions dnnClear">
									<li>
										<asp:LinkButton ID="SaveAddProductReviewLinkButton" runat="server" resourcekey="SaveAddProductReviewLinkButton" OnClick="SaveAddProductReviewLinkButton_Click" ValidationGroup="AddProductReviewDetailDisplayTemplateControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
								</ul>
							</asp:Panel>
							<asp:ListView ID="ProductReviewListView" runat="server">
								<LayoutTemplate>
									<div class="rvdsfProductReviewList">
										<div runat="server" id="groupPlaceholder" />
									</div>
								</LayoutTemplate>
								<GroupTemplate>
									<div class="rvdsfProductReviewGroup">
										<div runat="server" id="itemPlaceholder" />
									</div>
								</GroupTemplate>
								<ItemTemplate>
									<div class="rvdsfProductReviewItem">
										<div class="rvdsfProductReviewItemAbstractContainer">
											<dnn2:DnnRating ID="ProductReviewOverallRatingDnnRating" runat="server" CssClass="rvdsfProductDisplayRating" Value='<%# Eval("ProductReviewOverallRatingDnnRating_Value") %>' ReadOnly="true">
											</dnn2:DnnRating>
											<asp:Label ID="ProductReviewDateLabel" runat="server" Text='<%# Eval("ProductReviewDateLabel_Text") %>' CssClass="rvdsfProductReviewDate" />
											<asp:Label ID="ProductReviewUserLabel" runat="server" Text='<%# Eval("ProductReviewUserLabel_Text") %>' CssClass="rvdsfProductReviewUser" />
										</div>
										<div class="rvdsfProductReviewItemInfoContainer">
											<asp:Label ID="ProductReviewTitleLabel" runat="server" Text='<%# Eval("ProductReviewTitleLabel_Text") %>' CssClass="rvdsfProductReviewTitle" />
											<p>
												<asp:Label ID="ProductReviewCommentLabel" runat="server" Text='<%# Eval("ProductReviewCommentLabel_Text") %>' CssClass="rvdsfProductReviewComment" />
											</p>
										</div>
									</div>
								</ItemTemplate>
							</asp:ListView>
							<div class="rvdPager">
								<asp:DataPager ID="ProductReviewDataPager" runat="server" OnPreRender="ProductReviewDataPager_PreRender" PagedControlID="ProductReviewListView" PageSize="10">
									<Fields>
										<asp:NextPreviousPagerField ButtonType="Link" RenderDisabledButtonsAsLabels="False" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="rvdPreviousAction" />
										<asp:NumericPagerField NumericButtonCssClass="rvdNumericAction" NextPreviousButtonCssClass="rvdNextPreviousAction" />
										<asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="rvdNextAction" />
									</Fields>
								</asp:DataPager>
							</div>
						</ContentTemplate>
					</asp:UpdatePanel>
				</asp:Panel>
			</asp:Panel>
			<asp:Panel ID="RelatedProductPanel" runat="server" CssClass="dnnForm rvdsfRelatedProductContainer">
				<h2 class="dnnFormSectionHead">
					<asp:Label ID="RelatedProductTitleLabel" runat="server" resourcekey="RelatedProductTitleLabel"></asp:Label>
				</h2>
				<asp:ListView ID="RelatedProductListView" GroupItemCount="1" runat="server">
					<LayoutTemplate>
						<div class="rvdsfRelatedProductList">
							<div runat="server" id="groupPlaceholder" />
						</div>
					</LayoutTemplate>
					<GroupTemplate>
						<div class="rvdsfRelatedProductGroup">
							<div runat="server" id="itemPlaceholder" />
						</div>
					</GroupTemplate>
					<ItemTemplate>
						<div class="rvdsfRelatedProductItem">
							<div class="rvdsfRelatedProductItemAbstractContainer">
								<asp:HyperLink ID="RelatedProductGalleryHyperLink" runat="server" NavigateUrl='<%# Eval("RelatedProductGalleryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductDisplayGalleryThumbnail">
									<asp:Image ID="RelatedProductGalleryImage" AlternateText='<%# Eval("RelatedProductGalleryImage_AlternateText") %>' ImageUrl='<%# Eval("RelatedProductGalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("RelatedProductGalleryImage_Visible")) %>' runat="server" /></asp:HyperLink>
							</div>
							<div class="rvdsfRelatedProductItemInfoContainer">
								<asp:HyperLink ID="RelatedProductHyperLink" runat="server" NavigateUrl='<%# Eval("RelatedProductHyperLink_NavigateUrl") %>' Text='<%# Eval("RelatedProductHyperLink_Text") %>' CssClass="rvdsfProductDisplayName"></asp:HyperLink>
								<dnn2:DnnRating ID="RelatedProductReviewAverageOverallRatingDnnRating" CssClass="rvdsfProductDisplayRating" runat="server" Value='<%# Eval("RelatedProductReviewAverageOverallRatingDnnRating_Value") %>' ReadOnly="true" Visible='<%# Convert.ToBoolean(Eval("RelatedProductReviewAverageOverallRatingDnnRating_Visible")) %>' />
								<div class="dnnFormItem rvdsfSalePriceAmount">
									<asp:Label ID="RelatedProductSalePriceValueLabel" runat="server" Text='<%# Eval("RelatedProductSalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RelatedProductSaleRecurringLabel" runat="server" Text='<%# Eval("RelatedProductSaleRecurringLabel_Text") %>' Visible='<%# Convert.ToBoolean(Eval("RelatedProductSaleRecurringLabel_Visible")) %>' />
								</div>
								<div class='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("RelatedProductPriceValueLabel_CssClass")) %>'>
									<asp:Label ID="RelatedProductPriceValueLabel" runat="server" Text='<%# Eval("RelatedProductPriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RelatedProductRecurringLabel_Text") %>' />
								</div>
							</div>
						</div>
					</ItemTemplate>
				</asp:ListView>
				<div class="rvdPager">
					<asp:DataPager ID="RelatedProductDataPager" runat="server" OnPreRender="RelatedProductDataPager_PreRender" PagedControlID="RelatedProductListView" PageSize="3">
						<Fields>
							<asp:NextPreviousPagerField ButtonType="Link" RenderDisabledButtonsAsLabels="False" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="rvdPreviousAction" />
							<asp:NumericPagerField NumericButtonCssClass="rvdNumericAction" NextPreviousButtonCssClass="rvdNextPreviousAction" />
							<asp:NextPreviousPagerField ButtonType="Link" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="rvdNextAction" />
						</Fields>
					</asp:DataPager>
				</div>
			</asp:Panel>
		</div>
	</asp:Panel>
</div>
