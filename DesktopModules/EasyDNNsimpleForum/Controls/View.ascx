<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="EasyDNNSolutions.Modules.EasyDNNsimpleForum.Controls.View" %>
<div id="eds__simpleForum_<%=ModuleId %>" class="<%=MainAppDivClass %>" data-moduleid="<%=ModuleId %>" data-portalid="<%=PortalId %>" data-linkinfo="<%=Server.HtmlEncode(LinkInfo.ToJson()) %>"></div>
<asp:PlaceHolder ID="phActivationContainer" runat="server" Visible="False" />
