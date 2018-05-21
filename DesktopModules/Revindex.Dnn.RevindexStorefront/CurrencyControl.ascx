<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CurrencyControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CurrencyControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:MultiView ID="ContentMultiView" runat="server">
    <asp:View ID="ListView" runat="server">
        <h2>Currencies</h2>
        <div class="dnnForm rvdsfListContainer">
            <asp:GridView ID="CurrencyGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CurrencyID" OnRowDeleting="CurrencyGridView_RowDeleting" OnRowDataBound="CurrencyGridView_RowDataBound">
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
                    <asp:BoundField DataField="CultureCode" HeaderText="Culture" SortExpression="CultureCode" />
                    <asp:BoundField DataField="ExchangeRate" HeaderText="Exchange rate" SortExpression="ExchangeRate" />
                    <asp:CheckBoxField DataField="PrimaryCurrency" HeaderText="Primary" SortExpression="PrimaryCurrency" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="CurrencyObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.CurrencyController">
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
        <h2>Currency: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
        <div class="dnnForm">
            <fieldset>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="CurrencyIDLabelControl" runat="server" Text="Currency ID:" />
                    <asp:Label ID="CurrencyIDLabel" runat="server"></asp:Label>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="PrimaryCurrencyLabelControl" runat="server" HelpText="The primary currency is the actual currency stored in the system and used for all fallback cultures." Text="Primary:" />
                    <asp:CheckBox ID="PrimaryCurrencyCheckBox" runat="server" AutoPostBack="True" OnCheckedChanged="PrimaryCurrencyCheckBox_CheckedChanged" />
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="CultureCodeLabelControl" runat="server" Text="Culture:" />
                    <asp:DropDownList ID="CultureCodeDropDownList" runat="server">
                        <asp:ListItem Text="AED - Arabic (U.A.E.)" Value="ar-AE" />
                        <asp:ListItem Text="AFN - Dari (Afghanistan)" Value="prs-AF" />
                        <asp:ListItem Text="AFN - Pashto (Afghanistan)" Value="ps-AF" />
                        <asp:ListItem Text="ALL - Albanian (Albania)" Value="sq-AL" />
                        <asp:ListItem Text="AMD - Armenian (Armenia)" Value="hy-AM" />
                        <asp:ListItem Text="ARS - Spanish (Argentina)" Value="es-AR" />
                        <asp:ListItem Text="AUD - English (Australia)" Value="en-AU" />
                        <asp:ListItem Text="AZM - Azeri (Cyrillic, Azerbaijan)" Value="az-Cyrl-AZ" />
                        <asp:ListItem Text="AZM - Azeri (Latin, Azerbaijan)" Value="az-Latn-AZ" />
                        <asp:ListItem Text="BAM - Bosnian (Cyrillic) (Bosnia and Herzegovina)" Value="bs-Cyrl-BA" />
                        <asp:ListItem Text="BAM - Bosnian (Latin) (Bosnia and Herzegovina)" Value="bs-Latn-BA" />
                        <asp:ListItem Text="BAM - Croatian (Latin) (Bosnia and Herzegovina)" Value="hr-BA" />
                        <asp:ListItem Text="BAM - Serbian (Cyrillic) (Bosnia and Herzegovina)" Value="sr-Cyrl-BA" />
                        <asp:ListItem Text="BAM - Serbian (Latin) (Bosnia and Herzegovina)" Value="sr-Latn-BA" />
                        <asp:ListItem Text="BDT - Bangla (Bangladesh)" Value="bn-BD" />
                        <asp:ListItem Text="BGL - Bulgarian (Bulgaria)" Value="bg-BG" />
                        <asp:ListItem Text="BHD - Arabic (Bahrain)" Value="ar-BH" />
                        <asp:ListItem Text="BND - Malay (Brunei Darussalam)" Value="ms-BN" />
                        <asp:ListItem Text="BOB - Quechua (Bolivia)" Value="quz-BO" />
                        <asp:ListItem Text="BOB - Spanish (Bolivia)" Value="es-BO" />
                        <asp:ListItem Text="BRL - Portuguese (Brazil)" Value="pt-BR" />
                        <asp:ListItem Text="BWP - Setswana (Botswana)" Value="tn-BW" />
                        <asp:ListItem Text="BYB - Belarusian (Belarus)" Value="be-BY" />
                        <asp:ListItem Text="BZD - English (Belize)" Value="en-BZ" />
                        <asp:ListItem Text="CAD - English (Canada)" Value="en-CA" />
                        <asp:ListItem Text="CAD - French (Canada)" Value="fr-CA" />
                        <asp:ListItem Text="CAD - Inuktitut (Latin) (Canada)" Value="iu-Latn-CA" />
                        <asp:ListItem Text="CAD - Inuktitut (Syllabics) (Canada)" Value="iu-Cans-CA" />
                        <asp:ListItem Text="CAD - Mohawk (Canada)" Value="moh-CA" />
                        <asp:ListItem Text="CHF - French (Switzerland)" Value="fr-CH" />
                        <asp:ListItem Text="CHF - German (Liechtenstein)" Value="de-LI" />
                        <asp:ListItem Text="CHF - German (Switzerland)" Value="de-CH" />
                        <asp:ListItem Text="CHF - Italian (Switzerland)" Value="it-CH" />
                        <asp:ListItem Text="CHF - Romansh (Switzerland)" Value="rm-CH" />
                        <asp:ListItem Text="CLP - Mapudungun (Chile)" Value="arn-CL" />
                        <asp:ListItem Text="CLP - Spanish (Chile)" Value="es-CL" />
                        <asp:ListItem Text="CNY - Chinese (People's Republic of China)" Value="zh-CN" />
                        <asp:ListItem Text="CNY - Mongolian (Traditional Mongolian) (China)" Value="mn-Mong-CN" />
                        <asp:ListItem Text="CNY - Tibetan (China)" Value="bo-CN" />
                        <asp:ListItem Text="CNY - Uyghur (China)" Value="ug-CN" />
                        <asp:ListItem Text="CNY - Yi (China)" Value="ii-CN" />
                        <asp:ListItem Text="COP - Spanish (Colombia)" Value="es-CO" />
                        <asp:ListItem Text="CRC - Spanish (Costa Rica)" Value="es-CR" />
                        <asp:ListItem Text="CSD - Serbian (Cyrillic, Serbia and Montenegro (Former))" Value="sr-Cyrl-CS" />
                        <asp:ListItem Text="CSD - Serbian (Latin, Serbia and Montenegro (Former))" Value="sr-Latn-CS" />
                        <asp:ListItem Text="CZK - Czech (Czech Republic)" Value="cs-CZ" />
                        <asp:ListItem Text="DKK - Danish (Denmark)" Value="da-DK" />
                        <asp:ListItem Text="DKK - Faroese (Faroe Islands)" Value="fo-FO" />
                        <asp:ListItem Text="DKK - Greenlandic (Greenland)" Value="kl-GL" />
                        <asp:ListItem Text="DOP - Spanish (Dominican Republic)" Value="es-DO" />
                        <asp:ListItem Text="DZD - Arabic (Algeria)" Value="ar-DZ" />
                        <asp:ListItem Text="DZD - Central Atlas Tamazight (Latin) (Algeria)" Value="tzm-Latn-DZ" />
                        <asp:ListItem Text="EEK - Estonian (Estonia)" Value="et-EE" />
                        <asp:ListItem Text="EGP - Arabic (Egypt)" Value="ar-EG" />
                        <asp:ListItem Text="ERN - Tigrinya (Eritrea)" Value="ti-ER" />
                        <asp:ListItem Text="ERN - Tigrinya (Ethiopia)" Value="ti-ET" />
                        <asp:ListItem Text="ETB - Amharic (Ethiopia)" Value="am-ET" />
                        <asp:ListItem Text="EUR - Alsatian (France)" Value="gsw-FR" />
                        <asp:ListItem Text="EUR - Basque (Basque)" Value="eu-ES" />
                        <asp:ListItem Text="EUR - Breton (France)" Value="br-FR" />
                        <asp:ListItem Text="EUR - Catalan (Catalan)" Value="ca-ES" />
                        <asp:ListItem Text="EUR - Corsican (France)" Value="co-FR" />
                        <asp:ListItem Text="EUR - Dutch (Belgium)" Value="nl-BE" />
                        <asp:ListItem Text="EUR - Dutch (Netherlands)" Value="nl-NL" />
                        <asp:ListItem Text="EUR - English (Ireland)" Value="en-IE" />
                        <asp:ListItem Text="EUR - Finnish (Finland)" Value="fi-FI" />
                        <asp:ListItem Text="EUR - French (Belgium)" Value="fr-BE" />
                        <asp:ListItem Text="EUR - French (France)" Value="fr-FR" />
                        <asp:ListItem Text="EUR - French (Luxembourg)" Value="fr-LU" />
                        <asp:ListItem Text="EUR - French (Principality of Monaco)" Value="fr-MC" />
                        <asp:ListItem Text="EUR - Frisian (Netherlands)" Value="fy-NL" />
                        <asp:ListItem Text="EUR - Galician (Galician)" Value="gl-ES" />
                        <asp:ListItem Text="EUR - German (Austria)" Value="de-AT" />
                        <asp:ListItem Text="EUR - German (Germany)" Value="de-DE" />
                        <asp:ListItem Text="EUR - German (Luxembourg)" Value="de-LU" />
                        <asp:ListItem Text="EUR - Greek (Greece)" Value="el-GR" />
                        <asp:ListItem Text="EUR - Irish (Ireland)" Value="ga-IE" />
                        <asp:ListItem Text="EUR - Italian (Italy)" Value="it-IT" />
                        <asp:ListItem Text="EUR - Lower Sorbian (Germany)" Value="dsb-DE" />
                        <asp:ListItem Text="EUR - Luxembourgish (Luxembourg)" Value="lb-LU" />
                        <asp:ListItem Text="EUR - Maltese (Malta)" Value="mt-MT" />
                        <asp:ListItem Text="EUR - Occitan (France)" Value="oc-FR" />
                        <asp:ListItem Text="EUR - Portuguese (Portugal)" Value="pt-PT" />
                        <asp:ListItem Text="EUR - Sami (Inari) (Finland)" Value="smn-FI" />
                        <asp:ListItem Text="EUR - Sami (Northern) (Finland)" Value="se-FI" />
                        <asp:ListItem Text="EUR - Sami (Skolt) (Finland)" Value="sms-FI" />
                        <asp:ListItem Text="EUR - Serbian (Cyrillic) (Montenegro)" Value="sr-Cyrl-ME" />
                        <asp:ListItem Text="EUR - Serbian (Latin) (Montenegro)" Value="sr-Latn-ME" />
                        <asp:ListItem Text="EUR - Slovak (Slovakia)" Value="sk-SK" />
                        <asp:ListItem Text="EUR - Slovenian (Slovenia)" Value="sl-SI" />
                        <asp:ListItem Text="EUR - Spanish (Spain)" Value="es-ES" />
                        <asp:ListItem Text="EUR - Swedish (Finland)" Value="sv-FI" />
                        <asp:ListItem Text="EUR - Upper Sorbian (Germany)" Value="hsb-DE" />
                        <asp:ListItem Text="EUR - Valencian (Spain)" Value="ca-ES-valencia" />
                        <asp:ListItem Text="GBP - English (United Kingdom)" Value="en-GB" />
                        <asp:ListItem Text="GBP - Scottish Gaelic (United Kingdom)" Value="gd-GB" />
                        <asp:ListItem Text="GBP - Welsh (United Kingdom)" Value="cy-GB" />
                        <asp:ListItem Text="GEL - Georgian (Georgia)" Value="ka-GE" />
                        <asp:ListItem Text="GTQ - K'iche' (Guatemala)" Value="qut-GT" />
                        <asp:ListItem Text="GTQ - Spanish (Guatemala)" Value="es-GT" />
                        <asp:ListItem Text="HKD - Chinese (Hong Kong S.A.R.)" Value="zh-HK" />
                        <asp:ListItem Text="HNL - Spanish (Honduras)" Value="es-HN" />
                        <asp:ListItem Text="HRK - Croatian (Croatia)" Value="hr-HR" />
                        <asp:ListItem Text="HUF - Hungarian (Hungary)" Value="hu-HU" />
                        <asp:ListItem Text="IDR - Indonesian (Indonesia)" Value="id-ID" />
                        <asp:ListItem Text="ILS - Hebrew (Israel)" Value="he-IL" />
                        <asp:ListItem Text="INR - Assamese (India)" Value="as-IN" />
                        <asp:ListItem Text="INR - Bangla (India)" Value="bn-IN" />
                        <asp:ListItem Text="INR - English (India)" Value="en-IN" />
                        <asp:ListItem Text="INR - Gujarati (India)" Value="gu-IN" />
                        <asp:ListItem Text="INR - Hindi (India)" Value="hi-IN" />
                        <asp:ListItem Text="INR - Kannada (India)" Value="kn-IN" />
                        <asp:ListItem Text="INR - Konkani (India)" Value="kok-IN" />
                        <asp:ListItem Text="INR - Malayalam (India)" Value="ml-IN" />
                        <asp:ListItem Text="INR - Marathi (India)" Value="mr-IN" />
                        <asp:ListItem Text="INR - Odia (India)" Value="or-IN" />
                        <asp:ListItem Text="INR - Punjabi (India)" Value="pa-IN" />
                        <asp:ListItem Text="INR - Sanskrit (India)" Value="sa-IN" />
                        <asp:ListItem Text="INR - Tamil (India)" Value="ta-IN" />
                        <asp:ListItem Text="INR - Telugu (India)" Value="te-IN" />
                        <asp:ListItem Text="IQD - Arabic (Iraq)" Value="ar-IQ" />
                        <asp:ListItem Text="IQD - Central Kurdish (Iraq)" Value="ku-Arab-IQ" />
                        <asp:ListItem Text="IRR - Persian (Iran)" Value="fa-IR" />
                        <asp:ListItem Text="ISK - Icelandic (Iceland)" Value="is-IS" />
                        <asp:ListItem Text="JMD - English (Jamaica)" Value="en-JM" />
                        <asp:ListItem Text="JOD - Arabic (Jordan)" Value="ar-JO" />
                        <asp:ListItem Text="JPY - Japanese (Japan)" Value="ja-JP" />
                        <asp:ListItem Text="KES - Kiswahili (Kenya)" Value="sw-KE" />
                        <asp:ListItem Text="KGS - Kyrgyz (Kyrgyzstan)" Value="ky-KG" />
                        <asp:ListItem Text="KHR - Khmer (Cambodia)" Value="km-KH" />
                        <asp:ListItem Text="KRW - Korean (Korea)" Value="ko-KR" />
                        <asp:ListItem Text="KWD - Arabic (Kuwait)" Value="ar-KW" />
                        <asp:ListItem Text="KZT - Kazakh (Kazakhstan)" Value="kk-KZ" />
                        <asp:ListItem Text="LAK - Lao (Lao PDR)" Value="lo-LA" />
                        <asp:ListItem Text="LBP - Arabic (Lebanon)" Value="ar-LB" />
                        <asp:ListItem Text="LKR - Sinhala (Sri Lanka)" Value="si-LK" />
                        <asp:ListItem Text="LKR - Tamil (Sri Lanka)" Value="ta-LK" />
                        <asp:ListItem Text="LTL - Lithuanian (Lithuania)" Value="lt-LT" />
                        <asp:ListItem Text="LVL - Latvian (Latvia)" Value="lv-LV" />
                        <asp:ListItem Text="LYD - Arabic (Libya)" Value="ar-LY" />
                        <asp:ListItem Text="MAD - Arabic (Morocco)" Value="ar-MA" />
                        <asp:ListItem Text="MAD - Central Atlas Tamazight (Tifinagh) (Morocco)" Value="tzm-Tfng-MA" />
                        <asp:ListItem Text="MKD - Macedonian (Former Yugoslav Republic of Macedonia)" Value="mk-MK" />
                        <asp:ListItem Text="MNT - Mongolian (Cyrillic, Mongolia)" Value="mn-MN" />
                        <asp:ListItem Text="MOP - Chinese (Macao S.A.R.)" Value="zh-MO" />
                        <asp:ListItem Text="MVR - Divehi (Maldives)" Value="dv-MV" />
                        <asp:ListItem Text="MXN - Spanish (Mexico)" Value="es-MX" />
                        <asp:ListItem Text="MYR - English (Malaysia)" Value="en-MY" />
                        <asp:ListItem Text="MYR - Malay (Malaysia)" Value="ms-MY" />
                        <asp:ListItem Text="NGN - Hausa (Latin) (Nigeria)" Value="ha-Latn-NG" />
                        <asp:ListItem Text="NGN - Igbo (Nigeria)" Value="ig-NG" />
                        <asp:ListItem Text="NGN - Yoruba (Nigeria)" Value="yo-NG" />
                        <asp:ListItem Text="NIO - Spanish (Nicaragua)" Value="es-NI" />
                        <asp:ListItem Text="NOK - Norwegian, Bokm&#229;l (Norway)" Value="nb-NO" />
                        <asp:ListItem Text="NOK - Norwegian, Nynorsk (Norway)" Value="nn-NO" />
                        <asp:ListItem Text="NOK - Sami (Lule) (Norway)" Value="smj-NO" />
                        <asp:ListItem Text="NOK - Sami (Northern) (Norway)" Value="se-NO" />
                        <asp:ListItem Text="NOK - Sami (Southern) (Norway)" Value="sma-NO" />
                        <asp:ListItem Text="NPR - Nepali (Nepal)" Value="ne-NP" />
                        <asp:ListItem Text="NZD - English (New Zealand)" Value="en-NZ" />
                        <asp:ListItem Text="NZD - Maori (New Zealand)" Value="mi-NZ" />
                        <asp:ListItem Text="OMR - Arabic (Oman)" Value="ar-OM" />
                        <asp:ListItem Text="PAB - Spanish (Panama)" Value="es-PA" />
                        <asp:ListItem Text="PEN - Quechua (Peru)" Value="quz-PE" />
                        <asp:ListItem Text="PEN - Spanish (Peru)" Value="es-PE" />
                        <asp:ListItem Text="PHP - English (Republic of the Philippines)" Value="en-PH" />
                        <asp:ListItem Text="PHP - Filipino (Philippines)" Value="fil-PH" />
                        <asp:ListItem Text="PKR - Punjabi (Pakistan)" Value="pa-Arab-PK" />
                        <asp:ListItem Text="PKR - Sindhi (Pakistan)" Value="sd-Arab-PK" />
                        <asp:ListItem Text="PKR - Urdu (Islamic Republic of Pakistan)" Value="ur-PK" />
                        <asp:ListItem Text="PLN - Polish (Poland)" Value="pl-PL" />
                        <asp:ListItem Text="PYG - Spanish (Paraguay)" Value="es-PY" />
                        <asp:ListItem Text="QAR - Arabic (Qatar)" Value="ar-QA" />
                        <asp:ListItem Text="ROL - Romanian (Romania)" Value="ro-RO" />
                        <asp:ListItem Text="RSD - Serbian (Cyrillic) (Serbia)" Value="sr-Cyrl-RS" />
                        <asp:ListItem Text="RSD - Serbian (Latin) (Serbia)" Value="sr-Latn-RS" />
                        <asp:ListItem Text="RUB - Bashkir (Russia)" Value="ba-RU" />
                        <asp:ListItem Text="RUB - Sakha (Russia)" Value="sah-RU" />
                        <asp:ListItem Text="RUR - Russian (Russia)" Value="ru-RU" />
                        <asp:ListItem Text="RUR - Tatar (Russia)" Value="tt-RU" />
                        <asp:ListItem Text="RWF - Kinyarwanda (Rwanda)" Value="rw-RW" />
                        <asp:ListItem Text="SAR - Arabic (Saudi Arabia)" Value="ar-SA" />
                        <asp:ListItem Text="SEK - Sami (Lule) (Sweden)" Value="smj-SE" />
                        <asp:ListItem Text="SEK - Sami (Northern) (Sweden)" Value="se-SE" />
                        <asp:ListItem Text="SEK - Sami (Southern) (Sweden)" Value="sma-SE" />
                        <asp:ListItem Text="SEK - Swedish (Sweden)" Value="sv-SE" />
                        <asp:ListItem Text="SGD - Chinese (Singapore)" Value="zh-SG" />
                        <asp:ListItem Text="SGD - English (Singapore)" Value="en-SG" />
                        <asp:ListItem Text="SYP - Arabic (Syria)" Value="ar-SY" />
                        <asp:ListItem Text="SYP - Syriac (Syria)" Value="syr-SY" />
                        <asp:ListItem Text="THB - Thai (Thailand)" Value="th-TH" />
                        <asp:ListItem Text="TJS - Tajik (Cyrillic) (Tajikistan)" Value="tg-Cyrl-TJ" />
                        <asp:ListItem Text="TMT - Turkmen (Turkmenistan)" Value="tk-TM" />
                        <asp:ListItem Text="TND - Arabic (Tunisia)" Value="ar-TN" />
                        <asp:ListItem Text="TRY - Turkish (Turkey)" Value="tr-TR" />
                        <asp:ListItem Text="TTD - English (Trinidad and Tobago)" Value="en-TT" />
                        <asp:ListItem Text="TWD - Chinese (Taiwan)" Value="zh-TW" />
                        <asp:ListItem Text="UAH - Ukrainian (Ukraine)" Value="uk-UA" />
                        <asp:ListItem Text="USD - Cherokee (United States)" Value="chr-Cher-US" />
                        <asp:ListItem Text="USD - English (Caribbean)" Value="en-029" />
                        <asp:ListItem Text="USD - English (United States)" Value="en-US" Selected="True" />
                        <asp:ListItem Text="USD - Hawaiian (United States)" Value="haw-US" />
                        <asp:ListItem Text="USD - Quichua (Ecuador)" Value="quz-EC" />
                        <asp:ListItem Text="USD - Spanish (Ecuador)" Value="es-EC" />
                        <asp:ListItem Text="USD - Spanish (El Salvador)" Value="es-SV" />
                        <asp:ListItem Text="USD - Spanish (Puerto Rico)" Value="es-PR" />
                        <asp:ListItem Text="USD - Spanish (United States)" Value="es-US" />
                        <asp:ListItem Text="UYU - Spanish (Uruguay)" Value="es-UY" />
                        <asp:ListItem Text="UZS - Uzbek (Cyrillic, Uzbekistan)" Value="uz-Cyrl-UZ" />
                        <asp:ListItem Text="UZS - Uzbek (Latin, Uzbekistan)" Value="uz-Latn-UZ" />
                        <asp:ListItem Text="VEB - Spanish (Venezuela)" Value="es-VE" />
                        <asp:ListItem Text="VND - Vietnamese (Vietnam)" Value="vi-VN" />
                        <asp:ListItem Text="XOF - Fulah (Senegal)" Value="ff-Latn-SN" />
                        <asp:ListItem Text="XOF - Wolof (Senegal)" Value="wo-SN" />
                        <asp:ListItem Text="YER - Arabic (Yemen)" Value="ar-YE" />
                        <asp:ListItem Text="ZAR - Afrikaans (South Africa)" Value="af-ZA" />
                        <asp:ListItem Text="ZAR - English (South Africa)" Value="en-ZA" />
                        <asp:ListItem Text="ZAR - isiXhosa (South Africa)" Value="xh-ZA" />
                        <asp:ListItem Text="ZAR - isiZulu (South Africa)" Value="zu-ZA" />
                        <asp:ListItem Text="ZAR - Sesotho sa Leboa (South Africa)" Value="nso-ZA" />
                        <asp:ListItem Text="ZAR - Setswana (South Africa)" Value="tn-ZA" />
                        <asp:ListItem Text="ZMW - English (Zambia)" Value="en-ZM" />
                        <asp:ListItem Text="ZWD - English (Zimbabwe)" Value="en-ZW" />
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="ExchangeRateLabelControl" runat="server" HelpText="The exchange rate relative to the primary currency." Text="Exchange rate:" CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ExchangeRateTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CurrencyDetailsViewControl">Exchange rate is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="ExchangeRateTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="10000000" MinimumValue="0" Type="Double" ValidationGroup="CurrencyDetailsViewControl">Exchange rate is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="ExchangeRateTextBox" runat="server" CssClass="dnnFormRequired">1.00</asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="AutoUpdateLabelControl" runat="server" HelpText="Automatically update the exchange rate using the selected provider." Text="Auto update:" />
                    <asp:CheckBox ID="AutoUpdateCheckBox" runat="server" />
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="ProviderLabelControl" runat="server" HelpText="Use the selected provider to automatically update the exchange rate. Each provider may return a slightly different rate based on where they source and how frequently they update their own internal rates. Please verify if the selected provider supports your currency and the accuracy of the rate returned." Text="Provider:" />
                    <asp:DropDownList ID="ProviderDropDownList" runat="server">
                        <asp:ListItem Text="European Central Bank" Value="ECB" />
                        <asp:ListItem Text="FareBookings" Value="FareBookings" />
                        <asp:ListItem Text="Yahoo Finance" Value="Yahoo" />
                    </asp:DropDownList>
                </div>
            </fieldset>
            <ul class="dnnActions">
                <li>
                    <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CurrencyDetailsViewControl" />
                </li>
                <li>
                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CurrencyDetailsViewControl" />
                </li>
                <li>
                    <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                </li>
            </ul>
        </div>

    </asp:View>
</asp:MultiView>