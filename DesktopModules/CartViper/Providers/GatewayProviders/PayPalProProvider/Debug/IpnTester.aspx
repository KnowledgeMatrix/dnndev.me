<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IpnTester.aspx.cs" Inherits="CartViper.Store.PaymentProviders.PayPalProProvider.Debug.IpnTester" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <h3>Suspend</h3>
        <div>
            Sub ID
            <asp:TextBox runat="server" ID="txtSuspendSubId" Text="45435435435345345"/>
        </div>
        <asp:Button runat="server" ID="btnSuspend" OnClick="btnSuspend_Click" Text="Submit" />
    </div>

    
    <div>
        <h3>Failed</h3>
        <div>
            Sub ID
            <asp:TextBox runat="server" ID="txtCancelSubId" Text="45435435435345345" />
        </div>
        <asp:Button runat="server" ID="btnCanel" OnClick="btnCanel_Click" Text="Submit" />
    </div>


    <div>
        <h3>Success</h3>
        <div>
            Sub ID
            <asp:TextBox runat="server" ID="txtSuccessSubId"  Text="45435435435345345"/>
        </div>
        <div>
            Amount
            <asp:TextBox runat="server" ID="txtSuccessAmount"  Text="9.99" />
        </div>
        <asp:Button runat="server" ID="btnSuccess" OnClick="btnSuccess_Click" Text="Submit" />
    </div>

    </form>
</body>
</html>
