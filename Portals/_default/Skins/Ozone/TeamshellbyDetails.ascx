<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
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
<%--here i am adding my own custom css --%>
<dnn:DnnCssInclude runat="server" id="customcss" FilePath="common/css/custom.css" PathNameAlias="SkinPath" Priority="10" />

<dnn:DnnCssInclude runat="server" id="bootstrapcss" FilePath="bootstrap/css/bootstrap.min.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnCssInclude runat="server" id="OzoneBaseStyle" FilePath="common/css/base.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnCssInclude runat="server" id="FontAwesome" FilePath="common/css/font-awesome.min.css" PathNameAlias="SkinPath" Priority="10" />
<dnn:DnnJsInclude ID="bootstrapJS" runat="server" FilePath="bootstrap/js/bootstrap.min.js" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude ID="ozoneMainJs" runat="server" FilePath="common/js/main.js" PathNameAlias="SkinPath" />

<StyleWizard:Skin runat="server" id="OzoneStyleWizard" templateGroup="home" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    
    <!-- Bootstrap -->
    <link href="/Resources/Shared/stylesheets/TeamShelby/css/bootstrap.min.css" rel="stylesheet">
    <link href="/Resources/Shared/stylesheets/TeamShelby/css/custom.css" rel="stylesheet">

    <link href="/Resources/Shared/stylesheets/shelBy/css/Vehicle.css" rel="stylesheet">
    <link href="/Resources/Shared/stylesheets/NewStyle.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/fonts/FontAwesome.otf" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/fonts/fontawesome-webfont.ttf" rel="stylesheet">
	

    <style type="text/css">
h2 {
        margin: 0px; 
}

.chameleon_slider.NewsOne .main_panel{
height: 500px !important;

}
.chameleon_slider .main_panel .items_wrapper .item_container>div>iframe{
height: 600px !important;
}
.chameleon_slider .main_panel .items_wrapper .item_container{
height: 600px !important;
}

.chameleon_slider.NewsOne .thumb_wrapper{

    display: none;
height: 0px !important;
}
.chameleon_slider.NewsOne .title_box.current_item{

    top: 25px !important;
    left: 34px !important;
    height: auto !important;
background: none !important;
}

.chameleon_slider.NewsOne .title_box span{
color: #e71601;
    font-size: 60px;

}
.chameleon_slider.NewsOne .scrollable_box.item_info{

max-height: 250px !important;
    bottom: 0px !important;
    background: #0c0c0c9c !important;
}

.chameleon_slider.NewsOne .scrollable_box .scrollbar{
display: none !important;
}
.chameleon_slider.NewsOne .scrollable_box .viewport.scrollable{
height: auto !important;
max-height: 250px !important;
}

.chameleon_slider.NewsOne .scrollable_box .scrollbar{
display: none;
}

.chameleon_slider.NewsOne .scrollable_box .viewport .overview, .chameleon_slider.NewsOne .scrollable_box .viewport p{
   font-size: 60px;
    line-height: 45px;
    
    padding-left: 17px

}
    </style>
    <script type="text/javascript">
    </script>
</head>
<body>
<!-- loader_StyleWizardTemplateSection --><!-- loader_StyleWizardTemplateSectionEnd -->
<!-- header_StyleWizardTemplateSection -->
<div class="EasyDNNSkin_Ozone">
        <!--display haeder for search products-->
      <div class="main_nav_search">
        <div class="nav-search">
            <span class="search_txt">Team Shellby</span>
            <img src="<%=SkinPath%>/shelby-logo1.png" />
            <div class="input-group">
              <input type="text" class="form-control" placeholder="Search for products, brands and more...">
              <span class="input-group-btn">
                <button class="btn btn-default" type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
              </span>
            </div><!-- /input-group -->
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><dnn:LOGIN runat="server" ID="Login" /></li><li><dnn:USER runat="server" ID="Register" /></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">More <span class="caret"></span></a>
              <ul class="dropdown-menu">
                <li><a href="#"><span class="glyphicon glyphicon-folder-close"></span>Sell on Team shellBy</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-earphone"></span>24*7 Customer Care</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-flash"></span>Advertise</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-save"></span>Download App</a></li>
              </ul>
            </li>
            <li><a href="#"><span class="glyphicon glyphicon-shopping-cart"></span> Cart</a></li>
          </ul>
    </div>

  <!-- display list items in the header-->
     <div class="">
             <div class="col-sm-12 eds_container" id="headerMegamenuPane" runat="server"></div>
    </div>
    <div class="container-fluid">
		<div class="row">
			<div id="leftPane8" class="col-sm-12 eds_container" runat="server"></div>
		</div>
	</div>
   
     <div class="catlog_section" id="make_model_year">
            <div class="col-sm-2 eds_container edess_container">
                <h4><p>Customers who bought this also purchased</p></h4>
            </div>
            <div class="col-sm-10">
                <div class="row">
                   <div id="buyCustomersPane" runat="server"></div>
                  </div>
            </div>
        </div>
     <div class="catlog_section" id="make_model_year2">
            <div class="col-sm-2 eds_container edess_container">
                <h4><p>Products related to this item</p></h4>
            </div>
            <div class="col-sm-10">
                <div class="row">
                   <div id="relatedProductsPane" runat="server"></div>
                  </div>
            </div>
        </div>

	<div id="ContentPane" class="eds_container container-fluid" runat="server"></div>
	<div class="container-fluid">
		<div class="row">
			<div id="MainPane" runat="server"></div>
		</div>
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
	</div>
	<div id="contentPane5" class="container-fluid eds_container" runat="server"></div>
	<div class="eds_contentBellow5Background">
		<div id="contentPane6" class="container-fluid eds_container" runat="server"></div>
	</div>
	<div class="eds_paralaxBackground eds_pBackground2">
		<div id="contentPane7" class="eds_contentBellow6 container-fluid eds_container" runat="server"></div>
	</div>
	
     <div class="container-fluid">
       
        <div class="row">
            <div id="FooterPane" class="col-sm-12 eds_container" runat="server"></div>
        </div>
    </div>
</div>
<a data-options='{ "speed": 700,"easing": "easeOutQuint","updateURL": false }' href="#" class="eds_scrollTo eds_backToTop"><span><%= Localization.GetString("BackToTop.Text", SkinPath + "App_LocalResources/localization.ascx.resx") %></span></a>


    <script src="/Resources/Shared/stylesheets/TeamShelby/js/bootstrap.min.js"></script>
</body>
</html>

<script type="text/javascript">
    $(document).ready(function () {
        //to header mega menu
                $(".dropdown").hover(
                    function () {
                        $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true, true).slideDown("400");
                        $(this).toggleClass('open');
                    },
                    function () {
                        $('.dropdown-menu', this).not('.in .dropdown-menu').stop(true, true).slideUp("400");
                        $(this).toggleClass('open');
                    }
                );
    })
</script>