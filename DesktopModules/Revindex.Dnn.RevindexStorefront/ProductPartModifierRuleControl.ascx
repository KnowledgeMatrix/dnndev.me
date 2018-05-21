<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductPartModifierRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductPartModifierRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Modifier rule:" HelpText="Provide any price modification rule." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value=""></asp:ListItem>
		<asp:ListItem Text="Fixed price" Value="FlatPriceView"></asp:ListItem>
		<asp:ListItem Text="Adjust price - modify price by amount or percentage" Value="AdjustPriceView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="FlatPriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PriceFlatPriceLabelControl" runat="server" Text="Price:" HelpText="Enter the new price that will override the product variant's current price." CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="PriceFlatPriceRequiredFieldValidator" runat="server" ControlToValidate="PriceFlatPriceDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductPartDetailsViewControl">Price is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PriceFlatPriceDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="AdjustPriceView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="PriceAdjustPriceDetailsViewLabelControl" runat="server" Text="Price adjustment:" HelpText="The amount or percentage to adjust starting from the current price." CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="PriceAdjustPriceDetailsViewRequiredFieldValidator" runat="server" ControlToValidate="PriceAdjustPriceDetailsViewDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductPartDetailsViewControl">Price adjustment is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PriceAdjustPriceDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9">
			</dnn2:DnnNumericTextBox>
			<asp:DropDownList ID="PriceAdjustPriceDetailsViewDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Text="By amount" Value="amount" />
				<asp:ListItem Text="By percentage" Value="rate" />
			</asp:DropDownList>
		</div>
	</asp:View>
</asp:MultiView>