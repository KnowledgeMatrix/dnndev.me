<%@ control language="C#" inherits="EasyDNN.Modules.EasyDNNGallery.Upload, App_Web_upload.ascx.af09375b" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	rotateImage = function (direction) {
		var rotationAngle = parseInt($("#" + '<%= hfImageEditRotateValue.ClientID %>').val());
		if (direction == 'left')
			rotationAngle = rotationAngle - 90;
		else
			rotationAngle = rotationAngle + 90;
		if (rotationAngle < 0)
			rotationAngle = 270;
		else if (rotationAngle > 270)
			rotationAngle = 0;
		$('#' + '<%=hlIEViewImage.ClientID%>').switchClass("rotate" + $("#" + '<%= hfImageEditRotateValue.ClientID %>').val(), "rotate" + rotationAngle);
		$('#' + '<%=hfImageEditRotateValue.ClientID%>').val(rotationAngle);
		return false;
	}

	simpleFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: false,
				vimeo: false
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
				wistia: false,
				vimeo: false
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
				wistia: true,
				vimeo: false
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

	simpleVimeoFineUploaderSettings = function () {
		return {
			endpoint: '<%=ModulePath%>htmluploader.ashx?portalid=<%=PortalId%>&userid=<%=UserId%>',
			sizeLimit: 0,
			params: {
				moduleId: '<%=ModuleId%>',
				wistia: false,
				vimeo: true
			},
			allowedExtensions: ['mov', 'mp4', 'flv', 'swf', '3gp'],
			allowPreviewThumbnails: false,
			onAllUploadsComplete: function () {
				document.getElementById('<%=btnSaveVimeoVideoUpload.ClientID%>').click();
			},
			onEachUploadComplete: function (response) {
				var $hiddenField = $('#<%=hfVimeoUploadedVideos.ClientID%>'),
					data = $hiddenField.data('vimeoUploads');

				if (!response.vimeo)
					return;

				if (!data)
					data = [];

				data.push(response.vimeo);

				$hiddenField
					.data('vimeoUploads', data)
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
				wistia: false,
				vimeo: false
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

	function SaveCheckedChekboxes() {
		var roleViewChecked = ",",
			$ = eds1_10;
		$('#pnlAllSettings span.categoryRoleView > input').each(function () {
			if ($(this).is(':checked')) {
				roleViewChecked = roleViewChecked + $(this).parent().data('cid') + ",";
			}
		});
		$('#<%=hfCategoryRolesAndPermisionsView.ClientID%>').val(roleViewChecked);
		var roleViewChecked = ",";
		$('#pnlAllSettings span.categoryRoleEdit > input').each(function () {
			if ($(this).is(':checked')) {
				roleViewChecked = roleViewChecked + $(this).parent().data('cid') + ",";
			}
		});
		$('#<%=hfCategoryRolesAndPermisionsEdit.ClientID%>').val(roleViewChecked);
	}

	function SaveGalleryCheckedChekboxes() {
		if (typeof (Page_ClientValidate) == 'function') {
			if (Page_ClientValidate("vgSaveGalleryPermisions") == false) {
				return false;
			}
		}
		var roleViewChecked = ",", $ = eds1_10;
		$('#pnlAllGallerySettings span.galleryRoleView > input').each(function () {
			if ($(this).is(':checked')) {
				roleViewChecked = roleViewChecked + $(this).parent().data('cid') + ",";
			}
		});
		$('#<%=hfGalleryRolesAndPermisionsView.ClientID%>').val(roleViewChecked);
		var roleViewChecked = ",";
		$('#pnlAllGallerySettings span.galleryRoleEdit > input').each(function () {
			if ($(this).is(':checked')) {
				roleViewChecked = roleViewChecked + $(this).parent().data('cid') + ",";
			}
		});
		$('#<%=hfGalleryRolesAndPermisionsEdit.ClientID%>').val(roleViewChecked);
	}

	function clickAllcheckboxes(viewOrEdit) {
		var cbSelector = '#pnlAllSettings span.categoryRoleView > input', $ = eds1_10;
		if (viewOrEdit === 'Edit') {
			if ($(this).closest('td').children(':input').last().val() === 'All users') {
				cbSelector = '#pnlAllSettings span.categoryRoleView > input, #pnlAllSettings span.categoryRoleEdit > input';
			}
			else {
				cbSelector = "none";
			}
			var parentTr = $(this).closest('tr').find('span > input:first');
			if ($(this).is(':checked')) {
				var domElem = parentTr[0];
				domElem.checked = true;
				parentTr.prop("disabled", true);
			}
			else {
				if ($(this).closest('table').find('span > input:first').is(':checked') === false) {
					var parentTr = $(this).closest('tr').find('span > input:first');
					$(parentTr).removeAttr("disabled");
					$(parentTr).removeProp("disabled");
					$(parentTr).prop("disabled", false);
				}
			}
			if ($(this).parent().data('cid') == -2) {
				var checked = $(this).is(':checked');
				$('#pnlAllSettings span.categoryUserEdit > input, #pnlAllSettings span.categoryUserView > input').each(function () {
					$(this).prop("disabled", checked);
				});
			}
		}
		else {
			if ($(this).parent().data('cid') == -2) {
				var checked = $(this).is(':checked');
				$('#pnlAllSettings span.categoryUserView > input').each(function () {
					$(this).prop("disabled", checked);
				});
			}
			if ($(this).closest('td').children(':input').last().val() != 'All users') {
				cbSelector = "none";
			}
		}
		if (cbSelector != "none") {
			var idViewAll = ($(this).attr("id"));
			if ($(this).is(':checked')) {
				$(cbSelector).each(function () {
					var parentTr = $(this);
					parentTr[0].checked = true;
					if (idViewAll != $(this).attr("id"))
						$(this).prop("disabled", true);
				});
			}
			else {
				$(cbSelector).each(function () {
					if ($(this).closest('td').children(':input').last().val() != 'Administrators') {
						if ($(this).closest('table').find('span > input:first').is(':checked') === false || ($(this).attr('name').indexOf("cbCategoryRoleEdit") != -1) || ($(this).closest('td').children(':input').last().val() === 'All users')) {
							if ($(this).closest('tr').find('span > input:last').is(':checked') === false || $(this).attr('name').indexOf("cbCategoryRoleEdit") != -1) {
								$(this).removeAttr("disabled");
								$(this).removeProp("disabled");
								$(this).prop("disabled", false);
							}
						}
					}
				});
			}
		}
	}

	function clickAllGalleryCheckboxes(viewOrEdit) {
		var cbSelector = '#pnlAllGallerySettings span.galleryRoleView > input', $ = eds1_10;;
		if (viewOrEdit === 'Edit') {
			if ($(this).closest('td').children(':input').last().val() === 'All users') {
				cbSelector = '#pnlAllGallerySettings span.galleryRoleView > input, #pnlAllGallerySettings span.galleryRoleEdit > input';
			}
			else {
				cbSelector = "none";
			}
			var parentTr = $(this).closest('tr').find('span > input:first');
			if ($(this).is(':checked')) {
				var domElem = parentTr[0];
				domElem.checked = true;
				parentTr.prop("disabled", true);
			}
			else {
				if ($(this).closest('table').find('span > input:first').is(':checked') === false) {
					var parentTr = $(this).closest('tr').find('span > input:first');
					$(parentTr).removeAttr("disabled");
					$(parentTr).removeProp("disabled");
					$(parentTr).prop("disabled", false);
				}
			}
			if ($(this).parent().data('cid') == -2) {
				var checked = $(this).is(':checked');
				$('#pnlAllGallerySettings span.galleryUserEdit > input, #pnlAllGallerySettings span.galleryUserView > input').each(function () {
					$(this).prop("disabled", checked);
				});
			}
		}
		else {
			if ($(this).parent().data('cid') == -2) {
				var checked = $(this).is(':checked');
				$('#pnlAllGallerySettings span.galleryUserView > input').each(function () {
					$(this).prop("disabled", checked);
				});
			}
			if ($(this).closest('td').children(':input').last().val() != 'All users') {
				cbSelector = "none";
			}
		}
		if (cbSelector != "none") {
			var idViewAll = ($(this).attr("id"));
			if ($(this).is(':checked')) {
				$(cbSelector).each(function () {
					var parentTr = $(this);
					parentTr[0].checked = true;
					if (idViewAll != $(this).attr("id"))
						$(this).prop("disabled", true);
				});
			}
			else {
				$(cbSelector).each(function () {
					if ($(this).closest('td').children(':input').last().val() != 'Administrators') {
						if ($(this).closest('table').find('span > input:first').is(':checked') === false || ($(this).attr('name').indexOf("cbGalleryRoleEdit") != -1) || ($(this).closest('td').children(':input').last().val() === 'All users')) {
							if ($(this).closest('tr').find('span > input:last').is(':checked') === false || $(this).attr('name').indexOf("cbGalleryRoleEdit") != -1) {
								$(this).removeAttr("disabled");
								$(this).removeProp("disabled");
								$(this).prop("disabled", false);
							}
						}
					}
				});
			}
		}
	}

	function SelectAllMedia() {
		eds1_10('#<%=gvGalleryImages.ClientID%> span.EGMediaSelect > input').each(function () {
			this.checked = true;
		});
	}

	function DeSelectAllMedia() {
		eds1_10('#<%=gvGalleryImages.ClientID%> span.EGMediaSelect > input').each(function () {
			this.checked = false;
		});
	}

	function SelectAllGalleries() {
		eds1_10('#<%=gvGalleries.ClientID%> .styledCheckbox.noLabel input').each(function () {
			this.checked = true;
		});
	}

	function DeSelectAllGalleries() {
		eds1_10('#<%=gvGalleries.ClientID%> .styledCheckbox.noLabel input').each(function () {
			this.checked = false;
		});
	}

	function ProvjeriRBL3(rbl3, div3, div4) {
		var rdolist2 = document.getElementById(rbl3);
		var myitems2 = rdolist2.getElementsByTagName('input');
		var elementRef8 = document.getElementById(div3);
		var elementRef9 = document.getElementById(div4);
		if (myitems2[0].checked) {
			elementRef8.style.display = 'none';
			elementRef9.style.display = 'none';
		}
		if (myitems2[1].checked) {
			elementRef8.style.display = 'block';
			elementRef9.style.display = 'none';
		}
		if (myitems2[2].checked) {
			elementRef8.style.display = 'none';
			elementRef9.style.display = 'block';
		}
	}

	function ProvjeriRBL3Met2(rbl3, div3, div4) {
		var rdolist2 = document.getElementById(rbl3);
		var myitems2 = rdolist2.getElementsByTagName('input');
		var elementRef8 = document.getElementById(div3);
		var elementRef9 = document.getElementById(div4);
		if (myitems2[2].checked) {
			elementRef8.style.display = 'none';
			elementRef9.style.display = 'none';
		}
		if (myitems2[0].checked) {
			elementRef8.style.display = 'block';
			elementRef9.style.display = 'none';
		}
		if (myitems2[1].checked) {
			elementRef8.style.display = 'none';
			elementRef9.style.display = 'block';
		}
	}

	function Sakrij(sto) {
		var elementRef = document.getElementById(sto);
		elementRef.style.display = (elementRef.style.display == 'none') ? 'block' : 'none';
	}

	function SakrijDva(sto, sto2) {
		var elementRef2 = document.getElementById(sto);
		var elementRef3 = document.getElementById(sto2);
		elementRef2.style.display = (elementRef2.style.display == 'none') ? 'block' : 'none';
		elementRef3.style.display = (elementRef3.style.display == 'none') ? 'block' : 'none';
	}

	function SakrijTri(sto, sto2, sto3) {
		var elementRef2 = document.getElementById(sto);
		var elementRef3 = document.getElementById(sto2);
		var elementRef4 = document.getElementById(sto3);
		elementRef2.style.display = (elementRef2.style.display == 'none') ? 'block' : 'none';
		elementRef3.style.display = (elementRef3.style.display == 'none') ? 'block' : 'none';
		elementRef4.style.display = (elementRef4.style.display == 'none') ? 'block' : 'none';
	}

	function ProvjeriRBL(rbl, div1, div2) {
		var rdolist = document.getElementById(rbl);
		var myitems = rdolist.getElementsByTagName('input');
		var elementRef6 = document.getElementById(div1);
		var elementRef7 = document.getElementById(div2);
		if (myitems[0].checked) {
			elementRef6.style.display = 'block';
			elementRef7.style.display = 'none';
		}
		else {
			elementRef6.style.display = 'none';
			elementRef7.style.display = 'block';
		}
	}

	<%=jQuery%>(document).ready(function ($) {
		$('#<%=tbPublishDate.ClientID%>').datepick({ dateFormat: "<%=dateFormat%>" });
		$('#<%=tbExpireDate.ClientID%>').datepick({ dateFormat: "<%=dateFormat%>" });
		var moduleId = "<%=ModuleId%>";
		var userId = "<%=UserId%>";
		if ('<%=gms.EnableCommunityMode.ToString()%>' === 'True') {
			$('#<%=lbSocialSecurityGroups.ClientID %>').dropdownchecklist({
				forceMultiple: true,
				minWidth: 180,
				width: 180,
				emptyText: '<span class="empty">None</span>'
			});
			$('#<%=lbGallerySocialSecurityGroups.ClientID %>').dropdownchecklist({
				forceMultiple: true,
				minWidth: 180,
				width: 180,
				emptyText: '<span class="empty">None</span>'
			});
		}
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
			else if ($('#<%=pnlVimeoUploadfineUploader.ClientID%>').length > 0) {
				eds1_10('#galleryVimeoFineUploaderContainer').edsFineUploader_1_3(simpleVimeoFineUploaderSettings());
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
					document.getElementById('<%=btnSaveMultiImageUpload.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					}
					else if 
								 (errorObj.type === "HTTP")
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
					<%=jQuery%>("#<%=GalfileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQuery%>("#<%=GalfileInput.ClientID%>" + queueID).remove() });
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
					}
					else if (errorObj.type === "HTTP")
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
					$("#<%=MultiVideoFileInput.ClientID%>" + queueID).fadeOut(250, function () { <%=jQuery%>("#<%=MultiVideoFileInput.ClientID%>" + queueID).remove() });
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
				'buttonText': '<%=SelectAudio%>',
				'onAllComplete': function (event, queueID, fileObj, response, data) {
					document.getElementById('<%=btnSaveMultiAudioUpload.ClientID%>').click();
				},
				'onError': function (event, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					}
					else if (errorObj.type === "HTTP")
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
		}

		(function () {
			var $wrapper = $('.lastModifiedGalleries'),
				$trigger = $('> .lastAddedModifiedGalleriesHeader > span', $wrapper),
				$content = $('> .lastModifiedGalleriesToggleWrapper > .lastAddedModifiedGalleriesListWrapper', $wrapper),
				$div = $('> div', $content);

			$trigger.click(function () {
				if ($wrapper.hasClass('expanded')) {
					$wrapper.removeClass('expanded');
					$content
						.stop(true)
						.animate(
							{
								height: 37
							},
							{
								duration: 200
							}
						);
				} else {
					$wrapper.addClass('expanded');
					$content
						.stop(true)
						.animate(
							{
								height: $div.outerHeight(true)
							},
							{
								duration: 200
							}
						);
				}
			});
		})();
	});
</script>
<div id="mainUpload" runat="server">
	<div id="EDGAdminContent">
		<div class="flashMessages"></div>
		<asp:Label ID="lblPortalID" runat="server" Visible="False" />
		<asp:ObjectDataSource ID="odsCategories" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCategoriesByUser" UpdateMethod="UpdateCategory" DeleteMethod="DeleteCategory">
			<DeleteParameters>
				<asp:Parameter Name="CategoryID" Type="Int32" />
			</DeleteParameters>
			<UpdateParameters>
				<asp:Parameter Name="CategoryID" Type="Int32" />
				<asp:Parameter Name="CategoryName" Type="String" />
				<asp:Parameter Name="CategoryDescription" Type="String" />
				<asp:Parameter Name="Position" Type="Int32" />
			</UpdateParameters>
			<SelectParameters>
				<asp:ControlParameter ControlID="lblPortalID" Name="PortalID" PropertyName="Text" Type="Int32" />
				<asp:Parameter Name="UserID" Type="Int32" />
				<asp:Parameter Name="byUser" Type="Boolean" />
				<asp:Parameter Name="isAdmin" Type="Boolean" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsMoveCategories" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCategoriesByUser" OnSelecting="odsMoveCategories_Selecting">
			<SelectParameters>
				<asp:ControlParameter ControlID="lblPortalID" Name="PortalID" PropertyName="Text" Type="Int32" />
				<asp:Parameter Name="UserID" Type="Int32" />
				<asp:Parameter Name="byUser" Type="Boolean" />
				<asp:Parameter Name="isAdmin" Type="Boolean" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsMoveGalleries" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCatGalleries" DeleteMethod="DeleteGallery" UpdateMethod="UpdateGalley">
			<DeleteParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
			</DeleteParameters>
			<UpdateParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="GalleryName" Type="String" />
				<asp:Parameter Name="Position" Type="Int32" />
			</UpdateParameters>
			<SelectParameters>
				<asp:ControlParameter ControlID="ddlMoveCategory" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsMoveGalleriesByUserID" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetGaleriesByUserID" DeleteMethod="DeleteGallery" UpdateMethod="UpdateGalley">
			<DeleteParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
			</DeleteParameters>
			<UpdateParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="GalleryName" Type="String" />
				<asp:Parameter Name="Position" Type="Int32" />
			</UpdateParameters>
			<SelectParameters>
				<asp:ControlParameter ControlID="ddlMoveCategory" Name="CategoryID" PropertyName="SelectedValue" Type="Int32" />
				<asp:Parameter Name="UserID" Type="Int32" />
				<asp:Parameter Name="byUser" Type="Boolean" />
				<asp:Parameter Name="isAdmin" Type="Boolean" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGalleries" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetGaleriesByUserID" DeleteMethod="DeleteGallery" UpdateMethod="UpdateGalley" OnSelecting="odsGalleries_Selecting" OnSelected="odsGalleries_Selected">
			<DeleteParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
			</DeleteParameters>
			<UpdateParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="GalleryName" Type="String" />
				<asp:Parameter Name="GalleryDescription" Type="String" />
				<asp:Parameter Name="Position" Type="Int32" />
			</UpdateParameters>
			<SelectParameters>
				<asp:Parameter Name="CategoryID" Type="Int32" />
				<asp:Parameter Name="UserID" Type="Int32" />
				<asp:Parameter Name="byUser" Type="Boolean" />
				<asp:Parameter Name="isAdmin" Type="Boolean" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsTopGalleris" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetTop5GaleriesByUserID" OldValuesParameterFormatString="original_{0}" EnableViewState="False" OnSelecting="odsTopGalleris_Selecting">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:ControlParameter ControlID="ddlNumLastGals" Name="NumberOfGals2" PropertyName="SelectedValue" Type="Int32" />
				<asp:Parameter Name="UserID" Type="Int32" />
				<asp:Parameter Name="byUserID" Type="Boolean" />
				<asp:Parameter Name="isAdmin" Type="Boolean" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsCommunityCategories" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetCommunityModeCategories" OnSelecting="odsCommunityCategories_Selecting">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGalleryImages" TypeName="EasyDNN.Modules.EasyDNNGallery.DataAcess" runat="server" SelectMethod="GetImagesFromGallery" UpdateMethod="UpdateGalleryImage" DeleteMethod="DeleteImage" OnSelecting="odsGalleryImages_Selecting">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:ControlParameter ControlID="hfMainSelectedGallery" Name="GalleryID" PropertyName="Value" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
				<asp:Parameter Name="ThumbUrl" Type="String" />
				<asp:Parameter Name="Position" Type="Int32" />
				<asp:Parameter Name="MediaType" Type="String" />
			</UpdateParameters>
		</asp:ObjectDataSource>
		<asp:HiddenField ID="hfCategoriesByUserID" runat="server" />
		<asp:HiddenField ID="hfGalleriesByUserID" runat="server" />
		<asp:HiddenField ID="hfMainSelectedCategory" runat="server" />
		<asp:HiddenField ID="hfMainSelectedGallery" runat="server" />
		<asp:HiddenField ID="hfCurrentManagment" runat="server" />
		<asp:HiddenField ID="hfMultiMediaMoveList" runat="server" />
		<asp:Panel ID="pnlMainTopNavigation" runat="server">
			<div class="topBarWrapper">
				<div class="wrapper">
					<ul class="links">
						<li runat="server" id="liMainSectiontext">
							<asp:Label runat="server" ID="lblManagmentSectionTitle" Text="Manage catgories"></asp:Label>
						</li>
						<asp:Repeater ID="repCommunityModeCats" runat="server" OnItemCommand="repCommunityModeCats_ItemCommand">
							<ItemTemplate>
								<li>
									<asp:LinkButton ID="lbCategory" runat="server" CommandArgument='<%#((DataRowView)Container.DataItem)["CategoryID"]%>' CommandName="OpenCategory"><%#((DataRowView)Container.DataItem)["CategoryName"]%></asp:LinkButton>
								</li>
							</ItemTemplate>
						</asp:Repeater>
					</ul>
					<ul class="actions">
						<li class="back">
							<asp:LinkButton ID="btnBackManagment" runat="server" Text="Back" Visible="False" OnClick="btnBackManagment_Click" />
						</li>
						<li class="close">
							<asp:LinkButton ID="btnClose" runat="server" OnClick="btnCloseMM_Click" Text="Close" resourcekey="btnCloseResource1" />
						</li>
					</ul>
				</div>
			</div>
		</asp:Panel>
		<div class="mainContentWrapper">
			<asp:Panel ID="pnlLastModGals" runat="server">
				<div class="lastModifiedGalleries">
					<div class="lastAddedModifiedGalleriesHeader">
						<h3>
							<asp:Label ID="lblLastModifiedGalleriesTitle" resourcekey="lblLastModifiedGalleriesTitle" runat="server" Text="&lt;b&gt;Last&lt;/b&gt; added/modified galleries" CssClass="lastaddedtitle"></asp:Label>
						</h3>
						<span class="lastModifiedGalleriesHeaderToggle">Open/Close</span>
					</div>
					<div class="lastModifiedGalleriesToggleWrapper">
						<div class="lastAddedModifiedGalleriesListWrapper">
							<div>
								<asp:Repeater ID="dlLastModified" runat="server" DataSourceID="odsTopGalleris" OnItemCommand="dlLastModified_ItemCommand" OnPreRender="dlLastModified_PreRender">
									<HeaderTemplate>
										<ul class="lastAddedModifiedGalleriesList">
									</HeaderTemplate>
									<ItemTemplate>
										<li>
											<asp:LinkButton ID="lbGalleryLastModifiedName" runat="server" CommandArgument='<%#((DataRowView)Container.DataItem)["GalleryID"]%>' CommandName="Open" CssClass="lastmodgallery" resourcekey="LinkButton9Resource1"><%#((DataRowView)Container.DataItem)["GalleryName"]%></asp:LinkButton>
											<asp:Label ID="lblGalleryLastModifiedDate" runat="server" Text='<%#String.Format("({0})",((DataRowView)Container.DataItem)["DateLastModified"])%>' CssClass="labeltext" resourcekey="Label5Resource1"></asp:Label>
										</li>
									</ItemTemplate>
									<FooterTemplate>
										</ul>
									</FooterTemplate>
								</asp:Repeater>
								<div class="numberOfGalleriesPerPage">
									<dnn:Label ID="lblNumberOfLastModifiedGalleriesPerPage" runat="server" ResourceKey="lblNumberOfLastModifiedGalleriesPerPage" ControlName="ddlNumOfCatSelect" HelpText="Select the number of galleris to display on one page:" Text="Select the number of galleries per page:" CssClass="labeltext" HelpKey="lblNumberOfLastModifiedGalleriesPerPage.HelpText" />
									<div class="styledSelect smallSelect">
										<asp:DropDownList ID="ddlNumLastGals" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlNumLastGals_SelectedIndexChanged" CssClass="ddlpageitems">
											<asp:ListItem Text="10" Value="10" resourcekey="ListItemResource1"></asp:ListItem>
											<asp:ListItem Text="20" Value="20" resourcekey="ListItemResource3"></asp:ListItem>
											<asp:ListItem Text="30" Value="30" resourcekey="ListItemResource4"></asp:ListItem>
										</asp:DropDownList>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlCategoryManagment" runat="server" CssClass="contentSectionWrapper color1">
				<div id="categoryHeaderWrapper" class="sectionHeader" runat="server">
					<div class="titleAndNumber categoriesTitleAndNumber">
						<h4>
							<asp:Label ID="lblManageCategoriesTitle" resourcekey="lblManageCategoriesTitle" runat="server" Text="Manage categories"></asp:Label></h4>
						<p>
							<asp:Label ID="lblNumOfCats" runat="server" Text="Number of categories:" resourcekey="lblNumOfCatsResource1"></asp:Label>
							<asp:Label ID="lblCategoriesNumber" runat="server" CssClass="numberOfItemsInSection" resourcekey="lblCategoriesNumberResource1"></asp:Label>
						</p>
					</div>
					<asp:Panel ID="pnlAddCategoryBox" runat="server" DefaultButton="btnAddcat" CssClass="headerActionBox">
						<h4>
							<asp:Label ID="lblAddNewCategory" resourcekey="lblAddNewCategory" runat="server" Text="Add NEW Category"></asp:Label></h4>
						<div>
							<div>
								<asp:RequiredFieldValidator ID="rfvNewCategoryName" runat="server" ControlToValidate="tbCatName" Display="Dynamic" ErrorMessage="Category name is required." ValidationGroup="vgAddcategory" CssClass="smallInfo warning" resourcekey="rfvNewCategoryNameResource1.ErrorMessage"></asp:RequiredFieldValidator>
								<dnn:Label ID="lblEnterNewCategoryName" runat="server" ControlName="tbCatName" HelpText="Enter the name for the new category:" Text="Category name:" ResourceKey="lblEnterNewCategoryName" CssClass="tooltip" HelpKey="lblEnterNewCategoryName.HelpText" />
								<asp:TextBox ID="tbCatName" runat="server" CssClass="box1" MaxLength="500"></asp:TextBox>
								<dnn:Label ID="lblEnterNewCategoryDescription" runat="server" ControlName="tbCatDesc" HelpText="Enter the description for the new category:" Text="Description:" ResourceKey="lblEnterNewCategoryDescription" CssClass="tooltip" HelpKey="lblEnterNewCategoryDescription.HelpText" />
								<asp:TextBox ID="tbCatDesc" runat="server" CssClass="box1" MaxLength="2000"></asp:TextBox>
							</div>
							<asp:LinkButton ID="btnAddcat" runat="server" OnClick="btnAddcat_Click" ValidationGroup="vgAddcategory" ToolTip="Add Category" resourcekey="btnAddcatResource1" CssClass="headerActionButton" Text="Add" />
						</div>
					</asp:Panel>
				</div>
				<div class="listItems">
					<asp:Label ID="lblCategoriesStatusMessage" runat="server" EnableViewState="False" />
					<asp:Label ID="lblNoCategoryItems" CssClass="infoMessages info static" runat="server" Visible="False"></asp:Label>
					<asp:GridView ID="gvCategories" CssClass="listItemsTable" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" border="0" CellPadding="0" DataKeyNames="CategoryID" DataSourceID="odsCategories" GridLines="None" OnRowCommand="gvCategories_RowCommand" OnRowDeleted="gvCategories_RowDeleted" OnRowUpdated="gvCategories_RowUpdated" OnSelectedIndexChanged="gvCategories_SelectedIndexChanged" ShowFooter="True" OnRowDeleting="gvCategories_RowDeleting" EnableModelValidation="True" OnPreRender="gvCategories_PreRender">
						<Columns>
							<asp:TemplateField HeaderText="Actions" ShowHeader="False">
								<EditItemTemplate>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="lbCategoriesUpdate" runat="server" CommandName="Update" Text="Update" resourcekey="lbCategoriesUpdateResource1" CssClass="itemEditUpdate"></asp:LinkButton>
										<asp:LinkButton ID="lbCategoriesCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" resourcekey="lbCategoriesCancelResource1" CssClass="itemEditCancel"></asp:LinkButton>
									</div>
								</EditItemTemplate>
								<ItemTemplate>
									<div class="itemActions itemPrimaryActions">
										<asp:LinkButton ID="lbCategoriesSelect" runat="server" CausesValidation="False" CommandName="Select" CssClass="openAction" Text="Open" resourcekey="lbCategoriesSelectResource1"></asp:LinkButton>
										<asp:LinkButton ID="lbCategoriesEdit" runat="server" CausesValidation="False" CommandName="Edit" CssClass="editAction" Text="Edit" resourcekey="lbCategoriesEditResource1"></asp:LinkButton>
										<asp:LinkButton ID="lbCategoriesDelete" runat="server" CommandName="Delete" CssClass="deleteAction" OnClientClick="return confirm('Are you sure you want to delete this category?');" Text="Delete" resourcekey="lbCategoriesDeleteResource1"></asp:LinkButton>
									</div>
									<div class="itemActions itemSecondaryActions">
										<asp:LinkButton ID="lbCategoryPermissions" resourcekey="lbCategoryPermissions" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["CategoryID"]%>' CommandName="SetupPermissions" Text="Setup permissions" />
										<asp:LinkButton ID="lbCategoryContentLocalization" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="ContentLocalization" Text="Content Localization" resourcekey="lbMediaContentLocalization" Visible='<%#Convert.ToBoolean(ViewState["EnableLocalization"])%>'></asp:LinkButton>
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="actionsCell" />
							</asp:TemplateField>
							<asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" SortExpression="CategoryID"></asp:BoundField>
							<asp:TemplateField HeaderText="Name" SortExpression="CategoryName">
								<EditItemTemplate>
									<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CategoryName") %>' MaxLength="500"></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:LinkButton ID="lbCategoriesOpenCategoryName" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Open" CssClass="categorycontrollinklight" Text='<%#((DataRowView)Container.DataItem)["CategoryName"] %>' resourcekey="lbCategoriesOpenCategoryNameResource1"></asp:LinkButton>
									<asp:HiddenField ID="hfCategoryID" runat="server" Value='<%#((DataRowView)Container.DataItem)["CategoryID"]%>' />
								</ItemTemplate>
								<HeaderStyle Width="150" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Description">
								<EditItemTemplate>
									<asp:TextBox ID="tbgvCategoryDescriptionEdit" runat="server" Text='<%# Bind("CategoryDescription") %>' TextMode="MultiLine" MaxLength="2000" Height="85" Width="350"></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="lblgvCategoryDescription" runat="server" Text='<%# ((DataRowView)Container.DataItem)["CategoryDescription"] %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle Width="290" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="NumberOfGalleries">
								<ItemTemplate>
									<asp:Label ID="lblCategoryNumberItems" runat="server" Text='<%#((DataRowView)Container.DataItem)["GalleryCount"]%>'></asp:Label>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Position" SortExpression="Position">
								<EditItemTemplate>
									<asp:TextBox ID="tbCategoryPosition" CssClass="xsmall textCenter" runat="server" Text='<%# Bind("Position") %>'></asp:TextBox>
								</EditItemTemplate>
								<FooterTemplate>
									<div class="positionItems">
										<asp:LinkButton ID="btnCategorySavePosition" runat="server" CssClass="savePositions" OnClick="btnCatSavePosition_Click" Text="Save Positions" resourcekey="btnCategorySavePositionResource1" />
										<asp:LinkButton ID="btnRearrangeCategoryPositions" runat="server" CssClass="rearangePositions" OnClick="btnGalPosRearange_Click" ToolTip="Rearrange category positions numbers." resourcekey="btnRearrangeCategoryPositionsResource1" />
									</div>
								</FooterTemplate>
								<ItemTemplate>
									<div>
										<asp:TextBox ID="tbCategoryPosition" runat="server" CssClass="xsmall textCenter" Text='<%#((DataRowView)Container.DataItem)["Position"]%>'></asp:TextBox>
										<asp:LinkButton ID="imgCategoryUp" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["CategoryID"]%>' CommandName="Up" Text="Up" resourcekey="imgCategoryUpResource1" CssClass="move moveUp" />
										<asp:LinkButton ID="imgCategoryDown" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["CategoryID"]%>' CommandName="Down" Text="Down" resourcekey="imgCategoryDownResource1" CssClass="move moveDown" />
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="arrangeItems" />
							</asp:TemplateField>
						</Columns>
						<FooterStyle CssClass="itemsListFooter" />
						<HeaderStyle CssClass="itemsListheader" />
						<PagerStyle CssClass="contentPagination" />
						<EditRowStyle CssClass="editItemState" />
					</asp:GridView>
					<asp:Panel ID="pnlCategoryPermissionSettings" runat="server" Visible="False" CssClass="additionalOptions color1">
						<h2>
							<asp:Label ID="lblPermissionsSettingTitle" resourcekey="lblPermissionsSettingTitle" runat="server" Text="Setup Permissions"></asp:Label>
						</h2>
						<p>
							<asp:Label ID="lblPermissinsCategoryName" resourcekey="lblPermissinsCategoryName" runat="server" Text="Category name: "></asp:Label>
							<asp:Label ID="lblPermissionsCategoryName" runat="server" CssClass="itemName"></asp:Label>
						</p>
						<div id="pnlAllSettings">
							<div id="pnlPermissions" runat="server">
								<asp:GridView ID="gvRolePermisionSettings" runat="server" AutoGenerateColumns="False" CssClass="additionalOptionsList textCenter" DataKeyNames="RoleID" OnRowDataBound="gvRolePermisionSettings_RowDataBound" OnDataBound="gvRolePermisionSettings_DataBound">
									<Columns>
										<asp:TemplateField HeaderText="Roles">
											<ItemTemplate>
												<asp:Label ID="lblRoleName" runat="server" resourcekey="lblRoleNameResource1" Text='<%#Eval("RoleName")%>'></asp:Label>
											</ItemTemplate>
											<ItemStyle CssClass="subjectName" />
											<HeaderStyle CssClass="roleName" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="View">
											<ItemTemplate>
												<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# GetRoleID(Eval("RoleID"))%>' />
												<asp:HiddenField ID="hfCategoryRoleNameView" runat="server" Value='<%# Eval("RoleName") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID='cbCategoryRoleView' data-cid='<%#GetRoleID(Eval("RoleID"))%>' runat="server" CssClass="categoryRoleView" Checked='<%#Convert.ToBoolean(Eval("View"))%>' OnClick='clickAllcheckboxes.call(this,"View");' CausesValidation="True" Text="View" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permView" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Edit">
											<ItemTemplate>
												<asp:HiddenField ID="hfCategoryRoleNameEdit" runat="server" Value='<%# Eval("RoleName") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbCategoryRoleEdit" data-cid='<%#GetRoleID(Eval("RoleID"))%>' CssClass="categoryRoleEdit" runat="server" Checked='<%#Convert.ToBoolean(Eval("Edit"))%>' OnClick='clickAllcheckboxes.call(this,"Edit");' CausesValidation="True" Text="Edit" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
								<asp:GridView ID="gvUserPermisionSettings" runat="server" AutoGenerateColumns="False" CssClass="additionalOptionsList textCenter" DataKeyNames="UserID" OnRowCommand="gvUserPermisionSettings_RowCommand">
									<Columns>
										<asp:TemplateField HeaderText="Users">
											<ItemTemplate>
												<asp:Label ID="lblUserName" runat="server" resourcekey="lblRoleNameResource1" Text='<%#Eval("UserName")%>'></asp:Label>
											</ItemTemplate>
											<ItemStyle CssClass="subjectName" />
											<HeaderStyle CssClass="roleName" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="View">
											<ItemTemplate>
												<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
												<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID='cbCategoryUserView' runat="server" Checked='<%#Convert.ToBoolean(Eval("View"))%>' Text="View" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Edit">
											<ItemTemplate>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbCategoryUserEdit" runat="server" Checked='<%#Convert.ToBoolean(Eval("Edit"))%>' Text="Edit" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="">
											<ItemTemplate>
												<div class="itemActions itemEditActions">
													<asp:LinkButton ID="lbUserPermissionsRemove" resourcekey="lbUserPermissionsRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user?');" Text="Remove" CssClass="itemEditRemove"></asp:LinkButton>
												</div>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
							</div>
							<div class="addSubject">
								<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" />
								<div>
									<asp:Label ID="lblUsernameToAdd" runat="server" resourcekey="lblUsernameToAdd" Text="Add user by username:" CssClass="textBoxAndButtonLabel" />
									<div class="textBoxAndButton">
										<asp:TextBox ID="tbUserNameToAdd" runat="server" />
										<asp:LinkButton ID="lbUsernameAddPermissions" runat="server" OnClick="lbUsernameAddPermissions_Click" resourcekey="lbUsernameAddPermissions" Text="Add" />
									</div>
								</div>
								<asp:HiddenField ID="hfPermissionsCategoryID" runat="server" />
								<asp:HiddenField ID="hfCategoryRolesAndPermisionsView" runat="server" />
								<asp:HiddenField ID="hfCategoryRolesAndPermisionsEdit" runat="server" />
							</div>
							<div class="mainActions">
								<asp:Label ID="lblSaveGalleryPermissionsMessage" runat="server" EnableViewState="False" />
								<asp:LinkButton ID="btnSaveCategoryPermissions" resourcekey="btnSaveCategoryPermissions" runat="server" OnClick="btnSaveCategoryPermissions_Click" Text="Save permissions" OnClientClick="SaveCheckedChekboxes()" CssClass="downSaveClose" />
								<asp:LinkButton ID="btnCategoryPermissionsClose" runat="server" OnClick="btnCategoryPermissionsClose_Click" resourcekey="btnGalleryLocalizationClose" Text="Close" CssClass="downClose" />
							</div>
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlCategoryContentLocalization" runat="server" Visible="False" CssClass="additionalOptions color1">
						<h2>
							<asp:Label ID="lblCategoryContentLocalization" runat="server" resourcekey="lblCategoryContentLocalization" Text="Localize category title and description"></asp:Label>
						</h2>
						<table class="additionalOptionsList fullWidthTable bottomTdBorders textLeft">
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblContentLocalizationCategoryTitle" resourcekey="lblContentLocalizationCategoryTitle" runat="server" Text="Category title:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationCategoryTitleOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblContentLocalizationCategoryDescription" resourcekey="lblContentLocalizationCategoryDescription" runat="server" Text="Category description:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationCategoryDescriptionOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblDefPortalLang" runat="server" Text="Default portal language:"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblDefaultPortalLangugage" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblCategoryLocalizationLocalizedLanguages" runat="server" resourcekey="lblCategoryLocalizationLocalizedLanguages" Text="Translations added for:"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblCategoryLocalizationLocalizedLanguagesList" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblCategoryLocalizationSelectLanguage" runat="server" HelpKey="lblCategoryLocalizationSelectLanguage.HelpText" HelpText="Select the languange you want to edit. There is no need to edit dafault language." ResourceKey="lblCategoryLocalizationSelectLanguage" Text="Select language:" />
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlCategoryLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategoryLocalizationSelectLanguage_SelectedIndexChanged">
											<asp:ListItem Value="0">Select language</asp:ListItem>
										</asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short textTop">
									<dnn:Label ID="lblCategoryLocalizationTitle" runat="server" HelpKey="lblCategoryLocalizationTitle.HelpText" HelpText="Title:" ResourceKey="lblCategoryLocalizationTitle" Text="Title:" />
								</td>
								<td>
									<asp:TextBox ID="tbCategoryLocalizationTitle" runat="server" CssClass="medium"></asp:TextBox>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnCategoryLocalizationCopyDefault" runat="server" OnClick="btnCategoryLocalizationCopyDefault_Click" resourcekey="btnCategoryLocalizationCopyDefault" Text="Copy default values" CssClass="itemEditCopy" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short textTop">
									<dnn:Label ID="lblCategoryLocalizationDescription" runat="server" HelpKey="lblCategoryLocalizationDescription.HelpText" HelpText="Description:" ResourceKey="lblCategoryLocalizationDescription" Text="Description:" />
								</td>
								<td>
									<dnn:TextEditor ID="txtCategoryLocalizationDescription" runat="server" Height="350" Width="600" />
								</td>
							</tr>
						</table>
						<div class="mainActions">
							<asp:Label ID="lblCategoryLocalizationUpdateMessage" runat="server" EnableViewState="False" />
							<asp:LinkButton ID="btnCategoryLocalizationUpdate" resourcekey="btnCategoryLocalizationUpdate" runat="server" Text="Save" OnClick="btnCategoryLocalizationUpdate_Click" CssClass="downSaveClose" />
							<asp:LinkButton ID="btnCategoryLocalizationClose" resourcekey="btnGalleryLocalizationClose" runat="server" Text="Close" OnClick="btnCategoryLocalizationClose_Click" CssClass="downClose" />
						</div>
					</asp:Panel>
				</div>
				<div runat="server" id="categoryItemsPerPage" class="numberOfItemsPerPage">
					<dnn:Label ID="lblNumberofCatlSelect" runat="server" ControlName="ddlNumOfCatSelect" HelpText="Select the number of categories to display on one page:" Text="Categories per page:" ResourceKey="lblNumberofCatlSelect" HelpKey="lblNumberofCatlSelect.HelpText" />
					<div class="styledSelect">
						<asp:DropDownList ID="ddlNumOfCatSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlNumOfCatSelect_SelectedIndexChanged" CssClass="ddlpageitems">
							<asp:ListItem Text="10" resourcekey="ListItemResource6">
							</asp:ListItem>
							<asp:ListItem Text="30" resourcekey="ListItemResource7">
							</asp:ListItem>
							<asp:ListItem Text="50" resourcekey="ListItemResource8">
							</asp:ListItem>
						</asp:DropDownList>
					</div>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlGalleryManagment" runat="server" Visible="False" CssClass="contentSectionWrapper color2">
				<div class="sectionHeader" runat="server">
					<div class="titleAndNumber galleriesTitleAndNumber">
						<h4>
							<asp:Label ID="lblManageGalleriesTitle" resourcekey="lblManageGalleriesTitle" runat="server" Text="Manage &lt;br&gt; galleries"></asp:Label>
						</h4>
						<p>
							<asp:Label ID="lblNumberOfGalleries" runat="server" Text="Number of galleries:" resourcekey="lblNumberOfGalleriesResource1"></asp:Label>
							<asp:Label ID="lblGalleriesNumber" runat="server" CssClass="numberOfItemsInSection" resourcekey="lblGalleriesNumberResource1"></asp:Label>
						</p>
					</div>
					<asp:Panel ID="pnlAddGallery" runat="server" DefaultButton="btnAddGallery" CssClass="headerActionBox">
						<h4>
							<asp:Label ID="lblAddNewGallery" resourcekey="lblAddNewGallery" runat="server" Text="Add NEW Gallery"></asp:Label>
						</h4>
						<div>
							<div>
								<asp:RequiredFieldValidator ID="rfvEnterNewGalleryName" runat="server" ControlToValidate="tbAddGallery" ErrorMessage="Gallery name is required." ValidationGroup="vgAddGalley" Display="Dynamic" CssClass="smallInfo warning" resourcekey="rfvEnterNewGalleryNameResource1.ErrorMessage"></asp:RequiredFieldValidator>
								<dnn:Label ID="lblEnterNewGalleryName" runat="server" ControlName="tbAddGallery" HelpText="Enter the name of new gallery." Text="Gallery name:" ResourceKey="lblEnterNewGalleryName" CssClass="tooltip" HelpKey="lblEnterNewGalleryName.HelpText" />
								<asp:TextBox ID="tbAddGallery" runat="server" ValidationGroup="vgAddGalley" CssClass="box2" defaultbutton="button_id" MaxLength="500"></asp:TextBox>
								<dnn:Label ID="lblEnterNewGalleryDescription" runat="server" ControlName="tbAddGallery" HelpText="Enter the description of new gallery." Text="Gallery description:" ResourceKey="lblEnterNewGalleryDescription" CssClass="tooltip" HelpKey="lblEnterNewGalleryDescription.HelpText" />
								<asp:TextBox ID="tbAddGalleryDescription" runat="server" ValidationGroup="vgAddGalley" CssClass="box2" MaxLength="2000"></asp:TextBox>
								<div id="trGallerysharing" runat="server" visible="false">
									<dnn:Label ID="lblJournalSharing" runat="server" ControlName="tbAddGallery" HelpText="Privacy settings:" Text="Privacy settings:" CssClass="tooltip" HelpKey="lblJournalSharing.HelpText" ResourceKey="dnnUserGalleryPrivacy.Text" />
									<div class="styledSelect">
										<asp:DropDownList ID="ddlPostToJournal" CssClass="ddlvisibility" runat="server" />
									</div>
									<div id="pnlSocialSecuritySelect" runat="server" visible="False" class="paddingTop">
										<dnn:Label ID="lblGallerySocialGroupsCreate" runat="server" CssClass="tooltip" Text="Social groups:" HelpText="Social groups:" />
										<asp:ListBox ID="lbSocialSecurityGroups" runat="server" SelectionMode="Multiple"></asp:ListBox>
									</div>
								</div>
							</div>
							<asp:LinkButton ID="btnAddGallery" runat="server" OnClick="btnAddGallery_Click" ValidationGroup="vgAddGalley" ToolTip="Add Gallery" resourcekey="btnAddGalleryResource1" CssClass="headerActionButton" Text="Add" />
						</div>
					</asp:Panel>
				</div>
				<div id="tblSelCatInGalleries" runat="server" class="selectedCategory">
					<asp:Label ID="lblSelectedCatategory" runat="server" Text="Selected category:" resourcekey="lblSelectedCatategoryResource1"></asp:Label>
					<asp:Label ID="lblSelCatName" runat="server" CssClass="selectedCategoryName" resourcekey="lblSelCatNameResource1"></asp:Label>
				</div>
				<div class="listItems">
					<asp:Label ID="lblGalleryStatusMessage" runat="server" AssociatedControlID="gvGalleries" EnableViewState="False"></asp:Label>
					<asp:Label ID="lblNoGalleryItems" CssClass="infoMessages info static" runat="server" Visible="False"></asp:Label>
					<asp:GridView CssClass="listItemsTable" ID="gvGalleries" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="GalleryID" DataSourceID="odsGalleries" GridLines="None" OnRowCommand="gvGalleries_RowCommand" OnRowDeleted="gvGalleries_RowDeleted" OnRowUpdated="gvGalleries_RowUpdated" OnSelectedIndexChanged="gvGalleries_SelectedIndexChanged" ShowFooter="True" OnRowDeleting="gvGalleries_RowDeleting" EnableModelValidation="True" OnPreRender="gvGalleries_PreRender">
						<Columns>
							<asp:TemplateField>
								<ItemTemplate>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbGallerySelected" runat="server" Text="GallerySelected" />
									</div>
								</ItemTemplate>
								<FooterTemplate>
									<div class="itemActions footerActions">
										<asp:LinkButton ID="lbSelectAll" resourcekey="lbSelectAll" OnClientClick="SelectAllGalleries(); return false;" runat="server" Text="Select all"></asp:LinkButton>
										<asp:LinkButton ID="lbDeselectAll" resourcekey="lbDeselectAll" OnClientClick="DeSelectAllGalleries(); return false;" runat="server" Text="Deselect all"></asp:LinkButton>
										<asp:LinkButton ID="lbMoveGalleries" resourcekey="lbMoveGalleries" runat="server" Text="Move/Copy galleries" OnClick="lbMoveGalleries_Click"></asp:LinkButton>
									</div>
									<asp:Panel ID="pnlMoveMultipleGalleries" runat="server" Visible="false" CssClass="moveMultipleGalleries">
										<div class="styledSelect">
											<asp:DropDownList ID="ddlCategoryMultipleGalleryMove" runat="server" DataSourceID="odsMoveCategories" DataTextField="CategoryName" DataValueField="CategoryID"></asp:DropDownList>
										</div>
										<div class="itemActions itemMoveActions">
											<asp:LinkButton ID="btnmove" runat="server" Text="Move" resourcekey="btnmoveResource1" OnClick="btnmove_Click" CssClass="itemMoveMove" />
											<asp:LinkButton ID="btnCopy" runat="server" Text="Copy" resourcekey="btncopyResource1" OnClick="btnCopy_Click" CssClass="itemMoveCopy" />
											<asp:LinkButton ID="btnCancelMultipleGalleryMove" runat="server" Text="Cancel" OnClick="btnCancelMultipleGalleryMove_Click" CssClass="itemMoveCancel" />
										</div>
									</asp:Panel>
									<div class="positionItems">
										<asp:LinkButton ID="btnGallerySavePositions" runat="server" OnClick="btnGallerySavePositions_Click" resourcekey="btnGallerySavePositionsResource1" Text="Save Positions" CssClass="savePositions" />
										<asp:LinkButton ID="imgbtnrearrangegal" runat="server" OnClick="btnCatPosRearange_Click" resourcekey="imgbtnrearrangegalResource1" ToolTip="Rearrange gallery positions numbers in category." CssClass="rearangePositions" />
									</div>
								</FooterTemplate>
								<ItemStyle CssClass="selectItem" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Actions" InsertVisible="False" ShowHeader="False">
								<EditItemTemplate>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="lbGalleriesUpdate" runat="server" CommandName="Update" Text="Update" resourcekey="lbGalleriesUpdateResource1" CssClass="itemEditUpdate"></asp:LinkButton>
										<asp:LinkButton ID="lbGalleriesCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" resourcekey="lbGalleriesCancelResource1" CssClass="itemEditCancel"></asp:LinkButton>
									</div>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:HiddenField ID="hfGalleryID" runat="server" Value='<%#((DataRowView)Container.DataItem)["GalleryID"]%>' />
									<div class="itemActions itemPrimaryActions">
										<asp:LinkButton ID="lbGalleriesSelect" runat="server" CausesValidation="False" CommandName="Select" Text="Open" resourcekey="lbGalleriesSelectResource1" CssClass="openAction"></asp:LinkButton>
										<asp:LinkButton ID="lbGalleriesEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" resourcekey="lbGalleriesEditResource1" CssClass="editAction"></asp:LinkButton>
										<asp:LinkButton ID="lbGalleriesDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this gallery?');" Text="Delete" resourcekey="lbGalleriesDeleteResource1" CssClass="deleteAction"></asp:LinkButton>
									</div>
									<div class="itemActions itemSecondaryActions">
										<asp:LinkButton ID="lbGalleryPermissions" resourcekey="lbGalleryPermissions" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["GalleryID"]%>' CommandName="SetupPermissions" Text="Setup dates/permissions" Visible="<%#!gms.EnableCommunityMode%>"></asp:LinkButton>
										<asp:LinkButton ID="lbGalleryContentLocalization" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="ContentLocalization" Text="Content Localization" resourcekey="lbGalleryContentLocalization" Visible='<%#Convert.ToBoolean(ViewState["EnableLocalization"])%>'></asp:LinkButton>
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="actionsCell" />
							</asp:TemplateField>
							<asp:BoundField DataField="GalleryID" HeaderText="ID" ReadOnly="True" SortExpression="GalleryID">
								<ItemStyle />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Name" SortExpression="GalleryName">
								<EditItemTemplate>
									<asp:TextBox ID="tbGalleriesEditName" runat="server" Text='<%# Bind("GalleryName") %>'></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:LinkButton ID="lbGalleriesOpenGalleryName" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Open" Text='<%# Bind("GalleryName") %>' resourcekey="lbGalleriesOpenGalleryNameResource1"></asp:LinkButton>
								</ItemTemplate>
								<HeaderStyle Width="120" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Description">
								<EditItemTemplate>
									<asp:TextBox ID="tbgvGalleryDescription" runat="server" Text='<%# Bind("GalleryDescription") %>' Height="85" Width="180" TextMode="MultiLine"></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="lblgvGalleryDescription" runat="server" Text='<%# Bind("GalleryDescription") %>'></asp:Label>
								</ItemTemplate>
								<HeaderStyle Width="180" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="NumberOfItems">
								<ItemTemplate>
									<asp:Label ID="lblGalleriesNumberofItems" runat="server" Text='<%# ((DataRowView)Container.DataItem)["MediaCount"] %>'></asp:Label>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="LastModified" SortExpression="DateLastModified">
								<ItemTemplate>
									<asp:Label ID="lblgvLastModifiedDate" runat="server" Text='<%#EasyDNN.Modules.EasyDNNGallery.DateTimeHelpers.GetTimeFromUtc(Convert.ToDateTime(Eval("DateLastModified")), PortalSettings)%>'></asp:Label>
								</ItemTemplate>
								<ItemStyle CssClass="lastModified" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Position" SortExpression="Position">
								<EditItemTemplate>
									<asp:TextBox ID="tbPosition" runat="server" CssClass="xsmall textCenter" Text='<%# Bind("Position") %>'></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<div>
										<asp:TextBox ID="tbPosition" runat="server" CssClass="xsmall textCenter" Text='<%# Eval("Position") %>'></asp:TextBox>
										<asp:LinkButton ID="ibtGalleriesUp" runat="server" CausesValidation="False" CommandArgument='<%# Eval("GalleryID") %>' CommandName="Up" resourcekey="ibtGalleriesUpResource1" Text="Move" CssClass="move moveUp" />
										<asp:LinkButton ID="ibtGalleriesDown" runat="server" CausesValidation="False" CommandArgument='<%# Eval("GalleryID") %>' CommandName="Down" resourcekey="ibtGalleriesDownResource1" Text="Move" CssClass="move moveDown" />
									</div>
								</ItemTemplate>
								<ItemStyle CssClass="arrangeItems" />
							</asp:TemplateField>
						</Columns>
						<FooterStyle CssClass="itemsListFooter" />
						<HeaderStyle CssClass="itemsListheader" />
						<PagerStyle CssClass="contentPagination" />
						<EditRowStyle CssClass="editItemState" />
					</asp:GridView>
					<asp:Panel ID="pnlGalleryPermissionSettings" runat="server" Visible="False" CssClass="additionalOptions color2">
						<h2>
							<asp:Label ID="lblGalleryPermissionsSettingTitle" resourcekey="lblGalleryPermissionsSettingTitle" runat="server" Text="Gallery Permissions"></asp:Label>
						</h2>
						<p>
							<asp:Label ID="lblPermissinsGalleryNameTitle" resourcekey="lblPermissinsGalleryNameTitle" runat="server" Text="Gallery name:"></asp:Label>
							<asp:Label ID="lblPermissionsGalleryName" runat="server" CssClass="itemName"></asp:Label>
						</p>
						<div id="pnlAllGallerySettings">
							<div id="pnlGalleryPermissions" runat="server">
								<asp:GridView ID="gvGalleryRolePermisionSettings" runat="server" AutoGenerateColumns="False" CssClass="additionalOptionsList textCenter" DataKeyNames="RoleID" OnDataBound="gvGalleryRolePermisionSettings_DataBound" OnRowDataBound="gvGalleryRolePermisionSettings_RowDataBound">
									<Columns>
										<asp:TemplateField HeaderText="Roles">
											<ItemTemplate>
												<asp:Label ID="lblRoleName" runat="server" resourcekey="lblRoleNameResource1" Text='<%#Eval("RoleName")%>'></asp:Label>
											</ItemTemplate>
											<ItemStyle CssClass="subjectName" />
											<HeaderStyle CssClass="roleName" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="View">
											<ItemTemplate>
												<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# GetRoleID(Eval("RoleID"))%>' />
												<asp:HiddenField ID="hfGalleryRoleNameView" runat="server" Value='<%# Eval("RoleName") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbGalleryRoleView" CssClass="galleryRoleView" runat="server" Checked='<%#Convert.ToBoolean(Eval("View"))%>' data-cid='<%#GetRoleID(Eval("RoleID"))%>' OnClick="clickAllGalleryCheckboxes.call(this,&quot;View&quot;);" Text="View" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permView" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Edit">
											<ItemTemplate>
												<asp:HiddenField ID="hfGalleryRoleNameEdit" runat="server" Value='<%# Eval("RoleName") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbGalleryRoleEdit" runat="server" Checked='<%#Convert.ToBoolean(Eval("Edit"))%>' CssClass="galleryRoleEdit" data-cid='<%#GetRoleID(Eval("RoleID"))%>' OnClick="clickAllGalleryCheckboxes.call(this,&quot;Edit&quot;);" Text="Edit" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
								<asp:GridView ID="gvGalleryUserPermisionSettings" runat="server" AutoGenerateColumns="False" CellPadding="0" CssClass="additionalOptionsList textCenter" DataKeyNames="UserID" OnRowCommand="gvGalleryUserPermisionSettings_RowCommand" Style="margin: 0 auto;">
									<Columns>
										<asp:TemplateField HeaderText="Users">
											<ItemTemplate>
												<asp:Label ID="lblUserName" runat="server" resourcekey="lblRoleNameResource1" Text='<%#Eval("UserName")%>'></asp:Label>
											</ItemTemplate>
											<ItemStyle CssClass="subjectName" />
											<HeaderStyle CssClass="roleName" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="View">
											<ItemTemplate>
												<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
												<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbGalleryUserView" runat="server" Checked='<%#Convert.ToBoolean(Eval("View"))%>' Text="View" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Edit">
											<ItemTemplate>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbGalleryUserEdit" runat="server" Checked='<%#Convert.ToBoolean(Eval("Edit"))%>' Text="Edit" />
												</div>
											</ItemTemplate>
											<HeaderStyle CssClass="permEdit" />
										</asp:TemplateField>
										<asp:TemplateField HeaderText="">
											<ItemTemplate>
												<div class="itemActions itemEditActions">
													<asp:LinkButton ID="lbUserPermissionsRemove" runat="server" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user?');" resourcekey="lbUserPermissionsRemove" Text="Remove" CssClass="itemEditRemove"></asp:LinkButton>
												</div>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
							</div>
							<div class="addSubject">
								<asp:Label ID="lblGalleryAdduserMessage" runat="server" EnableViewState="False" />
								<div>
									<asp:Label ID="lblGalleryUsernameToAdd" runat="server" resourcekey="lblUsernameToAdd" Text="Add user by username:" CssClass="textBoxAndButtonLabel" />
									<div class="textBoxAndButton">
										<asp:TextBox ID="tbGalleryUserNameToAdd" runat="server" />
										<asp:LinkButton ID="lbGalleryUsernameAddPermissions" runat="server" OnClick="lbGalleryUsernameAddPermissions_Click" resourcekey="lbUsernameAddPermissions" Text="Add" />
									</div>
								</div>
								<asp:HiddenField ID="hfPermissionsGalleryID" runat="server" />
								<asp:HiddenField ID="hfGalleryRolesAndPermisionsView" runat="server" />
								<asp:HiddenField ID="hfGalleryRolesAndPermisionsEdit" runat="server" />
							</div>
							<table class="additionalOptionsList textCenter modeTime">
								<tr>
									<th colspan="2">
										<asp:Label ID="lblGalleryActiveTitle" resourcekey="lblGalleryActiveTitle" runat="server" CssClass="contenttitle" Font-Bold="True" Text="Draft/publish mode"></asp:Label>
									</th>
								</tr>
								<tr>
									<td class="subjectName">
										<dnn:Label ID="lblGalleryActiveMode" ResourceKey="lblGalleryActiveMode" runat="server" Text="Draft/publish mode:" HelpText="Draft/publish mode."></dnn:Label>
									</td>
									<td>
										<div class="styledRadio">
											<asp:RadioButtonList ID="rblGalleryActiveMode" runat="server" RepeatDirection="Horizontal">
												<asp:ListItem resourcekey="liDraft" Value="False">Draft</asp:ListItem>
												<asp:ListItem resourcekey="liPublish" Value="True">Publish</asp:ListItem>
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
								<tr>
									<td class="subjectName">
										<dnn:Label ID="lblGalleryApproved" runat="server" Text="Approved:" HelpText="Approve gallery."></dnn:Label>
									</td>
									<td>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbGalleryApproved" runat="server" Text="Approved" />
										</div>
									</td>
								</tr>
								<tr>
									<th colspan="2">
										<asp:Label ID="lblGalleryDatesSettingTitle" resourcekey="lblGalleryDatesSettingTitle" runat="server" CssClass="contenttitle" Font-Bold="True" Text="Publish/Expire Date"></asp:Label>
									</th>
								</tr>
								<tr>
									<td class="subjectName">
										<dnn:Label ID="lblGalleryPublishDate" runat="server" Text="Publish date:" HelpText="Gallery publish date."></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbPublishDate" runat="server" CssClass="textCenter" ValidationGroup="vgSaveGalleryPermisions" Width="90px" />
										<asp:Label ID="lblPubDateError" runat="server" Text="Invalid date." Visible="false" EnableViewState="False" />
										<asp:TextBox ID="tbPublishTime" runat="server" CssClass="textCenter" ValidationGroup="vgEditArticle" Width="50px" />
										<asp:RegularExpressionValidator ID="revPublishTIme" runat="server" ControlToValidate="tbPublishTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgSaveGalleryPermisions" />
									</td>
								</tr>
								<tr>
									<td class="subjectName">
										<dnn:Label ID="lblGalleryExpireDate" runat="server" Text="Expire date:" HelpText="Gallery expire date."></dnn:Label>
									</td>
									<td>
										<asp:TextBox ID="tbExpireDate" runat="server" CssClass="textCenter" ValidationGroup="vgSaveGalleryPermisions" Width="90px" />
										<asp:Label ID="lblExpireDateError" runat="server" Text="Invalid date." Visible="false" CssClass="smallInfo warning" />
										<asp:TextBox ID="tbExpireTime" runat="server" CssClass="textCenter" ValidationGroup="vgSaveGalleryPermisions" Width="50px" />
										<asp:RegularExpressionValidator ID="revPublishTIme0" runat="server" ControlToValidate="tbExpireTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgSaveGalleryPermisions" />
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<asp:Label ID="lblGalleryDatesPermissionsSaveMessage" runat="server" EnableViewState="False" />
										<asp:Label ID="lblMainDateMessage" runat="server" EnableViewState="False" />
									</td>
								</tr>
							</table>
							<div class="mainActions">
								<asp:LinkButton ID="btnSaveGalleryPermissions" resourcekey="btnSaveGalleryPermissions" runat="server" OnClick="btnSaveGalleryPermissions_Click" OnClientClick="SaveGalleryCheckedChekboxes()" Text="Save" ValidationGroup="vgSaveGalleryPermisions" CssClass="downSaveClose" />
								<asp:LinkButton ID="btnGalleryPermissionsClose" runat="server" OnClick="btnGalleryPermissionsClose_Click" resourcekey="btnGalleryLocalizationClose" Text="Close" CssClass="downClose" />
							</div>
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlGalleryContentLocalization" runat="server" Visible="False" CssClass="additionalOptions color2">
						<h2>
							<asp:Label ID="lblGalleryContentLocalization" runat="server" resourcekey="lblGalleryContentLocalization" Text="Translate gallery title and description"></asp:Label>
						</h2>
						<table class="additionalOptionsList fullWidthTable bottomTdBorders textLeft">
							<tr>
								<td class="subjectName short textTop">
									<asp:Label ID="lblContentLocalizationGalleryTitle" resourcekey="lblContentLocalizationGalleryTitle" runat="server" Text="Gallery title:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationGalleryTitleOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short textTop">
									<asp:Label ID="lblContentLocalizationGalleryDescription" resourcekey="lblContentLocalizationGalleryDescription" runat="server" Text="Gallery description:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationGalleryDescriptionOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblDefPortalLangGal" resourcekey="lblDefPortalLangGal" runat="server" Text="Default portal language:"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblDefaultPortalLangugageGal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblGalleryLocalizationLocalizedLanguages" runat="server" resourcekey="lblGalleryLocalizationLocalizedLanguages" Text="Localized languages:"></asp:Label>
								</td>
								<td align="left">
									<asp:Label ID="lblGalleryLocalizationLocalizedLanguagesList" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblGalleryLocalizationSelectLanguage" runat="server" HelpKey="lblContentLocalizationSelectLanguage.HelpText" ResourceKey="lblGalleryLocalizationSelectLanguage" HelpText="Select the languange you want to edit. There is no need to edit dafault language." Text="Select language:" />
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlGalleryLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGalleryLocalizationSelectLanguage_SelectedIndexChanged">
											<asp:ListItem Value="0">Select language</asp:ListItem>
										</asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblGalleryLocalizationTitle" runat="server" HelpKey="lblGalleryLocalizationTitle.HelpText" HelpText="Title:" ResourceKey="lblGalleryLocalizationTitle" Text="Title:" />
								</td>
								<td>
									<asp:TextBox ID="tbGalleryLocalizationTitle" runat="server" CssClass="medium"></asp:TextBox>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnGalleryLocalizationCopyDefault" runat="server" OnClick="btnGalleryLocalizationCopyDefault_Click" resourcekey="btnGalleryLocalizationCopyDefault" Text="Copy default values" CssClass="itemEditCopy" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short textTop">
									<dnn:Label ID="lblGalleryLocalizationDescription" runat="server" HelpKey="lblGalleryLocalizationDescription.HelpText" HelpText="Description:" ResourceKey="lblGalleryLocalizationDescription" Text="Description:" />
								</td>
								<td>
									<dnn:TextEditor ID="txtGalleryLocalizationDescription" runat="server" Height="350" Width="600" />
								</td>
							</tr>
						</table>
						<asp:Label ID="lblGallerLocalizationMessage" runat="server" EnableViewState="False"></asp:Label>
						<div class="mainActions">
							<asp:LinkButton ID="btnGalleryLocalizationUpdate" resourcekey="btnGalleryLocalizationUpdate" runat="server" Text="Update" OnClick="btnGalleryLocalizationUpdate_Click" CssClass="downSaveClose" />
							<asp:LinkButton ID="btnGalleryLocalizationClose" resourcekey="btnGalleryLocalizationClose" runat="server" Text="Close" OnClick="btnGalleryLocalizationClose_Click" CssClass="downClose" />
						</div>
					</asp:Panel>
				</div>
				<div runat="server" id="tblNumOfGalSelect" class="numberOfItemsPerPage">
					<asp:Panel ID="pnlGalleryViewOptions" runat="server">
						<dnn:Label ID="lblNumberofGalleriesPerPage" runat="server" ControlName="ddlNumOfGalSelect" HelpText="Select the number of galleries to to display on one page:" Text="Items per page:" ResourceKey="lblNumberofGalleriesPerPage" CssClass="labeltext" HelpKey="lblNumberofGalleriesPerPage.HelpText" />
						<div class="styledSelect">
							<asp:DropDownList ID="ddlNumOfGalSelect" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlNumOfGalSelect_SelectedIndexChanged">
								<asp:ListItem resourcekey="ListItemResource9" Text="10">
								</asp:ListItem>
								<asp:ListItem resourcekey="ListItemResource10" Text="30">
								</asp:ListItem>
								<asp:ListItem resourcekey="ListItemResource11" Text="50">
								</asp:ListItem>
							</asp:DropDownList>
						</div>
					</asp:Panel>
				</div>
				<%--<div id="divSaveCloseButtons" runat="server" class="mainActions">
					<asp:LinkButton ID="btnSaveCloseDown" runat="server" OnClick="btnCloseMM_Click" Text="Save & Close" resourcekey="btnSaveClose.Text" CssClass="downSaveClose" />
					<asp:LinkButton ID="btnCloseDown" runat="server" OnClick="btnCloseMM_Click" Text="Close" resourcekey="btnCloseResource1.Text" CssClass="downClose" />
				</div>--%>
			</asp:Panel>
			<asp:Panel ID="pnlMediaManagerWrapper" runat="server" Enabled="False" Visible="False" CssClass="contentSectionWrapper color3">
				<div class="sectionHeader">
					<div class="titleAndNumber mediaManagerTitleAndNumber">
						<h4>
							<asp:Label ID="lblMediaManagerTitle" resourcekey="lblMediaManagerTitle" runat="server" Text="Media &lt;br&gt; Manager"></asp:Label>
						</h4>
						<p>
							<asp:Label ID="lblAddEditDelete" resourcekey="lblAddEditDelete" runat="server" Text="Add | Edit | Delete"></asp:Label>
							<asp:Label ID="lblImagesVideoAudio" resourcekey="lblImagesVideoAudio" runat="server" Text="Images | Video | Audio" CssClass="numberOfItemsInSection"></asp:Label>
						</p>
					</div>
					<div class="headerActionBox userGalleryPrivacyWrapper" id="pnlUserGalleryPrivacy" runat="server" visible="false">
						<table class="userGalleryPrivacy">
							<tr>
								<td class="labels">
									<dnn:Label ID="dnnUserGalleryPrivacy" runat="server" ControlName="tbAddGallery" HelpText="lblJournalSharing.HelpText" Text="Privacy settings:" CssClass="tooltip" HelpKey="Privacy settings:" ResourceKey="dnnUserGalleryPrivacy" />
								</td>
								<td class="textLeft">
									<div class="styledSelect">
										<asp:DropDownList ID="ddlPostToJournalSettings" CssClass="ddlvisibility" runat="server" />
									</div>
								</td>
							</tr>
							<tr id="divGalleryGroups" runat="server" visible="False">
								<td class="labels">
									<dnn:Label ID="lblGallerySocialSecurityGroups" runat="server" CssClass="tooltip" Text="Social groups:" HelpText="Social groups:" />
								</td>
								<td class="textLeft">
									<asp:ListBox ID="lbGallerySocialSecurityGroups" runat="server" SelectionMode="Multiple"></asp:ListBox>
								</td>
							</tr>
							<tr id="trSaveGallerySharing" runat="server" visible="False">
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveGallerySharing" resourcekey="btnSaveGallerySharing" runat="server" Text="Save" CssClass="itemEditUpdate" OnClick="btnSaveGallerySharing_Click" />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<asp:Panel ID="pnlMediaListingWrapper" runat="server">
					<div class="headerActionBox elementInlineBlock" id="movecopyGal" runat="server">
						<h4>
							<asp:Label ID="lblMoveCopyTitle" resourcekey="lblMoveCopyTitle" runat="server" CssClass="MoveCopyTitle" Text="Move or copy gallery to another category:"></asp:Label>
						</h4>
						<div>
							<div class="styledSelect">
								<asp:DropDownList ID="ddlCategoryMove" runat="server" CssClass="inputboxmovecopy" DataSourceID="odsMoveCategories" DataTextField="CategoryName" DataValueField="CategoryID"></asp:DropDownList>
							</div>
							<asp:LinkButton ID="btncopy0" runat="server" Text="Copy" OnClick="btncopy_Click" resourcekey="btncopyResource1" CssClass="headerActionButton moveCopy" />
							<asp:LinkButton ID="btnmove0" runat="server" Text="Move" OnClick="btnMoveGallery_Click" resourcekey="btnmoveResource1" CssClass="headerActionButton moveCopy" />
						</div>
					</div>
					<div id="showCatName" runat="server">
						<div class="selectedCategory selectedCategoryMediaManager">
							<asp:Label ID="lblSelectedCatName" runat="server" Text="Selected category name:" resourcekey="lblSelectedCatNameResource1"></asp:Label>
							<asp:Label ID="lblSelCatNameAtMediaManager" runat="server" CssClass="selectedCategoryName" resourcekey="lblSelCatNameAtMediaManagerResource1"></asp:Label>
						</div>
						<br>
						<div class="selectedCategory">
							<asp:Label ID="lblSelectedGalleryNameTitle" runat="server" Text="Selected Gallery Name:" resourcekey="lblSelectedGalleryNameTitleResource1"></asp:Label>
							<asp:Label ID="lblSelectedGalleryName" runat="server" CssClass="selectedCategoryName" resourcekey="lblSelectedGalleryNameResource1"></asp:Label>
						</div>
					</div>
					<p class="numberOfMediaFiles">
						<asp:Label ID="lblNumberOfMediaFiles" runat="server" Text="Number of media files in gallery:" CssClass="labeltext2" resourcekey="lblNumberOfMediaFilesResource1"></asp:Label>
						<asp:Label ID="lblImagesNumber" runat="server" CssClass="labeltext2" resourcekey="lblImagesNumberResource1"></asp:Label>
					</p>
					<div class="listItems">
						<asp:Label ID="lblMedidaManagerMessage" runat="server" AssociatedControlID="gvGalleryImages" EnableViewState="False"></asp:Label>
						<asp:Label ID="lblNoMediaItems" CssClass="infoMessages info static" runat="server" Visible="False"></asp:Label>
						<asp:GridView ID="gvGalleryImages" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="listItemsTable" DataKeyNames="PictureID" DataSourceID="odsGalleryImages" OnPreRender="gvGalleryImages_PreRender" OnRowCancelingEdit="gvGalleryImages_RowCancelingEdit" OnRowCommand="gvGalleryImages_RowCommand" OnRowDeleted="gvGalleryImages_RowDeleted" OnRowEditing="gvGalleryImages_RowEditing" OnRowUpdated="gvGalleryImages_RowUpdated" ShowFooter="True" GridLines="Horizontal" OnRowDeleting="gvGalleryImages_RowDeleting1">
							<Columns>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbMediaSelected" CssClass="EGMediaSelect" resourcekey="cbSelected" runat="server" Text="Select" />
										</div>
									</ItemTemplate>
									<FooterTemplate>
										<div class="itemActions footerActions">
											<asp:LinkButton ID="lbSelectAll" resourcekey="lbSelectAll" OnClientClick="SelectAllMedia(); return false;" runat="server" Text="Select all"></asp:LinkButton>
											<asp:LinkButton ID="lbDeselectAll" resourcekey="lbDeselectAll" OnClientClick="DeSelectAllMedia(); return false;" runat="server" Text="Deselect all"></asp:LinkButton>
											<asp:LinkButton ID="lbDeleteSelected" resourcekey="lbDeleteSelected" runat="server" Text="Delete Selected" CommandName="DeleteSelected"></asp:LinkButton>
											<asp:LinkButton ID="lbMoveSelected" resourcekey="lbMoveSelected" runat="server" Text="Copy/Move Selected" CommandName="MoveSelected"></asp:LinkButton>
										</div>
										<div class="positionItems">
											<asp:LinkButton ID="btnMediaSavePositions" runat="server" OnClick="btnSavePositions_Click" Text="Save Positions" ToolTip="Save Positions" resourcekey="btnMediaSavePositionsResource1" CssClass="savePositions" />
											<asp:LinkButton ID="rearangeMediaPositions" runat="server" OnClick="btnOrgPozicije_Click" ToolTip="Rearrange media positions numbers in gallery." CssClass="rearangePositions" />
										</div>
									</FooterTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Action" ShowHeader="False">
									<EditItemTemplate>
										<div class="itemActions itemEditActions">
											<asp:LinkButton ID="lbMediaUpdate" runat="server" CommandName="Update" Text="Update" resourcekey="lbMediaUpdateResource1" CssClass="itemEditUpdate"></asp:LinkButton>
											<asp:LinkButton ID="lbMediaCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" resourcekey="lbMediaCancelResource1" CssClass="itemEditCancel"></asp:LinkButton>
										</div>
									</EditItemTemplate>
									<ItemTemplate>
										<div class="itemActions itemSecondaryActions">
											<asp:LinkButton ID="lbMediaEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Quick Edit" resourcekey="lbMediaEditResource1"></asp:LinkButton>
										</div>
										<div class="itemActions itemPrimaryActions">
											<asp:LinkButton ID="lbMediaSelect" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' CommandName="Open" Text="Open in editor" resourcekey="lbMediaSelectResource1" CssClass="openAction"></asp:LinkButton>
										</div>
										<div class="itemActions itemPrimaryActions">
											<asp:LinkButton ID="lbMediaDelete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this media?');" Text="Delete" resourcekey="lbMediaDeleteResource1" CssClass="deleteAction"></asp:LinkButton>
										</div>
										<div class="itemActions itemSecondaryActions">
											<asp:LinkButton ID="lbMediaMove" runat="server" CausesValidation="False" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Move" Text="Move/Copy" resourcekey="lbMediaMoveResource1"></asp:LinkButton>
											<asp:LinkButton ID="lbMediaContentLocalization" runat="server" CausesValidation="False" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' CommandName="ContentLocalization" Text="Content Localization" resourcekey="lbMediaContentLocalization" Visible='<%#Convert.ToBoolean(ViewState["EnableLocalization"])%>'></asp:LinkButton>
										</div>
										<asp:HiddenField ID="hfMediaID" runat="server" Value='<%#((DataRowView)Container.DataItem)["PictureID"]%>' />
									</ItemTemplate>
									<ItemStyle CssClass="actionsCell" />
								</asp:TemplateField>
								<asp:BoundField DataField="PictureID" HeaderText="ID" ReadOnly="True">
									<ItemStyle />
								</asp:BoundField>
								<asp:BoundField DataField="GalleryID" HeaderText="GalleryID" ReadOnly="True" Visible="False" />
								<asp:TemplateField HeaderText="Title" SortExpression="Title">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:HiddenField ID="hfMediaEnabled" runat="server" Value='<%# ((DataRowView)Container.DataItem)["MediaApproved"] %>' />
										<asp:LinkButton ID="lbMediaTitleOpen" runat="server" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' CommandName="Open" CssClass="gallerycontrollinklight" Text='<%# Bind("Title") %>' resourcekey="lbMediaTitleOpenResource1"></asp:LinkButton>
									</ItemTemplate>
									<HeaderStyle Width="110" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Description">
									<EditItemTemplate>
										<asp:TextBox ID="tbMediaEditDescription" runat="server" Height="150px" Text='<%# Bind("Description") %>' TextMode="MultiLine" Width="120px"></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblMediaDescription" runat="server" Text='<%# ((DataRowView)Container.DataItem)["Description"]%>' resourcekey="lblMediaDescriptionResource1"></asp:Label>
									</ItemTemplate>
									<HeaderStyle Width="150" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Thumbnail">
									<ItemTemplate>
										<asp:HyperLink ID="hlMediaThumbnailOpen" runat="server" NavigateUrl='<%#((DataRowView)Container.DataItem)["MediaType"].ToString()=="Embeded Video"?"": ((DataRowView)Container.DataItem)["FileName"] %>' Target="_blank" resourcekey="hlMediaThumbnailOpenResource1" CssClass="thumbnail">
											<asp:Image ID="Image1" runat="server" Width='<%#GetWidth(Eval("Info"))%>' Height='<%#GetHeight(Eval("Info"))%>' ImageUrl='<%# GetThumbnailURL(Eval("ThumbUrl"),Eval("Info"),Eval("FileName")) %>' />
										</asp:HyperLink>
										<asp:Label ID="lblMediaImageUrl" runat="server" Text='<%# ((DataRowView)Container.DataItem)["ImageUrl"]%>' resourcekey="lblMediaImageUrlResource1"></asp:Label>
									</ItemTemplate>
									<ItemStyle CssClass="thumbnailCell" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Position" SortExpression="Position">
									<EditItemTemplate>
										<asp:TextBox ID="tbMediaPosition" runat="server" CssClass="xsmall textCenter" Text='<%#Bind("Position")%>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<div>
											<asp:TextBox ID="tbMediaPosition" runat="server" CssClass="xsmall textCenter" Text='<%#((DataRowView)Container.DataItem)["Position"]%>'></asp:TextBox>
											<asp:LinkButton ID="imbMediaUp" runat="server" CausesValidation="False" CommandArgument='<%# ((DataRowView)Container.DataItem)["PictureID"] %>' CommandName="Up" Text="Up" resourcekey="imbMediaUpResource1" CssClass="move moveUp" />
											<asp:LinkButton ID="imbMediaDown" runat="server" CausesValidation="False" CommandArgument='<%# ((DataRowView)Container.DataItem)["PictureID"] %>' CommandName="Down" Text="Down" resourcekey="imbMediaDownResource1" CssClass="move moveDown" />
										</div>
									</ItemTemplate>
									<ItemStyle CssClass="arrangeItems" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Type" SortExpression="MediaType">
									<ItemTemplate>
										<asp:Label ID="lblMediaType" runat="server" Text='<%#((DataRowView)Container.DataItem)["MediaType"]%>' CssClass='<%# String.Format("mediaType type{0}", (((DataRowView)Container.DataItem)["MediaType"]).ToString().Replace(" ",""))%>'></asp:Label>
									</ItemTemplate>
									<ControlStyle />
									<FooterStyle />
									<HeaderStyle />
									<ItemStyle />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Approved" SortExpression="MediaApproved">
									<ItemTemplate>
										<asp:Label ID="lblApproved" runat="server" Text="Approved" Visible='<%#Convert.ToBoolean(GetApproved(Eval("MediaApproved")))%>' CssClass="approveState approved" />
										<asp:Label ID="lblUnapproved" runat="server" Text="Unapproved" Visible='<%#!Convert.ToBoolean(GetApproved(Eval("MediaApproved")))%>' CssClass="approveState unapproved" />
										<asp:Panel runat="server" ID="pnlApproveMediaCommands" Visible='<%#EnableApprove%>'>
											<asp:LinkButton ID="lbApprove" CssClass="approveLink approve" runat="server" CommandName="Approve" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' Visible='<%#!Convert.ToBoolean(GetApproved(Eval("MediaApproved")))%>' Text="Approve" resourcekey="lbApprove" CausesValidation="False"></asp:LinkButton>
											<asp:LinkButton ID="lbUnApprove" CssClass="approveLink unApprove" runat="server" CommandName="Unapprove" CommandArgument='<%#((DataRowView)Container.DataItem)["PictureID"]%>' Visible='<%#Convert.ToBoolean(GetApproved(Eval("MediaApproved")))%>' Text="Unapprove" resourcekey="lbUnApprove" CausesValidation="False"></asp:LinkButton>
										</asp:Panel>
										<asp:Label ID="lblUploadedBy" runat="server" resourcekey="lblUploadedBy" Text="Uploaded by:"></asp:Label>
										<asp:Label ID="lblUserName" runat="server" CssClass="approvedUserName" Text='<%#GetUserName(Eval("UserID"))%>'></asp:Label>
									</ItemTemplate>
									<ItemStyle CssClass="approveCell" />
								</asp:TemplateField>
							</Columns>
							<FooterStyle CssClass="itemsListFooter" />
							<HeaderStyle CssClass="itemsListheader" />
							<PagerStyle CssClass="contentPagination" />
							<EditRowStyle CssClass="editItemState" />
						</asp:GridView>
						<div runat="server" id="mediaItemsPerPage" class="numberOfItemsPerPage">
							<dnn:Label ID="lblNumberOfMediaPerPage" runat="server" Text="Items per page:" HelpText="Select the number of items to display on one page." ResourceKey="lblNumberOfMediaPerPage" CssClass="labeltext" HelpKey="lblNumberOfMediaPerPage.HelpText"></dnn:Label>
							<div class="styledSelect">
								<asp:DropDownList ID="ddlImagesPerPage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImagesPerPage_SelectedIndexChanged" CssClass="ddlpageitems">
									<asp:ListItem Text="10" resourcekey="ListItemResource12">
									</asp:ListItem>
									<asp:ListItem Text="30" resourcekey="ListItemResource13">
									</asp:ListItem>
									<asp:ListItem Text="50" resourcekey="ListItemResource14">
									</asp:ListItem>
								</asp:DropDownList>
							</div>
						</div>
					</div>
					<asp:Panel ID="pnlMediaUpload" runat="server">
						<asp:Label ID="lblUploadMediaStatus" runat="server" Visible="False" resourcekey="lblUploadMediaStatusResource1">
						</asp:Label>
						<ul class="mediaSelect">
							<li class="imageUpload">
								<asp:LinkButton ID="imgSelectImageUpload" runat="server" Text="images" OnClick="imgSelectImageUpload_Click" resourcekey="imgSelectImageUploadResource1" CssClass="active" />
							</li>
							<li class="videoUpload">
								<asp:LinkButton ID="imgSelectVidoeUpload" runat="server" Text="video" OnClick="imgSelectVidoeUpload_Click" resourcekey="imgSelectVidoeUploadResource1" />
							</li>
							<li class="audioUpload">
								<asp:LinkButton ID="imgSelectAudioUpload" runat="server" Text="audio" OnClick="imgSelectAudioUpload_Click" resourcekey="imgSelectAudioUploadResource1" />
							</li>
						</ul>
						<asp:Panel ID="pnlImageUploadContainer" runat="server" CssClass="contentSection imageUpload">
							<div class="specialOptions">
								<h2>
									<asp:Label ID="lblAddImages" resourcekey="lblAddImages" runat="server" Text="Add&lt;br&gt;images"></asp:Label>
								</h2>
								<asp:Label ID="lblUploadImageHeader" resourcekey="lblUploadImageHeader" runat="server" Text="Upload" CssClass="optionsListLabel"></asp:Label>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblImageUploadType" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblUpload_SelectedIndexChanged" RepeatDirection="Horizontal">
										<asp:ListItem resourcekey="ListItemResource15" Text="Upload single image" Value="single"></asp:ListItem>
										<asp:ListItem resourcekey="MultiImageUpload" Value="multi">Multi image upload</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource16" Text="Upload Zip file" Value="zip"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource17" Text="Add images from server folder" Value="imagefolder"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
							</div>
							<asp:Panel ID="pnlImageSettings" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblSingleImageTitle" runat="server" Text="Single image upload" resourcekey="lblSingleImageTitleResource1" CssClass="singleImageUplad"></asp:Label>
								</h4>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblSingleImageUploadSelectSource" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="rblSIUSelction_SelectedIndexChanged" CssClass="styledRadio">
										<asp:ListItem Selected="True" Text="Upload" resourcekey="ListItemResource37"></asp:ListItem>
										<asp:ListItem Value="server" Text="Add from server folder" resourcekey="ListItemResource38"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<asp:Panel ID="pnlSIUCOmp" runat="server" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadSelectFile" ResourceKey="lblSingleImageUploadSelectFile" runat="server" HelpText="Select image file to upload:" Text="Image file to upload:" HelpKey="lblSingleImageUploadSelectFile.HelpText" />
											</td>
											<td>
												<asp:FileUpload ID="fuImageUpload" runat="server" />
											</td>
										</tr>
									</table>
								</asp:Panel>
								<asp:Panel ID="pnlSIUAddfromServer" runat="server" Visible="False" CssClass="optionsPanel">
									<table>
										<tr>
											<th>
												<asp:Label ID="lblSingleImageUploadServerTitle" runat="server" Text="Add  images from server folder:" resourcekey="lblSingleImageUploadServerTitleResource1"></asp:Label>
											</th>
											<th></th>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadServerSelectFolder" ResourceKey="lblSingleImageUploadServerSelectFolder" runat="server" Text="Select folder:" HelpText="Select folder:" HelpKey="lblSingleImageUploadServerSelectFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSIUSelectfolder" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CausesValidation="True" OnSelectedIndexChanged="ddlSIUSelectfolder_SelectedIndexChanged">
														<asp:ListItem Value="\" Text="Root" resourcekey="ListItemResource39"></asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadServerSelectFile" ResourceKey="lblSingleImageUploadServerSelectFile" runat="server" Text="Select image file to add:" HelpText="Select image file to add:" HelpKey="lblSingleImageUploadServerSelectFile.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlSIUSelectFile" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadServerShowMainGalleryFolder" ResourceKey="lblSingleImageUploadServerShowMainGalleryFolder" runat="server" Text="Show main gallery folder:" HelpText="Add main EasyDNN gallery folder to folders list:" HelpKey="lblSingleImageUploadServerShowMainGalleryFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSIUShowMinGalFOlder" runat="server" AutoPostBack="True" OnCheckedChanged="cbSIUShowMinGalFOlder_CheckedChanged" CausesValidation="True" resourcekey="cbSIUShowMinGalFOlderResource1" Text="Show main gallery folder" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadServerDeleteOriginal" ResourceKey="lblSingleImageUploadServerDeleteOriginal" runat="server" HelpText="File will be copied to gallery folder. Delete original file:" Text="Delete original file:" HelpKey="lblSingleImageUploadServerDeleteOriginal.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbSIUDeleteOriginalFile" runat="server" CausesValidation="True" resourcekey="cbSIUDeleteOriginalFileResource1" Text="Delete original file" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadTitle" ResourceKey="lblSingleImageUploadTitle" runat="server" HelpText="Enter the image title:" Text="Image title:" HelpKey="lblSingleImageUploadTitle.HelpText" />
											</td>
											<td>
												<div id="SIUTitleTextBox" runat="server">
													<asp:TextBox ID="tbImageTitle" runat="server" ValidationGroup="Validationg1" MaxLength="250" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivUseFilenameCB" runat="server" cssclass="styledCheckbox">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbSingleImageUploadFilenameAsTitle" runat="server" Text="Use filename as title" resourcekey="cbSingleImageUploadFilenameAsTitleResource1" />
													</div>
												</div>
												<div id="SIUTitleFeomFilename" runat="server" style="display: none">
													<asp:Panel ID="pnlIUFilenameasTitle" runat="server">
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
															<asp:ListItem Value="AllUppercase" Text="Set this to change title to uppercase" resourcekey="ListItemResource40"></asp:ListItem>
															<asp:ListItem Value="AllLowercase" Text="Set this to change title to lowercase" resourcekey="ListItemResource41"></asp:ListItem>
															<asp:ListItem Value="AllFirstUppercase" Text="Set this to change first letter of every word in title to uppercase" resourcekey="ListItemResource42"></asp:ListItem>
															<asp:ListItem Value="FirstUppercase" Text="Set this to change first letter of title to uppercase" resourcekey="ListItemResource43"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
												<div id="DivUseExifMetada" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbSingleImageUploadTitleUseMetadata" runat="server" Text="Use Exif metadata as title" resourcekey="cbSingleImageUploadTitleUseMetadataResource1" />
													</div>
												</div>
												<div id="DivSIUseExifMetadata" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cblSingleImageUploadTitleUseMetadataOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbSingleImageSubtitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadDescription" ResourceKey="lblSingleImageUploadDescription" runat="server" HelpText="Enter the image description." Text="Description:" HelpKey="lblSingleImageUploadDescription.HelpText" />
											</td>
											<td>
												<div id="DivSIDescriptionTextBox" runat="server">
													<asp:TextBox ID="tbImageDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivSIUseMetadataDescription" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbSingleImageUploadseExifMetadataDescription" runat="server" Text="Use Exif metadata as description" resourcekey="cbSingleImageUploadseExifMetadataDescriptionResource1" />
													</div>
												</div>
												<div id="DivSIUseExifMetadataDescriptionOptions" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cbSingleImageUploadseExifMetadataDescriptionOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblSingleUmageUploadUrl" ResourceKey="lblSingleUmageUploadUrl" runat="server" HelpText="Enter url for media link:" Text="Enter url:" HelpKey="lblSingleUmageUploadUrl.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbSIImageUrl" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr id="trSiUploadImageResize" runat="server">
											<td class="labels">
												<dnn:Label ID="lblSingleImageUploadResize" ResourceKey="lblSingleImageUploadResize" runat="server" Text="Resize image:" HelpText="Proportionaly resize uploaded image:" HelpKey="lblSingleImageUploadResize.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbImageUploadResize" runat="server" OnCheckedChanged="cbImageUploadResize_CheckedChanged" resourcekey="cbImageUploadResizeResource1" Text="ImageUploadResize" />
												</div>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<div id="divSIUResize" runat="server" style="display: none">
													<asp:Panel ID="pnlImageUploadResize" runat="server">
														<table>
															<tr>
																<td>
																	<asp:Label ID="lblImageUploadResizeWidth" runat="server" Text="Max width:" resourcekey="lblImageUploadResizeWidthResource1"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbImageUploadResizeWidth" runat="server" Text="800" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResize" runat="server" ControlToValidate="tbImageUploadResizeWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageUpload" resourcekey="cvImagerResizeResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUpload" runat="server" ControlToValidate="tbImageUploadResizeWidth" ErrorMessage="This filed is required." ValidationGroup="vgImageUpload" resourcekey="rfvImageUploadResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td>
																	<asp:Label ID="lblImageUploadResizeHeight" runat="server" Text="Max height:" resourcekey="lblImageUploadResizeHeightResource1"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbImageUploadResizeHeight" runat="server" Text="600" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResizeHeight" runat="server" ControlToValidate="tbImageUploadResizeHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgImageUpload" resourcekey="cvImagerResizeHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUploadHeight" runat="server" ControlToValidate="tbImageUploadResizeHeight" ErrorMessage="This filed is required." ValidationGroup="vgImageUpload" resourcekey="rfvImageUploadHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td colspan="2">
																	<div class="styledCheckbox">
																		<asp:CheckBox ID="cbSIUOriginalAsDownload" runat="server" Text="Use unresized image as download version." />
																	</div>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<asp:Label ID="Label2" runat="server" Text="Image Format:" Visible="False" resourcekey="Label2Resource1"></asp:Label>
											</td>
											<td>
												<asp:Label ID="lblFileName" runat="server" Visible="False" resourcekey="lblFileNameResource1"></asp:Label>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblSingleImageUploadMessage" runat="server" EnableViewState="False" AssociatedControlID="btnSingleImageUpload"></asp:Label>
											</td>
										</tr>
									</table>
									<div class="mainActions color1">
										<asp:LinkButton ID="btnSingleImageUpload" runat="server" OnClick="btnUploadImage_Click" Text="Upload image file" ValidationGroup="vgImageUpload" resourcekey="btnSingleImageUploadResource1" CssClass="upload" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlMultiImageUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblMultiImageTitle" resourcekey="lblMultiImageTitle" runat="server" CssClass="multiImageUplad" Text="Multi image upload"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiImageUploadTitle" runat="server" HelpText="Enter the image title:" ResourceKey="lblSingleImageUploadTitle" HelpKey="lblSingleImageUploadTitle.HelpText" Text="Image title:" />
											</td>
											<td>
												<div id="MIUTitleTextBox" runat="server">
													<asp:TextBox ID="tbMultiImageTitle" runat="server" MaxLength="250" ValidationGroup="Validationg1" CssClass="large"></asp:TextBox>
												</div>
												<div id="MultiDivUseFilenameCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiImageUploadFilenameAsTitle" runat="server" resourcekey="cbSingleImageUploadFilenameAsTitleResource1" Text="Use filename as title" />
													</div>
												</div>
												<div id="MIUTitleFeomFilename" runat="server" style="display: none">
													<asp:Panel ID="pnlMIUFilenameasTitle" runat="server">
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiImageUploadRemoveExtenzion" runat="server" resourcekey="cbSingleImageUploadRemoveExtenzionResource1" Text="Remove extension" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiImageUploadTitleReplaceUnderscore" runat="server" resourcekey="cbSingleImageUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiImageUploadTitleReplaceMinus" runat="server" resourcekey="cbSinbleImageUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
														</div>
														<asp:RadioButtonList ID="rblMultiImageUploadFilenameTitleOptions" runat="server" CssClass="styledRadio small">
															<asp:ListItem resourcekey="ListItemResource40" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource41" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource42" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource43" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
												<div id="MultiDivUseExifMetada" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiImageUploadTitleUseMetadata" runat="server" resourcekey="cbSingleImageUploadTitleUseMetadataResource1" Text="Use Exif metadata as title" />
													</div>
												</div>
												<div id="MultiDivSIUseExifMetadata" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cblMultiImageUploadTitleUseMetadataOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiImageSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbMultiImageSubtitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiImageUploadDescription" runat="server" HelpKey="lblSingleImageUploadDescription.HelpText" HelpText="Enter the image description." ResourceKey="lblSingleImageUploadDescription" Text="Description:" />
											</td>
											<td>
												<div id="DivMIDescriptionTextBox" runat="server">
													<asp:TextBox ID="tbMultiImageDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivMIUseMetadataDescription" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbMultiImageUploadseExifMetadataDescription" runat="server" resourcekey="cbSingleImageUploadseExifMetadataDescriptionResource1" Text="Use Exif metadata as description" />
													</div>
												</div>
												<div id="DivMIUseExifMetadataDescriptionOptions" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cbMultiImageUploadseExifMetadataDescriptionOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr id="trMultiIUEnterUrl" runat="server">
											<td class="labels">
												<dnn:Label ID="lblMultiUmageUploadUrl" runat="server" HelpKey="lblUmageUploadUrl.HelpText" HelpText="Enter url for media link:" ResourceKey="lblSingleUmageUploadUrl" Text="Enter url:" />
											</td>
											<td>
												<asp:TextBox ID="tbMIImageUrl" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr id="trMultiImageUplaodResize" runat="server">
											<td class="labels">
												<dnn:Label ID="lblMultiImageUploadResize" runat="server" HelpKey="lblSingleImageUploadResize.HelpText" HelpText="Proportionaly resize uploaded image:" ResourceKey="lblSingleImageUploadResize" Text="Resize image:" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbMultiUploadResize" runat="server" OnCheckedChanged="cbImageUploadResize_CheckedChanged" resourcekey="cbImageUploadResizeResource1" Text="MultiUploadResize" />
												</div>
											</td>
										</tr>
										<tr id="trMultiImageUplaodResize2" runat="server">
											<td></td>
											<td>
												<div id="divMIUResize" runat="server" style="display: none">
													<asp:Panel ID="pnlMultiImageUploadResize" runat="server">
														<table>
															<tr>
																<td>
																	<asp:Label ID="lblMultiImageUploadResizeWidth" runat="server" resourcekey="lblImageUploadResizeWidthResource1" Text="Max width:"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbMultiImageUploadResizeWidth" runat="server" Text="800" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResize0" runat="server" ControlToValidate="tbMultiImageUploadResizeWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImagerResizeResource1.ErrorMessage" Type="Integer" ValidationGroup="vgImageUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUpload0" runat="server" ControlToValidate="tbMultiImageUploadResizeWidth" ErrorMessage="This filed is required." resourcekey="rfvImageUploadResource1.ErrorMessage" ValidationGroup="vgImageUpload" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td>
																	<asp:Label ID="lblMultiImageUploadResizeHeight" runat="server" resourcekey="lblImageUploadResizeHeightResource1" Text="Max height:"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbMultiImageUploadResizeHeight" runat="server" Text="600" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvImagerResizeHeight0" runat="server" ControlToValidate="tbMultiImageUploadResizeHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvImagerResizeHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgImageUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvImageUploadHeight0" runat="server" ControlToValidate="tbMultiImageUploadResizeHeight" ErrorMessage="This filed is required." resourcekey="rfvImageUploadHeightResource1.ErrorMessage" ValidationGroup="vgImageUpload" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td colspan="2">
																	<div class="styledCheckbox">
																		<asp:CheckBox ID="cbMIUOriginalAsDownload" runat="server" Text="Use unresized image as download version." />
																	</div>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td>
												<asp:Label ID="Label6" runat="server" resourcekey="Label2Resource1" Text="Image Format:" Visible="False"></asp:Label>
											</td>
											<td>
												<asp:Label ID="lblFileName0" runat="server" resourcekey="lblFileNameResource1" Visible="False">
												</asp:Label>
												<asp:Label ID="lblPathtoSave" runat="server" Visible="False"></asp:Label>
											</td>
										</tr>
										<tr id="trPostToJournal" runat="server" visible="false">
											<td class="labels">
												<dnn:Label ID="lblPostToJurnal" runat="server" Text="Post to Journal:" HelpText="Post to Journal:" EnableViewState="True" HelpKey="lblPostToJurnal.HelpText" ResourceKey="lblMAUPostToJournal.Text" />
											</td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMUIPostToJournal" runat="server" resourceKey="PostToJournal.Text" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblMultiImageUploadMessage" runat="server" EnableViewState="False" resourcekey="lblMessageResource1"></asp:Label>
											</td>
										</tr>
									</table>
								</div>
								<asp:Panel ID="pnlImageUploadUploadify" runat="server">
									<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
										<tr>
											<td>
												<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
													<asp:FileUpload ID="GalfileInput" runat="server" />
												</div>
												<div style="display: block; float: left; margin-left: 15px;">
													<a class="btnUpload" href="javascript:jQuery('#<%=GalfileInput.ClientID%>').uploadifyUpload();"><%=startUpload%></a> <a href="javascript:jQuery('#<%=GalfileInput.ClientID%>').uploadifyClearQueue();"><%=ViewState["ClearQueue"]%></a>
												</div>
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
											<ol class="fileUploadList"></ol>
										</div>
									</div>
								</asp:Panel>
								<div style="display: none; line-height: 0pt;">
									<asp:Button ID="btnSaveMultiImageUpload" runat="server" OnClick="MultiImageUpload" Text="Save" />
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlZipUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblZipUploadTitle" runat="server" Text="Zip file upload" resourcekey="lblZipUploadTitleResource1" CssClass="zipFileUplad"></asp:Label>
								</h4>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblZipUploadSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblTUSelect_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio">
										<asp:ListItem Selected="True" Value="upload" Text="Upload Zip file" resourcekey="ListItemResource18"></asp:ListItem>
										<asp:ListItem Value="server" Text="Add zip from server folder" resourcekey="ListItemResource19"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<asp:Panel ID="pnlZUpload" runat="server" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadFileSelect" ResourceKey="lblZipUploadFileSelect" runat="server" HelpText="Please select zip file to upload:" Text="Zip file to upload:" HelpKey="lblZipUploadFileSelect.HelpText" />
											</td>
											<td>
												<asp:FileUpload ID="fuZipUpload" runat="server" Width="300px" />
											</td>
										</tr>
									</table>
								</asp:Panel>
								<asp:Panel ID="pnlZUAddFromServer" runat="server" Visible="False" CssClass="optionsPanel">
									<table>
										<tr>
											<th>
												<asp:Label ID="lblZipUploadFromServerFileSelect" runat="server" Text="Select zip file:" CssClass="subtitleregion" resourcekey="lblZipUploadFromServerFileSelectResource1"></asp:Label>
											</th>
											<th></th>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadSelectFolder" ResourceKey="lblZipUploadSelectFolder" runat="server" Text="Select folder:" HelpText="Select folder:" HelpKey="lblZipUploadSelectFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlZUFolders" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlZUFolders_SelectedIndexChanged">
														<asp:ListItem Value="\" Text="Root" resourcekey="ListItemResource20"></asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadFolderSelectFile" ResourceKey="lblZipUploadFolderSelectFile" runat="server" Text="Select zip file to add:" HelpText="Select zip file to add:"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlZUFiles" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadMainGallFolder" ResourceKey="lblZipUploadMainGallFolder" runat="server" Text="Show main gallery folder:" HelpText="Add main EasyDNN gallery folder to folders list:" HelpKey="lblZipUploadMainGallFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbZUShowMainGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="cbZUShowMainGalFolder_CheckedChanged" resourcekey="cbZUShowMainGalFolderResource1" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadFilenameAsTitle" runat="server" HelpKey="lblZipUploadFilenameAsTitle.HelpText" HelpText="Use filename or metada of image from zip file to set title:" ResourceKey="lblZipUploadFilenameAsTitle" Text="Set title:" />
											</td>
											<td>
												<div id="ZIPTitleTextBox" runat="server">
													<asp:TextBox ID="tbZIPImageTitle" runat="server" MaxLength="250" ValidationGroup="Validationg1" Width="300px"></asp:TextBox>
												</div>
												<div id="DivZipUseFileNameCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUpladUseFilenameTitle" runat="server" CausesValidation="True" resourcekey="cbZipUpladUseFilenameTitleResource1" Text="Use filename as title" />
													</div>
												</div>
												<div id="divZUUseFilename" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUploadTitleRemoveExtenzion" runat="server" resourcekey="cbZipUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUploadTitleReplaceUnderscore" runat="server" resourcekey="cbZipUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUploadTitleReplaceMinus" runat="server" resourcekey="cbZipUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblZipUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource27" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource28" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource29" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource30" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
													</asp:RadioButtonList>
												</div>
												<div id="DivZipUseMetadataCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUploadUseExifMetadataTitle" runat="server" Text="Use Exif metadata as title" resourcekey="cbZipUploadUseExifMetadataTitleResource1" />
													</div>
												</div>
												<div id="DivZipUseMetadataOptions" runat="server" style="display: none">
													<asp:CheckBoxList ID="cblZipUploadMetadataOptions" runat="server" CssClass="styledCheckbox">
														<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbZipSubtitle" runat="server" MaxLength="2000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadDescription" ResourceKey="lblZipUploadDescription" runat="server" Text=" Description:" HelpText="Enter description for images from zip file." HelpKey="lblZipUploadDescription.HelpText"></dnn:Label>
											</td>
											<td>
												<div id="DivZipDescriptionTB" runat="server">
													<asp:TextBox ID="tbZipDescription" runat="server" TextMode="MultiLine" MaxLength="4000" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivZipUseMetadataDescriptionCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbZipUploadUseExifMetadataDescription" runat="server" Text="Use Exif metadata as description" resourcekey="cbZipUploadUseExifMetadataDescriptionResource1" />
													</div>
												</div>
												<div id="DivZipUseMetadataDescriptionOptions" runat="server" style="display: none">
													<asp:CheckBoxList ID="cblZipUploadMetadataDescriptionOptions" runat="server" CssClass="styledCheckbox">
														<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
													</asp:CheckBoxList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblZipUploadMediaUrl" ResourceKey="lblZipUploadMediaUrl" runat="server" HelpText="Enter url for media link:" Text="Enter url:" HelpKey="lblZipUploadMediaUrl.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbZipImageUrl" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblIZipUploadImageResize" ResourceKey="lblIZipUploadImageResize" runat="server" HelpText="Propotionaly resize uploaded images:" Text="Resize image:" HelpKey="lblIZipUploadImageResize.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbZipUploadImageResize" runat="server" resourcekey="cbZipUploadImageResizeResource1" Text="UploadImageResize" />
												</div>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<div id="divZUImageResize" runat="server" style="display: none">
													<asp:Panel ID="pnlZipUploadImageResize" runat="server">
														<table>
															<tr>
																<td>
																	<asp:Label ID="lblZipUploadResizeWidth" runat="server" Text="Max width:" resourcekey="lblZipUploadResizeWidthResource1"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbZipUploadImageResizeWidth" runat="server" Text="800" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvZipUploadResizeWidth" runat="server" ControlToValidate="tbZipUploadImageResizeWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgZipUpload" resourcekey="cvZipUploadResizeWidthResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvZipUploadResizeWidth" runat="server" ControlToValidate="tbZipUploadImageResizeWidth" ErrorMessage="This filed is required." ValidationGroup="vgZipUpload" resourcekey="rfvZipUploadResizeWidthResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td class="style41">
																	<asp:Label ID="lblZipUploadResizeHeight" runat="server" Text="Max height:" resourcekey="lblZipUploadResizeHeightResource1"></asp:Label>
																</td>
																<td>
																	<asp:TextBox ID="tbZipUploadImageResizeHeight" runat="server" Text="600" CssClass="small textCenter"></asp:TextBox>
																	<asp:CompareValidator ID="cvZipUploadResizeHeight" runat="server" ControlToValidate="tbZipUploadImageResizeHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgZipUpload" resourcekey="cvZipUploadResizeHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																	<asp:RequiredFieldValidator ID="rfvZipUploadResizeHeight" runat="server" ControlToValidate="tbZipUploadImageResizeHeight" ErrorMessage="This filed is required." ValidationGroup="vgZipUpload" resourcekey="rfvZipUploadResizeHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
																</td>
															</tr>
															<tr>
																<td colspan="2">
																	<div class="styledCheckbox">
																		<asp:CheckBox ID="cbZipOriginalAsDownload" runat="server" Text="Use unresized image as download version." />
																	</div>
																</td>
															</tr>
														</table>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblZipUploadMessage" runat="server" EnableViewState="False" resourcekey="lblZipUploadMessageResource1"></asp:Label>
											</td>
										</tr>
									</table>
									<div class="mainActions color1">
										<asp:LinkButton ID="btnUploadZipFile" runat="server" OnClick="UploadZipButton_Click" Text="Upload Zip file" ValidationGroup="vgZipUpload" resourcekey="btnUploadZipFileResource1" CssClass="upload" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnaAddFolder" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblImageUpladoFromFolderTitle" runat="server" Text="Add images from folder" resourcekey="lblImageUpladoFromFolderTitleResource1" CssClass="singleImageUplad"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderSelectFolder" runat="server" Text="Select folder:" ResourceKey="lblAddImagesFromFolderSelectFolderResource1" HelpText="Select folder:"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAddImageFolder" runat="server" Style="margin-left: 0px" AppendDataBoundItems="True">
														<asp:ListItem Value="\" Text="Root" resourcekey="ListItemResource56"></asp:ListItem>
													</asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderShowMainGallery" ResourceKey="lblAddImagesFromFolderShowMainGallery" runat="server" Text="Show main gallery folder:" HelpText="Add main EasyDNN gallery folder to folders list:" HelpKey="lblAddImagesFromFolderShowMainGallery.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="chIUShowMainGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="chIUShowMainGalFolder_CheckedChanged" resourcekey="chIUShowMainGalFolderResource1" Text="ShowMainGalFolder" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderTitleUse" ResourceKey="lblAddImagesFromFolderTitleUse" runat="server" HelpText="Use filename or exif metadata as title:" Text="Set title:" HelpKey="lblAddImagesFromFolderTitleUse.HelpText" />
											</td>
											<td>
												<div id="ServerFolderTitleTextBox" runat="server">
													<asp:TextBox ID="tbServerFolderTitleName" runat="server" MaxLength="250" ValidationGroup="Validationg1" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivImageFolderUseFilenameCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAddImagesFromFolderTitleFilename" runat="server" resourcekey="cbAddImagesFromFolderTitleFilenameResource1" Text="Use filename as title" />
													</div>
												</div>
												<div id="divIAFUseFilename" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbIUAFRemoveExtenzion" runat="server" resourcekey="cbIUAFRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAFReplaceTitle" runat="server" resourcekey="cbAFReplaceTitleResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAFReplaceMinus" runat="server" resourcekey="cbAFReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<div class="styledRadio small">
														<asp:RadioButtonList ID="rblImageFolderTitleOptions" runat="server">
															<asp:ListItem resourcekey="ListItemResource57" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource58" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource59" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource60" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</div>
												</div>
												<div id="DivImageFolderMetadataCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAddImagesFromFolderTitleMetadata" runat="server" Text="Use Exif metadata as title" resourcekey="cbAddImagesFromFolderTitleMetadataResource1" />
													</div>
												</div>
												<div id="DivImageFolderTitleUseExifMetadataOptions" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cblImageFolderMetadataOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblImagesFromFolderSubstitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbImagesFromFolderSubstitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderDescription" ResourceKey="lblAddImagesFromFolderDescription" runat="server" HelpText="Enter or use exif metadata as description:" Text="Set description:" />
											</td>
											<td>
												<div id="DivImageFolderDescriptionTB" runat="server">
													<asp:TextBox ID="tbIUAFImageDescription" runat="server" TextMode="MultiLine" MaxLength="4000" CssClass="large"></asp:TextBox>
												</div>
												<div id="DivUmageFolderUseMetadataDescriptionCB" runat="server">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAddImagesFromFolderDescriptionUseMetadata" runat="server" Text="Use Exif metadata as description" resourcekey="cbAddImagesFromFolderDescriptionUseMetadataResource1" />
													</div>
												</div>
												<div id="DivImageFolderuseMetadaDescriptionOptions" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBoxList ID="cblAddImagesFromFolderDescriptionMetadataOptions" runat="server">
															<asp:ListItem resourcekey="liTitle" Value="XPTitle" Text="Title"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource44" Value="Artist" Text="Artist"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource45" Value="Copyright" Text="Copyright"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource46" Text="Image description" Value="ImageDescription"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource47" Value="Make" Text="Make"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource48" Value="Model" Text="Model"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource49" Text="Subject location" Value="SubjectLocation"></asp:ListItem>
														</asp:CheckBoxList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderUrl" ResourceKey="lblAddImagesFromFolderUrl" runat="server" HelpText="Enter url for media link:" Text="Enter url:" HelpKey="lblAddImagesFromFolderUrl.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAFImagesUrl" runat="server" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr id="trResizeImage" runat="server">
											<td class="labels">
												<dnn:Label ID="lblAddImagesFromFolderResize" ResourceKey="lblAddImagesFromFolderResize" runat="server" HelpText="Proportionaly resize uploaded image:" Text="Resize image:" HelpKey="lblAddImagesFromFolderResize.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAFImageUploadResize" runat="server" OnCheckedChanged="cbImageUploadResize_CheckedChanged" resourcekey="cbAFImageUploadResizeResource1" Text="ImageUploadResize" />
												</div>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<div id="divAIFImagResize" runat="server" style="display: none">
													<table>
														<tr>
															<td>
																<asp:Label ID="lblAddImagesFromFolderResizeWidth" runat="server" Text="Max width:" resourcekey="lblAddImagesFromFolderResizeWidthResource1"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbAFImageUploadResizeWidth" runat="server" Text="800" ValidationGroup="vgAFImages" CssClass="small textCenter"></asp:TextBox>
																<asp:CompareValidator ID="cvAddImagesFromFolderResizeWidth" runat="server" ControlToValidate="tbAFImageUploadResizeWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAFImages" resourcekey="cvAddImagesFromFolderResizeWidthResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																<asp:RequiredFieldValidator ID="rfvAddImagesFromFolderResize" runat="server" ControlToValidate="tbAFImageUploadResizeWidth" ErrorMessage="This filed is required." ValidationGroup="vgAFImages" resourcekey="rfvAddImagesFromFolderResizeResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
															</td>
														</tr>
														<tr>
															<td>
																<asp:Label ID="lblAddImagesFromFolderResizeHeight" runat="server" Text="Max height:" resourcekey="lblAddImagesFromFolderResizeHeightResource1"></asp:Label>
															</td>
															<td>
																<asp:TextBox ID="tbAFImageUploadResizeHeight" runat="server" Text="600" ValidationGroup="vgAFImages" CssClass="small textCenter"></asp:TextBox>
																<asp:CompareValidator ID="cvAddImagesFromFolderResizeHeight" runat="server" ControlToValidate="tbAFImageUploadResizeHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgAFImages" resourcekey="cvImagerResizeHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
																<asp:RequiredFieldValidator ID="rfvAddImagesFromFolderHeight" runat="server" ControlToValidate="tbAFImageUploadResizeHeight" ErrorMessage="This filed is required." ValidationGroup="vgAFImages" resourcekey="rfvAddImagesFromFolderHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
															</td>
														</tr>
														<tr>
															<td colspan="2">
																<div class="styledCheckbox">
																	<asp:CheckBox ID="cbServerFolderOriginalAsDownload" runat="server" Text="Use unresized image as download version." />
																</div>
															</td>
														</tr>
													</table>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblImageFromFolderMessage" runat="server" EnableViewState="False" resourcekey="lblAIFMessageResource1"></asp:Label>
											</td>
										</tr>
									</table>
									<div class="mainActions color1">
										<asp:LinkButton ID="btnAddImagesFromFolder" runat="server" OnClick="btnAddImagesFromFolder_Click" resourcekey="btnAddImagesFromFolderResource1" Text="Add images" ValidationGroup="vgAFImages" CssClass="upload" />
									</div>
								</div>
							</asp:Panel>
						</asp:Panel>
						<asp:Panel ID="pnlVideoUploadContainer" runat="server" Visible="False" CssClass="contentSection videoUpload">
							<div class="specialOptions">
								<h2>
									<asp:Label ID="lblAddVideo" resourcekey="lblAddVideo" runat="server" Text="Add&lt;br&gt;video"></asp:Label>
								</h2>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblVideoUploadTypeSelect" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblVideoUpload_SelectedIndexChanged" RepeatDirection="Horizontal" OnPreRender="rblVideoUploadTypeSelect_PreRender">
										<asp:ListItem resourcekey="ListItemResource73" Text="Upload Video" Value="UploadFlash"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource74" Text="Embed video" Value="Embedvideo"></asp:ListItem>
										<asp:ListItem resourcekey="AmazonS3" Value="amazons3">Amazon S3</asp:ListItem>
										<asp:ListItem resourcekey="liWistia" Value="wistia">Wistia</asp:ListItem>
										<asp:ListItem resourcekey="liVimeo" Value="vimeo">Vimeo</asp:ListItem>
									</asp:RadioButtonList>
								</div>
							</div>
							<asp:Panel ID="pnlFlashUploadFlash" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblVideoUploadTitle" runat="server" CssClass="videoUpload" Text="Video Upload" resourcekey="lblVideoUploadTitleResource1"></asp:Label>
								</h4>
								<div class="optionsList">
									<asp:Label ID="lblVideoUploadHeader" runat="server" Text="Upload" resourcekey="lblVideoUploadHeader"></asp:Label>
									<asp:RadioButtonList ID="rblVideoUploadSelctSource" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblVUSelctSorce_SelectedIndexChanged" RepeatDirection="Horizontal" CausesValidation="True" CssClass="styledRadio">
										<asp:ListItem Selected="True" Value="upload" Text="Upload video" resourcekey="ListItemResource75"></asp:ListItem>
										<asp:ListItem resourcekey="liMultiVideoUpload" Value="multi">Multi video upload</asp:ListItem>
										<asp:ListItem Value="server" Text="Add single video from server folder" resourcekey="ListItemResource76"></asp:ListItem>
										<asp:ListItem Value="folder" Text="Add all videos from server folder" resourcekey="ListItemResource77"></asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<asp:Panel ID="pnlSingleVideoUpload" runat="server">
									<asp:Panel ID="pnlUVUpload" runat="server" CssClass="optionsPanel">
										<table>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadFileSelect" runat="server" HelpKey="lblVideoUploadFileSelect.HelpText" HelpText="Select the file to upload:" ResourceKey="lblVideoUploadFileSelect" Text="Please select the file to upload:" />
												</td>
												<td>
													<asp:FileUpload ID="fuSingleVideoUpload" runat="server" />
												</td>
											</tr>
										</table>
									</asp:Panel>
									<asp:Panel ID="pnlVideoUploadFromServer" runat="server" Visible="False" CssClass="optionsPanel">
										<table>
											<tr>
												<th>
													<asp:Label ID="lblVideoUploadAddFileFromServer" runat="server" CssClass="subtitleregion" resourcekey="lblVideoUploadAddFileFromServerResource1" Text="Add video from folder:"></asp:Label>
												</th>
												<th></th>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadFolderSelect" runat="server" HelpKey="lblVideoUploadFolderSelect.HelpText" HelpText="Select folder:" ResourceKey="lblVideoUploadFolderSelect" Text="Select folder:" />
												</td>
												<td>
													<asp:DropDownList ID="ddlVideoUploadFolders" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CausesValidation="True" OnSelectedIndexChanged="ddlFolders_SelectedIndexChanged">
														<asp:ListItem resourcekey="ListItemResource78" Text="Root" Value="\"></asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblVideoUploadFiles" runat="server" HelpKey="lblVideoUploadFiles.HelpText" HelpText="Select file:" ResourceKey="lblVideoUploadFiles" Text="Select file:" />
												</td>
												<td>
													<asp:DropDownList ID="ddlVUFiles" runat="server" DataTextField="Name" DataValueField="Name"></asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblVideoUploadShowMainGalleryFolder" runat="server" HelpKey="lblVideoUploadShowMainGalleryFolder.HelpText" HelpText="Add main EasyDNN gallery folder to folders list:" ResourceKey="lblVideoUploadShowMainGalleryFolder" Text="Show main gallery folder:" />
												</td>
												<td>
													<asp:CheckBox ID="cbVUShowMainGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="cbVUShowMainGalFolder_CheckedChanged" resourcekey="cbVUShowMainGalFolderResource1" />
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblVideoUploadDeleteOriginalFile" runat="server" HelpKey="lblVideoUploadDeleteOriginalFile.HelpText" HelpText="File will be copied to gallery folder. Delete original file:" ResourceKey="lblVideoUploadDeleteOriginalFile" Text="Delete original file:" />
												</td>
												<td>
													<asp:CheckBox ID="cbVUDeleteFile" runat="server" resourcekey="cbVUDeleteFileResource1" />
												</td>
											</tr>
										</table>
									</asp:Panel>
									<asp:Panel ID="pnlAVF" runat="server" Visible="False" CssClass="optionsPanel">
										<table style="width: 650px; text-align: left;">
											<tr>
												<td>
													<dnn:Label ID="lblAddVideoFolderSelectFolder" runat="server" HelpKey="lblAddVideoFolderSelectFolder.HelpText" HelpText="Select folder:" ResourceKey="lblAddVideoFolderSelectFolder" Text="Select folder:" />
												</td>
												<td>
													<asp:DropDownList ID="ddlAVFFolders" runat="server" AutoPostBack="True" CausesValidation="True"></asp:DropDownList>
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblAddVideoFolderShowMainGalleryFolder" runat="server" HelpKey="lblAddVideoFolderShowMainGalleryFolder.HelpText" HelpText="Add main EasyDNN gallery folder to folders list:" ResourceKey="lblAddVideoFolderShowMainGalleryFolder" Text="Show main gallery folder:" />
												</td>
												<td>
													<asp:CheckBox ID="cbAVFShowMainGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="cbAVFShowMainGalFolder_CheckedChanged" resourcekey="cbAVFShowMainGalFolderResource1" />
												</td>
											</tr>
											<tr>
												<td>
													<dnn:Label ID="lblAddVideoFolderDeleteOriginalFile" runat="server" HelpKey="lblAddVideoFolderDeleteOriginalFile.HelpText" HelpText="File will be copied to gallery folder. Delete original file:" ResourceKey="lblAddVideoFolderDeleteOriginalFile" Text="Delete original file:" />
												</td>
												<td>
													<asp:CheckBox ID="cbAVFDeleteFile" runat="server" resourcekey="cbAVFDeleteFileResource1" />
												</td>
											</tr>
										</table>
									</asp:Panel>
									<div class="optionsPanel">
										<table>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadVideoTitle" runat="server" ControlName="tbFlashTitle" HelpKey="lblVideoUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblVideoUploadVideoTitle" Text="Video title:" />
												</td>
												<td>
													<div id="divVideoTitle" runat="server">
														<asp:TextBox ID="tbFlashTitle" runat="server" CssClass="large"></asp:TextBox>
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVideoUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
													</div>
													<div id="divVUFilenameAsTitle" runat="server" style="display: none">
														<asp:Panel ID="pnlVUFilenameasTitle" runat="server">
															<div class="styledCheckbox">
																<asp:CheckBox ID="cbVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
															</div>
															<div class="styledCheckbox">
																<asp:CheckBox ID="cbVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
															</div>
															<div class="styledCheckbox">
																<asp:CheckBox ID="cbVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
															</div>
															<asp:RadioButtonList ID="rblVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
																<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
																<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
																<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
																<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
															</asp:RadioButtonList>
														</asp:Panel>
													</div>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadSubstitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
												</td>
												<td>
													<asp:TextBox ID="tbVideoUploadSubstitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
												</td>
												<td>
													<asp:TextBox ID="tbFlashDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
												</td>
												<td>
													<asp:TextBox ID="tbFlashWidth" runat="server" ValidationGroup="vgVideoUpload" CssClass="small textCenter">640</asp:TextBox>
													<asp:CompareValidator ID="cvVideoUploadWidth" runat="server" ControlToValidate="tbFlashWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
												</td>
												<td>
													<asp:TextBox ID="tbFlashHeight" runat="server" CssClass="small textCenter">480</asp:TextBox>
													<asp:CompareValidator ID="cvVideoUploadheight" runat="server" ControlToValidate="tbFlashHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
												</td>
												<td>
													<asp:RadioButtonList ID="rblVideoThumbnailSelect" runat="server" OnLoad="rblFlashThumbnail_Load" RepeatDirection="Horizontal" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
													</asp:RadioButtonList>
													<div id="divVUStandardImage" runat="server" class="paddingTopBottom">
														<asp:Label ID="lblVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
														<div class="styledSelect">
															<asp:DropDownList ID="ddlVUThumbSelect" runat="server"></asp:DropDownList>
														</div>
													</div>
													<div id="divVUUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
														<asp:Label ID="lblVideoUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
														<asp:FileUpload ID="fuFlashThumbnail" runat="server" />
													</div>
												</td>
											</tr>
											<tr>
												<td class="labels">
													<dnn:Label ID="lblVideoUploadStartupImage" runat="server" HelpText="Upload the image for video file or use standard image to be used as startup image:" Text="Startup image:" HelpKey="lblVideoUploadStartupImage.HelpText" ResourceKey="lblVideoUploadStartupImage" />
												</td>
												<td>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVideoStartUp" runat="server" resourcekey="cbVideoStartUp" Text="Use thumbnail as startup image" Checked="True" />
													</div>
													<div id="DivVUStartupImagesetup" runat="server" style="display: none">
														<asp:RadioButtonList ID="rblVideoStartupImageSelect" runat="server" OnLoad="rblFlashThumbnail_Load" RepeatDirection="Horizontal" CssClass="styledRadio small">
															<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
														</asp:RadioButtonList>
														<div id="divVUStandardStartImage" runat="server" class="paddingTopBottom">
															<asp:Label ID="lblVideoUploadSelectStartImage" runat="server" resourcekey="lblVideoUploadSelectStartImage" Text="Select standard start image:"></asp:Label>
															<asp:DropDownList ID="ddlVUStartImageSelect" runat="server"></asp:DropDownList>
														</div>
														<div id="divVideoStartupImage" runat="server" style="display: none" class="paddingTopBottom">
															<asp:Label ID="lblVideoStartupImage" runat="server" resourcekey="lblVideoStartupImage" Text="Select thumbnail to upload:"></asp:Label>
															<asp:FileUpload ID="fuVideoStartupImage" runat="server" />
														</div>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="2">
													<asp:Label ID="lblSingleVideoUploadMessage" runat="server" EnableViewState="False"></asp:Label>
												</td>
											</tr>
										</table>
										<div class="mainActions color1">
											<asp:LinkButton ID="btnVideoUpload" runat="server" OnClick="btnVideoUpload_Click" resourcekey="btnVideoUploadResource1" Text="Upload" ValidationGroup="vgVideoUpload" CssClass="upload" />
										</div>
									</div>
								</asp:Panel>
								<asp:Panel ID="pnlMultiVideoUpload" runat="server" Visible="False" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadVideoTitle" runat="server" ControlName="tbFlashTitle" HelpKey="lblVideoUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblVideoUploadVideoTitle" Text="Video title:" />
											</td>
											<td>
												<div id="divMultiVideoTitle" runat="server">
													<asp:TextBox ID="tbMultiFlashTitle" runat="server" Width="300px"></asp:TextBox>
												</div>
												<asp:CheckBox ID="cbMultiVideoUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
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
															<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbMultiVideoUploadSubtitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbMultiFlashDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
											</td>
											<td>
												<asp:TextBox ID="tbMultiFlashWidth" runat="server" ValidationGroup="vgVideoUpload" CssClass="small textCenter">640</asp:TextBox>
												<asp:CompareValidator ID="cvMultiVideoUploadWidth" runat="server" ControlToValidate="tbMultiFlashWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
											</td>
											<td>
												<asp:TextBox ID="tbMultiFlashHeight" runat="server" CssClass="small textCenter">480</asp:TextBox>
												<asp:CompareValidator ID="cvMultiVideoUploadheight" runat="server" ControlToValidate="tbMultiFlashHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblMultiVideoThumbnailSelect" runat="server" OnLoad="rblFlashThumbnail_Load" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divMultiVUStandardImage" runat="server" class="paddingTopBottom">
													<asp:Label ID="lblMultiVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
													<div class="styledSelect">
														<asp:DropDownList ID="ddlMultiVUThumbSelect" runat="server"></asp:DropDownList>
													</div>
												</div>
												<div id="divMultiVUUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
													<asp:Label ID="lblMultiVideoUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
													<asp:FileUpload ID="fuMultiFlashThumbnail" runat="server" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblVideoMultiUploadStartupImage" runat="server" HelpText="Upload the image for video file or use standard image to be used as startup image:" Text="Startup image:" ResourceKey="lblVideoMultiUploadStartupImage" HelpKey="lblVideoMultiUploadStartupImage.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiVideoStartUp" runat="server" Text="Upload startup image" resourcekey="cbMultiVideoStartUp" Checked="True" />
												</div>
												<div id="DivMUltiVideoStartupSetup" runat="server" style="display: none">
													<asp:RadioButtonList ID="rblMultiVideoStartupImageSelect" runat="server" OnLoad="rblFlashThumbnail_Load" RepeatDirection="Horizontal" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
													</asp:RadioButtonList>
													<div id="divMultiVUStandardStartImage" runat="server" class="paddingTopBottom">
														<asp:Label ID="lblMultiStartupImage" runat="server" resourcekey="lblMultiStartupImage" Text="Select standard start image:"></asp:Label>
														<div class="styledSelect">
															<asp:DropDownList ID="ddlMultiStartupStandard" runat="server"></asp:DropDownList>
														</div>
													</div>
													<div id="DivMultiStartupUpload" runat="server" style="display: none" class="paddingTopBottom">
														<asp:Label ID="lblMultiStartupUpload" runat="server" resourcekey="lblMultiStartupUpload" Text="Select thumbnail to upload:"></asp:Label>
														<asp:FileUpload ID="fuMultiStartupUpload" runat="server" />
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblMultiVideoUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
									<asp:Panel ID="pnlVideoUploadUploadify" runat="server">
										<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
											<tr>
												<td>
													<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
														<asp:FileUpload ID="MultiVideoFileInput" runat="server" EnableTheming="True" />
													</div>
													<div style="display: block; float: left; margin-left: 15px;">
														<a class="btnUpload" href="javascript:jQuery('#<%=MultiVideoFileInput.ClientID%>').uploadifyUpload();"><%=startUpload%></a> <a href="javascript:jQuery('#<%=MultiVideoFileInput.ClientID%>').uploadifyClearQueue();"><%=ViewState["ClearQueue"]%></a>
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
														<asp:Label ID="galleryVideoFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
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
							<asp:Panel ID="pnlFlashEmbeedFlasf" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblEmbedVideoTitle" ResourceKey="lblEmbedVideoTitle" runat="server" Text="Embed Video" CssClass="videoUpload"></asp:Label>
								</h4>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblEmbedVideoSourceSelect" runat="server" AutoPostBack="True" CssClass="styledRadio" OnSelectedIndexChanged="rblVideoSources_SelectedIndexChanged" RepeatDirection="Horizontal">
										<asp:ListItem resourcekey="ListItemResource85" Selected="True" Text="YouTube" Value="YouTube"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource86" Text="Vimeo" Value="Vimeo"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource87" Text="Dailymotion"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource88" Text="Metacafe"></asp:ListItem>
										<asp:ListItem resourcekey="liBitsOnTheRun" Value="bitsrun">Bits on the Run</asp:ListItem>
										<asp:ListItem resourcekey="liBrightCrove" Value="Brightcove">Brightcove</asp:ListItem>
										<asp:ListItem Value="Wistia">Wistia</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource89" Text="Others"></asp:ListItem>
									</asp:RadioButtonList>
									<asp:RequiredFieldValidator ID="rfvEmbedVideoSourceSelect" runat="server" ControlToValidate="rblEmbedVideoSourceSelect" CssClass="infoMessages error static" ErrorMessage="Please select." resourcekey="rfvEmbedVideoSourceSelectResource1.ErrorMessage" ValidationGroup="EmbedVideo"></asp:RequiredFieldValidator>
								</div>
								<div class="optionsPanel">
									<table>
										<tr id="trEnterEmbedCodeRow" runat="server" visible="false">
											<td class="labels">
												<dnn:Label ID="lblEmbedVideoCode" runat="server" ControlName="tbFlashEmbedUrl" HelpKey="lblEmbedVideoCode.HelpText" HelpText="Enter video embed code:" ResourceKey="lblEmbedVideoCode" Text="Embed code:" />
											</td>
											<td>
												<asp:TextBox ID="tbVideoEmbedCode" runat="server" CssClass="large" MaxLength="2500" TextMode="MultiLine" ValidationGroup="EmbedVideo"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvEmbedVideoCode" runat="server" ControlToValidate="tbVideoEmbedCode" CssClass="smallInfo error" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="EmbedVideo"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblEembedVideoUrl" runat="server" ControlName="tbEmbedShortUrl" HelpKey="lblEembedVideoUrl.HelpText" HelpText="Enter video url:" ResourceKey="lblEembedVideoUrl" Text="Video url:" />
											</td>
											<td>
												<asp:TextBox ID="tbEmbedVideoURL" runat="server" CssClass="large" ValidationGroup="EmbedVideo"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvEmbedVideoURL" runat="server" ControlToValidate="tbEmbedVideoURL" CssClass="smallInfo error" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoURLResource1.ErrorMessage" ValidationGroup="EmbedVideo"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr id="trEmbedVideoDimensions" runat="server">
											<td class="labels">
												<dnn:Label ID="lblEmbedVideoDimensions" runat="server" HelpKey="lblEmbedVideoDimensions.HelpText" HelpText="Video dimensions:" ResourceKey="lblEmbedVideoDimensions" Text="Video dimensions:" />
											</td>
											<td>
												<asp:Label ID="lblEmbedVideoWidth" runat="server" ResourceKey="lblEmbedVideoWidth" Text="Width:"></asp:Label>
												<asp:TextBox ID="tbEmbedVideoWidth" runat="server" CssClass="small" ValidationGroup="EmbedVideo">560</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvEmbedVideoWidth" runat="server" ControlToValidate="tbEmbedVideoWidth" CssClass="smallInfo inline error" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoURLResource1.ErrorMessage" ValidationGroup="EmbedVideo"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvEmbedVideoWidth" runat="server" ControlToValidate="tbEmbedVideoWidth" CssClass="smallInfo inline error" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoEditHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="EmbedVideo"></asp:CompareValidator>
												<asp:Label ID="lblEmbedVideoHeight" runat="server" ResourceKey="lblEmbedVideoHeight" Text="Height:"></asp:Label>
												<asp:TextBox ID="tbEmbedVideoHeight" runat="server" CssClass="small" ValidationGroup="EmbedVideo">315</asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvEmbedVideoCode0" runat="server" ControlToValidate="tbEmbedVideoHeight" CssClass="smallInfo inline error" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="EmbedVideo"></asp:RequiredFieldValidator>
												<asp:CompareValidator ID="cvEmbedVideoHeight" runat="server" ControlToValidate="tbEmbedVideoHeight" CssClass="smallInfo inline error" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoEditHeightResource1.ErrorMessage" Type="Integer" ValidationGroup="EmbedVideo"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblEmbedVideoEnterTitle" runat="server" ControlName="tbFlashEmbedTitle" HelpKey="lblEmbedVideoEnterTitle.HelpText" HelpText="Enter video title." ResourceKey="lblEmbedVideoEnterTitle" Text="Video title:" />
											</td>
											<td>
												<asp:TextBox ID="tbFlashEmbedTitle" runat="server" CssClass="large" ValidationGroup="EmbedVideo"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblEmbedVideoSubttle" runat="server" HelpText="Enter subtitle for images from zip file." Text=" Subtitle:" />
											</td>
											<td>
												<asp:TextBox ID="tbEmbedVideoSubtitle" runat="server" CssClass="large" MaxLength="2000" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblEmbedVideoDescription" runat="server" ControlName="tbFlashEmbedDescription" HelpKey="lblEmbedVideoDescription.HelpText" HelpText="Enter video description." ResourceKey="lblEmbedVideoDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbFlashEmbedDescription" runat="server" CssClass="large" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<asp:RadioButtonList ID="rblEmbedVideoThumbnail" runat="server" AutoPostBack="True" CssClass="styledRadio small" OnSelectedIndexChanged="rblEVThumbCreate_SelectedIndexChanged" RepeatDirection="Horizontal">
													<asp:ListItem resourcekey="ListItemResource90" Selected="True" Text="Auto create thumbnail" Value="Autocreate"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource91" Text="Upload thumbnail" Value="Upload"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource92" Text="Use standard image" Value="standard"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divEVEFileUpload" runat="server" class="paddingTopBottom" style="display: none">
													<asp:FileUpload ID="fuEmbedAddThumb" runat="server" />
												</div>
												<div id="divEVESelectThumb" runat="server" class="paddingTopBottom" style="display: none">
													<div class="styledSelect">
														<asp:DropDownList ID="ddlVUEVSelectThumbnail" runat="server" CausesValidation="True">
														</asp:DropDownList>
													</div>
												</div>
											</td>
										</tr>
										<tr id="trMVUPostToJournal" runat="server" visible="false">
											<td>
												<dnn:Label ID="lblMVUPostToJournal" runat="server" EnableViewState="True" HelpText="Post to Journal:" ResourceKey="lblMAUPostToJournal.Text" Text="Post to Journal:" />
											</td>
											<td class="style7">
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMvUPostToJournal" runat="server" ResourceKey="PostToJournal.Text" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblEVUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
								</div>
								<div class="mainActions color1">
									<asp:LinkButton ID="btnAddEmbedVideo" runat="server" CssClass="add" OnClick="btnAddEmbedFlash_Click" resourcekey="btnAddEmbedVideoResource1" Text="Add" ValidationGroup="EmbedVideo" />
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlAmazonS3VideoAupload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblAmazonS3Title" resourcekey="liAmazonS3" runat="server" Text="Amazon S3" CssClass="amazonS3"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonUploadVideoURL" runat="server" HelpText="Aamazon S3 video URL link." Text="Aamazon S3 video URL link:" HelpKey="lblAmazonUploadVideoURL.HelpText" ResourceKey="lblAmazonUploadVideoURL" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonVideoURL" runat="server" CssClass="large" ValidationGroup="vgAmazonVideoUpload" MaxLength="1500"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAmazonVideoURL" runat="server" ControlToValidate="tbAmazonVideoURL" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="vgAmazonVideoUpload" CssClass="smallInfo error"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonUploadVideoTitle" runat="server" HelpKey="lblAmazonUploadVideoTitle.HelpText" HelpText="Enter the title of video file:" ResourceKey="lblAmazonUploadVideoTitle" Text="Video title:" />
											</td>
											<td>
												<div id="divAmazonVideoTitle" runat="server">
													<asp:TextBox ID="tbAmazonVideoTitle" runat="server" CssClass="large"></asp:TextBox>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbAmazonUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
													</div>
													<div id="divAmazonFilenameAsTitle" runat="server" style="display: none">
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbAmazonVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbAmazonVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbAmazonVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
														</div>
														<asp:RadioButtonList ID="rblAmazonVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
															<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every  word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonVideoUploadSubstitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbAmazonVideoUploadSubstitle" runat="server" MaxLength="2000" CssClass="large" TextMode="MultiLine"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonVideoDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonUploadWidth" runat="server" ControlName="tbFlashWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonVideoWidth" runat="server" ValidationGroup="vgAmazonVideoUpload" CssClass="small textCenter">640</asp:TextBox>
												<asp:CompareValidator ID="cvAmazonVideoUploadWidth" runat="server" ControlToValidate="tbAmazonVideoWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAmazonVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonVideoUploadHeight" runat="server" ControlName="tbFlashHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonVideoHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgAmazonVideoUpload">480</asp:TextBox>
												<asp:CompareValidator ID="cvAmazonVideoUploadHeight" runat="server" ControlToValidate="tbAmazonVideoHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgAmazonVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonVideoUploadThumbnail" runat="server" HelpKey="lblVideoUploadThumbnail.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblVideoUploadThumbnail" Text="Thumbnail:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblAmazonVideoThumbnailSelect" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divAmazonStandardImage" runat="server" class="paddingTopBottom">
													<asp:Label ID="lblAmazonVideoUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
													<div class="styledCheckbox">
														<asp:DropDownList ID="ddlAmazobVideoThumbSelect" runat="server"></asp:DropDownList>
													</div>
												</div>
												<div id="divAmazonUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
													<asp:Label ID="lblVideoUploadSelectThumbnailToUpload0" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
													<asp:FileUpload ID="fuAmazonThumbnail" runat="server" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblAmazonUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
								</div>
								<div class="mainActions">
									<asp:LinkButton ID="btnAmazonVideoUpload" runat="server" OnClick="btnAmazonVideoUpload_Click" resourcekey="btnAmazonVideoUpload" Text="Upload" ValidationGroup="vgAmazonVideoUpload" CssClass="upload" />
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlWistiaVideoUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblWistiaTitle" runat="server" Text="Upload video to Wistia" CssClass="uploadToWistia"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblWistiaUploadVideoTitle" runat="server" HelpText="Enter the title of video file:" Text="Video title:" />
											</td>
											<td>
												<div id="divWistiaVideoTitle" runat="server">
													<asp:TextBox ID="tbWistiaVideoTitle" runat="server" CssClass="large"></asp:TextBox>
												</div>
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
														<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every  word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
													</asp:RadioButtonList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblWistiaVideoUploadSubstitle" runat="server" Text="Subtitle:" HelpText="Enter subtitle for video."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbWistiaVideoUploadSubstitle" runat="server" TextMode="MultiLine" MaxLength="2000" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblWistiaVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbWistiaVideoDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr runat="server" id="trWistiaUploadWidth">
											<td class="labels">
												<dnn:Label ID="lblWistiaUploadWidth" runat="server" ControlName="tbWistiaVideoWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
											</td>
											<td>
												<asp:TextBox ID="tbWistiaVideoWidth" runat="server" ValidationGroup="vgWistiaVideoUpload" CssClass="small textCenter">640</asp:TextBox>
												<asp:CompareValidator ID="cvWistiaVideoUploadWidth" runat="server" ControlToValidate="tbWistiaVideoWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgWistiaVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr runat="server" id="trWistiaUploadHeight">
											<td class="labels">
												<dnn:Label ID="lblWistiaVideoUploadHeight" runat="server" ControlName="tbWistiaVideoHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
											</td>
											<td>
												<asp:TextBox ID="tbWistiaVideoHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgWistiaVideoUpload">360</asp:TextBox>
												<asp:CompareValidator ID="cvWistiaVideoUploadHeight" runat="server" ControlToValidate="tbWistiaVideoHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgWistiaVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<asp:RadioButtonList ID="rblWistiaVideoThumbnail" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblWistiaVideoThumbnail_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem Selected="True" Value="autocreate" Text="Auto create thumbnail" resourcekey="ListItemResource90"></asp:ListItem>
													<asp:ListItem Value="upload" Text="Upload thumbnail" resourcekey="ListItemResource91"></asp:ListItem>
													<asp:ListItem Value="standard" Text="Use standard image" resourcekey="ListItemResource92"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divWistiaUploadThumbnail" runat="server" style="display: none" class="paddingTopBottom">
													<asp:FileUpload ID="fuWistiaUploadThumbnail" runat="server" />
												</div>
												<div id="divWistiaStandardThumbnail" runat="server" style="display: none" class="paddingTopBottom">
													<div class="styledSelect">
														<asp:DropDownList ID="ddlWistiaVideoThumbSelect" runat="server" CausesValidation="True"></asp:DropDownList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblWistiaUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
								</div>
								<asp:Panel ID="pnlWistiaUploadSingleVideo" runat="server">
									<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
										<tr>
											<asp:Label ID="lblWistiaSingleUploadMessage" runat="server" CssClass="subtitleregion" EnableViewState="False"></asp:Label>
										</tr>
										<tr>
											<td>
												<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
													<asp:FileUpload ID="fuWistiaVideoFileInput" runat="server" EnableTheming="True" />
												</div>
												<div style="display: block; float: left; margin-left: 15px;">
													<asp:Button ID="btnWistiaSingleUpload" resourcekey="btnWistiaSingleUpload" runat="server" Text="Upload to Wistia" OnClick="btnWistiaSingleUpload_Click" />
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
													<asp:Label ID="galleryWistiaFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
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
							<asp:Panel ID="pnlVimeoVideoUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblVimeoTitle" runat="server" Text="Upload video to Vimeo" CssClass="uploadToVimeo"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblVimeoUploadVideoTitle" runat="server" HelpText="Enter the title of video file:" Text="Video title:" />
											</td>
											<td>
												<div id="divVimeoVideoTitle" runat="server">
													<asp:TextBox ID="tbVimeoVideoTitle" runat="server" CssClass="large"></asp:TextBox>
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbVimeoUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
												</div>
												<div id="divVimeoFilenameAsTitle" runat="server" style="display: none">
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVimeoVideoUploadTitleRemoveExtenzion" runat="server" resourcekey="cbVideoUploadTitleRemoveExtenzionResource1" Text="Remove extension" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVimeoVideoUploadTitleReplaceUnderscore" runat="server" resourcekey="cbVideoUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
													</div>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbVimeoVideoUploadTitleReplaceMinus" runat="server" resourcekey="cbVideoUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
													</div>
													<asp:RadioButtonList ID="rblVimeoVideoUploadTitleOptions" runat="server" CssClass="styledRadio small">
														<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every  word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
														<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
													</asp:RadioButtonList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblVimeoVideoUploadSubstitle" runat="server" Text="Subtitle:" HelpText="Enter subtitle for video."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbVimeoVideoUploadSubstitle" runat="server" TextMode="MultiLine" MaxLength="2000" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblVimeoVideoUploadDescription" runat="server" ControlName="tbFlashDescription" HelpKey="lblVideoUploadDescription.HelpText" HelpText="Enter the video description:" ResourceKey="lblVideoUploadDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbVimeoVideoDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr runat="server" id="trVimeoUploadWidth">
											<td class="labels">
												<dnn:Label ID="lblVimeoUploadWidth" runat="server" ControlName="tbVimeoVideoWidth" HelpKey="lblVideoUploadWidth.HelpText" HelpText="Enter the video width to be used displaying video:" ResourceKey="lblVideoUploadWidth" Text="Video width:" />
											</td>
											<td>
												<asp:TextBox ID="tbVimeoVideoWidth" runat="server" ValidationGroup="vgVimeoVideoUpload" CssClass="small textCenter">560</asp:TextBox>
												<asp:CompareValidator ID="cvVimeoVideoUploadWidth" runat="server" ControlToValidate="tbVimeoVideoWidth" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadWidthResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVimeoVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr runat="server" id="trVimeoUploadHeight">
											<td class="labels">
												<dnn:Label ID="lblVimeoVideoUploadHeight" runat="server" ControlName="tbVimeoVideoHeight" HelpKey="lblVideoUploadHeight.HelpText" HelpText="Enter the video height to be used when displaying video:" ResourceKey="lblVideoUploadHeight" Text="Video height:" />
											</td>
											<td>
												<asp:TextBox ID="tbVimeoVideoHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgVimeoVideoUpload">315</asp:TextBox>
												<asp:CompareValidator ID="cvVimeoVideoUploadHeight" runat="server" ControlToValidate="tbVimeoVideoHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvVideoUploadheightResource1.ErrorMessage" Type="Integer" ValidationGroup="vgVimeoVideoUpload" CssClass="smallInfo inline error"></asp:CompareValidator>
											</td>
										</tr>
										<tr>
											<td></td>
											<td>
												<asp:RadioButtonList ID="rblVimeoVideoThumbnail" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblVimeoVideoThumbnail_SelectedIndexChanged" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem Selected="True" Value="autocreate" Text="Auto create thumbnail" resourcekey="ListItemResource90"></asp:ListItem>
													<asp:ListItem Value="upload" Text="Upload thumbnail" resourcekey="ListItemResource91"></asp:ListItem>
													<asp:ListItem Value="standard" Text="Use standard image" resourcekey="ListItemResource92"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divVimeoUploadThumbnail" runat="server" style="display: none" class="paddingTopBottom">
													<asp:FileUpload ID="fuVimeoUploadThumbnail" runat="server" />
												</div>
												<div id="divVimeoStandardThumbnail" runat="server" style="display: none" class="paddingTopBottom">
													<div class="styledSelect">
														<asp:DropDownList ID="ddlVimeoVideoThumbSelect" runat="server" CausesValidation="True"></asp:DropDownList>
													</div>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblVimeoUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
								</div>
								<asp:Panel ID="pnlVimeoUploadSingleVideo" runat="server">
									<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
										<tr>
											<asp:Label ID="lblVimeoSingleUploadMessage" runat="server" CssClass="subtitleregion" EnableViewState="False"></asp:Label>
										</tr>
										<tr>
											<td>
												<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
													<asp:FileUpload ID="fuVimeoVideoFileInput" runat="server" EnableTheming="True" />
												</div>
												<div style="display: block; float: left; margin-left: 15px;">
													<asp:Button ID="btnVimeoSingleUpload" runat="server" Text="Upload to Vimeo" OnClick="btnVimeoSingleUpload_Click" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
								<asp:Panel ID="pnlVimeoUploadfineUploader" runat="server" Visible="False">
									<div id="galleryVimeoFineUploaderContainer" class="EDS_simpleFineUploader">
										<div class="uploader">
										</div>
										<div class="uploadControls">
											<div class="actions">
												<span class="action fileSelection">
													<asp:Label ID="galleryVimeoFineUploaderSelectFiles" runat="server" resourcekey="fineVideoUploaderSelectFiles" Text="Select videos" />
													<span class="dnnInputFileWrapper">
														<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
															<asp:Label ID="galleryVimeoFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
														</span>
											</div>
											<div class="dndContainer">
												<p>
													<asp:Label ID="galleryVimeoFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
												</p>
											</div>
										</div>
										<div class="uploadDetails">
											<ol class="fileUploadList">
											</ol>
										</div>
									</div>
									<asp:HiddenField ID="hfVimeoUploadedVideos" runat="server" Value="" EnableViewState="False" />
								</asp:Panel>
								<div style="display: none; line-height: 0pt;">
									<asp:Button ID="btnSaveVimeoVideoUpload" runat="server" OnClick="VimeoMultiVideoUpload" Text="Save" />
								</div>
							</asp:Panel>
						</asp:Panel>
						<asp:Panel ID="pnlAudioUploadContainer" runat="server" Visible="False" CssClass="contentSection audioUpload">
							<div class="specialOptions">
								<h2>
									<asp:Label ID="lblAddAudio" resourcekey="lblAddAudio" runat="server" CssClass="AddDesc" Text="Add&lt;br&gt;audio"></asp:Label>
								</h2>
								<div class="optionsList">
									<asp:RadioButtonList ID="rblAudioUploadSelectType" runat="server" AutoPostBack="True" CssClass="styledRadio small" OnSelectedIndexChanged="rblSelectAudioUpload_SelectedIndexChanged" RepeatDirection="Horizontal">
										<asp:ListItem resourcekey="ListItemResource93" Text="Upload audio file" Value="upload"></asp:ListItem>
										<asp:ListItem resourcekey="MultiAudioUpload" Value="multi">Multi audio file upload</asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource94" Text="Add audio file from server" Value="audioserver"></asp:ListItem>
										<asp:ListItem resourcekey="ListItemResource95" Text="Add all files from server folder" Value="folder"></asp:ListItem>
										<asp:ListItem resourcekey="liAmazonS3" Value="AmazonS3">Amazon S3</asp:ListItem>
									</asp:RadioButtonList>
								</div>
							</div>
							<asp:Panel ID="pnlAuFile" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblAudioUploadFile" runat="server" CssClass="uploadAudio" Text="Upload audio file" resourcekey="lblAudioUploadFileResource1"></asp:Label>
								</h4>
								<asp:Panel ID="pnlAUUploadFile" runat="server" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadSelectFile" ResourceKey="lblAudioUploadSelectFile" runat="server" HelpText="Select audio file to upload:" Text="Select file:" HelpKey="lblAudioUploadSelectFile.HelpText" />
											</td>
											<td>
												<asp:FileUpload ID="fuAudio" runat="server" />
											</td>
										</tr>
									</table>
								</asp:Panel>
								<asp:Panel ID="pnlAUAddFileFromServer" runat="server" Visible="False" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadSelectFolder" ResourceKey="lblAudioUploadSelectFolder" runat="server" Text="Select folder:" HelpText="Select folder:" HelpKey="lblAudioUploadSelectFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAUFolders" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlAUFolders_SelectedIndexChanged"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadSelectFileFromFolder" ResourceKey="lblAudioUploadSelectFileFromFolder" runat="server" Text="Select audio file:" HelpText="Select audio file:" HelpKey="lblAudioUploadSelectFileFromFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAUFiles" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadShowMainGalleryFolder" ResourceKey="lblAudioUploadShowMainGalleryFolder" runat="server" Text="Show main gallery folder:" HelpText="Add main EasyDNN gallery folder to folders list:" HelpKey="lblAudioUploadShowMainGalleryFolder.HelpText"></dnn:Label>
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAUShowMinGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="cbAUShowMinGalFolder_CheckedChanged" resourcekey="cbAUShowMinGalFolderResource1" Text="Show main gallery folder" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadDeleteOriginalFile" ResourceKey="lblAudioUploadDeleteOriginalFile" runat="server" HelpText="File will be copied to gallery folder. Delete original file:" Text="Delete original file:" HelpKey="lblAudioUploadDeleteOriginalFile.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAUDeleteOriginalFile" runat="server" resourcekey="cbAUDeleteOriginalFileResource1" Text="Delete original file" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
								<asp:Panel ID="pnlAAF" runat="server" CssClass="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadAddFolderSelect" runat="server" Text="Select folder:" ResourceKey="lblAudioUploadAddFolderSelectResource1" HelpText="Select folder:"></dnn:Label>
											</td>
											<td>
												<div class="styledSelect">
													<asp:DropDownList ID="ddlAddAudioFolder" runat="server"></asp:DropDownList>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadAddFolderShowMainGalleryFolder" ResourceKey="lblAudioUploadAddFolderShowMainGalleryFolder" runat="server" HelpText="Add main EasyDNN gallery folder to folders list:" Text="Show main gallery folder:" HelpKey="lblAudioUploadAddFolderShowMainGalleryFolder.HelpText" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAAFShowMainGalFolder" runat="server" AutoPostBack="True" OnCheckedChanged="cbAAFShowMainGalFolder_CheckedChanged" resourcekey="cbAAFShowMainGalFolderResource1" Text="Show main gallery folder" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadAddFolderDeleteOriginalFile" ResourceKey="lblAudioUploadAddFolderDeleteOriginalFile" runat="server" HelpText="File will be copied to gallery folder. Delete original file:" Text="Delete original file:" HelpKey="lblAudioUploadAddFolderDeleteOriginalFile.HelpText" Visible="True" />
											</td>
											<td>
												<div class="styledCheckbox noLabel">
													<asp:CheckBox ID="cbAAFDeleteOriginalFile" runat="server" resourcekey="cbAAFDeleteOriginalFileResource1" Text="Delete original file" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadEnterTitle" ResourceKey="lblAudioUploadEnterTitle" runat="server" Text="Title:" ControlName="tbAudioTitle" HelpText="Enter the audio file title:" HelpKey="lblAudioUploadEnterTitle.HelpText"></dnn:Label>
											</td>
											<td>
												<div id="divAUTitleTextBox" runat="server">
													<asp:TextBox ID="tbAudioTitle" runat="server" CssClass="large"></asp:TextBox>
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbAudioUploadFilenameAsTitle" runat="server" Text="Use filename as title" resourcekey="cbAudioUploadFilenameAsTitleResource1" />
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
															<asp:ListItem Value="AllUppercase" Text="Set this to change title to uppercase" resourcekey="ListItemResource97"></asp:ListItem>
															<asp:ListItem Value="AllLowercase" Text="Set this to change title to lowercase" resourcekey="ListItemResource98"></asp:ListItem>
															<asp:ListItem Value="AllFirstUppercase" Text="Set this to change first letter of every word in title to uppercase" resourcekey="ListItemResource99"></asp:ListItem>
															<asp:ListItem Value="FirstUppercase" Text="Set this to change first letter of title to uppercase" resourcekey="ListItemResource100"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbAudioUploadSubtitle" runat="server" TextMode="MultiLine" MaxLength="2000" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadDescription" ResourceKey="lblAudioUploadDescription" runat="server" ControlName="tbAudioDescription" HelpText="Enter the audio file description:" Text="Description:" HelpKey="lblAudioUploadDescription.HelpText" />
											</td>
											<td>
												<asp:TextBox ID="tbAudioDescription" runat="server" TextMode="MultiLine" CssClass="large" MaxLength="4000"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAudioUploadThumbnailSelect" ResourceKey="lblAudioUploadThumbnailSelect" runat="server" HelpText="Upload the thumbnail for video file or use standard image:" Text="Thumbnail:" HelpKey="lblAudioUploadThumbnailSelect.HelpText" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblAudioUploadSelectThumbSource" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem Selected="True" Value="standard" Text="Use standard image" resourcekey="ListItemResource101"></asp:ListItem>
													<asp:ListItem Value="upload" Text="Upload" resourcekey="ListItemResource102"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divAUSelectStantard" runat="server" class="paddingTopBottom">
													<div class="styledSelect">
														<asp:DropDownList ID="ddlAUSelectSTandThumb" runat="server"></asp:DropDownList>
													</div>
												</div>
												<div id="divAUUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
													<asp:FileUpload ID="fuAudioUpload" runat="server" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblAudioUploadMessage" runat="server" AssociatedControlID="btnUploadAudio" EnableViewState="False"></asp:Label>
											</td>
										</tr>
									</table>
									<div class="mainActions">
										<asp:LinkButton ID="btnUploadAudio" runat="server" OnClick="btnUploadAudio_Click" Text="Upload" resourcekey="btnUploadAudioResource1" CssClass="upload" />
									</div>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlMultiAudioFileUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblMultiAudioUploadFile" runat="server" resourcekey="lblMultiAudioUploadFile" Text="Multi upload audio file" CssClass="multiUploadAudio"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiAudioUploadEnterTitle" runat="server" ControlName="tbAudioTitle" HelpKey="lblAudioUploadEnterTitle.HelpText" HelpText="Enter the audio file title:" ResourceKey="lblAudioUploadEnterTitle" Text="Title:" />
											</td>
											<td>
												<div id="divMultiAUTitleTextBox" runat="server">
													<asp:TextBox ID="tbMultiAudioTitle" runat="server" CssClass="large"></asp:TextBox>
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMultiAudioUploadFilenameAsTitle" runat="server" resourcekey="cbAudioUploadFilenameAsTitleResource1" Text="Use filename as title" />
												</div>
												<div id="divMultiAUFilenameAsTitle" runat="server" style="display: none">
													<asp:Panel ID="pnlAUFilenameasTitle0" runat="server">
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiAudioUploadRemoveExtenzion" runat="server" resourcekey="cbAudioUploadRemoveExtenzionResource1" Text="Remove extension" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiAudioUploadTitleReplaceUnderscore" runat="server" resourcekey="cbAudioUploadTitleReplaceUnderscoreResource1" Text="Set this to replace &quot;_&quot; with blank space in title" />
														</div>
														<div class="styledCheckbox">
															<asp:CheckBox ID="cbMultiAudioUploadTitleReplaceMinus" runat="server" resourcekey="cbAudioUploadTitleReplaceMinusResource1" Text="Set this to replace &quot;-&quot; with blank space in title" />
														</div>
														<asp:RadioButtonList ID="rblMultiAudioUploadTitleOptions" runat="server" CssClass="styledRadio small">
															<asp:ListItem resourcekey="ListItemResource97" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource98" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource99" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource100" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiAudioUploadSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbMultiAudioUploadSubtitle" runat="server" TextMode="MultiLine" MaxLength="2000" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiAudioUploadDescription" runat="server" ControlName="tbAudioDescription" HelpKey="lblAudioUploadDescription.HelpText" HelpText="Enter the audio file description:" ResourceKey="lblAudioUploadDescription" Text="Description:" />
											</td>
											<td>
												<asp:TextBox ID="tbMultiAudioDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblMultiAudioUploadThumbnailSelect" runat="server" HelpKey="lblAudioUploadThumbnailSelect.HelpText" HelpText="Upload the thumbnail for video file or use standard image:" ResourceKey="lblAudioUploadThumbnailSelect" Text="Thumbnail:" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblMultiAudioUploadSelectThumbSource" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="ListItemResource101" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource102" Text="Upload" Value="upload"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divMultiAUSelectStantard" runat="server" class="paddingTopBottom">
													<div class="styledSelect">
														<asp:DropDownList ID="ddlMultiAUSelectSTandThumb" runat="server"></asp:DropDownList>
													</div>
												</div>
												<div id="divMultiAUUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
													<asp:FileUpload ID="fuMultiAudioUploadThumbnail" runat="server" />
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<asp:Label ID="lblMultiAudioUploadMessage" runat="server" EnableViewState="False"></asp:Label>
											</td>
										</tr>
										<tr id="trMAUPostToJournal" runat="server" visible="false">
											<td class="labels">
												<dnn:Label ID="lblMAUPostToJournal" runat="server" Text="Post to Journal:" HelpText="Post to Journal:" EnableViewState="True" HelpKey="lblPostToJurnal.HelpText" ResourceKey="lblMAUPostToJournal" />
											</td>
											<td>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbMAUPostToJournal" ResourceKey="PostToJournal" runat="server" />
												</div>
											</td>
										</tr>
									</table>
								</div>
								<asp:Panel ID="pnlAudioUploadUploadify" runat="server" Visible="True">
									<table cellpadding="0" cellspacing="0" align="center" class="multiuploadcontrol">
										<tr>
											<td>
												<div style="display: block; float: left; margin-left: 30px; padding-top: 4px;">
													<asp:FileUpload ID="MultiAudioFileInput" runat="server" EnableTheming="True" />
												</div>
												<div style="display: block; float: left; margin-left: 15px;">
													<a class="btnUpload" href="javascript:jQuery('#<%=MultiAudioFileInput.ClientID%>').uploadifyUpload();"><%=startUpload%></a> <a href="javascript:jQuery('#<%=MultiAudioFileInput.ClientID%>').uploadifyClearQueue();"><%=ViewState["ClearQueue"]%></a>
												</div>
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
													<asp:Label ID="galleryAudioFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
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
									<asp:Button ID="btnSaveMultiAudioUpload" runat="server" OnClick="MultiAudioUpload" Text="Save" />
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlAmazonS3AudioUpload" runat="server" Visible="False" CssClass="content">
								<h4>
									<asp:Label ID="lblAmazonS3Title0" resourcekey="liAmazonS3" runat="server" CssClass="amazonS3Upload" Text="Amazon S3"></asp:Label>
								</h4>
								<div class="optionsPanel">
									<table>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonUploadAudioURL" runat="server" HelpText="Aamazon S3 audio URL link." Text="Aamazon S3 audio URL link:" HelpKey="lblAmazonUploadAudioURL.HelpText" ResourceKey="lblAmazonUploadAudioURL.Text" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonAudioURL" runat="server" ValidationGroup="vgAmazonAudioUpload" CssClass="large" MaxLength="1500"></asp:TextBox>
												<asp:RequiredFieldValidator ID="rfvAmazonAudioURL" runat="server" ControlToValidate="tbAmazonAudioURL" ErrorMessage="This filed is required." resourcekey="rfvEmbedVideoCodeResource1.ErrorMessage" ValidationGroup="vgAmazonAudioUpload" CssClass="smallInfo error"></asp:RequiredFieldValidator>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonUploadAudioTitle" runat="server" HelpText="Enter the title of audio file:" Text="Audio title:" HelpKey="lblAmazonUploadAudioTitle.HelpText" ResourceKey="lblAmazonUploadAudioTitle.Text" />
											</td>
											<td>
												<div id="divAmazonAudioTitle" runat="server">
													<asp:TextBox ID="tbAmazonAudioTitle" runat="server" CssClass="large"></asp:TextBox>
												</div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbAmazonAudioUploadFilenameAsTitle" runat="server" resourcekey="cbVideoUploadFilenameAsTitleResource1" Text="Use filename as title" />
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
															<asp:ListItem resourcekey="ListItemResource79" Text="Set this to change title to uppercase" Value="AllUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource80" Text="Set this to change title to lowercase" Value="AllLowercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource81" Text="Set this to change first letter of every word in title to uppercase" Value="AllFirstUppercase"></asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource82" Text="Set this to change first letter of title to uppercase" Value="FirstUppercase"></asp:ListItem>
														</asp:RadioButtonList>
													</asp:Panel>
												</div>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonAudioUploadSubtitle" runat="server" Text=" Subtitle:" HelpText="Enter subtitle for images from zip file."></dnn:Label>
											</td>
											<td>
												<asp:TextBox ID="tbAmazonAudioUploadSubtitle" runat="server" TextMode="MultiLine" MaxLength="2000" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonAudioUploadDescription" runat="server" ControlName="tbFlashDescription" HelpText="Enter the audio description:" Text="Description:" HelpKey="lblAmazonAudioUploadDescription.HelpText" ResourceKey="lblAmazonAudioUploadDescription.Text" />
											</td>
											<td>
												<asp:TextBox ID="tbAmazonAudioDescription" runat="server" MaxLength="4000" TextMode="MultiLine" CssClass="large"></asp:TextBox>
											</td>
										</tr>
										<tr>
											<td class="labels">
												<dnn:Label ID="lblAmazonAudioUploadThumbnail" runat="server" HelpText="Upload the thumbnail for audio file or use standard image:" Text="Thumbnail:" HelpKey="lblAmazonAudioUploadThumbnail.HelpText" ResourceKey="lblAmazonAudioUploadThumbnail.Text" />
											</td>
											<td>
												<asp:RadioButtonList ID="rblAmazonAudioThumbnailSelect" runat="server" OnLoad="rblFlashThumbnail_Load" RepeatDirection="Horizontal" CssClass="styledRadio small">
													<asp:ListItem resourcekey="ListItemResource83" Selected="True" Text="Use standard image" Value="standard"></asp:ListItem>
													<asp:ListItem resourcekey="ListItemResource84" Text="Upload" Value="Upload"></asp:ListItem>
												</asp:RadioButtonList>
												<div id="divAmazonAudioStandardImage" runat="server" class="paddingTopBottom">
													<asp:Label ID="lblAmazonAudioUploadSelectStandardThumbnail" runat="server" resourcekey="lblVideoUploadSelectStandardThumbnailResource1" Text="Select standard thumbnail:"></asp:Label>
													<div class="styledSelect">
														<asp:DropDownList ID="ddlAmazobAudioThumbSelect" runat="server"></asp:DropDownList>
													</div>
												</div>
												<div id="divAmazonAudioUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
													<asp:Label ID="lblAudioUploadSelectThumbnailToUpload" runat="server" resourcekey="lblVideoUploadSelectThumbnailToUploadResource1" Text="Select thumbnail to upload:"></asp:Label>
													<asp:FileUpload ID="fuAmazonAudioThumbnail" runat="server" />
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
										<asp:LinkButton ID="btnAmazonAudioUpload" runat="server" OnClick="btnAmazonAudioUpload_Click" resourcekey="btnAmazonVideoUpload" Text="Upload" ValidationGroup="vgAmazonAudioUpload" CssClass="add" />
									</div>
								</div>
							</asp:Panel>
						</asp:Panel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlImageEdit" runat="server" CssClass="listItems additionalOptions imageEdit" Visible="False">
					<h2>
						<asp:Label ID="lblImageEditorTitle" runat="server" Text="Image Edit" resourcekey="lblImageEditorTitleResource1"></asp:Label>
					</h2>
					<table id="tblImageEdit" runat="server" class="additionalOptionsList fullWidthTable noTdBorders noTableBorder">
						<tr>
							<td class="subjectName short">
								<asp:Label ID="lblImageEditorGalleryName" runat="server" Text="Gallery:" resourcekey="lblImageEditorGalleryNameResource1"></asp:Label>
							</td>
							<td>
								<asp:Label ID="lblIEGalleryName2" runat="server" resourcekey="lblIEGalleryName2Resource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<asp:HyperLink ID="hlIEViewImage" runat="server" Target="_blank" CssClass="thumbnail rotate0">
									<asp:Image ID="imgEditPanelthumb" runat="server" />
								</asp:HyperLink>
								<asp:HiddenField ID="hfImageEditRotateValue" runat="server" Value="0" />
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblRotateImage" ResourceKey="lblRotateImage" runat="server" HelpText="Set the image roatation:" Text="Rotate image:" />
							</td>
							<td>
								<div class="itemActions itemEditActions">
									<asp:LinkButton ID="lbImageRotateLeft" OnClientClick="return rotateImage('left');" runat="server" Text="Left" CssClass="itemEditRotate rotateLeft" />
									<asp:LinkButton ID="lbImageRotateRight" OnClientClick="return rotateImage('right');" runat="server" Text="Right" CssClass="itemEditRotate rotateRight" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblImageEditorFilename" ResourceKey="lblImageEditorFilename" runat="server" ControlName="tbEditTitlePanel" HelpText="Filename:" Text="Filename:" HelpKey="lblImageEditorFilename.HelpText" />
							</td>
							<td>
								<asp:Label ID="lblImageEditorFilename2" runat="server" resourcekey="lblImageEditorFilename2Resource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblImageEditorImageTitle" ResourceKey="lblImageEditorImageTitle" runat="server" Text="Image title:" HelpText="Edit image title:" ControlName="tbEditTitlePanel" HelpKey="lblImageEditorImageTitle.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbEditTitlePanel" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblImageEditorImageSubtitle" ResourceKey="lblImageEditorImageSubtitle" runat="server" Text="Image subtitle:" HelpText="Edit image subtitle:" ControlName="tbEditTitlePanel" HelpKey="lblImageEditorImageSubtitle.HelpText" TextMode="MultiLine" />
							</td>
							<td>
								<asp:TextBox ID="tbEditSubtitlePanel" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblImageEditorDescription" ResourceKey="lblImageEditorDescription" runat="server" HelpText="Edit description:" Text="Description:" HelpKey="lblImageEditorDescription.HelpText" />
							</td>
							<td>
								<dnn:TextEditor ID="txtDescHmlEdit" runat="server" Height="350" Width="600" />
							</td>
						</tr>
						<tr id="trEdiImageURL" runat="server">
							<td class="subjectName short">
								<dnn:Label ID="lblImageEditorUrl" ResourceKey="lblImageEditorUrl" runat="server" ControlName="tbEditImageUrl" HelpText="Edit Media Url link:" Text="Media Url:" HelpKey="lblImageEditorUrl.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbEditImageUrl" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr id="trEdiReplaceImage" runat="server">
							<td class="subjectName short textTop">
								<dnn:Label ID="lblImageEditorReplaceImage" ResourceKey="lblImageEditorReplaceImage" runat="server" HelpText="Use this to upload new image." Text="Replace image:" HelpKey="lblImageEditorReplaceImage.HelpText" />
							</td>
							<td>
								<asp:FileUpload ID="fuReplaceImage" runat="server" />
								<div class="itemActions itemEditActions">
									<asp:LinkButton ID="btnImageEditorReplaceImage" runat="server" OnClick="btnReplacemage_Click" Text="Replace" resourcekey="btnImageEditorReplaceImageResource1" ValidationGroup="vgReplaceImage" CssClass="itemEditCopy" />
								</div>
								<div class="styledCheckbox displayInline">
									<asp:CheckBox ID="cbIEResizeNewImage" resourcekey="cbIEResizeNewImage" runat="server" Text="Resize new image" AutoPostBack="True" OnCheckedChanged="cbIEResizeNewImage_CheckedChanged" />
								</div>
								<asp:Panel ID="pnlIEResizeNewImage" runat="server" Visible="False" CssClass="paddingTopBottom">
									<asp:Label ID="lblIEResizeWidth" resourcekey="lblIEResizeWidth" runat="server" Text="Width:"></asp:Label>
									<asp:RequiredFieldValidator Display="Dynamic" ID="rfvIEWidth" runat="server" ControlToValidate="tbIEResizeWidth" ErrorMessage="Please enter width." ValidationGroup="vgReplaceImage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:TextBox ID="tbIEResizeWidth" runat="server" CssClass="small textCenter" ValidationGroup="vgReplaceImage">800</asp:TextBox>
									<asp:Label ID="lblResizeHeight" resourcekey="lblResizeHeight" runat="server" Text="Height:"></asp:Label>
									<asp:RequiredFieldValidator Display="Dynamic" ID="rfvIEHeight" runat="server" ControlToValidate="tbIEResizeHeight" ErrorMessage="Please enter height." ValidationGroup="vgReplaceImage" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:TextBox ID="tbIEResizeHeight" runat="server" CssClass="small textCenter" ValidationGroup="vgReplaceImage">600</asp:TextBox>
									<div class="styledCheckbox paddingTopBottom">
										<asp:CheckBox ID="cbIEUseUnresizedAsDownload" runat="server" Text="Use unresized image as download version." />
									</div>
								</asp:Panel>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr id="trEditImageHiRes" runat="server">
							<td class="subjectName short textTop">
								<dnn:Label ID="lblHiResVersion" runat="server" HelpText="Upload downloadable version of the image." Text="Upload downloadable version:" HelpKey="lblHiResVersion.HelpText" ResourceKey="lblHiResVersion" />
							</td>
							<td class="textTop">
								<asp:HyperLink ID="hlIEDownloadImage" runat="server" Target="_blank" CssClass="thumbnail">
									<asp:Image ID="imgEditPanelthumbDownload" runat="server" Visible="False" />
								</asp:HyperLink>
								<asp:FileUpload ID="fuIEHiResVersion" runat="server" />
								<div class="itemActions itemEditActions paddingTop">
									<asp:LinkButton ID="btnHiRes" runat="server" resourcekey="btnHiRes" OnClick="btnHiRes_Click" Text="Upload downloadable version" CssClass="itemEditCopy" />
									<asp:LinkButton ID="btnUseViewVersionAsDownload" resourcekey="btnUseViewVersionAsDownload" runat="server" OnClick="btnUseViewVersionAsDownload_Click" Text="Use view version as download" CssClass="itemEditUpdate" />
								</div>
							</td>
						</tr>
					</table>
					<div class="mainActions">
						<asp:LinkButton ID="btnImageEditorSave" runat="server" OnClick="btnImageEditPanelSave_Click" Text="Save " resourcekey="btnImageEditorSaveResource1" CssClass="downSaveClose" />
						<asp:LinkButton ID="btnImageEditorCancel" runat="server" OnClick="btnCancelEditPanel_Click" Text="Cancel" resourcekey="btnImageEditorCancelResource1" CssClass="downClose" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEmbedVideoEdit" CssClass="listItems additionalOptions videoEdit" runat="server" Visible="False">
					<h2>
						<asp:Label ID="lblEmbedVideoEditorTitle" runat="server" Text="Embed Video Edit" resourcekey="lblEmbedVideoEditorTitleResource1"></asp:Label>
					</h2>
					<asp:Label ID="lblEVEInfo" runat="server" Visible="False"></asp:Label>
					<table class="additionalOptionsList fullWidthTable noTdBorders noTableBorder">
						<tr>
							<td class="subjectName short textTop">
								<asp:Label ID="lblEmbedVideoEditGalleryName" runat="server" Text="Gallery:" resourcekey="lblEmbedVideoEditGalleryNameResource1"></asp:Label>
							</td>
							<td>
								<asp:Label ID="lblEVGalleryName" runat="server" resourcekey="lblEVGalleryNameResource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblEmbedVideoEditTitle" ResourceKey="lblEmbedVideoEditTitle" runat="server" ControlName="tbEMbedVideoEditTitle" HelpText="Edit video title:" Text="Video title:" HelpKey="lblEmbedVideoEditTitle.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbEMbedVideoEditTitle" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblEmbedVideoEditSubTitle" runat="server" ControlName="tbEMbedVideoEditTitle" HelpText="Edit video subtitle:" Text="Video title:" />
							</td>
							<td>
								<asp:TextBox ID="tbEmbedVideoEditSubTitle" runat="server" class="large" TextMode="MultiLine"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblEmbedVideoEditCode" ResourceKey="lblEmbedVideoEditCode" runat="server" ControlName="tbEmbedVideoEditUrl" HelpText="Edit embed video code:" Text="Embed video code:" HelpKey="lblEmbedVideoEditCode.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbEmbedVideoEditUrl" runat="server" CssClass="large" TextMode="MultiLine"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblEmbedVideoEditUrl" ResourceKey="lblEmbedVideoEditUrl" runat="server" ControlName="tbEmbedEditURL" HelpText="Edit video Url:" Text="Video Url:" HelpKey="lblEmbedVideoEditUrl.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbEmbedEditURL" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblEmbedVideoEditDescription" ResourceKey="lblEmbedVideoEditDescription" runat="server" ControlName="txtEVEDescription" HelpText="Edit description:" Text="Description:" HelpKey="lblEmbedVideoEditDescription.HelpText" />
							</td>
							<td>
								<dnn:TextEditor ID="txtEVEDescription" runat="server" Height="350" Width="600" />
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<asp:Label ID="lblEmbedVideoEditThumbnail" runat="server" Text="Thumbnail:" resourcekey="lblEmbedVideoEditThumbnailResource1"></asp:Label>
							</td>
							<td>
								<div class="thumbnail">
									<asp:Image ID="imgEVEThumbnail" runat="server" Width="150px" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr id="trEditEmbedReplace" runat="server">
							<td class="subjectName short textTop">
								<dnn:Label ID="lblEmbedVideoEditReplaceThumb" ResourceKey="lblEmbedVideoEditReplaceThumb" runat="server" HelpText="Replace thumbnail for video file:" Text="Replace thumbnail:" HelpKey="lblEmbedVideoEditReplaceThumb.HelpText" />
							</td>
							<td>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbEVEReplaceThumbnail" runat="server" resourcekey="cbEVEReplaceThumbnailResource1" Text="Replace thumbnail for video file" />
								</div>
								<div id="divEVEAddThumb" style="display: none" runat="server" class="paddingTop">
									<asp:RadioButtonList ID="rblEmbedVideoEditChangeThumb" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
										<asp:ListItem Selected="True" Value="standard" Text="Use standard image" resourcekey="ListItemResource103"></asp:ListItem>
										<asp:ListItem Text="Upload" resourcekey="ListItemResource104"></asp:ListItem>
										<asp:ListItem Value="autocreate" Text="Auto create thumbnail"></asp:ListItem>
									</asp:RadioButtonList>
									<div id="divEVEStandardThumb" runat="server" class="paddingTopBottom">
										<div class="styledSelect">
											<asp:DropDownList ID="ddlEVESTandardThumbList" runat="server"></asp:DropDownList>
										</div>
									</div>
									<div id="divEVEThumbUpload" runat="server" style="display: none" class="paddingTopBottom">
										<asp:FileUpload ID="fuEVEReplaceThumb" runat="server" />
									</div>
									<div id="divEVEThumbAutoCreate" runat="server" style="display: none">
									</div>
								</div>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblEmbedVideoEditorMessage" runat="server" EnableViewState="False"></asp:Label>
					<div class="mainActions">
						<asp:LinkButton ID="bntEmbedVideoEditSave" runat="server" OnClick="bntEmbedVideoEditSave_Click" Text="Save" resourcekey="bntEmbedVideoEditSaveResource1" CssClass="downSaveClose" />
						<asp:LinkButton ID="btnEMbedVideoEditCancel" runat="server" OnClick="btnEMbedVideoEditCancel_Click" Text="Cancel" resourcekey="btnEMbedVideoEditCancelResource1" CssClass="downClose" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlVideoEdit" CssClass="listItems additionalOptions videoEdit" runat="server" Visible="False">
					<h2>
						<asp:Label ID="lblVideoEditTitle" runat="server" Text="Video Edit" resourcekey="lblVideoEditTitleResource1"></asp:Label>
					</h2>
					<table class="additionalOptionsList fullWidthTable noTdBorders noTableBorder">
						<tr>
							<td class="subjectName short">
								<asp:Label ID="lblVideoEditGalleryName" runat="server" Text="Gallery:" resourcekey="lblVideoEditGalleryNameResource1"></asp:Label>
							</td>
							<td>
								<asp:Label ID="lblVEGalleryName" runat="server" resourcekey="lblVEGalleryNameResource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditFilename" ResourceKey="lblVideoEditFilename" runat="server" HelpText="Filename:" Text="Filename:" HelpKey="lblVideoEditFilename.HelpText" />
							</td>
							<td>
								<asp:Label ID="lblFEFilename2" runat="server" resourcekey="lblFEFilename2Resource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditorTitle" ResourceKey="lblVideoEditorTitle" runat="server" Text="Title:" ControlName="tbFlashEditorTitle" HelpText="Edit video title:" HelpKey="lblVideoEditorTitle.HelpText"></dnn:Label>
							</td>
							<td>
								<asp:TextBox ID="tbFlashEditorTitle" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblVideoEditorSubtitle" runat="server" Text="Subtitle:" ControlName="tbFlashEditorTitle" HelpText="Edit video subtitle:"></dnn:Label>
							</td>
							<td>
								<asp:TextBox ID="tbVideoEditorSubtitle" runat="server" CssClass="large" TextMode="MultiLine"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditorWidth" ResourceKey="lblVideoEditorWidth" runat="server" ControlName="tbVideoEditorWidth" HelpText="Edit video width:" Text="Width:" HelpKey="lblVideoEditorWidth.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbVideoEditorWidth" runat="server" class="small textCenter"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvVideoEditorWidth" runat="server" ControlToValidate="tbVideoEditorWidth" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgVideoEditor" resourcekey="rfvVideoEditorWidthResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvVideoEditWidth" runat="server" ControlToValidate="tbVideoEditorWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVideoEditor" resourcekey="cvVideoEditWidthResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditHeight" ResourceKey="lblVideoEditHeight" runat="server" ControlName="tbVideoEditorHeight" HelpText="Edit video height:" Text="Height:" HelpKey="lblVideoEditHeight.HelpText" />
							</td>
							<td>
								<asp:TextBox ID="tbVideoEditorHeight" runat="server" class="small textCenter"></asp:TextBox>
								<asp:RequiredFieldValidator ID="rfvVideoEditorHeight" runat="server" ControlToValidate="tbVideoEditorHeight" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgVideoEditor" resourcekey="rfvVideoEditorHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:RequiredFieldValidator>
								<asp:CompareValidator ID="cvVideoEditHeight" runat="server" ControlToValidate="tbVideoEditorHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgVideoEditor" resourcekey="cvVideoEditHeightResource1.ErrorMessage" CssClass="smallInfo inline error"></asp:CompareValidator>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditDescription" ResourceKey="lblVideoEditDescription" runat="server" HelpText="Edit description." Text="Description:" HelpKey="lblVideoEditDescription.HelpText" />
							</td>
							<td>
								<dnn:TextEditor ID="txtVideoEditDescription" runat="server" Height="350" Width="600" />
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<asp:Label ID="lblVideoEditThumbnail" runat="server" Text="Thumbnail:" resourcekey="lblVideoEditThumbnailResource1"></asp:Label>
							</td>
							<td>
								<div class="thumbnail">
									<asp:Image ID="imgFLEThumbnail" runat="server" Width="150px" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblVideoEditReplaceThumbnail" ResourceKey="lblVideoEditReplaceThumbnail" runat="server" HelpText="Upload new or select standard thumbnail:" Text="Replace thumbnail:" HelpKey="lblVideoEditReplaceThumbnail.HelpText" />
							</td>
							<td>
								<div class="styledCheckbox big">
									<asp:CheckBox ID="cbVideoEditAddNewThumbnail" runat="server" Text="Add new thumbnail" CausesValidation="True" resourcekey="cbVideoEditAddNewThumbnailResource1" />
								</div>
								<div id="VEThumb" runat="server" style="display: none" class="paddingTopBottom">
									<asp:Panel ID="pnlVEAddNewThumbnail" runat="server">
										<asp:RadioButtonList ID="rblVideoEditSelectNewThumb" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
											<asp:ListItem Selected="True" Value="standard" Text="Use standard image" resourcekey="ListItemResource105"></asp:ListItem>
											<asp:ListItem Value="upload" Text="Upload" resourcekey="ListItemResource106"></asp:ListItem>
										</asp:RadioButtonList>
										<div id="divVEStandardThumb" runat="server" class="paddingTopBottom">
											<div class="styledSelect">
												<asp:DropDownList ID="ddlVEStandardImage" runat="server"></asp:DropDownList>
											</div>
										</div>
										<div id="divVEUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
											<asp:FileUpload ID="fuFLEReplaceThumbnail" runat="server" />
										</div>
									</asp:Panel>
								</div>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<asp:Label ID="lblVideoEditStartupImage" runat="server" Text="Startup image:"></asp:Label>
							</td>
							<td>
								<asp:Image ID="imgVideoEditStartupImage" runat="server" Width="150px" ImageUrl="<%#ModulePath%>images/spacer.gif" />
								<div class="itemActions itemEditActions alignTop">
									<asp:LinkButton ID="btnVideoEditRemoveStartupImage" runat="server" Enabled="False" OnClick="btnVideoEditRemoveStartupImage_Click" Text="Remove startup image" CssClass="itemEditRemove" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblVideoEditReplaceStartupImage" runat="server" HelpText="Upload new or select standard thumbnail:" Text="Replace startup image:" />
							</td>
							<td>
								<div class="styledCheckbox big">
									<asp:CheckBox ID="cbVideoEditAddNewStartupImage" runat="server" CausesValidation="True" Text="Add new startup image" />
								</div>
								<div id="DivReplaceStartupImage" runat="server" style="display: none" class="paddingTopBottom">
									<asp:Panel ID="Panel1" runat="server">
										<asp:RadioButtonList ID="rblVideoEditSelectNewStartupImage" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
											<asp:ListItem Selected="True" Value="standard" Text="Use standard image" resourcekey="ListItemResource105"></asp:ListItem>
											<asp:ListItem Value="upload" Text="Upload" resourcekey="ListItemResource106"></asp:ListItem>
										</asp:RadioButtonList>
										<div id="DivVideoEditSelectStartupStandard" runat="server" class="paddingTopBottom">
											<div class="styledSelect">
												<asp:DropDownList ID="ddlVideoEditStandardStartup" runat="server"></asp:DropDownList>
											</div>
										</div>
										<div id="DivVideoEditSelectStartupUpload" runat="server" style="display: none" class="paddingTopBottom">
											<asp:FileUpload ID="fuVideoEditStartupImage" runat="server" />
										</div>
									</asp:Panel>
								</div>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblFlashEditorHelper" runat="server" resourcekey="lblFlashEditorHelperResource1" Visible="False"></asp:Label>
					<div class="mainActions">
						<asp:LinkButton ID="btnVideoEditSave" runat="server" OnClick="Button2btnFlashEditorSave_Click" resourcekey="btnVideoEditSaveResource1" CssClass="downSaveClose" Text="Save" ValidationGroup="vgVideoEditor" />
						<asp:LinkButton ID="btnVideoEditCancel" runat="server" OnClick="btnFlashEditorCancel_Click" resourcekey="btnVideoEditCancelResource1" Text="Cancel" CssClass="downClose" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlAudioEdit" runat="server" Visible="False" CssClass="listItems additionalOptions audioEdit">
					<h2>
						<asp:Label ID="lblAudioEditorTitle" runat="server" Text="Audio Edit" resourcekey="lblAudioEditorTitleResource1"></asp:Label>
					</h2>
					<table class="additionalOptionsList fullWidthTable noTdBorders noTableBorder">
						<tr>
							<td class="subjectName short">
								<asp:Label ID="lblAudeioEditGalleryName" runat="server" Text="Gallery:" resourcekey="lblAudeioEditGalleryNameResource1"></asp:Label>
							</td>
							<td>
								<asp:Label ID="lblAEGalleryName" runat="server" resourcekey="lblAEGalleryNameResource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblAudioEditFilename" ResourceKey="lblAudioEditFilename" runat="server" HelpText="Filename:" Text="Filename:" HelpKey="lblAudioEditFilename.HelpText" />
							</td>
							<td>
								<asp:Label ID="lblAEFilename2" runat="server" resourcekey="lblAEFilename2Resource1"></asp:Label>
							</td>
						</tr>
						<tr>
							<td class="subjectName short">
								<dnn:Label ID="lblAudioEditTile" ResourceKey="lblAudioEditTile" runat="server" Text="Title:" HelpText="Edit title:" HelpKey="lblAudioEditTile.HelpText"></dnn:Label>
							</td>
							<td>
								<asp:TextBox ID="tbAEName" runat="server" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblAudioEditSubtitle" ResourceKey="lblAudioEditSubtitle" runat="server" Text="Subtitle:" HelpText="Edit subtitle:"></dnn:Label>
							</td>
							<td>
								<asp:TextBox ID="tbAudioEditSubtitle" runat="server" TextMode="MultiLine" CssClass="large"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<dnn:Label ID="lblAudioEditDescription" runat="server" Text="Description:" HelpText="Edit description:" HelpKey="lblAudioEditDescription.HelpText"></dnn:Label>
							</td>
							<td>
								<dnn:TextEditor ID="txtAEDescription" runat="server" Height="350" Width="600" />
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr>
							<td class="subjectName short textTop">
								<asp:Label ID="lblAudioEditThumbnail" runat="server" Text="Thumbnail:" resourcekey="lblAudioEditThumbnailResource1"></asp:Label>
							</td>
							<td>
								<div class="thumbnail">
									<asp:Image ID="imgAEThumbnail" runat="server" Width="150px" />
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="2"></td>
						</tr>
						<tr id="trEditAudeioReplace" runat="server">
							<td class="subjectName short textTop">
								<dnn:Label ID="lblAudioEditReplaceThumbnail" ResourceKey="lblAudioEditReplaceThumbnail" runat="server" HelpText="Upload new or select standard thumbnail:" Text="Replace thumbnail:" HelpKey="lblAudioEditReplaceThumbnail.HelpText" />
							</td>
							<td>
								<div class="styledCheckbox noLabel big">
									<asp:CheckBox ID="cbAEAddNewThumbnail" runat="server" resourcekey="cbAEAddNewThumbnailResource1" Text="Replace thumbnail" />
								</div>
							</td>
						</tr>
						<tr id="trEditAudeioReplace2" runat="server">
							<td></td>
							<td>
								<div id="AENewThumbnail" style="display: none" runat="server" class="paddingTopBottom">
									<asp:RadioButtonList ID="rblAESelectNewThumbnail" runat="server" RepeatDirection="Horizontal" CssClass="styledRadio small">
										<asp:ListItem Value="standard" Selected="True" Text="Use standard image" resourcekey="ListItemResource107"></asp:ListItem>
										<asp:ListItem Value="upload" Text="Upload" resourcekey="ListItemResource108"></asp:ListItem>
									</asp:RadioButtonList>
									<div id="divAESelectStandardThumb" runat="server" class="paddingTopBottom">
										<div class="styledSelect">
											<asp:DropDownList ID="ddlAESelectStandardThumb" runat="server"></asp:DropDownList>
										</div>
									</div>
									<div id="divAEUploadThumb" runat="server" style="display: none" class="paddingTopBottom">
										<asp:FileUpload ID="fuAEReplaceThumbnail" runat="server" />
									</div>
								</div>
							</td>
						</tr>
					</table>
					<div class="mainActions">
						<asp:LinkButton ID="btnAudioEditSave" runat="server" OnClick="btnAESaveSettings_Click" Text="Save" resourcekey="btnAudioEditSaveResource1" CssClass="downSaveClose" />
						<asp:LinkButton ID="btnAudioEditCancel" runat="server" OnClick="btnAECancel_Click" Text="Cancel" resourcekey="btnAudioEditCancelResource1" CssClass="downClose" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlContentLocalization" runat="server" Visible="False" CssClass="listItems">
					<div class="additionalOptions color3">
						<h2>
							<asp:Label ID="lblContentLocalization" runat="server" resourcekey="lblContentLocalization" Text="Content localization"></asp:Label>
						</h2>
						<table class="additionalOptionsList fullWidthTable bottomTdBorders textLeft">
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblContentLocalizationMediaTitle" resourcekey="lblContentLocalizationMediaTitle" runat="server" Text="Media title:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationMediaTitleOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblContentLocalizationMediaDescription" resourcekey="lblContentLocalizationMediaDescription" runat="server" Text="Media description:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationMediaDescriptionOriginal" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblPortalDefLanguage" resourcekey="lblPortalDefLanguage" runat="server" Text="Poratal default language:">
									</asp:Label>
								</td>
								<td>
									<asp:Label ID="lblDefaultPortalLangugageImage" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<asp:Label ID="lblContentLocalizationLocalizedLanguages" runat="server" resourcekey="lblContentLocalizationLocalizedLanguages" Text="Localized languages:" Font-Bold="True"></asp:Label>
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationLocalizedLanguagesList" runat="server"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblContentLocalizationSelectLanguage" runat="server" HelpKey="lblContentLocalizationSelectLanguage.HelpText" HelpText="Select the languange you want to edit. There is no need to edit dafault language." Text="Select language:" />
								</td>
								<td>
									<div class="styledSelect">
										<asp:DropDownList ID="ddlContentLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageEditorContentLocalizationSelectLanguage_SelectedIndexChanged">
											<asp:ListItem Value="0">Select language</asp:ListItem>
										</asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblContentLocalizationTitle" ResourceKey="lblContentLocalizationTitle" runat="server" Text="Title:" HelpKey="lblContentLocalizationTitle.HelpText" HelpText="Title:"></dnn:Label>
								</td>
								<td>
									<asp:TextBox ID="tbContentLocalizationTitle" runat="server" CssClass="medium"></asp:TextBox>
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnContentLocalizationCopyDefault" runat="server" OnClick="btnContentLocalizationCopyDefault_Click" resourcekey="btnContentLocalizationCopyDefault" Text="Copy default values" CssClass="itemEditCopy" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblContentLocalizationSubtitle" runat="server" Text="Subtitle:" HelpText="Subtitle:"></dnn:Label>
								</td>
								<td>
									<asp:TextBox ID="tbContentLocalizationSubTitle" runat="server" CssClass="medium"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="subjectName short textTop">
									<dnn:Label ID="lblContentLocalizationDescription" ResourceKey="lblContentLocalizationDescription" runat="server" Text="Description:" HelpKey="lblContentLocalizationDescription.HelpText" HelpText="Description:"></dnn:Label>
								</td>
								<td>
									<dnn:TextEditor ID="txtContentLocalizationDescription" runat="server" Height="350" Width="600" />
								</td>
							</tr>
							<tr runat="server" id="trContentLocalizationMediaUrl" visible="false">
								<td class="subjectName short">
									<dnn:Label ID="lblContentLocalizationMediaUrl" runat="server" HelpKey="lblContentLocalizationMediaUrl.HelpText" HelpText="Media Url:" ResourceKey="lblContentLocalizationMediaUrl" Text="Media Url:" />
								</td>
								<td>
									<asp:TextBox ID="tbContentLocalizationMediaUrl" runat="server" CssClass="large" MaxLength="1500"></asp:TextBox>
								</td>
							</tr>
							<tr runat="server" id="trContentLocalizationAmazonUrl" visible="false">
								<td class="subjectName short">
									<dnn:Label ID="lblContentLocalizationAmazonUrl" runat="server" HelpText="Amazon Url:" ResourceKey="lblContentLocalizationAmazonUrl" Text="Amazon Url:" />
								</td>
								<td>
									<asp:TextBox ID="tbContentLocalizationAmazonUrl" runat="server" CssClass="large" MaxLength="1500"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<asp:Label ID="lblMediaLocalizationMessage" runat="server" EnableViewState="False"></asp:Label>
									<div class="itemActions mainActions">
										<asp:LinkButton ID="btnContentLocalizationUpdate" runat="server" OnClick="btnImageEditorContentLocalizationUpdate_Click" resourcekey="btnContentLocalizationUpdate" Text="Update" CssClass="downSaveClose" />
										<asp:LinkButton ID="btnContentLocalizationClose" runat="server" OnClick="btnContentLocalizationClose_Click" resourcekey="btnContentLocalizationClose" Text="Close" CssClass="downClose" />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlMoveMedia" runat="server" Visible="False" CssClass="listItems">
					<div class="additionalOptions color2">
						<h2>
							<asp:Label ID="lblMoveORCopyMedia" runat="server" Text="Move or copy selected media" resourcekey="lblMoveORCopyMediaResource1"></asp:Label>
						</h2>
						<table class="additionalOptionsList noTdBorders bottomTdBorders noTableBorder fullWidthTable">
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblMediaMoveID" ResourceKey="lblMediaMoveID" runat="server" HelpText="ID of the selected media." Text="ID:" HelpKey="lblMediaMoveID.HelpText" />
								</td>
								<td>
									<asp:Label ID="lblMoveMediaID2" runat="server" Text="ID"></asp:Label>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblMoveMediaTitle" ResourceKey="lblMoveMediaTitle" runat="server" Text="Title:" HelpText="Title of the selected media." HelpKey="lblMoveMediaTitle.HelpText"></dnn:Label>
								</td>
								<td>
									<asp:Label ID="lblMoveMedoaTitle2" runat="server" Text="Title"></asp:Label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td align="center">
									<asp:LinkButton ID="btnRefrehsData" runat="server" CssClass="refresh" ToolTip="Refresh category and gallery list" OnClick="btnRefrehsData_Click"></asp:LinkButton>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblMoveMediaSelectCategory" ResourceKey="lblMoveMediaSelectCategory" runat="server" Text="Select category:" HelpText="Select the category to move or copy image to:" HelpKey="lblMoveMediaSelectCategory.HelpText"></dnn:Label>
								</td>
								<td>
									<div class="styledSelect large">
										<asp:DropDownList ID="ddlMoveCategory" runat="server" DataTextField="CategoryName" DataValueField="CategoryID" AutoPostBack="True" OnSelectedIndexChanged="ddlMoveCategory_SelectedIndexChanged"></asp:DropDownList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="subjectName short">
									<dnn:Label ID="lblMedijaMoveGallerySelect" ResourceKey="lblMedijaMoveGallerySelect" runat="server" Text="Select gallery:" HelpText="Select the gallery to move or copy image to:" HelpKey="lblMedijaMoveGallerySelect.HelpText"></dnn:Label>
								</td>
								<td>
									<div class="styledSelect large">
										<asp:DropDownList ID="ddlMMSelectGallery" runat="server" DataSourceID="odsMoveGalleries" DataTextField="GalleryName" DataValueField="GalleryID"></asp:DropDownList>
									</div>
								</td>
							</tr>
						</table>
						<asp:Label ID="lblMoveMediaMessage" runat="server" EnableViewState="False"></asp:Label>
						<div class="itemActions mainActions">
							<asp:LinkButton ID="btnMoveMediaCopy" runat="server" OnClick="btnMMCopy_Click" Text="Copy" resourcekey="btnMoveMediaCopyResource1" CssClass="copy" />
							<asp:LinkButton ID="btnMoveMediaMove" runat="server" OnClick="btnMMMove_Click" Text="Move" resourcekey="btnMoveMediaMoveResource1" CssClass="moveAction" />
							<asp:LinkButton ID="btnMoveMediaCancel" runat="server" OnClick="btnMMMoveCancel_Click" Text="Cancel" resourcekey="btnMoveMediaCancelResource1" CssClass="downClose" />
						</div>
					</div>
				</asp:Panel>
			</asp:Panel>
		</div>
	</div>
</div>
<asp:HiddenField ID="hfEditorMediaID" runat="server" />
<asp:HiddenField ID="hfCloseSource" runat="server" />
<asp:HiddenField ID="hfTimeTicks" runat="server" />
<asp:Panel ID="pnlMainInfo" runat="server" Visible="False" />
