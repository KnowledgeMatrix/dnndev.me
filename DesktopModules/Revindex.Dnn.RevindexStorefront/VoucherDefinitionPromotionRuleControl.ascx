<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VoucherDefinitionPromotionRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.VoucherDefinitionPromotionRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Promotion rule:" HelpText="Provide any promotion rule." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value=""></asp:ListItem>
		<asp:ListItem Text="Flat increase - increase by amount or rate" Value="FlatIncreaseView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatIncreaseView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="IncreaseAmountFlatIncreaseLabelControl" runat="server" Text="Increase:" HelpText="The voucher's value will be increased by this extra amount during the promotion period. After the promotion period ends, the voucher will return to its original amount less any amount already redeemed." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="IncreaseAmountFlatIncreaseRequiredFieldValidator" runat="server" ControlToValidate="IncreaseAmountFlatIncreaseDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDefinitionDetailsViewControl">Increase amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="IncreaseAmountFlatIncreaseDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
			<asp:DropDownList ID="IncreaseAmountUnitFlatIncreaseDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxRedemptionFlatIncreaseLabelControl" runat="server" Text="Max redemption:" HelpText="The number of times the voucher can be redeemed during the promotion period. Leave blank to use default max redemption." CssClass="dnnFormRequired"/>
			<dnn2:DnnNumericTextBox ID="MaxRedemptionFlatIncreaseDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="1">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PromotionRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="PromotionRuleFormulaEditor" runat="server" Width="100%" ModuleControl="VoucherDefinitionPromotion" />
		</div>
	</asp:View>
</asp:MultiView>