<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone eds_fixedSideHeader eds_headerOnClickOpen eds_rightSideHeader">
	<div class="eds_headerContainer eds_headerContainer1">
		<div class="eds_fixedHeader eds_headerStyle7 eds_headerHeight" data-placeholder-selector=".eds_headerHeightHolder">
			<div class="eds_headerBackground">
				<header class="eds_header clearfix">
					<div class="container-fluid eds_logoMenuSearchContainer">
						<div class="eds_logo pull-left eds_logoHeader1"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
						<div class="eds_sideHeader7TrigerContainer">
							<span class="eds_sideHeader7Triger">
								<i class="fa fa-bars eds_headerOpen"></i>
								<i class="fa fa-times eds_headerClose"></i>
							</span>
						</div>
						<div class="responsAbilityMenu pull-right">
							<div class="raMenuTriggerWrapper">
								<span class="raMenuTrigger"><%= Localization.GetString("Menu.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span>
							</div>
							<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
						</div>
					</div>
				</header>
			</div>
		</div>
		<div class="eds_sideHeader eds_sideHeader7">
			<div class="eds_sideWrapper">
				<header class="eds_header">
					<div class="eds_sideHeader7CloseContainer">
						<span class="eds_sideHeader7Close"></span>
					</div>
					<div id="HeaderPaneTop" class="eds_sideHeaderPane eds_sideHeaderPaneTop" runat="server"></div>
					<div class="eds_searchContainer">
						<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
					</div>
					<div class="eds_language">
						<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
					</div>
					<div class="eds_userLogin">
						<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
					</div>
					<div id="HeaderPaneBottom" class="eds_sideHeaderPane" runat="server"></div>
				</header>
			</div>
		</div>
