<%@ Control language="c#" CodeBehind="CardSaveAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.CardSaveProvider.CardSaveAdmin" AutoEventWireup="True" %>

<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblMerchantId" runat="server" controlname="txtMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtMerchantId" CssClass="Normal" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfv" 
                runat="server" 
                ErrorMessage="<br/>Required Field"
                Display="Dynamic"
                ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPassword" runat="server" controlname="txtPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtPassword" CssClass="Normal" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" 
                runat="server" 
                ErrorMessage="<br/>Required Field"
                Display="Dynamic"
                ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>

    
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblSharedSecret" runat="server" controlname="txtSharedSecret" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtSharedSecret" CssClass="Normal" runat="server" Width="300px" MaxLength="255"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" 
                runat="server" 
                ErrorMessage="<br/>Required Field"
                Display="Dynamic"
                ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblDomain" runat="server" controlname="txtDomain" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtDomain" CssClass="Normal" runat="server" Width="300px" MaxLength="255"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" 
                runat="server" 
                ErrorMessage="<br/>Required Field"
                Display="Dynamic"
                ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblPort" runat="server" controlname="txtPort" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtPort" CssClass="Normal" runat="server" Width="50px" MaxLength="5"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" 
                runat="server" 
                ErrorMessage="<br/>Required Field"
                Display="Dynamic"
                ControlToValidate="txtMerchantId"></asp:RequiredFieldValidator>
		</td>
	</tr>

	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblTestMode" runat="server" controlname="cbTest" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:CheckBox id="cbTest" runat="server" CssClass="Normal"></asp:CheckBox>
		</td>
	</tr>
</table>


<asp:CheckBox runat="server" ID="chkEnableRecurring" CssClass="chkEnableRecurring" Text=" Enable Recurring Payment" />

<table id="tblRecurringPayment" style="display:none;">
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblRPMerchantId" runat="server" controlname="txtRPMerchantId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtRPMerchantId" CssClass="Normal" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>
	<tr>
		<td class="NormalBold" style="width:150px; vertical-align:top;">
			<dnn:label id="lblRPPassword" runat="server" controlname="txtRPPassword" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox id="txtRPPassword" CssClass="Normal" runat="server" Width="300px" MaxLength="50"></asp:TextBox>
		</td>
	</tr>

</table>

<script type="text/javascript">

    ShowHideRecurring();

    jQuery(document).ready(function () {

        jQuery(".chkEnableRecurring").find(":input").click(function () {
            ShowHideRecurring();
        });
    });

    function ShowHideRecurring() {
        if (jQuery(".chkEnableRecurring :input").is(":checked")) {
            jQuery("#tblRecurringPayment").show();
        } else {
            jQuery("#tblRecurringPayment").hide();
        }
    }
</script>

