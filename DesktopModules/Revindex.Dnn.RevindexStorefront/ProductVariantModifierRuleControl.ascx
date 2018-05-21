<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantModifierRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantModifierRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Modifier rule:" HelpText="Provide any price modification rule." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value=""></asp:ListItem>
		<asp:ListItem Text="Override price - customer enters price" Value="OverridePriceView"></asp:ListItem>
		<asp:ListItem Text="Configurable price - vary by custom fields" Value="ConfigurablePriceView"></asp:ListItem>
		<asp:ListItem Text="Tier price - vary by quantity, role..." Value="TierPriceView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="OverridePriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FieldIDOverridePriceLabelControl" runat="server" Text="Field ID:" HelpText="The ID of the custom field input control that the customer will use to enter the price." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="FieldIDOverridePriceRequiredFieldValidator" runat="server" ControlToValidate="FieldIDOverridePriceTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl" >Field ID is required.</asp:RequiredFieldValidator>
			<asp:RegularExpressionValidator ID="FieldIDOverridePriceRegularExpressionValidator" runat="server" ControlToValidate="FieldIDOverridePriceTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" Text="ID is invalid." ValidationGroup="FieldBasicDynamicFormDetailsViewControl" ValidationExpression="^[a-zA-Z][a-zA-Z0-9_]+$"></asp:RegularExpressionValidator>
			<asp:TextBox ID="FieldIDOverridePriceTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
	</asp:View>
	<asp:View ID="ConfigurablePriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinPriceFieldConfigurablePriceLabelControl" runat="server" Text="Minimum price:" HelpText="The price that will be charged if the calculated price is less than this minimum price." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MinPriceFieldConfigurablePriceRequiredFieldValidator" runat="server" ControlToValidate="MinPriceFieldConfigurablePriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl" >Minimum price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinPriceFieldConfigurablePriceDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FieldConfigurablePriceLabelControl" runat="server" Text="Adjustments:" HelpText="Adjust price based on field value." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="FieldConfigurablePriceMessagePlaceHolder" runat="server" />
				<asp:GridView ID="FieldConfigurablePriceGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID,Operator,Operand" OnRowDeleting="FieldConfigurablePriceGridView_RowDeleting" OnSelectedIndexChanged="FieldConfigurablePriceGridView_SelectedIndexChanged">
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
						<asp:BoundField DataField="ID" HeaderText="Field ID" />
						<asp:BoundField DataField="Operator" HeaderText="Operator" />
						<asp:BoundField DataField="Operand" HeaderText="Operand" />
						<asp:BoundField DataField="PriceAdjustment" HeaderText="Price adjustment" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddFieldConfigurablePriceLinkButton" runat="server" Text="Add new" OnClick="AddFieldConfigurablePriceLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="FieldConfigurablePriceDetailsViewPanel" runat="server">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="IDFieldConfigurablePriceDetailsViewLabelControl" runat="server" Text="Field ID:" HelpText="The ID of the custom field control to match." CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="IDFieldConfigurablePriceDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="IDFieldConfigurablePriceDetailsViewTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="FieldConfigurablePriceDetailsViewControl">Field ID is required.</asp:RequiredFieldValidator>
							<asp:TextBox ID="IDFieldConfigurablePriceDetailsViewTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="OperatorFieldConfigurablePriceDetailsViewLabelControl" runat="server" Text="Operator:" HelpText="The operation to perform comparison between the custom field and operand value." />
							<asp:DropDownList ID="OperatorFieldConfigurablePriceDetailsViewDropDownList" runat="server">
								<asp:ListItem Text="Equal" Value="equal" />
								<asp:ListItem Text="Greater than" Value="greaterthan" />
								<asp:ListItem Text="Greater than or equal" Value="greaterthanorequal" />
								<asp:ListItem Text="Is empty" Value="isempty" />
								<asp:ListItem Text="Is not empty" Value="isnotempty" />
								<asp:ListItem Text="Match" Value="match" />
								<asp:ListItem Text="Less than" Value="lessthan" />
								<asp:ListItem Text="Less than or equal" Value="lessthanorequal" />
								<asp:ListItem Text="Not equal" Value="notequal" />
								<asp:ListItem Text="Not match" Value="notmatch" />
							</asp:DropDownList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="OperandFieldConfigurablePriceDetailsViewLabelControl" runat="server" Text="Operand:" HelpText="The value to match." />
							<asp:TextBox ID="OperandFieldConfigurablePriceDetailsViewTextBox" runat="server" TextMode="MultiLine" Height="100px"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PriceAdjustmentFieldConfigurablePriceLabelControl" runat="server" Text="Price adjustment:" HelpText="The amount or percentage to adjust starting from the base price." CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="PriceAdjustmentFieldConfigurablePriceRequiredFieldValidator" runat="server" ControlToValidate="PriceAdjustmentFieldConfigurablePriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="FieldConfigurablePriceDetailsViewControl">Price adjustment is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="PriceAdjustmentFieldConfigurablePriceDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9">
							</dnn2:DnnNumericTextBox>
							<asp:DropDownList ID="PriceAdjustmentUnitFieldConfigurablePriceDropDownList" runat="server" CssClass="rvdUnitInput">
								<asp:ListItem Text="By amount" Value="amount" />
								<asp:ListItem Text="By percentage" Value="rate" />
							</asp:DropDownList>
						</div>
					</fieldset>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveFieldConfigurablePriceLinkButton" runat="server" Text="OK" OnClick="SaveFieldConfigurablePriceLinkButton_Click" ValidationGroup="FieldConfigurablePriceDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="TierPriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinPriceTierPriceLabelControl" runat="server" Text="Minimum price:" HelpText="The price that will be charged if the calculated price is less than this minimum price." />
			<asp:RequiredFieldValidator ID="MinPriceTierPriceRequiredFieldValidator" runat="server" ControlToValidate="MinPriceTierPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantDetailsViewControl" >Minimum price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MinPriceTierPriceDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RangeTierPriceLabelControl" runat="server" Text="Range:" HelpText="Price is calculated by finding the matching range to apply the price adjustment." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="RangeTierPriceMessagePlaceHolder" runat="server" />
				<asp:GridView ID="RangeTierPriceGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDeleting="RangeTierPriceGridView_RowDeleting" OnSelectedIndexChanged="RangeTierPriceGridView_SelectedIndexChanged">
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
						<asp:BoundField DataField="PriceAdjustment" HeaderText="Price adjustment" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRangeTierPriceLinkButton" runat="server" Text="Add new" OnClick="AddRangeTierPriceLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="RangeTierPriceDetailsViewPanel" runat="server">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityBeginRangeTierPriceDetailsViewLabelControl" runat="server" Text="Quantity begin:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityBeginRangeTierPriceDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityBeginRangeTierPriceDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierPriceDetailsViewControl">Quantity begin range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityBeginRangeTierPriceDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="QuantityEndRangeTierPriceDetailsViewLabelControl" runat="server" Text="Quantity end:" CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="QuantityEndRangeTierPriceDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="QuantityEndRangeTierPriceDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierPriceDetailsViewControl">Quantity end range is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="QuantityEndRangeTierPriceDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
							</dnn2:DnnNumericTextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleBehaviorRangeTierPriceDetailsLabelControl" runat="server" Text="Role match:" HelpText="Determine if rule is allowed or disallowed." />
							<asp:RadioButtonList ID="RoleBehaviorRangeTierPriceDetailsRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
								<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
								<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
							</asp:RadioButtonList>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="RoleRangeTierPriceDetailsLabelControl" runat="server" Text="Roles:" HelpText="Select the roles that should match. Use CTRL + mouse click to select multiple items." />
							<asp:ListBox ID="RoleRangeTierPriceDetailsListBox" runat="server" CssClass="rvdFormListBox" SelectionMode="Multiple">
							</asp:ListBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="PriceAdjustmentTierPriceDetailsViewLabelControl" runat="server" Text="Price adjustment:" HelpText="The amount or percentage to adjust starting from the base price." CssClass="dnnFormRequired"/>
							<asp:RequiredFieldValidator ID="PriceAdjustmentTierPriceDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="PriceAdjustmentTierPriceDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="RangeTierPriceDetailsViewControl">Price adjustment is required.</asp:RequiredFieldValidator>
							<dnn2:DnnNumericTextBox ID="PriceAdjustmentTierPriceDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9">
							</dnn2:DnnNumericTextBox>
							<asp:DropDownList ID="PriceAdjustmentUnitTierPriceDetailsViewDropDownList" runat="server" CssClass="rvdUnitInput">
								<asp:ListItem Text="By amount" Value="amount" />
								<asp:ListItem Text="By percentage" Value="rate" />
							</asp:DropDownList>
						</div>
					</fieldset>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRangeTierPriceLinkButton" runat="server" Text="OK" OnClick="SaveRangeTierPriceLinkButton_Click" ValidationGroup="RangeTierPriceDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ModifierRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="ModifierRuleFormulaEditor" runat="server" Width="100%" ModuleControl="ProductVariantModifier" />
		</div>
	</asp:View>
</asp:MultiView>