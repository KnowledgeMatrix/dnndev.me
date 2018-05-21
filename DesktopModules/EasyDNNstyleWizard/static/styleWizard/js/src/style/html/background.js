propertyTypeSubsesctions['background'] = [
	{
		id: 'color',
		name: 'Color'
	},
	{
		id: 'image',
		name: 'Image'
	},
	{
		id: 'repeat',
		name: 'Repeat'
	},
	{
		id: 'attachment',
		name: 'Attachment'
	},
	{
		id: 'position',
		name: 'Position'
	},
	{
		id: 'animation',
		name: 'Animation'
	}
];

Style.generatePropertyEditorHtml.background = function ($container, forbidden, states, currentState, metaVersion, baseId, universalPropertyId) {
	var values = states[currentState].values,

		verticalPosition,
		verticalPositionInitialized = false,
		horizontalPosition,
		horizontalPositionInitialized = false,

		activeCollectionIndex = rendering.active.collection,
		collection = collections[activeCollectionIndex],
		activeSubject = collection.subjects[rendering.active.subjects[activeCollectionIndex]],
		styleGroup = collection.styleGroups[activeSubject.styleGroup],
		imagesMeta = styleGroup.imagesMeta[universalPropertyId],

		previouslyActiveImage = undefined,

		$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar'),

		$colorPicker,

		$imageContainer,
		$imageContentWrapper,
		$mainImageTrigger,

		$verticalPositionSelectionContainer,
		$verticalPositionCustomValue,
		$verticalPositionCustomUnit,
		$verticalPositionCustomContainer,

		$horizontalPositionSelectionContainer,
		$horizontalPositionCustomValue,
		$horizontalPositionCustomUnit,
		$horizontalPositionCustomContainer,

		$repeatSelectionContainer,

		$attachmentSelectionContainer,

		$uploader,
		$uploadQueue,

		$animationSpeedContainer,

		fillPropertyImageLists = function ($container, type) {
			if (imagesMeta[type] == undefined)
				return;

			fillImageLists(
				$container,
				imagesMeta.baseUrl + type + '/',
				imagesMeta[type],
				type
			);
		},

		fillImageLists = function ($container, folderPath, files, type) {
			$.each(files, function(name, meta) {
				var $li,
					imageSrc = folderPath.replace(/_-StyleAssetsClientRoot-_/g, styleGroup.styleAssetsClientRoot) + name;

				if (name.indexOf('background_pattern_') == 0)
					$li = $('<li><div class="image"><div class="patternWrapper" style="background: url(\'' + imageSrc + '\') repeat;"></div>' + (type == 'uploaded' ? '<div class="alert" /><div class="loading delete" />' : '') + '</div></li>');
				else
					$li = $('<li><div class="image"><img alt="" src="' + imageSrc + '" />' + (type == 'uploaded' ? '<div class="alert" /><div class="loading delete" />' : '') + '</div></li>');

				if (typeof values.image == 'object') {
					if (
						(
							type == 'shared' &&
							values.image.type == type &&
							values.image.completeUrl == folderPath + name
						) ||
						(
							values.image.type == type &&
							values.image.file == name
						)
					)
						$li.addClass('active');
				}

				if (type == 'uploaded')
					$li.append('<div class="delete" title="Delete this image"><span /></div><div class="deleteConfirm" title="Really delete this image"><span /></div>');
				else if (type == 'shared')
					$li.data('directory', folderPath.replace(/_-StyleAssetsClientRoot-_images\//g, ''));

				$container
					.css('display', 'block')
					.append($li.data('file', name));
			});
		};

	if ($.inArray('color', forbidden) === -1) {
		$container.append(
			'<div class="propertySubsection color">Color: ' +
				'<input type="text" class="spectrumPicker" />' +
			'</div>'
		);

		$('> .propertySubsection.color', $container).on('disabling', function () {
			$colorPicker.spectrum('hide');
		});

		$colorPicker = $('> .propertySubsection.color > input.spectrumPicker', $container)
			.spectrum(spectrumSettings(
				values.color,
				function (newColor) {
					states[currentState].values.color = newColor;

					Style.updateActiveSubjectStyle();
				}
			));

		rendering.activeColorPickers.push($colorPicker);
	}

	if ($.inArray('image', forbidden) === -1) {
		$imageContainer = $(
			'<div class="collapsableOptionsContainer propertySubsection image">' +
				'<div class="trigger"><label><input type="checkbox" value="1" />Set image</label></div>' +
				'<div class="contentWrapper"><div class="content">' +
					'<div class="uploadWrapper">' +
						'<div class="uploader"></div>' +
						'<ol></ol>' +
						'<div class="actions">' +
							'<div class="action fileSelection">' +
								'<span>Upload</span>' +
								'<input type="file" value="" multiple="multiple" />' +
							'</div>' +
						'</div>' +
					'</div>' +
					'<ul class="imageList uploaded"></ul>' +
					'<ul class="imageList predefined"></ul>' +
					'<ul class="imageList shared"></ul>' +
				'</div></div>' +
			'</div>'
		).appendTo($container);

		$mainImageTrigger = $('> .trigger input', $imageContainer);
		$imageContentWrapper = $('> .contentWrapper', $imageContainer);

		$mainImageTrigger.on('change', function () {
			if ($mainImageTrigger[0].checked) {
				if (
					previouslyActiveImage != undefined &&
					(
						previouslyActiveImage.type == 'shared' ||
						imagesMeta[previouslyActiveImage.type] &&
						imagesMeta[previouslyActiveImage.type][previouslyActiveImage.file]
					)
				)
					states[currentState].values.image = previouslyActiveImage;
				else
					states[currentState].values.image = undefined;
			} else {
				previouslyActiveImage = states[currentState].values.image;
				states[currentState].values.image = undefined;
			}

			Style.updateActiveSubjectStyle();
		});

		if (typeof values.image == 'object' && typeof values.image.completeUrl == 'string' && values.image.completeUrl != '') {
			$imageContainer.addClass('expanded');
			$imageContentWrapper.css('display', 'block');
			$mainImageTrigger[0].checked = true;
		}

		if (imagesMeta) {
			fillPropertyImageLists($('.imageList.predefined', $imageContentWrapper), 'predefined');
			fillPropertyImageLists($('.imageList.uploaded', $imageContentWrapper), 'uploaded');

			if (imagesMeta['shared'] != undefined) {
				$.each(imagesMeta['shared'], function(folderPath, files) {
					fillImageLists(
						$('.imageList.shared', $imageContentWrapper),
						'_-StyleAssetsClientRoot-_images/' + folderPath,
						files,
						'shared'
					);
				});
			}
		}

		$imageContentWrapper
			.on('click', '.imageList > li > div.image', function () {
				var $li = $(this).parent(),
					$imageList = $li.parent(),
					imageType = $imageList.hasClass('predefined')
						? 'predefined'
						: (
							$imageList.hasClass('uploaded')
								? 'uploaded'
								: 'shared'
						),
					filename = $li.data('file'),
					completeUrl;

				if ($li.hasClass('active') || $li.hasClass('deleting'))
					return;

				if (imageType == 'shared')
					completeUrl = '_-StyleAssetsClientRoot-_images/' + $li.data('directory') + filename;
				else
					completeUrl = imagesMeta.baseUrl + imageType + '/' + filename;

				states[currentState].values.image = {
					"completeUrl": completeUrl,
					"file": filename,
					"type": imageType
				};

				Style.updateActiveSubjectStyle();

				$('.imageList > li', $imageContentWrapper).removeClass('active');
				$li.addClass('active');
			})
			.on('click', '.imageList > li > div.delete', function () {
				var $this = $(this),
					$li = $this.parent();

				if ($li.hasClass('confirmDelete')) {
					$li.removeClass('confirmDelete');
					$this.parents(1).removeClass('transparentItems');
					$this.attr('title', 'Delete this image');
				} else {
					$li.addClass('confirmDelete');
					$this.parents(1).addClass('transparentItems');
					$this.attr('title', 'Don\'t delete the image');
				}
			})
			.on('mouseleave', '.imageList > li', function () {
				var $this = $(this);

				$this.parent().removeClass('transparentItems');

				$this
					.removeClass('confirmDelete')
					.find('> .delete')
						.attr('title', 'Delete this image');
			})
			.on('click', '.imageList > li > div.deleteConfirm', function () {
				var $li = $(this).parent(),
					$imageList = $li.parent(),
					$otherImageLists = $('.imageList.uploaded', $imageList.parents('.propertyStatesWrapper > div').siblings()),
					file = $li.data('file'),
					stylesThatUseImage,
					$modalWrapper = undefined,

					errorHandler = function () {
						$li.removeClass('showLoading deleting');

						$('> .image > .alert', $li)
							.css('display', 'block')
							.attr('title', 'There has been a problem while trying to delete this image. Please try again.');
					},

					removeImageFromStyleProperty = function (style, imageType) {
						var property = Style.getStyleProperty(style.values, universalPropertyId.split('_'));

						$.each(property, function (i, state) {
							var stateImage = state.values.image;

							if (typeof stateImage == 'object' && stateImage.type == imageType && stateImage.file == file) {
								state.values.image = undefined;
							}
						});
					},

					makeDeleteRequest = function () {
						$li.addClass('showLoading deleting');

						$.ajax({
							data: {
								collection: collection.type,
								action: 'deleteBackgroundImage',
								themeName: styleGroup.themeName,
								collectionPortalId: styleGroup.portalId,
								universalPropertyId: universalPropertyId,
								file: file
							},
							dataType: 'json',
							success: function (response) {
								if (response.success == undefined || !response.success) {
									errorHandler();

									return;
								}

								if (stylesThatUseImageList) {
									$.each(stylesThatUseImage.custom, function (i, style) {
										removeImageFromStyleProperty(style, 'uploaded');
									});
									$.each(stylesThatUseImage.predefined, function (i, style) {
										removeImageFromStyleProperty(style, 'predefined');
									});
								}

								delete imagesMeta.uploaded[file];

								if ($.isEmptyObject(imagesMeta.uploaded)) {
									$li.fadeOut(200, function () {
										$li.remove();

										if ($('>', $imageList).length == 0)
											$imageList.css('display', 'none');
									});

									$otherImageLists
										.empty()
										.css('display', 'none');
								} else {
									$('> li', $otherImageLists).each(function (i, el) {
										var $otherLi = $(el);

										if ($otherLi.data('file') == file)
											$otherLi.remove();
									});

									$li.fadeOut(200, function () {
										$li.remove();
									});
								}

								$styleEditorContainer.tinyscrollbar_update('relative');

								Style.updateActiveSubjectStyle();
							},
							error: function () {
								errorHandler();
							},
							timeout: 15000,
							url: config.backend
						});
					},

					stylesThatUseImageList = '',

					collectionIndex = rendering.active.collection,
					subjectIndex = rendering.active.subjects[collectionIndex],

					collection = collections[collectionIndex],
					subject = collection.subjects[subjectIndex];

				stylesThatUseImage = Style.listStylesThatUseBackgroundImage(file, 'uploaded', universalPropertyId);

				if (!$.isEmptyObject(stylesThatUseImage.custom))
					$.each(stylesThatUseImage.custom, function (i, style) {
						var nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup);

						stylesThatUseImageList += '<li>' + nameAndColors.name + '</li>';
					});

				if (!$.isEmptyObject(stylesThatUseImage.predefined))
					$.each(stylesThatUseImage.predefined, function (i, style) {
						var nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup);

						stylesThatUseImageList += '<li>' + nameAndColors.name + '</li>';
					});

				if (stylesThatUseImageList) {
					$('body').append('<div id="EasyDNNstyleWizardModalWrapper" class="imageDeleteConfirmation">' +
							'<div>' +
								'<div class="content">' +
									'<p>The image you are deleting is used in the following styles. Do you want to procede?</p>' +
									'<ul>' + stylesThatUseImageList + '</ul>' +
								'</div>' +
								'<div class="actions"><span class="delete">Delete the image</span><span class="cancel">Cancel deletion</span></div>' +
							'</div>' +
						'</div>');

					$modalWrapper = $('#EasyDNNstyleWizardModalWrapper')
						.on('click', '.actions > span', function () {
							if ($(this).hasClass('delete'))
								makeDeleteRequest();

							$modalWrapper.fadeOut(100, function () {
								$modalWrapper.remove();
							});
						});

					return;
				}

				makeDeleteRequest();
			});

		$uploadQueue = $('.uploadWrapper > ol', $imageContentWrapper);

		$uploader = $('.uploadWrapper > .uploader', $imageContentWrapper)
			.fineUploader({
				uploaderType: 'basic',
				autoUpload: true,
				maxConnections: 1,
				request: {
					endpoint: config.backend,
					inputName: 'file',
					uuidName: 'uuid',
					totalFileSizeName: 'filesize',
					params: {
						collection: collection.type,
						action: 'uploadBackgroundImage',
						themeName: styleGroup.themeName,
						collectionPortalId: styleGroup.portalId,
						universalPropertyId: universalPropertyId
					}
				},
				validation: {
					allowedExtensions: [
						'jpg',
						'jpeg',
						'gif',
						'png',
						'bmp'
					],
					stopOnFirstInvalidFile: false
				}
			})
			.on('submit', function (e, fileId, fileName) {
				var fileInfo = $uploader.fineUploader('getFile', fileId),
					$li = $('<li class="file' + fileId + '">' +
						'<div class="main">' +
							'<p class="file">' + Utils.html.encode(fileInfo.name) + '</p>' +
							'<p class="uploadInfo">Queued (' + Utils.files.readableFileSize(fileInfo.size) + ')</p>' +
							'<div class="progress"><div></div></div>' +
							'<div class="actions"><span class="retry" style="display: none;">Retry</span><span class="cancel">Cancel</span></div>' +
						'</div>' +
						'<div class="thumbnail"></div>' +
					'</li>').appendTo($uploadQueue),
					fileReader = new FileReader(),
					$imageList = $li.parent(),
					$otherImageLists = $('.imageList.uploaded', $imageList.parents('.propertyStatesWrapper > div').siblings());

				fileReader.onload = function (e) {
					$('> .thumbnail', $li).prepend('<img src="' + e.target.result + '" alt="" />');
				};

				$li
					.data('imageReader', fileReader)
					.data('fileId', fileId);
				fileReader.readAsDataURL(fileInfo);

				$styleEditorContainer.tinyscrollbar_update('relative');
			})
			.on('upload', function (e, fileId, fileName) {
				var $li = $('> li.file' + fileId, $uploadQueue),
					$liMain = $('> .main', $li);

				$('> .progress', $liMain).css('display', 'block');
			})
			.on('progress', function (e, fileId, fileName, bytesUploaded, bytesTotal) {
				var $liMain = $('> li.file' + fileId + ' > .main', $uploadQueue),
					uploadedPercent = bytesUploaded / bytesTotal * 100;

				$('> .uploadInfo', $liMain).text(Math.round(uploadedPercent) + '% (' + Utils.files.readableFileSize(bytesUploaded) + ' of ' + Utils.files.readableFileSize(bytesTotal) + ')');
				$('> .progress > div', $liMain).css('width', uploadedPercent + '%');
			})
			.on('complete', function (e, fileId, fileName, response) {
				var $li = $('> li.file' + fileId, $uploadQueue),
					$liMain = $('> .main', $li),
					imageReader = $li.data('imageReader'),

					$imageLists;

				if (response.success == undefined || response.success !== true) {
					$li.addClass('failed');
					$('> .uploadInfo', $liMain).text('Upload failed');
					$('> .progress', $liMain).css('display', 'none');
					$('> .progress > div', $liMain).css('width', '');
					$('> .actions > .retry', $liMain).css('display', '');

					return;
				}

				if (imagesMeta.uploaded == undefined)
					imagesMeta.uploaded = {};

				imagesMeta.uploaded[response.filename] = {
					width: response.width,
					height: response.height
				};

				$imageLists = $('ul.imageList.uploaded', $li.parents('.propertyStatesWrapper').eq(0))
					.css('display', 'block');

				$('<li><div class="image"><img alt="" src="' + imagesMeta.baseUrl.replace(/_-StyleAssetsClientRoot-_/g, styleGroup.styleAssetsClientRoot) + 'uploaded/' + response.filename + '" /><div class="alert" /><div class="loading delete" /></div><div class="delete" title="Delete this image"><span /></div><div class="deleteConfirm" title="Really delete this image"><span /></div></li>')
					.data('file', response.filename)
					.appendTo($imageLists);

				if (imageReader.readyState === FileReader.LOADING)
					imageReader.abort();

				$li.slideUp(200, function () {
					$li.remove();
					$styleEditorContainer.tinyscrollbar_update('relative');
				});
			});

		$('.uploadWrapper .fileSelection > input', $imageContentWrapper).on('change', function () {
			$uploader.fineUploader('addFiles', this.files);
		});

		$uploadQueue
			.on('click', '> li > .main > .actions > .retry', function () {
				var $this = $(this),
					$li = $this.parents().eq(2),
					fileId = $li.data('fileId'),
					fileInfo = $uploader.fineUploader('getFile', fileId);

				if (!$li.is(':last-child'))
					$li = $li.detach().appendTo($uploadQueue);

				$li.removeClass('failed');
				$('> .main > .uploadInfo', $li).text('Queued (' + Utils.files.readableFileSize(fileInfo.size) + ')');
				$this.css('display', 'none');

				$uploader.fineUploader('retry', fileId);
			})
			.on('click', '> li > .main > .actions > .cancel', function () {
				var $li = $(this).parents().eq(2);

				$uploader.fineUploader('cancel', $li.data('fileId'));

				$li.remove();
			});
	}

	if ($.inArray('position', forbidden) === -1) {
		$container.append(
			'<div class="propertySubsection position">' +
				'<div class="positionSelection horizontal">Horizontal position: ' +
					'<label><input type="radio" value="1" class="leftBgPosition" name="' + baseId + '_horizontalImagePositionRadios" />Left</label> ' +
					'<label><input type="radio" value="1" class="center" name="' + baseId + '_horizontalImagePositionRadios" />Center</label> ' +
					'<label><input type="radio" value="1" class="rightBgPosition" name="' + baseId + '_horizontalImagePositionRadios" />Right</label> ' +
					'<label><input type="radio" value="1" class="custom" name="' + baseId + '_horizontalImagePositionRadios" />Custom</label>' +
					'<div>Custom: ' +
						'<input type="text" class="position numeric" value="" /> ' +
						'<select class="positionUnit numericUnit">' +
							'<option value="px">px</option>' +
							'<option value="%">%</option>' +
							'<option value="em">em</option>' +
						'</select> ' +
					'</div>' +
				'</div>' +
				'<div class="positionSelection vertical">Vertical position: ' +
					'<label><input type="radio" value="1" class="top" name="' + baseId + '_verticalImagePositionRadios" />Top</label> ' +
					'<label><input type="radio" value="1" class="center" name="' + baseId + '_verticalImagePositionRadios" />Center</label> ' +
					'<label><input type="radio" value="1" class="bottom" name="' + baseId + '_verticalImagePositionRadios" />Bottom</label> ' +
					'<label><input type="radio" value="1" class="custom" name="' + baseId + '_verticalImagePositionRadios" />Custom</label>' +
					'<div>Custom: ' +
						'<input type="text" class="position numeric" value="" /> ' +
						'<select class="positionUnit numericUnit">' +
							'<option value="px">px</option>' +
							'<option value="%">%</option>' +
							'<option value="em">em</option>' +
						'</select> ' +
					'</div>' +
				'</div>' +
			'</div>'
		);

		$verticalPositionSelectionContainer = $('> .propertySubsection.position > .positionSelection.vertical', $container);
		$verticalPositionCustomValue = $('input.position', $verticalPositionSelectionContainer);
		$verticalPositionCustomUnit = $('select.positionUnit', $verticalPositionSelectionContainer);
		$verticalPositionCustomContainer = $('> div', $verticalPositionSelectionContainer);

		$horizontalPositionSelectionContainer = $('> .propertySubsection.position > .positionSelection.horizontal', $container);
		$horizontalPositionCustomValue = $('input.position', $horizontalPositionSelectionContainer);
		$horizontalPositionCustomUnit = $('select.positionUnit', $horizontalPositionSelectionContainer);
		$horizontalPositionCustomContainer = $('> div', $horizontalPositionSelectionContainer);

		verticalPosition = values.position.vertical;
		$verticalPositionCustomValue.val(verticalPosition.value);
		$verticalPositionCustomUnit.val(verticalPosition.unit);

		if (verticalPosition.value == 0) {
			verticalPositionInitialized = true;
			$('input.top', $verticalPositionSelectionContainer)[0].checked = true;
		}

		if (!verticalPositionInitialized && verticalPosition.unit == '%') {
			if (verticalPosition.value == 50) {
				verticalPositionInitialized = true;
				$('input.center', $verticalPositionSelectionContainer)[0].checked = true;
			} else if (verticalPosition.value == 100) {
				verticalPositionInitialized = true;
				$('input.bottom', $verticalPositionSelectionContainer)[0].checked = true;
			}
		}

		if (!verticalPositionInitialized) {
			$verticalPositionCustomContainer.css('display', 'block');
			$('input.custom', $verticalPositionSelectionContainer)[0].checked = true;
		}

		horizontalPosition = values.position.horizontal;
		$horizontalPositionCustomValue.val(horizontalPosition.value);
		$horizontalPositionCustomUnit.val(horizontalPosition.unit);

		if (horizontalPosition.value == 0) {
			horizontalPositionInitialized = true;
			$('input.leftBgPosition', $horizontalPositionSelectionContainer)[0].checked = true;
		}

		if (!horizontalPositionInitialized && horizontalPosition.unit == '%') {
			if (horizontalPosition.value == 50) {
				horizontalPositionInitialized = true;
				$('input.center', $horizontalPositionSelectionContainer)[0].checked = true;
			} else if (horizontalPosition.value == 100) {
				horizontalPositionInitialized = true;
				$('input.rightBgPosition', $horizontalPositionSelectionContainer)[0].checked = true;
			}
		}

		if (!horizontalPositionInitialized) {
			$horizontalPositionCustomContainer.css('display', 'block');
			$('input.custom', $horizontalPositionSelectionContainer)[0].checked = true;
		}

		$('> .propertySubsection.position > .positionSelection > label > input[type="radio"]', $container).on('change', function () {
			var $this = $(this),
				$selectionContainer = $this.parents().eq(1),
				$customSelectionContainer = $('> div', $selectionContainer),
				axis = $selectionContainer.hasClass('horizontal') ? 'horizontal' : 'vertical',

				newValue,
				newUnit;

			if ($this.hasClass('custom')) {
				$customSelectionContainer.css('display', 'block');
			} else {
				$customSelectionContainer.css('display', 'none');
				newUnit = '%';

				if ($this.hasClass('center')) {
					newValue = 50;
				} else {
					if ($this.hasClass('leftBgPosition') || $this.hasClass('top')) {
						newValue = 0;
					} else {
						newValue = 100;
					}
				}

				states[currentState].values.position[axis].value = newValue;
				states[currentState].values.position[axis].unit = newUnit;

				$('input.position', $customSelectionContainer).val(newValue);
				$('select.positionUnit', $customSelectionContainer).val(newUnit);

				Style.updateActiveSubjectStyle();
			}

			$styleEditorContainer.tinyscrollbar_update('relative');
		});

		$('> .propertySubsection.position > .positionSelection', $container)
			.on('keydown', 'input.numeric', function (e) {
				var $this = $(this),
					oldValue = $this.val(),
					offset,
					axis = $this.parents().eq(1).hasClass('horizontal') ? 'horizontal' : 'vertical',
					axisValues = states[currentState].values.position[axis];

				if (e.which != 38 && e.which != 40)
					return;

				if (oldValue == '')
					offset = 0
				else {
					if (axisValues.unit == 'px')
						offset = parseInt(oldValue, 10);
					else
						offset = parseFloat(oldValue, 10);
				}

				switch (e.which) {
				case 38:
					offset += 1;
					break;

				case 40:
					offset -= 1;
					break;
				}

				$this
					.val(offset)
					.data('stepChange', true);

				axisValues.value = offset;

				Style.updateActiveSubjectStyle();
			})
			.on('keyup change', 'input.numeric', function (e) {
				var $this = $(this),
					oldValue = $this.val(),
					endingWithDot = false,
					inputValue = '',
					offset,
					axis = $this.parents().eq(1).hasClass('horizontal') ? 'horizontal' : 'vertical',
					axisValues = states[currentState].values.position[axis];

				if (axisValues.unit == 'px')
					offset = parseInt(oldValue, 10);
				else {
					endingWithDot = oldValue[oldValue.length - 1] == '.';
					offset = parseFloat(oldValue, 10);
				}

				if (isNaN(offset) || typeof offset != 'number')
					offset = 0;

				if ($this.data('stepChange') == true || oldValue == '0' || (e.type != 'keyup' || offset != 0)) {
					$this.data('stepChange', false);
					inputValue = offset + (endingWithDot ? '.' : '');
				}

				$this.val(inputValue);

				axisValues.value = offset;

				Style.updateActiveSubjectStyle();
			})
			.on('keydown keyup change', 'select.numericUnit', function () {
				var $this = $(this),
					axis = $this.parents().eq(1).hasClass('horizontal') ? 'horizontal' : 'vertical';

				states[currentState].values.position[axis].unit = $this.val();

				Style.updateActiveSubjectStyle();
			});
	}

	if ($.inArray('repeat', forbidden) === -1) {
		$repeatSelectionContainer = $(
			'<div class="propertySubsection repeat">Repeat: ' +
				'<label><input type="radio" value="repeat" class="repeat" name="' + baseId + '_imageRepeat" />Both</label> ' +
				'<label><input type="radio" value="repeat-x" class="repeat-x" name="' + baseId + '_imageRepeat" />Horizontal</label> ' +
				'<label><input type="radio" value="repeat-y" class="repeat-y" name="' + baseId + '_imageRepeat" />Vertical</label> ' +
				'<label><input type="radio" value="no-repeat" class="no-repeat" name="' + baseId + '_imageRepeat" />No</label>' +
			'</div>'
		).appendTo($container);

		$('input', $repeatSelectionContainer)
			.on('change', function () {
				states[currentState].values.repeat = $(this).val();

				Style.updateActiveSubjectStyle();
			})
			.filter('.' + (values.repeat ? values.repeat : 'repeat'))[0].checked = true;
	}

	if ($.inArray('attachment', forbidden) === -1) {
		$attachmentSelectionContainer = $(
			'<div class="propertySubsection attachment">Attachment: ' +
				'<label><input type="radio" value="scroll" class="scroll" name="' + baseId + '_imageAttachment" />Scroll</label> ' +
				'<label><input type="radio" value="fixed" class="fixed" name="' + baseId + '_imageAttachment" />Fixed</label>' +
			'</div>'
		).appendTo($container);

		$('input', $attachmentSelectionContainer)
			.on('change', function () {
				states[currentState].values.attachment = $(this).val();

				Style.updateActiveSubjectStyle();
			})
			.filter('.' + (values.attachment ? values.attachment : 'scroll'))[0].checked = true;
	}

	if ($.inArray('animation', forbidden) === -1 && metaVersion > 1) {
		$animationSpeedContainer = $(
			'<div class="propertySubsection animation">Animation speed: ' +
				'<input type="text" class="numeric" value="" /> second(s)' +
			'</div>'
		).appendTo($container);

		$('input', $animationSpeedContainer)
			.val(values.animation.duration)
			.on('keydown', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					value;

				if (e.which != 38 && e.which != 40)
					return;

				if (oldWidth == '')
					value = 0
				else
					value = parseInt(oldWidth, 10);

				switch (e.which) {
				case 38:
					value += 1;
					break;

				case 40:
					value -= 1;
					break;
				}

				if (value < 0)
					value = 0;

				$this
					.val(value)
					.data('stepChange', true);

				states[currentState].values.animation.duration = value;

				Style.updateActiveSubjectStyle();
			})
			.on('keyup change', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					value,
					newValue = '';

				value = parseInt(oldWidth, 10);

				if (isNaN(value) || typeof value != 'number' || value < 0)
					value = 0;

				if ($this.data('stepChange') == true || oldWidth == '0' || e.type != 'keyup' || value != 0) {
					$this.data('stepChange', false);
					newValue = value;
				}

				$this.val(newValue);

				states[currentState].values.animation.duration = value;

				Style.updateActiveSubjectStyle();
			});
	}
};
