<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.ViewEasyDNNGallery, App_Web_vieweasydnngallery.ascx.af09375b" autoeventwireup="true" %>
<script type="text/javascript">
	if (typeof <%=jQuery%> != 'undefined') {
		if ('<%=jQuery%>'=='jQuery')
			jQuery.noConflict();
		if('<%=loadScripts%>' == "True")
		{
			<%=jQuery%>(document).ready(function ($) {
			var showtips = '<%=ShowToolTips.ToString().ToLower()%>';
				$('#<%=strMduleID%>EasyDNNGallery a[rel^="prettyPhoto"], #<%=strMduleID%>EasyDNNGallery a[rel^="slP"]').each(function () {
					if ($(this).attr("title")) {
						if ($(this).attr("title").length > 0) {
							$(this).attr("pptitle", $(this).attr("title"));
							if (showtips == 'false') {
								if ($(this).attr("title").length > 0) {
									$(this).attr("title", "");
								}
							}
						}
					}
				});
				if ("<%=LightboxSelection%>" == "prettyphoto") {
					$('#<%=strMduleID%>EasyDNNGallery a[rel^="prettyPhoto"], a[rel^="slP"]').prettyPhoto({
							animationSpeed: '<%=AnimSpeed%>',
							slideshow: <%=LightBoxSlideShow%>,
							autoplay_slideshow: <%=LightBoxSlideShowAP.ToString().ToLower()%>,
							padding: 40,
							opacity: 0.8,
							showTitle: true,
							allowresize: true,
							hideflash: true,
							downloadText:'<%=strDownloadText%>',
							wmode: 'opaque',
							autoplay: <%=PlayOnLoadLB.ToString().ToLower()%>,
							modal: false,
							overlay_gallery: <%=OverlayGallery.ToString().ToLower()%>,
							counter_separator_label: '/',
							print_image_text: '<%=strPrintImageText%>',
							item_emailing_text: '<%=strEmailText%>',
							item_emailing_subject: '<%=strEmailTextSubject%>',
							allow_image_printing:<%=ShowPrintButton.ToString().ToLower()%>,
							enable_item_emailing:<%=ShowEmailButton.ToString().ToLower()%>,
							show_social_sharing:<%=ShowSocial.ToString().ToLower()%>,
							download_handler_url:'<%=ShowDownloadLinkLightbox%>',
							theme: '<%=LightboxType %>',
							callback: function() { }
						});
				}
			});
		}

		<%=jQuery%>(function ($) {
			$("#<%=strMduleID%>EasyDNNGallery .eds_galleryManageMenuTrigger").click(function(){
				$("#<%=strMduleID%>EasyDNNGallery.eds_galleryWrapper").toggleClass("eds_galleryManageMenuVisible");
				});
		});
	}
</script>
<asp:Image itemprop="image" ID="imgItepProp" runat="server" Style="display: none;" Visible="False" />
<div id="<%=strMduleID%>EasyDNNGallery" class="eds_galleryWrapper<%=initialState%>">
	<asp:Label ID="lblMainMessage" runat="server" Text="Click on Manage Content for adding and managing content.<br />Click on Gallery Settings and choose what and how it will be displayed." Visible="False" resourcekey="lblMainMessageResource1"></asp:Label>
	<asp:PlaceHolder ID="plhContent" runat="server"></asp:PlaceHolder>
	<asp:PlaceHolder ID="plhAdminMenu" runat="server"></asp:PlaceHolder>
</div>
<div>
	<a id="hlUploadQuerstr" runat="server" visible="false">
		<asp:Image ID="Image1" runat="server" ImageUrl="~/DesktopModules/EasyDNNgallery/images/image_add.png" />
		<%=strUserUpload%>
	</a>
	<a id="hlApproveMedia" runat="server" visible="false">
		<asp:Image ID="Image2" runat="server" ImageUrl="~/DesktopModules/EasyDNNgallery/images/note_accept.png" />
		<%=strApprove%>
	</a>
</div>
<%--<br />
<asp:Label ID="lblDemoTrial" runat="server" Text="This is 15 day trial version."></asp:Label>--%>
