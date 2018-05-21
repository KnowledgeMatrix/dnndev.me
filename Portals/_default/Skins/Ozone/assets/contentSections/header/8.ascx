<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone eds_fixedSideHeader eds_headerOnClickOpen">
	<div class="eds_headerContainer">
		<div class="eds_fixedHeader eds_headerStyle8 eds_animatedHeader eds_headerHeight" data-placeholder-selector=".eds_headerHeightHolderSmall">
			<div class="eds_headerBackground">
				<header class="container-fluid eds_header8Container">
					<div class="eds_header8middle">
						<div class="eds_header8Logo">
							<div>
								<dnn:LOGO runat="server" id="dnnLOGO" />
							</div>
						</div>
					</div>
					<div class="eds_header8left">
						<div class="eds_sideHeader8TrigerContainer">
							<span class="eds_sideHeader8Triger">
								<i class="fa fa-bars eds_headerOpen"></i>
								<i class="fa fa-times eds_headerClose"></i>
							</span>
						</div>
					</div>
					<div class="eds_header8right">
						<div id="HeaderPane" class="eds_Header8Pane" runat="server"></div>
						<div class="eds_Header8PaneTrigerContainer">
							<i class="fa fa-plus-square-o eds_Header8PaneTriger"></i>
						</div>
						<% if Localization.GetEnabledLocales().Count > 1 Then %>
						<div class="eds_header8Language">
							<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
						</div>
						<div class="eds_header8LanguageTrigerContainer">
							<span class="eds_header8LanguageTriger">
								<i class="fa fa-globe"></i>
							</span>
						</div>
						<% End If %>
						<div class="eds_header8SearchPanelTrigerContainer">
							<a href="<%= SkinPath %>#" class="fa fa-search eds_header8SearchPanelTriger"><span>Search</span></a>
						</div>
						<div class="eds_header8UserPanelTrigerContainer">
							<a href="<%= SkinPath %>#" class="fa fa-user eds_header8UserPanelTriger"><span>Register/Login</span></a>
						</div>
					</div>
				</header>
			</div>
		</div>
		<div class="eds_headerHeightHolder"></div>
		<div class="eds_headerHeightHolderSmall"></div>
		<div class="eds_header8UserPanel">
			<div class="container-fluid eds_header8UserLogin">
				<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
				<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
			</div>
		</div>
		<div class="eds_header8SearchPanel">
			<div class="eds_header8searchTitleContainer">
				<div class="container-fluid">
					<h5 class="eds_header8SearchTitle"><%= Localization.GetString("Search.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></h5>
				</div>
			</div>
			<div class="container-fluid">
				<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
			</div>
		</div>
		<div class="eds_sideHeader">
			<div class="eds_sideWrapper">
				<header class="eds_header">
					<div class="eds_logoCloseContainer">
						<div class="eds_logo eds_logoHeader8"><dnn:LOGO runat="server" id="dnnLOGO2" /></div>
						<div class="eds_sideHeader8CloseContainer">
							<span class="eds_sideHeader8Close">
								<i class="fa fa-times eds_headerClose"></i>
							</span>
						</div>
					</div>
					<div id="HeaderPaneTop" class="eds_sideHeaderPane eds_sideHeaderPaneTop" runat="server"></div>
					<div class="responsAbilityMenu sideMenu hoverOpensItems eds_sideMenu8">
						<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
					</div>
					<div id="HeaderPaneBottom" class="eds_sideHeaderPane" runat="server"></div>
				</header>
			</div>
		</div>
