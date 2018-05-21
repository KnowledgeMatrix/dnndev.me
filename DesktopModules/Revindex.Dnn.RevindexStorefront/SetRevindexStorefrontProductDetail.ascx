<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SetRevindexStorefrontProductDetail.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SetRevindexStorefrontProductDetail" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="OverrideDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="Select a custom display template to associate to this module instance. This setting will override any configured template at the product or configuration level. Leave blank to use the default configured template." />
			<uc1:DisplayTemplateDropDownListControl ID="DisplayTemplateDropDownList" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DefaultControlLabelControl" runat="server" Text="Default:" />
			<asp:CheckBox ID="DefaultControlCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CustomProductIDLabelControl" runat="server" Text="Product ID:" HelpText="Enter the Product ID object identifier to override. If a value is entered, the Product Detail module will display this product."/>
			<asp:TextBox ID="CustomProductIDTextBox" runat="server" TextMode="Number"></asp:TextBox>
		</div>
	</fieldset>
</div>
