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
<%--this js file for display timer--%>
<dnn:DnnJsInclude ID="DnnJsInclude1" runat="server" FilePath="common/js/timer.jquery.min.js" PathNameAlias="SkinPath" />

<StyleWizard:Skin runat="server" id="OzoneStyleWizard" templateGroup="home" />
<!DOCTYPE html>
<script runat="server">

    Protected Sub Page_Load(sender As Object, e As EventArgs)

    End Sub
</script>

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
<!-- loader_StyleWizardTemplateSection -->
<!-- header_StyleWizardTemplateSection -->

   
	<div id="ContentPane" class="eds_container container-fluid"></div>
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
            <li><a href="#">Login / Signup</a></li>
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
  
  <div class="hidden">
      <div class="container">
          <nav class="navbar navbar-inverse">
            <div class="navbar-header">
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".js-navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
		        <a class="navbar-brand" href="#">My Store</a>
	        </div>
	
	        <div class="collapse navbar-collapse js-navbar-collapse">
		        <ul class="nav navbar-nav">
                    <li class="dropdown mega-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Electronics<span class="caret"></span></a>
                        <ul class="dropdown-menu mega-dropdown-menu">
                             <li class="col-sm-2">
    					        <ul>
							        <li class="dropdown-header">Mobiles</li>
							        <li><a href="#">Samsung</a></li>
                                    <li><a href="#">Lenovo</a></li>
                                    <li><a href="#">Mi</a></li>
							        <li><a href="#">Motorola</a></li>
                                     <li><a href="#">OPPO</a></li>
							       <%-- <li class="divider"></li>
							        <li class="dropdown-header">Fonts</li>--%>
                                    <li><a href="#">Apple</a></li>
							        <li><a href="#">Vivo</a></li>
                                     <li><a href="#">Honor</a></li>
                                     <li><a href="#">Panasonic</a></li>
                                     <li><a href="#">FK Exclusive Mobiles</a></li>
                                     <li><a href="#">New and Popular Models</a></li>
                                     <li><a href="#">Moto x4 6GB</a></li>
                                     <li><a href="#">Redmi Note 5 series</a></li>
                                     <li><a href="#">Honor 9 Lite</a></li>
                                     <li><a href="#">Mobiles with extended warranty</a></li>
                                     <li><a href="#">Mobiles with Damage protection</a></li>
						        </ul>
					        </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Mobile Accessories</li>
                                    <li><a href="#">Mobile Cases</a></li>
                                    <li><a href="#">HeadPhones & HeadSets </a></li>
                                    <li><a href="#">Power Banks</a></li>
                                    <li><a href="#">Screenguards</a></li>
                                   <%-- <li class="divider"></li>
                                    <li class="dropdown-header">Fonts</li>--%>
                                    <li><a href="#">Memory Cards</a></li>
                                    <li><a href="#">Smart Headphones</a></li>
                                      <li><a href="#">Mobile Cables</a></li>
                                      <li><a href="#">Chargers</a></li>
                                      <li><a href="#">Selfie Sticks</a></li>
                                      <li><a href="#">Smart Wearable Tech</a></li>
                                      <li><a href="#">Smart Watches</a></li>
                                    <li><a href="#">Smart Glasses (VR)</a></li>
                                    <li><a href="#">Smart Bands</a></li>
                                    <li><a href="#">Health Care Appliances</a></li>
                                    <li><a href="#">Bp Monitors</a></li>
                                    <li><a href="#">Weighing Scale</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Laptops</li>
                                    <li><a href="#">Laptops with Extended Warranty</a></li>
                                    <li><a href="#">Desktop PCs</a></li>
                                    <li><a href="#">Gaming & Accessories</a></li>
                                    <li><a href="#">Computer Accessories</a></li>
                                     <li><a href="#">External Hard Disks</a></li>
                                     <li><a href="#">Pendrives</a></li>
                                     <li><a href="#">Laptop Skins & Decals Accessories</a></li>
                                     <li><a href="#">Laptop Bags</a></li>
                                     <li><a href="#">Mouse</a></li>
                                    <li><a href="#">Computer Peripherals</a></li>
                                    <li><a href="#">Printers & Ink Cartridges</a></li>
                                    <li><a href="#">Monitors</a></li>
                                    <li><a href="#">Tablets</a></li>
                                     <li><a href="#">Apple iPads</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Televisions</li>
                                    <li><a href="#">Home Entertainment</a></li>
                                    <li><a href="#">Home Audio Speakers</a></li>
                                    <li><a href="#">Home Theatres</a></li>
                                    <li><a href="#">Bluetooth Speakers</a></li>
                                    <li><a href="#">DTH Set Top Box</a></li>
                                    <li><a href="#">Smart Home Automation</a></li>
                                    <li><a href="#">Camera</a></li>
                                    <li><a href="#">DSLR</a></li>
                                    <li><a href="#">Compact & Bridge Cameras</a></li>
                                    <li><a href="#">Sports & Action</a></li>
                                    <li><a href="#">Camera Accessories</a></li>
                                    <li><a href="#">Lens</a></li>
                                    <li><a href="#">Tripods</a></li>
                                    <li><a href="#">Network Components</a></li>
                                    <li><a href="#">Routers</a></li>
                                </ul>
                            </li>
                             <li class="col-sm-3">
                                <ul>
                                    <li class="dropdown-header">Featured</li>
                                    <li><a href="#">Laptops on Buyback Guarantee</a></li>
                                    <li><a href="#">Flipkart SmartBuy</a></li>
                                    <li><a href="#">Li-Polymer Power Banks</a></li>
                                    <li><a href="#">Sony PS4 Pro & Slim</a></li>
                                    <li><a href="#">Apple Products/a></li>
                                    <li><a href="#">Microsoft Store</a></li>
                                    <li><a href="#">Lenovo Phab Series</a></li>
                                    <li><a href="#">JBL Speakers</a></li>
                                    <li><a href="#">Smartphones On Buyback Guarantee</a></li>
                                    <li><a href="#">Philips</a></li>
                                    <li><a href="#">Dr. Morepen</a></li>
                                    <li><a href="#">GoPro</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown mega-dropdown">
    			        <a href="#" class="dropdown-toggle" data-toggle="dropdown">TVs & Appliances <span class="caret"></span></a>				
				        <ul class="dropdown-menu mega-dropdown-menu">
					        <li class="col-sm-2">
    					        <ul>
							        <li class="dropdown-header">Televisions</li>
							        <li><a href="#">TVs by screen size</a></li>
                                    <li><a href="#">24 and below</a></li>
                                    <li><a href="#">32</a></li>
							        <li><a href="#">39-43</a></li>
							        <li><a href="#">48 & Above</a></li>
                                    <li><a href="#">Smart & Ultra HD</a></li>
							        <li><a href="#">TVs by Brand</a></li>
                                    <li><a href="#">VU</a></li>
                                    <li><a href="#">Mi LED Smart TVs</a></li>
                                    <li><a href="#">Samsung</a></li>
                                    <li><a href="#">LG</a></li>
                                    <li><a href="#">Sony</a></li>
                                    <li><a href="#">Panasonic</a></li>
                                    <li><a href="#">TVs & Appliances With Extended Warranty</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Air Conditioners</li>
							        <li><a href="#">Shop By Type</a></li>
							        <li><a href="#">Inverter AC</a></li>
							        <li><a href="#">Split ACs</a></li>                            
							        <li><a href="#">Shop By Brand</a></li>	
                                    <li><a href="#">Carrier</a></li>
                                    <li><a href="#">Samsung</a></li>
                                    <li><a href="#">Voltas</a></li>
                                    <li><a href="#">Refrigerators</a></li>
                                    <li><a href="#">Single Door</a></li>
                                    <li><a href="#">Double Door</a></li>
                                    <li><a href="#">Triple door</a></li>
                                    <li><a href="#">Side by Side</a></li>
                                    <li><a href="#">Washing Machine</a></li>
                                    <li><a href="#">Fully Automatic Front Load</a></li>
                                    <li><a href="#">Semi Automatic Top Load</a></li>
                                    <li><a href="#">Fully Automatic Top Load</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Kitchen Appliances</li>
                                    <li><a href="#">Microwave Ovens</a></li>
							        <li><a href="#">Oven Toaster Grills (OTG)</a></li>
							        <li><a href="#">Juicer/Mixer/Grinder</a></li>
							        <li><a href="#">Electric Kettle</a></li> 
                                    <li><a href="#">Induction Cooktops</a></li>    
                                    <li><a href="#">Hand Blenders</a></li>    
                                    <li><a href="#">Sandwich Makers</a></li>    
                                    <li><a href="#">Chimneys</a></li>    
                                   <li><a href="#">Electric Cookers</a></li>    
                                    <li><a href="#">Wet Grinders</a></li>  
                                    <li><a href="#">Food Processors</a></li>    
                                    <li><a href="#">Coffee Makers</a></li>    
                                    <li><a href="#">Dishwashers</a></li>    
						        </ul>
					        </li>
                             <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Small Home Appliances</li>
                                    <li><a href="#">Irons</a></li>
							        <li><a href="#">Fans</a></li>
							        <li><a href="#">Air Coolers</a></li>
							        <li><a href="#">Water Purifiers</a></li> 
                                    <li><a href="#">Voltage Stabalizers</a></li>    
                                    <li><a href="#">Inverters</a></li>    
                                    <li><a href="#">Sewing Machines</a></li>    
                                    <li><a href="#">Vacuum Cleaners</a></li>    
                                   <li><a href="#">Landline Phones</a></li>    
                                    <li><a href="#">Water Geysers</a></li>  
                                    <li><a href="#">Summer Special</a></li>    
                                    <li><a href="#">Trending</a></li>    
                                    <li><a href="#">Personal Air Coolers</a></li>
                                    <li><a href="#">Ceiling Fans</a></li>   
                                    <li><a href="#">Philips</a></li>   
                                    <li><a href="#">Symphony</a></li>   
                                    <li><a href="#">Usha</a></li>   
                                    <li><a href="#">Bajaj</a></li>   
						        </ul>
					        </li>
                             <li class="col-sm-3">
						        <ul>
							        <li><span>Buying Guides</span></li>
                                    <li><a href="#">Televisions</a></li>
							        <li><a href="#">Washing Machines</a></li>
							        <li><a href="#">Refrigerators</a></li>
							        <li><a href="#">Air Conditioners</a></li> 
                                    <li><a href="#">Water Purifiers</a></li>    
                                    <li><a href="#">Air Purifiers</a></li>    
                                    <li><a href="#">Chimneys</a></li>    
                                    <li><a href="#">Upcoming Flash Sales</a></li>    
                                   <li><a href="#">New Launches</a></li>    
                                    <li><a href="#">Thomson Smart LED TVs</a></li>  
                                    <li><a href="#">Midea Appliances</a></li>    
                                    <li><a href="#">Haier Refrigerators</a></li>    
						        </ul>
					        </li>
				        </ul>				
			        </li>
                     <li class="dropdown mega-dropdown">
    			        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Men<span class="caret"></span></a>				
				        <ul class="dropdown-menu mega-dropdown-menu">
					        <li class="col-sm-2">
    					        <ul>
							        <li class="dropdown-header">Footwear</li>
							        <li><a href="#">Sports Shoes</a></li>
                                    <li><a href="#">Casual Shoes</a></li>
                                    <li><a href="#">Formal Shoes</a></li>
							        <li><a href="#">Sandals & Floaters</a></li>
							        <li><a href="#">Flip- Flops</a></li>
                                    <li><a href="#">Loafers</a></li>
							        <li><a href="#">Boots</a></li>
                                    <li><a href="#">Running Shoes</a></li>
                                    <li><a href="#">Sneakers</a></li>
                                    <li><a href="#">Men's Grooming</a></li>
                                    <li><a href="#">Deodorants</a></li>
                                    <li><a href="#">Perfumes</a></li>
                                    <li><a href="#">Beard Care & Grooming</a></li>
                                    <li><a href="#">Shaving & Aftershave</a></li>
                                    <li><a href="#">Sexual Wellness</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Top wear</li>
							        <li><a href="#">T-Shirts</a></li>
							        <li><a href="#">Shirts</a></li>
							        <li><a href="#">Kurtas</a></li>                            
							        <li><a href="#">Suits & Blazers</a></li>	
                                    <li><a href="#">Jackets</a></li>
                                    <li><a href="#">Sweatshirts</a></li>
                                    <li><a href="#">Bottom wear</a></li>
                                    <li><a href="#">Jeans</a></li>
                                    <li><a href="#">Trousers</a></li>
                                    <li><a href="#">Shorts & 3/4ths</a></li>
                                    <li><a href="#">Cargos</a></li>
                                    <li><a href="#">Track pants</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Sports wear</li>
                                    <li><a href="#">Sports T-Shirts</a></li>
							        <li><a href="#">Track Pants</a></li>
							        <li><a href="#">Track Suits</a></li>
							        <li><a href="#">Shorts</a></li> 
                                    <li><a href="#">Innerwear & Sleepwear</a></li>    
                                    <li><a href="#">Briefs & Trunks</a></li>    
                                    <li><a href="#">Vests</a></li>    
                                    <li><a href="#">Boxers</a></li>    
                                   <li><a href="#">Thermals</a></li>    
                                    <li><a href="#">Ties, Socks, Caps & more</a></li>  
                                    <li><a href="#">Kurta, Pyjama & more</a></li>    
                                    <li><a href="#">Winter wear</a></li>    
                                    <li><a href="#">Fabrics</a></li>    
						        </ul>
					        </li>
                             <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Watches</li>
                                    <li><a href="#">Fastrack</a></li>
							        <li><a href="#">Casio</a></li>
							        <li><a href="#">Titan</a></li>
							        <li><a href="#">Fossil</a></li> 
                                    <li><a href="#">Sonata</a></li>    
                                    <li><a href="#">Accessories</a></li>    
                                    <li><a href="#">Backpacks</a></li>    
                                    <li><a href="#">Wallets</a></li>    
                                   <li><a href="#">Belts</a></li>    
                                    <li><a href="#">Sunglasses</a></li>  
                                    <li><a href="#">Luggage & Travel</a></li>    
                                    <li><a href="#">Frames</a></li>    
                                    <li><a href="#">Jewellery</a></li>
                                    <li><a href="#">Sports & Fitness Store</a></li>   
						        </ul>
					        </li>
                             <li class="col-sm-3">
						        <ul>
							        <li><span>Smart Watches</span></li>
                                    <li><a href="#">Smart Bands</a></li>
							        <li><a href="#">Personal Care Appliances</a></li>
							        <li><a href="#">Trimmers</a></li>
							        <li><a href="#">Shavers</a></li> 
                                    <li><a href="#">Grooming Kits</a></li>    
                                    <li><a href="#">Featured</a></li>    
                                    <li><a href="#">Watches Store</a></li>    
                                    <li><a href="#">Footwear Club</a></li>    
                                   <li><a href="#">Bags & Wallet</a></li>    
                                    <li><a href="#">T-Shirt Store</a></li>  
                                    <li><a href="#">Adidas</a></li>    
                                    <li><a href="#">Beardo</a></li> 
                                    <li><a href="#">Reebok</a></li> 
                                    <li><a href="#">Metronaut</a></li> 
                                    <li><a href="#">Nike</a></li> 
						        </ul>
					        </li>
				        </ul>				
			        </li>
                     <li class="dropdown mega-dropdown">
    			        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Women<span class="caret"></span></a>				
				        <ul class="dropdown-menu mega-dropdown-menu">
					        <li class="col-sm-2">
    					        <ul>
							        <li class="dropdown-header">Clothing</li>
							        <li><a href="#">Western Wear</a></li>
                                    <li><a href="#">Top, T-Shirts & Shirts</a></li>
                                    <li><a href="#">Dresses</a></li>
							        <li><a href="#">Jeans</a></li>
							        <li><a href="#">Leggings & Jeggings</a></li>
                                    <li><a href="#">Trousers & Capris</a></li>
							        <li><a href="#">Shorts</a></li>
                                    <li><a href="#">Skirts</a></li>
                                    <li><a href="#">Lingerie & Sleepwear</a></li>
                                    <li><a href="#">Bras</a></li>
                                    <li><a href="#">Panties</a></li>
                                    <li><a href="#">Nightsuits & Nightdresses</a></li>
                                    <li><a href="#">Shapewear</a></li>
                                    <li><a href="#">Camisoles & Slips</a></li>
                                    <li><a href="#">Sports Wear</a></li>
                                    <li><a href="#">Tights</a></li>
                                    <li><a href="#">Sports Bra</a></li>
                                    <li><a href="#">Track Pants</a></li>
                                    <li><a href="#">T-shirts</a></li>
                                    <li><a href="#">Swim & Beachwear</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Ethnic Wear</li>
							        <li><a href="#">Sarees</a></li>
							        <li><a href="#">Kurtas & Kurtis</a></li>
							        <li><a href="#">Dress Material</a></li>                            
							        <li><a href="#">Lehenga Choli</a></li>	
                                    <li><a href="#">Blouse</a></li>
                                    <li><a href="#">Leggings & Salwars</a></li>
                                    <li><a href="#">Anarkali Suits</a></li>
                                    <li><a href="#">Petticoats</a></li>
                                    <li><a href="#">Abhayas & Burqas</a></li>
                                    <li><a href="#">Dupattas</a></li>
                                    <li><a href="#">Winter & Seasonal Wear</a></li>
                                    <li><a href="#">International Brands</a></li>
                                     <li><a href="#">New arrivals !</a></li>
                                     <li><a href="#">Top Selling Styles</a></li>
                                     <li><a href="#">Exclusive Collection</a></li>
                                     <li><a href="#">Under 499</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Footwear</li>
                                    <li><a href="#">Sandals</a></li>
							        <li><a href="#">Flats</a></li>
							        <li><a href="#">Heels</a></li>
							        <li><a href="#">Wedges</a></li> 
                                    <li><a href="#">Shoes</a></li>    
                                    <li><a href="#">Sports Shoes</a></li>    
                                    <li><a href="#">Casual Shoes</a></li>    
                                    <li><a href="#">Boots</a></li>    
                                   <li><a href="#">Ballerinas</a></li>    
                                    <li><a href="#">Slippers & Flip- Flop's</a></li>  
                                    <li><a href="#">Watches</a></li>    
                                    <li><a href="#">Smart Watches</a></li>    
                                    <li><a href="#">Personal Care Appliances</a></li>  
                                    <li><a href="#">Hair Straightners</a></li>    
                                    <li><a href="#">Hair Dryers</a></li>    
                                    <li><a href="#">Epilators</a></li>    
						        </ul>
					        </li>
                             <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Beauty & Grooming</li>
                                    <li><a href="#">Make Up</a></li>
							        <li><a href="#">Skin Care</a></li>
							        <li><a href="#">Hair Care</a></li>
							        <li><a href="#">Bath & Spa</a></li> 
                                    <li><a href="#">Deodorants & Perfumes</a></li>    
                                    <li><a href="#">Jewellery</a></li>    
                                    <li><a href="#">Precious Jewellery</a></li>    
                                    <li><a href="#">Artificial Jewellery</a></li>    
                                   <li><a href="#">Silver Jewellery</a></li>    
                                    <li><a href="#">Accessories</a></li>  
                                    <li><a href="#">Smart Bands</a></li>    
                                    <li><a href="#">Handbags</a></li>    
                                    <li><a href="#">Shoulder Bags</a></li>
                                    <li><a href="#">Totes</a></li>   
                                    <li><a href="#">Sling bags</a></li>   
                                    <li><a href="#">Clutches</a></li>   
                                    <li><a href="#">Wallets & Belts</a></li>   
                                    <li><a href="#">Luggage & Travel</a></li>   
                                    <li><a href="#">Sunglasses</a></li>   
                                    <li><a href="#">Frames</a></li>  
						        </ul>
					        </li>
                             <li class="col-sm-3">
						        <ul>
							        <li class="dropdown-header"><span>Featured</span></li>
                                    <li><a href="#">Forever 21</a></li>
							        <li><a href="#">Accessorize</a></li>
							        <li><a href="#">W</a></li>
							        <li><a href="#">Pantaloons</a></li> 
                                    <li><a href="#">Chemistry</a></li>    
                                    <li><a href="#">Lakme</a></li>    
                                    <li><a href="#">Nivea</a></li>    
                                    <li><a href="#">Catwalk</a></li>    
                                   <li><a href="#">Titan-Raga</a></li>    
                                    <li><a href="#">Fastrack</a></li>  
                                    <li><a href="#">Divastri</a></li>    
                                    <li><a href="#">Rare Roots</a></li> 
                                    <li><a href="#">Anmi</a></li> 
                                    <li><a href="#">Coins & Bars</a></li> 
                                    <li><a href="#">Trending today!</a></li> 
                                     <li><a href="#">Ruffles & Frills</a></li> 
                                     <li><a href="#">Pastel Kurtas & Kurtis</a></li> 
                                     <li><a href="#">Designer Net Sarees</a></li> 
						        </ul>
					        </li>
				        </ul>				
			        </li>
                     <li class="dropdown mega-dropdown">
    			        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Baby & Kids<span class="caret"></span></a>				
				        <ul class="dropdown-menu mega-dropdown-menu">
					        <li class="col-sm-2">
    					        <ul>
							        <li class="dropdown-header">Kids Clothing</li>
							        <li><a href="#">Boys' Clothing</a></li>
                                    <li><a href="#">Polos & T-Shirts</a></li>
                                    <li><a href="#">Ethnic Wear</a></li>
							        <li><a href="#">Shorts & 3/4ths</a></li>
							        <li><a href="#">Girls' Clothing</a></li>
                                    <li><a href="#">Dresses & Skirts</a></li>
							        <li><a href="#">Ethnic Wear</a></li>
                                    <li><a href="#">T-shirts & Tops</a></li>
                                    <li><a href="#">Baby Boy Clothing</a></li>
                                    <li><a href="#">Body Suits</a></li>
                                    <li><a href="#">Polos & T-Shirts</a></li>
                                    <li><a href="#">Baby Girl Clothing</a></li>
                                    <li><a href="#">Body Suits</a></li>
                                    <li><a href="#">Dresses</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Kids Footwear</li>
							        <li><a href="#">Boys' Footwear</a></li>
							        <li><a href="#">Boys' Footwear</a></li>
							        <li><a href="#">Sport Shoes</a></li>                            
							        <li><a href="#">Girls' Footwear</a></li>	
                                    <li><a href="#">Flats & Bellies</a></li>
                                    <li><a href="#">Sport Shoes</a></li>
                                    <li><a href="#">Baby Footwear</a></li>
                                    <li><a href="#">Booties</a></li>
                                    <li><a href="#">Character Shoes</a></li>
                                    <li><a href="#">School Supplies</a></li>
                                    <li><a href="#">School Bags</a></li>
                                    <li><a href="#">School Combo Sets</a></li>
                                     <li><a href="#">Lunch Box</a></li>
                                     <li><a href="#">Kids' Watches</a></li>
						        </ul>
					        </li>
					        <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Toys</li>
                                    <li><a href="#">Remote Control Toys</a></li>
							        <li><a href="#">Educational Toys</a></li>
							        <li><a href="#">Soft Toys</a></li>
							        <li><a href="#">Cars & Die-cast Vehicles</a></li> 
                                    <li><a href="#">Outdoor Toys</a></li>    
                                    <li><a href="#">Action Figures</a></li>    
                                    <li><a href="#">Board Games</a></li>    
                                    <li><a href="#">Musical Toys</a></li>    
                                   <li><a href="#">Dolls & Doll Houses</a></li>    
                                    <li><a href="#">Puzzles</a></li>  
                                    <li><a href="#">S.T.E.M Toys</a></li>    
						        </ul>
					        </li>
                             <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header">Baby Care</li>
                                    <li><a href="#">Diapers</a></li>
							        <li><a href="#">Wipes</a></li>
							        <li><a href="#">Strollers & activity Gear</a></li>
							        <li><a href="#">Baby Bedding</a></li> 
                                    <li><a href="#">Feeding & Nursing</a></li>    
                                    <li><a href="#">Maternity Care</a></li>    
                                    <li><a href="#">Bath & Skin Care</a></li>    
                                    <li><a href="#">Baby Grooming</a></li>    
                                   <li><a href="#">Health & Safety</a></li>    
                                    <li><a href="#">Baby Gifting Sets</a></li>  
                                    <li><a href="#">Baby Toys</a></li>    
                                    <li><a href="#">Baby Smart Monitors</a></li>    
                                    <li><a href="#">Diapers & Potty Training</a></li>
                                    <li><a href="#">Furniture </a></li>   
						        </ul>
					        </li>
                             <li class="col-sm-2">
						        <ul>
							        <li class="dropdown-header"><span>Featured brands</span></li>
                                    <li><a href="#">Barbie 21</a></li>
							        <li><a href="#">Disney</a></li>
							        <li><a href="#">United Colors of Benetton</a></li>
							        <li><a href="#">The Children's Place</a></li> 
                                    <li><a href="#">US Polo</a></li>    
                                    <li><a href="#">Flying Machine</a></li>    
                                    <li><a href="#">Crocs</a></li>    
                                    <li><a href="#">Puma</a></li>    
                                   <li><a href="#">Funskool</a></li>    
                                    <li><a href="#">Lego</a></li>  
                                    <li><a href="#">Divastri</a></li>    
                                    <li><a href="#">Luvlap/a></li> 
                                    <li><a href="#">Mamy Poko</a></li> 
                                    <li><a href="#">Mee Mee</a></li> 
						        </ul>
					        </li>
				        </ul>				
			        </li>
                    <li class="dropdown mega-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Home & Furniture<span class="caret"></span></a>
                        <ul class="dropdown-menu mega-dropdown-menu">
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Kitchen & Dining</li>
                                    <li><a href="#">Pots & Pans</a></li>
                                    <li><a href="#">Pressure Cookers</a></li>
                                    <li><a href="#">Kitchen Tools</a></li>
                                    <li><a href="#">Gas Stoves</a></li>
                                    <li><a href="#">Dining & Serving</a></li>
                                    <li><a href="#">Coffee Mugs</a></li>
                                    <li><a href="#">Dinnerware & Crockery</a></li>
                                    <li><a href="#">Bar & Glassware</a></li>
                                    <li><a href="#">Kitchen Storage</a></li>
                                    <li><a href="#">Water Bottles</a></li>
                                    <li><a href="#">Lunch Boxes</a></li>
                                    <li><a href="#">Flasks & Casseroles</a></li>
                                    <li><a href="#">Kitchen Containers</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Furniture</li>
                                    <li><a href="#">Beds</a></li>
                                    <li><a href="#">Sofas</a></li>
                                    <li><a href="#">Dining tables & Sets</a></li>
                                    <li><a href="#">Mattresses</a></li>
                                    <li><a href="#">Tables</a></li>
                                    <li><a href="#">Office Chairs</a></li>
                                    <li><a href="#">Chairs</a></li>
                                    <li><a href="#">Bean Bags</a></li>
                                    <li><a href="#">Shoe Racks</a></li>
                                    <li><a href="#">TV Units & Cabinets</a></li>
                                    <li><a href="#">Wardrobes</a></li>
                                    <li><a href="#">Drawers</a></li>
                                    <li><a href="#">Sofa Beds</a></li>
                                    <li><a href="#">Offers on Furniture</a></li>
                                    <li><a href="#">House Keeping & Laundry</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Furnishing</li>
                                    <li><a href="#">Bedsheets</a></li>
                                    <li><a href="#">Curtains</a></li>
                                    <li><a href="#">Cushion & Pillow Covers</a></li>
                                    <li><a href="#">Blankets, Quilts & Dohars</a></li>
                                    <li><a href="#">Towels</a></li>
                                    <li><a href="#">Kitchen & Dining Linen</a></li>
                                    <li><a href="#">Mats & Carpets</a></li>
                                    <li><a href="#">Smart Home Automation</a></li>
                                    <li><a href="#">Smart Security System</a></li>
                                    <li><a href="#">Smart Door Locks</a></li>
                                    <li><a href="#">Tools & Hardware</a></li>
                                    <li><a href="#">Hand Tools</a></li>
                                    <li><a href="#">Power Tools</a></li>
                                    <li><a href="#">Gardening Essentials</a></li>
                                    <li><a href="#">Plant Seeds</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Home Decor</li>
                                    <li><a href="#">Paintings</a></li>
                                    <li><a href="#">Clocks</a></li>
                                    <li><a href="#">Wall Shelves</a></li>
                                    <li><a href="#">Wall Decals</a></li>
                                    <li><a href="#">Showpieces</a></li>
                                    <li><a href="#">Lighting</a></li>
                                    <li><a href="#">Smart Lighting</a></li>
                                    <li><a href="#">LED & CFL</a></li>
                                    <li><a href="#">Decorative Lighting & Lamps</a></li>
                                    <li><a href="#">Emergency Light</a></li>
                                    <li><a href="#">Pet Supplies</a></li>
                                    <li><a href="#">Pedigree</a></li>
                                    <li><a href="#">Whiskas</a></li>
                                    <li><a href="#">Royal Canin</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-3">
                                <ul>
                                    <li class="dropdown-header"><span>Featured</span></li>
                                    <li><a href="#">Gardening Store</a></li>
                                    <li><a href="#">Bakeware store</a></li>
                                    <li><a href="#">Stainless Steel Store</a></li>
                                    <li><a href="#">Home Styler Store</a></li>
                                    <li><a href="#">Milton</a></li>
                                    <li><a href="#">Bombay Dyeing</a></li>
                                    <li><a href="#">@home</a></li>
                                    <li><a href="#">Bosch</a></li>
                                    <li><a href="#">HomeTown</a></li>
                                    <li><a href="#">Ajanta</a></li>
                                    <li><a href="#">Spaces by Welspun</a></li>
                                    <li><a href="#">Prestige/a></li>
                                    <li><a href="#">Perfect Home Store</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown mega-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sports, Books & More<span class="caret"></span></a>
                        <ul class="dropdown-menu mega-dropdown-menu">
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Books</li>
                                    <li><a href="#">Entrance Exams</a></li>
                                    <li><a href="#">Academic</a></li>
                                    <li><a href="#">Literature & Fiction</a></li>
                                    <li><a href="#">Indian Writing</a></li>
                                    <li><a href="#">Biographies</a></li>
                                    <li><a href="#">Children</a></li>
                                    <li><a href="#">Business</a></li>
                                    <li><a href="#">Self Help</a></li>
                                    <li><a href="#">Comics</a></li>
                                    <li><a href="#">Stationery</a></li>
                                    <li><a href="#">Pens</a></li>
                                    <li><a href="#">Diaries</a></li>
                                    <li><a href="#">Key Chains</a></li>
                                    <li><a href="#">Desk Organisers</a></li>
                                    <li><a href="#">Calculators</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Gaming & Accessories</li>
                                    <li><a href="#">PS3</a></li>
                                    <li><a href="#">PS4</a></li>
                                    <li><a href="#">Xbox One</a></li>
                                    <li><a href="#">Xbox 360</a></li>
                                    <li><a href="#">Gaming Consoles</a></li>
                                    <li><a href="#">Smart Glasses(VR)</a></li>
                                    <li><a href="#">Music</a></li>
                                    <li><a href="#">International Music</a></li>
                                    <li><a href="#">Bollywood Music</a></li>
                                    <li><a href="#">Movies & TV Shows</a></li>
                                    <li><a href="#">Hollywood Movies</a></li>
                                    <li><a href="#">Bollywood Movies</a></li>
                                    <li><a href="#">Musical Instruments</a></li>
                                    <li><a href="#">The Hobby Store</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Sports</li>
                                    <li><a href="#">Cricket</a></li>
                                    <li><a href="#">Badminton</a></li>
                                    <li><a href="#">Cycling</a></li>
                                    <li><a href="#">Camping & Hiking</a></li>
                                    <li><a href="#">Football</a></li>
                                    <li><a href="#">Skating</a></li>
                                    <li><a href="#">Swimming</a></li>
                                    <li><a href="#">Exercise & Fitness</a></li>
                                    <li><a href="#">Yoga Mats</a></li>
                                    <li><a href="#">Gloves</a></li>
                                    <li><a href="#">Dumbells</a></li>
                                    <li><a href="#">Home Gyms</a></li>
                                    <li><a href="#">Cardio Equipment</a></li>
                                    <li><a href="#">Sippers & Shakers</a></li>
                                    <li><a href="#">Supports</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-2">
                                <ul>
                                    <li class="dropdown-header">Car & Bike Accessories</li>
                                    <li><a href="#">Car Body Cover</a></li>
                                    <li><a href="#">Bike Body Cover</a></li>
                                    <li><a href="#">Car Air Freshener</a></li>
                                    <li><a href="#">Car Electronics & Appliances </a></li>
                                    <li><a href="#">Car Media Player</a></li>
                                    <li><a href="#">Car Pressure Washer</a></li>
                                    <li><a href="#">Car Charger</a></li>
                                    <li><a href="#">Car Bluetooth Device</a></li>
                                    <li><a href="#">Helmets & Riding Gear</a></li>
                                    <li><a href="#">Health & Nutrition</a></li>
                                    <li><a href="#">Health & Energy Drinks</a></li>
                                    <li><a href="#">Protein Supplements</a></li>
                                    <li><a href="#">Health Food & Snacks</a></li>
                                    <li><a href="#">Vitamin Supplements</a></li>
                                </ul>
                            </li>
                            <li class="col-sm-3">
                                <ul>
                                    <li class="dropdown-header"><span>Featured</span></li>
                                    <li><a href="#">Books on Pre-Order</a></li>
                                    <li><a href="#">Author in Focus</a></li>
                                    <li><a href="#">New Releases in Books</a></li>
                                    <li><a href="#">Bestsellers in Books</a></li>
                                    <li><a href="#">Royal Enfield Accessories</a></li>
                                    <li><a href="#">Games on Pre-order</a></li>
                                    <li><a href="#">Bosch Pressure Washers</a></li>
                                    <li><a href="#">Vega Helmets</a></li>
                                    <li><a href="#">Godrej Car Perfumes</a></li>
                                    <li><a href="#">Gourmet & Specialty Foods</a></li>
                                    <li><a href="#">Tea, Coffee & Beverages</a></li>
                                    <li><a href="#">Nuts, Dry Fruits & Combos</a></li>
                                    <li><a href="#">Chocolates</a></li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown mega-dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Offer Zone</a>
                    </li>
		        </ul>
	        </div><!-- /.nav-collapse -->
          </nav>
        </div>
  </div>

    <div class="col-sm-12 eds_container" id="sliderPane" runat="server"></div>

    <div class="col-sm-12 eds_container hidden" id="sliderProducts">
            <img class="slides" src="<%=SkinPath%>/sliderImages/slider1.jpg" />
            <img class="slides" src="<%=SkinPath%>/sliderImages/slider2.jpg" />
            <img class="slides" src="<%=SkinPath%>/sliderImages/slider3.jpg" />
            <img class="slides" src="<%=SkinPath%>/sliderImages/slider4.jpg" />
        <button class="btn" id="btn1" onclick="plusIndex(-1)">&#10094;</button>
        <button class="btn" id="btn2" onclick="plusIndex(1)">&#10095;</button>
    </div>

    <div class="row">
        <div class="catlog_section">
            <div id="txtDealOfTheDay" class="col-sm-2 eds_container">
                <h1>Deals of the Day</h1>
                <br />
                <h3>
                    <p id="dealsTimer"></p>
                </h3>
                <h4><a href="#" target="_self" style="color: blueviolet; font: italic">View All</a></h4>

            </div>
          <div class="col-sm-8 eds_container" id="dealsOfTheDayPane" runat="server"></div>
             <div id="offerPane" class="col-sm-2 eds_container img-responsive" runat="server">
                 <%--<a target="_blank" href="#" runat="server">
                        <img src="<%=SkinPath%>discounts.jpg" /></a>--%>
             </div>
        </div>
    </div>

	<div class="container-fluid">
		<div class="row">
			<div id="contentLeftPane" class="col-sm-12 eds_container" runat="server"></div>
			
		</div>
	</div>
    <div>
        <div class="col-sm-4 eds_container" id="placeholdersPane1" runat="server"></div> <div class="col-sm-4 eds_container" id="placeholdersPane2" runat="server"></div><div class="col-sm-4 eds_container" id="placeholdersPane3" runat="server"></div>
    </div>
    <div class="row hidden">
        <div class="catlog_section">
           
                <div id="placeLeftPane" class="col-sm-4 eds_container" runat="server">
                    <a target="_blank" href="#" runat="server">
                        <img src="<%=SkinPath%>offers.jpg" /></a>

                </div>
                <div id="placeMiddlePane" class="col-sm-4 eds_container" runat="server">
                    <a target="_blank" href="#" runat="server">
                        <img src="<%=SkinPath%>offers3.jpg" /></a>
                </div>
                <div id="placeRighttPane" class="col-sm-4 eds_container" runat="server">
                    <a target="_blank" href="#" runat="server">
                        <img src="<%=SkinPath%>books.jpg" /></a>
                </div>
            </div>
        
    </div>
    <div class="row">
          <div><h3 style="color:black" class=".col-sm-2.eds_container"> Featured Brands</h3>  </div>
       <div id="featuredProductsPane" class="col-sm-12 eds_container" runat="server"></div>
       
    </div>

    <div class="row">
        <div class="catlog_section">
            <div class="col-sm-2 eds_container">
                <h2>Best Of Branded Shirts</h2>
                <br />
                <h4><a href="#" target="_self" style="color: blueviolet; font: italic">View All</a></h4>
            </div>
            <div class="col-sm-10 eds_container" id="productsShirtsPane" runat="server"></div>
        </div>
    </div>
     <div class="row">
         <div class="catlog_section">
             <div class="col-sm-2 eds_container">
                 <h2>Best Of Mobile Phones</h2>
                 <br />
                 <h4><a href="#" target="_self" style="color: blueviolet; font: italic">View All</a></h4>
             </div>
             <div class="col-sm-10 eds_container" id="productsMobilesPane" runat="server"></div>
         </div>
    </div>
    
     <div class="row">
         <div class="catlog_section">
             <div class="col-sm-2 eds_container">
                 <h2>Lap Tops For You</h2>
                 <br />
                 <h4><a href="#" target="_self" style="color: blueviolet; font: italic">View All</a></h4>
             </div>
             <div class="col-sm-10 eds_container" id="productsLaptopsPane" runat="server"></div>
         </div>
    </div>
   
     <div class="row">
         <div class="catlog_section">
             <div class="col-sm-2 eds_container">
                 <h2>Branded Jeans</h2>
                 <br />
                 <h4><a href="#" target="_self" style="color: blueviolet; font: italic">View All</a></h4>
             </div>
             <div class="col-sm-10 eds_container" id="productsJeansPane" runat="server"></div>
         </div>
    </div>

       <div class="row">
         <div class="catlog_section">
             <div class="col-sm-2 eds_container">
                 <h2>Recently
                     
                     Viewed</h2>
             </div>
             <div class="col-sm-10 eds_container" id="recentProductsPane" runat="server"></div>
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
			<div id="leftPane8" class="col-sm-8 eds_container" runat="server"></div>
			<div id="sidebarPane8" class="col-sm-4 eds_container" runat="server"></div>
		</div>
	</div>
	<div id="contentPane8" class="container-fluid" runat="server"></div>
	<div class="container-fluid">
		<div class="row">
			<div id="rightPane8" class="col-sm-12 eds_container" runat="server"></div>
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
        <div class="container-fluid">
            <div class="row">
                <div id="Div3" class="col-sm-12 footerBoxContainer2" runat="server"></div>

            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div id="Div4" class="col-sm-12 footerBoxContainer2" runat="server"></div>

            </div>
        </div>
    </div>
   
<a data-options='{ "speed": 700,"easing": "easeOutQuint","updateURL": false }' href="#" class="eds_scrollTo eds_backToTop"><span><%= Localization.GetString("BackToTop.Text", skinpath + "App_LocalResources/localization.ascx.resx") %></span></a>


    <script src="/Resources/Shared/stylesheets/TeamShelby/js/bootstrap.min.js"></script>
   
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
            
        });
    </script>
   
</body>
    
</html>