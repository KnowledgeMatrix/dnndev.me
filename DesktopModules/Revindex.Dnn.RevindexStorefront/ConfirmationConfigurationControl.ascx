<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ConfirmationConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ConfirmationConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Confirmation</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ConfirmationDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Confirmation module."/>
			<uc1:DisplayTemplateDropDownListControl ID="ConfirmationDisplayTemplateDropDownListControl" runat="server" />
			<asp:LinkButton ID="ConfirmationDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="ConfirmationDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ConfirmationSingleTransactionLabelControl" runat="server" Text="Single transaction:" HelpText="Prevent the confirmation page from being rendered more than once for the duration of the checkout transaction. This feature is useful in cases where you have affiliate tracking code that you only want to trigger once on checkout completion even if the customer refreshes the confirmation page." />
			<asp:CheckBox ID="ConfirmationSingleTransactionCheckBox" runat="server" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
