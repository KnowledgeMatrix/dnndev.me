<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TestLogin.ascx.cs" Inherits="DesktopModules_MVC_TestModule_TestLogin" %>
<div>
    <h4 style="text-align:center;color:aqua">Please Login Here:</h4>
    <div style="text-align:center">
        UserName:<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
        Password:<asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
        <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" /><asp:Button ID="Button2" runat="server" Text="Cancel" />
    </div>
    
</div>