<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserPaymentConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.UserPaymentConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>User payment</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="UserPaymentVerificationActiveLabelControl" runat="server" Text="Verify saved payment:" HelpText="Verify the payment information saved by the user is valid by authorizing a small amount that will be voided immediately after. Verification helps ensure future recurring payments will be successful. Currently, this feature applies to saved credit card payments only. This feature may not be available for every payment gateway. Please perform your own tests to ensure it works for your payment gateway." />
			<asp:CheckBox ID="UserPaymentVerificationActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="UserPaymentVerificationAmountLabelControl" runat="server" Text="Amount to verify:" HelpText="Specify the amount to authorize and voided immediately after. Typically, a small amount of 1.00 is sufficient to test the validity of the saved payment." />
			<asp:RequiredFieldValidator ID="UserPaymentVerificationAmountRequiredFieldValidator" runat="server" ControlToValidate="UserPaymentVerificationAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="UserPaymentVerificationAmountDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
