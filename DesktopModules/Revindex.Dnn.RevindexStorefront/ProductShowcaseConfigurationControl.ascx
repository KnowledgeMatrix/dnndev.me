<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductShowcaseConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductShowcaseConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Product showcase</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseDisplayTemplateLabelControl" runat="server" Text="Display template:"  HelpText="The selected display template determines how to display the Product Showcase module." />
			<uc1:DisplayTemplateDropDownListControl ID="ProductShowcaseDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ProductShowcaseDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ProductShowcaseDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ShowcaseModeLabelControl" runat="server" Text="Showcase mode:" />
			<asp:DropDownList ID="ShowcaseModeDropDownList" runat="server" OnSelectedIndexChanged="ShowcaseModeDropDownList_SelectedIndexChanged" AutoPostBack="true">
				<asp:ListItem Value="1">Featured products</asp:ListItem>
				<asp:ListItem Value="2">Newest products</asp:ListItem>
				<asp:ListItem Value="3">Oldest products</asp:ListItem>
				<asp:ListItem Value="4">Random products</asp:ListItem>
                <asp:ListItem Value="7">Related products</asp:ListItem>
                <asp:ListItem Value="6">Custom categories</asp:ListItem>
				<asp:ListItem Value="5">Custom products</asp:ListItem>
				<asp:ListItem Value="6">Custom categories</asp:ListItem>
			</asp:DropDownList>
		</div>
		<asp:Panel ID="CustomProductPanel" runat="server" CssClass="dnnFormItem">
			<dnn1:LabelControl ID="CustomProductIDListLabelControl" runat="server" Text="Product IDs:" HelpText="Used in conjunction with &quot;Custom products&quot; mode. Enter one or more Product ID to display separated by a pipe &quot;|&quot; delimiter." />
			<asp:RegularExpressionValidator ID="CustomProductIDListRegularExpressionValidator4" runat="server" ControlToValidate="CustomProductIDListTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\d\|]+$" ValidationGroup="ConfigurationDetailsViewControl">Custom Product ID list is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="CustomProductIDListTextBox" runat="server"></asp:TextBox>
		</asp:Panel>
		<asp:Panel ID="CustomCategoryPanel" runat="server" CssClass="dnnFormItem">
			<dnn1:LabelControl ID="CustomCategoryIDListLabelControl" runat="server" Text="Category IDs:" HelpText="Used in conjunction with &quot;Custom categories&quot; mode. Enter one or more Category ID to display separated by a pipe &quot;|&quot; delimiter." />
			<asp:RegularExpressionValidator ID="CustomCategoryIDListRegularExpressionValidator4" runat="server" ControlToValidate="CustomCategoryIDListTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\d\|]+$" ValidationGroup="ConfigurationDetailsViewControl">Custom Category ID list is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="CustomCategoryIDListTextBox" runat="server"></asp:TextBox>
		</asp:Panel>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxItemsLabelControl" runat="server" Text="Max items:" CssClass="dnnFormRequired" HelpText="The total maximum number of products to display."/>
			<asp:RequiredFieldValidator ID="MaxItemsRequiredFieldValidator" runat="server" ControlToValidate="MaxItemsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Max items is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="MaxItemsRangeValidator" runat="server" ControlToValidate="MaxItemsTextBox" CssClass="dnnFormMessage dnnFormError" MaximumValue="100000" MinimumValue="1" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl" Display="Dynamic">Invalid max items.</asp:RangeValidator>
			<asp:TextBox ID="MaxItemsTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="VisibleMaxItemsLabelControl" runat="server" Text="Visible max items:" CssClass="dnnFormRequired" HelpText="The maximum number of products that is visible on screen at a time."/>
			<asp:RequiredFieldValidator ID="VisibleMaxItemsRequiredFieldValidator" runat="server" ControlToValidate="VisibleMaxItemsTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Visible max items is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="VisibleMaxItemsRangeValidator" runat="server" ControlToValidate="VisibleMaxItemsTextBox" CssClass="dnnFormMessage dnnFormError" MaximumValue="100000" MinimumValue="1" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl" Display="Dynamic">Invalid visible max items.</asp:RangeValidator>
			<asp:TextBox ID="VisibleMaxItemsTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DisplayEffectLabelControl" runat="server" Text="Display effect:" />
			<asp:DropDownList ID="DisplayEffectDropDownList" runat="server" >
				<asp:ListItem Value="1">Automatic advance</asp:ListItem>
				<asp:ListItem Value="2">Button mouse over</asp:ListItem>
				<asp:ListItem Value="3">Button click</asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ScrollDirectionLabelControl" runat="server" Text="Scroll direction:" />
			<asp:DropDownList ID="ScrollDirectionDropDownList" runat="server" >
				<asp:ListItem Value="1">Left</asp:ListItem>
				<asp:ListItem Value="2">Right</asp:ListItem>
				<asp:ListItem Value="4">Up</asp:ListItem>
				<asp:ListItem Value="8">Down</asp:ListItem>
				<asp:ListItem Value="3">Left, Right</asp:ListItem>
				<asp:ListItem Value="12">Up, Down</asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ScrollDurationLabelControl" runat="server" Text="Scroll duration:" HelpText="Specify the speed in milliseconds for scrolling items." />
			<asp:RangeValidator ID="ScrollDurationRangeValidator" runat="server" ControlToValidate="ScrollDurationTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="1000000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Scroll duration is invalid.</asp:RangeValidator>
			<asp:TextBox ID="ScrollDurationTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FrameDurationLabelControl" runat="server" Text="Frame duration:" HelpText="Specify the time in milliseconds each frame will display during automatic scrolling." />
			<asp:RangeValidator ID="FrameDurationRangeValidator" runat="server" ControlToValidate="FrameDurationTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="1000000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Frame duration is invalid.</asp:RangeValidator>
			<asp:TextBox ID="FrameDurationTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="WrapFramesLabelControl" runat="server" Text="Wrap frames:" HelpText="Specify if items should restart from first item after the last item is displayed." />
			<asp:CheckBox ID="WrapFramesCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="HeightLabelControl" runat="server" Text="Height:" />
			<asp:RegularExpressionValidator ID="HeightRegularExpressionValidator" runat="server" ControlToValidate="HeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\d\|]+(px|%){0,1}$" ValidationGroup="ConfigurationDetailsViewControl">Height is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="HeightTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="WidthLabelControl" runat="server" Text="Width:" />
			<asp:RegularExpressionValidator ID="WidthRegularExpressionValidator" runat="server" ControlToValidate="WidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\d\|]+(px|%){0,1}$" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="WidthTextBox" runat="server"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseAddToCartInPlaceLabelControl" runat="server" Text="Add to cart in-place:" HelpText="Adding product to cart will stay on the same page." />
			<asp:CheckBox ID="ProductShowcaseAddToCartInPlaceCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcasePriceShowLabelControl" runat="server" Text="Show price:" HelpText="Show price on product showcase module." />
			<asp:CheckBox ID="ProductShowcasePriceShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseQuantityShowLabelControl" runat="server" Text="Show quantity:" HelpText="Show quantity on product showcase module." />
			<asp:CheckBox ID="ProductShowcaseQuantityShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseAddToCartShowLabelControl" runat="server" Text="Show Add to Cart button:" HelpText="Show Add to Cart button on product showcase module." />
			<asp:CheckBox ID="ProductShowcaseAddToCartShowCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseBuyNowShowLabelControl" runat="server" Text="Show Buy Now button:" HelpText="Show Buy Now button on product showcase module." />
			<asp:CheckBox ID="ProductShowcaseBuyNowShowCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ProductShowcaseSeeDetailsShowLabelControl" runat="server" Text="Show See Details button:" HelpText="Show See Details button on product showcase module." />
			<asp:CheckBox ID="ProductShowcaseSeeDetailsShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
