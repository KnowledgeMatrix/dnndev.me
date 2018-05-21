<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SquareEcommerceAdmin.ascx.cs" Inherits="CartViper.Store.PaymentProviders.SquareEcommerceProvider.SquareEcommerceAdmin" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table style="text-align:left;">
	<tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblApplicationId" runat="server" controlname="txtApplicationId" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
			<asp:TextBox runat="server" ID="txtApplicationId" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="rf" resourcekey="rf" Display="Dynamic" ControlToValidate="txtApplicationId"></asp:RequiredFieldValidator>
	    </td>
	</tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblAccessToken" runat="server" controlname="txtAccessToken" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
           <asp:TextBox CssClass="txtAccessToken" runat="server" ID="txtAccessToken" Width="300px"></asp:TextBox>
            <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="RequiredFieldValidator1" resourcekey="rf" Display="Dynamic" ControlToValidate="txtAccessToken"></asp:RequiredFieldValidator>
	    </td>
    </tr>
    <tr>
		<td class="NormalBold" style="width:180px; vertical-align:top;">
			<dnn:label id="lblLocation" runat="server" controlname="chkUseTestMode" suffix=":"></dnn:label>
		</td>
		<td style="vertical-align:top;">
            <select runat="server" ID="ddlLocations" class="ddlLocations"></select><br />
             <asp:Label runat="server" CssClass="lblNoLocations adminPercentageInfo" Text="No valid locations found, please check your access token" ID="lblNoPlayLists" ForeColor="Red" Font-Bold="true" Font-Italic="true" Font-Size="XX-Small"></asp:Label>
             <input class="locationId" type='hidden' id='locationId' runat="server" />
	    </td>
    </tr>
</table>

<script type="text/javascript">

    function LoadLocations(initalLoad) {
        var ddlLocations = jQuery(".ddlLocations");
        ddlLocations.empty();

        var data = {};
        data.action = 'get_square_ecommerce_locations';
        data.language = '<%= System.Threading.Thread.CurrentThread.CurrentCulture.ToString() %>';
        data.accesstoken = jQuery(".txtAccessToken").val();

        jQuery.ajax({
            type: "POST",
            async: true,
            url: "<%= AjaxHandlerPath %>",
            dataType: "json",
            data: (data),
            success: function (data) {

                if (data.result) {
                                        
                    for (var i = 0; i < data.Locations.length; i++) {
                        ddlLocations.append($("<option />").val(data.Locations[i].Id).text(data.Locations[i].Name));
                    }

                    if (initalLoad) {
                        ddlLocations.val(jQuery(".locationId").val());
                    }

                    if (data.Locations != null && data.Locations.length > 0) {
                        jQuery(".lblNoLocations").hide();
                        jQuery(".locationId").val(ddlLocations.val());
                    }
                    else {
                        jQuery(".lblNoLocations").show();
                    }
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            },
            beforeSend: function (xhr) {
            },
            complete: function (XMLHttpRequest, textStatus) {
            }
        });

    }

    jQuery(document).ready(function () {

        LoadLocations(true);

        jQuery(".txtAccessToken").blur(function () {
            LoadLocations(false);
        });
        
        jQuery(".ddlLocations").change(function () {
            jQuery(".locationId").val(jQuery(".ddlLocations").val());
        });
       
    });
</script>