<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone">
	<div class="eds_headerContainer eds_headerContainer2 eds_headerContainer3 eds_headerContainer4">
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
							<div class="eds_search pull-right">
								<span class="eds_searchButton">Search</span>
								<div>
									<div class="eds_searchContainer">
										<span class="eds_searchClose">&times;</span>
										<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="center-block container-fluid clearfix eds_logoMenuContainer">
						<div class="eds_logo pull-left"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
						<div class="responsAbilityMenu eds_menuType4 pull-right">
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

