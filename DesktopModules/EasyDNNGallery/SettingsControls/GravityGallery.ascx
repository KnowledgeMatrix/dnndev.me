<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.SettingsCotrols_GravityGallery, App_Web_gravitygallery.ascx.d6cf3db9" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
	function ValidateCheckBoxList(sender, args) {
		args.IsValid = false;
		eds1_10("#<%=cblMediaSelect.ClientID%>").find(":checkbox").each(function () {
			if (eds1_10(this).prop("checked")) {
				args.IsValid = true;
				return;
			}
		});
	}
	function validateSettings() {
		if(!Page_ClientValidate("vgGravitySaveSettings"))
		{
			return false;
		}
		if(<%=isNewsInstalled.ToString().ToLower()%> == true)
		{
			document.getElementById('<%=lblNewsModuleValidateEror.ClientID%>').style.display = 'none';
			var chkStatus1 = document.getElementById('<%=cbGalleryDisplayNewsLink.ClientID %>');
			var chkStatus2 = document.getElementById('<%=cbItemsListDisplayNewsLink.ClientID %>');
			var chkStatus3 = document.getElementById('<%=cbDetailsDisplayNewsLink.ClientID %>');
			if ((chkStatus1 !=null && chkStatus1.checked) ||(chkStatus2 !=null &&  chkStatus2.checked) || (chkStatus3 !=null && chkStatus3.checked)) {
				var chkStatusddl = document.getElementById('<%=ddlNewsOpenDetails.ClientID %>');
				var selDDLValue = chkStatusddl.options[chkStatusddl.selectedIndex].value;
				if (selDDLValue != "0") {
					return true;
				}
				else {
					document.getElementById('<%=lblNewsModuleValidateEror.ClientID%>').style.display = 'block';
					eds1_10('#<%=ddlNewsOpenDetails.ClientID%>').focus();
					return false;
				}
			}
			else {
				return true;
			}
		}
		else{
			return true;
		}
	}

	eds1_10().ready(function ($) {

		$('#<%=rblLigtBoxSelection.ClientID %> input[type="radio"]').change(function () {
			$smbSettings = $('#<%=pnlSMBOptions.ClientID %>');
			$smbLiteSettings = $('#<%=pnlSMBLiteOptions.ClientID %>');
			var selectedvalue = $("#<%=rblLigtBoxSelection.ClientID %> input:radio:checked").val();
			if (selectedvalue == 2) {
				$smbSettings.css('display', 'none');
				$smbLiteSettings.css('display', 'block');
				$('#imgSmbOptionsImage').attr("src",'<%=ControlPath.Replace("/SettingsControls", "") %>images/icons/smblight.png');
			}
			if (selectedvalue == 3) {
				$smbSettings.css('display', 'none');
				$smbLiteSettings.css('display', 'block');
				$('#imgSmbOptionsImage').attr("src",'<%=ControlPath.Replace("/SettingsControls", "") %>images/icons/smbplus.png');
			}
			else if (selectedvalue == 1) {
				$smbSettings.css('display', 'block');
				$smbLiteSettings.css('display', 'none');
			} else if (selectedvalue == 0) {
				$smbSettings.css('display', 'none');
				$smbLiteSettings.css('display', 'none');
			}
		});
		$('#<%=cbEnableUpload.ClientID %>').change(function () {
			if ($('#<%= cbEnableUpload.ClientID %>').is(':checked')) {
				$('#<%=tblUploadSettings.ClientID%>').show();
			}else
				$('#<%=tblUploadSettings.ClientID%>').hide();
		});
		$('#<%=rblLigtBoxSelection.ClientID %> input[type="radio"]').change();
		$('#<%=cbEnableUpload.ClientID %>').change();
	});
</script>
<asp:HiddenField ID="hfLoad" runat="server" Value="0" />
<div id="edgAdminSettingsWrapper" runat="server">
	<div id="edgAdminSettings" class="gravityGallerySettings">
		<div class="settingsList negativeMargins40">
			<h3>
				<asp:Label ID="lblGravityGallerySettings" runat="server" Text="Gravity gallery settings" />
			</h3>
		</div>
		<div id="pnlPresets" runat="server" class="settingsGroup sectionBox" visible="False">
			<div class="sectionBoxHeader color2">
				<h4>
					<span class="fa fa-photo"></span>
					<asp:Label ID="lblPresetsTitle" resourcekey="lblPresetsTitle.Text" runat="server" Text="Presets" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table>
						<tbody>
							<tr>
								<td>
									<asp:DataList ID="dlGravityPresets" runat="server" RepeatColumns="4" RepeatDirection="Horizontal" CssClass="datalist_table" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Top" OnItemCommand="dlGravityPresets_ItemCommand">
										<ItemTemplate>
											<div>
												<h2>
													<asp:HiddenField ID="hfPresetFileName" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "PresetFileName")%>' />
													<asp:Label ID="lblPresetName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Name") %>'></asp:Label></h2>
												<asp:Image ID="imgThumbPreSet" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "Thumbnail") %>' CssClass="presetimage" />
												<asp:LinkButton ID="lbLoadXmlPreSet" runat="server" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "PresetFileName") %>' CommandName="Load" CssClass="EDR_admin_button"><span>Load</span>
												</asp:LinkButton>
											</div>
										</ItemTemplate>
									</asp:DataList>
								</td>
								<td></td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblUserCreatedPresets" runat="server" Text="Select user created preset:" HelpText="Select user created preset." Visible="True" />
									<asp:DropDownList ID="ddlUserCreatedPresets" runat="server" Visible="True" AutoPostBack="True" DataTextField="Name" DataValueField="PresetFileName" OnSelectedIndexChanged="ddlUserCreatedPresets_SelectedIndexChanged">
										<asp:ListItem Value="-1">Select preset</asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>
									<dnn:Label ID="lblSettingsFromOtherModulesOnThePortal" runat="server" Text="Select settings from other modules:" HelpText="Select settings from other modules." Visible="True" />
									<asp:DropDownList ID="ddlSettingsFromOtherModulesOnThePortal" runat="server" Visible="True" AutoPostBack="True" OnSelectedIndexChanged="ddlSettingsFromOtherModulesOnThePortal_SelectedIndexChanged">
										<asp:ListItem Value="-1">Select module</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="sectionBox">
			<div class="sectionBoxHeader color1">
				<h4>
					<span class="fa fa-desktop"></span>
					<asp:Label ID="lblCustomizeDisplayTitle" resourcekey="lblCustomizeDisplayTitle.Text" runat="server" Text="Customize display" />
				</h4>
			</div>
			<div class="displayContent paddingTopBottom">
				<div class="displayContentTable paddingBottom">
					<table class="noTdBorders">
						<tbody>
							<tr>
								<td>
									<div class="paddingBottom">
										<dnn:Label ID="lblSelecttheme" ResourceKey="lblSelecttheme" runat="server" Text="Select theme:" HelpText="Select theme." />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-desktop"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlThemeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlThemeSelect_SelectedIndexChanged" />
										</div>
									</div>
								</td>
								<td>
									<div runat="server" id="divStyleSelect">
										<div class="paddingBottom">
											<dnn:Label ID="lblSelectCSSFile" runat="server" ResourceKey="lblSelectCSSFile" Text="Select style:" HelpText="Select style." />
										</div>
										<div class="inputWithIcon">
											<i class="fa fa-pencil-square"></i>
											<div class="styledSelect fullWidth higher">
												<asp:DropDownList ID="ddlStyleSelect" runat="server" AppendDataBoundItems="True" />
											</div>
										</div>
									</div>
								</td>
							</tr>
							<tr id="trCategoryGalleryTemplateSelect" runat="server">
								<td>
									<div class="paddingBottom">
										<dnn:Label ID="lblCategoryTemplateSelect" runat="server" ResourceKey="lblCategoryTemplateSelect" Text="Select category template:" HelpText="Select category template." />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-folder"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlCategoryTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategoryTemplateSelect_SelectedIndexChanged" />
										</div>
									</div>
								</td>
								<td>
									<div class="paddingBottom">
										<dnn:Label ID="lblGalleryTemplateSelect" runat="server" ResourceKey="lblGalleryTemplateSelect" Text="Select gallery template:" HelpText="Select gallery template." />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-clone"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlGalleryTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGalleryTemplateSelect_SelectedIndexChanged" />
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="paddingBottom">
										<dnn:Label ID="lblItemsTemaplteSelect" runat="server" ResourceKey="lblItemsTemaplteSelect" Text="Select items template:" HelpText="Select items template:" />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-tag"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlItemsTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlItemsTemplateSelect_SelectedIndexChanged" />
										</div>
									</div>
								</td>
								<td id="tdDetailsTemplateSelect" runat="server">
									<div class="paddingBottom">
										<dnn:Label ID="lblDetailsTemplateSelect" runat="server" ResourceKey="lblDetailsTemplateSelect" Text="Select details template:" HelpText="Select details template." />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-search"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlDetailsTemplateSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDetailsTemplateSelect_SelectedIndexChanged" />
										</div>
									</div>
								</td>
							</tr>
							<tr id="trPortfolioOverlaySelect" runat="server" visible="false">
								<td>
									<div class="paddingBottom">
										<dnn:Label ID="lbltrPortfolioOverlaySelect" runat="server" Text="Select overly:" HelpText="Select overlay." />
									</div>
									<div class="inputWithIcon">
										<i class="fa fa-tag"></i>
										<div class="styledSelect fullWidth higher">
											<asp:DropDownList ID="ddlPortfolioOverlaySelect" runat="server" />
										</div>
									</div>
								</td>
								<td></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="sectionBox">
			<div class="sectionBoxHeader color1">
				<h4>
					<span class="fa fa-desktop"></span>
					<asp:Label ID="lblSelectCategoriesAndGalleriesToDisplay" resourcekey="lblSelectCategoriesAndGalleriesToDisplay.Text" runat="server" Text="Select categories and galleries to display" />
				</h4>
			</div>
			<asp:Panel ID="pnlPortalSharing" runat="server">
				<div class="paddingTop" style="margin-left: 40px">
					<asp:Label ID="lblPortalSharing" runat="server" resourcekey="lblPortalSharing" Text="Select portal:" />
					<div class="styledSelect">
						<asp:DropDownList ID="ddlPortalSharing" runat="server" AppendDataBoundItems="True" DataTextField="PortalName" DataValueField="PortalIDFrom" Style="margin-right: 15px;" OnSelectedIndexChanged="ddlPortalSharing_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem resourcekey="liCurrentPortal" Value="-1">Current portal</asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</asp:Panel>
			<div class="sectionBox insideSectionBox">
				<div class="sectionBoxHeader small color1">
					<h4>
						<span class="fa fa-folder"></span>
						<asp:Label ID="lblSelectCategoriesToDisplay" resourcekey="lblSelectCategoriesToDisplay.Text" runat="server" Text="Choose Categories to display" />
					</h4>
				</div>
				<div class="displayContent">
					<div class="itemSelectionContainer">
						<asp:UpdatePanel ID="upCategorySelection" runat="server" UpdateMode="Conditional">
							<ContentTemplate>
								<asp:DataList ID="dlListOfCategories" runat="server" CssClass="itemSelection_itemList" DataKeyField="CategoryID" RepeatLayout="Flow" RepeatDirection="Horizontal">
									<ItemTemplate>
										<span class="itemSelection_item" data-item-id='<%#Eval("CategoryID")%>'>
											<span class="image">
												<img src='<%#DataBinder.Eval(Container.DataItem, "CatetoryImage.ThumbUrl")%>'></span>
											<span class="name"><%#Eval("Title")%></span>
										</span>
									</ItemTemplate>
								</asp:DataList>
								<asp:Panel ID="pnlSelectCategoriesPager" runat="server" CssClass="itemSelection_itemPagination">
									<asp:Repeater ID="repPaggeingcategorieselection" runat="server" OnItemCommand="repPaggeingcategorieselection_ItemCommand">
										<ItemTemplate>
											<asp:LinkButton ID="lbCategoriesPagerPage" runat="server" CssClass='<%# Eval("class") %>' Text='<%#Eval("page") %>' CommandArgument='<%#Eval("page") %>' />
										</ItemTemplate>
									</asp:Repeater>
								</asp:Panel>
								<asp:Panel ID="pnlSelectedCategoriesHtmlContainer" runat="server" CssClass="itemSelection_selectedItemsContainer">
									<p class="itemSelection_selectedItemsTitle">
										<i class="fa fa-check-circle"></i>
										<asp:Label ID="lblSelectedCategoriesTitle" resourcekey="lblSelectedCategoriesTitle.Text" runat="server" Text="Selected categories:" />
									</p>
									<p class="itemSelection_noItemsSelectedMsg">
										<asp:Label ID="lblNoCategoriesSelectedMsg" runat="server" resourcekey="lblNoCategoriesSelectedMsg.Text" Text="Select categories from which you want to display galleries." CssClass="infoMessages error static" />
									</p>
									<asp:Literal ID="ListOfselectedcategories" runat="server" Text="" />
								</asp:Panel>
								<asp:UpdateProgress ID="upCategorySelectionProgress" runat="server" AssociatedUpdatePanelID="upCategorySelection" DisplayAfter="0" DynamicLayout="true">
									<ProgressTemplate>
										<div class="itemSelection_processingOverlay">
										</div>
									</ProgressTemplate>
								</asp:UpdateProgress>
							</ContentTemplate>
						</asp:UpdatePanel>
						<asp:TextBox ID="tbSelectedCategories" runat="server" EnableViewState="true" Style="display: none" Text="" TextMode="SingleLine" CssClass="itemSelection_selectedIds" />
					</div>
				</div>
			</div>
			<asp:Panel ID="pnlGallerySelectionWrapper" runat="server" CssClass="settingsGroup sectionBox galleries insideSectionBox">
				<div class="sectionBoxHeader small color2">
					<h4>
						<span class="fa fa-clone"></span>
						<asp:Label ID="lblSelectGalleriesToDisplay" runat="server" resourcekey="lblSelectGalleriesToDisplay.Text" Text="Choose Galleries to display" />
					</h4>
					<div class="styledCheckbox big">
						<asp:CheckBox ID="cbCategoryDisplayAllGalleries" runat="server" resourcekey="cbCategoryDisplayAllGalleries.Text" AutoPostBack="True" OnCheckedChanged="cbCategoryDisplayAllGalleries_CheckedChanged" Text="Display all galleries from each selected category" />
					</div>
				</div>
				<div class="displayContent">
					<div class="itemSelectionContainer">
						<asp:Panel ID="gallerySelectionContainer" runat="server" CssClass="itemSelectionContainer">
							<asp:UpdatePanel ID="upGallerySelection" runat="server" UpdateMode="Conditional">
								<ContentTemplate>
									<asp:Button ID="btnSelectGaleriesFromCategories" runat="server" OnClick="btnSelectGaleriesFromCategories_Click" CssClass="refreshGalleryItemsTrigger" Text="Load gallery items" Style="display: none;" />
									<asp:DataList ID="dlListOfGalleries" runat="server" CssClass="itemSelection_itemList" DataKeyField="GalleryID" RepeatLayout="Flow" RepeatDirection="Horizontal">
										<ItemTemplate>
											<span class="itemSelection_item" data-item-id='<%#Eval("GalleryID")%>'>
												<span class="image">
													<img src='<%#Eval("GalleryImage.ThumbUrl")%>'></span>
												<span class="name"><%#Eval("Title")%> (<%#Eval("ParentCategory.Title")%>)</span>
											</span>
										</ItemTemplate>
									</asp:DataList>
									<asp:Panel ID="pnlSelectGalleriessPager" runat="server" CssClass="contentPagination">
										<asp:Repeater ID="repPaggeingGalleryselection" runat="server" OnItemCommand="repPaggeingGalleryselection_ItemCommand">
											<ItemTemplate>
												<asp:LinkButton ID="lbGalleriesPagerPage" runat="server" CssClass='<%# Eval("class") %>' Text='<%#Eval("page") %>' CommandArgument='<%#Eval("page") %>' />
											</ItemTemplate>
										</asp:Repeater>
									</asp:Panel>
									<asp:Panel ID="pnlSelectedGalleriesHtmlContainer" runat="server" CssClass="itemSelection_selectedItemsContainer">
										<p class="itemSelection_selectedItemsTitle">
											<i class="fa fa-check-circle"></i>
											<asp:Label ID="lblSelectedGalleriesTitle" runat="server" resourcekey="lblSelectedGalleriesTitle.Text" Text="Selected galleries:" />
										</p>
										<p class="itemSelection_noItemsSelectedMsg">
											<asp:Label ID="lblNoGalleriesSelectedMsg" runat="server" resourcekey="lblNoGalleriesSelectedMsg.Text" Text="Select galleries that you want to display." CssClass="infoMessages error static" />
										</p>
										<asp:Literal ID="ListOfselectedGallery" runat="server" Text="" />
									</asp:Panel>
									<asp:UpdateProgress ID="upGallerySelectionProgress" runat="server" AssociatedUpdatePanelID="upGallerySelection" DisplayAfter="0" DynamicLayout="true">
										<ProgressTemplate>
											<div class="itemSelection_processingOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
								</ContentTemplate>
							</asp:UpdatePanel>
							<asp:TextBox ID="tbSelectedGalleries" runat="server" EnableViewState="true" Style="display: none" Text="" TextMode="SingleLine" CssClass="itemSelection_selectedIds" />
						</asp:Panel>
					</div>
				</div>
			</asp:Panel>
		</div>
		<div runat="server" id="divDieplayLevelSelection" class="edsgg_admin_sectionTogglesWrapper sectionBox">
			<div class="sectionBoxHeader">
				<h4><span class="fa fa-bars"></span>
					<asp:Label ID="lblDisplayLevels" runat="server" resourcekey="lblDisplayLevels" Text="Display levels" /></h4>
			</div>
			<div runat="server" id="sectionCategories" class="section categories">
				<h3><%=Categories%></h3>
				<div>
					<asp:Label ID="lblExternalCategoriesSectionToggle" runat="server" CssClass="onOffToggle color1">
						<span class="onText"><%=Yes%></span>
						<span class="offText"><%=No%></span>
						<span class="slider"></span>
					</asp:Label>
				</div>
			</div>
			<div class="section galleries">
				<h3><%=Galleries %></h3>
				<div>
					<asp:Label ID="lblExternalGalleriesSectionToggle" runat="server" CssClass="onOffToggle color7">
						<span class="onText"><%=Yes%></span>
						<span class="offText"><%=No%></span>
						<span class="slider"></span>
					</asp:Label>
				</div>
			</div>
			<div class="section items">
				<h3><%=Items%></h3>
				<div>
					<asp:Label ID="lblExternalItemsSectionToggle" runat="server" CssClass="onOffToggle color2">
						<span class="onText"><%=Yes%></span>
						<span class="offText"><%=No%></span>
						<span class="slider"></span>
					</asp:Label>
				</div>
			</div>
			<div class="section details">
				<h3><%=Details%></h3>
				<div>
					<asp:Label ID="lblExternalDetailsSectionToggle" runat="server" CssClass="onOffToggle color4">
						<span class="onText"><%=Yes%></span>
						<span class="offText"><%=No%></span>
						<span class="slider"></span>
					</asp:Label>
				</div>
			</div>
		</div>
		<div runat="server" id="divSettingsGroupCategories" class="settingsGroup edgDisplaySettings edgCategories sectionBox">
			<div class="sectionBoxHeader">
				<h4>
					<span class="fa fa-folder"></span>
					<asp:Label ID="lblCategoryDisplayOptions" runat="server" resourcekey="lblCategoryDisplayOptions.Text" Text="Category display level" />
				</h4>
				<asp:Label ID="lblCategoriesSectionToggle" runat="server" CssClass="onOffToggle color1">
					<asp:CheckBox ID="cbDisplayCategoriesPage" runat="server" CssClass="normalCheckBox" Checked="True" />
					<span class="offText"><%=No%></span>
					<span class="onText"><%=Yes%></span>
					<span class="slider"></span>
				</asp:Label>
			</div>
			<asp:Panel ID="pnlCategoryDisplayOptions" runat="server" CssClass="displayContent color1">
				<div>
					<div class="displayLevel category">
						<p>1</p>
					</div>
					<div>
						<div class="displayContentTable clearfix inputGroupWidth50">
							<div class="edGG_inputgroup" runat="server" id="divCategoryThumbnailWidth" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-h"></i>
									<dnn:Label ID="lblCategoryThumbnailWidth" ResourceKey="lblCategoryThumbnailWidth" runat="server" Text="Thumbnail width:" HelpText="Category thumbnail width." />
								</div>
								<asp:TextBox ID="tbCategoryThumbnailWidth" runat="server" CssClass="small textCenter higher">220</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbCategoryThumbnailWidth" runat="server" ControlToValidate="tbCategoryThumbnailWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbCategoryThumbnailWidth" runat="server" ControlToValidate="tbCategoryThumbnailWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryThumbnailHeight" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-v"></i>
									<dnn:Label ID="lblCategoryThumbnailHeight" ResourceKey="lblCategoryThumbnailHeight" runat="server" Text="Thumbnail height:" HelpText="Category thumbnail height." />
								</div>
								<asp:TextBox ID="tbCategoryThumbnailHeight" runat="server" CssClass="small textCenter higher">180</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbCategoryThumbnailHeight" runat="server" ControlToValidate="tbCategoryThumbnailHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbCategoryThumbnailHeight" runat="server" ControlToValidate="tbCategoryThumbnailHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryShowTitle" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-book"></i>
									<dnn:Label ID="lblCategoryShowTitle" ResourceKey="lblCategoryShowTitle" runat="server" Text="Show title:" HelpText="Show category title."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbCategoryShowTitle" runat="server" Checked="True" Text="Show title" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryTitleLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-text-width"></i>
									<dnn:Label ID="lblCategoryTitleLimit" ResourceKey="lblCategoryTitleLimit" runat="server" Text="Title character limit:" HelpText="Category title limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbCategoryTitleLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbCategoryTitleLimit" runat="server" ControlToValidate="tbCategoryTitleLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbCategoryTitleLimit" runat="server" ControlToValidate="tbCategoryTitleLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryShowDescription" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-font"></i>
									<dnn:Label ID="lblCategoryShowDescription" runat="server" ResourceKey="lblCategoryShowDescription" Text="Show description:" HelpText="Show category description."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbCategoryShowDescription" runat="server" Checked="True" Text="Show description" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryDescriptionLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-exchange"></i>
									<dnn:Label ID="lblCategoryDescriptionLimit" runat="server" ResourceKey="lblCategoryDescriptionLimit" Text="Description character limit:" HelpText="Category description limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbCategoryDescriptionLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbCategoryDescriptionLimit" runat="server" ControlToValidate="tbCategoryDescriptionLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbCategoryDescriptionLimit" runat="server" ControlToValidate="tbCategoryDescriptionLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberofcategoryitemsperpage" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-clone"></i>
									<dnn:Label ID="lblNumberofcategoryitemsperpage" runat="server" ResourceKey="lblNumberofcategoryitemsperpage" Text="Number of category items per page:" HelpText="Number of category items per page."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberofcategoryitemsperpage" runat="server" CssClass="small textCenter higher">20</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberofcategoryitemsperpage" runat="server" ControlToValidate="tbNumberofcategoryitemsperpage" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberofcategoryitemsperpage" runat="server" ControlToValidate="tbNumberofcategoryitemsperpage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberOfCategoryPagingLinks" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-ellipsis-h"></i>
									<dnn:Label ID="lblNumberOfCategoryPagingLinks" runat="server" ResourceKey="lblNumberOfCategoryPagingLinks" Text="Number of category paging links:" HelpText="Number of category paging links."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberOfCategoryPagingLinks" runat="server" CssClass="small textCenter higher">10</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberOfCategoryPagingLinks" runat="server" ControlToValidate="tbNumberOfCategoryPagingLinks" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberOfCategoryPagingLinks" runat="server" ControlToValidate="tbNumberOfCategoryPagingLinks" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryDisplayNumberOfGalleries" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-list-ol"></i>
									<dnn:Label ID="lblCategoryDisplayNumberOfGalleries" runat="server" ResourceKey="lblCategoryDisplayNumberOfGalleries" Text="Display the number of galleries:" HelpText="Display the number of galleries for each category."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbCategoryDisplayNumberOfGalleries" runat="server" Checked="True" Text="Display the number of galleries" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryDisplaySharingButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblCategoryDisplaySharingButtons" runat="server" ResourceKey="lblCategoryDisplaySharingButtons" Text="Sharing buttons:" HelpText="Display sharing buttons."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbCategoryDisplaySharingButtons" runat="server" Checked="True" Text="Sharing buttons" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divCategoryDisplayShowRSS" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-rss"></i>
									<dnn:Label ID="lblCategoryDisplayShowRSS" runat="server" ResourceKey="lblCategoryDisplayShowRSS" Text="RSS links:" HelpText="Show RSS links to individual categories and a link to the RSS for the list of categories."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbCategoryDisplayShowRSS" runat="server" Checked="True" Text="RSS links" />
								</div>
							</div>
						</div>
						<div class="displayContentTable">
							<div class="edGG_inputgroup">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-sort-amount-asc"></i>
									<dnn:Label ID="lblCategoryDisplaySortingOptions" runat="server" ResourceKey="lblCategoryDisplaySortingOptions" Text="Sorting option:" HelpText="Sorting option."></dnn:Label>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlCategoryItemsSorting" runat="server">
										<asp:ListItem Value="0" ResourceKey="liPosition">Position</asp:ListItem>
										<asp:ListItem Value="1" ResourceKey="liTitle">Title</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlCategoryItemsSortingDirection" runat="server">
										<asp:ListItem Value="0" ResourceKey="liAscending">Ascending</asp:ListItem>
										<asp:ListItem Value="1" ResourceKey="liDescending">Descending</asp:ListItem>
									</asp:DropDownList>
								</div>
							</div>
						</div>
					</div>
				</div>
			</asp:Panel>
		</div>
		<div runat="server" id="divSettingsGroupGalleries" class="settingsGroup edgDisplaySettings edgGalleries sectionBox">
			<div class="sectionBoxHeader color2">
				<h4>
					<span class="fa fa-clone"></span>
					<asp:Label ID="lblDisplayGalleriesPage" resourcekey="lblDisplayGalleriesPage" runat="server" Text="Gallery display level" />
				</h4>
				<asp:Label ID="lblGalleriesSectionToggle" runat="server" CssClass="onOffToggle color2">
					<asp:CheckBox ID="cbDisplayGalleriesPage" runat="server" CssClass="normalCheckBox" Checked="True" />
					<span class="offText"><%=No%></span>
					<span class="onText"><%=Yes%></span>
					<span class="slider"></span>
				</asp:Label>
			</div>
			<asp:Panel ID="pnlGalleryOptions" runat="server" CssClass="displayContent color2">
				<div>
					<div class="displayLevel gallery">
						<p>2</p>
					</div>
					<div>
						<div class="displayContentTable inputGroupWidth50 clearfix">
							<div class="edGG_inputgroup" runat="server" id="divGalleryThumbnailwidth" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-h"></i>
									<dnn:Label ID="lblGalleryThumbnailwidth" ResourceKey="lblGalleryThumbnailwidth" runat="server" Text="Thumbnail width:" HelpText="Gallery thumbnail width"></dnn:Label>
								</div>
								<asp:TextBox ID="tbGalleryThumbnailwidth" runat="server" CssClass="small textCenter higher">220</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbGalleryThumbnailwidth" runat="server" ControlToValidate="tbGalleryThumbnailwidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbGalleryThumbnailwidth" runat="server" ControlToValidate="tbGalleryThumbnailwidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryThumbnailheight" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-v"></i>
									<dnn:Label ID="lblGalleryThumbnailheight" ResourceKey="lblGalleryThumbnailheight" runat="server" Text="Thumbnail height:" HelpText="Gallery thumbnail height."></dnn:Label>
								</div>
								<asp:TextBox ID="tbGalleryThumbnailheight" runat="server" CssClass="small textCenter higher">180</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbGalleryThumbnailheight" runat="server" ControlToValidate="tbGalleryThumbnailheight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbGalleryThumbnailheight" runat="server" ControlToValidate="tbGalleryThumbnailheight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayTitle" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-book"></i>
									<dnn:Label ID="lblGalleryDisplayTitle" ResourceKey="lblGalleryDisplayTitle" runat="server" Text="Show title:" HelpText="Show gallery title."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayTitle" runat="server" Checked="True" Text="Show title" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryTitleLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-text-width"></i>
									<dnn:Label ID="lblGalleryTitleLimit" ResourceKey="lblGalleryTitleLimit" runat="server" Text="Title character limit:" HelpText="Gallery title limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbGalleryTitleLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbGalleryTitleLimit" runat="server" ControlToValidate="tbGalleryTitleLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbGalleryTitleLimit" runat="server" ControlToValidate="tbGalleryTitleLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayDescription" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-font"></i>
									<dnn:Label ID="lblGalleryDisplayDescription" ResourceKey="lblGalleryDisplayDescription" runat="server" Text="Show description:" HelpText="Show gallery description."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayDescription" runat="server" Checked="True" Text="Show description" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDescriptionLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-exchange"></i>
									<dnn:Label ID="lblGalleryDescriptionLimit" ResourceKey="lblGalleryDescriptionLimit" runat="server" Text="Description character limit:" HelpText="Gallery description limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbGalleryDescriptionLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbGalleryDescriptionLimit" runat="server" ControlToValidate="tbGalleryDescriptionLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbGalleryDescriptionLimit" runat="server" ControlToValidate="tbGalleryDescriptionLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberofgalleryitemsperpage" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-clone"></i>
									<dnn:Label ID="lblNumberofgalleryitemsperpage" ResourceKey="lblNumberofgalleryitemsperpage" runat="server" Text="Number of gallery items per page:" HelpText="Number of gallery items per page."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberofgalleryitemsperpage" runat="server" CssClass="small textCenter higher">20</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberofgalleryitemsperpage" runat="server" ControlToValidate="tbNumberofgalleryitemsperpage" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberofgalleryitemsperpage" runat="server" ControlToValidate="tbNumberofgalleryitemsperpage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberofgallerypaginglinks" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-ellipsis-h"></i>
									<dnn:Label ID="lblNumberofgallerypaginglinks" ResourceKey="lblNumberofgallerypaginglinks" runat="server" Text="Number of gallery paging links:" HelpText="Number of gallery paging links."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberofgallerypaginglinks" runat="server" CssClass="small textCenter higher">5</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberofgallerypaginglinks" runat="server" ControlToValidate="tbNumberofgallerypaginglinks" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberofgallerypaginglinks" runat="server" ControlToValidate="tbNumberofgallerypaginglinks" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayOwnerInfo" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-user"></i>
									<dnn:Label ID="lblGalleryDisplayOwnerInfo" ResourceKey="lblGalleryDisplayOwnerInfo" runat="server" Text="Owner info:" HelpText="Show the owner info for each gallery."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayOwnerInfo" runat="server" Checked="True" Text="Owner info" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplaySharingButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblGalleryDisplaySharingButtons" ResourceKey="lblGalleryDisplaySharingButtons" runat="server" Text="Sharing buttons:" HelpText="Show sharing buttons"></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplaySharingButtons" runat="server" Checked="True" Text="Sharing buttons" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayNumberOfGalleryViews" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-eye"></i>
									<dnn:Label ID="lblGalleryDisplayNumberOfGalleryViews" ResourceKey="lblGalleryDisplayNumberOfGalleryViews" runat="server" Text="Number of gallery views:" HelpText="Show the number of views the gallery got."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNumberOfGalleryViews" runat="server" Checked="True" Text="Number of gallery views" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayNumberOfGalleryItems" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-list-ol"></i>
									<dnn:Label ID="lblGalleryDisplayNumberOfGalleryItems" ResourceKey="lblGalleryDisplayNumberOfGalleryItems" runat="server" Text="Number of gallery items:" HelpText="Show the number of items in each gallery."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNumberOfGalleryItems" runat="server" Checked="True" Text="Number of gallery items" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayNumberOfGalleryImages" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-file-image-o"></i>
									<dnn:Label ID="lblGalleryDisplayNumberOfGalleryImages" ResourceKey="lblGalleryDisplayNumberOfGalleryImages" runat="server" Text="Number of gallery images:" HelpText="Show the number of images in each gallery."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNumberOfGalleryImages" runat="server" Checked="True" Text="Number of gallery images" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayNumnberOfGalleryVideos" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-file-video-o"></i>
									<dnn:Label ID="lblGalleryDisplayNumnberOfGalleryVideos" ResourceKey="lblGalleryDisplayNumnberOfGalleryVideos" runat="server" Text="Number of gallery videos:" HelpText="Show the number of videos in each gallery."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNumnberOfGalleryVideos" runat="server" Checked="True" Text="Number of gallery videos" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayNumnberOfGalleryAudios" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-file-sound-o"></i>
									<dnn:Label ID="lblGalleryDisplayNumnberOfGalleryAudios" ResourceKey="lblGalleryDisplayNumnberOfGalleryAudios" runat="server" Text="Number of gallery audio files:" HelpText="Show the number number of audio files in each gallery."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNumnberOfGalleryAudios" runat="server" Checked="True" Text="Number of gallery audio files" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayShowRss" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-rss"></i>
									<dnn:Label ID="lblGalleryDisplayShowRss" ResourceKey="lblGalleryDisplayShowRss" runat="server" Text="RSS links:" HelpText="Show RSS links to individual galleries and a link to the RSS for the list of galleries."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayShowRss" runat="server" Checked="True" Text="RSS links" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divGalleryDisplayBreadCrumbs" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-terminal"></i>
									<dnn:Label ID="lblGalleryDisplayBreadCrumbs" ResourceKey="lblGalleryDisplayBreadCrumbs" runat="server" Text="Bread crumbs:" HelpText="Show bread crumbs."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayBreadCrumbs" runat="server" Checked="True" Text="Bread crumbs" />
								</div>
							</div>
						</div>
						<div class="displayContentTable">
							<div class="edGG_inputgroup">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-sort-amount-asc"></i>
									<dnn:Label ID="lblGalleryDisplaySortiongOptions" ResourceKey="lblGalleryDisplaySortiongOptions" runat="server" Text="Sorting option:" HelpText="Sorting option."></dnn:Label>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlGalleryItemsSorting" runat="server">
										<asp:ListItem ResourceKey="liPosition" Value="0">Position</asp:ListItem>
										<asp:ListItem ResourceKey="liTitle" Value="1">Title</asp:ListItem>
										<asp:ListItem ResourceKey="liDateCreated" Value="2">Date created</asp:ListItem>
										<asp:ListItem ResourceKey="liDateLastModified" Value="3">Date last modified</asp:ListItem>
										<asp:ListItem ResourceKey="liPublishDate" Value="4">Publish date</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlGalleryItemsDirection" runat="server">
										<asp:ListItem ResourceKey="liAscending" Value="0">Ascending</asp:ListItem>
										<asp:ListItem ResourceKey="liDescending" Value="1">Descending</asp:ListItem>
									</asp:DropDownList>
								</div>
							</div>
						</div>
						<div class="displayContentTable" runat="server" id="trGalleryDisplayNewsLink">
							<div class="edGG_inputgroup">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblGalleryDisplayNewsLink" ResourceKey="lblGalleryDisplayNewsLink" runat="server" Text="Show link to news article:" HelpText="Display link to news article."></dnn:Label>
								</div>
								<div class="styledCheckbox big noLabel">
									<asp:CheckBox ID="cbGalleryDisplayNewsLink" runat="server" Text="Show link to news article" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</asp:Panel>
		</div>
		<div class="settingsGroup edgDisplaySettings edgItems sectionBox">
			<div class="sectionBoxHeader color7">
				<h4>
					<span class="fa fa-tag"></span>
					<asp:Label ID="lblDisplayListItemPage" Resourcekey="lblDisplayListItemPage" runat="server" Text="Item display level" />
				</h4>
				<asp:Label ID="lblItemsSectionToggle" runat="server" CssClass="onOffToggle color7">
					<asp:CheckBox ID="cbDisplayListItemPage" runat="server" CssClass="normalCheckBox" Checked="True" />
					<span class="offText"><%=No%></span>
					<span class="onText"><%=Yes%></span>
					<span class="slider"></span>
				</asp:Label>
			</div>
			<asp:Panel ID="pnlItemListOptions" runat="server" CssClass="displayContent color7">
				<div>
					<div class="displayLevel item">
						<p>3</p>
					</div>
					<div>
						<div class="displayContentTable inputGroupWidth50 clearfix">
							<div class="edGG_inputgroup" runat="server" id="divItemsListThumbnailwidth" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-h"></i>
									<dnn:Label ID="lblItemsListThumbnailwidth" ResourceKey="lblItemsListThumbnailwidth" runat="server" Text="Thumbnail width:" HelpText="Items list thumbnail width."></dnn:Label>
								</div>
								<asp:TextBox ID="tbItemsListThumbnailwidth" runat="server" CssClass="small textCenter higher">220</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbItemsListThumbnailwidth" runat="server" ControlToValidate="tbItemsListThumbnailwidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbItemsListThumbnailwidth" runat="server" ControlToValidate="tbItemsListThumbnailwidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListThumbnailheight" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-v"></i>
									<dnn:Label ID="lblItemsListThumbnailheight" ResourceKey="lblItemsListThumbnailheight" runat="server" Text="Thumbnail height:" HelpText="Items list thumbnail height."></dnn:Label>
								</div>
								<asp:TextBox ID="tbItemsListThumbnailheight" runat="server" CssClass="small textCenter higher">180</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbItemsListThumbnailheight" runat="server" ControlToValidate="tbItemsListThumbnailheight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbItemsListThumbnailheight" runat="server" ControlToValidate="tbItemsListThumbnailheight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayTitle" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-book"></i>
									<dnn:Label ID="lblItemsListDisplayTitle" ResourceKey="lblItemsListDisplayTitle" runat="server" Text="Show title:" HelpText="Item list display title."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayTitle" runat="server" Checked="True" Text="Show title" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemTitleLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-text-width"></i>
									<dnn:Label ID="lblItemTitleLimit" ResourceKey="lblItemTitleLimit" runat="server" Text="Title character limit:" HelpText="Item title limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbItemTitleLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbItemTitleLimit" runat="server" ControlToValidate="tbItemTitleLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbItemTitleLimit" runat="server" ControlToValidate="tbItemTitleLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayDescription" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-font"></i>
									<dnn:Label ID="lblItemsListDisplayDescription" ResourceKey="lblItemsListDisplayDescription" runat="server" Text="Show description:" HelpText="Items list display description."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayDescription" runat="server" Checked="True" Text="Show description" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemDescriptionLimit" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-exchange"></i>
									<dnn:Label ID="lblItemDescriptionLimit" ResourceKey="lblItemDescriptionLimit" runat="server" Text="Description character limit:" HelpText="Item description limit (0 - no limit)."></dnn:Label>
								</div>
								<asp:TextBox ID="tbItemDescriptionLimit" runat="server" CssClass="small textCenter higher">0</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbItemDescriptionLimit" runat="server" ControlToValidate="tbItemDescriptionLimit" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbItemDescriptionLimit" runat="server" ControlToValidate="tbItemDescriptionLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberOfItemsListItemsPerPage" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-clone"></i>
									<dnn:Label ID="lblNumberOfItemsListItemsPerPage" ResourceKey="lblNumberOfItemsListItemsPerPage" runat="server" Text="Number of items per page:" HelpText="Number of items per page."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberOfItemsListItemsPerPage" runat="server" CssClass="small textCenter higher">20</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberOfItemsListItemsPerPage" runat="server" ControlToValidate="tbNumberOfItemsListItemsPerPage" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberOfItemsListItemsPerPage" runat="server" ControlToValidate="tbNumberOfItemsListItemsPerPage" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divNumberOfItemsListPagingLinks" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-ellipsis-h"></i>
									<dnn:Label ID="lblNumberOfItemsListPagingLinks" ResourceKey="lblNumberOfItemsListPagingLinks" runat="server" Text="Number of item paging links:" HelpText="Number of item paging links."></dnn:Label>
								</div>
								<asp:TextBox ID="tbNumberOfItemsListPagingLinks" runat="server" CssClass="small textCenter higher">5</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbNumberOfItemsListPagingLinks" runat="server" ControlToValidate="tbNumberOfItemsListPagingLinks" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbNumberOfItemsListPagingLinks" runat="server" ControlToValidate="tbNumberOfItemsListPagingLinks" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayUploaderInfo" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-user"></i>
									<dnn:Label ID="lblItemsListDisplayUploaderInfo" ResourceKey="lblItemsListDisplayUploaderInfo" runat="server" Text="Uploader info:" HelpText="Show uploader info."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayUploaderInfo" runat="server" Checked="True" Text="Uploader info" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayItemNumberOfViews" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-eye"></i>
									<dnn:Label ID="lblItemsListDisplayItemNumberOfViews" ResourceKey="lblItemsListDisplayItemNumberOfViews" runat="server" Text="Number of item views:" HelpText="Items list display item number of views."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayItemNumberOfViews" runat="server" Checked="True" Text="Number of item views" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayNumberOfLikes" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-thumbs-o-up"></i>
									<dnn:Label ID="lblItemsListDisplayNumberOfLikes" ResourceKey="lblItemsListDisplayNumberOfLikes" runat="server" Text="Number of item likes:" HelpText="Items list display item number of likes."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayNumberOfLikes" runat="server" Checked="True" Text="Number of item likes" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayMediaRatingValue" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-star"></i>
									<dnn:Label ID="lblItemsListDisplayMediaRatingValue" ResourceKey="lblItemsListDisplayMediaRatingValue" runat="server" Text="Show item rating:" HelpText="Display item rating."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayMediaRatingValue" runat="server" Checked="True" Text="Show item rating" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayItemsShareButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblItemsListDisplayItemsShareButtons" ResourceKey="lblItemsListDisplayItemsShareButtons" runat="server" Text="Sharing buttons:" HelpText="Items list display items sharing buttons."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayItemsShareButtons" runat="server" Checked="True" Text="Sharing buttons" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayMediaDownload" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-download"></i>
									<dnn:Label ID="lblItemsListDisplayMediaDownload" ResourceKey="lblItemsListDisplayMediaDownload" runat="server" Text="Show item download link:" HelpText="Show a download link for each item if the user has the permission to download items. This also shows the number of downloads for each item, if that is used in the template."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayMediaDownload" runat="server" Checked="True" Text="Show item download link" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayMediaType" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-caret-square-o-right"></i>
									<dnn:Label ID="lblItemsListDisplayMediaType" ResourceKey="lblItemsListDisplayMediaType" runat="server" Text="Show media type:" HelpText="Items list display media type."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayMediaType" runat="server" Checked="True" Text="Show media type" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemListDisplayBreadCrumbs" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-terminal"></i>
									<dnn:Label ID="lblItemListDisplayBreadCrumbs" ResourceKey="lblItemListDisplayBreadCrumbs" runat="server" Text="Bread crumbs:" HelpText="Items list display bread crumbs."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemListDisplayBreadCrumbs" runat="server" Checked="True" Text="Bread crumbs" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divListItemNumberOfLatestCommentsToDisplay" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-commenting-o"></i>
									<dnn:Label ID="lblListItemNumberOfLatestCommentsToDisplay" ResourceKey="lblListItemNumberOfLatestCommentsToDisplay" runat="server" Text="Number of latest comments to show:" HelpText="Items list number of latest comments to display."></dnn:Label>
								</div>
								<asp:TextBox ID="tbListItemNumberOfLatestCommentsToDisplay" runat="server" CssClass="small textCenter higher">3</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbListItemNumberOfLatestCommentsToDisplay" runat="server" ControlToValidate="tbListItemNumberOfLatestCommentsToDisplay" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbListItemNumberOfLatestCommentsToDisplay" runat="server" ControlToValidate="tbListItemNumberOfLatestCommentsToDisplay" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayumberOfComments" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-comment"></i>
									<dnn:Label ID="lblItemsListDisplayumberOfComments" ResourceKey="lblItemsListDisplayumberOfComments" runat="server" Text="Show number of comments:" HelpText="Items list display number of comments."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayumberOfComments" runat="server" Checked="True" Text="Show number of comments" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayItemsShowRss" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-rss"></i>
									<dnn:Label ID="lblItemsListDisplayItemsShowRss" ResourceKey="lblItemsListDisplayItemsShowRss" runat="server" Text="RSS link:" HelpText="Show a link to the RSS containing that gallery's items."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayShowRss" runat="server" Checked="True" Text="RSS link" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayEmailLink" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-external-link"></i>
									<dnn:Label ID="lbItemsListDisplayEmailLink" ResourceKey="lbItemsListDisplayEmailLink" runat="server" Text="Display email link:" HelpText="Display email link."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayEmailLink" runat="server" Checked="False" Text="Display email link" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListOpenMediaUrl" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblItemsListOpenMediaUrl" runat="server" Text="Open media Url:" HelpText="If media has Url set open it."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListOpenMediaUrl" runat="server" Text="Open media Ur" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListOpenMediaUrlTarget" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-external-link"></i>
									<dnn:Label ID="lblItemsListOpenMediaUrlTarget" runat="server" Text="Open media Url target:" HelpText="Media url window target."></dnn:Label>
								</div>
								<div class="styledSelect">
									<asp:DropDownList ID="ddlItemsListOpenMediaUrlTarge" runat="server">
										<asp:ListItem Value="0" Text="_self" Selected="True" />
										<asp:ListItem Value="1" Text="_blank" />
										<asp:ListItem Value="2" Text="_parent" />
										<asp:ListItem Value="3" Text="_top" />
									</asp:DropDownList>
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divItemsListEnableUserImageReport" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-exclamation-triangle"></i>
									<dnn:Label ID="lblItemsListEnableUserImageReport" runat="server" Text="Enable user report:" HelpText="This options enables registered users to report imagaes." ResourceKey="lblItemsListEnableUserImageReport"></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListEnableUserImageReport" runat="server" Text="Enable user report" />
								</div>
							</div>
						</div>
						<div class="displayContentTable">
							<div class="edGG_inputgroup" runat="server" id="divItemsListDisplayLikeButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblItemsListDisplayLikeButtons" ResourceKey="lblItemsListDisplayLikeButtons" runat="server" Text="Show like buttons:" HelpText="Display like buttons."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayLikeButtons" runat="server" Text="Show like buttons" AutoPostBack="True" OnCheckedChanged="cbItemsListDisplayLikeButtons_CheckedChanged" />
								</div>
								<div id="divItemListSocialButtonSelection" runat="server" style="padding-top: 10px;" visible="false" class="styledCheckbox">
									<asp:CheckBox ID="cbItemsListDisplayLikeButtonFacebook" runat="server" Text="Facebook" />
									<asp:CheckBox ID="cbItemsListDisplayLikeButtonGooglePlus" runat="server" Text="Google+" />
									<asp:CheckBox ID="cbItemsListDisplayLikeButtonTwitter" runat="server" Text="Twitter" />
									<asp:CheckBox ID="cbItemsListDisplayLikeButtonPinterest" runat="server" Text="Pinterest" />
									<asp:CheckBox ID="cbItemsListDisplayLikeButtonLinkedIn" runat="server" Text="LinkedIn" />
								</div>
							</div>
							<div class="edGG_inputgroup">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-sort-amount-asc"></i>
									<dnn:Label ID="lblListItemSortingOption" ResourceKey="lblListItemSortingOption" runat="server" Text="Sorting option:" HelpText="Sorting option."></dnn:Label>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlListItemsSorting" runat="server">
										<asp:ListItem ResourceKey="liPosition" Value="0">Position</asp:ListItem>
										<asp:ListItem ResourceKey="liTitle" Value="1">Title</asp:ListItem>
										<asp:ListItem ResourceKey="liFilename" Value="2">Filename</asp:ListItem>
										<asp:ListItem ResourceKey="liDateUploaded" Value="3">DateUploaded</asp:ListItem>
									</asp:DropDownList>
								</div>
								<div class="styledSelect higher">
									<asp:DropDownList ID="ddlListItemsSortingDirection" runat="server">
										<asp:ListItem ResourceKey="liAscending" Value="0">Ascending</asp:ListItem>
										<asp:ListItem ResourceKey="liDescending" Value="1">Descending</asp:ListItem>
									</asp:DropDownList>
								</div>
							</div>
						</div>
						<div class="displayContentTable" runat="server" id="trItemsListDisplayNewsLink" visible="false">
							<div class="edGG_inputgroup">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblItemsListDisplayNewsLink" ResourceKey="lblItemsListDisplayNewsLink" runat="server" Text="Show link to news article:" HelpText="Display link to news article."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbItemsListDisplayNewsLink" runat="server" Text="Show link to news article" />
								</div>
							</div>
						</div>
						<div class="displayContentTable inputGroupWidth50 clearfix" runat="server" id="trPortfolioOptions" visible="false">
							<div class="edGG_inputgroup" runat="server" id="divShowGalleryFilter" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblShowGalleryFilter" runat="server" Text="Show gallery filter:" HelpText="Show gallery filter if token exists in template."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbShowGalleryFilter" runat="server" Text="ShowGalleryFilter" Checked="True" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divLoadContentOnHover" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-external-link"></i>
									<dnn:Label ID="lblLoadContentOnHover" runat="server" Text="Load content on hover:" HelpText="Load content on hover."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbLoadContentOnHover" runat="server" Text="Load Content On Hover" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</asp:Panel>
		</div>
		<div runat="server" id="divSettingsGroupDetails" class="settingsGroup edgDisplaySettings edgItemDetails sectionBox">
			<div class="sectionBoxHeader color4">
				<h4>
					<span class="fa fa-search"></span>
					<asp:Label ID="lblDisplayDetailsPage" ResourceKey="lblDisplayDetailsPage" runat="server" Text="Details display level" />
				</h4>
				<asp:Label ID="lblDetailsSectionToggle" runat="server" CssClass="onOffToggle color4">
					<asp:CheckBox ID="cbDisplayDetailsPage" runat="server" CssClass="normalCheckBox" Checked="True" />
					<span class="offText"><%=No%></span>
					<span class="onText"><%=Yes%></span>
					<span class="slider"></span>
				</asp:Label>
			</div>
			<asp:Panel ID="pnlDetailsPageOptions" runat="server" CssClass="displayContent color4">
				<div>
					<div class="displayLevel details">
						<p>4</p>
					</div>
					<div>
						<div class="displayContentTable inputGroupWidth50 clearfix">
							<div class="edGG_inputgroup" runat="server" id="divDtailsThumbnailWidth" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-h"></i>
									<dnn:Label ID="lblDtailsThumbnailWidth" ResourceKey="lblDtailsThumbnailWidth" runat="server" Text="Thumbnail width:" HelpText="Details thumbnail width."></dnn:Label>
								</div>
								<asp:TextBox ID="tbDetailsThumbnailWidth" runat="server" CssClass="small textCenter higher">800</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbDetailsThumbnailWidth" runat="server" ControlToValidate="tbDetailsThumbnailWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbDetailsThumbnailWidth" runat="server" ControlToValidate="tbDetailsThumbnailWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDtailsThumbnailHeigh" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-arrows-v"></i>
									<dnn:Label ID="lblDtailsThumbnailHeight" ResourceKey="lblDtailsThumbnailHeight" runat="server" Text="Thumbnail height:" HelpText="Details thumbnail height."></dnn:Label>
								</div>
								<asp:TextBox ID="tbDtailsThumbnailHeight" runat="server" CssClass="small textCenter higher">800</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbDtailsThumbnailHeight" runat="server" ControlToValidate="tbDtailsThumbnailHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbDtailsThumbnailHeight" runat="server" ControlToValidate="tbDtailsThumbnailHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayTitle" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-book"></i>
									<dnn:Label ID="lblDetailsDisplayTitle" ResourceKey="lblDetailsDisplayTitle" runat="server" Text="Show title:" HelpText="Show title in details."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayTitle" runat="server" Checked="True" Text="Show title" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayDescription" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-font"></i>
									<dnn:Label ID="lblDetailsDisplayDescription" ResourceKey="lblDetailsDisplayDescription" runat="server" Text="Show description:" HelpText="Show description in details."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayDescription" runat="server" Checked="True" Text="Show description" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayUploaderInfo" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-user"></i>
									<dnn:Label ID="lblDetailsDisplayUploaderInfo" ResourceKey="lblDetailsDisplayUploaderInfo" runat="server" Text="Show uploader info:" HelpText="Display uploader info."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayUploaderInfo" runat="server" Checked="True" Text="Show uploader info" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayItemNumberOfViews" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-eye"></i>
									<dnn:Label ID="lblDetailsDisplayItemNumberOfViews" ResourceKey="lblDetailsDisplayItemNumberOfViews" runat="server" Text="Number of views:" HelpText="Display item number of views."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayItemNumberOfViews" runat="server" Checked="True" Text="Number of views" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayNumberOfLikes" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-thumbs-o-up"></i>
									<dnn:Label ID="lblDetailsDisplayNumberOfLikes" ResourceKey="lblDetailsDisplayNumberOfLikes" runat="server" Text="Number of likes:" HelpText="Display item number of likes."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayNumberOfLikes" runat="server" Checked="True" Text="Number of likes" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayDisplayUsersWhoLikedMedia" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-users"></i>
									<dnn:Label ID="lblDetailsDisplayDisplayUsersWhoLikedMedia" ResourceKey="lblDetailsDisplayDisplayUsersWhoLikedMedia" runat="server" Text="Show users who liked an item:" HelpText="Show a list of users who have liked an item."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayDisplayUsersWhoLikedMedia" runat="server" Checked="True" Text="Show users who liked an item" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsNumberOfUsersWhoLikedMedia" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-heart"></i>
									<dnn:Label ID="lblDetailsNumberOfUsersWhoLikedMedia" ResourceKey="lblDetailsNumberOfUsersWhoLikedMedia" runat="server" Text="Number of users who liked an item:" HelpText="The number of users who have liked an item."></dnn:Label>
								</div>
								<asp:TextBox ID="tbDetailsNumberOfUsersWhoLikedMedia" runat="server" CssClass="small textCenter higher">10</asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvtbDetailsNumberOfUsersWhoLikedMedia" runat="server" ControlToValidate="tbDetailsNumberOfUsersWhoLikedMedia" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvtbDetailsNumberOfUsersWhoLikedMedia" runat="server" ControlToValidate="tbDetailsNumberOfUsersWhoLikedMedia" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayNumberOfDownloads" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-download"></i>
									<dnn:Label ID="lblDetailsDisplayNumberOfDownloads" ResourceKey="lblDetailsDisplayNumberOfDownloads" runat="server" HelpText="Show a download link for each item if the user has the permission to download items. This also shows the number of downloads for each item, if that is used in the template." Text="Show item download link:" />
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayNumberOfDownloads" runat="server" Checked="True" Text="Show item download link" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayMediaRatingValue" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-star"></i>
									<dnn:Label ID="lblDetailsDisplayMediaRatingValue" ResourceKey="lblDetailsDisplayMediaRatingValue" runat="server" Text="Show rating:" HelpText="Display media rating value."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayMediaRatingValue" runat="server" Checked="True" Text="Show rating" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayItemsShareButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblDetailsDisplayItemsShareButtons" ResourceKey="lblDetailsDisplayItemsShareButtons" runat="server" Text="Sharing buttons:" HelpText="Display sharing buttons."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayItemsShareButtons" runat="server" Checked="True" Text="Sharing buttons" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayNumberOfComments" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-commenting-o"></i>
									<dnn:Label ID="lblDetailsDisplayNumberOfComments" ResourceKey="lblDetailsDisplayNumberOfComments" runat="server" Text="Number of comments:" HelpText="Display number of comments."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayNumberOfComments" runat="server" Checked="True" Text="Number of comments:" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayExifData" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-camera"></i>
									<dnn:Label ID="lblDetailsDisplayExifData" ResourceKey="lblDetailsDisplayExifData" runat="server" Text="Exif data:" HelpText="Display media exif data."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayExifData" runat="server" Checked="True" Text="Exif data:" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayMediaType" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-caret-square-o-right"></i>
									<dnn:Label ID="lblDetailsDisplayMediaType" ResourceKey="lblDetailsDisplayMediaType" runat="server" Text="Show media type:" HelpText="Display media type."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayMediaType" runat="server" Checked="True" Text="Show media type:" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayBreadCrumbs" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-terminal"></i>
									<dnn:Label ID="lblDetailsDisplayBreadCrumbs" ResourceKey="lblDetailsDisplayBreadCrumbs" runat="server" Text="Bread crumbs:" HelpText="Display bread crumbs."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayBreadCrumbs" runat="server" Checked="True" Text="Bread crumbs" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayEmailLink" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-external-link"></i>
									<dnn:Label ID="lblDetailsDisplayEmailLink" ResourceKey="lblDetailsDisplayEmailLink" runat="server" Text="Display email link:" HelpText="Display email link."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayEmailLink" runat="server" Checked="False" Text="Display email link" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayEnableUserImageReport" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-exclamation-triangle"></i>
									<dnn:Label ID="lblDetailsDisplayEnableUserImageReport" ResourceKey="lblDetailsDisplayEnableUserImageReport" runat="server" Text="Enable user report:" HelpText="This options enables registered users to report imagaes."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayEnableUserImageReport" runat="server" Text="Enable user report" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsOpenMediaUrl" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblDetailsOpenMediaUrl" runat="server" Text="Open media Url:" HelpText="If media has Url set open it."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsOpenMediaUrl" runat="server" Text="Open media Ur" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="divDetailsOpenMediaUrlTarget" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-external-link"></i>
									<dnn:Label ID="lblDetailsOpenMediaUrlTarget" runat="server" Text="Open media Url target:" HelpText="Media url window target ."></dnn:Label>
								</div>
								<div class="styledSelect">
									<asp:DropDownList ID="ddlDetailsOpenMediaUrlTarge" runat="server">
										<asp:ListItem Value="0" Text="_self" Selected="True" />
										<asp:ListItem Value="1" Text="_blank" />
										<asp:ListItem Value="2" Text="_parent" />
										<asp:ListItem Value="3" Text="_top" />
									</asp:DropDownList>
								</div>
							</div>
						</div>
						<div class="displayContentTable">
							<div class="edGG_inputgroup" runat="server" id="divDetailsDisplayLikeButtons" visible="false">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-share-square-o"></i>
									<dnn:Label ID="lblDetailsDisplayLikeButtons" ResourceKey="lblDetailsDisplayLikeButtons" runat="server" Text="Show like buttons:" HelpText="Display like buttons."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayLikeButtons" runat="server" AutoPostBack="True" OnCheckedChanged="cbDetailsDisplayLikeButtons_CheckedChanged" Checked="True" Text="Show like buttons" />
								</div>
								<div id="divDetailsSocialButtonSelection" runat="server" class="styledCheckbox displayInline">
									<asp:CheckBox ID="cbDetailsDisplayLikeButtonFacebook" runat="server" ResourceKey="cbDetailsDisplayLikeButtonFacebook" Text="Facebook" Checked="True" />
									<asp:CheckBox ID="cbDetailsDisplayLikeButtonGooglePlus" runat="server" ResourceKey="cbDetailsDisplayLikeButtonGooglePlus" Text="Google+" Checked="True" />
									<asp:CheckBox ID="cbDetailsDisplayLikeButtonTwitter" runat="server" ResourceKey="cbDetailsDisplayLikeButtonTwitter" Text="Twitter" Checked="True" />
									<asp:CheckBox ID="cbDetailsDisplayLikeButtonPinterest" runat="server" ResourceKey="cbDetailsDisplayLikeButtonPinterest" Text="Pinterest" Checked="True" />
									<asp:CheckBox ID="cbDetailsDisplayLikeButtonLinkedIn" runat="server" ResourceKey="cbDetailsDisplayLikeButtonLinkedIn" Text="LinkedIn" Checked="True" />
								</div>
							</div>
							<div class="edGG_inputgroup" runat="server" id="trDetailsDisplayNewsLink">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblDetailsDisplayNewsLink" ResourceKey="lblDetailsDisplayNewsLink" runat="server" Text="Show link to news article:" HelpText="Display link to news article."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbDetailsDisplayNewsLink" runat="server" Text="Show link to news article" />
								</div>
							</div>
							<div class="edGG_inputgroup" id="trPostCommentNotificationToJournal" runat="server">
								<div class="edGG_inputGroupLabel">
									<i class="fa fa-stack-exchange"></i>
									<dnn:Label ID="lblPostCommentNotificationToJournal" ResourceKey="lblPostCommentNotificationToJournal" runat="server" Text="Post comment notification to Journal:" HelpText="Every time a user posts a comment on an item, a notification for the comment is added to that user's DNN Journal."></dnn:Label>
								</div>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbPostCommentNotificationToJournal" runat="server" Text="Post comment notification to Journal" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</asp:Panel>
		</div>
		<div class="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-asterisk"></span>
					<span><%=Generaloptions%></span>
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblAvatarProvider" ResourceKey="lblAvatarProvider" runat="server" Text="Select avatar provider:" HelpText="Select avatar provider." />
								</td>
								<td>
									<asp:RadioButtonList ID="rblAvatarProvider" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
										<asp:ListItem resourcekey="liGravatar" Selected="True" Value="1">Gravatar</asp:ListItem>
										<asp:ListItem resourcekey="liDNNProfile" Value="2">DNN profile</asp:ListItem>
										<asp:ListItem resourcekey="liNoAvatars" Value="0">No avatars</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSelectResiznigMethod" ResourceKey="lblSelectResiznigMethod" runat="server" Text="Select image resize method:" HelpText="Select image resize method." />
								</td>
								<td>
									<asp:RadioButtonList ID="rblSelectResiznigMethod" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
										<asp:ListItem resourcekey="liProportional" Value="2" Selected="True">Proportional</asp:ListItem>
										<asp:ListItem resourcekey="liCrop" Value="1">Crop</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblUseMasonryLayout" ResourceKey="lblUseMasonryLayout" runat="server" Text="Use masonry layout:" HelpText="Use masonry mayout."></dnn:Label>
								</td>
								<td>
									<div class="styledCheckbox noLabel big">
										<asp:CheckBox ID="cbUseMasonryLayout" runat="server" Checked="True" Text="Use masonry layout:" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSelectTypeOfMedia" ResourceKey="lblSelectTypeOfMedia" runat="server" Text="Select type of media:" HelpText="Select type of media that will be displayed."></dnn:Label>
								</td>
								<td>
									<div class="styledCheckbox big">
										<asp:CheckBoxList ID="cblMediaSelect" runat="server" RepeatDirection="Horizontal" ValidationGroup="vgTGSettings" RepeatLayout="Flow">
											<asp:ListItem ResourceKey="liImage" Selected="True" Value="Image">Image</asp:ListItem>
											<asp:ListItem ResourceKey="liVideo" Selected="True" Value="Video">Video</asp:ListItem>
											<asp:ListItem ResourceKey="liAudio" Selected="True" Value="Audio">Audio</asp:ListItem>
										</asp:CheckBoxList>
									</div>
									<asp:CustomValidator ID="cvMedeaSelectValidator" Display="Dynamic" ValidationGroup="vgGravitySaveSettings" runat="server" ClientValidationFunction="ValidateCheckBoxList" SetFocusOnError="True">Please select at least one media type.</asp:CustomValidator>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div id="divPaginationOptions" runat="server" class="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-ellipsis-h"></span>
					<span><%=Paginationoptions%></span>
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr id="trGravityPaginationOptions" runat="server">
								<td class="label textTop">
									<dnn:Label ID="lblPagingTypeTitle" ResourceKey="lblPagingTypeTitle" runat="server" Text="Set the pagination type:" HelpText="Set the pagination type."></dnn:Label>
								</td>
								<td>
									<asp:RadioButtonList ID="rblSelectPaginationType" runat="server" RepeatDirection="Vertical" CssClass="styledRadio small">
										<asp:ListItem resourcekey="liNormalPagination" Value="NormalPagination">Classical pagination</asp:ListItem>
										<asp:ListItem resourcekey="liInfiniteOnButtonClick" Value="InfiniteOnButtonClick" Selected="True">Infinite scroll pagination with Load more button</asp:ListItem>
										<asp:ListItem resourcekey="liInfiniteOnButtonClickAndScroll" Value="InfiniteOnButtonClickAndScroll">Infinite scroll pagination with automatic item loading</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
							<tr id="trPortfolioPaginationOptions" runat="server">
								<td class="label">
									<i class="fa fa-link"></i>
									<dnn:Label ID="lblIsPaginationEnabled" runat="server" Text="Enable pagination:" HelpText="Enable pagination if token exists in template."></dnn:Label>
								</td>
								<td colspan="3">
									<div class="styledCheckbox noLabel big">
										<asp:CheckBox ID="cbIsPaginationEnabled" runat="server" Text="Is Pagination Enabled" Checked="True" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-external-link"></span>
					<asp:Label ID="lblLitghboxSetup" resourcekey="lblLitghboxSetup" runat="server" Text="Lightbox" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label textTop">
									<dnn:Label ID="lblLightboxSetting" ResourceKey="lblLightboxSetting" runat="server" Text="Use lightbox to open items:" HelpText="Use lightbox to open items."></dnn:Label>
								</td>
								<td class="textTop">
									<asp:RadioButtonList ID="rblLigtBoxSelection" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio">
										<asp:ListItem resourcekey="liNo" Value="0">No</asp:ListItem>
										<asp:ListItem resourcekey="liSocialMediaBoxLite" Value="2" Selected="False">SocialMediaBox Lite</asp:ListItem>
										<asp:ListItem resourcekey="liSocialMediaBoxPlus" Value="3">SocialMediaBox Plus</asp:ListItem>
										<asp:ListItem resourcekey="liSocialMediaBox" Value="1" Selected="True">SocialMediaBox Advanced</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<asp:Panel ID="pnlSMBOptions" runat="server">
										<div style="float: left; width: 260px; margin: 15px; padding: 0;">
											<img alt="" src='<%=ControlPath.Replace("/SettingsControls", "")%>images/icons/smb.png' />
										</div>
										<table cellspacing="0" cellpadding="0" border="0" style="float: right; width: 788px;">
											<tr>
												<td class="label">
													<dnn:Label ID="lblsmbShowThumbnails" ResourceKey="lblsmbShowThumbnails" runat="server" Text="Show thumbnails panel:" HelpText="Show thumbnails panel."></dnn:Label>
												</td>
												<td>
													<div class="styledCheckbox noLabel">
														<asp:CheckBox ID="cbSmbShowThumbnails" runat="server" Text="Show thumbnails panel" />
													</div>
												</td>
												<td class="label">
													<dnn:Label ID="lblsmbShowDetailsPanel" ResourceKey="lblsmbShowDetailsPanel" runat="server" Text="Show Item details panel:" HelpText="Show Item details panel."></dnn:Label>
												</td>
												<td>
													<div class="styledCheckbox noLabel">
														<asp:CheckBox ID="cbSocialMediaBoxShowDetails" runat="server" Checked="True" Text="Show Item details panel" />
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="4" style="width: auto; padding: 0;">
													<table id="tblSmbOPtions" runat="server" cellspacing="0" cellpadding="0" border="0" style="width: 100%;">
														<tr>
															<td class="label">
																<dnn:Label ID="lblSmbShowTitle" ResourceKey="lblSmbShowTitle" runat="server" Text="Show title:" HelpText="Show title."></dnn:Label>
															</td>
															<td>
																<div class="styledCheckbox noLabel small">
																	<asp:CheckBox ID="cbSmbShowTitle" runat="server" Checked="True" Text="Show title" />
																</div>
															</td>
															<td class="label">
																<dnn:Label ID="lblSmbShowDescription" ResourceKey="lblSmbShowDescription" runat="server" Text="Show description:" HelpText="Show description:"></dnn:Label>
															</td>
															<td>
																<div class="styledCheckbox noLabel small">
																	<asp:CheckBox ID="cbSmbShowDescription" runat="server" Checked="True" Text="Show description" />
																</div>
															</td>
														</tr>
														<tr>
															<td class="label">
																<dnn:Label ID="lblsmbShowEmail" ResourceKey="lblsmbShowEmail" runat="server" Text="Show email link:" HelpText="Show email link."></dnn:Label>
															</td>
															<td>
																<div class="styledCheckbox noLabel small">
																	<asp:CheckBox ID="cbsmbShowEmailLink" runat="server" Checked="True" Text="Show email link" />
																</div>
															</td>
															<td class="label">
																<dnn:Label ID="lblsmbShowUploaderInfo" ResourceKey="lblsmbShowUploaderInfo" runat="server" Text="Show user info:" HelpText="Show information about the user who added the image or other media."></dnn:Label>
															</td>
															<td>
																<div class="styledCheckbox noLabel small">
																	<asp:CheckBox ID="cbSmbShowUploaderInfo" runat="server" Checked="True" Text="Show user info" />
																</div>
															</td>
														</tr>
														<tr>
															<td class="label">
																<dnn:Label ID="lblSmbShowDownloadLink" ResourceKey="lblSmbShowDownloadLink" runat="server" Text="Show downlink link:" HelpText="Show downlink link."></dnn:Label>
															</td>
															<td>
																<div class="styledCheckbox noLabel small">
																	<asp:CheckBox ID="cbSmbShowDownloadLink" runat="server" Checked="True" Text="Show downlink link" />
																</div>
															</td>
															<td></td>
															<td></td>
														</tr>
														<tr id="trsmbSocialSharing" runat="server">
															<td class="label">
																<dnn:Label ID="lblSocialMediaBoxShowSocialSharing" ResourceKey="lblSocialMediaBoxShowSocialSharing" runat="server" Text="Show social sharing buttons:" HelpText="Show social sharing buttons."></dnn:Label>
															</td>
															<td colspan="3">
																<asp:Panel ID="pnlSmbSocialSharingButons" runat="server" Style="margin-top: 5px">
																	<div class="styledCheckbox">
																		<asp:CheckBox ID="cbSmbShowFacebook" resourcekey="cbSmbShowFacebook" runat="server" Text="Facebook" Checked="True" />
																		<asp:CheckBox ID="cbSmbShowGooglePlus" resourcekey="cbSmbShowGooglePlus" runat="server" Text="Google+" Checked="True" />
																		<asp:CheckBox ID="cbSmbShowTwitter" resourcekey="cbSmbShowTwitter" runat="server" Text="Twitter" Checked="True" />
																		<asp:CheckBox ID="cbSmbShowPintrest" resourcekey="cbSmbShowPintrest" runat="server" Text="Pinterest" Checked="True" />
																		<asp:CheckBox ID="cbSmbShowLinkedIn" resourcekey="cbSmbShowLinkedIn" runat="server" Text="LinkedIn" Checked="True" />
																	</div>
																</asp:Panel>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</asp:Panel>
									<asp:Panel ID="pnlSMBLiteOptions" runat="server">
										<div style="float: left; width: 260px; margin: 15px; padding: 0;">
											<img id="imgSmbOptionsImage" alt="" src='<%=ControlPath.Replace("/SettingsControls", "")%>images/icons/smblight.png' />
										</div>
										<table cellspacing="0" cellpadding="0" border="0" style="float: right; width: 788px;">
											<tr>
												<td class="label">
													<dnn:Label ID="lblSmbLiteShowTitle" ResourceKey="lblSmbLiteShowTitle" runat="server" Text="Show title:" HelpText="Show title."></dnn:Label>
												</td>
												<td>
													<div class="styledCheckbox noLabel">
														<asp:CheckBox ID="cbSmbLiteShowTitle" runat="server" Checked="True" Text="Show title" />
													</div>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblSmbLitewrapperResizeDuration" ResourceKey="lblSmbLitewrapperResizeDuration" runat="server" Text="Transition effect:" HelpText="Transition effect."></dnn:Label>
												</td>
												<td>
													<asp:RadioButtonList ID="rblSmbLitewrapperResizeDuration" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
														<asp:ListItem resourcekey="liNone" Value="0">None</asp:ListItem>
														<asp:ListItem resourcekey="liFast" Value="1" Selected="True">Fast</asp:ListItem>
														<asp:ListItem resourcekey="liSlow" Value="2" Selected="False">Slow</asp:ListItem>
													</asp:RadioButtonList>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblSmbLiteShowSocialSharing" ResourceKey="lblSmbLiteShowSocialSharing" runat="server" Text="Show social sharing buttons:" HelpText="Show social sharing buttons"></dnn:Label>
												</td>
												<td>
													<asp:Panel ID="pnlSmbLiteSocialSharingButons" resourcekey="liNone" runat="server" Style="margin-top: 5px">
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbSmbLiteShowFacebook" resourcekey="cbSmbLiteShowFacebook" runat="server" Text="Facebook" Checked="True" />
															<asp:CheckBox ID="cbSmbLiteShowGooglePlus" resourcekey="cbSmbLiteShowGooglePlus" runat="server" Text="Google+" Checked="True" />
															<asp:CheckBox ID="cbSmbLiteShowTwitter" resourcekey="cbSmbLiteShowTwitter" runat="server" Text="Twitter" Checked="True" />
															<asp:CheckBox ID="cbSmbLiteShowPintrest" resourcekey="cbSmbLiteShowPintrest" runat="server" Text="Pinterest" Checked="True" />
															<asp:CheckBox ID="cbSmbLiteShowLinkedIn" resourcekey="cbSmbLiteShowLinkedIn" runat="server" Text="LinkedIn" Checked="True" />
														</div>
													</asp:Panel>
												</td>
											</tr>
										</table>
									</asp:Panel>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div runat="server" id="divGoogleMaps" class="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-map-o"></span>
					<asp:Label ID="lblGoogleMapsSetup" resourcekey="lblGoogleMapsSetup" runat="server" Text="Google Maps:" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr id="trGmapsInfo" runat="server" visible="false">
								<td colspan="2">
									<asp:Label ID="lblSetupGoolgeMapsApiKey" resourcekey="lblSetupGoolgeMapsApiKey" runat="server" Text="To enable Google Maps, please go to the API Connection control (Dasboard -> API settings) and enter your Google Maps API key."></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="label textTop">
									<dnn:Label ID="lblEnableGoogleMaps" ResourceKey="lblEnableGoogleMaps" runat="server" Text="Google Maps:" HelpText="If an item has GPS coordinates in it's EXIF data, a Google Maps map showing the location is displayed on it's details page." />
								</td>
								<td>
									<div class="styledCheckbox big noLabel">
										<asp:CheckBox ID="cbEnableGoogleMaps" runat="server" AutoPostBack="True" Text="Google Maps" />
									</div>
									<asp:Panel ID="pnlMapsOptions" runat="server">
										<table cellspacing="0" cellpadding="0" border="0">
											<tr>
												<td class="label textTop">
													<dnn:Label ID="lblGoogleMapsWidth" ResourceKey="lblGoogleMapsWidth" runat="server" Text="Map width:" HelpText="Set the width of the map in pixels or percentage." />
												</td>
												<td class="textTop">
													<asp:TextBox ID="tbGoogleMapsWidth" runat="server" CssClass="small textCenter">500</asp:TextBox>
													<div>
														<asp:RequiredFieldValidator ID="rfvGoogleMapsWidth" runat="server" ControlToValidate="tbGoogleMapsWidth" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvGoogleMapsWidth.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
														<asp:CompareValidator ID="cvGoogleMapsWidth" runat="server" ControlToValidate="tbGoogleMapsWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvGoogleMapsWidth.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
														<asp:RangeValidator ID="rvGoogleMapsWidthPixels" runat="server" ControlToValidate="tbGoogleMapsWidth" Display="Dynamic" ErrorMessage="Enter value between 0-1000." MaximumValue="1000" MinimumValue="0" resourcekey="rvGoogleMapsWidthPixels.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:RangeValidator>
														<asp:RangeValidator ID="rvGoogleMapsWidthPercent" runat="server" ControlToValidate="tbGoogleMapsWidth" Display="Dynamic" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvGoogleMapsWidthPercent.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings" Enabled="False" Visible="False"></asp:RangeValidator>
													</div>
												</td>

												<td class="textTop">
													<asp:RadioButtonList ID="rblMapWidthType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblMapWidthType_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
														<asp:ListItem resourcekey="liPixel" Value="False" Selected="True">Pixel</asp:ListItem>
														<asp:ListItem resourcekey="liPercentage" Value="True">Percentage</asp:ListItem>
													</asp:RadioButtonList>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblGoogleMapsHeight" ResourceKey="lblGoogleMapsHeight" runat="server" Text="Map height:" HelpText="Set the height of the map in pixels or percentage." />
												</td>
												<td colspan="2" class="textTop">
													<asp:TextBox ID="tbGoogleMapsHeight" runat="server" CssClass="small textCenter">500</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvGoogleMapsHeight" runat="server" ControlToValidate="tbGoogleMapsHeight" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvGoogleMapsHeight.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvGoogleMapsHeight" runat="server" ControlToValidate="tbGoogleMapsHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvGoogleMapsHeight.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblGoogleMapsZoomLevel" runat="server" ResourceKey="lblGoogleMapsZoomLevel" Text="Maps zoom level:" HelpText="Maps zoom level" />
												</td>
												<td colspan="2" class="textTop">
													<asp:TextBox ID="tbGoogleMapsZoomLevel" runat="server" CssClass="small textCenter">12</asp:TextBox>
													<asp:RequiredFieldValidator ID="rfvMapsZoomLevel" runat="server" ControlToValidate="tbGoogleMapsZoomLevel" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvMapsZoomLevel.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
													<asp:CompareValidator ID="cvMapsZoomLevel" runat="server" ControlToValidate="tbGoogleMapsZoomLevel" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvMapsZoomLevel.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblGoogleMapType" ResourceKey="lblGoogleMapType" runat="server" Text="Select Google Map type:" HelpText="Select Google Map type" />
												</td>
												<td colspan="2">
													<asp:RadioButtonList ID="rblGoogleMapType" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
														<asp:ListItem resourcekey="liRoadmap" Selected="True" Value="ROADMAP">ROADMAP</asp:ListItem>
														<asp:ListItem resourcekey="liSatellite" Value="SATELLITE">SATELLITE</asp:ListItem>
														<asp:ListItem resourcekey="liHybrid" Value="HYBRID">HYBRID</asp:ListItem>
														<asp:ListItem resourcekey="liTerrain" Value="TERRAIN">TERRAIN</asp:ListItem>
													</asp:RadioButtonList>
												</td>
											</tr>
											<tr>
												<td class="label">
													<dnn:Label ID="lblGoogleMapsShowMarkerInfo" runat="server" ResourceKey="lblGoogleMapsShowMarkerInfo" Text="Show marker info:" HelpText="Show marker info" />
												</td>
												<td colspan="2">
													<div class="styledCheckbox noLabel">
														<asp:CheckBox ID="cbGoogleMapsShowMarkerInfo" runat="server" Text="Show marker info" />
													</div>
												</td>
											</tr>
										</table>
									</asp:Panel>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<asp:Panel ID="pnlRssSettingsWrapper" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-rss"></span>
					<asp:Label ID="lblRssSettings" resourcekey="lblRssSettings" runat="server" Text="RSS settings" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblNumberOfRSSLinks" ResourceKey="lblNumberOfRSSLinks" runat="server" Text="Setup the number of RSS links:" HelpText="Setup the number of RSS liks" />
								</td>
								<td>
									<asp:TextBox ID="tbNumerOfRSSLinks" runat="server" CssClass="small textCenter">10</asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbNumerOfRSSLinks" runat="server" ControlToValidate="tbNumerOfRSSLinks" Display="Dynamic" ErrorMessage="This field is required." resourcekey="RequiredField.ErrorMessage" ValidationGroup="vgGravitySaveSettings"></asp:RequiredFieldValidator>
									<asp:CompareValidator ID="cvtbNumerOfRSSLinks" runat="server" ControlToValidate="tbNumerOfRSSLinks" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="OnlyNumber.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgGravitySaveSettings"></asp:CompareValidator>
								</td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblRSSIncludeImageInDescription" ResourceKey="lblRSSIncludeImageInDescription" runat="server" Text="Include image in RSS description:" HelpText="Include image in RSS description" />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbRSSIncludeImageInDescription" runat="server" Text="Include image in RSS description:" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlSelectNewsInstance" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-newspaper-o"></span>
					<asp:Label ID="lblNewsInstanceConncetion" resourcekey="lblNewsInstanceConncetion" runat="server" Text="EasyDNNnews connection" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblNewsOpenDetails" ResourceKey="lblNewsOpenDetails" runat="server" Text="EasyDNNnews instance:" HelpText="If a gallery is included in any news article, you can select a news instance in which the article that contains the gallery will be displayed." />
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlNewsOpenDetails" runat="server" AppendDataBoundItems="True">
											<asp:ListItem Value="0">Select news module instance</asp:ListItem>
										</asp:DropDownList>
									</div>
									<asp:Label ID="lblNewsModuleValidateEror" resourcekey="lblNewsModuleValidateEror" runat="server" Style="display: none" ForeColor="Red" Text="Please select a news instance."></asp:Label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlCommunityModeWrapper" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox" Visible="True" Enabled="False">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-users"></span>
					<asp:Label ID="lblCommunityMode" resourcekey="lblCommunityMode" runat="server" Text="Community mode" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table runat="server" id="tblEnableCommunityMessage" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td>
									<asp:Label ID="lblEnableCommunityModeMessage" resourcekey="lblEnableCommunityModeMessage" runat="server" Text="Community mode option can be enabled only when the module is added within Activity feed pages (User's or Group's)." />
								</td>
							</tr>
						</tbody>
					</table>
					<table runat="server" id="tblEnableCommunitySettings" visible="false" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblEnableCommunityMode" ResourceKey="lblEnableCommunityMode" runat="server" Text="Enable community mode:" HelpText="Enable community mode." />
								</td>
								<td>
									<div class="styledCheckbox noLabel big">
										<asp:CheckBox ID="cbEnableCommunityMode" runat="server" AutoPostBack="True" OnCheckedChanged="cbEnableCommunityMode_CheckedChanged" CssClass="communityMode" Text="Enable community mode" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<table runat="server" id="tblCommunitySettings" visible="false" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblUserUploadInterface" runat="server" Text="User media upload interface:" HelpText="User media upload interface." />
								</td>
								<td>
									<asp:RadioButtonList ID="rblUserUploadInterface" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
										<asp:ListItem Value="AdminInterface">Standard managment interface</asp:ListItem>
										<asp:ListItem Value="InlineInterface" Selected="True">In-place editing</asp:ListItem>
										<asp:ListItem Value="Both">Both</asp:ListItem>
									</asp:RadioButtonList>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlUploadSettings" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-upload"></span>
					<asp:Label ID="lblUploadSettigns" resourcekey="lblUploadSettigns" runat="server" Text="Upload settings" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblEnableUpload" runat="server" Text="Enable upload:" HelpText="Enable user media upload." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbEnableUpload" runat="server" Visible="True" Checked="False" Text="Enable upload" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<table id="tblUploadSettings" runat="server" cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblEnableGalleryCreation" runat="server" Text="Enable gallery creation:" HelpText="Enable gallery creation." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbEnableGalleryCreation" runat="server" Visible="True" Checked="False" Text="Enable gallery creation." />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblApproveUploadedImages" runat="server" Text="Approve uploaded images:" HelpText="Approved images require approval." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbApproveUploadedImages" runat="server" Visible="True" Checked="False" Text="Approve uploaded images" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSendApproveNotification" runat="server" Text="Send notification to approver:" HelpText="Send notification to approver when new media is uploaded and needs approval." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbSendApproveNotification" runat="server" Visible="True" Checked="False" Text="Send notification to approver" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblLimitUploadSize" runat="server" Text="Limit upload file size:" HelpText="Set maximum uploaded media file size (0- unlimited)." />
								</td>
								<td>
									<asp:TextBox ID="tbLimitUploadSize" runat="server" CssClass="small textCenter" Text="0"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblResizeUploadedImages" runat="server" Text="Resize uploaded images:" HelpText="Resize uploaded images to set width and height." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbResizeUploadedImages" runat="server" Visible="True" Checked="False" AutoPostBack="True" OnCheckedChanged="cbResizeUploadedImages_CheckedChanged" Text="Resize uploaded images:" />
									</div>
								</td>
							</tr>
							<tr runat="server" id="trUploadResizeWidth" visible="false">
								<td class="label">
									<dnn:Label ID="lblUploadResizeWidth" runat="server" Text="Upload resize width:" HelpText="Upload resize width." />
								</td>
								<td>
									<asp:TextBox ID="tbUploadResizeWidth" runat="server" CssClass="small textCenter" Text="900"></asp:TextBox>
								</td>
							</tr>
							<tr runat="server" id="trUploadResizeHeight" visible="false">
								<td class="label">
									<dnn:Label ID="lblUploadResizeHeight" runat="server" Text="Upload resize height:" HelpText="Upload resize height." />
								</td>
								<td>
									<asp:TextBox ID="tbUploadResizeHeight" runat="server" CssClass="small textCenter" Text="600"></asp:TextBox>
								</td>
							</tr>
							<tr id="trEnablePostToJournal" runat="server">
								<td class="label">
									<dnn:Label ID="lblEnableJouranlPosting" runat="server" Text="Enable posting to journal:" HelpKey="lblEnableJouranlPosting.HelpText" HelpText="This is automatically post info about uploaded media to user Journal activity feed."></dnn:Label>
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbEnableJournalPosting" runat="server" AutoPostBack="True" OnCheckedChanged="cbEnableJournalPosting_CheckedChanged" Checked="False" resourcekey="cbEnableJournalPostingResource1" Text="Enable posting to journal" />
									</div>
								</td>
							</tr>
							<tr runat="server" id="trAutoPostToJournal">
								<td class="label">
									<dnn:Label ID="lblAutoPostToJournal" runat="server" Text="Auto post to journal:" HelpText="Auto post to journal:" HelpKey="lblAutoPostToJournal.HelpText" ResourceKey="lblAutoPostToJournal"></dnn:Label>
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbAutoPostingToJourmal" runat="server" AutoPostBack="True" Checked="False" resourcekey="cbAutoPostingToJourmalResource1" Text="Auto post to journal" />
									</div>
								</td>
							</tr>
							<tr runat="server" id="trListOfModules">
								<td class="label">
									<dnn:Label ID="lblListOfModules" runat="server" Text="Select module to open gallery details from user Journal:" HelpText="Select module to open gallery details from user Journal:" ResourceKey="lblListOfModules" HelpKey="lblListOfModules.HelpText"></dnn:Label>
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlGalleryModuleList" runat="server" resourcekey="ddlGalleryModuleListResource1"></asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr runat="server" id="trGroupDetails">
								<td class="label">
									<dnn:Label ID="lblGroupDetails" runat="server" Text="Select module to open gallery details from group Journal:" HelpText="Select module to open gallery details from group Journal:" ResourceKey="lblGroupDetails" HelpKey="lblGroupDetails.HelpText"></dnn:Label>
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlGroupGalleryModuleList" runat="server" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlCommentsSettings" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-commenting-o"></span>
					<asp:Label ID="lblCommentsSettigns" runat="server" resourcekey="lblCommentsSettigns" Text="Comments settings" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblCommentsMustBeApproved" runat="server" ResourceKey="lblCommentsMustBeApproved" Text="New comments must be approved:" HelpText="New comments must be approved." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbCommentsMustBeApproved" runat="server" Text="New comments must be approved" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSendNewCommentNotification" runat="server" ResourceKey="lblSendNewCommentNotification" Text="Send new comment notification:" HelpText="Send notification when new comment is added." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbSendNewCommentNotification" runat="server" Text="Send notification" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSendNotificationToCommentAuthor" runat="server" ResourceKey="lblSendNotificationToCommentAuthor" Text="Send notification to author of comment when comment is approved or denied:" HelpText="Send notification to author of comment when comment is approved or denied." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbSendNotificationToCommentAuthor" runat="server" Text="Send notification" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblSendCommentNotificationToMediaUploader" runat="server" Text="Send new comment notification to media uploader:" HelpText="Send a notification to media uploader when new comment is added or approved." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbSendCommentNotificationToMediaUploader" runat="server" Text="Send notification" />
									</div>
								</td>
							</tr>
							<tr id="trCaptchaInfo" runat="server" visible="false">
								<td colspan="2">
									<asp:Label ID="lblCaptchaInfo" runat="server" Text="To enable Google ReCaptcha, please go to the API Connection control (Dasboard -> API settings) and enter your Google ReCaptcha keys."></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="label">
									<dnn:Label ID="lblUseGoogleRecaptchaOnComments" runat="server" Text="Use Google ReCaptcha:" HelpText="Use Google ReCaptcha service when adding new coments." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbUseGoogleRecaptchaOnComments" runat="server" Text="Use Google ReCaptcha" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlCacheSettings" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-refresh"></span>
					<asp:Label ID="lblCacheSettigns" resourcekey="lblCacheSettigns" runat="server" Text="Cache settings" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label">
									<dnn:Label ID="lblUseCache" ResourceKey="lblUseCache" runat="server" Text="Use cache:" HelpText="Cache data to improve performance." />
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbUseCache" runat="server" Visible="True" Checked="True" Text="Use cache" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlPermissionWrapper" runat="server" CssClass="settingsGroup edgDisplaySettings aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-shield"></span>
					<asp:Label ID="lblSetupPermissions" resourcekey="lblSetupPermissions" runat="server" Text="Permissions" />
				</h4>
			</div>
			<asp:GridView ID="gvRolePermisionSettings" runat="server" CssClass="permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="RoleID" CellPadding="0" OnRowDataBound="gvRolePermisionSettings_RowDataBound">
				<AlternatingRowStyle CssClass="second" />
				<Columns>
					<asp:TemplateField HeaderText="Roles">
						<ItemTemplate>
							<p>
								<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("RoleName")%>'></asp:Label>
							</p>
						</ItemTemplate>
						<HeaderStyle CssClass="header_cell" />
						<ItemStyle CssClass="subjectName" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Show comments">
						<ItemTemplate>
							<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# GetRoleID(Eval("RoleID"))%>' />
							<asp:HiddenField ID="hfRoleName" runat="server" Value='<%# Eval("RoleName") %>' />
							<asp:CheckBox ID="cbShowComments" runat="server" Checked='<%#Convert.ToBoolean(Eval("ShowComments"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable commenting">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToComment"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable comment editing">
						<ItemTemplate>
							<asp:CheckBox ID="cbCommentEditing" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentEditing"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable comment deleting">
						<ItemTemplate>
							<asp:CheckBox ID="cbCommentDeleting" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentDeleting"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Show rating">
						<ItemTemplate>
							<asp:CheckBox ID="cbShowrating" runat="server" Checked='<%#Convert.ToBoolean(Eval("Showrating"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable rating">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToRate" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToRate"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable Liking">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToLike" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToLike"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable download">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToDownload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToDownload"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable upload">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToUpload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToUpload"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Approve">
						<ItemTemplate>
							<asp:CheckBox ID="cbApprove" runat="server" Checked='<%#Convert.ToBoolean(Eval("Approve"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
			<asp:GridView ID="gvUserPermisionSettings" runat="server" CssClass="permissionsNotifications" AutoGenerateColumns="False" DataKeyNames="UserID" CellPadding="0" OnRowCommand="gvUserNotificationSettings_RowCommand">
				<AlternatingRowStyle CssClass="second" />
				<Columns>
					<asp:TemplateField HeaderText="Users">
						<ItemTemplate>
							<p>
								<asp:Label ID="lblUserName" runat="server" Text='<%#Eval("UserName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
							</p>
						</ItemTemplate>
						<HeaderStyle CssClass="header_cell" />
						<ItemStyle CssClass="subjectName" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Show comments">
						<ItemTemplate>
							<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
							<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
							<asp:CheckBox ID="cbShowComments" runat="server" Checked='<%#Convert.ToBoolean(Eval("ShowComments"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable commenting">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToComment" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToComment"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable comment editing">
						<ItemTemplate>
							<asp:CheckBox ID="cbCommentEditing" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentEditing"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable comment deleting">
						<ItemTemplate>
							<asp:CheckBox ID="cbCommentDeleting" runat="server" Checked='<%#Convert.ToBoolean(Eval("CommentDeleting"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Show rating">
						<ItemTemplate>
							<asp:CheckBox ID="cbShowrating" runat="server" Checked='<%#Convert.ToBoolean(Eval("Showrating"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable rating">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToRate" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToRate"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable Liking">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToLike" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToLike"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable download">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToDownload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToDownload"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Enable upload">
						<ItemTemplate>
							<asp:CheckBox ID="cbAllowToUpload" runat="server" Checked='<%#Convert.ToBoolean(Eval("AllowToUpload"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Approve">
						<ItemTemplate>
							<asp:CheckBox ID="cbApprove" runat="server" Checked='<%#Convert.ToBoolean(Eval("Approve"))%>' />
						</ItemTemplate>
					</asp:TemplateField>
					<asp:TemplateField HeaderText="">
						<ItemTemplate>
							<asp:LinkButton ID="lbUserPermissionsRemove" resourcekey="lbUserPermissionsRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user notifications?');"
								Text="Remove"></asp:LinkButton>
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
			<table style="margin: 10px 0; width: 100%;">
				<tr>
					<td colspan="2" style="text-align: center">
						<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" ForeColor="Red" />
					</td>
				</tr>
				<tr>
					<td style="text-align: right;">
						<asp:Label ID="lblUsernameToAdd" resourcekey="lblUsernameToAdd" runat="server" Text="Add user by username:" Font-Bold="True" />
					</td>
					<td style="text-align: left; padding-left: 10px;">
						<asp:TextBox ID="tbUserNameToAdd" runat="server" />
						<asp:LinkButton ID="lbUsernameAddPermissions" resourcekey="lbUsernameAddPermissions" runat="server" Text="Add" OnClick="lbUsernameAddPermissions_Click" />
					</td>
				</tr>
			</table>
		</asp:Panel>
		<asp:Label ID="lblSaveMessage" runat="server" EnableViewState="False" CssClass="infoMessages success" Visible="false" />
		<div class="mainActions">
			<asp:LinkButton ID="btnSaveGravityGallerySettings" resourcekey="btnSaveGravityGallerySettings" runat="server" Text="Save" OnClick="btnSaveGravityGallerySettings_Click" ValidationGroup="vgGravitySaveSettings" OnClientClick="return validateSettings();" CssClass="downSave" />
			<asp:LinkButton ID="btnSaveCloseGravityGallerySettings" resourcekey="btnSaveCloseGravityGallerySettings" runat="server" Text="Save &amp; Close" OnClick="btnSaveCloseGravityGallerySettings_Click" ValidationGroup="vgGravitySaveSettings" OnClientClick="return validateSettings()" CssClass="downSaveClose" />
			<asp:LinkButton ID="btnCancelSaveGravitySettings" resourcekey="btnCancelSaveGravitySettings" runat="server" Text="Close" OnClick="btnCancelSaveGravitySettings_Click" ValidationGroup="vgGravitySaveSettings" CssClass="downClose" />
		</div>
		<div id="pnlSavePresets" runat="server" visible="false" class="aditionalOptions sectionBox">
			<div class="sectionBoxHeader small color5">
				<h4>
					<span class="fa fa-save"></span>
					<asp:Label ID="lblSavePresetsTitle" resourcekey="lblSavePresetsTitle" runat="server" Text="Save Preset" />
				</h4>
			</div>
			<div class="displayContent">
				<div class="displayContentTable">
					<table cellspacing="0" cellpadding="0" border="0">
						<tbody>
							<tr>
								<td class="label textTop">
									<dnn:Label ID="lblSaveCurrentSettingsAsPreset" runat="server" Text="Enter preset name:" HelpText="Enter preset name. The preset name will be also used as filename." Visible="True" ControlName="tbSavePreset" />
								</td>
								<td>
									<asp:TextBox ID="tbSavePreset" runat="server" CssClass="large"></asp:TextBox>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSavePreset" runat="server" OnClick="btnSavePreset_Click" Text="Save preset" CssClass="itemEditAdd" />
									</div>
								</td>
							</tr>
						</tbody>
					</table>
					<asp:Label ID="lblSavePresetMessage" runat="server" EnableViewState="False" CssClass="infoMessages success" Visible="false" />
				</div>
			</div>
		</div>
	</div>
</div>
<asp:Literal ID="ltMessage" runat="server" Text="" EnableViewState="False" Visible="False" />
<asp:ObjectDataSource ID="odsGallery" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCatGalleries">
	<SelectParameters>
		<asp:Parameter Name="CategoryID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
