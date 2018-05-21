<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKS" Src="~/Admin/Skins/Links.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKTOMOBILE" Src="~/Admin/Skins/LinkToMobileSite.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USERANDLOGIN" Src="~/Admin/Skins/UserAndLogin.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TOAST" Src="~/Admin/Skins/Toast.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CONTROLPANEL" Src="~/Admin/Skins/controlpanel.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:META ID="META1" runat="server" Name="viewport" Content="width=device-width,initial-scale=1.0,maximum-scale=1.0" />
<div class="page-wrap">
	<div class="topBar">
		<div class="skinWidth">
			<div class="language"><dnn:LANGUAGE runat="server" id="dnnLANGUAGE" showMenu="False" showLinks="True" /></div>
			<div class="right">
				<div class="login"><dnn:USERANDLOGIN id="userLogin" runat="Server" /></div>
				<div class="login"><dnn:TOAST id="toast" runat="Server" /></div>
			</div>
		</div>
		<div class="dnnClear"></div>
	</div>
	<div class="header">
		<div class="skinWidth">
			<div class="topHeader">
				<div class="mobileMenu"><a href="javascript:void(0)">Menu</a></div>
				<div class="logo"><dnn:LOGO runat="server" id="dnnLOGO" /></div>
				<div class="search dnnRight"><dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" /></div>
				<div class="nav"><dnn:MENU MenuStyle="Simple" runat="server"></dnn:MENU></div>
			   
				<div class="dnnClear"></div>
			</div><!--/topLink-->
		</div><!--/skinWidth-->
	</div><!--/header-->
	<div class="ContentWrapDark">
		<div id="TopHeroDark" class="TopHeroDark" runat="server"></div>
		<div class="skinWidth">
			<div id="TopPane" class="TopPane" runat="server"></div>
			<div class="dnnClear"></div>
		</div>
	</div>
	<div class="contentWrap">
		<div id="topHero" class="topHero" runat="server"></div>
		<div class="skinWidth">
			<div id="ContentPane" class="ContentPane" runat="server"></div>	
			<div class="dnnClear"></div>
			<div id="LeftPane" class="LeftPane" runat="server"></div>
			<div id="RightPane" class="RightPane" runat="server"></div>
			<div class="dnnClear"></div>
			<div id="leftPaneNarrow" class="leftPaneNarrow" runat="server"></div>
			<div id="rightPaneWide" class="rightPaneWide spacingLeft" runat="server"></div>	
			<div class="dnnClear"></div>
			
		</div><!--/skinWidth-->
	</div><!--/contentWrap-->
</div>
<!-- /page-wrap -->
<div class="footer">
	<div class="copyright">
		<div class="skinWidth">
			<dnn:COPYRIGHT ID="dnnCopyright" runat="server" />
		</div>
	</div>
	<div class="skinWidth">
		<div id="FooterPane" class="footerPane" runat="server"></div>
	</div>
	<div class="dnnClear"></div>
</div><!--/footer-->

<script type="text/javascript">
    $(window).load(function () {

    	/* When right pane empty and not in edit mode, make left pane full width */		
		if ($('.RightPane h6').length == 0 && !$('body').is('.dnnEditState') && $('.RightPane .ModDNNHTMLC').length == 0) {
				
			$('.LeftPane').addClass("noRightPane");
		}

        /* Toggle User Properties Menu
        -------------------------------------------*/
        $('.userName a').click(function (e) {
            $(this).toggleClass('active');
            $('.userMenu').fadeToggle('fast');
            e.stopPropagation();
        });
        $(document.body).click(function () {
            $('.userMenu').hide();
            $('.userName a').removeClass("active");
        });
        $('#dnn_pnav li').mouseenter(function () {
            $('.userMenu').hide();
            $('.userName a').removeClass("active");
        });
        $('.userMenu').click(function (e) {
            e.stopPropagation();
        });


        /* Set CSS3 Animations via class: http://daneden.me/animate/ 
        ---------------------------------------------*/
        $("#dnn_pnav li").hover(
             function () {
                 // detect viewport
                 var width = $(window).width();
                 if (width < 1400)
                     $("ul", this).removeClass().addClass('fadeInDown rightDropdown');
                 else
                     $("ul", this).removeClass().addClass('fadeInDown');
             },
             function () { $("ul", this).removeClass().addClass('fadeOutUp'); }
         );
        $("#dnn_pnav li ul li").hover(
             function () { $("ul", this).removeClass().addClass('fadeInLeft'); },
             function () { $("ul", this).removeClass().addClass('fadeOutRight'); }
         );
		 
		 /* Mobile Menu 
        ---------------------------------------------*/
		$('.mobileMenu > a').click(function(){
			if($('ul#dnn_pnav').is(':visible')){
				$('ul#dnn_pnav').slideUp('fast');
			}
			else{
				$('ul#dnn_pnav').slideDown('fast');
				$('ul#dnn_pnav > li > ul').each(function(){
					var ul = $(this);
					if(ul.data('side-arrow')) return;
					ul.data('side-arrow', 1);
					$('<div class="nav-side-arrow"><div class="right"></div></div>').insertBefore(ul).on('click', function(){
						var div = $(this).find('div');
						if(div.hasClass('right')){
							div.removeClass('right').addClass('down');
							ul.slideDown('fast');
						}
						else{
							div.removeClass('down').addClass('right');
							ul.slideUp('fast');
						}
						return false;
					});
				});
			}
		});
  });
</script>

