<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.ProductShowcase.Standard6.Display" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Import Namespace="Revindex.Business.Revindex.Revindex.Storefront" %>
<div class="rvdsfProductShowcaseContainer">

	<script type="text/javascript">
		jQuery(document).ready(function($)
		{
			// Refer to http://caroufredsel.dev7studios.com/configuration.php for configuration settings
			$(".rvdsfProductShowcaseRotator").carouFredSel
			({			
				auto:
				{
					play: <%= (this.ProductShowcaseDisplayEffect == ProductShowcaseDisplayEffectType.AutomaticAdvance).ToString().ToLower() %>,
					timeoutDuration: <%= this.ProductShowcaseFrameDuration %>,
				},
				
				circular: <%= this.ProductShowcaseWrapFrames.ToString().ToLower() %>,
				
				<% if (this.ProductShowcaseScrollDirection == ProductShowcaseScrollDirectionType.Left) { %>
				direction: 'left',
				<% } else if (this.ProductShowcaseScrollDirection == ProductShowcaseScrollDirectionType.Right) { %>
				direction: 'right',
				<% } else if (this.ProductShowcaseScrollDirection == ProductShowcaseScrollDirectionType.Up) { %>
				direction: 'up',
				<% } else if (this.ProductShowcaseScrollDirection == ProductShowcaseScrollDirectionType.Down) { %>
				direction: 'down',
				<% } else if ((this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Left) == ProductShowcaseScrollDirectionType.Left) { %>
				direction: 'left',
				<% } else if ((this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Up) == ProductShowcaseScrollDirectionType.Up) { %>
				direction: 'up',
				<% } else { %>
				direction: 'left',
				<% } %>
				
				<% if (this.ProductShowcaseHeight.IsEmpty || this.ProductShowcaseHeight.Type == UnitType.Percentage) { %>
				height: '<%= this.ProductShowcaseHeight.ToString() %>',
				<% } else { %>
				height: <%= this.ProductShowcaseHeight.Value %>,
				<% } %>
				
				infinite: <%= this.ProductShowcaseWrapFrames.ToString().ToLower() %>,
				
				items: 
				{
					visible: 
					{
						min: 1,
						max: <%= this.ProductShowcaseVisibleMaxItems %>
					}
				},
				
				<% if (this.ProductShowcaseScrollDirection == (ProductShowcaseScrollDirectionType.Left | ProductShowcaseScrollDirectionType.Right)) { %>
				responsive: <%= (this.ProductShowcaseWidth.Type == UnitType.Percentage).ToString().ToLower() %>,
				<% } %>
				
				<% if (this.ProductShowcaseWidth.IsEmpty || this.ProductShowcaseWidth.Type == UnitType.Percentage) { %>
				width: '<%= this.ProductShowcaseWidth.ToString() %>',
				<% } else { %>
				width: <%= this.ProductShowcaseWidth.Value %>,
				<% } %>
				
				scroll:
	    		{
	    			items: 1,
	    			duration: <%= this.ProductShowcaseScrollDuration %>,
	    			pauseOnHover: true
	    		},
	    		
				<% if (this.ProductShowcaseDisplayEffect != ProductShowcaseDisplayEffectType.AutomaticAdvance && ((this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Left) == ProductShowcaseScrollDirectionType.Left || (this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Up) == ProductShowcaseScrollDirectionType.Up)) { %>
				prev:
				{
					button: '.rvdPreviousAction',
					
					<% if (this.ProductShowcaseDisplayEffect == ProductShowcaseDisplayEffectType.ButtonMouseOver) { %>
					event: 'mouseover',
					<% } %>
					<% if (this.ProductShowcaseDisplayEffect == ProductShowcaseDisplayEffectType.ButtonClick) { %>
					event: 'click',
					<% } %>
					
					items: ''
				},
				<%} %>
				
				<% if (this.ProductShowcaseDisplayEffect != ProductShowcaseDisplayEffectType.AutomaticAdvance && ((this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Right) == ProductShowcaseScrollDirectionType.Right || (this.ProductShowcaseScrollDirection & ProductShowcaseScrollDirectionType.Down) == ProductShowcaseScrollDirectionType.Down)) { %>
				next:
				{
					button: '.rvdNextAction',
					
					<% if (this.ProductShowcaseDisplayEffect == ProductShowcaseDisplayEffectType.ButtonMouseOver) { %>
					event: 'mouseover',
					<% } %>
					<% if (this.ProductShowcaseDisplayEffect == ProductShowcaseDisplayEffectType.ButtonClick) { %>
					event: 'click',
					<% } %>
					
					items: ''
				},
				<%} %>
				
				pagination:
				{
					// Uncomment to show pager
					//container: '.rvdNumericAction',
					items: ''
				},
				
				mousewheel: true,
				
				swipe:
				{
					onMouse: true,
					onTouch: true
				}
			});
		});
	</script>

	<asp:Panel CssClass="rvdsfProductShowcaseRotatorContainer" runat="server" ID="ProductShowcaseRotatorPanel">
		<ul class="rvdsfProductShowcaseRotator">
			<asp:Repeater ID="ProductShowcaseRepeater" runat="server" OnItemDataBound="ProductShowcaseRepeater_ItemDataBound">
				<ItemTemplate>
					<li>
						<div class="rvdsfProductDisplayContainer">
							<div class="dnnForm rvdsfProductDisplayAbstractContainer">
								<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("GalleryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductDisplayGalleryThumbnail">
									<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
								</asp:HyperLink>
							</div>
							<div class="dnnForm rvdsfProductDisplayInfoContainer">
								<asp:HyperLink ID="ProductHyperLink" runat="server" NavigateUrl='<%# Eval("ProductHyperLink_NavigateUrl") %>' Text='<%# Eval("ProductHyperLink_Text") %>'></asp:HyperLink>
								<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" runat="server" ReadOnly="true" Value='<%# Eval("ProductReviewAverageOverallRatingDnnRating_Value") %>' Visible='<%# Convert.ToBoolean(Eval("ProductReviewAverageOverallRatingDnnRating_Visible")) %>' CssClass="rvdsfProductDisplayRating" />
								<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount" Visible='<%# Convert.ToBoolean(Eval("SalePricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" />
									<asp:Label ID="SalePriceValueLabel" runat="server" Text='<%# Eval("SalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="SaleRecurringLabel" runat="server" Text='<%# Eval("SaleRecurringLabel_Text") %>' ></asp:Label>
								</asp:Panel>
								<asp:Panel ID="PricePanel" CssClass='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("PriceValueLabel_CssClass")) %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("PricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
									<asp:Label ID="PriceValueLabel" runat="server" Text='<%# Eval("PriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RecurringLabel_Text") %>'></asp:Label>
								</asp:Panel>
								<asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem" Visible='<%# Convert.ToBoolean(Eval("QuantityPanel_Visible")) %>'>
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductShowcaseDisplayTemplateControl" ></asp:RequiredFieldValidator>
									<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue='<%# Eval("QuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("QuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="ProductShowcaseDisplayTemplateControl"></asp:RangeValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" MinValue="1" CssClass="rvdQuantityInput dnnFormRequired" Value='<%# Eval("QuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Enabled='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Enabled")) %>'>
									</dnn2:DnnNumericTextBox>
								</asp:Panel>
								<div class="rvdsfProductDisplayActions">
									<asp:LinkButton ID="SeeDetailsLinkButton" runat="server" resourcekey="SeeDetailsLinkButton" Visible='<%# Convert.ToBoolean(Eval("SeeDetailsLinkButton_Visible")) %>' ValidationGroup="ProductShowcaseDisplayTemplateControl" OnClientClick='<%# Eval("SeeDetailsLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdSeeDetailsAction" />
									<asp:LinkButton ID="AddToCartLinkButton" runat="server" resourcekey="AddToCartLinkButton" Visible='<%# Convert.ToBoolean(Eval("AddToCartLinkButton_Visible")) %>' ValidationGroup="ProductShowcaseDisplayTemplateControl" OnClientClick='<%# Eval("AddToCartLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfAddToCartAction" />
									<asp:LinkButton ID="BuyNowLinkButton" runat="server" resourcekey="BuyNowLinkButton" Visible='<%# Convert.ToBoolean(Eval("BuyNowLinkButton_Visible")) %>' ValidationGroup="ProductShowcaseDisplayTemplateControl" OnClientClick='<%# Eval("BuyNowLinkButton_OnClientClick") %>' CssClass="dnnPrimaryAction rvdsfBuyNowAction" />
								</div>
							</div>
						</div>
					</li>
				</ItemTemplate>
			</asp:Repeater>
		</ul>
		<a class="rvdsfProductShowcasePagination rvdPreviousAction" href="#"></a>
		<a class="rvdsfProductShowcasePagination rvdNextAction" href="#"></a>
		<div class="rvdsfProductShowcasePagination rvdNumericAction" ></div>
	</asp:Panel>
</div>
