<%@ Control language="c#" CodeBehind="StoreAddress.ascx.cs" Inherits="CartViper.Modules.Store.WebControls.Address.DefaultAddressProvider.StoreAddress" AutoEventWireup="True" %>

<input id="hiddenAddressId" type="hidden" runat="server" />
<table class="StoreAccountAddress" width="100%">
	<tr id="rowDescription" runat="server" visible="false">
		<td class="StoreAddressLabel">
		    <asp:label id="plDescription" runat="server" text="Description:"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtDescription" runat="server" MaxLength="50" cssclass="StoreAddressField" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator id="valDescription" ValidationGroup="cvCheckout" runat="server" CssClass="NormalRed" ControlToValidate="txtDescription" ErrorMessage="Description required." Display="Dynamic" resourcekey="DescriptionRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowFirstName" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plFirstName" runat="server" resourcekey="plFirstName"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtFirstName" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressFirstName" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" ID="valFirstName" runat="server" ControlToValidate="txtFirstName" CssClass="NormalRed" Display="Dynamic" ErrorMessage="* First Name required." resourcekey="FirstNameRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowLastName" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plLastName" runat="server" resourcekey="plLastName"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtLastName" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressSurname" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" ID="valLastName" runat="server" ControlToValidate="txtLastName" CssClass="NormalRed" Display="Dynamic" ErrorMessage="* Last Name required." resourcekey="LastNameRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
        <tr id="rowCompanyName" runat="server" visible="false">
        <td class="StoreAddressLabel">
            <asp:Label runat="server" ID="lblCompanyName" resourcekey="lblCompanyName"></asp:Label>
        </td>
        <td class="StoreAddressField">
            <asp:TextBox runat="server" ID="txtCompanyName"></asp:TextBox>
                 <asp:requiredfieldvalidator ValidationGroup="cvCheckout" ID="rfCompanyName" runat="server" ControlToValidate="txtCompanyName" CssClass="NormalRed" Display="Dynamic" ErrorMessage="* Company name is required." resourcekey="CompanyNameRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
        </td>
    </tr>
	<tr id="rowStreet" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plStreet" runat="server" resourcekey="plStreet"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtStreet" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddress1" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valStreet" runat="server" CssClass="NormalRed" ControlToValidate="txtStreet" ErrorMessage="* First line of address required." Display="Dynamic" resourcekey="StreetRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowUnit" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plUnit" runat="server" resourcekey="plUnit"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtUnit" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddress2" OnTextChanged="TextChanged"></asp:textbox>
		</td>
	</tr>
	<tr id="rowCity" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plCity" runat="server" resourcekey="plCity"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtCity" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressCity" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valCity" runat="server" CssClass="NormalRed" ControlToValidate="txtCity" ErrorMessage="* Town/city required." Display="Dynamic" resourcekey="CityRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowRegion" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plRegion" runat="server" resourcekey="plRegion"></asp:label>
		</td>
		<td class="StoreAddressField">
			<asp:DropDownList ID="cboRegion" runat="server" CssClass="StoreAddressField cvAddressState" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
			<asp:textbox id="txtRegion" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressRegion" OnTextChanged="TextChanged"></asp:textbox>
			<asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valRegion1" runat="server" CssClass="NormalRed" ControlToValidate="cboRegion" ErrorMessage="* County required cbo." Display="Dynamic" SetFocusOnError="True"></asp:requiredfieldvalidator>
			<asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valRegion2" runat="server" CssClass="NormalRed" ControlToValidate="txtRegion" ErrorMessage="* County required txt." Display="Dynamic" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
    <tr id="rowCounty" runat="server" class="cvAddressCountyRow">
        <td class="StoreAddressLabel">
            <asp:Label runat="server" ID="lblCounty" resourcekey="lblCounty"></asp:Label>
        </td>
        <td>
            <asp:DropDownList CssClass="cvAddressCounty" runat="server" ID="ddlCounty"></asp:DropDownList>
        </td>
    </tr>
    <tr id="rowPostal" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plPostal" runat="server" resourcekey="plPostal"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtPostal" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressZip" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valPostal" runat="server" CssClass="NormalRed" ControlToValidate="txtPostal" ErrorMessage="* Post code required." Display="Dynamic" resourcekey="PostalRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowCountry" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plCountry" runat="server" resourcekey="plCountry"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:DropDownList ID="ddlcountry" runat="server" DataValueField="Value" 
                DataTextField="Text" AutoPostBack="True" CssClass="StoreAddressField cvAddressCountry"
                onselectedindexchanged="ddlcountry_SelectedIndexChanged"></asp:DropDownList>
            <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valCountry" runat="server" CssClass="NormalRed" ControlToValidate="ddlcountry" ErrorMessage="* Country required." Display="Dynamic" resourcekey="CountryRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>	
	<tr id="rowTelephone" runat="server">
		<td class="StoreAddressLabel">
		    <asp:label id="plTelephone" runat="server" resourcekey="plTelephone"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtTelephone" runat="server" MaxLength="50" cssclass="StoreAddressField cvAddressTelephone" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="valTelephone" runat="server" CssClass="NormalRed" ControlToValidate="txtTelephone" ErrorMessage="* Telephone number required." Display="Dynamic" resourcekey="TelephoneRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
	<tr id="rowCell" runat="server" visible="false">
		<td class="StoreAddressLabel">
		    <asp:label id="plCell" runat="server" resourcekey="plCell"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtCell" runat="server" MaxLength="50" cssclass="StoreAddressField" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator id="valCell" ValidationGroup="cvCheckout" runat="server" CssClass="NormalRed" ControlToValidate="txtCell" ErrorMessage="* Mobile phone number required." Display="Dynamic" resourcekey="CellRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
		</td>
	</tr>
    <tr id="rowEmail" runat="server" visible="false">
		<td class="StoreAddressLabel">
		    <asp:label id="plEmail" runat="server" resourcekey="plEmail"></asp:label>
		</td>
		<td class="StoreAddressField">
		    <asp:textbox id="txtEmail" runat="server" MaxLength="100" cssclass="StoreAddressField" OnTextChanged="TextChanged"></asp:textbox>
		    <asp:requiredfieldvalidator ValidationGroup="cvCheckout" id="rfvEmail" runat="server" CssClass="NormalRed" 
                    ControlToValidate="txtEmail" Display="Dynamic" 
                    resourcekey="rfvEmail" SetFocusOnError="True"></asp:requiredfieldvalidator>
            <asp:RegularExpressionValidator ValidationGroup="cvCheckout" ID="revEmail" runat="server" 
                CssClass="NormalRed" ControlToValidate="txtEmail" Display="Dynamic" 
                resourcekey="revEmail" SetFocusOnError="True" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
		</td>
	</tr>
    <tr id="rowVatNumber" runat="server" visible="false">
        <td class="StoreAddressLabel">
            <asp:Label runat="server" ID="lblVatNumber" resourcekey="lblVatNumber"></asp:Label>
        </td>
        <td class="StoreAddressField">
            <asp:TextBox runat="server" ID="txtVatNumber"></asp:TextBox>
             <asp:requiredfieldvalidator ValidationGroup="cvCheckout" ID="rfVatNumber" runat="server" ControlToValidate="txtVatNumber" CssClass="NormalRed" Display="Dynamic" ErrorMessage="* Company name is required." resourcekey="VatNumberRequired" SetFocusOnError="True"></asp:requiredfieldvalidator>
        </td>
    </tr>
    <tr id="rowBusinessAddress" runat="server" visible="false">
        <td class="StoreAddressLabel">
            &nbsp;
        </td>
        <td class="StoreAddressField">
            <asp:CheckBox runat="server" ID="chkIsBusinessAddress" resourcekey="lblBusinessAddress" />
        </td>
    </tr>
</table>
