<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="eds_pageLoader eds_pageLoader2">
	<div class="eds_customImage"></div>
	<dnn:TEXT runat="server" id="PortalNameTitle" CssClass="eds_preloadPortalTitle" replaceTokens="True" ShowText="[Portal]" />
	<p class="eds_customText"><%= Localization.GetString("CustomLoadingText.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></p>
</div>

