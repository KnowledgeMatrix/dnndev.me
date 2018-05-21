<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.WishList.Standard1.Display" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<asp:Panel ID="SearchPanel" runat="server" class="dnnForm" DefaultButton="SearchLinkButton">
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
			<dnn1:LabelControl ID="SearchLabelControl" runat="server" />
			<asp:RequiredFieldValidator ID="SearchRequiredFieldValidator" resourcekey="SearchRequiredFieldValidator" runat="server" ControlToValidate="SearchTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="WishListDetailsViewControl"></asp:RequiredFieldValidator>
			<asp:TextBox ID="SearchTextBox" runat="server" CssClass="dnnFormRequired" />
		</div>
	</fieldset>
	<ul class="dnnActions dnnClear">
		<li>
			<asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="dnnPrimaryAction" Text="Search" OnClick="SearchLinkButton_Click" ValidationGroup="WishListDetailsViewControl"></asp:LinkButton></li>
	</ul>
	<asp:GridView ID="WishListGridView" runat="server" CssClass="dnnGrid" GridLines="None" Width="100%" AutoGenerateColumns="False" AllowSorting="True" OnSorting="WishListGridView_Sorting">
		<HeaderStyle CssClass="dnnGridHeader" />
		<RowStyle CssClass="dnnGridItem" />
		<AlternatingRowStyle CssClass="dnnGridAltItem" />
		<Columns>
			<asp:HyperLinkField DataTextField="Name" HeaderText="NameWishListGridView" SortExpression="Name" HeaderStyle-HorizontalAlign="Left" DataNavigateUrlFields="Url" />
			<asp:BoundField DataField="Registrant" HeaderText="RegistrantWishListGridView" HeaderStyle-HorizontalAlign="Left" SortExpression="Registrant" />
			<asp:BoundField DataField="EventDate" HeaderText="EventDateWishListGridView" HeaderStyle-HorizontalAlign="Left" SortExpression="EventDate" />
			<asp:BoundField DataField="EventLocation" HeaderText="EventLocationWishListGridView" HeaderStyle-HorizontalAlign="Left" SortExpression="EventLocation" />
		</Columns>
		<EmptyDataTemplate>
			<div class="dnnFormItem">
				<asp:Label ID="NoResultLabel" runat="server" Text="No results found." CssClass="dnnFormMessage dnnFormInfo" /></div>
		</EmptyDataTemplate>
	</asp:GridView>
</asp:Panel>
<asp:Panel ID="WishListDetailPanel" runat="server" class="dnnForm">
	<h1 class="dnnFormSectionHead"><asp:Label ID="NameLabel" runat="server" /></h1>
	<p><asp:Label ID="PersonalMessageLabel" runat="server" /></p>
	<fieldset>
		<div class="dnnFormItem"><dnn1:LabelControl ID="RegistrantLabelControl" runat="server" /><asp:Label ID="RegistrantLabel" runat="server" /></div>
		<div class="dnnFormItem"><dnn1:LabelControl ID="EventDateLabelControl" runat="server" /><asp:Label ID="EventDateLabel" runat="server" /></div>
		<div class="dnnFormItem"><dnn1:LabelControl ID="EventLocationLabelControl" runat="server" /><asp:Label ID="EventLocationLabel" runat="server" /></div>
	</fieldset>
	<asp:GridView ID="WishListDetailGridView" CssClass="dnnGrid" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="WishListDetailGridView_PageIndexChanging" Width="100%" DataKeyNames="WishListDetailID" OnRowCommand="WishListDetailGridView_RowCommand" >
		<HeaderStyle CssClass="dnnGridHeader" />
		<RowStyle CssClass="dnnGridItem" />
		<AlternatingRowStyle CssClass="dnnGridAltItem" />
		<SelectedRowStyle BackColor="#FFFF66" />
		<Columns>
			<asp:TemplateField HeaderText="ProductHeaderWishListDetailGridView" HeaderStyle-HorizontalAlign="Left">
				<ItemTemplate>
					<table cellpadding="10" cellspacing="0" style="width: 100%">
								<tr>
									<td style="vertical-align: top; width: 100px">
										<asp:HyperLink ID="GalleryHyperLink" BorderStyle="None" runat="server" NavigateUrl='<%# Eval("GalleryHyperLink_NavigateUrl") %>'>
											<asp:Image ID="GalleryImage" Width='<%# Eval("GalleryImage_Width") %>' AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" BorderStyle="None" /></asp:HyperLink>
									</td>
									<td style="text-align: left; vertical-align: top" valign="top">
										<asp:HyperLink ID="ProductHyperLink" runat="server" NavigateUrl='<%# Eval("ProductHyperLink_NavigateUrl") %>' Text='<%# Eval("ProductHyperLink_Text") %>'></asp:HyperLink>
										<br />
										<asp:Literal ID="SummaryLiteral" runat="server" Text='<%# Eval("SummaryLiteral_Text") %>' />
										<br />
										<br />
										<table cellpadding="3" cellspacing="0">
											<tr>
												<td>
													<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" runat="server" ReadOnly="true" Value='<%# Eval("ProductReviewAverageOverallRatingDnnRating_Value") %>' Visible='<%# Convert.ToBoolean(Eval("ProductReviewAverageOverallRatingDnnRating_Visible")) %>'>
													</dnn2:DnnRating>
												</td>
											</tr>
										</table>
										<table cellpadding="3" cellspacing="0">
											<tr>
												<td>
													<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" Visible='<%# Convert.ToBoolean(Eval("SalePriceLabelControl_Visible")) %>' />
												</td>
												<td>
													<asp:Label ID="SalePriceValueLabel" runat="server" CssClass="NormalRed" Text='<%# Eval("SalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="SaleRecurringLabel" runat="server" CssClass="NormalRed" Text='<%# Eval("SaleRecurringLabel_Text") %>' Visible='<%# Convert.ToBoolean(Eval("SaleRecurringLabel_Visible")) %>'></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
													<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
												</td>
												<td>
													<asp:Label ID="PriceValueLabel" runat="server" Font-Strikeout='<%# Convert.ToBoolean(Eval("PriceValueLabel_FontStrikeout")) %>' Text='<%# Eval("PriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RecurringLabel_Text") %>'></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
													<dnn1:LabelControl ID="MSRPLabelControl" runat="server" Visible='<%# Convert.ToBoolean(Eval("MSRPLabelControl_Visible")) %>' />
												</td>
												<td>
													<asp:Label ID="MSRPValueLabel" runat="server" Text='<%# Eval("MSRPValueLabel_Text") %>'></asp:Label>
													<asp:Label ID="MSRPRecurringLabel" runat="server" Text='<%# Eval("MSRPRecurringLabel_Text") %>' Visible='<%# Convert.ToBoolean(Eval("MSRPRecurringLabel_Visible")) %>'></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
													<dnn1:LabelControl ID="SavingsLabelControl" runat="server" Visible='<%# Convert.ToBoolean(Eval("SavingsLabelControl_Visible")) %>' />
												</td>
												<td>
													<asp:Label ID="SavingsValueLabel" runat="server" CssClass="NormalRed" Text='<%# Eval("SavingsValueLabel_Text") %>'></asp:Label>
												</td>
											</tr>
											<tr>
												<td>
													<dnn1:LabelControl ID="QuantityLabelControl" runat="server" Visible='<%# Convert.ToBoolean(Eval("QuantityLabelControl_Visible")) %>' />
													<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductListDisplayTemplateControl" Visible='<%# Convert.ToBoolean(Eval("QuantityRequiredFieldValidator_Visible")) %>'></asp:RequiredFieldValidator>
													<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue='<%# Eval("QuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("QuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="ProductListDisplayTemplateControl" Visible='<%# Convert.ToBoolean(Eval("QuantityRangeValidator_Visible")) %>'></asp:RangeValidator>
												</td>
												<td>
													<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" Width="50px" MinValue="1" Value='<%# Eval("QuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Visible='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Visible")) %>' Enabled='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Enabled")) %>'>
													</dnn2:DnnNumericTextBox>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<dnn2:DnnRadButton ID="AddToCartDnnRadButton" runat="server" Text="AddToCartDnnRadButton" Visible='<%# Convert.ToBoolean(Eval("AddToCartDnnRadButton_Visible")) %>' Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/CartIcon.gif" ValidationGroup="ProductListDisplayTemplateControl" CommandName="AddToCart" CommandArgument='<%# Eval("ProductVariantID") %>'>
													</dnn2:DnnRadButton>
													&nbsp;<dnn2:DnnRadButton ID="BuyNowDnnRadButton" runat="server" Text="BuyNowDnnRadButton" Visible='<%# Convert.ToBoolean(Eval("BuyNowDnnRadButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" Icon-PrimaryIconUrl="~/DesktopModules/Revindex.Dnn.RevindexStorefront/Media/BuyNowIcon.gif" CommandName="BuyNow" CommandArgument='<%# Eval("ProductVariantID") %>'>
													</dnn2:DnnRadButton>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
				</ItemTemplate>
			</asp:TemplateField>
			<asp:BoundField DataField="DesiredQuantity" HeaderText="DesiredQuantityHeaderWishListDetailGridView" ItemStyle-HorizontalAlign="Left" />
			<asp:BoundField DataField="OrderedQuantity" HeaderText="OrderedQuantityHeaderWishListDetailGridView" SortExpression="OrderedQuantity" ItemStyle-HorizontalAlign="Left" />
		</Columns>
	</asp:GridView>
</asp:Panel>
