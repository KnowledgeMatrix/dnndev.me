<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_PortfolioControl, App_Web_lightboxportfolio.ascx.b5be42b4" %>
<style type="text/css">
	.eds_edn_qtip2_style {
		-moz-border-radius: <%=myappSettings.TooltipRadius%>px;
		-webkit-border-radius: <%=myappSettings.TooltipRadius%>px;
		border-radius: <%=myappSettings.TooltipRadius%>px;
		border-width: <%=myappSettings.TooltipBorder%>px;
	}
</style>
<script type="text/javascript">
  <%=jQuery%>(document).ready(function($) {
  	$('#<%=ModulNr%>portfolio').portfolioSetter({
  		ppgroup:'<%=ModulNr%>',
  		pptheme:'<%=myappSettings.LightboxType %>',
  		ppanimationSpeed: '<%=myappSettings.LightboxAnimationSpeed%>',
  		ppoverlay_gallery: <%=myappSettings.OverlayGallery%>,
  		ppslideshow: <%=LightBoxSlideShow2%>,
  		ppautoplay_slideshow: <%=myappSettings.LightBoxSSAP%>,
  		showCategories: <%=myappSettings.DisplayNestedGalleries.ToLower()%>,
  		ppLightboxTitle:'<%=myappSettings.LightboxTitle.ToLower()%>',
  		ppLightboxDescription:'<%=myappSettings.LightboxDescription.ToLower()%>',
  		ppMediaTitle:'<%=myappSettings.ShowMediaTitle.ToLower()%>',
  		ppMediaDescription:'<%=myappSettings.ShowMediaDescription.ToLower()%>',
  		pfqtip:'<%=myappSettings.LightboxDescription.ToLower()%>',
  		pfShowQtip:'<%=myappSettings.ShowToolTips.ToLower()%>',
  		pfdiv:'<%=ModulNr%>EasyDNNGallery',
  		pfShowEffect:'<%=myappSettings.ShowEffect%>',
  		pfHideEffect:'<%=myappSettings.HideEffect%>',
  		pfShowDuration: '<%=myappSettings.ShowEffectDuration%>',
  		pfHideDuration: '<%=myappSettings.HideEffectDuration%>',
  		pfTargetPos: '<%=myappSettings.TargetPosition%>',
  		pfTooltipPos:'<%=myappSettings.TooltipPosition%>',
  		pfTheme:'<%=myappSettings.TooltipTheme%>',
  		pfcorner: <%=myappSettings.TooltipBorder%>,
  		pfradius: <%=myappSettings.TooltipRadius%>,
  		pfOpenMediaUrl :'<%=myappSettings.OpenMediaUrl%>',
  		pfOpenMediaTarget : '<%=NewWindow%>',
  		itemMargin: 11,
  		allText: '<%=strAll%>',
  		easing: '<%=myappSettings.NGGalResizeProportionally%>',
  		animationSpeed: <%=myappSettings.NGCategoryItems%>,
  		itemsPerPage: <%=SesItemsPerPage%>,
  		wavyAnimation: false, 
  		myshowCategories:<%=myappSettings.DisplayControl%>,
  		navButtonWidth:21, 
  		categorySelector: '<%=myappSettings.PortfolioMenuType%>',
	  	showNavigationArrows : <%=myappSettings.PortfolioShowArrows%>,
  		hidableNavigationArrows: <%=myappSettings.PortfolioAutoHideArrows%>,
  		customTitle: '<%=myappSettings.PortfolioDisplayTitle%>',
  		navigationId: 'EDG_portfolio_pagination<%=ModulNr%>',
  		categoriesId: 'EDG_portfolio_categories<%=ModulNr%>',
  		navArrowsFile: '<%=PortfolioArrowFile%>',
  		navDDMFile:'<%=ProtfolioDDMFile%>',
  		ppprint_image_text: '<%=PrintImageText%>',
  		ppitem_emailing_text: '<%=EmailText%>',
  		ppitem_emailing_subject: '<%=EmailTextSubject%>',
  		ppallow_image_printing:<%=myappSettings.LightboxShowPrint%>,
  		ppenable_item_emailing:<%=myappSettings.LightboxShowEmail%>,
  		ppshow_social_sharing:<%=myappSettings.LightboxSocialSharing%>,
  		ppdownload_handler_url:'<%=ShowDownloadLinkLightbox%>',
  		downloadItemText:'<%=strDownloadImage%>',
  		showAllBtn:<%=myappSettings.PortfolioShowAllButton%>,
  		categorySelectorSlideable:<%=myappSettings.SliderTransition%>,
  		sidewayCatsWidth:<%=myappSettings.PortfolioMenuWidth%>,
  		// XML request parameters
  		xmlRequestParams: {
  			GalleryType: 'portfolio',
  			ModuleID: '<%=ModuleId%>',
  			ModulePath:'<%=ModulePath.Replace("Controls/Portfolio/", "")%>',
  			PortalHome: '<%=PortalSettings.HomeDirectory%>',
  			PortalID: '<%=PortalId%>',
  			LocaleCode: '<%=localecode %>',
  			ShowDownloadLink: '<%=ShowDownloadLink%>',
  			UseViewAsDownload: '<%=myappSettings.UseViewAsDownload%>',
  			DownHandlerURL : '<%=DownHandlerURL%>',
  			SettingCheck: '<%=myappSettings.PortfolioRandomNumber%>'
  		},
  		showSharingButtons: {
  			facebook: <%=myappSettings.ShowFacebook%>,
  			twitter: <%=myappSettings.ShowTwitter%>,
  			gplus: <%=myappSettings.ShowGooglePlus%>
  			},
  		itemToOpen : <%=itemToOpen %>,
  		maxImgWidth: <%=myappSettings.TGImageWidth%>,
  		maxImgHeight: <%=myappSettings.TGImageHeight%>,
  		containerWidth: <%=myappSettings.NGThumbWidth%>,
  		containerHeight: <%=myappSettings.NGThumbHeight%>,
  		smartResize: <%=myappSettings.TGSmartResize%>,
  		moduleCssId: '<%=CssClass%>',
  		fullscreenable: <%=myappSettings.PortfolioShowFullscreen%>,
  		fullscreenButtonText: '<%=ShowFullscreen%>',
  		fullscreenCssId: '<%=FullscreenTheme%>',
  		containerWidthIsRatio: <%=containerWidthIsRatio%>,
  		xmlSource: '<%=ModulePath.Replace("Controls/Portfolio/","")%>PortfolioHandler.ashx?tabid=<%=TabId%>'
  	});
  });
</script>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>

<div class="portfolioDimensionsContainer">
	<table cellpadding="0" cellspacing="0" border="0" align="center" style="<%=responsiveStyle%>">
		<tr>
			<td>
				<div id="PortfolioGallery">
					<div id="<%=CssClass%>">
						<div class="EDGbackground">
							<div class="EDGcontentbgrd">
								<div class="EDGcornerbotleft">
									<div class="EDGcornerbotright">
										<div class="EDGcornertopleft">
											<div class="EDGcornertopright">
												<div class="EDGcontent">
													<div id="<%=ModulNr%>portfolio" style="position: relative;">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</div>
