<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutConfigurationAvailabilityRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CheckoutConfigurationAvailabilityRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Availability rule:" HelpText="Provide any condition that determines when the checkout should be allowed." />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - Always allow" Value=""></asp:ListItem>
		<asp:ListItem Text="Basic" Value="BasicAvailabilityView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicAvailabilityView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinOrderAmountBasicAvailabilityLabelControl" runat="server" Text="Min total amount:" HelpText="The minimum total order amount to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MinOrderAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxOrderAmountBasicAvailabilityLabelControl" runat="server" Text="Max total amount:" HelpText="The maximum total order amount to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MaxOrderAmountBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinOrderQuantityBasicAvailabilityLabelControl" runat="server" Text="Min total quantity:" HelpText="The minimum total order quantity to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MinOrderQuantityBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxOrderQuantityBasicAvailabilityLabelControl" runat="server" Text="Max total quantity:" HelpText="The maximum total order quantity to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MaxOrderQuantityBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinOrderWeightBasicAvailabilityLabelControl" runat="server" Text="Min total weight ({0}):" HelpText="The minimum total weight to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MinOrderWeightBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxOrderWeightBasicAvailabilityLabelControl" runat="server" Text="Max total weight ({0}):" HelpText="The maximum total weight to qualify for checkout." />
			<dnn2:DnnNumericTextBox ID="MaxOrderWeightBasicAvailabilityDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RegionBehaviorBasicAvailabilityLabelControl" runat="server" Text="Region match:" HelpText="Determine if rule is allowed or disallowed." />
			<asp:RadioButtonList ID="RegionBehaviorBasicAvailabilityRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Allow all except listed below" Value="exclusion" Selected="True" />
				<asp:ListItem Text="Allow only those listed below" Value="inclusion" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RegionBasicAvailabilityLabelControl" runat="server" Text="Regions:" HelpText="Availability is determined by the customer's billing address." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
				<asp:GridView ID="RegionBasicAvailabilityGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="CountryCode,SubdivisionCode,PostalCode" OnRowDeleting="RegionBasicAvailabilityGridView_RowDeleting" OnSelectedIndexChanged="RegionBasicAvailabilityGridView_SelectedIndexChanged">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="" ControlStyle-CssClass="rvdEditGridAction" />
						<asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="Country" HeaderText="Country" />
						<asp:BoundField DataField="Subdivision" HeaderText="State/Province" />
						<asp:BoundField DataField="PostalCode" HeaderText="Postal code" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRegionBasicAvailabilityLinkButton" runat="server" Text="Add new" OnClick="AddRegionBasicAvailabilityLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" CausesValidation="false" />
				</div>
				<asp:Panel ID="RegionBasicAvailabilityDetailsViewPanel" runat="server" CssClass="dnnForm">
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="CountryCodeBasicAvailabilityDetailsViewLabelControl" runat="server" Text="Country:" />
						<asp:DropDownList ID="CountryCodeBasicAvailabilityDetailsViewDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CountryCodeBasicAvailabilityDetailsViewDropDownList_SelectedIndexChanged">
							<asp:ListItem Text="Any" Value="" />
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
						<dnn1:LabelControl ID="SubdivisionCodeBasicAvailabilityDetailsViewLabelControl" runat="server" Text="State/Province:" />
						<asp:DropDownList ID="SubdivisionCodeBasicAvailabilityDetailsViewDropDownList" runat="server">
						</asp:DropDownList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PostalCodeBasicAvailabilityDetailsViewLabelControl" runat="server" Text="Postal code:" HelpText="Enter a postal code to match or leave blank to match any postal code. If you enter a substring 902 postal code, it will also match 90210. This allows you to group your postal code into manageable regions." />
						<asp:TextBox ID="PostalCodeBasicAvailabilityDetailsViewTextBox" runat="server" ></asp:TextBox>
					</div>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRegionBasicAvailabilityLinkButton" runat="server" Text="OK" OnClick="SaveRegionBasicAvailabilityLinkButton_Click" ValidationGroup="RegionBasicAvailabilityDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MessageBasicAvailabilityLabelControl" runat="server" Text="Message:" HelpText="The message to display when disallowed." />
			<asp:TextBox ID="MessageBasicAvailabilityTextBox" runat="server" TextMode="MultiLine" />
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AvailabilityRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="AvailabilityRuleFormulaEditor" runat="server" Width="100%" ModuleControl="CheckoutAvailability" />
		</div>
	</asp:View>
</asp:MultiView>