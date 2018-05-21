<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.Dashboard, App_Web_dashboard.ascx.af09375b" %>
<%@ Register TagPrefix="dnnCTRL" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<div id="EDGAdminContent">
	<div class="topBarWrapper">
		<div class="wrapper">
			<ul class="links">
				<li>
					<span><%=strDashboard%></span>
				</li>
			</ul>
			<ul class="actions">
				<li class="close">
					<asp:HyperLink ID="hlPowerOff" runat="server" ToolTip="Close" resourcekey="lbPowerOffResource1">Exit</asp:HyperLink>
				</li>
			</ul>
		</div>
	</div>
	<div class="mainContentWrapper">
		<div class="contentSectionWrapper color1">
			<div class="main_content dashboard">
				<ul class="links">
					<li>
						<asp:HyperLink runat="server" ID="lbManageContent" class="icon gallery" resourcekey="lbManageContent" Visible="False">Manage content (add/edit media)</asp:HyperLink></li>
					<li>
						<asp:HyperLink runat="server" ID="lbGallerySettings" class="icon module_settings" resourcekey="lbGallerySettings" Visible="False">Gallery settings (setup gallery display)</asp:HyperLink></li>
				</ul>

				<ul class="links">
					<li>
						<asp:HyperLink runat="server" ID="lbCommentsModeration" resourcekey="lbCommentsModeration" class="icon comments">Comments Moderation</asp:HyperLink></li>
					<li>
						<asp:HyperLink runat="server" ID="lbCrossportalsharing" class="icon cross" resourcekey="lbCrossportalsharing">Cross portal sharing</asp:HyperLink></li>
					<li>
						<asp:HyperLink runat="server" ID="lbAPIsettings" class="icon apiconnections" resourcekey="lbAPIsettings">API settings</asp:HyperLink></li>
					<li>
						<asp:HyperLink runat="server" ID="lbRSSimports" class="icon atom" resourcekey="lbRSSimports">RSS import</asp:HyperLink></li>
				</ul>

				<ul class="links bigger_margin">
					<li>
						<asp:HyperLink runat="server" ID="lbGeneralSettings" class="icon general_settings" resourcekey="lbGeneralSettings">General settings</asp:HyperLink></li>
					<li>
						<asp:HyperLink runat="server" ID="hlDataImportExport" class="icon customfields_export" resourcekey="hlDataImportExport">Export/Import</asp:HyperLink></li>
				</ul>
			</div>
		</div>
	</div>
</div>
