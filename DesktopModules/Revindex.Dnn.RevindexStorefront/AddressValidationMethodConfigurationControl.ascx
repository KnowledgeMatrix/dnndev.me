<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddressValidationMethodConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.AddressValidationMethodConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:MultiView ID="ContentMultiView" runat="server">
    <asp:View ID="ListView" runat="server">
        <h2>Address validation methods</h2>
        <div class="dnnForm">
            <asp:GridView ID="AddressValidationMethodGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AddressValidationMethodID" OnRowDeleting="AddressValidationMethodGridView_RowDeleting" OnRowDataBound="AddressValidationMethodGridView_RowDataBound">
                <AlternatingRowStyle CssClass="dnnGridAltItem" />
                <HeaderStyle CssClass="dnnGridHeader" />
                <RowStyle CssClass="dnnGridItem" />
                <SelectedRowStyle CssClass="dnnGridSelectedItem" />
                <FooterStyle CssClass="dnnGridFooter" />
                <PagerStyle CssClass="dnnGridPager" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CountryCode" HeaderText="Country" SortExpression="CountryCode" />
                    <asp:BoundField DataField="AddressValidationProvider" HeaderText="Provider" SortExpression="AddressValidationProvider" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="AddressValidationMethodObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.AddressValidationMethodController">
                <SelectParameters>
                    <asp:Parameter Name="sortExpression" Type="String" />
                    <asp:Parameter Name="maximumRows" Type="Int32" />
                    <asp:Parameter Name="startRowIndex" Type="Int32" />
                    <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                </li>
            </ul>
        </div>

    </asp:View>
    <asp:View ID="DetailsView" runat="server">
        <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
        <h2>Address validation method: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
        <div class="dnnForm">
            <fieldset>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="AddressValidationMethodIDLabelControl" runat="server" Text="Address validation method ID:" />
                    <asp:Label ID="AddressValidationMethodIDLabel" runat="server"></asp:Label>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="CountryCodeLabelControl" runat="server" Text="Country:" />
                    <asp:DropDownList ID="CountryCodeDropDownList" runat="server">
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
                    <dnn1:LabelControl ID="AddressValidationProviderLabelControl" runat="server" Text="Provider:" CssClass="dnnFormRequired" />
                    <asp:DropDownList ID="AddressValidationProviderDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="AddressValidationProviderDropDownList_SelectedIndexChanged">
                        <asp:ListItem Text="AvaTax" Value="AvaTax" />
                    </asp:DropDownList>
					<asp:HyperLink ID="AddressValidationProviderHyperLink" runat="server" CssClass="rvdLinkAction" Text="Edit"></asp:HyperLink>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="ValidationSeverityLabelControl" runat="server" Text="Severity level:" CssClass="dnnFormRequired" HelpText="The system will attempt to validate the address and if a valid match is found, it will automatically standardize the address format. The severity level determines how to treat an invalid address that cannot be automatically corrected by the system. High - Require user to correct the invalid address before proceeding further. Normal - Warn user of the invalid address, but allow the user to proceed. Low - Invalid address is silently accepted." />
                    <asp:DropDownList ID="ValidationSeverityDropDownList" runat="server">
                        <asp:ListItem Text="High" Value="3" />
                        <asp:ListItem Text="Normal" Value="2" Selected="True" />
                        <asp:ListItem Text="Low" Value="1" />
                    </asp:DropDownList>
                </div>
            </fieldset>
            <ul class="dnnActions">
                <li>
                    <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="AddressValidationMethodDetailsViewControl" />
                </li>
                <li>
                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="AddressValidationMethodDetailsViewControl" />
                </li>
                <li>
                    <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                </li>
            </ul>
        </div>
    </asp:View>
</asp:MultiView>
