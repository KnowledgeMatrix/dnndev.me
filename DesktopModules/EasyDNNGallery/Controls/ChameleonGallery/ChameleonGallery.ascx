<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_ChameleonGallery, App_Web_chameleongallery.ascx.88d657a2" %>
<asp:Literal ID="ltChameleonScript" runat="server" EnableViewState="False"></asp:Literal>
<div id="ChameleonGallery" runat="server" enableviewstate="false">
	<div id="eds_slider<%=ModulNr%>" class="chameleon_slider <%=ViewState["CSSThemeDisplayStyle"]%>"></div>
</div>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
