<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="CategoryDropDownListControl.ascx" TagName="CategoryDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="CrosssellProductControl.ascx" TagName="CrosssellProductControl" TagPrefix="uc1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="GalleryControl.ascx" TagName="GalleryControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantControl.ascx" TagName="ProductVariantControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantGroupControl.ascx" TagName="ProductVariantGroupControl" TagPrefix="uc1" %>
<%@ Register Src="CategoryCheckBoxListControl.ascx" TagName="CategoryCheckBoxListControl" TagPrefix="uc1" %>
<%@ Register Src="ProductReviewControl.ascx" TagName="ProductReviewControl" TagPrefix="uc1" %>
<%@ Register Src="ProductChannelControl.ascx" TagName="ProductChannelControl" TagPrefix="uc1" %>
<%@ Register Src="RelatedProductControl.ascx" TagName="RelatedProductControl" TagPrefix="uc1" %>
<%@ Register Src="ProductAttributeControl.ascx" TagName="ProductAttributeControl" TagPrefix="uc1" %>
<%@ Register Src="ProductDynamicFormCodeControl.ascx" TagName="ProductDynamicFormCodeControl" TagPrefix="uc1" %>
<%@ Register Src="ProductAvailabilityRuleControl.ascx" TagName="ProductAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/XmlEditorControl.ascx" TagName="XmlEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
			jQuery('#ProductDetailsViewTabPanel').dnnTabs();
			jQuery("#DescriptionProductDetailsViewPanel").dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
        	jQuery('#ProductDetailsViewTabPanel').dnnTabs();
        	jQuery("#DescriptionProductDetailsViewPanel").dnnPanels();
        });
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<h2>Products</h2>
					<p>Products are representation of items that are listed for sale on your store. A product can be a bundle of items or can have many variations (e.g. black, brown and white shoes can be represented as a single product with variants).</p>
					<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
						<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
							<a href="#" class="dnnSectionExpanded">Search</a></h2>
						<fieldset class="rvdSplit2">
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="ProductSearchLabelControl" Text="Product/SKU:" HelpText="Enter product name or SKU to search."></dnn1:LabelControl>
								<asp:TextBox ID="ProductSearchTextBox" runat="server"></asp:TextBox>
							</div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl runat="server" ID="CategorySearchLabelControl" Text="Category:" ></dnn1:LabelControl>
                                <uc1:CategoryDropDownListControl ID="CategorySearchDropDownListControl" runat="server" ShowEmptyRoot="true" EmptyText="Any" />
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl runat="server" ID="ManufacturerSearchLabelControl" Text="Manufacturer:" ></dnn1:LabelControl>
                                <asp:DropDownList runat="server" ID="ManufacturerSearchDropDownList" ></asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl runat="server" ID="DistributorSearchLabelControl" Text="Distributor:" ></dnn1:LabelControl>
                                <asp:DropDownList runat="server" ID="DistributorSearchDropDownList" ></asp:DropDownList>
                            </div>
							<div class="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="InventoryLabelControl" Text="Inventory:" ></dnn1:LabelControl>
								<asp:DropDownList ID="InventorySearchDropDownList" runat="server">
									<asp:ListItem Text="Any" Value="0" />
									<asp:ListItem Text="Backorder - inventory backlog needed to fill order" Value="1" />
									<asp:ListItem Text="Empty - inventory has exhausted" Value="2" />
									<asp:ListItem Text="Understock - inventory is below min quantity" Value="3" />
									<asp:ListItem Text="Overstock - inventory is above max quantity" Value="4" />
									<asp:ListItem Text="Unspecified - inventory is unknown or infinite" Value="5" />
								</asp:DropDownList>
							</div>
							<asp:Panel ID="SellerSearchPanel" runat="server" CssClass="dnnFormItem">
								<dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
								<dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
							</asp:Panel>
							<div class="rvdActions">
								<asp:LinkButton ID="SearchLinkButton" runat="server" Text="Search" OnClick="SearchLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction" />
                                <asp:LinkButton ID="ResetLinkButton" runat="server" Text="Reset" OnClick="ResetLinkButton_Click" CausesValidation="false" CssClass="dnnSecondaryAction rvdResetAction" />
							</div>
						</fieldset>
					</asp:Panel>
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ProductID" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDeleting="ProductGridView_RowDeleting" OnRowDataBound="ProductGridView_RowDataBound" OnRowCommand="ProductGridView_RowCommand" OnDataBound="ProductGridView_DataBound">
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
										<asp:LinkButton ID="CloneLinkButton" runat="server" CommandName="Clone" CausesValidation="false" CssClass="rvdCopyGridAction" ToolTip="Clone" CommandArgument='<%# Eval("ProductID") %>'></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Image">
                                    <ItemTemplate>
                                        <asp:Image ID="ThumbnailImage" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
								<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
								<asp:CheckBoxField DataField="Published" HeaderText="Published" SortExpression="Published" />
								<asp:BoundField DataField="DisplayOrder" HeaderText="Display order" SortExpression="DisplayOrder" />
							</Columns>
							<PagerTemplate>
								<table style="width: 100%">
									<tr>
										<td>
											<table>
												<tr>
													<td>
														<asp:LinkButton ID="PagePreviousLinkButton" runat="server" CommandName="Page" CommandArgument="Prev" Text="..." /></td>
													<td>
														<asp:LinkButton ID="Page1LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="1" /></td>
													<td>
														<asp:LinkButton ID="Page2LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="2" /></td>
													<td>
														<asp:LinkButton ID="Page3LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="3" /></td>
													<td>
														<asp:LinkButton ID="Page4LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="4" /></td>
													<td>
														<asp:LinkButton ID="Page5LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="5" /></td>
													<td>
														<asp:LinkButton ID="Page6LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="6" /></td>
													<td>
														<asp:LinkButton ID="Page7LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="7" /></td>
													<td>
														<asp:LinkButton ID="Page8LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="8" /></td>
													<td>
														<asp:LinkButton ID="Page9LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="9" /></td>
													<td>
														<asp:LinkButton ID="Page10LinkButton" runat="server" CommandName="Page" CommandArgument="1" Text="10" /></td>
													<td>
														<asp:LinkButton ID="PageNextLinkButton" runat="server" CommandName="Page" CommandArgument="Next" Text="..." /></td>
												</tr>
											</table>
										</td>
										<td style="text-align: right">Page items:
											<asp:DropDownList ID="PageViewSizeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageViewSizeDropDownList_SelectedIndexChanged">
												<asp:ListItem Value="10">10</asp:ListItem>
												<asp:ListItem Value="20">20</asp:ListItem>
												<asp:ListItem Value="50">50</asp:ListItem>
												<asp:ListItem Value="100">100</asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
								</table>
							</PagerTemplate>
						</asp:GridView>
						<asp:ObjectDataSource ID="ProductObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductController" SortParameterName="sortExpression" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.Product" DeleteMethod="Delete">
							<SelectParameters>
								<asp:Parameter DefaultValue="" Name="sortExpression" Type="String" />
								<asp:Parameter DefaultValue="" Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
								<asp:ControlParameter ControlID="ProductSearchTextBox" Name="productSearch" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="CategorySearchDropDownListControl" Name="categoryID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="ManufacturerSearchDropDownList" Name="manufacturerID" PropertyName="SelectedValue" Type="Int32" />
                                <asp:ControlParameter ControlID="DistributorSearchDropDownList" Name="distributorID" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="InventorySearchDropDownList" Name="inventory" PropertyName="SelectedValue" Type="Int32" />
								<asp:ControlParameter ControlID="SellerSearchDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<ul class="dnnActions dnnClear">
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li>
								<asp:HyperLink ID="ImportHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportHyperLink" runat="server" Text="Export" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Product: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
					<div id="ProductDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= DescriptionDetailsViewPanel.ClientID %>">
								<asp:Label ID="DescriptionDetailsViewTabLabel" runat="server" Text="Description" /></a></li>
							<li ID="AttributeDetailsViewListItem" runat="server"><a href="#<%= AttributeDetailsViewPanel.ClientID %>">
								<asp:Label ID="AttributeDetailsViewTabLabel" runat="server" Text="Attribute" /></a></li>
							<li><a href="#<%= DisplayDetailsViewPanel.ClientID %>">
								<asp:Label ID="DisplayDetailsViewTabLabel" runat="server" Text="Display" /></a></li>
							<li><a href="#<%= CategoryDetailsViewPanel.ClientID %>">
								<asp:Label ID="CategoryDetailsViewTabLabel" runat="server" Text="Category" /></a></li>
							<li ID="AvailabilityDetailsViewListItem" runat="server"><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
								<asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
							<li><a href="#<%= GalleryDetailsViewPanel.ClientID %>">
								<asp:Label ID="GalleryDetailsViewTabLabel" runat="server" Text="Gallery" /></a></li>
							<li><a href="#<%= SEODetailsViewPanel.ClientID %>">
								<asp:Label ID="SEODetailsViewTabLabel" runat="server" Text="SEO" /></a></li>
							<li ID="RelatedDetailsViewListItem" runat="server"><a href="#<%= RelatedDetailsViewPanel.ClientID %>">
								<asp:Label ID="RelatedDetailsViewTabLabel" runat="server" Text="Related" /></a></li>
							<li ID="CrosssellDetailsViewListItem" runat="server"><a href="#<%= CrosssellDetailsViewPanel.ClientID %>">
								<asp:Label ID="CrosssellDetailsViewTabLabel" runat="server" Text="Cross-sell" /></a></li>
							<li ID="CustomFieldDetailsViewListItem" runat="server"><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
								<asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
							<li ID="ExtensionDetailsViewListItem" runat="server"><a href="#<%= ExtensionDetailsViewPanel.ClientID %>">
								<asp:Label ID="ExtensionDetailsViewTabLabel" runat="server" Text="Extension" /></a></li>
							<li ID="VariantGroupDetailsViewListItem" runat="server"><a href="#<%= VariantGroupDetailsViewPanel.ClientID %>">
								<asp:Label ID="VariantGroupDetailsViewTabLabel" runat="server" Text="Variant group" /></a></li>
							<li><a href="#<%= VariantDetailsViewPanel.ClientID %>">
								<asp:Label ID="VariantDetailsViewTabLabel" runat="server" Text="Variant" /></a></li>
							<li ID="ProductReviewDetailsViewListItem" runat="server"><a href="#<%= ProductReviewDetailsViewPanel.ClientID %>">
								<asp:Label ID="ProductReviewDetailsViewTabLabel" runat="server" Text="Review" /></a></li>
							<li ID="ProductChannelDetailsViewListItem" runat="server"><a href="#<%= ProductChannelDetailsViewPanel.ClientID %>">
								<asp:Label ID="ProductChannelDetailsViewTabLabel" runat="server" Text="Channel" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductIDLabelControl" runat="server" Text="Product ID:"></dnn1:LabelControl>
									<asp:Label ID="ProductIDLabel" runat="server"></asp:Label>
								</div>
								<asp:Panel ID="ProductKeyPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ProductKeyLabelControl" runat="server" Text="Product key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be your item name, SKU, any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="ProductKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ProductKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
								</asp:Panel>
								<asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
									<dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="This is the product name that will be displayed on your cart." Text="Name:" CssClass="dnnFormRequired" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
									<asp:TextBox ID="NameTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired" ></asp:TextBox>
								</div>
								<div class="dnnFormItem" style="display: none">
									<dnn1:LabelControl ID="ProductTypeLabelControl" runat="server" HelpText="Reserved for future use." Text="Product type:" />
									<asp:DropDownList ID="ProductTypeDropDownList" runat="server">
										<asp:ListItem Value="1">Regular</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BuyMethodLabelControl" runat="server" HelpText="Select which method to allow purchasing this product. If Internet method is unchecked, customers online will only be able to browse the product but they cannot purchase it." Text="Buy method:" />
									<div class="rvdFormCheckBoxes">
										<asp:CheckBox ID="AllowInternetOrderCheckBox" runat="server" Text="Internet" />
										<asp:CheckBox ID="AllowPhoneOrderCheckBox" runat="server" Text="Phone" />
									</div>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl runat="server" />
									<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable more features" CssClass="dnnTertiaryAction" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="DescriptionDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div id="DescriptionProductDetailsViewPanel" class="dnnForm">
									<h2 id="SummaryDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Summary</a>
									</h2>
									<fieldset>
										<dnn1:TextEditor ID="SummaryTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
									<h2 id="OverviewDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Overview</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="OverviewNameLabelControl" runat="server" HelpText="Override the description name or leave blank to use the default name." Text="Overview name:" />
											<asp:TextBox ID="OverviewNameTextBox" runat="server"></asp:TextBox>
										</div>
										<dnn1:TextEditor ID="OverviewTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
									<h2 id="SpecificationsDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Specifications</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="SpecificationsNameLabelControl" runat="server" HelpText="Override the description name or leave blank to use the default name." Text="Specifications name:" />
											<asp:TextBox ID="SpecificationsNameTextBox" runat="server"></asp:TextBox>
										</div>
										<dnn1:TextEditor ID="SpecificationsTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
									<h2 id="TermsDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Terms</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="TermsNameLabelControl" runat="server" HelpText="Override the description name or leave blank to use the default name." Text="Terms name:" />
											<asp:TextBox ID="TermsNameTextBox" runat="server"></asp:TextBox>
										</div>
										<dnn1:TextEditor ID="TermsTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
									<h2 id="FAQDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">FAQ</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="FAQNameLabelControl" runat="server" HelpText="Override the description name or leave blank to use the default name." Text="FAQ name:" />
											<asp:TextBox ID="FAQNameTextBox" runat="server"></asp:TextBox>
										</div>
										<dnn1:TextEditor ID="FAQTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
									<h2 id="BuyingGuideDescriptionSectionHead" class="dnnFormSectionHead">
										<a href="#" class="dnnSectionExpanded">Buying guide</a>
									</h2>
									<fieldset>
										<div class="dnnFormItem">
											<dnn1:LabelControl ID="BuyingGuideNameLabelControl" runat="server" HelpText="Override the description name or leave blank to use the default name." Text="Buying guide name:" />
											<asp:TextBox ID="BuyingGuideNameTextBox" runat="server"></asp:TextBox>
										</div>
										<dnn1:TextEditor ID="BuyingGuideTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="400px" Mode="RICH" />
									</fieldset>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="AttributeDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="ProductAttributeUnavailableLabel" runat="server" Text="Please save your product first before adding a product attribute." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:ProductAttributeControl ID="ProductAttributeControl1" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="DisplayDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PublishedLabelControl" runat="server" HelpText="Publish this item to customers." Text="Published:"></dnn1:LabelControl>
									<asp:CheckBox ID="PublishedCheckBox" runat="server" Checked="True" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DisplayTemplateLabelControl" runat="server" HelpText="The selected display template determines how to display the Product Detail module when this product is shown. Select a custom display template to associate to this product. Leave blank to use the default configuration template." Text="Display template:"></dnn1:LabelControl>
									<uc1:DisplayTemplateDropDownListControl ID="DisplayTemplateDropDownList" runat="server" />
									<asp:LinkButton ID="DisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="DisplayTemplateLinkButton_Click" CausesValidation="False" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductDetailUrlLabelControl" runat="server" Text="Product detail page:" HelpText="Specify a custom product detail page or use the default page if not specified." />
									<dnn1:UrlControl ID="ProductDetailUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="true" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowUsers="false"></dnn1:UrlControl>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RedirectUrlLabelControl" runat="server" Text="Redirect:" HelpText="Redirect product page to another location. Useful for cases where the product is no longer available for sale, but a substitute product exists or customer should see a different page to preserve link." />
									<dnn1:UrlControl ID="RedirectUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="true" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="true" ShowUsers="false"></dnn1:UrlControl>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin displaying product. Leave blank if product is available immediately." Text="Start date:" />
									<dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StopDateLabelControl" runat="server" HelpText="Enter a stop date (yyyy-mm-dd) to end displaying product. Leave blank if product is available perpetually." Text="Stop date:" />
									<dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowInventoryLabelControl" runat="server" Text="Show inventory:" />
									<asp:CheckBox ID="ShowInventoryCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowSKULabelControl" runat="server" Text="Show SKU:" />
									<asp:CheckBox ID="ShowSKUCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowPriceLabelControl" runat="server" Text="Show price:" />
									<asp:CheckBox ID="ShowPriceCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowQuantityLabelControl" runat="server" Text="Show quantity:" />
									<asp:CheckBox ID="ShowQuantityCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowMSRPLabelControl" runat="server" Text="Show MSRP:" />
									<asp:CheckBox ID="ShowMSRPCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowSavingsLabelControl" runat="server" Text="Show savings:" />
									<asp:CheckBox ID="ShowSavingsCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowRewardPointsLabelControl" runat="server" Text="Show reward points:" />
									<asp:CheckBox ID="ShowRewardPointsCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowAddToCartLabelControl" runat="server" Text="Show Add to Cart button:" />
									<asp:CheckBox ID="ShowAddToCartCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowBuyNowLabelControl" runat="server" Text="Show Buy Now button:" />
									<asp:CheckBox ID="ShowBuyNowCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowSeeDetailsLabelControl" runat="server" Text="Show See Details button:" />
									<asp:CheckBox ID="ShowSeeDetailsCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowAddToWishListLabelControl" runat="server" Text="Show Add to Wish List button:" />
									<asp:CheckBox ID="ShowAddToWishListCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowUpdateLabelControl" runat="server" Text="Show Update button:" />
									<asp:CheckBox ID="ShowUpdateCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShowSocialShareLabelControl" runat="server" Text="Show social share buttons:" />
									<asp:CheckBox ID="ShowSocialShareCheckBox" runat="server" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CategoryDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="FeaturedLabelControl" runat="server" HelpText="Display this item on product list even when no category is selected." Text="Featured:" />
									<asp:CheckBox ID="FeaturedCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="CategoriesLabelControl" runat="server" HelpText="Select the categories belonging to this product." Text="Categories:"></dnn1:LabelControl>
									<asp:HyperLink ID="EditCategoryHyperLink" runat="server" Text="Add new category" CssClass="rvdLinkAction" />
									<uc1:CategoryCheckBoxListControl ID="CategoryCheckBoxListControl1" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DefaultCategoryLabelControl" runat="server" HelpText="A default category is useful to help customers locate similar products. The default category is shown on the breadcrumb if customer arrived on the product detail page without selecting a category, manufacturer, distributor or coming from a search." Text="Default category:"></dnn1:LabelControl>
									<uc1:CategoryDropDownListControl ID="DefaultCategoryDropDownListControl" runat="server" ShowEmptyRoot="true" EmptyText="None"/>
								</div>
								<ul class="dnnActions dnnClear">
									<li>
										<asp:HyperLink ID="ImportProductCategoryHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
									</li>
									<li>
										<asp:HyperLink ID="ExportProductCategoryViewHyperLink" runat="server" Text="Export view" CssClass="dnnSecondaryAction rvdExportAction" />
									</li>
									<li>
										<asp:HyperLink ID="ExportProductCategoryAllHyperLink" runat="server" Text="Export all" CssClass="dnnSecondaryAction rvdExportAction" />
									</li>
								</ul>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:ProductAvailabilityRuleControl ID="AvailabilityRuleControl" runat="server" Width="100%" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="GalleryDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="GalleryUnavailableLabel" runat="server" Text="Please save your product first before adding a gallery item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:GalleryControl ID="GalleryControl1" runat="server"></uc1:GalleryControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="SEODetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UrlNameLabelControl" runat="server" HelpText="Specify a unique name that will appear in the URL slug for the product detail page. The name should contain meaningful keywords in lowercase. The product name will be used if this value is empty. A good set of keywords can help your page ranking in search results. E.g. A good URL name for &amp;quot;Apple iPad&amp;quot; product could be something like &amp;quot;apple ipad tablet&amp;quot; that will produce a nice clean URL http://a.com/product/apple-ipad-tablet." Text="URL name:" />
									<asp:TextBox ID="UrlNameTextBox" runat="server" MaxLength="400"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PageTitleLabelControl" runat="server" HelpText="Specify a custom page title for the product detail page. A good title can help your page ranking in search results." Text="Page title:" />
									<asp:TextBox ID="PageTitleTextBox" runat="server" MaxLength="400"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MetaKeywordsLabelControl" runat="server" HelpText="Specify META keywords for the product detail page." Text="Meta keywords:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="MetaKeywordsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ProductDetailsViewControl">Meta keywords is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="MetaKeywordsTextBox" runat="server" MaxLength="400" Rows="3" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MetaDescriptionLabelControl" runat="server" HelpText="Specify META description for the product detail page." Text="Meta description:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="MetaDescriptionTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ProductDetailsViewControl">Meta description is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="MetaDescriptionTextBox" runat="server" MaxLength="400" Rows="3" TextMode="MultiLine"></asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RelatedDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="RelatedProductUnavailableLabel" runat="server" Text="Please save your product first before adding a related product item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:RelatedProductControl ID="RelatedProductControl1" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CrosssellDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="CrosssellProductUnavailableLabel" runat="server" Text="Please save your product first before adding a cross-sell product." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:CrosssellProductControl ID="CrosssellProductControl1" runat="server"></uc1:CrosssellProductControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="CustomFieldDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:ProductDynamicFormCodeControl ID="DynamicFormCodeControl" runat="server" Width="100%" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ExtensionDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ExtensionLabelControl" runat="server" HelpText="Provide any custom data associated with this item using XML." Text="Extension:" />
									<uc1:XmlEditorControl ID="ExtensionXmlEditor" runat="server" Width="100%" ModuleControl="ProductExtension" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="VariantGroupDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="ProductVariantGroupUnavailableLabel" runat="server" Text="Please save your product first before adding a variant group." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:ProductVariantGroupControl ID="ProductVariantGroupControl1" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="VariantDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="ProductVariantUnavailableLabel" runat="server" Text="Please save your product first before adding a product variant item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:ProductVariantControl ID="ProductVariantControl1" runat="server"></uc1:ProductVariantControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ProductReviewDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AllowProductReviewLabelControl" runat="server" HelpText="Allow customers to enter product reviews and ratings." Text="Allow product review:" />
									<asp:CheckBox ID="AllowProductReviewCheckBox" runat="server" />
								</div>
								<uc1:ProductReviewControl ID="ProductReviewControl1" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ProductChannelDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:ProductChannelControl ID="ProductChannelControl1" runat="server" />
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductDetailsViewControl" />
							</li>
							<li>
								<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
							</li>
							<li>
								<asp:HyperLink ID="PreviewHyperLink" runat="server" Text="Preview" CssClass="dnnSecondaryAction rvdPreviewAction" Target="_blank" />
							</li>
						</ul>
					</div>
				</asp:View>
			</asp:MultiView>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
