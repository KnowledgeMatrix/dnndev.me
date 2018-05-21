<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

<div class="EasyDNNSkin_Ozone eds_fixedSideHeader eds_headerOnClickOpen">
	<div class="eds_headerContainer">
		<span class="eds_sideHeaderTriger">
				<i class="fa fa-bars eds_headerOpen"></i>
				<i class="fa fa-times eds_headerClose"></i>
			</span>
		<div class="eds_sideHeader">
			<div class="eds_sideWrapper">
				<header class="eds_header">
					<div class="eds_logo"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
					<div class="eds_language">
						<dnn:LANGUAGE runat="server" id="LANGUAGE1" showMenu="false" showLinks="True" />
					</div>
					<div class="eds_userLogin">
						<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
					</div>
					<div class="eds_searchContainer">
						<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
					</div>
					<div id="HeaderPaneTop" class="eds_sideHeaderPane eds_sideHeaderPaneTop" runat="server"></div>
					<div class="responsAbilityMenu sideMenu hoverOpensItems">
						<div class="raMenuWrapper"><MegaMenu:MENU ID="main_menu" runat="server" /></div>
					</div>
					<div id="HeaderPaneBottom" class="eds_sideHeaderPane" runat="server"></div>
				</header>
			</div>
		</div>
