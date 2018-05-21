<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CURRENTDATE" Src="~/Admin/Skins/currentdate.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%@ Register TagPrefix="StyleWizard" TagName="Skin" Src="~/DesktopModules/EasyDNNstyleWizard/SkinObjects/Skin.ascx" %>
<%@ Register TagPrefix="MegaMenu" TagName="MENU" src="~/DesktopModules/EasyDNNmegaMenu/Menu.ascx" %>
<dnn:META ID="META1" runat="server" Name="viewport" Content="width=device-width, initial-scale=1" />
<dnn:DnnCssInclude runat="server" id="bootstrapcss" FilePath="bootstrap/css/bootstrap.min.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnCssInclude runat="server" id="OzoneBaseStyle" FilePath="common/css/base.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnCssInclude runat="server" id="FontAwesome" FilePath="common/css/font-awesome.min.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnJsInclude ID="bootstrapJS" runat="server" FilePath="bootstrap/js/bootstrap.min.js" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude ID="ozoneMainJs" runat="server" FilePath="common/js/main.js" PathNameAlias="SkinPath" />
<StyleWizard:Skin runat="server" id="OzoneStyleWizard" templateGroup="social" />

<!-- loader_StyleWizardTemplateSection --><!-- loader_StyleWizardTemplateSectionEnd -->
<!-- header_StyleWizardTemplateSection -->
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
<!-- header_StyleWizardTemplateSectionEnd -->
<!-- pageDetails_StyleWizardTemplateSection -->
		<div class="eds_pageDetails eds_pageDetails1">
			<div class="eds_headerHeightHolder eds_headerHeightHolderPd"></div>
			<div class="container-fluid">
				<dnn:CURRENTDATE runat="server" id="dnnCURRENTDATE" CssClass="eds_currentDate pull-right" />
				<div class="eds_breadCrumbs"><dnn:BREADCRUMB ID="dnnBreadcrumb" runat="server" CssClass="eds_breadCrumb" RootLevel="0" Separator="&lt;span class=&quot;fa fa-chevron-right eds_breadcrumbSeparator&quot;&gt;&lt;/span&gt;" HideWithNoBreadCrumb="true" /></div>
				<% if Not String.isNullOrEmpty(PortalSettings.ActiveTab.Title) Then %><h1 class="eds_pageTitle"><span><%= Server.HtmlEncode(PortalSettings.ActiveTab.Title)%></span></h1><% End If %>
				<% if Not String.isNullOrEmpty(PortalSettings.ActiveTab.Description) Or Not String.isNullOrEmpty(PortalSettings.ActiveTab.IconFile) Then %>
					<p class="eds_pageDescription"><span>
					<% if Not String.isNullOrEmpty(PortalSettings.ActiveTab.Description) Then %><span><%= Server.HtmlEncode(PortalSettings.ActiveTab.Description)%></span>
					<% End If %>
					<% if Not String.isNullOrEmpty(PortalSettings.ActiveTab.IconFile) Then %><span><img src="<%= Server.HtmlEncode(PortalSettings.ActiveTab.IconFile)%>" alt="" /></span>
					<% End If %>
					</span></p>
				<% End If %>
			</div>
		</div><!-- pageDetails_StyleWizardTemplateSectionEnd -->
		<div class="eds_headerContent" id="headerWide" runat="server"></div>
	</div>
	<div class="eds_container container-fluid threeColSocial">
		<div id="rightPane" class="eds_threeColumnSocialRight" runat="server"></div>
		<div id="leftPane" class="eds_threeColumnSocialLeft" runat="server"></div>
		<div id="ContentPane" class="eds_threeColumnSocialCenter" runat="server"></div>
	</div>
	<div class="eds_contentBellowBackground">
		<div id="contentPane2" class="eds_container container-fluid" runat="server"></div>
		<div class="container-fluid">
			<div class="row">
				<div id="leftPane2" class="col-sm-6 eds_container" runat="server"></div>
				<div id="rightPane2" class="col-sm-6 eds_container" runat="server"></div>
			</div>
			<div class="row">
				<div id="threeColumnLeftPane2" class="col-sm-4 eds_container" runat="server"></div>
				<div id="threeColumnMiddlePane2" class="col-sm-4 eds_container" runat="server"></div>
				<div id="threeColumnRightPane2" class="col-sm-4 eds_container" runat="server"></div>
			</div>
		</div>
	</div>
	<div id="contentPane3" class="eds_contentBellow2 container-fluid eds_container" runat="server"></div>
	<div class="eds_paralaxBackground eds_pBackground1">
		<div id="contentPane4" class="eds_contentBellow3 container-fluid eds_container" runat="server"></div>
		<div class="container-fluid">
			<div class="row">
				<div id="leftPane4" class="col-sm-8 eds_container" runat="server"></div>
				<div id="sidebarPane4" class="col-sm-4 eds_container" runat="server"></div>
			</div>
		</div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div id="sidebarPane5" class="col-sm-4 eds_container" runat="server"></div>
			<div id="rightPane5" class="col-sm-8 eds_container" runat="server"></div>
		</div>
	</div>
	<div id="contentPane5" class="eds_contentBellow4 container-fluid eds_container" runat="server"></div>
	<div class="eds_contentBellow5Background">
		<div id="contentPane6" class="container-fluid eds_container" runat="server"></div>
	</div>
	<div class="eds_paralaxBackground eds_pBackground2">
		<div id="contentPane7" class="eds_contentBellow6 container-fluid eds_container" runat="server"></div>
	</div>
	<div class="container-fluid">
		<div class="row">
			<div id="leftPane8" class="col-sm-8 eds_container" runat="server"></div>
			<div id="sidebarPane8" class="col-sm-4 eds_container" runat="server"></div>
		</div>
	</div>
	<div id="contentPane8" class="container-fluid" runat="server"></div>
	<div class="container-fluid">
		<div class="row">
			<div id="sidebarLeftPane8" class="col-sm-4 eds_container" runat="server"></div>
			<div id="rightPane8" class="col-sm-8 eds_container" runat="server"></div>
		</div>
	</div>
	<div class="eds_bottomBannerBg">
		<div class="container-fluid eds_container" id="BottomBanner" runat="server"></div>
	</div>
	<div class="container-fluid eds_container" id="BottomPane1" runat="server"></div>
	<div class="eds_bottomPaneWide" id="BottomPane2" runat="server"></div>
	<div class="container-fluid eds_container" id="BottomPane3" runat="server"></div>
	<div class="edsFooterBackground clearfix">
		<div class="container-fluid">
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-3 footerBoxContainer" >
					<div class="footerBox" id="Footer1" runat="server"></div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-3 footerBoxContainer">
					<div class="footerBox eds_second" id="Footer2" runat="server"></div>
				</div>
				<div class="clearfix visible-sm" runat="server"></div>
				<div class="col-xs-12 col-sm-6 col-md-3 footerBoxContainer">
					<div class="footerBox" id="Footer3" runat="server"></div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-3 footerBoxContainer">
					<div class="footerBox eds_last" id="Footer4" runat="server"></div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div id="Footer5" class="col-sm-4 footerBoxContainer2" runat="server"></div>
				<div id="Footer6" class="col-sm-4 footerBoxContainer2" runat="server"></div>
				<div id="Footer7" class="col-sm-4 footerBoxContainer2" runat="server"></div>
			</div>
		</div>
	</div>
	<div class="edsCopyrightBg">
		<div class="edsCopyright container-fluid clearfix"><dnn:TERMS ID="dnnTerms" runat="server" CssClass="pull-right"/><dnn:PRIVACY ID="dnnPrivacy" runat="server" CssClass="pull-right"/><dnn:COPYRIGHT ID="dnnCopyright" runat="server" CssClass="pull-left" /></div>
	</div>
</div>
<a data-options='{ "speed": 700,"easing": "easeOutQuint","updateURL": false }' href="#" class="eds_scrollTo eds_backToTop"><span><%= Localization.GetString("BackToTop.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span></a>
