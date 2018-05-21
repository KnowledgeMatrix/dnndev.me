<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PaymentGatewayConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PaymentGatewayConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
<h2>Payment gateway</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<fieldset>
		<asp:MultiView ID="DetailsMultiView" runat="server">
			<asp:View ID="AuthorizeNetAIMView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetAIMGatewayUrlLabelControl" runat="server" Text="Gateway Url:" HelpText="Enter a non-standard gateway URL if you're using a different payment gateway under Authorize.Net compatibility mode otherwise leave blank." />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetAIMGatewayUrlTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetAIMLoginLabelControl" runat="server" Text="Login:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetAIMLoginTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetAIMTranKeyLabelControl" runat="server" Text="TranKey:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetAIMTranKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetAIMDuplicateWindowLabelControl" runat="server" Text="Duplicate window:" HelpText="The number of seconds must have elapsed before allowing to process another identical transactions with the same amount and credit card information." />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetAIMDuplicateWindowTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetAIMTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysAuthorizeNetAIMTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="AuthorizeNetCIMView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetCIMLoginLabelControl" runat="server" Text="Login:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetCIMLoginTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetCIMTranKeyLabelControl" runat="server" Text="TranKey:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetCIMTranKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetCIMDuplicateWindowLabelControl" runat="server" Text="Duplicate window:" HelpText="The number of seconds must have elapsed before allowing to process another identical transactions with the same amount and credit card information." />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetCIMDuplicateWindowTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetCIMTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysAuthorizeNetCIMTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="AuthorizeNetSIMView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMGatewayUrlLabelControl" runat="server" Text="Gateway Url:" HelpText="Enter a non-standard gateway URL if you're using a different payment gateway under Authorize.Net compatibility mode otherwise leave blank." />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetSIMGatewayUrlTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMLoginLabelControl" runat="server" Text="Login:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetSIMLoginTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMTranKeyLabelControl" runat="server" Text="TranKey:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetSIMTranKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMMD5HashLabelControl" runat="server" Text="MD5 hash:" />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetSIMMD5HashTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMDuplicateWindowLabelControl" runat="server" Text="Duplicate window:" HelpText="The number of seconds must have elapsed before allowing to process another identical transactions with the same amount and credit card information." />
					<asp:TextBox ID="PaymentGatewaysAuthorizeNetSIMDuplicateWindowTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysAuthorizeNetSIMTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysAuthorizeNetSIMTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="BluePayView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysBluePayAccountIDLabelControl" runat="server" Text="Account ID:" />
					<asp:TextBox ID="PaymentGatewaysBluePayAccountIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysBluePaySecretKeyLabelControl" runat="server" Text="Secret Key:" />
					<asp:TextBox ID="PaymentGatewaysBluePaySecretKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysBluePayTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysBluePayTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="CashFlowsRemoteAPIView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCashFlowsRemoteAPIProfileIDLabelControl" runat="server" Text="Profile ID:" />
					<asp:TextBox ID="PaymentGatewaysCashFlowsRemoteAPIProfileIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCashFlowsRemoteAPIPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysCashFlowsRemoteAPIPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCashFlowsRemoteAPITestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysCashFlowsRemoteAPITestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="ChasePaymentechOGView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGUsernameLabelControl" runat="server" Text="Username:" HelpText="The credentials for the Tampa version of Chase Paymentech Orbital Gateway." />
					<asp:TextBox ID="PaymentGatewaysChasePaymentechOGUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysChasePaymentechOGPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysChasePaymentechOGMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGTerminalIDLabelControl" runat="server" Text="Terminal ID:" />
					<asp:TextBox ID="PaymentGatewaysChasePaymentechOGTerminalIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGBinLabelControl" runat="server" Text="Bin:" />
					<asp:TextBox ID="PaymentGatewaysChasePaymentechOGBinTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysChasePaymentechOGTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysChasePaymentechOGTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="CorduroView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroClientNumberLabelControl" runat="server" Text="Client number:" />
					<asp:TextBox ID="PaymentGatewaysCorduroClientNumberTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysCorduroUsernameTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroPasswordKeyLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysCorduroPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroProcessAccountNumberLabelControl" runat="server" Text="Process account number:" />
					<asp:TextBox ID="PaymentGatewaysCorduroProcessAccountNumberTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroCertificateLabelControl" runat="server" Text="PEM certificate:" />
					<asp:TextBox ID="PaymentGatewaysCorduroCertificateTextBox" runat="server" MaxLength="8000" Rows="6" TextMode="MultiLine" Wrap="False"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCorduroTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysCorduroTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="CyberSourceSoapView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCyberSourceSoapMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysCyberSourceSoapMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCyberSourceSoapTransactionKeyLabelControl" runat="server" Text="Transaction key:" />
					<asp:TextBox ID="PaymentGatewaysCyberSourceSoapTransactionKeyTextBox" runat="server" MaxLength="500"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysCyberSourceSoapTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysCyberSourceSoapTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="DotpayView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysDotpayAccountIDLabelControl" runat="server" Text="Account ID:" />
					<asp:TextBox ID="PaymentGatewaysDotpayAccountIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysDotpayPinLabelControl" runat="server" Text="Pin:" />
					<asp:TextBox ID="PaymentGatewaysDotpayPinTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysDotpayTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysDotpayTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="ElavonVirtualMerchantView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysElavonVirtualMerchantAccountIDLabelControl" runat="server" Text="Account ID:" />
					<asp:TextBox ID="PaymentGatewaysElavonVirtualMerchantAccountIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysElavonVirtualMerchantUserIDLabelControl" runat="server" Text="User ID:" />
					<asp:TextBox ID="PaymentGatewaysElavonVirtualMerchantUserIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysElavonVirtualMerchantPinLabelControl" runat="server" Text="Pin:" />
					<asp:TextBox ID="PaymentGatewaysElavonVirtualMerchantPinTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysElavonVirtualMerchantTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysElavonVirtualMerchantTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="eProcessingNetworkView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseProcessingNetworkAccountNumberLabelControl" runat="server" Text="Account Number:" />
					<asp:TextBox ID="PaymentGatewayseProcessingNetworkAccountNumberTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseProcessingNetworkRestrictKeyLabelControl" runat="server" Text="Restrict Key:" />
					<asp:TextBox ID="PaymentGatewayseProcessingNetworkRestrictKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseProcessingNetworkTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewayseProcessingNetworkTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="eWayDirectPaymentView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseWayDirectPaymentCustomerIDLabelControl" runat="server" Text="Customer ID:" />
					<asp:TextBox ID="PaymentGatewayseWayDirectPaymentCustomerIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseWayDirectPaymentRefundPasswordLabelControl" runat="server" Text="Refund password:" HelpText="Enter the password to allow refunds." />
					<asp:TextBox ID="PaymentGatewayseWayDirectPaymentRefundPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewayseWayDirectPaymentTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewayseWayDirectPaymentTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="FirstDataGGWSView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFirstDataGGWSUserLabelControl" runat="server" Text="User:" />
					<asp:TextBox ID="PaymentGatewaysFirstDataGGWSUserTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFirstDataGGWSPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysFirstDataGGWSPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFirstDataGGWSCertificateLabelControl" runat="server" Text="PEM Certificate:" />
					<asp:TextBox ID="PaymentGatewaysFirstDataGGWSCertificateTextBox" runat="server" MaxLength="8000" Rows="6" TextMode="MultiLine" Wrap="False"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFirstDataGGWSTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysFirstDataGGWSTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="FTNIView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNIUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysFTNIUsernameTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNIPasswordKeyLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysFTNIPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNITestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysFTNITestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="FTNIACHView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNIACHUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysFTNIACHUsernameTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNIACHPasswordKeyLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysFTNIACHPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysFTNIACHTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysFTNIACHTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="InternetSecureMDView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysInternetSecureMDGatewayIDLabelControl" runat="server" Text="Gateway ID:" />
					<asp:TextBox ID="PaymentGatewaysInternetSecureMDGatewayIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysInternetSecureMDTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysInternetSecureMDTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="IntuitQBMSView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysIntuitQBMSAppIDLabelControl" runat="server" Text="App ID:" />
					<asp:TextBox ID="PaymentGatewaysIntuitQBMSAppIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysIntuitQBMSAppLoginLabelControl" runat="server" Text="App login:" />
					<asp:TextBox ID="PaymentGatewaysIntuitQBMSAppLoginTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysIntuitQBMSConnectionTicketLabelControl" runat="server" Text="Connection ticket:" />
					<asp:TextBox ID="PaymentGatewaysIntuitQBMSConnectionTicketTextBox" runat="server"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysIntuitQBMSTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysIntuitQBMSTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="MasterCardIGSHostedView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMasterCardIGSHostedMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysMasterCardIGSHostedMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMasterCardIGSHostedAccessCodeLabelControl" runat="server" Text="Access code:" />
					<asp:TextBox ID="PaymentGatewaysMasterCardIGSHostedAccessCodeTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMasterCardIGSHostedSecureHashSecretLabelControl" runat="server" Text="Secure hash secret:" />
					<asp:TextBox ID="PaymentGatewaysMasterCardIGSHostedSecureHashSecretTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMasterCardIGSHostedTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysMasterCardIGSHostedTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="MerchanteSolutionsView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMerchanteSolutionsProfileIDLabelControl" runat="server" Text="Profile ID:" />
					<asp:TextBox ID="PaymentGatewaysMerchanteSolutionsProfileIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMerchanteSolutionsProfileKeyLabelControl" runat="server" Text="Profile Key:" />
					<asp:TextBox ID="PaymentGatewaysMerchanteSolutionsProfileKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMerchanteSolutionsTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysMerchanteSolutionsTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="MollieView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMolliePartnerIDLabelControl" runat="server" Text="API key:" />
					<asp:TextBox ID="PaymentGatewaysMollieAPIKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="MonerisESPCAView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMonerisESPCAStoreIDLabelControl" runat="server" Text="Store ID:" />
					<asp:TextBox ID="PaymentGatewaysMonerisESPCAStoreIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMonerisESPCAAPITokenLabelControl" runat="server" Text="API token:" />
					<asp:TextBox ID="PaymentGatewaysMonerisESPCAAPITokenTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysMonerisESPCATestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysMonerisESPCATestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="NMIView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysNMIKeyIDLabelControl" runat="server" Text="Key ID:" />
					<asp:TextBox ID="PaymentGatewaysNMIKeyIDTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysNMIKeyLabelControl" runat="server" Text="Key:" />
					<asp:TextBox ID="PaymentGatewaysNMIKeyTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysNMIUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysNMIUsernameTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysNMIPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysNMIPasswordTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysNMIGatewayUrlLabelControl" runat="server" Text="Gateway URL:" HelpText="Enter a non-standard gateway URL if you're using a different payment gateway under NMI compatibility mode otherwise leave blank." />
					<asp:TextBox ID="PaymentGatewaysNMIGatewayUrlTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="PaymentExpressView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPayUserIDLabelControl" runat="server" Text="User ID:" />
					<asp:TextBox ID="PaymentGatewaysPaymentExpressPXPayUserIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPayKeyLabelControl" runat="server" Text="Key:" />
					<asp:TextBox ID="PaymentGatewaysPaymentExpressPXPayKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPayTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPaymentExpressPXPayTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="PaymentExpressPXPostView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPostUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPaymentExpressPXPostUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPostPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPaymentExpressPXPostPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaymentExpressPXPostTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPaymentExpressPXPostTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayFastWPView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayFastWPMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysPayFastWPMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayFastWPMerchantKeyLabelControl" runat="server" Text="Merchant Key:" />
					<asp:TextBox ID="PaymentGatewaysPayFastWPMerchantKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayFastWPPDTKeyLabelControl" runat="server" Text="PDT Key:" />
					<asp:TextBox ID="PaymentGatewaysPayFastWPPDTKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayFastWPTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayFastWPTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayPalECView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalECUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayPalECUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalECPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayPalECPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalECSignatureLabelControl" runat="server" Text="Signature:" />
					<asp:TextBox ID="PaymentGatewaysPayPalECSignatureTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalECShippingFormActiveLabelControl" runat="server" Text="Enable shipping form:" HelpText="Allow PayPal to collect shipping information to make use of PayPal's shipping and packing slip features." />
					<asp:CheckBox ID="PaymentGatewaysPayPalECShippingFormActiveCheckBox" runat="server" />
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalECTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayPalECTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayPalPPView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalPPUserLabelControl" runat="server" Text="User:" />
					<asp:TextBox ID="PaymentGatewaysPayPalPPUserTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalPPVendorLabelControl2" runat="server" Text="Vendor:" />
					<asp:TextBox ID="PaymentGatewaysPayPalPPVendorTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalPPPartnerLabelControl3" runat="server" Text="Partner:" />
					<asp:TextBox ID="PaymentGatewaysPayPalPPPartnerTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalPPPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayPalPPPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalPPTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayPalPPTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayPalWPPView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPPUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPPUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPPPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPPPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPPSignatureLabelControl" runat="server" Text="Signature:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPPSignatureTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPPTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayPalWPPTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayPalWPSView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSEmailLabelControl" runat="server" Text="Email:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPSEmailTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPSUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPSPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSSignatureLabelControl" runat="server" Text="Signature:" />
					<asp:TextBox ID="PaymentGatewaysPayPalWPSSignatureTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSShippingFormActiveLabelControl" runat="server" Text="Enable shipping form:" HelpText="Allow PayPal to collect shipping information to make use of PayPal's shipping and packing slip features." />
					<asp:CheckBox ID="PaymentGatewaysPayPalWPSShippingFormActiveCheckBox" runat="server" />
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayPalWPSTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayPalWPSTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="Paystation3PartyView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaystation3PartyGatewayIDLabelControl" runat="server" Text="Gateway ID:" />
					<asp:TextBox ID="PaymentGatewaysPaystation3PartyGatewayIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaystation3PartyPaystationIDLabelControl" runat="server" Text="Paystation ID:" />
					<asp:TextBox ID="PaymentGatewaysPaystation3PartyPaystationIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPaystation3PartyTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPaystation3PartyTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayTraceView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayTraceUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayTraceUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayTracePasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayTracePasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayTraceTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayTraceTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayUBusinessView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUBusinessUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayUBusinessUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUBusinessPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayUBusinessPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUBusinessSafekeyLabelControl" runat="server" Text="Safekey:" />
					<asp:TextBox ID="PaymentGatewaysPayUBusinessSafekeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUBusinessPaymentMethodsLabelControl" runat="server" Text="Payment methods:" />
					<asp:TextBox ID="PaymentGatewaysPayUBusinessPaymentMethodsTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUBusinessTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayUBusinessTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PayUEnterpriseView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUEnterpriseUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPayUEnterpriseUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUEnterprisePasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPayUEnterprisePasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUEnterpriseSafekeyLabelControl" runat="server" Text="Safekey:" />
					<asp:TextBox ID="PaymentGatewaysPayUEnterpriseSafekeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPayUEnterpriseTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPayUEnterpriseTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PeachXmlIntegratorView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorSenderLabelControl" runat="server" Text="Sender:" />
					<asp:TextBox ID="PaymentGatewaysPeachXmlIntegratorSenderTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorLoginLabelControl" runat="server" Text="Login:" />
					<asp:TextBox ID="PaymentGatewaysPeachXmlIntegratorLoginTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorPasswordKeyLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPeachXmlIntegratorPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorRegistrationChannelLabelControl" runat="server" Text="Registration channel:" />
					<asp:TextBox ID="PaymentGatewaysPeachXmlIntegratorRegistrationChannelTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorPaymentChannelLabelControl" runat="server" Text="Payment channel:" />
					<asp:TextBox ID="PaymentGatewaysPeachXmlIntegratorPaymentChannelTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPeachXmlIntegratorTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPeachXmlIntegratorTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PrincetonCardConnectView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPrincetonCardConnectMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysPrincetonCardConnectMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPrincetonCardConnectUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysPrincetonCardConnectUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPrincetonCardConnectPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysPrincetonCardConnectPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPrincetonCardConnectGatewayUrlLabelControl" runat="server" Text="Web service Url:" />
					<asp:TextBox ID="PaymentGatewaysPrincetonCardConnectGatewayUrlTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPrincetonCardConnectTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPrincetonCardConnectTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="PSiGateXMLMessengerView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPSiGateXmlMessengerStoreIDLabelControl" runat="server" Text="Store ID:" />
					<asp:TextBox ID="PaymentGatewaysPSiGateXmlMessengerStoreIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPSiGateXmlMessengerPassphraseLabelControl" runat="server" Text="Passphrase:" />
					<asp:TextBox ID="PaymentGatewaysPSiGateXmlMessengerPassphraseTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysPSiGateXmlMessengerTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysPSiGateXmlMessengerTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="SageDirectView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSageDirectMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysSageDirectMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSageDirectMerchantKeyLabelControl" runat="server" Text="Merchant key:" />
					<asp:TextBox ID="PaymentGatewaysSageDirectMerchantKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="SagePayDirectView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayDirectVendorNameLabelControl" runat="server" Text="Vendor name:" />
					<asp:TextBox ID="PaymentGatewaysSagePayDirectVendorNameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayDirectSimulationModeLabelControl" runat="server" Text="Simulation mode:" HelpText="Only run in simulation mode if your gateway provided you with a separate simulation account. Under simulation mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysSagePayDirectSimulationModeCheckBox" runat="server" />
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayDirectTestModeLabelControl3" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysSagePayDirectTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="SagePayFormView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayFormVendorNameLabelControl" runat="server" Text="Vendor name:" />
					<asp:TextBox ID="PaymentGatewaysSagePayFormVendorNameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayFormEncryptionPasswordLabelControl" runat="server" Text="Encryption password:" />
					<asp:TextBox ID="PaymentGatewaysSagePayFormEncryptionPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSagePayFormTestModeLabelControl3" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysSagePayFormTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="StripeView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysStripeSecretKeyLabelControl" runat="server" Text="Secret key:" />
					<asp:TextBox ID="PaymentGatewaysStripeSecretKeyTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysStripePublishableKeyLabelControl" runat="server" Text="Publishable key:" />
					<asp:TextBox ID="PaymentGatewaysStripePublishableKeyTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="SuomenVerkkomaksutView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSuomenVerkkomaksutMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysSuomenVerkkomaksutMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSuomenVerkkomaksutSecretCodeLabelControl" runat="server" Text="Secret Key:" />
					<asp:TextBox ID="PaymentGatewaysSuomenVerkkomaksutSecretCodeTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysSuomenVerkkomaksutTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysSuomenVerkkomaksutTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
            <asp:View ID="TotalAppsDirectPostView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysTotalAppsDirectPostUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysTotalAppsDirectPostUsernameTextBox" runat="server" MaxLength="255"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysTotalAppsDirectPostPasswordKeyLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysTotalAppsDirectPostPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="TowahView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysTowahMerchantIDLabelControl" runat="server" Text="Merchant ID:" />
					<asp:TextBox ID="PaymentGatewaysTowahMerchantIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysTowahSecretKeyLabelControl" runat="server" Text="Secret Key:" />
					<asp:TextBox ID="PaymentGatewaysTowahSecretKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysTowahTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysTowahTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="USAePayView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysUSAePaySourceKeyLabelControl" runat="server" Text="Source Key:" />
					<asp:TextBox ID="PaymentGatewaysUSAePaySourceKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysUSAePayTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysUSAePayTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="VirtualCardServicesPayView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysVirtualCardServicesPayTerminalIDLabelControl" runat="server" Text="Terminal ID:" />
					<asp:TextBox ID="PaymentGatewaysVirtualCardServicesPayTerminalIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysVirtualCardServicesPayMD5KeyLabelControl" runat="server" Text="MD5 Key:" />
					<asp:TextBox ID="PaymentGatewaysVirtualCardServicesPayMD5KeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysVirtualCardServicesPayUsernameLabelControl" runat="server" Text="Username:" />
					<asp:TextBox ID="PaymentGatewaysVirtualCardServicesPayUsernameTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysVirtualCardServicesPayPasswordLabelControl" runat="server" Text="Password:" />
					<asp:TextBox ID="PaymentGatewaysVirtualCardServicesPayPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
			</asp:View>
			<asp:View ID="WorldPayCorporateXMLDirectView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysWorldPayCorporateXmlDirectMerchantCodeLabelControl" runat="server" Text="Merchant code:" />
					<asp:TextBox ID="PaymentGatewaysWorldPayCorporateXmlDirectMerchantCodeTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysWorldPayCorporateXmlDirectXmlPasswordLabelControl" runat="server" Text="XML password:" />
					<asp:TextBox ID="PaymentGatewaysWorldPayCorporateXmlDirectXmlPasswordTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysWorldPayCorporateXmlDirectTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysWorldPayCorporateXmlDirectTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
			<asp:View ID="ZoozView" runat="server">
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysZoozUniqueIDLabelControl" runat="server" Text="Unique ID:" />
					<asp:TextBox ID="PaymentGatewaysZoozUniqueIDTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysZoozAppKeyLabelControl" runat="server" Text="App key:" />
					<asp:TextBox ID="PaymentGatewaysZoozAppKeyTextBox" runat="server" MaxLength="256"></asp:TextBox>
				</div>
				<div class="dnnFormItem">
					<dnn1:LabelControl ID="PaymentGatewaysZoozTestModeLabelControl" runat="server" Text="Test mode:" HelpText="Only run in test mode if your gateway provided you with a separate test account. Under test mode, the system will attempt to transact with the gateway's sandbox server." />
					<asp:CheckBox ID="PaymentGatewaysZoozTestModeCheckBox" runat="server" />
				</div>
			</asp:View>
		</asp:MultiView>
	</fieldset>
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
</asp:Panel>
