<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CommunicationConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CommunicationConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="CommunicationConfigurationEmailControl.ascx" TagName="CommunicationConfigurationEmailControl" TagPrefix="uc1" %>
<%@ Register Src="CommunicationConfigurationPrintControl.ascx" TagName="CommunicationConfigurationPrintControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:MultiView ID="ContentMultiView" runat="server">
	<asp:View ID="ListView" runat="server">
		<h2>Communication</h2>
		<div class="dnnForm rvdsfListContainer">
			<asp:GridView ID="CommunicationGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="False" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="">
				<AlternatingRowStyle CssClass="dnnGridAltItem" />
				<HeaderStyle CssClass="dnnGridHeader" />
				<RowStyle CssClass="dnnGridItem" />
				<SelectedRowStyle CssClass="dnnGridSelectedItem" />
				<FooterStyle CssClass="dnnGridFooter" />
				<PagerStyle CssClass="dnnGridPager" />
				<Columns>
					<asp:TemplateField>
						<ItemTemplate>
							<asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" NavigateUrl='<%# Eval("SelectHyperLink_NavigateUrl") %>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
					<asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
				</Columns>
			</asp:GridView>
		</div>
	</asp:View>
	<asp:View ID="DetailsView" runat="server">
		<div class="dnnForm">
			<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
			<asp:MultiView ID="TemplateMultiView" runat="server">
				<asp:View ID="CartAbandonEmailDetailsView" runat="server">
					<h2>Communication: Cart abandon email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationCartAbandonEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationCartAbandonEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationCartAbandonEmailControl" runat="server" Width="100%" ModuleControl="CartAbandonEmail"/>
					</fieldset>
				</asp:View>
				<asp:View ID="OrderAlertEmailDetailsView" runat="server">
					<h2>Communication: Order alert email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesOrderAlertEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesOrderAlertEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesOrderAlertEmailControl" runat="server" Width="100%" ModuleControl="SalesOrderAlertEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderInvoiceEmailDetailsView" runat="server">
					<h2>Communication: Order invoice email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesOrderInvoiceEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesOrderInvoiceEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesOrderInvoiceEmailControl" runat="server" Width="100%" ModuleControl="SalesOrderInvoiceEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderInvoicePrintDetailsView" runat="server">
					<h2>Communication: Order invoice print</h2>
					<fieldset>
						<uc1:CommunicationConfigurationPrintControl ID="CommunicationConfigurationSalesOrderInvoicePrintControl" runat="server" Width="100%" ModuleControl="SalesOrderInvoicePrint" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderQuoteEmailDetailsView" runat="server">
					<h2>Communication: Order quote email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesOrderQuoteEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesOrderQuoteEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesOrderQuoteEmailControl" runat="server" Width="100%" ModuleControl="SalesOrderQuoteEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderQuotePrintDetailsView" runat="server">
					<h2>Communication: Order quote print</h2>
					<fieldset>
						<uc1:CommunicationConfigurationPrintControl ID="CommunicationConfigurationSalesOrderQuotePrintControl" runat="server" Width="100%" ModuleControl="SalesOrderQuotePrint" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderReceiptEmailDetailsView" runat="server">
					<h2>Communication: Order receipt email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesOrderReceiptEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesOrderReceiptEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesOrderReceiptEmailControl" runat="server" Width="100%" ModuleControl="SalesOrderReceiptEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderReceiptPrintDetailsView" runat="server">
					<h2>Communication: Order receipt print</h2>
					<fieldset>
						<uc1:CommunicationConfigurationPrintControl ID="CommunicationConfigurationSalesOrderReceiptPrintControl" runat="server" Width="100%" ModuleControl="SalesOrderReceiptPrint" />
					</fieldset>
				</asp:View>
				<asp:View ID="OrderUpdateEmailDetailsView" runat="server">
					<h2>Communication: Order update email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesOrderUpdateEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesOrderUpdateEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesOrderUpdateEmailControl" runat="server" Width="100%" ModuleControl="SalesOrderUpdateEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="PackingSlipPrintDetailsView" runat="server">
					<h2>Communication: Packing slip print</h2>
					<fieldset>
						<uc1:CommunicationConfigurationPrintControl ID="CommunicationConfigurationPackingSlipPrintControl" runat="server" Width="100%" ModuleControl="PackingSlipPrint" />
					</fieldset>
				</asp:View>
				<asp:View ID="PaymentAlertEmailDetailsView" runat="server">
					<h2>Communication: Payment alert email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationSalesPaymentAlertEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationSalesPaymentAlertEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationSalesPaymentAlertEmailControl" runat="server" Width="100%" ModuleControl="SalesPaymentAlertEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="ProductReviewEmailDetailsView" runat="server">
					<h2>Communication: Product review email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationProductReviewsAlertEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationProductReviewsAlertEmailActiveCheckBox" runat="server" />
						</div>
					</fieldset>
				</asp:View>
				<asp:View ID="RecurringOrderPaymentIncompleteRetryEmailDetailsView" runat="server">
					<h2>Communication: Recurring order payment retry email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryEmailActiveCheckBox" runat="server" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownLabelControl" runat="server" Text="Days before retry attempt:" HelpText="The number of days to start sending the payment retry email before the actual retry date." CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownRequiredFieldValidator" runat="server" ControlToValidate="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Number of days is required.</asp:RequiredFieldValidator>
							<asp:RangeValidator ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownRangeValidator" runat="server" ControlToValidate="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="10000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Number of days is invalid.</asp:RangeValidator>
							<asp:TextBox ID="CommunicationRecurringSalesOrderPaymentIncompleteRetryCountdownTextBox" runat="server" CssClass="dnnFormRequired" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationRecurringSalesOrderPaymentIncompleteRetryEmailControl" runat="server" Width="100%" ModuleControl="RecurringSalesOrderPaymentIncompleteRetryEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="RecurringOrderReminderEmailDetailsView" runat="server">
					<h2>Communication: Recurring order reminder email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationRecurringSalesOrderReminderEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationRecurringSalesOrderReminderEmailActiveCheckBox" runat="server" />
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationRecurringSalesOrderReminderCountdownLabelControl" runat="server" Text="Days before renewal:" HelpText="The number of days to start sending the reminder email before the recurring order is due for renewal." CssClass="dnnFormRequired" />
							<asp:RequiredFieldValidator ID="CommunicationRecurringSalesOrderReminderCountdownRequiredFieldValidator" runat="server" ControlToValidate="CommunicationRecurringSalesOrderReminderCountdownTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Number of days is required.</asp:RequiredFieldValidator>
							<asp:RangeValidator ID="CommunicationRecurringSalesOrderReminderCountdownRangeValidator" runat="server" ControlToValidate="CommunicationRecurringSalesOrderReminderCountdownTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="10000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Number of days is invalid.</asp:RangeValidator>
							<asp:TextBox ID="CommunicationRecurringSalesOrderReminderCountdownTextBox" runat="server" CssClass="dnnFormRequired" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationRecurringSalesOrderReminderEmailControl" runat="server" Width="100%" ModuleControl="RecurringSalesOrderReminderEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="RightReceiptEmailDetailsView" runat="server">
					<h2>Communication: Rights receipt email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationRightReceiptEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationRightReceiptEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationRightReceiptEmailControl" runat="server" Width="100%" ModuleControl="RightReceiptEmail" />
					</fieldset>
				</asp:View>
				<asp:View ID="VoucherReceiptEmailDetailsView" runat="server">
					<h2>Communication: Voucher receipt email</h2>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="CommunicationVoucherReceiptEmailActiveLabelControl" runat="server" Text="Enable:" />
							<asp:CheckBox ID="CommunicationVoucherReceiptEmailActiveCheckBox" runat="server" />
						</div>
						<uc1:CommunicationConfigurationEmailControl ID="CommunicationConfigurationVoucherReceiptEmailControl" runat="server" Width="100%" ModuleControl="VoucherReceiptEmail" />
					</fieldset>
				</asp:View>
			</asp:MultiView>
			<ul class="dnnActions">
				<li>
					<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
				<li>
					<asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ConfigurationDetailsViewControl" />
				</li>
				<li>
					<uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
				</li>
			</ul>
		</div>
	</asp:View>
</asp:MultiView>
