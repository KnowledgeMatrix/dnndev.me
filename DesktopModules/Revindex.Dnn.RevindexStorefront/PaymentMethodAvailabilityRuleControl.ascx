<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentMethodAvailabilityRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PaymentMethodAvailabilityRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Availability rule:" HelpText="Provide any condition that determines when this payment method should be available for selection." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - always allow" Value=""></asp:ListItem>
		<asp:ListItem Text="Basic" Value="BasicAvailabilityView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicAvailabilityView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinOrderAmountBasicAvailabilityLabelControl" runat="server" Text="Min total amount:" HelpText="The minimum total order amount to qualify for this payment method." />
			<dnn2:DnnNumericTextBox ID="MinOrderAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxOrderAmountBasicAvailabilityLabelControl" runat="server" Text="Max total amount:" HelpText="The maximum total order amount to qualify for this payment method." />
			<dnn2:DnnNumericTextBox ID="MaxOrderAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinPaymentBalanceAmountBasicAvailabilityLabelControl" runat="server" Text="Min payment balance amount:" HelpText="The minimum payment balance (total amount - payments) to qualify for this payment method." />
			<dnn2:DnnNumericTextBox ID="MinPaymentBalanceAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxPaymentBalanceAmountBasicAvailabilityLabelControl" runat="server" Text="Max payment balance amount:" HelpText="The maximum payment balance (total amount - payments) to qualify for this payment method." />
			<dnn2:DnnNumericTextBox ID="MaxPaymentBalanceAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AvailabilityRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="AvailabilityRuleFormulaEditor" runat="server" Width="100%" ModuleControl="PaymentMethodAvailability" />
		</div>
	</asp:View>
</asp:MultiView>