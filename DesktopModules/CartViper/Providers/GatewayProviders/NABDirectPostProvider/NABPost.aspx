<%@ Page Language="C#" AutoEventWireup="true" ViewStateMode="Disabled" EnableViewState="false" CodeBehind="NABPost.aspx.cs" Inherits="CartViper.Store.PaymentProviders.NABDirectPostProvider.NABPost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payment Details</title>
    <link href="/Portals/_default/default.css" type="text/css" rel="stylesheet" />
    <style>
    label {
    display: inline-block;
    width: 180px;
    }
    
    .mainForm
    {
        margin:50px;
    }
    </style>

    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery(".aspNetHidden").remove();
        });
    </script>

</head>
<body>
    <form id="form1" class="mainForm" runat="server">
    <div>
        <p>Please complete the purchase by entering your credit card details</p>

        <asp:PlaceHolder runat="server" ID="pcHidden" />

        <label for="EPS_CARDNUMBER">Credit Card Number</label>
        <input type="text" id="EPS_CARDNUMBER" name="EPS_CARDNUMBER" autocomplete="off"/><br />

        <label for="EPS_EXPIRYMONTH">Expiry Month</label>
        <select id="EPS_EXPIRYMONTH" name="EPS_EXPIRYMONTH">
			<option Value="01">01</option>
			<option Value="02">02</option>
			<option Value="03">03</option>
			<option Value="04">04</option>
			<option Value="05">05</option>
			<option Value="06">06</option>
			<option Value="07">07</option>
			<option Value="08">08</option>
			<option Value="09">09</option>
			<option Value="10">10</option>
			<option Value="11">11</option>
			<option Value="12">12</option>
        </select><br />

        <label for="EPS_EXPIRYYEAR">Expiry Year</label>
        <select id="EPS_EXPIRYYEAR" name="EPS_EXPIRYYEAR">
            <option Value="14">14</option>
			<option Value="15">15</option>
			<option Value="16">16</option>
			<option Value="17">17</option>
			<option Value="18">18</option>
			<option Value="19">19</option>
			<option Value="20">20</option>
			<option Value="21">21</option>
			<option Value="22">22</option>
			<option Value="23">23</option>
			<option Value="24">24</option>
			<option Value="25">25</option>
        </select><br />

        <label for="EPS_CCV">CCV</label>
        <input type="text" id="EPS_CCV" name="EPS_CCV" autocomplete="off" style="width:100px;"/><br />

        <button type="submit" value="Complete Purchase">Complete Purchase</button>
    </div>
    </form>
</body>
</html>
