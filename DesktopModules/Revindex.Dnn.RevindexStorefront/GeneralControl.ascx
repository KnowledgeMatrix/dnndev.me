<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GeneralControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.GeneralControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/urlcontrol.ascx" TagName="UrlControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>General</h2>
<p>Tell us about your business and enable the features you need to make your store awesome!</p>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<script type="text/javascript">
	jQuery(function ($)
	{
		$('#<%= DetailsViewPanel.ClientID %>').dnnPanels();
	});
</script>
<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
	<h2 id="AddressFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Store address</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStoreNameLabelControl" runat="server" Text="Business name:" />
			<asp:TextBox ID="GeneralStoreNameTextBox" runat="server" MaxLength="100"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStoreCountryCodeLabelControl" runat="server" Text="Country:" />
			<asp:DropDownList ID="GeneralStoreCountryDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="GeneralStoreCountryDropDownList_SelectedIndexChanged">
				<asp:ListItem Text="Afghanistan" Value="AF" />
				<asp:ListItem Text="&#197;land Islands" Value="AX" />
				<asp:ListItem Text="Albania" Value="AL" />
				<asp:ListItem Text="Algeria" Value="DZ" />
				<asp:ListItem Text="American Samoa" Value="AS" />
				<asp:ListItem Text="Andorra" Value="AD" />
				<asp:ListItem Text="Angola" Value="AO" />
				<asp:ListItem Text="Anguilla" Value="AI" />
				<asp:ListItem Text="Antarctica" Value="AQ" />
				<asp:ListItem Text="Antigua and Barbuda" Value="AG" />
				<asp:ListItem Text="Argentina" Value="AR" />
				<asp:ListItem Text="Armenia" Value="AM" />
				<asp:ListItem Text="Aruba" Value="AW" />
				<asp:ListItem Text="Australia" Value="AU" />
				<asp:ListItem Text="Austria" Value="AT" />
				<asp:ListItem Text="Azerbaijan" Value="AZ" />
				<asp:ListItem Text="Bahamas" Value="BS" />
				<asp:ListItem Text="Bahrain" Value="BH" />
				<asp:ListItem Text="Bangladesh" Value="BD" />
				<asp:ListItem Text="Barbados" Value="BB" />
				<asp:ListItem Text="Belarus" Value="BY" />
				<asp:ListItem Text="Belgium" Value="BE" />
				<asp:ListItem Text="Belize" Value="BZ" />
				<asp:ListItem Text="Benin" Value="BJ" />
				<asp:ListItem Text="Bermuda" Value="BM" />
				<asp:ListItem Text="Bhutan" Value="BT" />
				<asp:ListItem Text="Bolivia" Value="BO" />
				<asp:ListItem Text="Bosnia and Herzegovina" Value="BA" />
				<asp:ListItem Text="Botswana" Value="BW" />
				<asp:ListItem Text="Bouvet Island" Value="BV" />
				<asp:ListItem Text="Brazil" Value="BR" />
				<asp:ListItem Text="British Indian Ocean Territory" Value="IO" />
				<asp:ListItem Text="Brunei Darussalam" Value="BN" />
				<asp:ListItem Text="Bulgaria" Value="BG" />
				<asp:ListItem Text="Burkina Faso" Value="BF" />
				<asp:ListItem Text="Burundi" Value="BI" />
				<asp:ListItem Text="Cambodia" Value="KH" />
				<asp:ListItem Text="Cameroon" Value="CM" />
				<asp:ListItem Text="Canada" Value="CA" />
				<asp:ListItem Text="Cape Verde" Value="CV" />
				<asp:ListItem Text="Cayman Islands" Value="KY" />
				<asp:ListItem Text="Central African Republic" Value="CF" />
				<asp:ListItem Text="Chad" Value="TD" />
				<asp:ListItem Text="Chile" Value="CL" />
				<asp:ListItem Text="China" Value="CN" />
				<asp:ListItem Text="Christmas Island" Value="CX" />
				<asp:ListItem Text="Cocos (Keeling) Islands" Value="CC" />
				<asp:ListItem Text="Colombia" Value="CO" />
				<asp:ListItem Text="Comoros" Value="KM" />
				<asp:ListItem Text="Congo" Value="CG" />
				<asp:ListItem Text="Congo, The Democratic Republic Of The" Value="CD" />
				<asp:ListItem Text="Cook Islands" Value="CK" />
				<asp:ListItem Text="Costa Rica" Value="CR" />
				<asp:ListItem Text="C&#244;te D'Ivoire" Value="CI" />
				<asp:ListItem Text="Croatia" Value="HR" />
				<asp:ListItem Text="Cuba" Value="CU" />
				<asp:ListItem Text="Cyprus" Value="CY" />
				<asp:ListItem Text="Czech Republic" Value="CZ" />
				<asp:ListItem Text="Denmark" Value="DK" />
				<asp:ListItem Text="Djibouti" Value="DJ" />
				<asp:ListItem Text="Dominica" Value="DM" />
				<asp:ListItem Text="Dominican Republic" Value="DO" />
				<asp:ListItem Text="Ecuador" Value="EC" />
				<asp:ListItem Text="Egypt" Value="EG" />
				<asp:ListItem Text="El Salvador" Value="SV" />
				<asp:ListItem Text="Equatorial Guinea" Value="GQ" />
				<asp:ListItem Text="Eritrea" Value="ER" />
				<asp:ListItem Text="Estonia" Value="EE" />
				<asp:ListItem Text="Ethiopia" Value="ET" />
				<asp:ListItem Text="Falkland Islands  (Malvinas)" Value="FK" />
				<asp:ListItem Text="Faroe Islands" Value="FO" />
				<asp:ListItem Text="Fiji" Value="FJ" />
				<asp:ListItem Text="Finland" Value="FI" />
				<asp:ListItem Text="France" Value="FR" />
				<asp:ListItem Text="French Guiana" Value="GF" />
				<asp:ListItem Text="French Polynesia" Value="PF" />
				<asp:ListItem Text="French Southern Territories" Value="TF" />
				<asp:ListItem Text="Gabon" Value="GA" />
				<asp:ListItem Text="Gambia" Value="GM" />
				<asp:ListItem Text="Georgia" Value="GE" />
				<asp:ListItem Text="Germany" Value="DE" />
				<asp:ListItem Text="Ghana" Value="GH" />
				<asp:ListItem Text="Gibraltar" Value="GI" />
				<asp:ListItem Text="Greece" Value="GR" />
				<asp:ListItem Text="Greenland" Value="GL" />
				<asp:ListItem Text="Grenada" Value="GD" />
				<asp:ListItem Text="Guadeloupe" Value="GP" />
				<asp:ListItem Text="Guam" Value="GU" />
				<asp:ListItem Text="Guatemala" Value="GT" />
				<asp:ListItem Text="Guernsey" Value="GG" />
				<asp:ListItem Text="Guinea" Value="GN" />
				<asp:ListItem Text="Guinea-Bissau" Value="GW" />
				<asp:ListItem Text="Guyana" Value="GY" />
				<asp:ListItem Text="Haiti" Value="HT" />
				<asp:ListItem Text="Heard and McDonald Islands" Value="HM" />
				<asp:ListItem Text="Holy See (Vatican City State)" Value="VA" />
				<asp:ListItem Text="Honduras" Value="HN" />
				<asp:ListItem Text="Hong Kong" Value="HK" />
				<asp:ListItem Text="Hungary" Value="HU" />
				<asp:ListItem Text="Iceland" Value="IS" />
				<asp:ListItem Text="India" Value="IN" />
				<asp:ListItem Text="Indonesia" Value="ID" />
				<asp:ListItem Text="Iran, Islamic Republic Of" Value="IR" />
				<asp:ListItem Text="Iraq" Value="IQ" />
				<asp:ListItem Text="Ireland" Value="IE" />
				<asp:ListItem Text="Isle of Man" Value="IM" />
				<asp:ListItem Text="Israel" Value="IL" />
				<asp:ListItem Text="Italy" Value="IT" />
				<asp:ListItem Text="Jamaica" Value="JM" />
				<asp:ListItem Text="Japan" Value="JP" />
				<asp:ListItem Text="Jersey" Value="JE" />
				<asp:ListItem Text="Jordan" Value="JO" />
				<asp:ListItem Text="Kazakhstan" Value="KZ" />
				<asp:ListItem Text="Kenya" Value="KE" />
				<asp:ListItem Text="Kiribati" Value="KI" />
				<asp:ListItem Text="Korea, Democratic People's Republic Of" Value="KP" />
				<asp:ListItem Text="Korea, Republic of" Value="KR" />
				<asp:ListItem Text="Kuwait" Value="KW" />
				<asp:ListItem Text="Kyrgyzstan" Value="KG" />
				<asp:ListItem Text="Lao People's Democratic Republic" Value="LA" />
				<asp:ListItem Text="Latvia" Value="LV" />
				<asp:ListItem Text="Lebanon" Value="LB" />
				<asp:ListItem Text="Lesotho" Value="LS" />
				<asp:ListItem Text="Liberia" Value="LR" />
				<asp:ListItem Text="Libyan Arab Jamahiriya" Value="LY" />
				<asp:ListItem Text="Liechtenstein" Value="LI" />
				<asp:ListItem Text="Lithuania" Value="LT" />
				<asp:ListItem Text="Luxembourg" Value="LU" />
				<asp:ListItem Text="Macao" Value="MO" />
				<asp:ListItem Text="Macedonia, the Former Yugoslav Republic Of" Value="MK" />
				<asp:ListItem Text="Madagascar" Value="MG" />
				<asp:ListItem Text="Malawi" Value="MW" />
				<asp:ListItem Text="Malaysia" Value="MY" />
				<asp:ListItem Text="Maldives" Value="MV" />
				<asp:ListItem Text="Mali" Value="ML" />
				<asp:ListItem Text="Malta" Value="MT" />
				<asp:ListItem Text="Marshall Islands" Value="MH" />
				<asp:ListItem Text="Martinique" Value="MQ" />
				<asp:ListItem Text="Mauritania" Value="MR" />
				<asp:ListItem Text="Mauritius" Value="MU" />
				<asp:ListItem Text="Mayotte" Value="YT" />
				<asp:ListItem Text="Mexico" Value="MX" />
				<asp:ListItem Text="Micronesia, Federated States Of" Value="FM" />
				<asp:ListItem Text="Moldova, Republic of" Value="MD" />
				<asp:ListItem Text="Monaco" Value="MC" />
				<asp:ListItem Text="Mongolia" Value="MN" />
				<asp:ListItem Text="Montenegro" Value="ME" />
				<asp:ListItem Text="Montserrat" Value="MS" />
				<asp:ListItem Text="Morocco" Value="MA" />
				<asp:ListItem Text="Mozambique" Value="MZ" />
				<asp:ListItem Text="Myanmar" Value="MM" />
				<asp:ListItem Text="Namibia" Value="NA" />
				<asp:ListItem Text="Nauru" Value="NR" />
				<asp:ListItem Text="Nepal" Value="NP" />
				<asp:ListItem Text="Netherlands" Value="NL" />
				<asp:ListItem Text="Netherlands Antilles" Value="AN" />
				<asp:ListItem Text="New Caledonia" Value="NC" />
				<asp:ListItem Text="New Zealand" Value="NZ" />
				<asp:ListItem Text="Nicaragua" Value="NI" />
				<asp:ListItem Text="Niger" Value="NE" />
				<asp:ListItem Text="Nigeria" Value="NG" />
				<asp:ListItem Text="Niue" Value="NU" />
				<asp:ListItem Text="Norfolk Island" Value="NF" />
				<asp:ListItem Text="Northern Mariana Islands" Value="MP" />
				<asp:ListItem Text="Norway" Value="NO" />
				<asp:ListItem Text="Oman" Value="OM" />
				<asp:ListItem Text="Pakistan" Value="PK" />
				<asp:ListItem Text="Palau" Value="PW" />
				<asp:ListItem Text="Palestinian Territory, Occupied" Value="PS" />
				<asp:ListItem Text="Panama" Value="PA" />
				<asp:ListItem Text="Papua New Guinea" Value="PG" />
				<asp:ListItem Text="Paraguay" Value="PY" />
				<asp:ListItem Text="Peru" Value="PE" />
				<asp:ListItem Text="Philippines" Value="PH" />
				<asp:ListItem Text="Pitcairn" Value="PN" />
				<asp:ListItem Text="Poland" Value="PL" />
				<asp:ListItem Text="Portugal" Value="PT" />
				<asp:ListItem Text="Puerto Rico" Value="PR" />
				<asp:ListItem Text="Qatar" Value="QA" />
				<asp:ListItem Text="R&#233;union" Value="RE" />
				<asp:ListItem Text="Romania" Value="RO" />
				<asp:ListItem Text="Russian Federation" Value="RU" />
				<asp:ListItem Text="Rwanda" Value="RW" />
				<asp:ListItem Text="Saint Barth&#233;lemy" Value="BL" />
				<asp:ListItem Text="Saint Helena" Value="SH" />
				<asp:ListItem Text="Saint Kitts And Nevis" Value="KN" />
				<asp:ListItem Text="Saint Lucia" Value="LC" />
				<asp:ListItem Text="Saint Martin" Value="MF" />
				<asp:ListItem Text="Saint Pierre And Miquelon" Value="PM" />
				<asp:ListItem Text="Saint Vincent And The Grenedines" Value="VC" />
				<asp:ListItem Text="Samoa" Value="WS" />
				<asp:ListItem Text="San Marino" Value="SM" />
				<asp:ListItem Text="Sao Tome and Principe" Value="ST" />
				<asp:ListItem Text="Saudi Arabia" Value="SA" />
				<asp:ListItem Text="Senegal" Value="SN" />
				<asp:ListItem Text="Serbia" Value="RS" />
				<asp:ListItem Text="Seychelles" Value="SC" />
				<asp:ListItem Text="Sierra Leone" Value="SL" />
				<asp:ListItem Text="Singapore" Value="SG" />
				<asp:ListItem Text="Slovakia" Value="SK" />
				<asp:ListItem Text="Slovenia" Value="SI" />
				<asp:ListItem Text="Solomon Islands" Value="SB" />
				<asp:ListItem Text="Somalia" Value="SO" />
				<asp:ListItem Text="South Africa" Value="ZA" />
				<asp:ListItem Text="South Georgia and the South Sandwich Islands" Value="GS" />
				<asp:ListItem Text="Spain" Value="ES" />
				<asp:ListItem Text="Sri Lanka" Value="LK" />
				<asp:ListItem Text="Sudan" Value="SD" />
				<asp:ListItem Text="Suriname" Value="SR" />
				<asp:ListItem Text="Svalbard And Jan Mayen" Value="SJ" />
				<asp:ListItem Text="Swaziland" Value="SZ" />
				<asp:ListItem Text="Sweden" Value="SE" />
				<asp:ListItem Text="Switzerland" Value="CH" />
				<asp:ListItem Text="Syrian Arab Republic" Value="SY" />
				<asp:ListItem Text="Taiwan, Province Of China" Value="TW" />
				<asp:ListItem Text="Tajikistan" Value="TJ" />
				<asp:ListItem Text="Tanzania, United Republic of" Value="TZ" />
				<asp:ListItem Text="Thailand" Value="TH" />
				<asp:ListItem Text="Timor-Leste" Value="TL" />
				<asp:ListItem Text="Togo" Value="TG" />
				<asp:ListItem Text="Tokelau" Value="TK" />
				<asp:ListItem Text="Tonga" Value="TO" />
				<asp:ListItem Text="Trinidad and Tobago" Value="TT" />
				<asp:ListItem Text="Tunisia" Value="TN" />
				<asp:ListItem Text="Turkey" Value="TR" />
				<asp:ListItem Text="Turkmenistan" Value="TM" />
				<asp:ListItem Text="Turks and Caicos Islands" Value="TC" />
				<asp:ListItem Text="Tuvalu" Value="TV" />
				<asp:ListItem Text="Uganda" Value="UG" />
				<asp:ListItem Text="Ukraine" Value="UA" />
				<asp:ListItem Text="United Arab Emirates" Value="AE" />
				<asp:ListItem Text="United Kingdom" Value="GB" />
				<asp:ListItem Text="United States" Value="US" />
				<asp:ListItem Text="United States Minor Outlying Islands" Value="UM" />
				<asp:ListItem Text="Uruguay" Value="UY" />
				<asp:ListItem Text="Uzbekistan" Value="UZ" />
				<asp:ListItem Text="Vanuatu" Value="VU" />
				<asp:ListItem Text="Venezuela, Bolivarian Republic of" Value="VE" />
				<asp:ListItem Text="Viet Nam" Value="VN" />
				<asp:ListItem Text="Virgin Islands, British" Value="VG" />
				<asp:ListItem Text="Virgin Islands, U.S." Value="VI" />
				<asp:ListItem Text="Wallis and Futuna" Value="WF" />
				<asp:ListItem Text="Western Sahara" Value="EH" />
				<asp:ListItem Text="Yemen" Value="YE" />
				<asp:ListItem Text="Zambia" Value="ZM" />
				<asp:ListItem Text="Zimbabwe" Value="ZW" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStoreStreetLabelControl" runat="server" Text="Street:" CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GeneralStoreStreetRequiredFieldValidator" runat="server" ControlToValidate="GeneralStoreStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="StreetRequiredFieldValidator" ValidationGroup="ConfigurationDetailsViewControl">Street is required.</asp:RequiredFieldValidator>
			<asp:RegularExpressionValidator ID="StreetRegularExpressionValidator" runat="server" ControlToValidate="GeneralStoreStreetTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="StreetRegularExpressionValidator" ValidationExpression="^[\s\S]{0,200}$" ValidationGroup="ConfigurationDetailsViewControl">Street is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="GeneralStoreStreetTextBox" runat="server" MaxLength="100" Rows="2" TextMode="MultiLine" CssClass="dnnFormRequired" Wrap="False"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStoreCityLabelControl" runat="server" Text="City:" CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GeneralStoreCityRequiredFieldValidator" runat="server" ControlToValidate="GeneralStoreCityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="PostalCodeRequiredFieldValidator" ValidationGroup="ConfigurationDetailsViewControl">City is required.</asp:RequiredFieldValidator>
			<asp:TextBox ID="GeneralStoreCityTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStoreSubdivisionCodeLabelControl" runat="server" Text="State/province:" />
			<asp:DropDownList ID="GeneralStoreSubdivisionDropDownList" runat="server" >
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralStorePostalCodeLabelControl" runat="server" Text="Postal code:" CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GeneralStorePostalCodeRequiredFieldValidator" runat="server" ControlToValidate="GeneralStorePostalCodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" resourcekey="PostalCodeRequiredFieldValidator" ValidationGroup="ConfigurationDetailsViewControl">Postal code is required.</asp:RequiredFieldValidator>
			<asp:TextBox ID="GeneralStorePostalCodeTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralEmailRecipientLabelControl" runat="server" HelpText="The default email address used to receive various communications from the Storefront (e.g. order alerts, etc)." Text="Email recipient:" CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="GeneralEmailRecipientTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Email is required.</asp:RequiredFieldValidator>
			<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="GeneralEmailRecipientTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^(\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*|(&quot;*[\w ]*&quot;*\s*)&lt;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*&gt;)$" ValidationGroup="ConfigurationDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="GeneralEmailRecipientTextBox" runat="server" MaxLength="256" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralEmailSenderLabelControl" runat="server" Text="Email sender:" HelpText="The default email address used to send out various communications." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="GeneralEmailSenderTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Email is required.</asp:RequiredFieldValidator>
			<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="GeneralEmailSenderTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^(\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*|(&quot;*[\w ]*&quot;*\s*)&lt;\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*&gt;)$" ValidationGroup="ConfigurationDetailsViewControl">Email is invalid.</asp:RegularExpressionValidator>
			<asp:TextBox ID="GeneralEmailSenderTextBox" runat="server" MaxLength="256" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
	</fieldset>
	<script type="text/javascript">
		$(document).ready(function ()
		{
			// Expand features section by default
			if (document.cookie.indexOf("FeaturesFormSectionHead") < 0)
				$("#FeaturesFormSectionHead > a").click();
		});
	</script>
	<h2 id="FeaturesFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded" name="FeaturesAnchor">Features</a></h2>
	<fieldset>
		<p>
			The Storefront has many powerful features to help you sell more. Enable just the right features you need to keep your site fast and streamlined.
		</p>
		<div class="dnnFormItem">
			<dnn1:LabelControl runat="server" Text=""/>
			<a class="dnnTertiaryAction" href="#" onclick="$('.rvdsfFeaturesContainer').find('input').prop('checked', true); return false;" >Select all</a>
			<a class="dnnTertiaryAction" href="#" onclick="$('.rvdsfFeaturesContainer').find('input').prop('checked', false); return false;" >Deselect all</a>
		</div>
		<div class="rvdsfFeaturesContainer">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="AddressValidationActiveLabelControl" runat="server" Text="Address validation:" HelpText="Validate and normalize customer address."/>
				<asp:CheckBox ID="AddressValidationActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="AnalyticsActiveLabelControl" runat="server" Text="Analytics:" HelpText="Track user browsing conversion and statistics."/>
				<asp:CheckBox ID="AnalyticsActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ApiActiveLabelControl" runat="server" Text="API:" HelpText="Allow external application to access the storefront data programmatically. For security reasons, it is recommended that you disable API access." />
				<asp:CheckBox ID="ApiActiveCheckBox" runat="server"/>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="CartActiveLabelControl" runat="server" Text="Cart:" HelpText="Allow advanced configuration for the cart module." />
				<asp:CheckBox ID="CartActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="CartSummaryActiveLabelControl" runat="server" Text="Cart summary:" HelpText="Allow advanced configuration for the cart summary module."/>
				<asp:CheckBox ID="CartSummaryActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ChannelActiveLabelControl" runat="server" Text="Channel:" HelpText="Allow promoting products on other channels (e.g. eBay)."/>
				<asp:CheckBox ID="ChannelActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="CheckoutActiveLabelControl" runat="server" Text="Checkout:" HelpText="Allow advanced configuration for the checkout module."/>
				<asp:CheckBox ID="CheckoutActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ConfirmationActiveLabelControl" runat="server" Text="Confirmation:" HelpText="Allow advanced configuration for the confirmation module."/>
				<asp:CheckBox ID="ConfirmationActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="CrosssellProductActiveLabelControl" runat="server" Text="Cross-sell products:" HelpText="Cross-sell products to customers during checkout."/>
				<asp:CheckBox ID="CrosssellProductActiveCheckBox" runat="server" />
			</div>
			<asp:Panel ID="DisplayTemplatePanel" runat="server" CssClass="dnnFormItem">
				<dnn1:LabelControl ID="DisplayTemplateActiveLabelControl" runat="server" Text="Display template:" HelpText="Allow customizing the look-and-feel of modules."/>
				<asp:CheckBox ID="DisplayTemplateActiveCheckBox" runat="server" />
			</asp:Panel>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="DistributorActiveLabelControl" runat="server" Text="Distributor:" HelpText="Allow associating products to distributors."/>
				<asp:CheckBox ID="DistributorActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="FulfillmentActiveLabelControl" runat="server" Text="Fulfillment:" HelpText="Allow automatic fulfilling of orders."/>
				<asp:CheckBox ID="FulfillmentActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="HandlingActiveLabelControl" runat="server" Text="Handling:" HelpText="Allow charging a handling fee on checkout." />
				<asp:CheckBox ID="HandlingActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ManufacturerActiveLabelControl" runat="server" Text="Manufacturer:" HelpText="Allow associating products to manufacturers."/>
				<asp:CheckBox ID="ManufacturerActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="SellerMarketplaceActiveLabelControl" runat="server" Text="Marketplace:" HelpText="Markeplace allows 3rd party sellers (vendors) to list their products for sale on your site."/>
				<asp:CheckBox ID="SellerMarketplaceActiveCheckBox" runat="server"/>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="PackingActiveLabelControl" runat="server" Text="Packing:" HelpText="Optimize shipping rates calculation by packing efficiently."/>
				<asp:CheckBox ID="PackingActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductComparisonActiveLabelControl" runat="server" Text="Product comparison:" HelpText="Allow comparing products side by side."/>
				<asp:CheckBox ID="ProductComparisonActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductDetailActiveLabelControl" runat="server" Text="Product detail:" HelpText="Allow advanced configuration for the product detail module."/>
				<asp:CheckBox ID="ProductDetailActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductFilterActiveLabelControl" runat="server" Text="Product filter:" HelpText="Allow advanced configuration for the product filter module."/>
				<asp:CheckBox ID="ProductFilterActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductListActiveLabelControl" runat="server" Text="Product list:" HelpText="Allow advanced configuration for the product list module."/>
				<asp:CheckBox ID="ProductListActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductSearchActiveLabelControl" runat="server" Text="Product search:" HelpText="Allow advanced configuration for the product search module."/>
				<asp:CheckBox ID="ProductSearchActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductShowcaseActiveLabelControl" runat="server" Text="Product showcase:" HelpText="Allow advanced configuration for the product showcase module."/>
				<asp:CheckBox ID="ProductShowcaseActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="QuickOrderActiveLabelControl" runat="server" Text="Quick order:" HelpText="Allow advanced configuration for the quick order module."/>
				<asp:CheckBox ID="QuickOrderActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RecurringSalesOrderActiveLabelControl" runat="server" Text="Recurring orders:" HelpText="Allow recurring orders (subscriptions)."/>
				<asp:CheckBox ID="RecurringSalesOrderActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RewardsPointActiveLabelControl" runat="server" Text="Rewards points:" HelpText="Allow customers to earn rewards points for their purchases."/>
				<asp:CheckBox ID="RewardsPointActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RightActiveLabelControl" runat="server" Text="Rights:" HelpText="Allow granting rights (license key, serial number, etc.) normally for authorizing software or the use of downloadable products."/>
				<asp:CheckBox ID="RightActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RiskActiveLabelControl" runat="server" Text="Risk:" HelpText="Allow fraud score risk assessment."/>
				<asp:CheckBox ID="RiskActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="SalesOrderActiveLabelControl" runat="server" Text="Sales order:" HelpText="Allow advanced configuration for sales orders."/>
				<asp:CheckBox ID="SalesOrderActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ShippingActiveLabelControl" runat="server" Text="Shipping:" HelpText="Allow charging a shipping fee on checkout."/>
				<asp:CheckBox ID="ShippingActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="UserPaymentActiveLabelControl" runat="server" Text="User payment:" HelpText="Allow advanced configuration for user payments."/>
				<asp:CheckBox ID="UserPaymentActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="VoucherActiveLabelControl" runat="server" Text="Voucher:" HelpText="Offer vouchers (gift cards/certificates) to be used as money."/>
				<asp:CheckBox ID="VoucherActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WarehouseActiveLabelControl" runat="server" Text="Warehouse:" HelpText="Allow associating products to warehouses. This feature is useful for dropshipping or if you ship products out from a different location than your primary store address."/>
				<asp:CheckBox ID="WarehouseActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WishListActiveLabelControl" runat="server" Text="Wish list:" HelpText="Allow advanced configuration for the wish list module."/>
				<asp:CheckBox ID="WishListActiveCheckBox" runat="server" />
			</div>
            <div class="dnnFormItem">
				<dnn1:LabelControl ID="GeneralStringTokenizerActiveLabelControl" runat="server" Text="Replace tokens:" HelpText="Automatically detect and replace known tokens using MyTokens or DNN tokens on common text areas such as description, rules, etc.."/>
				<asp:CheckBox ID="GeneralStringTokenizerActiveCheckBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="GeneralObjectKeyShowLabelControl" runat="server" Text="Show object key:" HelpText="The object's unique key makes it easy to reference associated objects in the import/export file."/>
				<asp:CheckBox ID="GeneralObjectKeyShowCheckBox" runat="server" />
			</div>
		</div>
	</fieldset>
	<h2 id="StandardsFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Standards</a></h2>
	<fieldset>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralPriceDisplayModeLabelControl" runat="server" HelpText="Configure how prices should be displayed with or without tax usually for VAT tax compliance." Text="Price display mode:" />
			<asp:DropDownList ID="GeneralPriceDisplayModeDropDownList" runat="server">
				<asp:ListItem Text="Show Price" Value="1" />
				<asp:ListItem Text="Show Price Tax Inclusive" Value="2" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralUnitsLengthLabelControl" runat="server" Text="Length unit:" HelpText="The default unit of measure." />
			<asp:DropDownList ID="GeneralUnitsLengthDropDownList" runat="server">
				<asp:ListItem Text="Centimeter" Value="Centimeter"></asp:ListItem>
				<asp:ListItem Text="Feet" Value="Feet"></asp:ListItem>
				<asp:ListItem Text="Inch" Value="Inch"></asp:ListItem>
				<asp:ListItem Text="Meter" Value="Meter"></asp:ListItem>
				<asp:ListItem Text="Millimeter" Value="Millimeter"></asp:ListItem>
				<asp:ListItem Text="Yard" Value="Yard"></asp:ListItem>
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralUnitsMassLabelControl" runat="server" Text="Weight unit:" HelpText="The default unit of measure." />
			<asp:DropDownList ID="GeneralUnitsMassDropDownList" runat="server">
				<asp:ListItem Text="Gram" Value="Gram"></asp:ListItem>
				<asp:ListItem Text="Kilogram" Value="Kilogram"></asp:ListItem>
				<asp:ListItem Text="Milligram" Value="Milligram"></asp:ListItem>
				<asp:ListItem Text="Pound" Value="Pound"></asp:ListItem>
				<asp:ListItem Text="Ounce" Value="Ounce"></asp:ListItem>
			</asp:DropDownList>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralProfileSubdivisionRequiredLabelControl" runat="server" Text="Require valid State/Province address:" HelpText="Require customer to enter a valid state/province region. It is recommended to keep this a required field as certain payment gateways and real-time shipping providers may require the information." />
			<asp:CheckBox ID="GeneralProfileSubdivisionRequiredCheckBox" runat="server" />
		</div>
	</fieldset>
	<h2 id="CountryFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Countries</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralCountryAllowedLabelControl" runat="server" Text="Allowed countries:" HelpText="Select the countries that are allowed to purchase from your store."/>
			<div style="height: 300px; overflow: auto; margin: 20px">
				<asp:CheckBoxList ID="GeneralCountryAllowedCheckBoxList" runat="server">
					<asp:ListItem Text="Afghanistan" Value="AF" />
					<asp:ListItem Text="&#197;land Islands" Value="AX" />
					<asp:ListItem Text="Albania" Value="AL" />
					<asp:ListItem Text="Algeria" Value="DZ" />
					<asp:ListItem Text="American Samoa" Value="AS" />
					<asp:ListItem Text="Andorra" Value="AD" />
					<asp:ListItem Text="Angola" Value="AO" />
					<asp:ListItem Text="Anguilla" Value="AI" />
					<asp:ListItem Text="Antarctica" Value="AQ" />
					<asp:ListItem Text="Antigua and Barbuda" Value="AG" />
					<asp:ListItem Text="Argentina" Value="AR" />
					<asp:ListItem Text="Armenia" Value="AM" />
					<asp:ListItem Text="Aruba" Value="AW" />
					<asp:ListItem Text="Australia" Value="AU" />
					<asp:ListItem Text="Austria" Value="AT" />
					<asp:ListItem Text="Azerbaijan" Value="AZ" />
					<asp:ListItem Text="Bahamas" Value="BS" />
					<asp:ListItem Text="Bahrain" Value="BH" />
					<asp:ListItem Text="Bangladesh" Value="BD" />
					<asp:ListItem Text="Barbados" Value="BB" />
					<asp:ListItem Text="Belarus" Value="BY" />
					<asp:ListItem Text="Belgium" Value="BE" />
					<asp:ListItem Text="Belize" Value="BZ" />
					<asp:ListItem Text="Benin" Value="BJ" />
					<asp:ListItem Text="Bermuda" Value="BM" />
					<asp:ListItem Text="Bhutan" Value="BT" />
					<asp:ListItem Text="Bolivia" Value="BO" />
					<asp:ListItem Text="Bosnia and Herzegovina" Value="BA" />
					<asp:ListItem Text="Botswana" Value="BW" />
					<asp:ListItem Text="Bouvet Island" Value="BV" />
					<asp:ListItem Text="Brazil" Value="BR" />
					<asp:ListItem Text="British Indian Ocean Territory" Value="IO" />
					<asp:ListItem Text="Brunei Darussalam" Value="BN" />
					<asp:ListItem Text="Bulgaria" Value="BG" />
					<asp:ListItem Text="Burkina Faso" Value="BF" />
					<asp:ListItem Text="Burundi" Value="BI" />
					<asp:ListItem Text="Cambodia" Value="KH" />
					<asp:ListItem Text="Cameroon" Value="CM" />
					<asp:ListItem Text="Canada" Value="CA" />
					<asp:ListItem Text="Cape Verde" Value="CV" />
					<asp:ListItem Text="Cayman Islands" Value="KY" />
					<asp:ListItem Text="Central African Republic" Value="CF" />
					<asp:ListItem Text="Chad" Value="TD" />
					<asp:ListItem Text="Chile" Value="CL" />
					<asp:ListItem Text="China" Value="CN" />
					<asp:ListItem Text="Christmas Island" Value="CX" />
					<asp:ListItem Text="Cocos (Keeling) Islands" Value="CC" />
					<asp:ListItem Text="Colombia" Value="CO" />
					<asp:ListItem Text="Comoros" Value="KM" />
					<asp:ListItem Text="Congo" Value="CG" />
					<asp:ListItem Text="Congo, The Democratic Republic Of The" Value="CD" />
					<asp:ListItem Text="Cook Islands" Value="CK" />
					<asp:ListItem Text="Costa Rica" Value="CR" />
					<asp:ListItem Text="C&#244;te D'Ivoire" Value="CI" />
					<asp:ListItem Text="Croatia" Value="HR" />
					<asp:ListItem Text="Cuba" Value="CU" />
					<asp:ListItem Text="Cyprus" Value="CY" />
					<asp:ListItem Text="Czech Republic" Value="CZ" />
					<asp:ListItem Text="Denmark" Value="DK" />
					<asp:ListItem Text="Djibouti" Value="DJ" />
					<asp:ListItem Text="Dominica" Value="DM" />
					<asp:ListItem Text="Dominican Republic" Value="DO" />
					<asp:ListItem Text="Ecuador" Value="EC" />
					<asp:ListItem Text="Egypt" Value="EG" />
					<asp:ListItem Text="El Salvador" Value="SV" />
					<asp:ListItem Text="Equatorial Guinea" Value="GQ" />
					<asp:ListItem Text="Eritrea" Value="ER" />
					<asp:ListItem Text="Estonia" Value="EE" />
					<asp:ListItem Text="Ethiopia" Value="ET" />
					<asp:ListItem Text="Falkland Islands  (Malvinas)" Value="FK" />
					<asp:ListItem Text="Faroe Islands" Value="FO" />
					<asp:ListItem Text="Fiji" Value="FJ" />
					<asp:ListItem Text="Finland" Value="FI" />
					<asp:ListItem Text="France" Value="FR" />
					<asp:ListItem Text="French Guiana" Value="GF" />
					<asp:ListItem Text="French Polynesia" Value="PF" />
					<asp:ListItem Text="French Southern Territories" Value="TF" />
					<asp:ListItem Text="Gabon" Value="GA" />
					<asp:ListItem Text="Gambia" Value="GM" />
					<asp:ListItem Text="Georgia" Value="GE" />
					<asp:ListItem Text="Germany" Value="DE" />
					<asp:ListItem Text="Ghana" Value="GH" />
					<asp:ListItem Text="Gibraltar" Value="GI" />
					<asp:ListItem Text="Greece" Value="GR" />
					<asp:ListItem Text="Greenland" Value="GL" />
					<asp:ListItem Text="Grenada" Value="GD" />
					<asp:ListItem Text="Guadeloupe" Value="GP" />
					<asp:ListItem Text="Guam" Value="GU" />
					<asp:ListItem Text="Guatemala" Value="GT" />
					<asp:ListItem Text="Guernsey" Value="GG" />
					<asp:ListItem Text="Guinea" Value="GN" />
					<asp:ListItem Text="Guinea-Bissau" Value="GW" />
					<asp:ListItem Text="Guyana" Value="GY" />
					<asp:ListItem Text="Haiti" Value="HT" />
					<asp:ListItem Text="Heard and McDonald Islands" Value="HM" />
					<asp:ListItem Text="Holy See (Vatican City State)" Value="VA" />
					<asp:ListItem Text="Honduras" Value="HN" />
					<asp:ListItem Text="Hong Kong" Value="HK" />
					<asp:ListItem Text="Hungary" Value="HU" />
					<asp:ListItem Text="Iceland" Value="IS" />
					<asp:ListItem Text="India" Value="IN" />
					<asp:ListItem Text="Indonesia" Value="ID" />
					<asp:ListItem Text="Iran, Islamic Republic Of" Value="IR" />
					<asp:ListItem Text="Iraq" Value="IQ" />
					<asp:ListItem Text="Ireland" Value="IE" />
					<asp:ListItem Text="Isle of Man" Value="IM" />
					<asp:ListItem Text="Israel" Value="IL" />
					<asp:ListItem Text="Italy" Value="IT" />
					<asp:ListItem Text="Jamaica" Value="JM" />
					<asp:ListItem Text="Japan" Value="JP" />
					<asp:ListItem Text="Jersey" Value="JE" />
					<asp:ListItem Text="Jordan" Value="JO" />
					<asp:ListItem Text="Kazakhstan" Value="KZ" />
					<asp:ListItem Text="Kenya" Value="KE" />
					<asp:ListItem Text="Kiribati" Value="KI" />
					<asp:ListItem Text="Korea, Democratic People's Republic Of" Value="KP" />
					<asp:ListItem Text="Korea, Republic of" Value="KR" />
					<asp:ListItem Text="Kuwait" Value="KW" />
					<asp:ListItem Text="Kyrgyzstan" Value="KG" />
					<asp:ListItem Text="Lao People's Democratic Republic" Value="LA" />
					<asp:ListItem Text="Latvia" Value="LV" />
					<asp:ListItem Text="Lebanon" Value="LB" />
					<asp:ListItem Text="Lesotho" Value="LS" />
					<asp:ListItem Text="Liberia" Value="LR" />
					<asp:ListItem Text="Libyan Arab Jamahiriya" Value="LY" />
					<asp:ListItem Text="Liechtenstein" Value="LI" />
					<asp:ListItem Text="Lithuania" Value="LT" />
					<asp:ListItem Text="Luxembourg" Value="LU" />
					<asp:ListItem Text="Macao" Value="MO" />
					<asp:ListItem Text="Macedonia, the Former Yugoslav Republic Of" Value="MK" />
					<asp:ListItem Text="Madagascar" Value="MG" />
					<asp:ListItem Text="Malawi" Value="MW" />
					<asp:ListItem Text="Malaysia" Value="MY" />
					<asp:ListItem Text="Maldives" Value="MV" />
					<asp:ListItem Text="Mali" Value="ML" />
					<asp:ListItem Text="Malta" Value="MT" />
					<asp:ListItem Text="Marshall Islands" Value="MH" />
					<asp:ListItem Text="Martinique" Value="MQ" />
					<asp:ListItem Text="Mauritania" Value="MR" />
					<asp:ListItem Text="Mauritius" Value="MU" />
					<asp:ListItem Text="Mayotte" Value="YT" />
					<asp:ListItem Text="Mexico" Value="MX" />
					<asp:ListItem Text="Micronesia, Federated States Of" Value="FM" />
					<asp:ListItem Text="Moldova, Republic of" Value="MD" />
					<asp:ListItem Text="Monaco" Value="MC" />
					<asp:ListItem Text="Mongolia" Value="MN" />
					<asp:ListItem Text="Montenegro" Value="ME" />
					<asp:ListItem Text="Montserrat" Value="MS" />
					<asp:ListItem Text="Morocco" Value="MA" />
					<asp:ListItem Text="Mozambique" Value="MZ" />
					<asp:ListItem Text="Myanmar" Value="MM" />
					<asp:ListItem Text="Namibia" Value="NA" />
					<asp:ListItem Text="Nauru" Value="NR" />
					<asp:ListItem Text="Nepal" Value="NP" />
					<asp:ListItem Text="Netherlands" Value="NL" />
					<asp:ListItem Text="Netherlands Antilles" Value="AN" />
					<asp:ListItem Text="New Caledonia" Value="NC" />
					<asp:ListItem Text="New Zealand" Value="NZ" />
					<asp:ListItem Text="Nicaragua" Value="NI" />
					<asp:ListItem Text="Niger" Value="NE" />
					<asp:ListItem Text="Nigeria" Value="NG" />
					<asp:ListItem Text="Niue" Value="NU" />
					<asp:ListItem Text="Norfolk Island" Value="NF" />
					<asp:ListItem Text="Northern Mariana Islands" Value="MP" />
					<asp:ListItem Text="Norway" Value="NO" />
					<asp:ListItem Text="Oman" Value="OM" />
					<asp:ListItem Text="Pakistan" Value="PK" />
					<asp:ListItem Text="Palau" Value="PW" />
					<asp:ListItem Text="Palestinian Territory, Occupied" Value="PS" />
					<asp:ListItem Text="Panama" Value="PA" />
					<asp:ListItem Text="Papua New Guinea" Value="PG" />
					<asp:ListItem Text="Paraguay" Value="PY" />
					<asp:ListItem Text="Peru" Value="PE" />
					<asp:ListItem Text="Philippines" Value="PH" />
					<asp:ListItem Text="Pitcairn" Value="PN" />
					<asp:ListItem Text="Poland" Value="PL" />
					<asp:ListItem Text="Portugal" Value="PT" />
					<asp:ListItem Text="Puerto Rico" Value="PR" />
					<asp:ListItem Text="Qatar" Value="QA" />
					<asp:ListItem Text="R&#233;union" Value="RE" />
					<asp:ListItem Text="Romania" Value="RO" />
					<asp:ListItem Text="Russian Federation" Value="RU" />
					<asp:ListItem Text="Rwanda" Value="RW" />
					<asp:ListItem Text="Saint Barth&#233;lemy" Value="BL" />
					<asp:ListItem Text="Saint Helena" Value="SH" />
					<asp:ListItem Text="Saint Kitts And Nevis" Value="KN" />
					<asp:ListItem Text="Saint Lucia" Value="LC" />
					<asp:ListItem Text="Saint Martin" Value="MF" />
					<asp:ListItem Text="Saint Pierre And Miquelon" Value="PM" />
					<asp:ListItem Text="Saint Vincent And The Grenedines" Value="VC" />
					<asp:ListItem Text="Samoa" Value="WS" />
					<asp:ListItem Text="San Marino" Value="SM" />
					<asp:ListItem Text="Sao Tome and Principe" Value="ST" />
					<asp:ListItem Text="Saudi Arabia" Value="SA" />
					<asp:ListItem Text="Senegal" Value="SN" />
					<asp:ListItem Text="Serbia" Value="RS" />
					<asp:ListItem Text="Seychelles" Value="SC" />
					<asp:ListItem Text="Sierra Leone" Value="SL" />
					<asp:ListItem Text="Singapore" Value="SG" />
					<asp:ListItem Text="Slovakia" Value="SK" />
					<asp:ListItem Text="Slovenia" Value="SI" />
					<asp:ListItem Text="Solomon Islands" Value="SB" />
					<asp:ListItem Text="Somalia" Value="SO" />
					<asp:ListItem Text="South Africa" Value="ZA" />
					<asp:ListItem Text="South Georgia and the South Sandwich Islands" Value="GS" />
					<asp:ListItem Text="Spain" Value="ES" />
					<asp:ListItem Text="Sri Lanka" Value="LK" />
					<asp:ListItem Text="Sudan" Value="SD" />
					<asp:ListItem Text="Suriname" Value="SR" />
					<asp:ListItem Text="Svalbard And Jan Mayen" Value="SJ" />
					<asp:ListItem Text="Swaziland" Value="SZ" />
					<asp:ListItem Text="Sweden" Value="SE" />
					<asp:ListItem Text="Switzerland" Value="CH" />
					<asp:ListItem Text="Syrian Arab Republic" Value="SY" />
					<asp:ListItem Text="Taiwan, Province Of China" Value="TW" />
					<asp:ListItem Text="Tajikistan" Value="TJ" />
					<asp:ListItem Text="Tanzania, United Republic of" Value="TZ" />
					<asp:ListItem Text="Thailand" Value="TH" />
					<asp:ListItem Text="Timor-Leste" Value="TL" />
					<asp:ListItem Text="Togo" Value="TG" />
					<asp:ListItem Text="Tokelau" Value="TK" />
					<asp:ListItem Text="Tonga" Value="TO" />
					<asp:ListItem Text="Trinidad and Tobago" Value="TT" />
					<asp:ListItem Text="Tunisia" Value="TN" />
					<asp:ListItem Text="Turkey" Value="TR" />
					<asp:ListItem Text="Turkmenistan" Value="TM" />
					<asp:ListItem Text="Turks and Caicos Islands" Value="TC" />
					<asp:ListItem Text="Tuvalu" Value="TV" />
					<asp:ListItem Text="Uganda" Value="UG" />
					<asp:ListItem Text="Ukraine" Value="UA" />
					<asp:ListItem Text="United Arab Emirates" Value="AE" />
					<asp:ListItem Text="United Kingdom" Value="GB" />
					<asp:ListItem Text="United States" Value="US" />
					<asp:ListItem Text="United States Minor Outlying Islands" Value="UM" />
					<asp:ListItem Text="Uruguay" Value="UY" />
					<asp:ListItem Text="Uzbekistan" Value="UZ" />
					<asp:ListItem Text="Vanuatu" Value="VU" />
					<asp:ListItem Text="Venezuela, Bolivarian Republic of" Value="VE" />
					<asp:ListItem Text="Viet Nam" Value="VN" />
					<asp:ListItem Text="Virgin Islands, British" Value="VG" />
					<asp:ListItem Text="Virgin Islands, U.S." Value="VI" />
					<asp:ListItem Text="Wallis and Futuna" Value="WF" />
					<asp:ListItem Text="Western Sahara" Value="EH" />
					<asp:ListItem Text="Yemen" Value="YE" />
					<asp:ListItem Text="Zambia" Value="ZM" />
					<asp:ListItem Text="Zimbabwe" Value="ZW" />
				</asp:CheckBoxList>
			</div>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralCountryDefaultLabelControl" runat="server" Text="Default country:" />
			<asp:DropDownList ID="GeneralCountryDefaultDropDownList" runat="server">
				<asp:ListItem Text="" Value="" />
				<asp:ListItem Text="Afghanistan" Value="AF" />
				<asp:ListItem Text="&#197;land Islands" Value="AX" />
				<asp:ListItem Text="Albania" Value="AL" />
				<asp:ListItem Text="Algeria" Value="DZ" />
				<asp:ListItem Text="American Samoa" Value="AS" />
				<asp:ListItem Text="Andorra" Value="AD" />
				<asp:ListItem Text="Angola" Value="AO" />
				<asp:ListItem Text="Anguilla" Value="AI" />
				<asp:ListItem Text="Antarctica" Value="AQ" />
				<asp:ListItem Text="Antigua and Barbuda" Value="AG" />
				<asp:ListItem Text="Argentina" Value="AR" />
				<asp:ListItem Text="Armenia" Value="AM" />
				<asp:ListItem Text="Aruba" Value="AW" />
				<asp:ListItem Text="Australia" Value="AU" />
				<asp:ListItem Text="Austria" Value="AT" />
				<asp:ListItem Text="Azerbaijan" Value="AZ" />
				<asp:ListItem Text="Bahamas" Value="BS" />
				<asp:ListItem Text="Bahrain" Value="BH" />
				<asp:ListItem Text="Bangladesh" Value="BD" />
				<asp:ListItem Text="Barbados" Value="BB" />
				<asp:ListItem Text="Belarus" Value="BY" />
				<asp:ListItem Text="Belgium" Value="BE" />
				<asp:ListItem Text="Belize" Value="BZ" />
				<asp:ListItem Text="Benin" Value="BJ" />
				<asp:ListItem Text="Bermuda" Value="BM" />
				<asp:ListItem Text="Bhutan" Value="BT" />
				<asp:ListItem Text="Bolivia" Value="BO" />
				<asp:ListItem Text="Bosnia and Herzegovina" Value="BA" />
				<asp:ListItem Text="Botswana" Value="BW" />
				<asp:ListItem Text="Bouvet Island" Value="BV" />
				<asp:ListItem Text="Brazil" Value="BR" />
				<asp:ListItem Text="British Indian Ocean Territory" Value="IO" />
				<asp:ListItem Text="Brunei Darussalam" Value="BN" />
				<asp:ListItem Text="Bulgaria" Value="BG" />
				<asp:ListItem Text="Burkina Faso" Value="BF" />
				<asp:ListItem Text="Burundi" Value="BI" />
				<asp:ListItem Text="Cambodia" Value="KH" />
				<asp:ListItem Text="Cameroon" Value="CM" />
				<asp:ListItem Text="Canada" Value="CA" />
				<asp:ListItem Text="Cape Verde" Value="CV" />
				<asp:ListItem Text="Cayman Islands" Value="KY" />
				<asp:ListItem Text="Central African Republic" Value="CF" />
				<asp:ListItem Text="Chad" Value="TD" />
				<asp:ListItem Text="Chile" Value="CL" />
				<asp:ListItem Text="China" Value="CN" />
				<asp:ListItem Text="Christmas Island" Value="CX" />
				<asp:ListItem Text="Cocos (Keeling) Islands" Value="CC" />
				<asp:ListItem Text="Colombia" Value="CO" />
				<asp:ListItem Text="Comoros" Value="KM" />
				<asp:ListItem Text="Congo" Value="CG" />
				<asp:ListItem Text="Congo, The Democratic Republic Of The" Value="CD" />
				<asp:ListItem Text="Cook Islands" Value="CK" />
				<asp:ListItem Text="Costa Rica" Value="CR" />
				<asp:ListItem Text="C&#244;te D'Ivoire" Value="CI" />
				<asp:ListItem Text="Croatia" Value="HR" />
				<asp:ListItem Text="Cuba" Value="CU" />
				<asp:ListItem Text="Cyprus" Value="CY" />
				<asp:ListItem Text="Czech Republic" Value="CZ" />
				<asp:ListItem Text="Denmark" Value="DK" />
				<asp:ListItem Text="Djibouti" Value="DJ" />
				<asp:ListItem Text="Dominica" Value="DM" />
				<asp:ListItem Text="Dominican Republic" Value="DO" />
				<asp:ListItem Text="Ecuador" Value="EC" />
				<asp:ListItem Text="Egypt" Value="EG" />
				<asp:ListItem Text="El Salvador" Value="SV" />
				<asp:ListItem Text="Equatorial Guinea" Value="GQ" />
				<asp:ListItem Text="Eritrea" Value="ER" />
				<asp:ListItem Text="Estonia" Value="EE" />
				<asp:ListItem Text="Ethiopia" Value="ET" />
				<asp:ListItem Text="Falkland Islands  (Malvinas)" Value="FK" />
				<asp:ListItem Text="Faroe Islands" Value="FO" />
				<asp:ListItem Text="Fiji" Value="FJ" />
				<asp:ListItem Text="Finland" Value="FI" />
				<asp:ListItem Text="France" Value="FR" />
				<asp:ListItem Text="French Guiana" Value="GF" />
				<asp:ListItem Text="French Polynesia" Value="PF" />
				<asp:ListItem Text="French Southern Territories" Value="TF" />
				<asp:ListItem Text="Gabon" Value="GA" />
				<asp:ListItem Text="Gambia" Value="GM" />
				<asp:ListItem Text="Georgia" Value="GE" />
				<asp:ListItem Text="Germany" Value="DE" />
				<asp:ListItem Text="Ghana" Value="GH" />
				<asp:ListItem Text="Gibraltar" Value="GI" />
				<asp:ListItem Text="Greece" Value="GR" />
				<asp:ListItem Text="Greenland" Value="GL" />
				<asp:ListItem Text="Grenada" Value="GD" />
				<asp:ListItem Text="Guadeloupe" Value="GP" />
				<asp:ListItem Text="Guam" Value="GU" />
				<asp:ListItem Text="Guatemala" Value="GT" />
				<asp:ListItem Text="Guernsey" Value="GG" />
				<asp:ListItem Text="Guinea" Value="GN" />
				<asp:ListItem Text="Guinea-Bissau" Value="GW" />
				<asp:ListItem Text="Guyana" Value="GY" />
				<asp:ListItem Text="Haiti" Value="HT" />
				<asp:ListItem Text="Heard and McDonald Islands" Value="HM" />
				<asp:ListItem Text="Holy See (Vatican City State)" Value="VA" />
				<asp:ListItem Text="Honduras" Value="HN" />
				<asp:ListItem Text="Hong Kong" Value="HK" />
				<asp:ListItem Text="Hungary" Value="HU" />
				<asp:ListItem Text="Iceland" Value="IS" />
				<asp:ListItem Text="India" Value="IN" />
				<asp:ListItem Text="Indonesia" Value="ID" />
				<asp:ListItem Text="Iran, Islamic Republic Of" Value="IR" />
				<asp:ListItem Text="Iraq" Value="IQ" />
				<asp:ListItem Text="Ireland" Value="IE" />
				<asp:ListItem Text="Isle of Man" Value="IM" />
				<asp:ListItem Text="Israel" Value="IL" />
				<asp:ListItem Text="Italy" Value="IT" />
				<asp:ListItem Text="Jamaica" Value="JM" />
				<asp:ListItem Text="Japan" Value="JP" />
				<asp:ListItem Text="Jersey" Value="JE" />
				<asp:ListItem Text="Jordan" Value="JO" />
				<asp:ListItem Text="Kazakhstan" Value="KZ" />
				<asp:ListItem Text="Kenya" Value="KE" />
				<asp:ListItem Text="Kiribati" Value="KI" />
				<asp:ListItem Text="Korea, Democratic People's Republic Of" Value="KP" />
				<asp:ListItem Text="Korea, Republic of" Value="KR" />
				<asp:ListItem Text="Kuwait" Value="KW" />
				<asp:ListItem Text="Kyrgyzstan" Value="KG" />
				<asp:ListItem Text="Lao People's Democratic Republic" Value="LA" />
				<asp:ListItem Text="Latvia" Value="LV" />
				<asp:ListItem Text="Lebanon" Value="LB" />
				<asp:ListItem Text="Lesotho" Value="LS" />
				<asp:ListItem Text="Liberia" Value="LR" />
				<asp:ListItem Text="Libyan Arab Jamahiriya" Value="LY" />
				<asp:ListItem Text="Liechtenstein" Value="LI" />
				<asp:ListItem Text="Lithuania" Value="LT" />
				<asp:ListItem Text="Luxembourg" Value="LU" />
				<asp:ListItem Text="Macao" Value="MO" />
				<asp:ListItem Text="Macedonia, the Former Yugoslav Republic Of" Value="MK" />
				<asp:ListItem Text="Madagascar" Value="MG" />
				<asp:ListItem Text="Malawi" Value="MW" />
				<asp:ListItem Text="Malaysia" Value="MY" />
				<asp:ListItem Text="Maldives" Value="MV" />
				<asp:ListItem Text="Mali" Value="ML" />
				<asp:ListItem Text="Malta" Value="MT" />
				<asp:ListItem Text="Marshall Islands" Value="MH" />
				<asp:ListItem Text="Martinique" Value="MQ" />
				<asp:ListItem Text="Mauritania" Value="MR" />
				<asp:ListItem Text="Mauritius" Value="MU" />
				<asp:ListItem Text="Mayotte" Value="YT" />
				<asp:ListItem Text="Mexico" Value="MX" />
				<asp:ListItem Text="Micronesia, Federated States Of" Value="FM" />
				<asp:ListItem Text="Moldova, Republic of" Value="MD" />
				<asp:ListItem Text="Monaco" Value="MC" />
				<asp:ListItem Text="Mongolia" Value="MN" />
				<asp:ListItem Text="Montenegro" Value="ME" />
				<asp:ListItem Text="Montserrat" Value="MS" />
				<asp:ListItem Text="Morocco" Value="MA" />
				<asp:ListItem Text="Mozambique" Value="MZ" />
				<asp:ListItem Text="Myanmar" Value="MM" />
				<asp:ListItem Text="Namibia" Value="NA" />
				<asp:ListItem Text="Nauru" Value="NR" />
				<asp:ListItem Text="Nepal" Value="NP" />
				<asp:ListItem Text="Netherlands" Value="NL" />
				<asp:ListItem Text="Netherlands Antilles" Value="AN" />
				<asp:ListItem Text="New Caledonia" Value="NC" />
				<asp:ListItem Text="New Zealand" Value="NZ" />
				<asp:ListItem Text="Nicaragua" Value="NI" />
				<asp:ListItem Text="Niger" Value="NE" />
				<asp:ListItem Text="Nigeria" Value="NG" />
				<asp:ListItem Text="Niue" Value="NU" />
				<asp:ListItem Text="Norfolk Island" Value="NF" />
				<asp:ListItem Text="Northern Mariana Islands" Value="MP" />
				<asp:ListItem Text="Norway" Value="NO" />
				<asp:ListItem Text="Oman" Value="OM" />
				<asp:ListItem Text="Pakistan" Value="PK" />
				<asp:ListItem Text="Palau" Value="PW" />
				<asp:ListItem Text="Palestinian Territory, Occupied" Value="PS" />
				<asp:ListItem Text="Panama" Value="PA" />
				<asp:ListItem Text="Papua New Guinea" Value="PG" />
				<asp:ListItem Text="Paraguay" Value="PY" />
				<asp:ListItem Text="Peru" Value="PE" />
				<asp:ListItem Text="Philippines" Value="PH" />
				<asp:ListItem Text="Pitcairn" Value="PN" />
				<asp:ListItem Text="Poland" Value="PL" />
				<asp:ListItem Text="Portugal" Value="PT" />
				<asp:ListItem Text="Puerto Rico" Value="PR" />
				<asp:ListItem Text="Qatar" Value="QA" />
				<asp:ListItem Text="R&#233;union" Value="RE" />
				<asp:ListItem Text="Romania" Value="RO" />
				<asp:ListItem Text="Russian Federation" Value="RU" />
				<asp:ListItem Text="Rwanda" Value="RW" />
				<asp:ListItem Text="Saint Barth&#233;lemy" Value="BL" />
				<asp:ListItem Text="Saint Helena" Value="SH" />
				<asp:ListItem Text="Saint Kitts And Nevis" Value="KN" />
				<asp:ListItem Text="Saint Lucia" Value="LC" />
				<asp:ListItem Text="Saint Martin" Value="MF" />
				<asp:ListItem Text="Saint Pierre And Miquelon" Value="PM" />
				<asp:ListItem Text="Saint Vincent And The Grenedines" Value="VC" />
				<asp:ListItem Text="Samoa" Value="WS" />
				<asp:ListItem Text="San Marino" Value="SM" />
				<asp:ListItem Text="Sao Tome and Principe" Value="ST" />
				<asp:ListItem Text="Saudi Arabia" Value="SA" />
				<asp:ListItem Text="Senegal" Value="SN" />
				<asp:ListItem Text="Serbia" Value="RS" />
				<asp:ListItem Text="Seychelles" Value="SC" />
				<asp:ListItem Text="Sierra Leone" Value="SL" />
				<asp:ListItem Text="Singapore" Value="SG" />
				<asp:ListItem Text="Slovakia" Value="SK" />
				<asp:ListItem Text="Slovenia" Value="SI" />
				<asp:ListItem Text="Solomon Islands" Value="SB" />
				<asp:ListItem Text="Somalia" Value="SO" />
				<asp:ListItem Text="South Africa" Value="ZA" />
				<asp:ListItem Text="South Georgia and the South Sandwich Islands" Value="GS" />
				<asp:ListItem Text="Spain" Value="ES" />
				<asp:ListItem Text="Sri Lanka" Value="LK" />
				<asp:ListItem Text="Sudan" Value="SD" />
				<asp:ListItem Text="Suriname" Value="SR" />
				<asp:ListItem Text="Svalbard And Jan Mayen" Value="SJ" />
				<asp:ListItem Text="Swaziland" Value="SZ" />
				<asp:ListItem Text="Sweden" Value="SE" />
				<asp:ListItem Text="Switzerland" Value="CH" />
				<asp:ListItem Text="Syrian Arab Republic" Value="SY" />
				<asp:ListItem Text="Taiwan, Province Of China" Value="TW" />
				<asp:ListItem Text="Tajikistan" Value="TJ" />
				<asp:ListItem Text="Tanzania, United Republic of" Value="TZ" />
				<asp:ListItem Text="Thailand" Value="TH" />
				<asp:ListItem Text="Timor-Leste" Value="TL" />
				<asp:ListItem Text="Togo" Value="TG" />
				<asp:ListItem Text="Tokelau" Value="TK" />
				<asp:ListItem Text="Tonga" Value="TO" />
				<asp:ListItem Text="Trinidad and Tobago" Value="TT" />
				<asp:ListItem Text="Tunisia" Value="TN" />
				<asp:ListItem Text="Turkey" Value="TR" />
				<asp:ListItem Text="Turkmenistan" Value="TM" />
				<asp:ListItem Text="Turks and Caicos Islands" Value="TC" />
				<asp:ListItem Text="Tuvalu" Value="TV" />
				<asp:ListItem Text="Uganda" Value="UG" />
				<asp:ListItem Text="Ukraine" Value="UA" />
				<asp:ListItem Text="United Arab Emirates" Value="AE" />
				<asp:ListItem Text="United Kingdom" Value="GB" />
				<asp:ListItem Text="United States" Value="US" />
				<asp:ListItem Text="United States Minor Outlying Islands" Value="UM" />
				<asp:ListItem Text="Uruguay" Value="UY" />
				<asp:ListItem Text="Uzbekistan" Value="UZ" />
				<asp:ListItem Text="Vanuatu" Value="VU" />
				<asp:ListItem Text="Venezuela, Bolivarian Republic of" Value="VE" />
				<asp:ListItem Text="Viet Nam" Value="VN" />
				<asp:ListItem Text="Virgin Islands, British" Value="VG" />
				<asp:ListItem Text="Virgin Islands, U.S." Value="VI" />
				<asp:ListItem Text="Wallis and Futuna" Value="WF" />
				<asp:ListItem Text="Western Sahara" Value="EH" />
				<asp:ListItem Text="Yemen" Value="YE" />
				<asp:ListItem Text="Zambia" Value="ZM" />
				<asp:ListItem Text="Zimbabwe" Value="ZW" />
			</asp:DropDownList>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralGeoIPActiveLabelControl" runat="server" Text="Enable GeoIP matching:" HelpText="Lookup customer's physical location by matching with their IP address." />
			<asp:CheckBox ID="GeneralGeoIPActiveCheckBox" runat="server" />
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="UpdateGeoIPFileLabelControl" runat="server" Text="" />
			<asp:LinkButton ID="UpdateGeoIPFileLinkButton" runat="server" onclick="UpdateGeoIPFileLinkButton_Click" Text="Update GeoIP file" CssClass="dnnPrimaryAction"/>
		</div>
	</fieldset>
	<h2 id="MembershipFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Membership</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralNavigationLoginUrlLabelControl" runat="server" Text="Custom login page:" HelpText="Specify a custom login page or use the system default if not specified." />
			<dnn1:UrlControl ID="GeneralNavigationLoginUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="true" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowUsers="false"></dnn1:UrlControl>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralNavigationRegistrationUrlLabelControl" runat="server" Text="Custom registration page:" HelpText="Specify a custom registration page or use the system default if not specified." />
			<dnn1:UrlControl ID="GeneralNavigationRegistrationUrlUrlControl" runat="server" ShowDatabase="false" ShowFiles="false" ShowImages="False" ShowLog="false" ShowNewWindow="False" ShowNone="true" ShowSecure="true" ShowTabs="True" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowUsers="false"></dnn1:UrlControl>
		</div>
	</fieldset>
	<h2 id="DiagnosticsFormSectionHead" class="dnnFormSectionHead">
		<a href="#" class="dnnSectionExpanded">Diagnostics</a></h2>
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GeneralLogLevelLabelControl" runat="server" Text="Log level:" HelpText="Select how much information to log to the system event viewer. Debug level log generates a lot of data useful for troubleshooting during development but may slow down performance. It is recommended to use Error log level during production." />
			<asp:DropDownList ID="GeneralLogLevelDropDownList" runat="server">
				<asp:ListItem Text="Error" Value="1"></asp:ListItem>
				<asp:ListItem Text="Debug" Value="8"></asp:ListItem>
			</asp:DropDownList>
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
		<li><asp:LinkButton ID="ClearCacheLinkButton" runat="server" Text="Clear cache" CssClass="dnnSecondaryAction" OnClick="ClearCacheLinkButton_Click"></asp:LinkButton></li>
	</ul>
</asp:Panel>
