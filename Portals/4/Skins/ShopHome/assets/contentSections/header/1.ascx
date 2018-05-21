<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone">
	<div class="eds_headerContainer eds_headerContainer1">
		<div class="eds_fixedHeader eds_headerHeight" data-placeholder-selector=".eds_headerHeightHolder">
			<div class="eds_headerBackground">
				<header class="eds_header clearfix center-block container-fluid">
					<div class="eds_logo pull-left eds_logoHeader1"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
					<% if Localization.GetEnabledLocales().Count > 1 Then %>
					<div class="eds_language pull-left">
						<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
						<span class="eds_languageText"><%= Localization.GetString("Language.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
					</div>
					<% End If %>
					<span class="eds_searchButton">Search</span>
					<div class="eds_userLogin pull-right">
						<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
					</div>
					<div class="eds_searchContainer">
						<span class="eds_searchClose">&times;</span>
						<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
					</div>
					<div class="responsAbilityMenu pull-right">
						<div class="raMenuTriggerWrapper">
							<span class="raMenuTrigger"><%= Localization.GetString("Menu.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
						</div>
						<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
					</div>
				</header>
			</div>
		</div>

