<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone">
	<div class="eds_headerContainer eds_headerContainer2">
		<div class="eds_fixedHeader eds_headerHeight" data-placeholder-selector=".eds_headerHeightHolder">
			<div class="eds_headerBackground">
				<header class="eds_header">
					<div class="eds_userLanguageBg clearfix">
						<div class="center-block container-fluid">
							<% if Localization.GetEnabledLocales().Count > 1 Then %>
							<div class="eds_language pull-left">
								<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
								<span class="eds_languageText"><%= Localization.GetString("Language.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
							</div>
							<% End If %>
							<div class="eds_userLogin pull-right">
								<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
								<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
							</div>
						</div>
					</div>
					<div class="center-block container-fluid clearfix">
						<div class="eds_logo eds_logoHeader2 pull-left"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
						<div class="eds_headerRight pull-right">
							<div id="HeaderBanner" class="eds_headerBanner" runat="server"></div>
							<div class="header2search">
								<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="eds_searchButton2" />
							</div>
						</div>
					</div>
					<div class="eds_menuBg clearfix">
						<div class="responsAbilityMenu eds_menuType2 center-block container-fluid">
							<div class="raMenuTriggerWrapper">
								<span class="raMenuTrigger"><%= Localization.GetString("Menu.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
							</div>
							<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
						</div>
					</div>
				</header>
			</div>
		</div>
		<div class="eds_headerHeightHolder"></div>

