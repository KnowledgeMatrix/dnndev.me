<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SalesPromotionPromotionRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SalesPromotionPromotionRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<%@ Register Src="CategoryCheckBoxListControl.ascx" TagName="CategoryCheckBoxListControl" TagPrefix="uc1" %>
<%@ Register TagPrefix="dnn3" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<dnn3:DnnCssInclude runat="server" FilePath="../_default/WebControlSkin/Default/ComboBox.Default.css" PathNameAlias="SkinPath" />
<div class="dnnFormItem">
	<dnn1:LabelControl ID="PromotionTypeLabelControl" runat="server" Text="Promotion type:" HelpText="Select the type of promotion to apply." />
	<asp:DropDownList ID="PromotionTypeDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PromotionTypeDropDownList_SelectedIndexChanged">
		<asp:ListItem Value="1">Product - apply to product before add to cart</asp:ListItem>
		<asp:ListItem Value="2">Sales Order Detail - apply to each item in cart</asp:ListItem>
		<asp:ListItem Value="3">Shipping - apply to shipping checkout</asp:ListItem>
		<asp:ListItem Value="4">Handling - apply to handling checkout</asp:ListItem>
		<asp:ListItem Value="5">Tax - apply to tax checkout</asp:ListItem>
	</asp:DropDownList>
</div>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Promotion rule:" HelpText="Provide any promotion rule." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True" >
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatPriceProductView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PromotionPriceFlatPriceProductLabelControl" runat="server" Text="Promotion price:" HelpText="The fixed promotion price to charge." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="PromotionPriceFlatPriceProductRequiredFieldValidator" runat="server" ControlToValidate="PromotionPriceFlatPriceProductDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Promotion price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PromotionPriceFlatPriceProductDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountProductView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountProductLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountProductRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountProductDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountProductDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountProductDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="TierDiscountProductView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinPromotionPriceTierDiscountProductLabelControl" runat="server" Text="Minimum promotion price:" HelpText="The promotion price that will be charged if the calculated price is less than this minimum price." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinPromotionPriceTierDiscountProductRequiredFieldValidator" runat="server" ControlToValidate="MinPromotionPriceTierDiscountProductDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Minimum promotion price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinPromotionPriceTierDiscountProductDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierDiscountProductLabelControl" runat="server" Text="Range:" HelpText="Discount is calculated by finding the matching range." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="RangeTierDiscountProductMessagePlaceHolder" runat="server" />
				<asp:GridView ID="RangeTierDiscountProductGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDeleting="RangeTierDiscountProductGridView_RowDeleting" OnSelectedIndexChanged="RangeTierDiscountProductGridView_SelectedIndexChanged">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
						<asp:CommandField ShowSelectButton="True" SelectText="" ControlStyle-CssClass="rvdEditGridAction" />
						<asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="QuantityBegin" HeaderText="Qty Begin" />
						<asp:BoundField DataField="QuantityEnd" HeaderText="Qty End" />
						<asp:BoundField DataField="Categories" HeaderText="Categories" />
						<asp:BoundField DataField="Roles" HeaderText="Roles" />
						<asp:BoundField DataField="Discount" HeaderText="Discount" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRangeTierDiscountProductLinkButton" runat="server" Text="Add new" OnClick="AddRangeTierDiscountProductLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="RangeTierDiscountProductDetailsViewPanel" runat="server">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityBeginRangeTierDiscountProductDetailsViewLabelControl" runat="server" Text="Quantity begin:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityBeginRangeTierDiscountProductDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityBeginRangeTierDiscountProductDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierPriceDetailsViewControl">Quantity begin range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityBeginRangeTierDiscountProductDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityEndRangeTierDiscountProductDetailsViewLabelControl" runat="server" Text="Quantity end:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityEndRangeTierDiscountProductDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityEndRangeTierDiscountProductDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierDiscountProductDetailsViewControl">Quantity end range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityEndRangeTierDiscountProductDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CategoryBehaviorRangeTierDiscountProductDetailsLabelControl" runat="server" Text="Category match:" HelpText="Determine if rule is allowed or disallowed." />
							<asp:RadioButtonList ID="CategoryBehaviorRangeTierDiscountProductDetailsRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
								<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
								<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CategoryRangeTierDiscountProductDetailsLabelControl" runat="server" Text="Categories:" HelpText="Select the categories that should match." />
							<uc1:CategoryCheckBoxListControl ID="CategoryRangeTierDiscountProductDetailsCategoryCheckBoxListControl" runat="server" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleBehaviorRangeTierDiscountProductDetailsLabelControl" runat="server" Text="Role match:" HelpText="Determine if rule is allowed or disallowed." />
							<asp:RadioButtonList ID="RoleBehaviorRangeTierDiscountProductDetailsRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
								<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
								<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleRangeTierDiscountProductDetailsLabelControl" runat="server" Text="Roles:" HelpText="Select the roles that should match. Use CTRL + mouse click to select multiple items." />
							<asp:ListBox ID="RoleRangeTierDiscountProductDetailsListBox" runat="server" CssClass="rvdFormListBox" SelectionMode="Multiple">
							</asp:ListBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="DiscountTierDiscountDetailsViewLabelControl" runat="server" Text="Discount:" HelpText="The amount or percentage to discount from the price." CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="DiscountTierDiscountDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="DiscountTierDiscountDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierDiscountProductDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="DiscountTierDiscountDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9">
							</dnn2:DnnNumericTextBox>
							<asp:DropDownList ID="DiscountUnitTierDiscountDetailsViewDropDownList" runat="server" CssClass="rvdUnitInput">
								<asp:ListItem Text="By amount" Value="amount" />
								<asp:ListItem Text="By percentage" Value="rate" />
							</asp:DropDownList>
						</div>
					</fieldset>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRangeTierDiscountProductLinkButton" runat="server" Text="OK" OnClick="SaveRangeTierDiscountProductLinkButton_Click"  ValidationGroup="RangeTierDiscountProductDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountSalesOrderDetailView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountSalesOrderDetailLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountSalesOrderDetailRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountSalesOrderDetailDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountSalesOrderDetailDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountSalesOrderDetailDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponFlatDiscountSalesOrderDetailLabelControl" runat="server" Text="Require coupon:" HelpText="Select the coupon required to qualify for discount or leave empty." />
			<asp:DropDownList ID="CouponFlatDiscountSalesOrderDetailDropDownList" runat="server">
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductVariantBehaviorBasicAvailabilityLabelControl" runat="server" Text="Require product:" HelpText="Determine when the promotion is only applied to certain products in the cart. By default, the promotion will apply to all products." />
			<asp:RadioButtonList ID="ProductVariantBehaviorBasicAvailabilityRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Allow all except listed below" Value="exclusion" Selected="True" />
				<asp:ListItem Text="Allow only those listed below" Value="inclusion" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductVariantInclusionBasicAvailabilityLabelControl" runat="server" Text="Products" HelpText="Select the products that should match the condition."/>
			<div class="rvdFormSubContainer">
				<dnn2:DnnComboBox ID="ProductVariantInclusionBasicAvailabilityDnnComboBox" runat="server" AllowCustomText="True" CssClass="dnnFormRequired" EnableLoadOnDemand="True" OnItemsRequested="ProductVariantInclusionBasicAvailabilityDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="ProductVariantInclusionBasicAvailabilityDnnComboBox_SelectedIndexChanged">
				</dnn2:DnnComboBox>
				<asp:CheckBoxList ID="ProductVariantInclusionBasicAvailabilityCheckBoxList" runat="server"></asp:CheckBoxList>
				<asp:LinkButton ID="ExcludeProductVariantInclusionBasicAvailabilityLinkButton" runat="server" OnClick="ExcludeProductVariantInclusionBasicAvailabilityLinkButton_Click" CssClass="dnnPrimaryAction rvdDeleteAction" Text="Remove"></asp:LinkButton>
			</div>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountShippingView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountShippingLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountShippingRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountShippingDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountShippingDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountShippingDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponFlatDiscountShippingLabelControl" runat="server" Text="Require coupon:" HelpText="Select the coupon required to qualify for discount or leave empty." />
			<asp:DropDownList ID="CouponFlatDiscountShippingDropDownList" runat="server">
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountHandlingView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountHandlingLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountHandlingRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountHandlingDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountHandlingDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountHandlingDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponFlatDiscountHandlingLabelControl" runat="server" Text="Require coupon:" HelpText="Select the coupon required to qualify for discount or leave empty." />
			<asp:DropDownList ID="CouponFlatDiscountHandlingDropDownList" runat="server">
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountTaxView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountTaxLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountTaxRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountTaxDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="SalesPromotionDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountTaxDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountTaxDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponFlatDiscountTaxLabelControl" runat="server" Text="Require coupon:" HelpText="Select the coupon required to qualify for discount or leave empty." />
			<asp:DropDownList ID="CouponFlatDiscountTaxDropDownList" runat="server">
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PromotionRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="PromotionRuleFormulaEditor" runat="server" Width="100%" />
		</div>
	</asp:View>
</asp:MultiView>