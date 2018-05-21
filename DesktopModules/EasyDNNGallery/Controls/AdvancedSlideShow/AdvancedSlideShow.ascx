<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.DesktopModules_EasyDNNGallery_Controls_AdvancedSlideShow, App_Web_advancedslideshow.ascx.fd2419f4" debug="True" %>

<asp:Literal ID="ltGalleryInit" runat="server" EnableViewState="False"></asp:Literal>
<asp:Literal ID="ltOpenImage" runat="server" EnableViewState="False"></asp:Literal>
<div id="AdvancedSlideShow" runat="server">
	<div id="EDSGASS" class="EDSGASS">
		<div class='<%="M" + ModuleId.ToString()%>container'>
			<div class="ASSgallery">
				<div class="screen">
					<noscript>
						Turn on JavaScript</noscript>
				</div>
				<div class="items">
					<asp:repeater id="repGalleries" runat="server" onitemdatabound="repGalleries_ItemDataBound">
						<itemtemplate> 
						<ul title="<%#Eval("GalleryName")%>">
							<asp:Repeater ID="repGalleryImages" runat="server">
								<ItemTemplate>
									<li >
									<a href='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ShortEmbedUrl")) %>' >
									 <img src='<%#GetThumbPath(DataBinder.Eval(Container.DataItem, "ViewerThumb"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' alt='<%#Eval("Title")%>' /></a>
										<a href='<%#Eval("ImageUrl")%>' runat="server" target='<%#advancedSlideShowSettings.NewWindow%>' Visible='<%#Convert.ToBoolean(advancedSlideShowSettings.OpenMediaUrl)%>' id="ImageUrl"></a>
										<div id="DescDIV" style='<%#ViewState["TTTop"]%>' runat="server" Visible='<%#Convert.ToBoolean(ViewState["ShowMediInfo"])%>'>
											<asp:Label ID="lblTitle" runat="server" Text='<%#ShowTitle(DataBinder.Eval(Container.DataItem, "Title"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#Convert.ToBoolean(ViewState["ShowMediaTitle"])%>'></asp:Label>  
											<asp:Label ID="lblDescription" runat="server" Text='<%# ShowDescription(DataBinder.Eval(Container.DataItem, "Description"),DataBinder.Eval(Container.DataItem, "PictureID"))%>' Visible='<%#Convert.ToBoolean(ViewState["ShowMediaDescription"])%>'></asp:Label>
										</div>
									</li>  
								</ItemTemplate>
							</asp:Repeater> 
						</ul>
						</itemtemplate>
					</asp:repeater>
				</div>
			</div>
		</div>
	</div>
</div>
<asp:objectdatasource id="odsIntegrate" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" selectmethod="GetIntegration">
	<selectparameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
	</selectparameters>
</asp:objectdatasource>
