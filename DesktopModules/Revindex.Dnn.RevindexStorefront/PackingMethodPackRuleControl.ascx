<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PackingMethodPackRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PackingMethodPackRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Pack rule:" />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True" >
		<asp:ListItem Text="None - no packing needed" Value=""></asp:ListItem>
		<asp:ListItem Text="Single package - all products in one package" Value="SinglePackageView"></asp:ListItem>
		<asp:ListItem Text="Single product - one package per product" Value="SingleProductView"></asp:ListItem>
		<asp:ListItem Text="Volume fit - fit packages by volume approximation" Value="VolumeFitView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="SinglePackageView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PackageIDSinglePackageLabelControl" runat="server" Text="Package:" HelpText="" />
			<asp:DropDownList ID="PackageIDSinglePackageDropDownList" runat="server" >
			</asp:DropDownList>
		</div>
	</asp:View>
	<asp:View ID="SingleProductView" runat="server">
	</asp:View>
	<asp:View ID="VolumeFitView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FillFactorVolumeFitLabelControl" runat="server" Text="Fill factor (%):" HelpText="Volume fit will approximate the number of items that can fit into a package by mathematical volume. The fill factor determines how much space from the package can be used for fitting content. You should allow a percentage of empty space to ensure products can loosely fit." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="FillFactorVolumeFitRequiredFieldValidator" runat="server" ControlToValidate="FillFactorVolumeFitDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackingMethodDetailsViewControl">Fill factor is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="FillFactorVolumeFitDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PackRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="PackRuleFormulaEditor" runat="server" Width="100%" ModuleControl="PackingMethodPack" />
		</div>
	</asp:View>
</asp:MultiView>