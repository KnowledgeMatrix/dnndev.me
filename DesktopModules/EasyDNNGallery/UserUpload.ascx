<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.ViewEasyDNNGalleryUserUpload, App_Web_userupload.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script type="text/javascript">
	simpleFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: false
			},
			allowedExtensions: ['jpg', 'jpeg', 'gif', 'png', 'bmp'],
			allowPreviewThumbnails: true,
			onAllUploadsComplete: function () {
				document.getElementById('<%=btnSaveMultiImageUpload.ClientID%>').click();
			},
			localization: {
				'Queued': '<%=Localization.GetString("Queued.Text", this.LocalResourceFile)%>',
				'Retry': '<%=Localization.GetString("Retry.Text", this.LocalResourceFile)%>',
				'Cancel': '<%=Localization.GetString("Cancel.Text", this.LocalResourceFile)%>',
				'no preview avalible': '<%=Localization.GetString("NoPreviewAvalible.Text", this.LocalResourceFile)%>',
				'of': '<%=Localization.GetString("Of.Text", this.LocalResourceFile)%>',
				'Upload failed': '<%=Localization.GetString("Uploadfailed.Text", this.LocalResourceFile)%>'
			}
		}
	};
	simpleVideoFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: false
			},
			allowedExtensions: ['mov', 'mp4', 'flv', 'swf', '3gp'],
			allowPreviewThumbnails: false,
			onAllUploadsComplete: function () {
				document.getElementById('<%=btnSaveMultiVideoUpload.ClientID%>').click();
			},
			localization: {
				'Queued': '<%=Localization.GetString("Queued.Text", this.LocalResourceFile)%>',
				'Retry': '<%=Localization.GetString("Retry.Text", this.LocalResourceFile)%>',
				'Cancel': '<%=Localization.GetString("Cancel.Text", this.LocalResourceFile)%>',
				'no preview avalible': '<%=Localization.GetString("NoPreviewAvalible.Text", this.LocalResourceFile)%>',
				'of': '<%=Localization.GetString("Of.Text", this.LocalResourceFile)%>',
				'Upload failed': '<%=Localization.GetString("Uploadfailed.Text", this.LocalResourceFile)%>'
			}
		}
	};
	simpleWistiaFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: true
			},
			allowedExtensions: ['mov', 'mp4', 'flv', 'swf', '3gp'],
			allowPreviewThumbnails: false,
			onAllUploadsComplete: function () {
				document.getElementById('<%=btnSaveWistiaVideoUpload.ClientID%>').click();
			},
			onEachUploadComplete: function (response) {
				var $hiddenField = $('#<%=hfWistiaUploadedVideos.ClientID%>'),
					data = $hiddenField.data('wistiaUploads');

				if (!response.wistia)
					return;

				if (!data)
					data = [];

				data.push(response.wistia);

				$hiddenField
					.data('wistiaUploads', data)
					.val(JSON.stringify(data));
			},
			localization: {
				'Queued': '<%=Localization.GetString("Queued.Text", this.LocalResourceFile)%>',
				'Retry': '<%=Localization.GetString("Retry.Text", this.LocalResourceFile)%>',
				'Cancel': '<%=Localization.GetString("Cancel.Text", this.LocalResourceFile)%>',
				'no preview avalible': '<%=Localization.GetString("NoPreviewAvalible.Text", this.LocalResourceFile)%>',
				'of': '<%=Localization.GetString("Of.Text", this.LocalResourceFile)%>',
				'Upload failed': '<%=Localization.GetString("Uploadfailed.Text", this.LocalResourceFile)%>'
			}
		}
	};
	simpleAudioFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: false
			},
			allowedExtensions: ['mp3'],
			allowPreviewThumbnails: false,
			onAllUploadsComplete: function () {
				document.getElementById('<%=btnSaveMultiAudioUpload.ClientID%>').click();
			},
			localization: {
				'Queued': '<%=Localization.GetString("Queued.Text", this.LocalResourceFile)%>',
				'Retry': '<%=Localization.GetString("Retry.Text", this.LocalResourceFile)%>',
				'Cancel': '<%=Localization.GetString("Cancel.Text", this.LocalResourceFile)%>',
				'no preview avalible': '<%=Localization.GetString("NoPreviewAvalible.Text", this.LocalResourceFile)%>',
				'of': '<%=Localization.GetString("Of.Text", this.LocalResourceFile)%>',
				'Upload failed': '<%=Localization.GetString("Uploadfailed.Text", this.LocalResourceFile)%>'
			}
		}
	};
	var moduleId = "<%=ModuleId%>";
	var userId = "<%=UserId%>";
	<%=jQuery%>(document).ready(function ($) {
		if ('<%=useHtmlUpload%>' === 'True') {
			if ($('#<%=pnlImageUploadfineUploader.ClientID%>').length > 0) {
				eds1_10('#galleryImageFineUploaderContainer').edsFineUploader_1_3(simpleFineUploaderSettings());
			}
			else if ($('#<%=pnlVideoUploadfineUploader.ClientID%>').length > 0) {
				eds1_10('#galleryVideoFineUploaderContainer').edsFineUploader_1_3(simpleVideoFineUploaderSettings());
			}
			else if ($('#<%=pnlWistiaUploadfineUploader.ClientID%>').length > 0) {
				eds1_10('#galleryWistiaFineUploaderContainer').edsFineUploader_1_3(simpleWistiaFineUploaderSettings());
			}
			else if ($('#<%=pnlAudioUploadfineUploader.ClientID%>').length > 0) {
				eds1_10('#galleryAudioFineUploaderContainer').edsFineUploader_1_3(simpleAudioFineUploaderSettings());
			}
}
else {
	$('#<%=GalfileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
		'script': '<%=ModulePath%>UploadImages.ashx?portalid=<%=PortalId%>',
		'scriptData': { 'id': moduleId, 'id2': userId },
		'cancelImg': '<%=ModulePath%>images/cancel.png',
		'multi': true,
		'fileDesc': 'Image Files',
		'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
		'queueSizeLimit': 100,
		'buttonText': '<%=SelectImages%>',
		'onAllComplete': function (event, queueID, fileObj, response, data) {
			$(document).ready(function () {
				document.getElementById('<%=btnSaveMultiImageUpload.ClientID%>').click();
			});
		},
		'onError': function (event, queueID, fileObj, errorObj) {
			var msg;
			if (errorObj.status == 404) {
				alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
				msg = 'Could not find upload script.';
			} else if (errorObj.type === "HTTP")
				msg = errorObj.type + ": " + errorObj.status;
			else if (errorObj.type === "File Size")
				msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
			else
				msg = errorObj.type + ": " + errorObj.text;
			$.jGrowl('<p></p>' + msg, {
				theme: 'error',
				header: 'ERROR',
				sticky: true
			});
			$("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=GalfileInput.ClientID%>" + queueID).remove() });
			return false;
		},
		'onComplete': function (a, b, c, d, e) {
			var size = Math.round(c.size / 1024);
			$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
				theme: 'success',
				header: 'Upload Complete',
				life: 3000,
				sticky: false
			});
		}
	});
	$('#<%=MultiAudioFileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
		'script': '<%=ModulePath%>UploadAudio.ashx?portalid=<%=PortalId%>',
		'scriptData': { 'id': moduleId, 'id2': userId },
		'cancelImg': '<%=ModulePath%>images/cancel.png',
		'multi': true,
		'fileDesc': 'Video Files',
		'fileExt': '*.mp3',
		'queueSizeLimit': 100,
		'buttonText': '<%=SelectImages%>',
		'onAllComplete': function (event, queueID, fileObj, response, data) {
			document.getElementById('<%=btnSaveMultiAudioUpload.ClientID%>').click();
		},
		'onError': function (event, queueID, fileObj, errorObj) {
			var msg;
			if (errorObj.status == 404) {
				alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
				msg = 'Could not find upload script.';
			} else if (errorObj.type === "HTTP")
				msg = errorObj.type + ": " + errorObj.status;
			else if (errorObj.type === "File Size")
				msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
			else
				msg = errorObj.type + ": " + errorObj.text;
			$.jGrowl('<p></p>' + msg, {
				theme: 'error',
				header: 'ERROR',
				sticky: true
			});
			$("#<%=MultiAudioFileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=MultiAudioFileInput.ClientID%>" + queueID).remove() });
			return false;
		},
		'onComplete': function (a, b, c, d, e) {
			var size = Math.round(c.size / 1024);
			$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
				theme: 'success',
				header: 'Upload Complete',
				life: 3000,
				sticky: false
			});
		}
	});

	$('#<%=MultiVideoFileInput.ClientID%>').uploadify({
				'uploader': '<%=ModulePath%>js/uploadify.swf',
		'script': '<%=ModulePath%>UploadVideos.ashx?portalid=<%=PortalId%>',
		'scriptData': { 'id': moduleId, 'id2': userId },
		'cancelImg': '<%=ModulePath%>images/cancel.png',
		'multi': true,
		'fileDesc': 'Video Files',
		'fileExt': '*.mov;*.mp4;*.flv;*.swf;*.3gp',
		'queueSizeLimit': 100,
		'buttonText': '<%=SelectVideos%>',
		'onAllComplete': function (event, queueID, fileObj, response, data) {
			document.getElementById('<%=btnSaveMultiVideoUpload.ClientID%>').click();
		},
		'onError': function (event, queueID, fileObj, errorObj) {
			var msg;
			if (errorObj.status == 404) {
				alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
				msg = 'Could not find upload script.';
			} else if (errorObj.type === "HTTP")
				msg = errorObj.type + ": " + errorObj.status;
			else if (errorObj.type === "File Size")
				msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
			else
				msg = errorObj.type + ": " + errorObj.text;
			$.jGrowl('<p></p>' + msg, {
				theme: 'error',
				header: 'ERROR',
				sticky: true
			});
			$("#<%=MultiVideoFileInput.ClientID%>" + queueID).fadeOut(250, function () { $("#<%=MultiVideoFileInput.ClientID%>" + queueID).remove() });
			return false;
		},
		'onComplete': function (a, b, c, d, e) {
			var size = Math.round(c.size / 1024);
			$.jGrowl('<p></p>' + c.name + ' - ' + size + 'KB', {
				theme: 'success',
				header: 'Upload Complete',
				life: 3000,
				sticky: false
			});
		}
	});
}
	});
</script>
<div id="mainUpload" runat="server">
	<div id="EDGAdminContent">
		<asp:Panel ID="pnlMainTopNavigation" runat="server">
			<div class="topBarWrapper">
				<div class="wrapper">
					<ul class="links">
						<li runat="server" id="liMainSectiontext">
							<asp:Label runat="server" ID="lblManagmentSectionTitle" Text="User Upload"></asp:Label></li>
					</ul>
					<ul class="actions">
						<li class="close">
							<asp:LinkButton ID="btnClose" runat="server" OnClick="btnCloseMM_Click" Text="Close" resourcekey="btnCloseResource1" />
						</li>
					</ul>
				</div>
			</div>
		</asp:Panel>
		<div class="mainContentWrapper">
			<div class="contentSectionWrapper color3">
				<asp:Panel ID="pnlMediaUpload" runat="server">
					<ul class="mediaSelect">
						<li class="imageUpload">
							<asp:LinkButton ID="lbImageUpload" runat="server" OnClick="lbImageUpload_Click" Visible="False" CssClass="active" Text="Images" resourcekey="lbImageUploadResource1" />
						</li>
						<li class="videoUpload">
							<asp:LinkButton ID="btnVideoFiles" runat="server" OnClick="btnVideoFiles_Click" Visible="False" Text="Video files" resourcekey="lbUserUploadVideo" />
						</li>
						<li class="videoUpload">
							<asp:LinkButton ID="lbVideoUpload" runat="server" OnClick="lbVideoUpload_Click" Visible="False" Text="Embed video" resourcekey="lbVideoUploadResource1" />
						</li>
						<li class="audioUpload">
							<asp:LinkButton ID="lbAudioUpload" runat="server" OnClick="lbAudioUpload_Click" Visible="False" Text="Audio" resourcekey="lbAudioUploadResource1" />
						</li>
					</ul>
					<asp:Panel ID="pnlImageUpload" runat="server" Visible="False" CssClass="contentSection imageUpload">
						<div class="specialOptions">
							<h2>
								<asp:Label ID="lblAddImages" resourcekey="lblAddImages" runat="server" Text="Add&lt;br&gt;images"></asp:Label>
							</h2>
							<div class="optionsList">
								<asp:RadioButtonList ID="rblImageUploadType" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblUpload_SelectedIndexChanged" RepeatDirection="Horizontal">
									<asp:ListItem resourcekey="lbSingleImageUploadResource1" Value="single">Upload single image</asp:ListItem>
									<asp:ListItem resourcekey="lbMultiImageUploadResource1" Value="multi" Selected="True">Multi image upload</asp:ListItem>
								</asp:RadioButtonList>
							</div>
						</div>
						<asp:Panel ID="pnlSingleImageUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblSingleImageTitle" runat="server" Text="Single image upload" resourcekey="lblSingleImageTitleResource1" CssClass="singleImageUplad"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSingleImageUploadTitle" runat="server" HelpKey="lblSingleImageUploadTitle.HelpText" HelpText="Enter the image title:" Text="Image title:" ResourceKey="lblSingleImageUploadTitle" />
										</td>
										<td>
											<div id="SIUTitleTextBox" runat="server">
												<asp:TextBox ID="tbImageTitle" runat="server" MaxLength="250" ValidationGroup="Validationg1" resourcekey="tbImageTitleResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="DivUseFilenameCB" runat="server" class="styledCheckbox">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSingleImageUploadFilenameAsTitle" runat="server" AutoPostBack="True" OnCheckedChanged="cbIUFilenameAsTitle_CheckedChanged" Text="Use filename as title" resourcekey="cbSingleImageUploadFilenameAsTitleResource1" />
												</div>
											</div>
											<div id="SIUTitleFeomFilename" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSingleImageUploadRemoveExtenzion" runat="server" Text="Remove extension" resourcekey="cbSingleImageUploadRemoveExtenzionResource1" />
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSingleImageUploadTitleReplaceUnderscore" runat="server" Text="Set this to replace &quot;_&quot; with blank space in title" resourcekey="cbSingleImageUploadTitleReplaceUnderscoreResource1" />
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSinbleImageUploadTitleReplaceMinus" runat="server" Text="Set this to replace &quot;-&quot; with blank space in title" resourcekey="cbSinbleImageUploadTitleReplaceMinusResource1" />
												</div>
												<asp:RadioButtonList ID="rblSingleImageUploadFilenameTitleOptions" runat="server" CssClass="styledRadio small">
													<asp:ListItem Text="Set this to change title to uppercase" Value="AllUppercase" resourcekey="ListItemResource1"></asp:ListItem>
													<asp:ListItem Text="Set this to change title to lowercase" Value="AllLowercase" resourcekey="ListItemResource2"></asp:ListItem>
													<asp:ListItem Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase" resourcekey="ListItemResource3">
													</asp:ListItem>
													<asp:ListItem Text="Set this to change first letter of title to uppercase" Value="FirstUppercase" resourcekey="ListItemResource4">
													</asp:ListItem>
												</asp:RadioButtonList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="DivUseExifMetada" runat="server">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSingleImageUploadTitleUseMetadata" runat="server" AutoPostBack="True" OnCheckedChanged="cbSingleImageUploadTitleUseMetadata_CheckedChanged" Text="Use Exif metadata as title" resourcekey="cbSingleImageUploadTitleUseMetadataResource1" />
												</div>
											</div>
											<div id="DivSIUseExifMetadata" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cblSingleImageUploadTitleUseMetadataOptions" runat="server">
														<asp:ListItem Text="Artist" resourcekey="ListItemResource5">
														</asp:ListItem>
														<asp:ListItem Text="Copyright" resourcekey="ListItemResource6">
														</asp:ListItem>
														<asp:ListItem Text="Image description" Value="ImageDescription" resourcekey="ListItemResource7">
														</asp:ListItem>
														<asp:ListItem Text="Make" resourcekey="ListItemResource8">
														</asp:ListItem>
														<asp:ListItem Text="Model" resourcekey="ListItemResource9">
														</asp:ListItem>
														<asp:ListItem Text="Subject location" Value="SubjectLocation" resourcekey="ListItemResource10">
														</asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSingleImageUploadDescription" runat="server" HelpKey="lblSingleImageUploadDescription.HelpText" HelpText="Enter the image description." Text="Description:" ResourceKey="lblSingleImageUploadDescription" />
										</td>
										<td>
											<div id="DivSIDescriptionTextBox" runat="server">
												<asp:TextBox ID="tbImageDescription" runat="server" Height="150px" MaxLength="4000" TextMode="MultiLine" resourcekey="tbImageDescriptionResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="DivSIUseMetadataDescription" runat="server">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbSingleImageUploadseExifMetadataDescription" runat="server" AutoPostBack="True" OnCheckedChanged="cbSingleImageUploadseExifMetadataDescription_CheckedChanged" Text="Use Exif metadata as description" resourcekey="cbSingleImageUploadseExifMetadataDescriptionResource1" />
												</div>
											</div>
											<div id="DivSIUseExifMetadataDescriptionOptions" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cbSingleImageUploadseExifMetadataDescriptionOptions" runat="server">
														<asp:ListItem Text="Artist" resourcekey="ListItemResource11">
														</asp:ListItem>
														<asp:ListItem Text="Copyright" resourcekey="ListItemResource12">
														</asp:ListItem>
														<asp:ListItem Text="Image description" Value="ImageDescription" resourcekey="ListItemResource13">
														</asp:ListItem>
														<asp:ListItem Text="Make" resourcekey="ListItemResource14">
														</asp:ListItem>
														<asp:ListItem Text="Model" resourcekey="ListItemResource15">
														</asp:ListItem>
														<asp:ListItem Text="Subject location" Value="SubjectLocation" resourcekey="ListItemResource16">
														</asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSingleUmageUploadUrl" runat="server" HelpKey="lblSingleUmageUploadUrl.HelpText" HelpText="Enter url for media link:" ResourceKey="lblSingleUmageUploadUrl" Text="Enter url:" />
										</td>
										<td>
											<asp:TextBox ID="tbSIImageUrl" runat="server" resourcekey="tbSIImageUrlResource1" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblSingleImageUploadSelectFile" runat="server" HelpKey="lblSingleImageUploadSelectFile.HelpText" HelpText="Select image file to upload:" Text="Image file to upload:" />
										</td>
										<td>
											<asp:FileUpload ID="fuImageUpload" runat="server" Height="25px" BorderStyle="None" CssClass="boxline" />
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblSingleImageUploadMessage" runat="server" CssClass="image_upload_message" EnableViewState="False" resourcekey="lblMessageResource1" AssociatedControlID="btnSingleImageUpload"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions color1">
									<asp:Label ID="lblFileName" runat="server" Visible="False" resourcekey="lblFileNameResource1"></asp:Label>
									<asp:HiddenField ID="hfMainSelectedCategory" runat="server" />
									<asp:Label ID="lblSelectedDataKey2" runat="server" Visible="False"></asp:Label>
									<asp:LinkButton ID="btnSingleImageUpload" runat="server" OnClick="btnUploadImage_Click" Text="Upload image file" ValidationGroup="vgImageUpload" CausesValidation="False" resourcekey="btnSingleImageUploadResource1" CssClass="upload" />
								</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlMultiImageUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblMultimageUploadMainTitle" runat="server" CssClass="multiImageUplad" resourcekey="lblMultiImageUploadResource1" Text="Multi image upload"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiImageUploadTitle" runat="server" HelpKey="lblSingleImageUploadTitle.HelpText" HelpText="Enter the image title:" Text="Image title:" ResourceKey="lblSingleImageUploadTitle" />
										</td>
										<td>
											<div id="MIUTitleTextBox" runat="server">
												<asp:TextBox ID="tbMultiImageTitle" runat="server" MaxLength="250" ValidationGroup="Validationg1" resourcekey="tbMultiImageTitleResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="MultiDivUseFilenameCB" runat="server">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadFilenameAsTitle" runat="server" AutoPostBack="True" OnCheckedChanged="cbMultiImageUploadFilenameAsTitle_CheckedChanged" Text="Use filename as title" resourcekey="cbMultiImageUploadFilenameAsTitleResource1" />
												</div>
											</div>
											<div id="MIUTitleFeomFilename" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadRemoveExtenzion" runat="server" Text="Remove extension" resourcekey="cbMultiImageUploadRemoveExtenzionResource1" />
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadTitleReplaceUnderscore" runat="server" Text="Set this to replace &quot;_&quot; with blank space in title" resourcekey="cbMultiImageUploadTitleReplaceUnderscoreResource1" />
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadTitleReplaceMinus" runat="server" Text="Set this to replace &quot;-&quot; with blank space in title" resourcekey="cbMultiImageUploadTitleReplaceMinusResource1" />
												</div>
												<asp:RadioButtonList ID="rblMultiImageUploadFilenameTitleOptions" runat="server" CssClass="styledRadio small">
													<asp:ListItem Text="Set this to change title to uppercase" Value="AllUppercase" resourcekey="ListItemResource17"></asp:ListItem>
													<asp:ListItem Text="Set this to change title to lowercase" Value="AllLowercase" resourcekey="ListItemResource18"></asp:ListItem>
													<asp:ListItem Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase" resourcekey="ListItemResource19"></asp:ListItem>
													<asp:ListItem Text="Set this to change first letter of title to uppercase" Value="FirstUppercase" resourcekey="ListItemResource20">
													</asp:ListItem>
												</asp:RadioButtonList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="MultiDivUseExifMetada" runat="server">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadTitleUseMetadata" runat="server" AutoPostBack="True" OnCheckedChanged="cbMultiImageUploadTitleUseMetadata_CheckedChanged" Text="Use Exif metadata as title" resourcekey="cbMultiImageUploadTitleUseMetadataResource1" />
												</div>
											</div>
											<div id="MultiDivSIUseExifMetadata" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cblMultiImageUploadTitleUseMetadataOptions" runat="server">
														<asp:ListItem Text="Artist" resourcekey="ListItemResource21"></asp:ListItem>
														<asp:ListItem Text="Copyright" resourcekey="ListItemResource22"></asp:ListItem>
														<asp:ListItem Text="Image description" Value="ImageDescription" resourcekey="ListItemResource23"></asp:ListItem>
														<asp:ListItem Text="Make" resourcekey="ListItemResource24"></asp:ListItem>
														<asp:ListItem Text="Model" resourcekey="ListItemResource25"></asp:ListItem>
														<asp:ListItem Text="Subject location" Value="SubjectLocation" resourcekey="ListItemResource26"></asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiImageUploadDescription" runat="server" HelpKey="lblSingleImageUploadDescription.HelpText" HelpText="Enter the image description." Text="Description:" ResourceKey="lblMultiImageUploadDescription" />
										</td>
										<td>
											<div id="DivMIDescriptionTextBox" runat="server">
												<asp:TextBox ID="tbMultiImageDescription" runat="server" Height="150px" MaxLength="4000" TextMode="MultiLine" resourcekey="tbMultiImageDescriptionResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="DivMIUseMetadataDescription" runat="server">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiImageUploadseExifMetadataDescription" runat="server" AutoPostBack="True" OnCheckedChanged="cbMultiImageUploadseExifMetadataDescription_CheckedChanged" Text="Use Exif metadata as description" resourcekey="cbMultiImageUploadseExifMetadataDescriptionResource1" />
												</div>
											</div>
											<div id="DivMIUseExifMetadataDescriptionOptions" runat="server" style="display: none">
												<div class="styledCheckbox">
													<asp:CheckBoxList ID="cbMultiImageUploadseExifMetadataDescriptionOptions" runat="server">
														<asp:ListItem Text="Artist" resourcekey="ListItemResource27">
														</asp:ListItem>
														<asp:ListItem Text="Copyright" resourcekey="ListItemResource28">
														</asp:ListItem>
														<asp:ListItem Text="Image description" Value="ImageDescription" resourcekey="ListItemResource29">
														</asp:ListItem>
														<asp:ListItem Text="Make" resourcekey="ListItemResource30">
														</asp:ListItem>
														<asp:ListItem Text="Model" resourcekey="ListItemResource31">
														</asp:ListItem>
														<asp:ListItem Text="Subject location" Value="SubjectLocation" resourcekey="ListItemResource32">
														</asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiUmageUploadUrl" runat="server" HelpKey="lblUmageUploadUrl.HelpText" HelpText="Enter url for media link:" Text="Enter url:" ResourceKey="lblUmageUploadUrl" />
										</td>
										<td>
											<asp:TextBox ID="tbMIImageUrl" runat="server" Width="300px" resourcekey="tbMIImageUrlResource1" CssClass="boxline">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblMultiImageUploadMessage" runat="server" CssClass="image_upload_message" EnableViewState="False" resourcekey="lblMessageResource1"></asp:Label>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<asp:Label ID="lblFileName0" runat="server" Visible="False" resourcekey="lblFileName0Resource1"></asp:Label>
											<asp:Panel ID="pnlImageUploadUploadify" runat="server">
												<table align="center" cellpadding="0" cellspacing="0">
													<tr>
														<td>
															<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
																<asp:FileUpload ID="GalfileInput" runat="server" CssClass="boxline" />
															</div>
															<div style="display: block; float: left; margin-left: 15px;">
																<a class="btnUpload" href="javascript:<%=jQuery%>('#<%=GalfileInput.ClientID%>').uploadifySettings('scriptData', { 'foo': '<%=DirToSave%>'});<%=jQuery%>('#<%=GalfileInput.ClientID%>').uploadifyUpload();">
																	<%=startUpload%></a> <a class="clearqueue" href="javascript:<%=jQuery%>('#<%=GalfileInput.ClientID%>').uploadifyClearQueue();">
																		<%=ClearQueue%>
																	</a>
															</div>
															<br />
														</td>
													</tr>
												</table>
											</asp:Panel>
											<asp:Panel ID="pnlImageUploadfineUploader" runat="server" Visible="False">
												<div id="galleryImageFineUploaderContainer" class="EDS_simpleFineUploader">
													<div class="uploader">
													</div>
													<div class="uploadControls">
														<div class="actions">
															<span class="action fileSelection">
																<asp:Label ID="galleryFineUploaderSelectFiles" runat="server" resourcekey="fineUploaderSelectFiles" Text="Select images" />
																<span class="dnnInputFileWrapper">
																	<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
																		<asp:Label ID="galleryFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
																	</span>
														</div>
														<div class="dndContainer">
															<p>
																<asp:Label ID="galleryFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
															</p>
														</div>
													</div>
													<div class="uploadDetails">
														<ol class="fileUploadList">
														</ol>
													</div>
												</div>
											</asp:Panel>
											<div style="display: none; line-height: 0pt;">
												<asp:Button ID="btnSaveMultiImageUpload" runat="server" OnClick="MultiImageUpload" Text="Save" resourcekey="btnSaveMultiImageUploadResource1" />
											</div>
										</td>
									</tr>
								</table>
							</div>
						</asp:Panel>
					</asp:Panel>
					<asp:Panel ID="pnlVideoFiles" runat="server" Visible="False" CssClass="contentSection videoUpload">
						<div class="specialOptions">
							<h2>
								<asp:Label ID="lblAddVideo" resourcekey="lblAddVideo" runat="server" Text="Add&lt;br&gt;video"></asp:Label>
							</h2>
							<div class="optionsList">
								<asp:RadioButtonList ID="rblVideoUploadTypeSelect" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblVideoUpload_SelectedIndexChanged" RepeatDirection="Horizontal">
									<asp:ListItem resourcekey="lbUserUploadMultiVideoUpload" Value="MultiVideoUpload" Selected="True">Multi video upload</asp:ListItem>
									<asp:ListItem resourcekey="lbUserUploadSingleVideoUpload" Value="SingleVideoUpload">Single video upload</asp:ListItem>
									<asp:ListItem resourcekey="lbUserUploadAmazonS3" Value="Amazons3">Amazon S3</asp:ListItem>
									<asp:ListItem Value="wistia">Wistia</asp:ListItem>
								</asp:RadioButtonList>
							</div>
						</div>
						<asp:Panel ID="pnlWistiaVideoUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblUploadToWistiaTopTitle" runat="server" Text="Upload video to Wistia" CssClass="uploadToWistia"></asp:Label>
							</h4>
							<table>
								<tr>
									<td class="labels">
										<dnn:Label ID="lblWistiaUploadVideoTitle" runat="server" HelpText="Enter the title of video file:" Text="Video title:" />
									</td>
									<td>
										<div id="divWistiaVideoTitle" runat="server">
											<asp:TextBox ID="tbWistiaVideoTitle" runat="server" CssClass="large"></asp:TextBox>
										</div>
									</td>
								</tr>
								<tr>
									<td class="labels"></td>
									<td>
										<div class="styledCheckbox">
											<asp:CheckBox ID="cbWistiaUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
										</div>
										<div id="divWistiaFilenameAsTitle" runat="server" style="display: none">
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbWistiaVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
											</div>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbWistiaVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
											</div>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbWistiaVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
											</div>
											<asp:RadioButtonList ID="rblWistiaVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
												<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every  word in title to uppercase" Value="AllFirstUppercase">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase">
												</asp:ListItem>
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
								<tr>
									<td class="labels">
										<dnn:Label ID="lblWistiaVideoUploadSubstitle" runat="server" Text="Subtitle:" HelpText="Enter subtitle for video."></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbWistiaVideoUploadSubstitle" runat="server" MaxLength="2000" CssClass="large"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td class="labels">
										<dnn:Label ID="lblWistiaVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
									</td>
									<td>
										<asp:TextBox ID="tbWistiaVideoDescription" runat="server" Height="150px" MaxLength="4000" TextMode="MultiLine" CssClass="large">
										</asp:TextBox>
									</td>
								</tr>
								<tr>
									<td class="labels">
										<dnn:Label ID="lblWistiaUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
									</td>
									<td>
										<asp:TextBox ID="tbWistiaVideoWidth" runat="server" ValidationGroup="vgWistiaVideoUpload" Width="50px">640</asp:TextBox>
										<asp:CompareValidator ID="cvWistiaVideoUploadWidth" runat="server" ControlToValidate="tbWistiaVideoWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgWistiaVideoUpload">
										</asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="labels">
										<dnn:Label ID="lblWistiaVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
									</td>
									<td>
										<asp:TextBox ID="tbWistiaVideoHeight" runat="server" Width="50px" ValidationGroup="vgWistiaVideoUpload">360</asp:TextBox>
										<asp:CompareValidator ID="cvWistiaVideoUploadHeight" runat="server" ControlToValidate="tbWistiaVideoHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgWistiaVideoUpload">
										</asp:CompareValidator>
									</td>
								</tr>
								<tr>
									<td class="labels"></td>
									<td>
										<asp:RadioButtonList ID="rblWistiaVideoThumbnail" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblWistiaVideoThumbnail_SelectedIndexChanged" CssClass="styledRadio small">
											<asp:ListItem Selected="True" Value="autocreate" Text="Auto create thumbnail" ResourceKey="ListItemResource90"></asp:ListItem>
											<asp:ListItem Value="upload" Text="Upload thumbnail" resourcekey="ListItemResource91"></asp:ListItem>
											<asp:ListItem Value="standard" Text="Use standard image" resourcekey="ListItemResource92"></asp:ListItem>
										</asp:RadioButtonList>
										<div id="divWistiaUploadThumbnail" runat="server" style="display: none">
											<asp:FileUpload ID="fuWistiaUploadThumbnail" runat="server" Width="300px" />
											<br />
										</div>
										<div id="divWistiaStandardThumbnail" runat="server" style="display: none">
											<asp:DropDownList ID="ddlWistiaVideoThumbSelect" runat="server" OnLoad="ddlWistiaVideoThumbSelect_Load" CausesValidation="True">
											</asp:DropDownList>
										</div>
									</td>
								</tr>
								<tr>
									<td class="labels"></td>
									<td>
										<asp:Label ID="lblWistiaUploadMessage" runat="server" EnableViewState="False"></asp:Label>
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlWistiaUploadSingleVideo" runat="server">
								<table>
									<tr>
										<asp:Label ID="lblWistiaSingleUploadMessage" runat="server" CssClass="subtitleregion" EnableViewState="False"></asp:Label>
									</tr>
									<tr>
										<td>
											<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
												<asp:FileUpload ID="fuWistiaVideoFileInput" runat="server" EnableTheming="True" />
											</div>
											<div style="display: block; float: left; margin-left: 15px;">
												<asp:Button ID="btnWistiaSingleUpload" runat="server" Text="Upload to Wistia" OnClick="btnWistiaSingleUpload_Click" />
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlWistiaUploadfineUploader" runat="server" Visible="False">
								<div id="galleryWistiaFineUploaderContainer" class="EDS_simpleFineUploader">
									<div class="uploader">
									</div>
									<div class="uploadControls">
										<div class="actions">
											<span class="action fileSelection">
												<asp:Label ID="galleryWistiaFineUploaderSelectFiles" runat="server" resourcekey="fineVideoUploaderSelectFiles" Text="Select videos" />
												<span class="dnnInputFileWrapper">
													<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
														<asp:Label ID="galleryWistiaFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
													</span>
										</div>
										<div class="dndContainer">
											<p>
												<asp:Label ID="galleryWistiaFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
											</p>
										</div>
									</div>
									<div class="uploadDetails">
										<ol class="fileUploadList">
										</ol>
									</div>
								</div>
								<asp:HiddenField ID="hfWistiaUploadedVideos" runat="server" Value="" EnableViewState="False" />
							</asp:Panel>
							<div style="display: none; line-height: 0pt;">
								<asp:Button ID="btnSaveWistiaVideoUpload" runat="server" OnClick="WistiaMultiVideoUpload" Text="Save" />
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlAmazonS3VideoAupload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblAmazonS3Title" runat="server" resourcekey="lblAmazonS3Title" Text="Amazon S3" CssClass="amazonS3"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonUploadVideoURL" runat="server" HelpKey="lblAmazonUploadVideoURL.HelpText" HelpText="Aamazon S3 video URL link." ResourceKey="lblAmazonUploadVideoURL" Text="Aamazon S3 video URL link:" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonVideoURL" runat="server" ValidationGroup="vgAmazonVideoUpload" CssClass="large"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvAmazonVideoURL" runat="server" ControlToValidate="tbAmazonVideoURL" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="vgAmazonVideoUpload">
											</asp:RequiredFieldValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonUploadVideoTitle" runat="server" HelpKey="lblAmazonUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblAmazonUploadVideoTitle" Text="Video title:" />
										</td>
										<td>
											<div id="divAmazonVideoTitle" runat="server">
												<asp:TextBox ID="tbAmazonVideoTitle" runat="server" resourcekey="tbFlashTitleResource1" CssClass="large"></asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbAmazonUploadFilenameAsTitle" runat="server" OnCheckedChanged="cbAmazonUploadFilenameAsTitle_CheckedChanged" resourcekey="cbAmazonVideoUploadFilenameAsTitleResource1" Text="Use filename as title" AutoPostBack="True" />
											</div>
											<div id="divAmazonFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlVUFilenameasTitle0" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbAmazonVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbAmazonVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbAmazonVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblAmazonVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="AmazonListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="AmazonListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="AmazonListItemResource81" Text="Set this to change first letter of every word in title to uppercase"
															Value="AllFirstUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="AmazonListItemResource82" Text="Set this to change first letter of title to uppercase"
															Value="FirstUppercase">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonVideoUploadDescription" runat="server" HelpKey="lblAmazonVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblAmazonVideoUploadDescription" Text="Description:" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonVideoDescription" runat="server" Height="150px" MaxLength="4000" resourcekey="tbFlashDescriptionResource1" TextMode="MultiLine" CssClass="large"></asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblAmazonVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblAmazonVideoUploadWidth" Text="Video width:" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonVideoWidth" runat="server" resourcekey="tbFlashWidthResource1" ValidationGroup="vgAmazonVideoUpload" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvAmazonVideoUploadWidth" runat="server" ControlToValidate="tbAmazonVideoWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAmazonVideoUpload">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblAmazonVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblAmazonVideoUploadHeight" Text="Video height:" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonVideoHeight" runat="server" resourcekey="tbFlashHeightResource1" ValidationGroup="vgAmazonVideoUpload" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvAmazonVideoUploadHeight" runat="server" ControlToValidate="tbAmazonVideoHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAmazonVideoUpload">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
										</td>
										<td>
											<asp:RadioButtonList ID="rblAmazonVideoThumbnailSelect" runat="server" OnLoad="rblFlashThumbnail_Load" OnSelectedIndexChanged="rblAmazonVideoThumbnailSelect_SelectedIndexChanged" RepeatDirection="Horizontal" AutoPostBack="True" CssClass="styledRadio small">
												<asp:ListItem resourcekey="AmazonListItemResource83" Selected="True" Text="Use standard image" Value="standard">
												</asp:ListItem>
												<asp:ListItem resourcekey="AmazonListItemResource84" Text="Upload" Value="Upload">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divAmazonStandardImage" runat="server">
												<asp:Label ID="lblAmazonVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
												&nbsp;<asp:DropDownList ID="ddlAmazobVideoThumbSelect" runat="server" OnLoad="ddlAmazobVideoThumbSelect_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td class="style23">
											<div id="divAmazonUploadThumb" runat="server" style="display: none">
												<asp:Label ID="lblVideoUploadSelectThumbnailToUpload0" runat="server" resourcekey="lblAmazonVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
												&nbsp;
															<asp:FileUpload ID="fuAmazonThumbnail" runat="server" Width="322px" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblAmazonUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions">
												<asp:LinkButton ID="btnAmazonVideoUpload" runat="server" OnClick="btnAmazonVideoUpload_Click" resourcekey="btnAmazonVideoUpload" Text="Upload" ValidationGroup="vgAmazonVideoUpload" CssClass="upload" />
											</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlSingleVideoUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblSingleVideoUploadTitle" resourcekey="lblSingleVideoUploadTitle" runat="server" Text="Single video upload" class="videoUpload"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadVideoTitle" runat="server" HelpKey="lblVideoUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblVideoUploadVideoTitle" Text="Video title:" />
										</td>
										<td>
											<div id="divVideoTitle" runat="server">
												<asp:TextBox ID="tbFlashTitle" runat="server" resourcekey="tbFlashTitleResource1" Width="300px" CssClass="large"></asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbVideoUploadFilenameAsTitle" runat="server" AutoPostBack="True" OnCheckedChanged="cbvUFilenameAsTitle_CheckedChanged" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
											</div>
											<div id="divVUFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlVUFilenameasTitle" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<asp:CheckBox ID="cbVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
										</td>
										<td>
											<asp:TextBox ID="tbFlashDescription" runat="server" Height="150px" MaxLength="4000" resourcekey="tbFlashDescriptionResource1" TextMode="MultiLine" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
										</td>
										<td>
											<asp:TextBox ID="tbFlashWidth" runat="server" resourcekey="tbFlashWidthResource1" ValidationGroup="vgVideoUpload" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvVideoUploadWidth" runat="server" ControlToValidate="tbFlashWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
										</td>
										<td>
											<asp:TextBox ID="tbFlashHeight" runat="server" resourcekey="tbFlashHeightResource1" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvVideoUploadheight" runat="server" ControlToValidate="tbFlashHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
										</td>
										<td class="style232">
											<asp:RadioButtonList ID="rblVideoThumbnailSelect" runat="server" AutoPostBack="True" OnLoad="rblFlashThumbnail_Load" OnSelectedIndexChanged="rblVideoThumbnailSelect_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
												<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divVUStandardImage" runat="server">
												<asp:Label ID="lblVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
												&nbsp;<asp:DropDownList ID="ddlVUThumbSelect" runat="server" OnLoad="dllVUThumbSelect_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divVUUploadThumb" runat="server" style="display: none">
												<asp:Label ID="lblVideoUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
												&nbsp;
															<asp:FileUpload ID="fuFlashThumbnail" runat="server" Width="322px" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblVideoUploadFileSelect" runat="server" HelpKey="lblVideoUploadFileSelect.HelpText" HelpText="Select the file to upload:" ResourceKey="lblVideoUploadFileSelect" Text="Please select the file to upload:" />
										</td>
										<td>
											<asp:FileUpload ID="fuSingleVideoUpload" runat="server" Width="300px" />
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblSingleVideoUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions color1">
												<asp:LinkButton ID="btnVideoUpload" runat="server" OnClick="btnVideoUpload_Click" resourcekey="btnVideoUploadResource1" Text="Upload" ValidationGroup="vgVideoUpload" CssClass="upload" />
											</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlMultiVideoUpload" runat="server" CssClass="content">
							<h4>
								<asp:Label ID="lblMultiVideoUploadTitle" resourcekey="lblMultiVideoUploadTitle" runat="server" Text="Multi video upload" CssClass="videoUpload"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labes">
											<dnn:Label ID="lblMultiVideoUploadVideoTitle" runat="server" HelpKey="lblVideoUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblVideoUploadVideoTitle" Text="Video title:" />
										</td>
										<td>
											<div id="divMultiVideoTitle" runat="server">
												<asp:TextBox ID="tbMultiFlashTitle" runat="server" resourcekey="tbFlashTitleResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labes"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbMultiVideoUploadFilenameAsTitle" runat="server" OnCheckedChanged="cbMultiVideoUploadFilenameAsTitle_CheckedChanged" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" AutoPostBack="True" />
											</div>
											<div id="divMultiVUFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlMultiVUFilenameasTitle" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblMulitVideoUploadTitleOptionsList" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labes">
											<dnn:Label ID="lblMultiVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
										</td>
										<td>
											<asp:TextBox ID="tbMultiFlashDescription" runat="server" Height="150px" MaxLength="4000" resourcekey="tbFlashDescriptionResource1" TextMode="MultiLine" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labes">
											<dnn:Label ID="lblMultiVideoUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
										</td>
										<td>
											<asp:TextBox ID="tbMultiFlashWidth" runat="server" resourcekey="tbFlashWidthResource1" ValidationGroup="vgVideoUpload" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvMultiVideoUploadWidth" runat="server" ControlToValidate="tbMultiFlashWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labes">
											<dnn:Label ID="lblMultiVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
										</td>
										<td>
											<asp:TextBox ID="tbMultiFlashHeight" runat="server" resourcekey="tbFlashHeightResource1" Width="50px" CssClass="large">
											</asp:TextBox>
											<asp:CompareValidator ID="cvMultiVideoUploadheight" runat="server" ControlToValidate="tbMultiFlashHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error">
											</asp:CompareValidator>
										</td>
									</tr>
									<tr>
										<td class="labes">
											<dnn:Label ID="lblMultiVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
										</td>
										<td>
											<asp:RadioButtonList ID="rblMultiVideoThumbnailSelect" runat="server" OnLoad="rblFlashThumbnail_Load" OnSelectedIndexChanged="rblMultiVideoThumbnailSelect_SelectedIndexChanged" RepeatDirection="Horizontal"
												AutoPostBack="True" CssClass="styledRadio small">
												<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labes"></td>
										<td>
											<div id="divMultiVUStandardImage" runat="server">
												<asp:Label ID="lblMultiVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
												&nbsp;<asp:DropDownList ID="ddlMultiVUThumbSelect" runat="server" OnLoad="ddlMultiVUThumbSelect_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labes"></td>
										<td>
											<div id="divMultiVUUploadThumb" runat="server" style="display: none">
												<asp:Label ID="lblMultiVideoUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
												<asp:FileUpload ID="fuMultiFlashThumbnail" runat="server" Width="322px" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labes"></td>
										<td>
											<asp:Label ID="lblMultiVideoUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
							</div>
							<asp:Panel ID="pnlVideoUploadUploadify" runat="server">
								<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
									<tr>
										<td>
											<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
												<asp:FileUpload ID="MultiVideoFileInput" runat="server" EnableTheming="True" />
											</div>
											<div style="display: block; float: left; margin-left: 15px;">
												<a class="btnUpload" href="javascript:<%=jQuery%>('#<%=MultiVideoFileInput.ClientID%>').uploadifySettings('scriptData', { 'foo': '<%=DirToSave%>'});<%=jQuery%>('#<%=MultiVideoFileInput.ClientID%>').uploadifyUpload();">
													<%=startUpload%></a> <a href="javascript:<%=jQuery%>('#<%=MultiVideoFileInput.ClientID%>').uploadifyClearQueue();">
														<%=ClearQueue%></a>
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlVideoUploadfineUploader" runat="server" Visible="False">
								<div id="galleryVideoFineUploaderContainer" class="EDS_simpleFineUploader">
									<div class="uploader">
									</div>
									<div class="uploadControls">
										<div class="actions">
											<span class="action fileSelection">
												<asp:Label ID="galleryVideoFineUploaderSelectFiles" runat="server" resourcekey="fineVideoUploaderSelectFiles" Text="Select videos" />
												<span class="dnnInputFileWrapper">
													<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
														<asp:Label ID="galleryVideoFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
													</span>
										</div>
										<div class="dndContainer">
											<p>
												<asp:Label ID="galleryVideoFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
											</p>
										</div>
									</div>
									<div class="uploadDetails">
										<ol class="fileUploadList">
										</ol>
									</div>
								</div>
							</asp:Panel>
							<div style="display: none; line-height: 0pt;">
								<asp:Button ID="btnSaveMultiVideoUpload" runat="server" OnClick="MultiVideoUpload" Text="Save" />
							</div>
						</asp:Panel>
					</asp:Panel>
					<asp:Panel ID="pnlAddEmbededVideo" runat="server" Visible="False" CssClass="contentSection videoUpload">
						<div class="specialOptions">
							<h2>
								<asp:Label ID="lblEmbedVideoTitle" runat="server" CssClass="subtitleregion" HelpText="Embed video from various video sites." Text="Embed Video" ResourceKey="lblEmbedVideoTitle.Text" />
							</h2>
							<div class="optionsList">
								<asp:RadioButtonList ID="rblEmbedVideoSourceSelect" runat="server" AutoPostBack="True" class="styledRadio" Height="29px" RepeatDirection="Horizontal" Width="415px"
									OnSelectedIndexChanged="rblEmbedVideoSourceSelect_SelectedIndexChanged">
									<asp:ListItem Selected="True" Text="YouTube" resourcekey="ListItemResource33">
									</asp:ListItem>
									<asp:ListItem Text="Vimeo" resourcekey="ListItemResource34">
									</asp:ListItem>
									<asp:ListItem Text="Dailymotion" resourcekey="ListItemResource35">
									</asp:ListItem>
									<asp:ListItem Text="Metacafe" resourcekey="ListItemResource36">
									</asp:ListItem>
								</asp:RadioButtonList>
								<asp:RequiredFieldValidator ID="rfvEmbedVideoSourceSelect" runat="server" ControlToValidate="rblEmbedVideoSourceSelect" ErrorMessage="Please select." ValidationGroup="EmbedVideo" resourcekey="rfvEmbedVideoSourceSelectResource1.ErrorMessage">
								</asp:RequiredFieldValidator>
							</div>
						</div>
						<asp:Panel ID="pnlFlashEmbeedFlasf" runat="server" CssClass="content">
							<h4>
								<asp:Label ID="Label2" ResourceKey="lblEmbedVideoTitle" runat="server" Text="Embed Video" CssClass="videoUpload"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr id="trEnterEmbedCodeRow" runat="server" visible="false">
										<td class="labels">
											<dnn:Label ID="lblEmbedVideoCode" runat="server" ControlName="tbFlashEmbedUrl" HelpKey="lblEmbedVideoCode.HelpText" HelpText="Enter video embed code:" Text="Embed code:" ResourceKey="lblEmbedVideoCode" />
											<asp:RequiredFieldValidator ID="rfvEmbedVideoCode" runat="server" ControlToValidate="tbVideoEmbedCode" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="EmbedVideo" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
										</td>
										<td>
											<asp:TextBox ID="tbVideoEmbedCode" runat="server" Height="150px" MaxLength="2500" TextMode="MultiLine" ValidationGroup="EmbedVideo" resourcekey="tbFlashEmbedUrlResource1" CssClass="large"></asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblEembedVideoUrl" runat="server" ControlName="tbEmbedShortUrl" HelpKey="lblEembedVideoUrl.HelpText" HelpText="Enter video url:" Text="Video url:" ResourceKey="lblEembedVideoUrl" />
										</td>
										<td>
											<asp:TextBox ID="tbEmbedVideoURL" runat="server" ValidationGroup="EmbedVideo" Width="300px" resourcekey="tbEmbedShortUrlResource1" CssClass="boxline"></asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvEmbedVideoURL" runat="server" ControlToValidate="tbEmbedVideoURL" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoURLResource1.ErrorMessage" ValidationGroup="EmbedVideo" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
										</td>
									</tr>
									<tr id="trEmbedVideoDimensions" runat="server">
										<td class="labels">
											<dnn:Label ID="lblEmbedVideoDimensions" runat="server" Text="Video dimensions:" HelpText="Video dimensions:" HelpKey="lblEmbedVideoDimensions.HelpText" ResourceKey="lblEmbedVideoDimensions"></dnn:Label>
										</td>
										<td>
											<asp:Label ID="lblEmbedVideoWidth" ResourceKey="lblEmbedVideoWidth" runat="server" Text="Width:"></asp:Label>
											<asp:TextBox ID="tbEmbedVideoWidth" runat="server" Width="30px" ValidationGroup="EmbedVideo" CssClass="large">560</asp:TextBox>
											&nbsp;<asp:RequiredFieldValidator ID="rfvEmbedVideoWidth" runat="server" ControlToValidate="tbEmbedVideoWidth" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoURLResource1.ErrorMessage" ValidationGroup="EmbedVideo" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
											<asp:CompareValidator ID="cvEmbedVideoWidth" runat="server" ControlToValidate="tbEmbedVideoWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoEditHeightResource1.ErrorMessage" Type="Integer"
												ValidationGroup="EmbedVideo" CssClass="smallInfo inline error">
											</asp:CompareValidator>
											<asp:Label ID="lblEmbedVideoHeight" ResourceKey="lblEmbedVideoHeight" runat="server" Text="Height:"></asp:Label>
											<asp:TextBox ID="tbEmbedVideoHeight" runat="server" Width="30px" ValidationGroup="EmbedVideo" CssClass="large">315</asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvEmbedVideoCode0" runat="server" ControlToValidate="tbEmbedVideoHeight" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="EmbedVideo" CssClass="smallInfo inline error">
											</asp:RequiredFieldValidator>
											<asp:CompareValidator ID="cvEmbedVideoHeight" runat="server" ControlToValidate="tbEmbedVideoHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoEditHeightResource1.ErrorMessage" Type="Integer"
												ValidationGroup="EmbedVideo" CssClass="smallInfo inline error">
											</asp:CompareValidator>
										</td>
										<td></td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblEmbedVideoEnterTitle" runat="server" ControlName="tbFlashEmbedTitle" HelpKey="lblEmbedVideoEnterTitle.HelpText" HelpText="Enter video title." Text="Video title:" />
										</td>
										<td>
											<asp:TextBox ID="tbFlashEmbedTitle" runat="server" ValidationGroup="EmbedVideo" resourcekey="tbFlashEmbedTitleResource1" CssClass="large"></asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblEmbedVideoDescription" runat="server" ControlName="tbFlashEmbedDescription" HelpKey="lblEmbedVideoDescription.HelpText" HelpText="Enter video description:" Text="Description:" ResourceKey="lblEmbedVideoDescription" />
										</td>
										<td>
											<asp:TextBox ID="tbFlashEmbedDescription" runat="server" Height="150px" MaxLength="4000" TextMode="MultiLine" resourcekey="tbFlashEmbedDescriptionResource1" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<asp:RadioButtonList ID="rblEmbedVideoThumbnail" runat="server" OnSelectedIndexChanged="rblEmbedVideoThumbnail_SelectedIndexChanged" Width="176px" Visible="False" CssClass="styledRadio small">
												<asp:ListItem Selected="True" Text="Auto create thumbnail" Value="Autocreate" resourcekey="ListItemResource37">
												</asp:ListItem>
												<asp:ListItem Text="Upload thumbnail" Value="Upload" resourcekey="ListItemResource38">
												</asp:ListItem>
												<asp:ListItem Text="Use standard image" Value="standard" resourcekey="ListItemResource39">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
										<td>
											<div id="divEVEFileUpload" runat="server" style="display: none">
												<asp:FileUpload ID="fuEmbedAddThumb" runat="server" Width="300px" />
												<br />
											</div>
											<div id="divEVESelectThumb" runat="server" style="display: none">
												<asp:DropDownList ID="ddlVUEVSelectThumbnail" runat="server" CausesValidation="True" OnLoad="ddlVUEVSelectThumbnail_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblEVUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions color1">
									<asp:LinkButton ID="btnAddEmbedVideo" runat="server" CssClass="add" OnClick="btnAddEmbedFlash_Click" Text="Add" ValidationGroup="EmbedVideo" resourcekey="btnAddEmbedVideoResource1" />
								</div>
							</div>
						</asp:Panel>
					</asp:Panel>
					<asp:Panel ID="pnlAudioUpload" runat="server" Visible="False" CssClass="contentSection videoUpload">
						<div class="specialOptions">
							<h2>
								<asp:Label ID="lblAddAudio" resourcekey="lblAddVideo" runat="server" Text="Add <br /> audio"></asp:Label>
							</h2>
							<div class="optionsList">
								<asp:RadioButtonList ID="rblAudioUploadSelectType" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblSelectAudioUpload_SelectedIndexChanged" RepeatDirection="Horizontal">
									<asp:ListItem resourcekey="lbMultiAudioUploadResource1" Value="multi" Selected="True">Multi audio file upload</asp:ListItem>
									<asp:ListItem resourcekey="lbSingleAudioUploadResource1" Text="Add audio file from server" Value="single"></asp:ListItem>
									<asp:ListItem resourcekey="liAmazonS3" Value="AmazonS3">Amazon S3</asp:ListItem>
								</asp:RadioButtonList>
							</div>
						</div>
						<asp:Panel ID="pnlAmazonS3AudioUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblAmazonS3TopTitle" runat="server" CssClass="amazonS3Upload" Text="Amazon S3"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonUploadAudioURL" runat="server" HelpText="Aamazon S3 audio URL link." Text="Aamazon S3 audio URL link:" HelpKey="lblAmazonUploadAudioURL.HelpText" ResourceKey="lblAmazonUploadAudioURL.Text" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonAudioURL" runat="server" Font-Size="11px" ValidationGroup="vgAmazonAudioUpload" CssClass="large">
											</asp:TextBox>
											<asp:RequiredFieldValidator ID="rfvAmazonAudioURL" runat="server" ControlToValidate="tbAmazonAudioURL" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="vgAmazonAudioUpload">
											</asp:RequiredFieldValidator>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonUploadAudioTitle" runat="server" HelpText="Enter the title of audio file:" Text="Audio title:" HelpKey="lblAmazonUploadAudioTitle.HelpText" ResourceKey="lblAmazonUploadAudioTitle.Text" />
										</td>
										<td>
											<div id="divAmazonAudioTitle" runat="server">
												<asp:TextBox ID="tbAmazonAudioTitle" runat="server" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbAmazonAudioUploadFilenameAsTitle" runat="server" AutoPostBack="True" OnCheckedChanged="cbAmazonAudioUploadFilenameAsTitle_CheckedChanged" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
											</div>
											<div id="divAmazonAudioFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlVUFilenameasTitle1" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonAudioUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonAudioUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonAudioUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblAmazonAudioUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase">
														</asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonAudioUploadDescription" runat="server" ControlName="tbFlashDescription" HelpText="Enter the audio description:" Text="Description:" HelpKey="lblAmazonAudioUploadDescription.HelpText" ResourceKey="lblAmazonAudioUploadDescription.Text" />
										</td>
										<td>
											<asp:TextBox ID="tbAmazonAudioDescription" runat="server" Height="150px" MaxLength="4000" resourcekey="tbFlashDescriptionResource1" TextMode="MultiLine" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAmazonAudioUploadThumbnail" runat="server" HelpText="Upload the thumbnail for audio file or use standard image:" Text="Thumbnail:" HelpKey="lblAmazonAudioUploadThumbnail.HelpText" ResourceKey="lblAmazonAudioUploadThumbnail.Text" />
										</td>
										<td>
											<asp:RadioButtonList ID="rblAmazonAudioThumbnailSelect" runat="server" AutoPostBack="True" OnLoad="rblFlashThumbnail_Load" OnSelectedIndexChanged="rblVideoThumbnailSelect_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
												<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard">
												</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divAmazonAudioStandardImage" runat="server">
												<asp:Label ID="lblAmazonAudioUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
												&nbsp;<asp:DropDownList ID="ddlAmazobAudioThumbSelect" runat="server" OnLoad="ddlAmazobAudioThumbSelect_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divAmazonAudioUploadThumb" runat="server" style="display: none">
												<asp:Label ID="lblAudioUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
												&nbsp;<asp:FileUpload ID="fuAmazonAudioThumbnail" runat="server" Width="322px" />
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<asp:Label ID="lblAmazonAudioUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions">
									<asp:LinkButton ID="btnAmazonUploadAudio" runat="server" CausesValidation="False" OnClick="btnAmazonUploadAudio_Click" resourcekey="btnUploadAudioResource1" Text="Add audio" ValidationGroup="vgAmazonAudioUpload" CssClass="add" />
								</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlSingleAudioUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblAudioUploadFile" runat="server" CssClass="uploadAudio" Text="Upload audio file" resourcekey="lblAudioUploadFileResource1"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAudioUploadEnterTitle" runat="server" ControlName="tbAudioTitle" HelpKey="lblAudioUploadEnterTitle.HelpText" HelpText="Enter the audio file title:" Text="Title:" ResourceKey="lblAudioUploadEnterTitle" />
										</td>
										<td>
											<div id="divAUTitleTextBox" runat="server">
												<asp:TextBox ID="tbAudioTitle" runat="server" resourcekey="tbAudioTitleResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbAudioUploadFilenameAsTitle" runat="server" AutoPostBack="True" OnCheckedChanged="cbAudioUploadFilenameAsTitle_CheckedChanged" Text="Use filename as title" resourcekey="cbAudioUploadFilenameAsTitleResource1" />
											</div>
											<div id="divAUFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlAUFilenameasTitle" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAudioUploadRemoveExtenzion" runat="server" Text="Remove extension" resourcekey="cbAudioUploadRemoveExtenzionResource1" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAudioUploadTitleReplaceUnderscore" runat="server" Text="Set this to replace &quot;_&quot; with blank space in title" resourcekey="cbAudioUploadTitleReplaceUnderscoreResource1" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAudioUploadTitleReplaceMinus" runat="server" Text="Set this to replace &quot;-&quot; with blank space in title" resourcekey="cbAudioUploadTitleReplaceMinusResource1" />
													</div>
													<asp:RadioButtonList ID="rblAudioUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem Text="Set this to change title to uppercase" Value="AllUppercase" resourcekey="ListItemResource40">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change title to lowercase" Value="AllLowercase" resourcekey="ListItemResource41">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase" resourcekey="ListItemResource42">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change first letter of title to uppercase" Value="FirstUppercase" resourcekey="ListItemResource43">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAudioUploadDescription" runat="server" ControlName="tbAudioDescription" HelpKey="lblAudioUploadDescription.HelpText" HelpText="Enter the audio file description:" Text="Description:" ResourceKey="lblAudioUploadDescription" />
										</td>
										<td>
											<asp:TextBox ID="tbAudioDescription" runat="server" Height="100px" MaxLength="4000" TextMode="MultiLine" resourcekey="tbAudioDescriptionResource1" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAudioUploadThumbnailSelect" runat="server" HelpKey="lblAudioUploadThumbnailSelect.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" Text="Thumbnail:" ResourceKey="lblAudioUploadThumbnailSelect" />
										</td>
										<td>
											<asp:RadioButtonList ID="rblAudioUploadSelectThumbSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblAudioUploadSelectThumbSource_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
												<asp:ListItem Selected="True" Text="Use standard image" Value="standard" resourcekey="ListItemResource44">
												</asp:ListItem>
												<asp:ListItem Text="Upload" Value="upload" resourcekey="ListItemResource45">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divAUSelectStantard" runat="server">
												<asp:DropDownList ID="ddlAUSelectSTandThumb" runat="server" OnLoad="ddlAUSelectSTandThumb_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divAUUploadThumb" runat="server" style="display: none">
												<asp:FileUpload ID="fuAudioUpload" runat="server" CssClass="boxline" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblAudioUploadSelectFile" runat="server" HelpKey="lblAudioUploadSelectFile.HelpText" HelpText="Select audio file to upload:" Text="Select file:" ResourceKey="lblAudioUploadSelectFile" />
										</td>
										<td>
											<asp:FileUpload ID="fuAudio" runat="server" Width="300px" CssClass="boxline" />
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblAudioUploadMessage" runat="server" AssociatedControlID="btnUploadAudio" EnableViewState="False"></asp:Label>
										</td>
									</tr>
								</table>
								<div class="mainActions">
									<asp:LinkButton ID="btnUploadAudio" runat="server" OnClick="btnUploadAudio_Click" Text="Upload" CausesValidation="False" resourcekey="btnUploadAudioResource1" CssClass="upload" />
								</div>
							</div>
						</asp:Panel>
						<asp:Panel ID="pnlMultiAudioUpload" runat="server" Visible="False" CssClass="content">
							<h4>
								<asp:Label ID="lblMultiAudioUploadFile" runat="server" CssClass="videoUpload" Text="Upload multiple audio file" resourcekey="lblMultiAudioUploadFile"></asp:Label>
							</h4>
							<div class="optionsPanel">
								<table>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiAudioUploadEnterTitle" runat="server" ControlName="tbAudioTitle" HelpKey="lblAudioUploadEnterTitle.HelpText" HelpText="Enter the audio file title:" Text="Title:" ResourceKey="lblMultiAudioUploadEnterTitle" />
										</td>
										<td>
											<div id="divMultiAUTitleTextBox" runat="server">
												<asp:TextBox ID="tbMultiAudioTitle" runat="server" resourcekey="tbMultiAudioTitleResource1" CssClass="large">
												</asp:TextBox>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div class="styledCheckbox">
												<asp:CheckBox ID="cbMultiAudioUploadFilenameAsTitle" runat="server" Text="Use filename as title" AutoPostBack="True" OnCheckedChanged="cbMultiAudioUploadFilenameAsTitle_CheckedChanged" resourcekey="cbMultiAudioUploadFilenameAsTitleResource1" />
											</div>
											<div id="divMultiAUFilenameAsTitle" runat="server" style="display: none">
												<asp:Panel ID="pnlAUFilenameasTitle0" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiAudioUploadRemoveExtenzion" runat="server" Text="Remove extension" resourcekey="cbMultiAudioUploadRemoveExtenzionResource1" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiAudioUploadTitleReplaceUnderscore" runat="server" Text="Set this to replace &quot;_&quot; with blank space in title" resourcekey="cbMultiAudioUploadTitleReplaceUnderscoreResource1" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiAudioUploadTitleReplaceMinus" runat="server" Text="Set this to replace &quot;-&quot; with blank space in title" resourcekey="cbMultiAudioUploadTitleReplaceMinusResource1" />
													</div>
													<asp:RadioButtonList ID="rblMultiAudioUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem Text="Set this to change title to uppercase" Value="AllUppercase" resourcekey="ListItemResource46">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change title to lowercase" Value="AllLowercase" resourcekey="ListItemResource47">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase" resourcekey="ListItemResource48">
														</asp:ListItem>
														<asp:ListItem Text="Set this to change first letter of title to uppercase" Value="FirstUppercase" resourcekey="ListItemResource49">
														</asp:ListItem>
													</asp:RadioButtonList>
												</asp:Panel>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiAudioUploadDescription" runat="server" ControlName="tbAudioDescription" HelpKey="lblAudioUploadDescription.HelpText" HelpText="Enter the audio file description:" Text="Description:" />
										</td>
										<td>
											<asp:TextBox ID="tbMultiAudioDescription" runat="server" Height="100px" MaxLength="4000" TextMode="MultiLine" resourcekey="tbMultiAudioDescriptionResource1" CssClass="large">
											</asp:TextBox>
										</td>
									</tr>
									<tr>
										<td class="labels">
											<dnn:Label ID="lblMultiAudioUploadThumbnailSelect" runat="server" HelpKey="lblAudioUploadThumbnailSelect.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" Text="Thumbnail:" />
										</td>
										<td>
											<asp:RadioButtonList ID="rblMultiAudioUploadSelectThumbSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblMultiAudioUploadSelectThumbSource_SelectedIndexChanged" CssClass="styledRadio small">
												<asp:ListItem Selected="True" Text="Use standard image" Value="standard" resourcekey="ListItemResource50">
												</asp:ListItem>
												<asp:ListItem Text="Upload" Value="upload" resourcekey="ListItemResource51">
												</asp:ListItem>
											</asp:RadioButtonList>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divMultiAUSelectStantard" runat="server">
												<asp:DropDownList ID="ddlMultiAUSelectSTandThumb" runat="server" OnLoad="ddlMultiAUSelectSTandThumb_Load">
												</asp:DropDownList>
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<div id="divMultiAUUploadThumb" runat="server" style="display: none">
												<asp:FileUpload ID="fuMultiAudioUpload" runat="server" />
											</div>
										</td>
									</tr>
									<tr>
										<td class="labels"></td>
										<td>
											<asp:Label ID="lblMultiAudioUploadMessage" runat="server" EnableViewState="False"></asp:Label>
										</td>
									</tr>
									<tr>
										<td class="style14" colspan="2">
											<asp:Panel ID="pnlAudioUploadUploadify" runat="server" Visible="True">
												<table align="center" cellpadding="0" cellspacing="0">
													<tr>
														<td>
															<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
																<asp:FileUpload ID="MultiAudioFileInput" runat="server" EnableTheming="True" />
															</div>
															<div style="display: block; float: left; margin-left: 15px;">
																<a class="btnUpload" href="javascript:<%=jQuery%>('#<%=MultiAudioFileInput.ClientID%>').uploadifySettings('scriptData', { 'foo': '<%=DirToSave%>'});<%=jQuery%>('#<%=MultiAudioFileInput.ClientID%>').uploadifyUpload();">
																	<%=startUpload%></a> <a class="clearqueue" href="javascript:<%=jQuery%>('#<%=MultiAudioFileInput.ClientID%>').uploadifyClearQueue();">
																		<%=ClearQueue%></a>
															</div>
															<br />

														</td>
													</tr>
												</table>
											</asp:Panel>
											<asp:Panel ID="pnlAudioUploadfineUploader" runat="server" Visible="False">
												<div id="galleryAudioFineUploaderContainer" class="EDS_simpleFineUploader">
													<div class="uploader">
													</div>
													<div class="uploadControls">
														<div class="actions">
															<span class="action fileSelection">
																<asp:Label ID="galleryAudioFineUploaderSelectFiles" runat="server" resourcekey="fineAudioUploaderSelectFiles" Text="Select Audios" />
																<span class="dnnInputFileWrapper">
																	<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
																		<asp:Label ID="galleryAudioFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
																	</span>
														</div>
														<div class="dndContainer">
															<p>
																<asp:Label ID="galleryAudioFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
															</p>
														</div>
													</div>
													<div class="uploadDetails">
														<ol class="fileUploadList">
														</ol>
													</div>
												</div>
											</asp:Panel>
											<div style="display: none; line-height: 0pt;">
												<asp:Button ID="btnSaveMultiAudioUpload" runat="server" OnClick="MultiAudioUpload" Text="Save" resourcekey="btnSaveMultiAudioUploadResource1" />
											</div>
										</td>
									</tr>
								</table>
							</div>
						</asp:Panel>
					</asp:Panel>
				</asp:Panel>
			</div>
		</div>
	</div>
</div>
