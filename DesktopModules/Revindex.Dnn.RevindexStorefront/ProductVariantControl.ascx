<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="GalleryControl.ascx" TagName="GalleryControl" TagPrefix="uc1" %>
<%@ Register Src="ProductComponentControl.ascx" TagName="ProductComponentControl" TagPrefix="uc1" %>
<%@ Register Src="RequiredProductControl.ascx" TagName="RequiredProductControl" TagPrefix="uc1" %>
<%@ Register Src="TaxClassDropDownListControl.ascx" TagName="TaxClassDropDownListControl" TagPrefix="uc1" %>
<%@ Register Src="ProductDynamicFormCodeControl.ascx" TagName="ProductDynamicFormCodeControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantBookingRuleControl.ascx" TagName="ProductVariantBookingRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantPlaceOrderActionRuleControl.ascx" TagName="ProductVariantPlaceOrderActionRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantAvailabilityRuleControl.ascx" TagName="ProductVariantAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantModifierRuleControl.ascx" TagName="ProductVariantModifierRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ProductVariantSalesPromotionRuleControl.ascx" TagName="ProductVariantSalesPromotionRuleControl" TagPrefix="uc1" %>
<%@ Register Src="ProductAttributeControl.ascx" TagName="ProductAttributeControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/XmlEditorControl.ascx" TagName="XmlEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#ProductVariantDetailsViewTabPanel').dnnTabs();
			jQuery("#DescriptionProductVariantDetailsViewPanel").dnnPanels();
			jQuery("#<%= SingleProductVariantDetailsViewPanel.ClientID %>").dnnPanels();
        });
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#ProductVariantDetailsViewTabPanel').dnnTabs();
			jQuery("#DescriptionProductVariantDetailsViewPanel").dnnPanels();
			jQuery("#<%= SingleProductVariantDetailsViewPanel.ClientID %>").dnnPanels();
        });
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:MultiView ID="ContentMultiView" runat="server">
				<asp:View ID="ListView" runat="server">
					<div class="dnnForm rvdsfListContainer">
						<asp:GridView ID="ProductVariantGridView" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ProductVariantID" CssClass="dnnGrid" GridLines="None" AllowPaging="True" OnRowDeleting="ProductVariantGridView_RowDeleting" OnRowDataBound="ProductVariantGridView_RowDataBound" OnRowCommand="ProductVariantGridView_RowCommand" OnDataBound="ProductVariantGridView_DataBound">
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
										<asp:LinkButton ID="CloneLinkButton" runat="server" CommandName="Clone" CausesValidation="false" CssClass="rvdCopyGridAction" ToolTip="Clone" CommandArgument='<%# Eval("ProductVariantID") %>'></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
								<asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU" />
								<asp:CheckBoxField DataField="Published" HeaderText="Published" SortExpression="Published" />
								<asp:BoundField DataField="BasePrice" HeaderText="Base price" SortExpression="BasePrice" />
								<asp:BoundField DataField="DisplayOrder" HeaderText="Display order" SortExpression="DisplayOrder" />
							</Columns>
						</asp:GridView>
						<asp:ObjectDataSource ID="ProductVariantObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductVariantController" SortParameterName="sortExpression" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.ProductVariant" DeleteMethod="Delete">
							<SelectParameters>
								<asp:Parameter DefaultValue="" Name="sortExpression" Type="String" />
								<asp:Parameter DefaultValue="" Name="maximumRows" Type="Int32" />
								<asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
								<rvd1:UserControlParameter Name="productID" PropertyName="ProductID" Type="Int32" />
								<rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<asp:Panel ID="SingleProductVariantDetailsViewPanel" runat="server" Visible="false">
							<h2 id="SinglePriceSectionHead" class="dnnFormSectionHead"><a href="#" class="dnnSectionExpanded">Price</a></h2>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleProductVariantIDLabelControl" runat="server" Text="Product variant ID:"></dnn1:LabelControl>
									<asp:Label ID="SingleProductVariantIDLabel" runat="server"></asp:Label>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleSKULabelControl" runat="server" HelpText="Provide a unique SKU number for this product." Text="SKU:"></dnn1:LabelControl>
									<asp:RegularExpressionValidator ID="SingleSKURegularExpressionValidator" runat="server" ControlToValidate="SingleSKUTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductDetailsViewControl">SKU is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="SingleSKUTextBox" runat="server" Columns="50" MaxLength="50"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleSalesTypeLabelControl" runat="server" HelpText="Determine if product can be sold directly or must be quoted." Text="Sales type:" />
									<asp:DropDownList ID="SingleSalesTypeDropDownList" runat="server">
										<asp:ListItem Value="1">Direct sales - Customer can purchase item for the listed price</asp:ListItem>
										<asp:ListItem Value="2">Quote - Customer must request a quote for final price</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleBasePriceLabelControl" runat="server" HelpText="Enter the product base price without the money symbol. (e.g. 10.50)" Text="Base price:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="SingleBasePriceRequiredFieldValidator" runat="server" ControlToValidate="SingleBasePriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Base price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="SingleBasePriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleTaxClassLabelControl" runat="server" HelpText="If this product is taxable, select the appropriate tax class." Text="Tax class:" />
									<uc1:TaxClassDropDownListControl ID="SingleTaxClassDropDownList" runat="server"></uc1:TaxClassDropDownListControl>
								</div>
							</fieldset>
							<h2 id="SingleInventorySectionHead" class="dnnFormSectionHead"><a href="#" class="dnnSectionExpanded">Inventory</a></h2>
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleInventoryLabelControl" runat="server" HelpText="Empty value indicates unlimited inventory on hand." Text="Inventory:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="SingleInventoryDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SingleInventoryEmptyBehaviorLabelControl" runat="server" HelpText="How product should behave when inventory has exhausted." Text="Inventory behavior:"></dnn1:LabelControl>
									<asp:DropDownList ID="SingleInventoryEmptyBehaviorDropDownList" runat="server">
										<asp:ListItem Text="Disallow order - show product with out of stock message" Value="1" />
										<asp:ListItem Text="Disable product - hide product" Value="2" />
										<asp:ListItem Text="Allow backorder - allow product to be purchased" Value="3" />
									</asp:DropDownList>
								</div>
							</fieldset>
							<asp:Panel ID="SingleShippingDetailsViewPanel" runat="server">
								<h2 id="SingleShippingSectionHead" class="dnnFormSectionHead"><a href="#" class="dnnSectionExpanded">Shipping</a></h2>
								<fieldset>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SingleRequireShippingLabelControl" runat="server" HelpText="This product requires shipping." Text="Require shipping:"></dnn1:LabelControl>
										<asp:CheckBox ID="SingleRequireShippingCheckBox" runat="server"></asp:CheckBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SingleWeightLabelControl" runat="server" HelpText="Product weight, usually including its own packaging. This value could be used for shipping calculation." Text="Weight ({0}):" CssClass="dnnFormRequired"></dnn1:LabelControl>
										<asp:RequiredFieldValidator ID="SingleWeightRequiredFieldValidator" runat="server" ControlToValidate="SingleWeightDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Weight is required.</asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="SingleWeightDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
										</dnn2:DnnNumericTextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SingleWidthLabelControl" runat="server" Text="Width ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="SingleRequiredFieldValidator3" runat="server" ControlToValidate="SingleWidthDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="SingleWidthDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
										</dnn2:DnnNumericTextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SingleHeightLabelControl" runat="server" Text="Height ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="SingleRequiredFieldValidator7" runat="server" ControlToValidate="SingleHeightDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Height is required.</asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="SingleHeightDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
										</dnn2:DnnNumericTextBox>
									</div>
									<div class="dnnFormItem">
										<dnn1:LabelControl ID="SingleDepthLabelControl" runat="server" Text="Depth ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
										<asp:RequiredFieldValidator ID="SingleRequiredFieldValidator8" runat="server" ControlToValidate="SingleDepthDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductDetailsViewControl">Depth is required.</asp:RequiredFieldValidator>
										<dnn2:DnnNumericTextBox ID="SingleDepthDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
										</dnn2:DnnNumericTextBox>
									</div>
								</fieldset>
							</asp:Panel>
						</asp:Panel>
						<ul class="dnnActions dnnClear">
							<li id="EditSingleListItem" runat="server">
								<asp:HyperLink ID="EditSingleHyperLink" runat="server" Text="Edit details" CssClass="dnnPrimaryAction rvEditAction" /></li>
							<li>
								<asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new variation" CssClass="dnnPrimaryAction rvdAddNewAction" />
							</li>
							<li id="CloneSingleListItem" runat="server">
								<asp:LinkButton ID="CloneSingleLinkButton" runat="server" Text="Clone" CssClass="dnnSecondaryAction dnnCloneAction" OnClick="CloneSingleLinkButton_Click" CausesValidation="False"></asp:LinkButton></li>
							<li>
								<asp:HyperLink ID="ImportHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportViewHyperLink" runat="server" Text="Export view" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
							<li>
								<asp:HyperLink ID="ExportAllHyperLink" runat="server" Text="Export all" CssClass="dnnSecondaryAction rvdExportAction" />
							</li>
						</ul>
					</div>
				</asp:View>
				<asp:View ID="DetailsView" runat="server">
					<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
					<h2>Variant:
						<uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" />
					</h2>
					<div id="ProductVariantDetailsViewTabPanel" class="dnnForm">
						<ul class="dnnAdminTabNav dnnClear">
							<li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
								<asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
							<li><a href="#<%= DescriptionDetailsViewPanel.ClientID %>">
								<asp:Label ID="DescriptionDetailsViewTabLabel" runat="server" Text="Description" /></a></li>
							<li id="AttributeDetailsViewListItem" runat="server"><a href="#<%= AttributeDetailsViewPanel.ClientID %>">
								<asp:Label ID="AttributeDetailsViewTabLabel" runat="server" Text="Attribute" /></a></li>
							<li><a href="#<%= InventoryDetailsViewPanel.ClientID %>">
								<asp:Label ID="InventoryDetailsViewTabLabel" runat="server" Text="Inventory" /></a></li>
							<li><a href="#<%= PriceDetailsViewPanel.ClientID %>">
								<asp:Label ID="PriceDetailsViewTabLabel" runat="server" Text="Price" /></a></li>
							<li><a href="#<%= PromotionDetailsViewPanel.ClientID %>">
								<asp:Label ID="PromotionDetailsViewTabLabel" runat="server" Text="Promotion" /></a></li>
							<li id="RecurringDetailsViewListItem" runat="server"><a href="#<%= RecurringDetailsViewPanel.ClientID %>">
								<asp:Label ID="RecurringDetailsViewTabLabel" runat="server" Text="Recurring" /></a></li>
							<li id="BookingDetailsViewListItem" runat="server"><a href="#<%= BookingDetailsViewPanel.ClientID %>">
								<asp:Label ID="BookingDetailsViewTabLabel" runat="server" Text="Booking" /></a></li>
							<li id="ShippingDetailsViewListItem" runat="server"><a href="#<%= ShippingDetailsViewPanel.ClientID %>">
								<asp:Label ID="ShippingDetailsViewTabLabel" runat="server" Text="Shipping" /></a></li>
							<li id="HandlingDetailsViewListItem" runat="server"><a href="#<%= HandlingDetailsViewPanel.ClientID %>">
								<asp:Label ID="HandlingDetailsViewTabLabel" runat="server" Text="Handling" /></a></li>
							<li><a href="#<%= DisplayDetailsViewPanel.ClientID %>">
								<asp:Label ID="DisplayDetailsViewTabLabel" runat="server" Text="Display" /></a></li>
							<li id="AvailabilityDetailsViewListItem" runat="server"><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
								<asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
							<li><a href="#<%= GalleryDetailsViewPanel.ClientID %>">
								<asp:Label ID="GalleryDetailsViewTabLabel" runat="server" Text="Gallery" /></a></li>
							<li><a href="#<%= SEODetailsViewPanel.ClientID %>">
								<asp:Label ID="SEODetailsViewTabLabel" runat="server" Text="SEO" /></a></li>
							<li id="ComponentDetailsViewListItem" runat="server"><a href="#<%= ComponentDetailsViewPanel.ClientID %>">
								<asp:Label ID="ComponentDetailsViewTabLabel" runat="server" Text="Component" /></a></li>
							<li id="RequiredDetailsViewListItem" runat="server"><a href="#<%= RequiredDetailsViewPanel.ClientID %>">
								<asp:Label ID="RequiredDetailsViewTabLabel" runat="server" Text="Required" /></a></li>
							<li id="CustomFieldDetailsViewListItem" runat="server"><a href="#<%= CustomFieldDetailsViewPanel.ClientID %>">
								<asp:Label ID="CustomFieldDetailsViewTabLabel" runat="server" Text="Custom field" /></a></li>
							<li id="ExtensionDetailsViewListItem" runat="server"><a href="#<%= ExtensionDetailsViewPanel.ClientID %>">
								<asp:Label ID="ExtensionDetailsViewTabLabel" runat="server" Text="Extension" /></a></li>
							<li id="ActionDetailsViewListItem" runat="server"><a href="#<%= ActionDetailsViewPanel.ClientID %>">
								<asp:Label ID="ActionDetailsViewTabLabel" runat="server" Text="Action" /></a></li>
							<li id="RewardsPointDetailsViewListItem" runat="server"><a href="#<%= RewardsPointDetailsViewPanel.ClientID %>">
								<asp:Label ID="RewardsPointDetailsViewTabLabel" runat="server" Text="Reward" /></a></li>
							<li><a href="#<%= ResourceDetailsViewPanel.ClientID %>">
								<asp:Label ID="ResourceDetailsViewTabLabel" runat="server" Text="Resource" /></a></li>
						</ul>
						<asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductVariantIDLabelControl" runat="server" Text="Product variant ID:"></dnn1:LabelControl>
									<asp:Label ID="ProductVariantIDLabel" runat="server"></asp:Label>
								</div>
								<asp:Panel ID="ProductVariantKeyPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ProductVariantKeyLabelControl" runat="server" Text="Product variant key:" CssClass="dnnFormRequired" HelpText="Enter a key that uniquely identifies this item throughout the system. The key could be your item name, SKU, any short meaningful text or simply a GUID value as long as the value is unique. The key is useful for bulk import and programming automation to help refer back to this item." />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="ProductVariantKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">Key is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ProductVariantKeyTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="NameLabelControl" runat="server" HelpText="Provide optional variant name to describe this variation. (e.g. &quot;Small red&quot;)" Text="Name:"></dnn1:LabelControl>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="NameTextBox" runat="server" MaxLength="100" ></asp:TextBox>
								</div>
								<asp:Panel ID="ProductVariantOptionPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ProductVariantOptionLabelControl" runat="server" HelpText="Associate this variant to the available variant group combinations. For example, the customer will be able to choose Small size and Red color to purchase the associated variant. If you decide to use variant groups, you must ensure all your variants are associated to a variant group. Leave blank if you don't want it to be associated to a variant group combination and simply want to use the default variant selector." Text="Variant group:"></dnn1:LabelControl>
									<asp:DropDownList ID="ProductVariantOptionDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SKULabelControl" runat="server" HelpText="Provide a unique SKU number for this product." Text="SKU:"></dnn1:LabelControl>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="SKUTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">SKU is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="SKUTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<asp:Panel ID="ManufacturerSKUPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ManufacturerSKULabelControl" runat="server" HelpText="Provide the manufacturer's SKU number." Text="Manufacturer SKU:"></dnn1:LabelControl>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="ManufacturerSKUTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">Manufacturer SKU is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="ManufacturerSKUTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</asp:Panel>
								<asp:Panel ID="DistributorSKUPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="DistributorSKULabelControl" runat="server" HelpText="Provide the distributor's SKU number." Text="Distributor SKU:"></dnn1:LabelControl>
									<asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="DistributorSKUTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">Distributor SKU is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="DistributorSKUTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UniversalProductCodeLabelControl" runat="server" HelpText="Unique product identifier code such as ISBN, UPC barcode, EAN, etc." Text="Universal product code:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="UniversalProductCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ProductVariantDetailsViewControl">Universal product code is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="UniversalProductCodeTextBox" runat="server" MaxLength="100"></asp:TextBox>
								</div>
								<asp:Panel ID="ManufacturerPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="ManufacturerLabelControl" runat="server" HelpText="Associate this product with the manufacturer." Text="Manufacturer:"></dnn1:LabelControl>
									<asp:DropDownList ID="ManufacturerDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
								<asp:Panel ID="DistributorPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="DistributorLabelControl" runat="server" HelpText="Associate this product with the distributor." Text="Distributor:"></dnn1:LabelControl>
									<asp:DropDownList ID="DistributorDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
								<asp:Panel ID="WarehousePanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="WarehouseLabelControl" runat="server" HelpText="Associate this product with the warehouse where the product is shipped from. If you leave blank, the product is assumed to be shipped from your business address." Text="Warehouse:" />
									<asp:DropDownList ID="WarehouseDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl runat="server" />
									<asp:HyperLink ID="AddFeaturesHyperLink" runat="server" Text="+ Enable more features" CssClass="dnnTertiaryAction" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="DescriptionDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div id="DescriptionProductVariantDetailsViewPanel" class="dnnForm">
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
								<asp:Label ID="ProductAttributeUnavailableLabel" runat="server" Text="Please save your variant first before adding a product attribute." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:ProductAttributeControl ID="ProductAttributeControl1" runat="server" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="InventoryDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="InventoryLabelControl" runat="server" HelpText="Empty value indicates unlimited inventory on hand." Text="Inventory:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="InventoryDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinInventoryLabelControl" runat="server" HelpText="The minimum inventory is used to indicate when low inventory should be reported and reordered. Empty value indicates no minimum inventory." Text="Min inventory:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MinInventoryDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxInventoryLabelControl" runat="server" HelpText="The maximum inventory that should be reordered when inventory runs low. Empty value indicates unlimited inventory." Text="Max inventory:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MaxInventoryDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="InventoryEmptyBehaviorLabelControl" runat="server" HelpText="How product should behave when inventory has exhausted." Text="Inventory behavior:"></dnn1:LabelControl>
									<asp:DropDownList ID="InventoryEmptyBehaviorDropDownList" runat="server">
										<asp:ListItem Text="Disallow order - show product with out of stock message" Value="1" />
										<asp:ListItem Text="Disable product - hide product" Value="2" />
										<asp:ListItem Text="Allow backorder - allow product to be purchased" Value="3" />
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinOrderQuantityLabelControl" runat="server" HelpText="Empty value indicates no minimum order." Text="Min order quantity:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MinOrderQuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxOrderQuantityLabelControl" runat="server" HelpText="Empty value indicates unlimited order." Text="Max order quantity:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MaxOrderQuantityDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
                                <div class="dnnFormItem">
									<dnn1:LabelControl ID="AllowableOrderQuantityLabelControl" runat="server" HelpText="Enter the quantities you want to allow, separated by a pipe &quot;|&quot; delimiter. Use a dash to denote a range of quantities. For example, if you enter &quot;1|3|5-7|9&quot; in the text box, only quantities 1, 3, 5, 6, 7 and 9 will be allowed" Text="Allowable order quantity:"></dnn1:LabelControl>
                                    <asp:RegularExpressionValidator ID="AllowableOrderQuantityRegularExpressionValidator" runat="server" ControlToValidate="AllowableOrderQuantityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^(?!([ \d]*-){2})\d+(?: *[-|] *\d+)*$" ValidationGroup="ProductVariantDetailsViewControl">Allowed order quantity is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="AllowableOrderQuantityTextBox" runat="server">
									</asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="PriceDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="SalesTypeLabelControl" runat="server" HelpText="Determine if product can be sold directly or must be quoted." Text="Sales type:" />
									<asp:DropDownList ID="SalesTypeDropDownList" runat="server">
										<asp:ListItem Value="1">Direct sales - Customer can purchase item for the listed price</asp:ListItem>
										<asp:ListItem Value="2">Quote - Customer must request a quote for final price</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="BasePriceLabelControl" runat="server" HelpText="Enter the product base price without the money symbol. (e.g. 10.50)" Text="Base price:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="BasePriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Base price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="BasePriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<uc1:ProductVariantModifierRuleControl ID="ModifierRuleControl" runat="server" Width="100%" />
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PriceTextLabelControl" runat="server" HelpText="Any text entered here will be shown in place of the actual price. For example, you can override the price label to show &quot;Call for price&quot; or &quot;See price at checkout&quot;. Custom price text is often used for sales over telephone or to prevent price comparison sites from robot scraping your price information. Some manufacturers may even place restrictions on how prices should be displayed especially if the selling price is below the manufacturer's minimum advertised price." Text="Price text:"></dnn1:LabelControl>
									<asp:TextBox ID="PriceTextTextBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MSRPLabelControl" runat="server" HelpText="Provide the manufacturer suggested retail price." Text="MSRP:" />
									<dnn2:DnnNumericTextBox ID="MSRPDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ProductCostLabelControl" runat="server" HelpText="Provide the actual cost of this product." Text="Product cost:" />
									<dnn2:DnnNumericTextBox ID="ProductCostDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="TaxClassLabelControl" runat="server" HelpText="If this product is taxable, select the appropriate tax class." Text="Tax class:" />
									<uc1:TaxClassDropDownListControl ID="TaxClassDropDownList" runat="server"></uc1:TaxClassDropDownListControl>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="PromotionDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PromotionStartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin running promotion. Leave blank if promotion is available immediately." Text="Promotion start date:" />
									<dnn2:DnnDateTimePicker ID="PromotionStartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PromotionStopDateLabelControl" runat="server" HelpText="Enter a stop date (yyyy-mm-dd) to end running promotion. Leave blank if promotion is available perpetually." Text="Promotion stop date:" />
									<dnn2:DnnDateTimePicker ID="PromotionStopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<uc1:ProductVariantSalesPromotionRuleControl ID="PromotionRuleControl" runat="server" Width="100%" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RecurringDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringLabelControl" runat="server" HelpText="If this is a recurring product, enter the recurring interval. Zero indicates non-recurring." Text="Recurring:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="RecurringIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Recurring interval is required.</asp:RequiredFieldValidator>
									<asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="RecurringIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="365" MinimumValue="0" Type="Double" ValidationGroup="ProductVariantDetailsViewControl">Recurring interval is invalid.</asp:RangeValidator>
									<asp:TextBox ID="RecurringIntervalTextBox" runat="server" CssClass="dnnFormRequired rvdQuantityInput">0</asp:TextBox>
									<asp:DropDownList ID="RecurringIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
										<asp:ListItem Value="1">Day</asp:ListItem>
										<asp:ListItem Value="2">Week</asp:ListItem>
										<asp:ListItem Value="3">Month</asp:ListItem>
										<asp:ListItem Value="4">Year</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StartRecurringDateTypeLabelControl" runat="server" EnableViewState="False" HelpText="By default, the first recurring date is calculated from one recurring interval added to the order date. For example, if your recurring interval is every 1 month and the user purchased this product on Jan 1st, the first reocurrence will start on Feb 1st. You can initialize a different recurring start date by entering a date value or a non-zero interval value. For example, you can enter an interval of 14 days and it will only start the first recurring after 14 days have elapsed from the order date." Text="Start recurring date:" />
									<asp:RadioButtonList ID="StartRecurringDateTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="StartRecurringDateTypeRadioButtonList_SelectedIndexChanged" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
										<asp:ListItem Text="Fixed date" Value="Fixed date" Selected="True"></asp:ListItem>
										<asp:ListItem Text="Interval" Value="Interval"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StartRecurringDateLabelControl" runat="server" EnableViewState="False" HelpText="Leave date blank or a zero interval value to use the default next recurring date." Text="" />
									<asp:MultiView ID="StartRecurringDateTypeMultiView" runat="server" ActiveViewIndex="0">
										<asp:View ID="FixedStartRecurringDateView" runat="server">
											<dnn2:DnnDatePicker ID="StartRecurringDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
											</dnn2:DnnDatePicker>
										</asp:View>
										<asp:View ID="StartRecurringIntervalView" runat="server">
											<asp:RequiredFieldValidator ID="StartRecurringRequiredFieldValidator" runat="server" ControlToValidate="StartRecurringIntervalDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RequiredProductDetailsViewControl">Start recurring interval is required.</asp:RequiredFieldValidator>
											<dnn2:DnnNumericTextBox ID="StartRecurringIntervalDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Value="0">
											</dnn2:DnnNumericTextBox>
											<asp:DropDownList ID="StartRecurringIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
												<asp:ListItem Value="1">Day</asp:ListItem>
												<asp:ListItem Value="2">Week</asp:ListItem>
												<asp:ListItem Value="3">Month</asp:ListItem>
												<asp:ListItem Value="4">Year</asp:ListItem>
											</asp:DropDownList>
										</asp:View>
									</asp:MultiView>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringMinRepeatLabelControl" runat="server" HelpText="If this is a recurring product, optionally enter the minimum number of times that must be repeated before allowing customers from cancelling future recurring orders. E.g. If this is a 12-month program and you don't want to give the customer the option to cancel before the 12 months have elapsed, you should enter 11 to repeat for the remaining 11 times excluding the initial order." Text="Recurring min repeat:" />
									<dnn2:DnnNumericTextBox ID="RecurringMinRepeatDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RecurringMaxRepeatLabelControl" runat="server" HelpText="If this is a recurring product, enter the maximum number of times to repeat or leave field blank to repeat perpetually. E.g. If this is a 12-month program, you should enter 11 to repeat for the remaining 11 times excluding the initial order." Text="Recurring max repeat:" />
									<dnn2:DnnNumericTextBox ID="RecurringMaxRepeatDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AllowRecurringGroupOrdersLabelControl" runat="server" HelpText="If this is a recurring product, allow this variant to be grouped with other recurring sales orders that are repeating on the same time with the same shipping and payment to reduce shipping cost and payment transaction fees." Text="Allow grouping recurring orders:" />
									<asp:CheckBox ID="AllowRecurringGroupOrdersCheckBox" runat="server" />
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PreorderLabelControl" runat="server" HelpText="If this is a recurring product that requires the order to be prepared in advanced on the next renewal such that the customer can be invoiced ahead of time for payment, enter the preorder days calculated ahead of the next recurring date. Zero indicates no advanced preordering is required. E.g. if you enter 10 days, the order will be prepared 10 days before the actual recurring is due." Text="Preorder days ahead:" CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="PreorderIntervalRequiredFieldValidator" runat="server" ControlToValidate="PreorderIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Preorder interval is required.</asp:RequiredFieldValidator>
									<asp:RangeValidator ID="PreorderIntervalRangeValidator" runat="server" ControlToValidate="PreorderIntervalTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="365" MinimumValue="0" Type="Double" ValidationGroup="ProductVariantDetailsViewControl">Preorder interval is invalid.</asp:RangeValidator>
									<asp:TextBox ID="PreorderIntervalTextBox" runat="server" CssClass="dnnFormRequired rvdQuantityInput">0</asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="BookingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="InventoryUnitTypeLabelControl" runat="server" HelpText="Indicate how inventory is treated." Text="Unit type:"></dnn1:LabelControl>
									<asp:DropDownList ID="InventoryUnitTypeDropDownList" runat="server">
										<asp:ListItem Text="Constant - Inventory is a regular non-booking product" Value="1" />
										<asp:ListItem Text="Year - Inventory is reserved per year" Value="2" />
										<asp:ListItem Text="Month - Inventory is reserved per month" Value="3" />
										<asp:ListItem Text="Week - Inventory is reserved per week" Value="4" />
										<asp:ListItem Text="Day - Inventory is reserved per day" Value="5" />
										<asp:ListItem Text="Hour - Inventory is reserved per hour" Value="6" />
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinOrderUnitLabelControl" runat="server" HelpText="Empty value indicates no minimum unit per booking. For example, if you set a value of 5 and the unit type is Day, then the customer must select a date range of 5 days or more."  Text="Min order unit:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MinOrderUnitDnnNumericTextBox" runat="server" Skin="" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxOrderUnitLabelControl" runat="server" HelpText="Empty value indicates no maximum units per booking. For example, if you set a value of 5 and the unit type is Day, then the customer must select a date range of 5 days or less."  Text="Max order unit:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="MaxOrderUnitDnnNumericTextBox" runat="server" Skin="" Value="1" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
									</dnn2:DnnNumericTextBox>
								</div>							
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinBookingDateLabelControl" runat="server" HelpText="The minimum selectable date range in the calendar. Empty value will default to today's date."  Text="Min date:"></dnn1:LabelControl>
									<dnn2:DnnDateTimePicker ID="MinBookingDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD" CssClass="rvdDateTimeInput" TimePopupButton-Visible="False">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxBookingDateLabelControl" runat="server" HelpText="The maximum selectable date range in the calendar. Empty value will default to maximum of 2 years ahead from today's date."  Text="Max date:"></dnn1:LabelControl>
									<dnn2:DnnDateTimePicker ID="MaxBookingDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD" CssClass="rvdDateTimeInput" TimePopupButton-Visible="False">
									</dnn2:DnnDateTimePicker>
								</div>
								<uc1:ProductVariantBookingRuleControl ID="ProductVariantBookingRuleControl" runat="server" />
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MinBookingTimeLabelControl" runat="server" HelpText="The minimum selectable time range in the calendar. Empty value indicates no minimum time enforced."  Text="Min time:"></dnn1:LabelControl>
									<dnn2:DnnTimePicker ID="MinBookingTimeDnnTimePicker" runat="server" DateInput-DateFormat="HH:00" DateInput-EmptyMessage="HH:00"/>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MaxBookingTimeLabelControl" runat="server" HelpText="The maximum selectable time range in the calendar. Empty value indicates no maximum time enforced."  Text="Max time:"></dnn1:LabelControl>
									<dnn2:DnnTimePicker ID="MaxBookingTimeDnnTimePicker" runat="server" DateInput-DateFormat="HH:00" DateInput-EmptyMessage="HH:00"/>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ShippingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequireShippingLabelControl" runat="server" HelpText="This product requires shipping." Text="Require shipping:"></dnn1:LabelControl>
									<asp:CheckBox ID="RequireShippingCheckBox" runat="server"></asp:CheckBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="WeightLabelControl" runat="server" HelpText="Product weight, usually including its own packaging. This value could be used for shipping calculation." Text="Weight ({0}):" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="WeightDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Weight is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="WeightDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="WidthLabelControl" runat="server" Text="Width ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="WidthDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="WidthDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HeightLabelControl" runat="server" Text="Height ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="HeightDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Height is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="HeightDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DepthLabelControl" runat="server" Text="Depth ({0}):" HelpText="Product dimension usually including its own packaging. These values may be used in shipping calculation." CssClass="dnnFormRequired" />
									<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="DepthDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Depth is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DepthDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.0000" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PackageTypeLabelControl" runat="server" Text="Package type:" HelpText="Specify the shipping package type used for shipping calculation. Do not specify a package type if you have trouble returning shipping rates as certain shipping providers may not support every type of shipping package." />
									<asp:DropDownList ID="PackageTypeDropDownList" runat="server">
										<asp:ListItem Value="3000" Text="Bag"></asp:ListItem>
										<asp:ListItem Value="2000" Text="Box"></asp:ListItem>
										<asp:ListItem Value="1000" Text="Envelope"></asp:ListItem>
										<asp:ListItem Value="4000" Text="Tube"></asp:ListItem>
										<asp:ListItem Value="1" Text="Unspecified"></asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingPriceLabelControl" runat="server" HelpText="This value is not used unless your configured shipping method rules require it to calculate the shipping amount by individual product. Enter the shipping price without the money symbol. (e.g. 10.50)." Text="Shipping price:"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="ShippingPriceRequiredFieldValidator" runat="server" ControlToValidate="ShippingPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Shipping price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="ShippingPriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="ShippingCodeLabelControl" runat="server" Text="Shipping code:" HelpText="Shipping code may be used by your shipping provider to classify this package to obtain a more accurate quote. Leave blank if you don't have a shipping code. For example, the freight class code 50, as governed by the NMFC, indicates the package is durable enough to fit on a 4x4 pallet." />
									<asp:TextBox ID="ShippingCodeTextBox" runat="server" MaxLength="50"></asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="HandlingDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RequireHandlingLabelControl" runat="server" HelpText="This product requires handling." Text="Require handling:"></dnn1:LabelControl>
									<asp:CheckBox ID="RequireHandlingCheckBox" runat="server"></asp:CheckBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="HandlingPriceLabelControl" runat="server" HelpText="This value is not used unless your configured handling method rules require it to calculate the handling amount by individual product. Enter the handling price without the money symbol. (e.g. 10.50)." Text="Handling price:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="HandlingPriceRequiredFieldValidator" runat="server" ControlToValidate="HandlingPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Handling price is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="HandlingPriceDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="DisplayDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PublishedLabelControl" runat="server" HelpText="Publish this item to customers." Text="Published:" />
									<asp:CheckBox ID="PublishedCheckBox" runat="server" Checked="True"></asp:CheckBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin displaying product. Leave blank if product is available immediately." Text="Start date:" />
									<dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="StopDateLabelControl" runat="server" HelpText="Enter a stop date (yyyy-mm-dd) to end displaying product. Leave blank if product is available perpetually." Text="Stop date:"></dnn1:LabelControl>
									<dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
									</dnn2:DnnDateTimePicker>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DisplayOrderLabelControl" runat="server" HelpText="Sort the item for display by lowest to highest number starting from zero." Text="Display order:" CssClass="dnnFormRequired"></dnn1:LabelControl>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DisplayOrderDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Display order is required.</asp:RequiredFieldValidator>
									<dnn2:DnnNumericTextBox ID="DisplayOrderDnnNumericTextBox" runat="server" Skin="" Value="1000" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" CssClass="dnnFormRequired">
									</dnn2:DnnNumericTextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AllowProductComparisonLabelControl" runat="server" HelpText="Allow this product to be compared with others." Text="Allow product comparison:" />
									<asp:CheckBox ID="AllowProductComparisonCheckBox" runat="server" Checked="True"></asp:CheckBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:ProductVariantAvailabilityRuleControl ID="AvailabilityRuleControl" runat="server" Width="100%" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="GalleryDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="GalleryUnavailableLabel" runat="server" Text="Please save your variant first before adding a gallery item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:GalleryControl ID="GalleryControl1" runat="server"></uc1:GalleryControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="SEODetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="UrlNameLabelControl" runat="server" HelpText="Specify a unique name that will appear in the URL slug for the product detail page. The name should contain meaningful keywords in lowercase. The product name will be used if this value is empty. A good set of keywords can help your page ranking in search results. E.g. A good URL name for &amp;quot;Apple iPad&amp;quot; product could be something like &amp;quot;apple ipad tablet&amp;quot; that will produce a nice clean URL http://a.com/product/apple-ipad-tablet with good searchable keywords." Text="URL name:" />
									<asp:TextBox ID="UrlNameTextBox" runat="server" MaxLength="400"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="PageTitleLabelControl" runat="server" HelpText="Specify a custom page title for the product detail page. A good title can help your page ranking in search results." Text="Page title:" />
									<asp:TextBox ID="PageTitleTextBox" runat="server" MaxLength="400"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MetaKeywordsLabelControl" runat="server" HelpText="Specify META keywords for the product detail page." Text="Meta keywords:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="MetaKeywordsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ProductVariantDetailsViewControl">Meta keywords is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="MetaKeywordsTextBox" runat="server" MaxLength="400" Rows="3" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="MetaDescriptionLabelControl" runat="server" HelpText="Specify META description for the product detail page." Text="Meta description:" />
									<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="MetaDescriptionTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\s\S]{0,400}$" ValidationGroup="ProductVariantDetailsViewControl">Meta description is invalid.</asp:RegularExpressionValidator>
									<asp:TextBox ID="MetaDescriptionTextBox" runat="server" MaxLength="400" Rows="3" TextMode="MultiLine"></asp:TextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ComponentDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="ProductComponentUnavailableLabel" runat="server" Text="Please save your variant first before adding a product component item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:ProductComponentControl ID="ProductComponentControl1" runat="server"></uc1:ProductComponentControl>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RequiredDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Label ID="RequiredProductUnavailableLabel" runat="server" Text="Please save your variant first before adding a required product item." CssClass="dnnFormMessage dnnFormInfo"></asp:Label>
								<uc1:RequiredProductControl ID="RequiredProductControl1" runat="server"></uc1:RequiredProductControl>
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
									<dnn1:LabelControl ID="ExtensionLabelControl" runat="server" HelpText="Provide any custom data associated with this product using XML." Text="Extension:"></dnn1:LabelControl>
									<uc1:XmlEditorControl ID="ExtensionXmlEditor" runat="server" Width="100%" ModuleControl="ProductVariantExtension" />
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ActionDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<uc1:ProductVariantPlaceOrderActionRuleControl ID="PlaceOrderActionRuleControl" runat="server" Width="100%" />
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="RewardsPointDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="AllowRewardsPointLabelControl" runat="server" HelpText="Allow this product to participate in rewards point program." Text="Allow rewards point:" />
									<asp:CheckBox ID="AllowRewardsPointCheckBox" runat="server" Checked="True"></asp:CheckBox>
								</div>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="RewardPointsLabelControl" runat="server" HelpText="By default, if unspecified, the number of points awarded for the purchase of this product is based on the selling price after any discount. You can specify a different number of points to award or leave blank to use the default." Text="Reward points:"></dnn1:LabelControl>
									<dnn2:DnnNumericTextBox ID="RewardPointsDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" MinValue="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
									</dnn2:DnnNumericTextBox>
								</div>
							</fieldset>
						</asp:Panel>
						<asp:Panel ID="ResourceDetailsViewPanel" runat="server" CssClass="dnnClear">
							<fieldset>
								<asp:Panel ID="VoucherDefinitionPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="VoucherDefinitionLabelControl" runat="server" HelpText="Associate this product with the voucher definition to automatically issue a new voucher to customer upon purchase." Text="Voucher:"></dnn1:LabelControl>
									<asp:DropDownList ID="VoucherDefinitionDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
								<div class="dnnFormItem">
									<dnn1:LabelControl ID="DownloadFileLabelControl" runat="server" HelpText="Provide download file location if this is a virtual product or has a downloadable item." Text="Download file:"></dnn1:LabelControl>
									<asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
										<ContentTemplate>
											<dnn1:UrlControl ID="DownloadFileUrlControl" runat="server" ShowDatabase="true" ShowFiles="true" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="true" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="true" ShowUrls="True" ShowUsers="false"></dnn1:UrlControl>
										</ContentTemplate>
									</asp:UpdatePanel>
								</div>
								<asp:Panel ID="RightDefinitionPanel" runat="server" CssClass="dnnFormItem">
									<dnn1:LabelControl ID="RightDefinitionLabelControl" runat="server" HelpText="Automatically grant rights such as license key or serial number to customer upon purchase." Text="Rights:"></dnn1:LabelControl>
									<asp:DropDownList ID="RightDefinitionDropDownList" runat="server">
									</asp:DropDownList>
								</asp:Panel>
							</fieldset>
						</asp:Panel>
					</div>
					<div class="dnnForm">
						<ul class="dnnActions">
							<li>
								<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductVariantDetailsViewControl" />
							</li>
							<li>
								<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductVariantDetailsViewControl" />
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
