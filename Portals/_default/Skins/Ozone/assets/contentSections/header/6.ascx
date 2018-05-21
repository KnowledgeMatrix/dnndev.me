<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone">
	<div class="eds_headerContainer eds_headerContainer5 eds_headerContainer6">
		<div class="eds_fixedHeader eds_headerHeight" data-placeholder-selector=".eds_headerHeightHolder">
			<div class="eds_headerBackground">
				<header class="eds_header clearfix center-block container-fluid">
					<div class="eds_logo pull-left"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
					<div class="eds_headerRight pull-right">
						<span class="eds_searchButton">Search</span>
						<div class="eds_userLogin pull-right">
							<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
							<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
						</div>
						<div class="eds_searchContainer">
							<span class="eds_searchClose">&times;</span>
							<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
						</div>
					</div>
					<% if Localization.GetEnabledLocales().Count > 1 Then %>
					<div class="eds_language pull-right">
						<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
						<span class="eds_languageText"><%= Localization.GetString("Language.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
					</div>
					<% End If %>
					<div id="HeaderBanner" class="eds_headerBanner pull-right" runat="server"></div>
				</header>
				<div class="eds_menuType5bg">
					<div class="responsAbilityMenu eds_menuType5 clearfix center-block container-fluid">
						<div class="raMenuTriggerWrapper">
							<span class="raMenuTrigger"><%= Localization.GetString("Menu.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
						</div>
						<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
					</div>
				</div>
			</div>
		</div>
		<div class="eds_headerHeightHolder"></div>

