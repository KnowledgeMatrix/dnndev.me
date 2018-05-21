<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Search.ascx.cs" Inherits="DotNetNuke.Professional.SocialEvents.Search" %>
<%@ Register TagPrefix="social" TagName="SearchControl" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/SearchControl.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="moduleContainer dnnClear">
    <social:SearchControl ID="CtlSearch" runat="server" />  
</asp:Panel>