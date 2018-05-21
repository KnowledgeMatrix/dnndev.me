<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Settings.ascx.cs" Inherits="DesktopModules_RazorCart_TestModule_Settings" %>
Show completed tasks
<asp:DropDownList ID="ShowCompletedTasksSelector" runat="server">
    <asp:ListItem Value="True">Yes</asp:ListItem>
    <asp:ListItem Value="False">No</asp:ListItem>
</asp:DropDownList>