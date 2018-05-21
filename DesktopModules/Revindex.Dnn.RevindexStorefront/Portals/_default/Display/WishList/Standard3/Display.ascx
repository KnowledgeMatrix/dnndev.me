<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.WishList.Standard3.Display" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdsfWishListContainer">
	<asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm" DefaultButton="SearchLinkButton">
		<fieldset>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="TypeLabelControl" runat="server" Text="Search wish list & registry:" />
				<asp:RadioButtonList ID="TypeRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons" RepeatLayout="Flow">
					<asp:ListItem Text="Baby" Value="2" Selected="True" />
					<asp:ListItem Text="Birthday" Value="3" />
					<asp:ListItem Text="Other" Value="1" />
					<asp:ListItem Text="Wedding" Value="4" />
				</asp:RadioButtonList>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="SearchLabelControl" runat="server" CssClass="dnnFormRequired"/>
				<asp:RequiredFieldValidator ID="SearchRequiredFieldValidator" resourcekey="SearchRequiredFieldValidator" runat="server" ControlToValidate="SearchTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="WishListDetailsViewControl"></asp:RequiredFieldValidator>
				<asp:TextBox ID="SearchTextBox" runat="server" CssClass="dnnFormRequired" />
			</div>
		</fieldset>
		<ul class="dnnActions dnnClear">
			<li>
				<asp:LinkButton ID="SearchLinkButton" runat="server" resourcekey="SearchLinkButton" CssClass="dnnPrimaryAction" Text="Search" OnClick="SearchLinkButton_Click" ValidationGroup="WishListDetailsViewControl"></asp:LinkButton></li>
		</ul>
		<asp:GridView ID="WishListGridView" runat="server" CssClass="dnnGrid rvdsfWishListGrid" GridLines="None" AutoGenerateColumns="False" AllowSorting="True" OnSorting="WishListGridView_Sorting">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:HyperLinkField DataTextField="Name" HeaderText="NameWishListGridView" SortExpression="Name" DataNavigateUrlFields="Url" />
				<asp:BoundField DataField="Registrant" HeaderText="RegistrantWishListGridView" SortExpression="Registrant" />
				<asp:BoundField DataField="EventDate" HeaderText="EventDateWishListGridView" SortExpression="EventDate" />
				<asp:BoundField DataField="EventLocation" HeaderText="EventLocationWishListGridView" SortExpression="EventLocation" />
			</Columns>
			<EmptyDataTemplate>
				<div class="dnnFormItem">
					<asp:Label ID="NoResultLabel" runat="server" Text="No results found." CssClass="dnnFormMessage dnnFormInfo" /></div>
			</EmptyDataTemplate>
		</asp:GridView>
	</asp:Panel>
	<asp:Panel ID="WishListDetailPanel" runat="server" class="dnnForm">
		<h1 class="dnnFormSectionHead">
			<asp:Label ID="NameLabel" runat="server" /></h1>
		<p>
			<asp:Label ID="PersonalMessageLabel" runat="server" /></p>
		<fieldset>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RegistrantLabelControl" runat="server" />
				<asp:Label ID="RegistrantLabel" runat="server" /></div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="EventDateLabelControl" runat="server" />
				<asp:Label ID="EventDateLabel" runat="server" /></div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="EventLocationLabelControl" runat="server" />
				<asp:Label ID="EventLocationLabel" runat="server" /></div>
		</fieldset>
		<asp:GridView ID="WishListDetailGridView" CssClass="dnnGrid rvdsfWishListDetailGrid" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="WishListDetailGridView_PageIndexChanging" DataKeyNames="WishListDetailID" OnRowCommand="WishListDetailGridView_RowCommand">
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:TemplateField HeaderText="ProductHeaderWishListDetailGridView">
					<ItemTemplate>
						<div class="rvdsfProductDisplayContainer">
							<div class="rvdsfProductDisplayAbstractContainer">
								<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("GalleryHyperLink_NavigateUrl") %>' CssClass="rvdsfProductDisplayGalleryThumbnail">
									<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
								</asp:HyperLink>
							</div>
							<div class="rvdsfProductDisplayInfoContainer">
								<asp:HyperLink ID="ProductHyperLink" runat="server" CssClass="rvdsfProductDisplayName" NavigateUrl='<%# Eval("ProductHyperLink_NavigateUrl") %>' Text='<%# Eval("ProductHyperLink_Text") %>'></asp:HyperLink>
								<asp:Panel ID="SummaryPanel" runat="server" CssClass="rvdsfProductDisplaySummary"  Visible='<%# Convert.ToBoolean(Eval("SummaryPanel_Visible")) %>'>
									<asp:Literal ID="SummaryLiteral" runat="server" Text='<%# Eval("SummaryLiteral_Text") %>' />
								</asp:Panel>
								<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" runat="server" CssClass="rvdsfProductDisplayRating" ReadOnly="True" Value='<%# Eval("ProductReviewAverageOverallRatingDnnRating_Value") %>' Visible='<%# Convert.ToBoolean(Eval("ProductReviewAverageOverallRatingDnnRating_Visible")) %>' />
								<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount" Visible='<%# Convert.ToBoolean(Eval("SalePricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" />
									<asp:Label ID="SalePriceValueLabel" runat="server" Text='<%# Eval("SalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="SaleRecurringLabel" runat="server" CssClass="rvdsfSalePriceAmount" Text='<%# Eval("SaleRecurringLabel_Text") %>' ></asp:Label>
								</asp:Panel>
								<asp:Panel ID="PricePanel" runat="server" CssClass='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("PriceValueLabel_CssClass")) %>' runat="server"  Visible='<%# Convert.ToBoolean(Eval("PricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
									<asp:Label ID="PriceValueLabel" runat="server" Text='<%# Eval("PriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RecurringLabel_Text") %>'></asp:Label>
								</asp:Panel>
								<asp:Panel ID="MSRPPricePanel" runat="server" CssClass="dnnFormItem rvdsfMSRPPriceAmount" Visible='<%# Convert.ToBoolean(Eval("MSRPPricePanel_Visible")) %>'>
									<dnn1:LabelControl ID="MSRPLabelControl" runat="server" />
									<asp:Label ID="MSRPValueLabel" runat="server" Text='<%# Eval("MSRPValueLabel_Text") %>'></asp:Label>
									<asp:Label ID="MSRPRecurringLabel" runat="server" Text='<%# Eval("MSRPRecurringLabel_Text") %>' ></asp:Label>
								</asp:Panel>
								<asp:Panel ID="SavingsPanel" runat="server" CssClass="dnnFormItem rvdsfSavingsAmount" Visible='<%# Convert.ToBoolean(Eval("SavingsPanel_Visible")) %>'>
									<dnn1:LabelControl ID="SavingsLabelControl" runat="server" />
									<asp:Label ID="SavingsValueLabel" runat="server" CssClass="" Text='<%# Eval("SavingsValueLabel_Text") %>'></asp:Label>
								</asp:Panel>
								<asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem" Visible='<%# Convert.ToBoolean(Eval("QuantityPanel_Visible")) %>'>
									<dnn1:LabelControl ID="QuantityLabelControl" runat="server" CssClass="dnnFormRequired"/>
									<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductListDisplayTemplateControl" ></asp:RequiredFieldValidator>
									<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue='<%# Eval("QuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("QuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="ProductListDisplayTemplateControl" ></asp:RangeValidator>
									<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" CssClass="rvdQuantityInput dnnFormRequired" Skin="" EnableSingleInputRendering="False" MinValue="1" Value='<%# Eval("QuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Enabled='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Enabled")) %>'>
									</dnn2:DnnNumericTextBox>
								</asp:Panel>
								<div class="rvdsfProductDisplayActions">
									<asp:LinkButton ID="AddToCartLinkButton" runat="server" resourcekey="AddToCartLinkButton" CssClass="dnnPrimaryAction rvdsfAddToCartAction" Visible='<%# Convert.ToBoolean(Eval("AddToCartLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="AddToCart" CommandArgument='<%# Eval("ProductVariantID") %>' />
									<asp:LinkButton ID="BuyNowLinkButton" runat="server" resourcekey="BuyNowLinkButton" CssClass="dnnPrimaryAction rvdsfBuyNowAction" Visible='<%# Convert.ToBoolean(Eval("BuyNowLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="BuyNow" CommandArgument='<%# Eval("ProductVariantID") %>' />
								</div>
							</div>
						</div>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField DataField="DesiredQuantity" HeaderText="DesiredQuantityHeaderWishListDetailGridView" />
				<asp:BoundField DataField="OrderedQuantity" HeaderText="OrderedQuantityHeaderWishListDetailGridView" SortExpression="OrderedQuantity" />
			</Columns>
		</asp:GridView>
	</asp:Panel>
</div>
