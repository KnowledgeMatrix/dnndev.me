<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CartSummaryConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CartSummaryConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Cart summary</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CartSummaryDisplayTemplateLabelControl" runat="server" Text="Display template:" />
			<uc1:DisplayTemplateDropDownListControl ID="CartSummaryDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="CartSummaryDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="CartSummaryDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CartSummarySalesOrderDetailShowLabelControl" runat="server" Text="Show order details:" />
			<asp:CheckBox ID="CartSummarySalesOrderDetailShowCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
		</li>
	</ul>
</div>
