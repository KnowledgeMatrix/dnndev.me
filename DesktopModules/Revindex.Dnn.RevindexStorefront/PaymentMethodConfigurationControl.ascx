<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentMethodConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PaymentMethodConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="PaymentMethodAvailabilityRuleControl.ascx" TagName="PaymentMethodAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder ID="PlaceHolder1" runat="server">

    <script type="text/javascript">
    	jQuery(document).ready(function ()
    	{
    		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
    	});
    	Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
    	{
    		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
    	});
    </script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<h2>Payment methods</h2>
			<p>Enable the payment methods that your business will accept. Make sure to enter the payment gateway credentials if you're using a 3rd party payment processor.</p>
			<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
			<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
				<h2 id="NoneFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">None</a></h2>
				<fieldset>
					<p>This payment method allows a user to bypass payment and is useful for allowing a customer to checkout zero dollar amounts such as free trials. It should normally be used with an availability rule to allow it only when the amount due is zero.</p>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsNoneActiveLabelControl" runat="server" Text="Enable:" HelpText="This payment method allows a user to bypass payment and is useful for allowing a customer to checkout zero dollar amounts such as free trials." />
						<asp:CheckBox ID="PaymentMethodsNoneActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsNoneAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
                <h2 id="ACHFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">ACH/eCheck</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsACHActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsACHActiveCheckBox" runat="server" />
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsACHPaymentGatewayLabelControl" runat="server" Text="ACH payment gateway:" />
						<asp:DropDownList ID="PaymentMethodsACHPaymentGatewayDropDownList" runat="server" OnSelectedIndexChanged="PaymentMethodsACHPaymentGatewayDropDownList_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem Text="Manual" Value="" />
							<asp:ListItem Text="FTNI" Value="FTNIACH" />
						</asp:DropDownList>
						<asp:HyperLink ID="PaymentMethodsACHPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsACHAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="AuthorizeNetCIMFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Authorize.Net CIM</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsAuthorizeNetCIMActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsAuthorizeNetCIMActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsAuthorizeNetCIMPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsAuthorizeNetCIMTransactionTypeLabelControl" runat="server" Text="Transaction type:" HelpText="Authorize reserves the money and needs to be captured at a later time to complete the transaction. Purchase transaction immediately deducts the money from the customer and begins the transfer of money to your account." />
						<asp:RadioButtonList ID="PaymentMethodsAuthorizeNetCIMTransactionTypeRadioButtonList" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Text="Authorize" Value="1" />
							<asp:ListItem Text="Purchase" Value="2" />
						</asp:RadioButtonList>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsAuthorizeNetCIMAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="AuthorizeNetSIMFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Authorize.Net SIM</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsAuthorizeNetSIMActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsAuthorizeNetSIMActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsAuthorizeNetSIMPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsAuthorizeNetSIMAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="CashFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Cash</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCashActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsCashActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsCashAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="CheckFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Check</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCheckActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsCheckActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsCheckAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="CreditCardFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Credit/Debit card</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCreditCardActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsCreditCardActiveCheckBox" runat="server" />
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCreditCardPaymentGatewayLabelControl" runat="server" Text="Credit card payment gateway:" />
						<asp:DropDownList ID="PaymentMethodsCreditCardPaymentGatewayDropDownList" runat="server" OnSelectedIndexChanged="PaymentMethodsCreditCardPaymentGatewayDropDownList_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem Text="Manual" Value="" />
							<asp:ListItem Text="Authorize.Net AIM" Value="AuthorizeNetAIM" />
							<asp:ListItem Text="BluePay" Value="BluePay" />
							<asp:ListItem Text="CashFlows Remote API" Value="CashFlowsRemoteAPI" />
							<asp:ListItem Text="Chase Paymentech Orbital Gateway" Value="ChasePaymentechOG" />
                            <asp:ListItem Text="Corduro" Value="Corduro" />
							<asp:ListItem Text="CyberSource" Value="CyberSourceSoap" />
							<asp:ListItem Text="Elavon Virtual Merchant" Value="ElavonVirtualMerchant" />
							<asp:ListItem Text="eProcessing Network" Value="eProcessingNetwork" />
							<asp:ListItem Text="eWay Direct Payment" Value="eWayDirectPayment" />
							<asp:ListItem Text="FirstData Global Gateway" Value="FirstDataGGWS" />
                            <asp:ListItem Text="FTNI" Value="FTNI" />
							<asp:ListItem Text="Internet Secure Merchant Direct" Value="InternetSecureMD" />
							<asp:ListItem Text="Intuit QuickBooks Merchant Service" Value="IntuitQBMS" />
							<asp:ListItem Text="Merchant e-Solutions" Value="MerchanteSolutions" />
							<asp:ListItem Text="Moneris eSelectPlus Canada" Value="MonerisESPCA" />
							<asp:ListItem Text="NMI" Value="NMI" />
                            <asp:ListItem Text="Payment Express PXPost" Value="PaymentExpressPXPost" />
							<asp:ListItem Text="PayPal Payments Pro (Payflow)" Value="PayPalPP" />
							<asp:ListItem Text="PayPal Website Payments Pro" Value="PayPalWPP" />
							<asp:ListItem Text="Pay Trace" Value="PayTrace" />
							<asp:ListItem Text="PayU Enterprise" Value="PayUEnterprise" />
							<asp:ListItem Text="Peach Payments" Value="PeachXmlIntegrator" />
							<asp:ListItem Text="Princeton CardConnect" Value="PrincetonCardConnect" />
							<asp:ListItem Text="PSiGate Xml Messenger" Value="PSiGateXmlMessenger" />
                            <asp:ListItem Text="Sage Payments Direct" Value="SageDirect" />
							<asp:ListItem Text="Sage Pay Direct" Value="SagePayDirect" />
							<asp:ListItem Text="Stripe" Value="Stripe" />
                            <asp:ListItem Text="Total Apps" Value="TotalAppsDirectPost" />
							<asp:ListItem Text="USA ePay" Value="USAePay" />
							<asp:ListItem Text="WorldPay Corporate XML Direct" Value="WorldPayCorporateXmlDirect" />
							<asp:ListItem Text="Zooz" Value="Zooz" />
						</asp:DropDownList>
						<asp:HyperLink ID="PaymentMethodsCreditCardPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCreditCardTransactionTypeLabelControl" runat="server" Text="Transaction type:" HelpText="Authorize reserves the money and needs to be captured at a later time to complete the transaction. Purchase transaction immediately deducts the money from the customer and begins the transfer of money to your account." />
						<asp:RadioButtonList ID="PaymentMethodsCreditCardTransactionTypeRadioButtonList" runat="server" RepeatDirection="Horizontal">
							<asp:ListItem Text="Authorize" Value="1" />
							<asp:ListItem Text="Purchase" Value="2" />
						</asp:RadioButtonList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCreditCardAuthenticateIdentityLabelControl" runat="server" Text="Authenticate identity (3D Secure):" HelpText="Enable 3D Secure authentication (Verified by Visa, MasterCard SecureCode, Amex SafeKey, etc.) when possible to shift chargeback liability to the issuing bank in case of fraudulent payments. Please verify your payment gateway supports 3D Secure before enabling this feature." />
						<asp:CheckBox ID="PaymentMethodsCreditCardAuthenticateIdentityCheckBox" runat="server" />
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsCreditCardTokenActiveLabelControl" runat="server" Text="Tokenize data:" HelpText="When possible, tokenization substitutes sensitive data with a token that has no exploitable value. It reduces your PCI footprint because the sensitive data is only stored at your payment gateway's secure facility. The token can be used to repeat a recurring payment without needing the sensitive data. Please verify your payment gateway supports tokenization before enabling this feature." />
						<asp:CheckBox ID="PaymentMethodsCreditCardTokenActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsCreditCardAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="DotpayFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Dotpay</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsDotpayActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsDotpayActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsDotpayPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsDotpayAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="MasterCardIGSHostedFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">MasterCard Internet Gateway Service Hosted</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsMasterCardIGSHostedActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsMasterCardIGSHostedActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsMasterCardIGSHostedPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsMasterCardIGSHostedAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="MollieFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Mollie</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsMollieActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsMollieActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsMolliePaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsMollieAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="MoneyOrderFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Money order</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsMoneyOrderActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsMoneyOrderActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsMoneyOrderAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="PaymentExpressFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Payment Express</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPaymentExpressActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsPaymentExpressActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsPaymentExpressPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsPaymentExpressAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="PayFastFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">PayFast</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPayFastActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsPayFastActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsPayFastPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsPayFastAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="PayPalFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">PayPal</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPayPalActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsPayPalActiveCheckBox" runat="server" />
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPayPalPaymentGatewayLabelControl" runat="server" Text="PayPal payment gateway:" />
						<asp:DropDownList ID="PaymentMethodsPayPalPaymentGatewayDropDownList" runat="server" OnSelectedIndexChanged="PaymentMethodsPayPalPaymentGatewayDropDownList_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem Text="PayPal Express Checkout" Value="PayPalEC" />
							<asp:ListItem Text="PayPal Website Payments Standard" Value="PayPalWPS" />
						</asp:DropDownList>
						<asp:HyperLink ID="PaymentMethodsPayPalPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsPayPalAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="Paystation3PartyFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Paystation</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPaystation3PartyActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsPaystation3PartyActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsPaystation3PartyPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsPaystation3PartyAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="PayUBusinessFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">PayU Business</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsPayUBusinessActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsPayUBusinessActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsPayUBusinessPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsPayUBusinessAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="RewardsPointFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Rewards points</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsRewardsPointActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsRewardsPointActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsRewardsPointAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="SagePayFormFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Sage Pay Form</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsSagePayFormActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsSagePayFormActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsSagePayFormPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsSagePayFormAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="SuomenVerkkomaksutFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Suomen Verkkomaksut</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsSuomenVerkkomaksutActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsSuomenVerkkomaksutActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsSuomenVerkkomaksutPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsSuomenVerkkomaksutAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="TowahFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Towah</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsTowahActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsTowahActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsTowahPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsTowahAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="VirtualCardServicesPayFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Virtual Card Services Pay</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsVirtualCardServicesPayActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsVirtualCardServicesPayActiveCheckBox" runat="server" />
						<asp:HyperLink ID="PaymentMethodsVirtualCardServicesPaymentGatewayHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsVirtualCardServicesPayAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="VoucherFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Voucher</a></h2>
				<fieldset>
					<p>Voucher, also known as gift card or gift certificate, allows a customer to pay for their purchase by entering the voucher code.</p>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsVoucherActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsVoucherActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsVoucherAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<h2 id="WireTransferFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Wire transfer</a></h2>
				<fieldset>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PaymentMethodsWireTransferActiveLabelControl" runat="server" Text="Enable:" />
						<asp:CheckBox ID="PaymentMethodsWireTransferActiveCheckBox" runat="server" />
					</div>
					<uc1:PaymentMethodAvailabilityRuleControl ID="PaymentMethodsWireTransferAvailabilityRuleControl" runat="server" Width="100%" />
				</fieldset>
				<ul class="dnnActions">
					<li>
						<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
				</ul>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
