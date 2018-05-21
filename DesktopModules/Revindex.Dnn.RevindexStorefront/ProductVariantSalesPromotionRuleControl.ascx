<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantSalesPromotionRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantSalesPromotionRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Promotion rule:" HelpText="Provide any price promotion rule." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value=""></asp:ListItem>
		<asp:ListItem Text="Flat price - fixed promotion price" Value="FlatPriceView"></asp:ListItem>
		<asp:ListItem Text="Flat discount - discount by amount or rate" Value="FlatDiscountView"></asp:ListItem>
		<asp:ListItem Text="Tier discount - discount by quantity, role..." Value="TierDiscountView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatPriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PromotionPriceFlatPriceLabelControl" runat="server" Text="Promotion price:" HelpText="The fixed promotion price to charge." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="PromotionPriceFlatPriceRequiredFieldValidator" runat="server" ControlToValidate="PromotionPriceFlatPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Promotion price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PromotionPriceFlatPriceDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatDiscountView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DiscountAmountFlatDiscountLabelControl" runat="server" Text="Discount:" HelpText="Enter the amount or percentage to discount." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DiscountAmountFlatDiscountRequiredFieldValidator" runat="server" ControlToValidate="DiscountAmountFlatDiscountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DiscountAmountFlatDiscountDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox><asp:DropDownList ID="DiscountAmountUnitFlatDiscountDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="TierDiscountView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinPromotionPriceTierDiscountLabelControl" runat="server" Text="Minimum promotion price:" HelpText="The promotion price that will be charged if the calculated price is less than this minimum price." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinPromotionPriceTierDiscountRequiredFieldValidator" runat="server" ControlToValidate="MinPromotionPriceTierDiscountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl">Minimum promotion price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinPromotionPriceTierDiscountDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierDiscounteLabelControl" runat="server" Text="Range:" HelpText="Discount is calculated by finding the matching range." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="RangeTierDiscountMessagePlaceHolder" runat="server" />
				<asp:GridView ID="RangeTierDiscountGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDeleting="RangeTierDiscountGridView_RowDeleting" OnSelectedIndexChanged="RangeTierDiscountGridView_SelectedIndexChanged">
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
						<asp:BoundField DataField="Roles" HeaderText="Roles" />
						<asp:BoundField DataField="Discount" HeaderText="Discount" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRangeTierDiscountLinkButton" runat="server" Text="Add new" OnClick="AddRangeTierDiscountLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="RangeTierDiscountDetailsViewPanel" runat="server">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityBeginRangeTierDiscountDetailsViewLabelControl" runat="server" Text="Quantity begin:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityBeginRangeTierDiscountDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityBeginRangeTierDiscountDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierPriceDetailsViewControl">Quantity begin range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityBeginRangeTierDiscountDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityEndRangeTierDiscountDetailsViewLabelControl" runat="server" Text="Quantity end:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityEndRangeTierDiscountDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityEndRangeTierDiscountDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierDiscountDetailsViewControl">Quantity end range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityEndRangeTierDiscountDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleBehaviorRangeTierDiscountDetailsLabelControl" runat="server" Text="Role match:" HelpText="Determine if rule is allowed or disallowed." />
							<asp:RadioButtonList ID="RoleBehaviorRangeTierDiscountDetailsRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
								<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
								<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleRangeTierDiscountDetailsLabelControl" runat="server" Text="Roles:" HelpText="Select the roles that should match. Use CTRL + mouse click to select multiple items." />
							<asp:ListBox ID="RoleRangeTierDiscountDetailsListBox" runat="server" CssClass="rvdFormListBox" SelectionMode="Multiple">
							</asp:ListBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="DiscountTierDiscountDetailsViewLabelControl" runat="server" Text="Discount:" HelpText="The amount or percentage to discount from the price." CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="DiscountTierDiscountDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="DiscountTierDiscountDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierDiscountDetailsViewControl">Discount is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="DiscountTierDiscountDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9">
							</dnn2:DnnNumericTextBox>
							<asp:DropDownList ID="DiscountUnitTierDiscountDetailsViewDropDownList" runat="server" CssClass="rvdUnitInput">
								<asp:ListItem Text="By amount" Value="amount" />
								<asp:ListItem Text="By percentage" Value="rate" />
							</asp:DropDownList>
						</div>
					</fieldset>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRangeTierDiscountLinkButton" runat="server" Text="OK" OnClick="SaveRangeTierDiscountLinkButton_Click" ValidationGroup="RangeTierDiscountDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RateRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="RateRuleFormulaEditor" runat="server" Width="100%" ModuleControl="ProductVariantSalesPromotion" />
		</div>
	</asp:View>
</asp:MultiView>