<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CouponAvailabilityRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CouponAvailabilityRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<%@ Register Src="CategoryCheckBoxListControl.ascx" TagName="CategoryCheckBoxListControl" TagPrefix="uc1" %>
<%@ Register TagPrefix="dnn3" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<dnn3:DnnCssInclude runat="server" FilePath="../_default/WebControlSkin/Default/ComboBox.Default.css" PathNameAlias="SkinPath" />
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Availability rule:" HelpText="Provide any condition that determines when the coupon should be allowed to use." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - Always allow" Value=""></asp:ListItem>
		<asp:ListItem Text="Basic" Value="BasicAvailabilityView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicAvailabilityView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxUserUsageBasicAvailabilityLabelControl" runat="server" Text="Max usage per user:" HelpText="The maximum number of times this coupon can be used by the same user. Leave blank for unlimited." />
			<dnn2:DnnNumericTextBox ID="MaxUserUsageBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="1">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponBehaviorBasicAvailabilityLabelControl" runat="server" Text="Coupon combination:" HelpText="Determine if coupon is allowed to be used with other coupons." />
			<asp:RadioButtonList ID="CouponBehaviorBasicAvailabilityRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Allow all except listed below" Value="exclusion" Selected="True" />
				<asp:ListItem Text="Allow only those listed below" Value="inclusion" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CouponInclusionBasicAvailabilityLabelControl" runat="server" Text="Coupons:" HelpText="Select the coupons that should match the combination condition." />
			<asp:Panel ID="CouponInclusionBasicAvailabilityPanel" runat="server" Height="250px" ScrollBars="Auto">
				<asp:CheckBoxList ID="CouponInclusionBasicAvailabilityCheckBoxList" runat="server" RepeatLayout="Flow" CssClass="rvdFormCheckBoxes">
				</asp:CheckBoxList>
			</asp:Panel>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductVariantBehaviorBasicAvailabilityLabelControl" runat="server" Text="Product requirement:" HelpText="Determine when the coupon is only allowed to be used when certain products are present in the cart. It does not, however, determine whether a product will be discounted as that is controlled by the promotion rule." />
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
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CategoryBehaviorBasicAvailabilityLabelControl" runat="server" Text="Category requirement:" HelpText="Determine when the coupon is only allowed to be used when certain products belonging to the category are present in the cart. It does not, however, determine whether a product will be discounted as that is controlled by the promotion rule." />
			<asp:RadioButtonList ID="CategoryBehaviorBasicAvailabilityRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Allow all except selected below" Value="exclusion" Selected="True" />
				<asp:ListItem Text="Allow only those selected below" Value="inclusion" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CategoryInclusionBasicAvailabilityLabelControl" runat="server" Text="Categories" HelpText="Select the categories that should match the condition."/>
			<uc1:CategoryCheckBoxListControl ID="CategoryInclusionBasicAvailabilityCheckBoxListControl1" runat="server" />
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AvailabilityRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="AvailabilityRuleFormulaEditor" runat="server" Width="100%" ModuleControl="CouponAvailability" />
		</div>
	</asp:View>
</asp:MultiView>