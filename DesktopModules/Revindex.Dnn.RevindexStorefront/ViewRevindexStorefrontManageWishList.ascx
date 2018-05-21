<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewRevindexStorefrontManageWishList.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ViewRevindexStorefrontManageWishList" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="UserAddressDropDownListControl.ascx" TagName="UserAddressDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<div class="rvdsfManageWishListContainer">
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<div class="dnnForm rvdsfListContainer">
				<asp:GridView ID="WishListGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="WishListGridView_RowDeleting" DataKeyNames="WishListID" OnRowDataBound="WishListGridView_RowDataBound">
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
						<asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" CssClass="rvdDeleteGridAction"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="Name" HeaderText="NameHeaderWishListGridView" SortExpression="Name" />
						<asp:BoundField DataField="EventDate" HeaderText="EventDateHeaderWishListGridView" SortExpression="EventDate" DataFormatString="{0:yyyy-MM-dd}" />
						<asp:BoundField DataField="WishListType" HeaderText="WishListTypeHeaderWishListGridView" SortExpression="WishListType" />
						<asp:CheckBoxField DataField="Published" SortExpression="Published" HeaderText="PublishedHeaderWishListGridView" />
					</Columns>
				</asp:GridView>
				<asp:ObjectDataSource ID="WishListObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCountByUser" SelectMethod="GetAllByUser" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.WishListController">
					<SelectParameters>
						<asp:Parameter Name="sortExpression" Type="String" />
						<asp:Parameter Name="maximumRows" Type="Int32" />
						<asp:Parameter Name="startRowIndex" Type="Int32" />
						<rvd1:UserControlParameter Name="userID" PropertyName="UserId" Type="Int32" />
					</SelectParameters>
				</asp:ObjectDataSource>
				<ul class="dnnActions dnnClear">
					<li>
						<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" resourcekey="AddHyperLink"/>
					</li>
				</ul>
			</div>
		</asp:View>
		<asp:View ID="DetailsView" runat="server">
			<script type="text/javascript">
				jQuery(function ($)
				{
					jQuery('#WishListDetailsViewTabPanel').dnnTabs();
					var panel = $('#WishListDetailsViewTabPanel').dnnPanels();
				});
			</script>

			<div id="WishListDetailsViewTabPanel" class="dnnForm">
				<ul class="dnnAdminTabNav">
					<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" resourcekey="GeneralDetailsViewTabLabel" />
					</a></li>
					<li><a href="#<%= ProductDetailsViewPanel.ClientID %>">
						<asp:Label ID="ProductDetailsViewTabLabel" runat="server" resourcekey="ProductDetailsViewTabLabel" /></a></li>
				</ul>
				<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="WishListIDLabelControl" runat="server" />
							<asp:Label ID="WishListIDLabel" runat="server" Text=""></asp:Label>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="NameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="NameRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="NameTextBox" runat="server" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="WishListTypeLabelControl" runat="server" />
							<asp:RadioButtonList ID="WishListTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons" RepeatLayout="Flow">
								<asp:ListItem Text="Baby" Value="2" />
								<asp:ListItem Text="Birthday" Value="3" />
								<asp:ListItem Text="Other" Value="1" />
								<asp:ListItem Text="Wedding" Value="4" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RegistrantFirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="RegistrantFirstNameRequiredFieldValidator" resourcekey="RegistrantFirstNameRequiredFieldValidator" runat="server" ControlToValidate="RegistrantFirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="RegistrantFirstNameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RegistrantLastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="RegistrantLastNameRequiredFieldValidator" resourcekey="RegistrantLastNameRequiredFieldValidator" runat="server" ControlToValidate="RegistrantLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="RegistrantLastNameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="Registrant2FirstNameLabelControl" runat="server" />
							<asp:TextBox ID="Registrant2FirstNameTextBox" runat="server"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="Registrant2LastNameLabelControl" runat="server" />
							<asp:TextBox ID="Registrant2LastNameTextBox" runat="server"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PersonalMessageLabelControl" runat="server" />
							<asp:TextBox ID="PersonalMessageTextBox" runat="server" TextMode="MultiLine" Height="100px"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PublishedLabelControl" runat="server" />
							<asp:CheckBox ID="PublishedCheckBox" runat="server" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShareLinkLabelControl" runat="server" />
							<asp:HyperLink ID="ShareLinkHyperLink" runat="server" Target="_blank" />
						</div>
					</fieldset>
					<h2 id="ShippingFormSectionHead" class="dnnFormSectionHead">
						<a href="#" class="dnnSectionExpanded">
							<%= DotNetNuke.Services.Localization.Localization.GetString("ShippingSection.Text", this.LocalResourceFile)%></a></h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="UserAddressLabelControl" runat="server" />
							<uc1:UserAddressDropDownListControl ID="UserAddressDropDownListControl" runat="server" AutoPostBack="True" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingFirstNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingFirstNameRequiredFieldValidator" resourcekey="ShippingFirstNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingFirstNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingFirstNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingLastNameLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingLastNameRequiredFieldValidator" runat="server" ControlToValidate="ShippingLastNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingLastNameRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingLastNameTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCompanyLabelControl" runat="server" />
							<asp:TextBox ID="ShippingCompanyTextBox" runat="server" MaxLength="100"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCountryLabelControl" runat="server" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="ShippingCountryRequiredFieldValidator" resourcekey="ShippingCountryRequiredFieldValidator" runat="server" ControlToValidate="ShippingCountryDropDownList" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:DropDownList ID="ShippingCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ShippingCountryDropDownList_SelectedIndexChanged">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingStreetLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingStreetRequiredFieldValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingStreetRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="ShippingStreetRegularExpressionValidator" runat="server" ControlToValidate="ShippingStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingStreetRegularExpressionValidator" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="ManageWishListDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="ShippingStreetTextBox" runat="server" Rows="2" TextMode="MultiLine" MaxLength="200" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingCityLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingCityRequiredFieldValidator" runat="server" ControlToValidate="ShippingCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingCityRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingCityTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingSubdivisionLabelControl" runat="server" />
							<asp:DropDownList ID="ShippingSubdivisionDropDownList" runat="server">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPostalCodeLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingPostalCodeRequiredFieldValidator" resourcekey="ShippingPostalCodeRequiredFieldValidator" runat="server" ControlToValidate="ShippingPostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingPostalCodeTextBox" runat="server" MaxLength="10" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingPhoneLabelControl" runat="server" CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="ShippingPhoneRequiredFieldValidator" runat="server" ControlToValidate="ShippingPhoneTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="ShippingPhoneRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
							<asp:TextBox ID="ShippingPhoneTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ShippingEmailLabelControl" runat="server" />
							<asp:RegularExpressionValidator ID="ShippingEmailRegularExpressionValidator" resourcekey="ShippingEmailRegularExpressionValidator" runat="server" ControlToValidate="ShippingEmailTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ManageWishListDetailsViewControl"></asp:RegularExpressionValidator>
							<asp:TextBox ID="ShippingEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
						</div>
					</fieldset>
					<h2 id="EventFormSectionHead" class="dnnFormSectionHead">
						<a href="#" class="dnnSectionExpanded">
							<%= DotNetNuke.Services.Localization.Localization.GetString("EventSection.Text", this.LocalResourceFile)%></a></h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EventDateLabelControl" runat="server" />
							<dnn2:DnnDatePicker ID="EventDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
							</dnn2:DnnDatePicker>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EventCountryCodeLabelControl" runat="server" />
							<asp:DropDownList ID="EventCountryCodeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="EventCountryCodeDropDownList_SelectedIndexChanged">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EventSubdivisionCodeLabelControl" runat="server" />
							<asp:DropDownList ID="EventSubdivisionCodeDropDownList" runat="server">
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="EventCityLabelControl" runat="server" />
							<asp:TextBox ID="EventCityTextBox" runat="server"></asp:TextBox>
						</div>
					</fieldset>
				</asp:Panel>
				<asp:Panel ID="ProductDetailsViewPanel" runat="server" CssClass="dnnClear">
					<asp:GridView ID="WishListDetailGridView" CssClass="dnnGrid" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="WishListDetailGridView_PageIndexChanging" OnRowDeleting="WishListDetailGridView_RowDeleting" DataKeyNames="WishListDetailID" OnRowCommand="WishListDetailGridView_RowCommand" >
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
											<asp:Panel ID="SummaryPanel" runat="server" CssClass="rvdsfProductDisplaySummary" Visible='<%# Convert.ToBoolean(Eval("SummaryPanel_Visible")) %>'>
												<asp:Literal ID="SummaryLiteral" runat="server" Text='<%# Eval("SummaryLiteral_Text") %>' />
											</asp:Panel>
											<dnn2:DnnRating ID="ProductReviewAverageOverallRatingDnnRating" runat="server" CssClass="rvdsfProductDisplayRating" ReadOnly="True" Value='<%# Eval("ProductReviewAverageOverallRatingDnnRating_Value") %>' Visible='<%# Convert.ToBoolean(Eval("ProductReviewAverageOverallRatingDnnRating_Visible")) %>' />
											<asp:Panel ID="SalePricePanel" runat="server" CssClass="dnnFormItem rvdsfSalePriceAmount" Visible='<%# Convert.ToBoolean(Eval("SalePricePanel_Visible")) %>'>
												<dnn1:LabelControl ID="SalePriceLabelControl" runat="server" />
												<asp:Label ID="SalePriceValueLabel" runat="server" Text='<%# Eval("SalePriceValueLabel_Text") %>'></asp:Label><asp:Label ID="SaleRecurringLabel" runat="server" CssClass="rvdsfSalePriceAmount" Text='<%# Eval("SaleRecurringLabel_Text") %>'></asp:Label>
											</asp:Panel>
											<asp:Panel ID="PricePanel" runat="server" CssClass='<%# String.Format("dnnFormItem rvdsfPriceAmount {0}", Eval("PriceValueLabel_CssClass")) %>' runat="server" Visible='<%# Convert.ToBoolean(Eval("PricePanel_Visible")) %>'>
												<dnn1:LabelControl ID="PriceLabelControl" runat="server" />
												<asp:Label ID="PriceValueLabel" runat="server" Text='<%# Eval("PriceValueLabel_Text") %>'></asp:Label><asp:Label ID="RecurringLabel" runat="server" Text='<%# Eval("RecurringLabel_Text") %>'></asp:Label>
											</asp:Panel>
											<asp:Panel ID="MSRPPricePanel" runat="server" CssClass="dnnFormItem rvdsfMSRPPriceAmount" Visible='<%# Convert.ToBoolean(Eval("MSRPPricePanel_Visible")) %>'>
												<dnn1:LabelControl ID="MSRPLabelControl" runat="server" />
												<asp:Label ID="MSRPValueLabel" runat="server" Text='<%# Eval("MSRPValueLabel_Text") %>'></asp:Label>
												<asp:Label ID="MSRPRecurringLabel" runat="server" Text='<%# Eval("MSRPRecurringLabel_Text") %>'></asp:Label>
											</asp:Panel>
											<asp:Panel ID="SavingsPanel" runat="server" CssClass="dnnFormItem rvdsfSavingsAmount" Visible='<%# Convert.ToBoolean(Eval("SavingsPanel_Visible")) %>'>
												<dnn1:LabelControl ID="SavingsLabelControl" runat="server" />
												<asp:Label ID="SavingsValueLabel" runat="server" CssClass="" Text='<%# Eval("SavingsValueLabel_Text") %>'></asp:Label>
											</asp:Panel>
											<asp:Panel ID="QuantityPanel" runat="server" CssClass="dnnFormItem" Visible='<%# Convert.ToBoolean(Eval("QuantityPanel_Visible")) %>'>
												<dnn1:LabelControl ID="QuantityLabelControl" runat="server" CssClass="dnnFormRequired" />
												<asp:RequiredFieldValidator ID="QuantityRequiredFieldValidator" runat="server" resourcekey="QuantityRequiredFieldValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductListDisplayTemplateControl"></asp:RequiredFieldValidator>
												<asp:RangeValidator ID="QuantityRangeValidator" runat="server" resourcekey="QuantityRangeValidator" ControlToValidate="QuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue='<%# Eval("QuantityRangeValidator_MaximumValue") %>' MinimumValue='<%# Eval("QuantityRangeValidator_MinimumValue") %>' Type="Integer" ValidationGroup="ProductListDisplayTemplateControl"></asp:RangeValidator>
												<dnn2:DnnNumericTextBox ID="QuantityDnnNumericTextBox" runat="server" CssClass="rvdQuantityInput dnnFormRequired" Skin="" EnableSingleInputRendering="False" MinValue="1" Value='<%# Eval("QuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" Enabled='<%# Convert.ToBoolean(Eval("QuantityDnnNumericTextBox_Enabled")) %>'>
												</dnn2:DnnNumericTextBox>
											</asp:Panel>
											<div class="rvdsfProductDisplayActions">
												<asp:LinkButton ID="AddToCartLinkButton" runat="server" resourcekey="AddToCartLinkButton" CssClass="dnnPrimaryAction rvdsfAddToCartAction" Visible='<%# Convert.ToBoolean(Eval("AddToCartLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="AddToCart" CommandArgument='<%# Eval("ProductVariantID") %>' />
												<asp:LinkButton ID="BuyNowLinkButton" runat="server" resourcekey="BuyNowLinkButton" CssClass="dnnPrimaryAction rvdsfBuyNowAction" Visible='<%# Convert.ToBoolean(Eval("BuyNowLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="BuyNow" CommandArgument='<%# Eval("ProductVariantID") %>' />
												<asp:LinkButton ID="AddToQuoteLinkButton" runat="server" resourcekey="AddToQuoteLinkButton" CssClass="dnnPrimaryAction rvdsfAddToQuoteAction" Visible='<%# Convert.ToBoolean(Eval("AddToQuoteLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="AddToQuote" CommandArgument='<%# Eval("ProductVariantID") %>' />
												<asp:LinkButton ID="QuoteNowLinkButton" runat="server" resourcekey="QuoteNowLinkButton" CssClass="dnnPrimaryAction rvdsfQuoteNowAction" Visible='<%# Convert.ToBoolean(Eval("QuoteNowLinkButton_Visible")) %>' ValidationGroup="ProductListDisplayTemplateControl" CommandName="QuoteNow" CommandArgument='<%# Eval("ProductVariantID") %>' />
											</div>
										</div>
									</div>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="DesiredQuantityHeaderWishListDetailGridView" ItemStyle-HorizontalAlign="Left">
								<ItemTemplate>
									<asp:RequiredFieldValidator ID="DesiredQuantityRequiredFieldValidator" runat="server" ControlToValidate="DesiredQuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="DesiredQuantityRequiredFieldValidator" ValidationGroup="ManageWishListDetailsViewControl"></asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DesiredQuantityDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="rvdQuantityInput dnnFormRequired" MinValue="1" DbValue='<%# Eval("DesiredQuantityDnnNumericTextBox_Value") %>' NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9">
									</dnn2:DnnNumericTextBox>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:BoundField DataField="OrderedQuantity" HeaderText="OrderedQuantityHeaderWishListDetailGridView" SortExpression="OrderedQuantity" ItemStyle-HorizontalAlign="Left" />
							<asp:TemplateField HeaderText="ContributorHeaderWishListDetailGridView" ItemStyle-HorizontalAlign="Left">
								<ItemTemplate>
									<a href="#" onclick="jQuery('.rvdsfWishListContributors').toggle(); return false;">
										<%= DotNetNuke.Services.Localization.Localization.GetString("ViewContributorHyperLink.Text", this.LocalResourceFile)%></a>
									<ul class="rvdsfWishListContributors">
										<asp:Literal ID="ContributorLiteral" runat="server" Text='<%# Eval("ContributorLiteral_Text") %>'></asp:Literal>
									</ul>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField>
								<ItemTemplate>
									<asp:LinkButton ID="DeleteLinkButtonFieldWishListDetailGridView" runat="server" CommandName="Delete" CausesValidation="False" CssClass="rvdDeleteGridAction"></asp:LinkButton>
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
					</asp:GridView>
				</asp:Panel>
			</div>
			<div class="dnnForm">
				<ul class="dnnActions dnnClear">
					<li>
						<asp:LinkButton ID="SaveLinkButton" CssClass="dnnPrimaryAction" runat="server" OnClick="SaveLinkButton_Click" resourcekey="SaveLinkButton" ValidationGroup="ManageWishListDetailsViewControl" CommandArgument="Back">Save</asp:LinkButton>
					</li>
					<li>
						<uc1:BackControl ID="BackControl" runat="server" Text="Cancel" ResourceKey="BackControl" />
					</li>
				</ul>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
