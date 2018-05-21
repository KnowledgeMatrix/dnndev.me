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
<StyleWizard:Skin runat="server" id="OzoneStyleWizard" templateGroup="page" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Shelby</title>

    <!-- Bootstrap -->

    <link href="/Resources/Shared/stylesheets/shelBy/css/bootstrap.min.css" rel="stylesheet">

    <link href="/Resources/Shared/stylesheets/shelBy/css/style.css" rel="stylesheet">
    <link href="/Resources/Shared/stylesheets/shelBy/css/styles.css" rel="stylesheet">


    <link href="/Resources/Shared/stylesheets/shelBy/css/font-awesome.min.css" rel="stylesheet">

    <link id="vers" rel="stylesheet" type="text/css" href="/Resources/Shared/stylesheets/shelBy/css/light-version.css">
    <!-- Owlcoursel -->
    <link rel="stylesheet" type="text/css" href="/Resources/Shared/stylesheets/shelBy/css/owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="/Resources/Shared/stylesheets/shelBy/css/owl.theme.css">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>--%>
    <style type="text/css">



        .eds_userLogin {
        top:0px !important;
        }
        .eds_searchButton {
        top:0px !important;
        }
        .edsCopyrightBg {
        color:#FFF;
        background:#000;
        }
        
.product-item  .product-caption .product-name{
    font-size:15px;
    margin-top:10px;
    padding-bottom:10px;
    text-transform:none;
    font-weight:bold;
}
.product-price-group{
    padding-bottom:10px;
}
.product-item .product-caption .product-price{
    font-size:25px;
    font-weight:normal;
}
.product_detail > .product-name .product-price{
    font-size:inherit;
}
.product-img-lg{
    padding:5px 15px 10px 15px;
    text-align:center;
}
.product-img-lg a:hover{
    cursor:zoom-in;
}
.product-img-lg a img{
    width:100%;
}
.product-item .product-caption .product-price-old{
    font-size:18px; 
    margin-left:10px;
    text-decoration:line-through;
}
.product-item .product-caption .product-txt{
    margin-bottom:15px;
}
.product-item .product-caption .ht-btn{
    margin-top:5px;
}
.product-list .product-item{
    text-align:left;
    border:none;
}
.product-list .product-item .product-name{
    padding-top:7px;
    margin-top:0px;
    padding-bottom:13px;
    font-size:18px;
}
.product-list .absolute-caption li,.product-list .absolute-caption li i{
    padding:0px;
    margin:0px;
}
.product-grid-2 .product-item .product-caption .product-name{
    padding:15px 0px 2px 15px;
    background:rgba(15,15,15,0.9);
    color:#999;
    margin-top:0px;
    height:66px;
    width:100%;
    float:left;
}
.product-grid-2 .product-caption .product-name a{
    width:60%;
    text-align:left;
    display:block;
    float:left;
}
.product-grid-2 .product-caption .product-name a b{
    text-transform:uppercase;
}
.product-grid-2 .product-caption .product-name span{
    font-size:inherit;
    width:40%;
    display:block;
    padding:12px 15px;
    text-align:right;
    position:relative;
    float:right;
}
.product-grid-2 .product-caption .product-name span::after{
    position:absolute;
    top:0px;
    left:0px;
    content:'';
    border-width:18px;
    border-style:solid;
    border-top-color:rgba(0,0,0,0);
    border-left-color:#d11717;
    border-right-color:rgba(0,0,0,0);
    border-bottom-color:#d11717;
}

        .panel.with-nav-tabs .panel-heading {
            padding: 5px 5px 0 5px;
        }

        .panel.with-nav-tabs .nav-tabs {
            border-bottom: none;
        }

        .panel.with-nav-tabs .nav-justified {
            margin-bottom: -1px;
        }
        /********************************************************************/
        /*** PANEL DEFAULT ***/
        .with-nav-tabs.panel-default .nav-tabs > li > a,
        .with-nav-tabs.panel-default .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-default .nav-tabs > li > a:focus {
            color: #777;
        }

            .with-nav-tabs.panel-default .nav-tabs > .open > a,
            .with-nav-tabs.panel-default .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-default .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-default .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-default .nav-tabs > li > a:focus {
                color: #777;
                background-color: #ddd;
                border-color: transparent;
            }

        .with-nav-tabs.panel-default .nav-tabs > li.active > a,
        .with-nav-tabs.panel-default .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-default .nav-tabs > li.active > a:focus {
            color: #555;
            background-color: #fff;
            border-color: #ddd;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #f5f5f5;
            border-color: #ddd;
        }

            .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #777;
            }

                .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #ddd;
                }

            .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-default .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                color: #fff;
                background-color: #555;
            }
        /********************************************************************/
        /*** PANEL PRIMARY ***/
        .with-nav-tabs.panel-primary .nav-tabs > li > a,
        .with-nav-tabs.panel-primary .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-primary .nav-tabs > li > a:focus {
            color: #fff;
        }

            .with-nav-tabs.panel-primary .nav-tabs > .open > a,
            .with-nav-tabs.panel-primary .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-primary .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-primary .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-primary .nav-tabs > li > a:focus {
                color: #fff;
                background-color: #3071a9;
                border-color: transparent;
            }

        .with-nav-tabs.panel-primary .nav-tabs > li.active > a,
        .with-nav-tabs.panel-primary .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-primary .nav-tabs > li.active > a:focus {
            color: #428bca;
            background-color: #fff;
            border-color: #428bca;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #428bca;
            border-color: #3071a9;
        }

            .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #fff;
            }

                .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #3071a9;
                }

            .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-primary .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                background-color: #4a9fe9;
            }
        /********************************************************************/
        /*** PANEL SUCCESS ***/
        .with-nav-tabs.panel-success .nav-tabs > li > a,
        .with-nav-tabs.panel-success .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-success .nav-tabs > li > a:focus {
            color: #3c763d;
        }

            .with-nav-tabs.panel-success .nav-tabs > .open > a,
            .with-nav-tabs.panel-success .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-success .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-success .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-success .nav-tabs > li > a:focus {
                color: #3c763d;
                background-color: #d6e9c6;
                border-color: transparent;
            }

        .with-nav-tabs.panel-success .nav-tabs > li.active > a,
        .with-nav-tabs.panel-success .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-success .nav-tabs > li.active > a:focus {
            color: #3c763d;
            background-color: #fff;
            border-color: #d6e9c6;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #dff0d8;
            border-color: #d6e9c6;
        }

            .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #3c763d;
            }

                .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #d6e9c6;
                }

            .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-success .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                color: #fff;
                background-color: #3c763d;
            }
        /********************************************************************/
        /*** PANEL INFO ***/
        .with-nav-tabs.panel-info .nav-tabs > li > a,
        .with-nav-tabs.panel-info .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-info .nav-tabs > li > a:focus {
            color: #31708f;
        }

            .with-nav-tabs.panel-info .nav-tabs > .open > a,
            .with-nav-tabs.panel-info .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-info .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-info .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-info .nav-tabs > li > a:focus {
                color: #31708f;
                background-color: #bce8f1;
                border-color: transparent;
            }

        .with-nav-tabs.panel-info .nav-tabs > li.active > a,
        .with-nav-tabs.panel-info .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-info .nav-tabs > li.active > a:focus {
            color: #31708f;
            background-color: #fff;
            border-color: #bce8f1;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #d9edf7;
            border-color: #bce8f1;
        }

            .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #31708f;
            }

                .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #bce8f1;
                }

            .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-info .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                color: #fff;
                background-color: #31708f;
            }
        /********************************************************************/
        /*** PANEL WARNING ***/
        .with-nav-tabs.panel-warning .nav-tabs > li > a,
        .with-nav-tabs.panel-warning .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-warning .nav-tabs > li > a:focus {
            color: #8a6d3b;
        }

            .with-nav-tabs.panel-warning .nav-tabs > .open > a,
            .with-nav-tabs.panel-warning .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-warning .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-warning .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-warning .nav-tabs > li > a:focus {
                color: #8a6d3b;
                background-color: #faebcc;
                border-color: transparent;
            }

        .with-nav-tabs.panel-warning .nav-tabs > li.active > a,
        .with-nav-tabs.panel-warning .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-warning .nav-tabs > li.active > a:focus {
            color: #8a6d3b;
            background-color: #fff;
            border-color: #faebcc;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #fcf8e3;
            border-color: #faebcc;
        }

            .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #8a6d3b;
            }

                .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #faebcc;
                }

            .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-warning .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                color: #fff;
                background-color: #8a6d3b;
            }
        /********************************************************************/
        /*** PANEL DANGER ***/
        .with-nav-tabs.panel-danger .nav-tabs > li > a,
        .with-nav-tabs.panel-danger .nav-tabs > li > a:hover,
        .with-nav-tabs.panel-danger .nav-tabs > li > a:focus {
            color: #a94442;
        }

            .with-nav-tabs.panel-danger .nav-tabs > .open > a,
            .with-nav-tabs.panel-danger .nav-tabs > .open > a:hover,
            .with-nav-tabs.panel-danger .nav-tabs > .open > a:focus,
            .with-nav-tabs.panel-danger .nav-tabs > li > a:hover,
            .with-nav-tabs.panel-danger .nav-tabs > li > a:focus {
                color: #a94442;
                background-color: #ebccd1;
                border-color: transparent;
            }

        .with-nav-tabs.panel-danger .nav-tabs > li.active > a,
        .with-nav-tabs.panel-danger .nav-tabs > li.active > a:hover,
        .with-nav-tabs.panel-danger .nav-tabs > li.active > a:focus {
            color: #a94442;
            background-color: #fff;
            border-color: #ebccd1;
            border-bottom-color: transparent;
        }

        .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu {
            background-color: #f2dede; /* bg color */
            border-color: #ebccd1; /* border color */
        }

            .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > li > a {
                color: #a94442; /* normal text color */
            }

                .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > li > a:hover,
                .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > li > a:focus {
                    background-color: #ebccd1; /* hover bg color */
                }

            .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > .active > a,
            .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > .active > a:hover,
            .with-nav-tabs.panel-danger .nav-tabs > li.dropdown .dropdown-menu > .active > a:focus {
                color: #fff; /* active text color */
                background-color: #a94442; /* active bg color */
            }
            .accordion_container {
    width: 500px;
}
.accordion_head {
        width: 1362px;
    background-color:#636260;;
    color: white;
    cursor: pointer;
    font-family: arial;
    font-size: 14px;
    margin: 0 0 1px 0;
    padding: 7px 11px;
    font-weight: bold;
}
.accordion_body {
    width:1362px;
    background: #f3f3f3;
}
.accordion_body p {
    padding: 18px 5px;
    margin: 0px;
}
.plusminus {
    float:left;
    padding-right: 15px;
}


.more {
        FONT-SIZE: 13PX;
    font-weight: BOLD;
   width: 95PX;
   color:#FFF;
   PADDING-TOP: 12PX;
    height: 39px;
    background: red;
    position: relative;
    float: left;
    margin-left:0;
    text-align: center;
    padding-left: 40px;
}

.more:before {
        content: '';
    position: absolute;
    border-top: 25px solid #fff;
    border-right: 40px solid red;
    width: 0;
    right: 0;
    left: 0;
    top: 0;
    text-align: right;
}

    </style>
    <script type="text/javascript">

        $(document).ready(function () {
           $('.accordion_body').hide();
            //$(".up").css("display", "none");
            $('.recentCars').slideDown(300);
            $(".caroufredsel_wrapper").css("width", "100%");
            $(".caroufredsel_wrapper> div").css("left", "185px");
          
            
            //$(".accordion_body").slideUp(300);
          //  toggle the component with class accordion_body
            $(".accordion_head").click(function () {
                if ($('.accordion_body').is(':visible')) {
                    $(".accordion_body").slideUp(300);
                    $(".plusminus").text('+');
                    $(".up").css("display", "none");
                    $(".down").css("display", "inline");
                }

                if ($(this).next(".accordion_body").is(':visible')) {
                    $(this).next(".accordion_body").slideUp(300);
                    $(this).children(".plusminus").text('+');

                    $(this).children(".up").css("display", "none");
                    $(this).children(".down").css("display", "inline");
                } else {
                    $(".caroufredsel_wrapper").css("width", "100%");
                    $(".caroufredsel_wrapper> div").css("left", "185px");
                    $(".caroufredsel_wrapper> div").css("width", "100%");
                    $(this).next(".accordion_body").slideDown(300);
                    $(this).children(".plusminus").text('-');
                    $(this).children(".down").css("display", "none");
                    $(this).children(".up").css("display", "inline");
                    

                }

            });

            

        });
    </script>
</head>
<body>
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
					<span class="eds_searchButton" style="top:0px  !important;    margin-right: 85px;">Search</span>
					<div class="eds_userLogin pull-right" style="top:0px  !important">
						<dnn:USER ID="USER1" runat="server" LegacyMode="false" />
						<dnn:LOGIN ID="LOGIN1" runat="server" LegacyMode="false" />
					</div>
					<div class="eds_searchContainer">
						<span class="eds_searchClose">&times;</span>
						<dnn:SEARCH ID="dnnSearch" runat="server" ShowSite="false" ShowWeb="false" EnableTheming="true" Submit="Search" CssClass="SearchButton" />
					</div>
					<div class="responsAbilityMenu pull-left">
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
		
<!-- pageDetails_StyleWizardTemplateSectionEnd -->
		<div class="eds_headerContent" id="headerWide" runat="server"></div>
	</div>
	<div id="ContentPane" class="eds_container container-fluid" runat="server"></div>
	<div class="container-fluid">
		<div class="row">
			<div id="leftPane" class="col-sm-8 eds_container" runat="server"></div>
			<div id="sidebarPane" class="col-sm-4 eds_container" runat="server"></div>
		</div>
		<div class="row">
			<div id="sidebarLeftPane" class="col-sm-4 eds_container" runat="server"></div>
			<div id="rightPane" class="col-sm-8 eds_container" runat="server"></div>
		</div>
		<div class="row">
			<div id="contentLeftPane" class="col-sm-4 eds_container" runat="server"></div>
			<div id="contentMiddlePane" class="col-sm-4 eds_container" runat="server"></div>
			<div id="contentRightPane" class="col-sm-4 eds_container" runat="server"></div>
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
    <script src="/Resources/Shared/stylesheets/shelBy/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="/Resources/Shared/stylesheets/shelBy/js/jquery/jquery-ui.js"></script>

    <script src="/Resources/Shared/stylesheets/shelBy/js/bootstrap.min.js"></script>
    <!-- Owl-coursel -->
    <script src="/Resources/Shared/stylesheets/shelBy/js/owl.carousel.js"></script>




    <script>

</script>
</body>
</html>