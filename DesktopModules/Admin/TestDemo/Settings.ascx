<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Settings.ascx.cs" Inherits="DesktopModules_Admin_TestDemo_Settings" %>
<div>
    select usertype:<asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem Text="select user type" Value="normal" Selected="True"></asp:ListItem>
        <asp:ListItem Text="Merchandise" Value="Merchandise"></asp:ListItem>
        <asp:ListItem Text="sheller" Value="sheller"></asp:ListItem>
                    </asp:DropDownList>
    <br />
    <asp:Button ID="btnOk" runat="server" Text="OK" /><asp:Button ID="btnCancel" runat="server" Text="Cancel" />
</div>