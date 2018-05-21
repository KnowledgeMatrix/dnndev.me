<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>

		<div class="eds_pageDetails eds_pageDetails2">
			<div class="eds_headerHeightHolder eds_headerHeightHolderPd"></div>
			<div class="container-fluid eds_titleBreadcrumbsContainer">
				<div class="eds_breadCrumbs"><dnn:BREADCRUMB ID="dnnBreadcrumb" runat="server" CssClass="eds_breadCrumb" RootLevel="0" Separator="&lt;span class=&quot;fa fa-chevron-right eds_breadcrumbSeparator&quot;&gt;&lt;/span&gt;" HideWithNoBreadCrumb="true" /></div>
				<% if Not String.isNullOrEmpty(PortalSettings.ActiveTab.Title) Then %><h1 class="eds_pageTitle"><span><%= Server.HtmlEncode(PortalSettings.ActiveTab.Title)%></span></h1><% End If %>
			</div>
		</div>
