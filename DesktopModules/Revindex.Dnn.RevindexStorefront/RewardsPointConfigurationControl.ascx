<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RewardsPointConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RewardsPointConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>
	Rewards point</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointMonetaryRateLabelControl" runat="server" Text="Monetary value of each point:" HelpText="How much each point is actually worth in money terms. This rate will be used for calculating the equivalent amount of money used for redeeming the points." CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="RewardsPointMonetaryRateRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointMonetaryRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointMonetaryRateDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0.00" MinValue="0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointRewardOrderActiveLabelControl" runat="server" Text="Reward points for orders:" HelpText="Reward points for checkout based on the subtotal amount before shipping, handling and taxes." />
			<asp:CheckBox ID="RewardsPointRewardOrderActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointRewardOrderMinAmountLabelControl" runat="server" Text="Reward points min order amount:" HelpText="The minimum subtotal amount must be attained before awarding points." CssClass="dnnFormRequired" />
			<asp:RequiredFieldValidator ID="RewardsPointRewardOrderMinAmountRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointRewardOrderMinAmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointRewardOrderMinAmountDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0.00" MinValue="0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointRewardOrderPointRateLabelControl" runat="server" CssClass="dnnFormRequired" Text="Points to award per order unit amount:" HelpText="The number of points to award for each currency unit spent on checkout for qualified products based on the order amount after discounts, but before shipping, handling and taxes. If the rate is equal to 1, then 1 point is awarded for each dollar spent. This rate can also be fractional to encourage customer to spend more. If the rate is 0.1, then 1 point is awarded for each 10 dollars spent, but if the customer spent 12 dollars, only 1 point is awarded." />
			<asp:RequiredFieldValidator ID="RewardsPointRewardOrderPointRateRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointRewardOrderPointRateDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointRewardOrderPointRateDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0.00" MinValue="0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointRewardOrderDelayLabelControl" runat="server" Text="Reward points delay:" CssClass="dnnFormRequired" HelpText="The number of days to delay rewarding the points for an order purchased. This is a security measure to protect the merchant from fraudulent customers who purchase products solely to earn points and returning the products after the points have been redeemed. For example, if you have a 30 days refund policy, you may want to set the delay equal to 30 days." />
			<asp:RequiredFieldValidator ID="RewardsPointRewardOrderDelayRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointRewardOrderDelayDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Delay is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointRewardOrderDelayDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0" MinValue="0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointRedeemMinPointQuantityLabelControl" runat="server" CssClass="dnnFormRequired" Text="Min. points to allow redeeming:" HelpText="The minimum number of points the customer must have to be allowed to redeem for purchases." />
			<asp:RequiredFieldValidator ID="RewardsPointRedeemMinPointQuantityRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointRedeemMinPointQuantityDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointRedeemMinPointQuantityDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0" MinValue="0" CssClass="dnnFormRequired">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RewardsPointExpiryIntervalLabelControl" runat="server" CssClass="dnnFormRequired" Text="Points expiration:" HelpText="Enter a non-zero value if the points should expire after the period of inactivity. A zero value indicates the points will never expire." />
			<asp:RequiredFieldValidator ID="RewardsPointExpiryIntervalRequiredFieldValidator" runat="server" ControlToValidate="RewardsPointExpiryIntervalDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Expiry is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="RewardsPointExpiryIntervalDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0" MinValue="0" CssClass="dnnFormRequired rvdQuantityInput">
			</dnn2:DnnNumericTextBox>
			<asp:DropDownList ID="RewardsPointExpiryIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
				<asp:ListItem Value="1">Day</asp:ListItem>
				<asp:ListItem Value="2">Week</asp:ListItem>
				<asp:ListItem Value="3">Month</asp:ListItem>
				<asp:ListItem Value="4">Year</asp:ListItem>
			</asp:DropDownList>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
