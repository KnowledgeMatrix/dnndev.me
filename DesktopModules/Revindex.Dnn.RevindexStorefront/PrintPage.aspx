<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrintPage.aspx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PrintPage" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body onload="window.print()">
    <form id="form1" runat="server">
    <div>
		<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
		<asp:Literal ID="BodyLiteral" runat="server"></asp:Literal>
    </div>
    </form>
</body>
</html>
