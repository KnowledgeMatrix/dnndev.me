propertyTypeSubsesctions['text'] = [
	{
		id: 'fontFamily',
		name: 'Font family'
	},
	{
		id: 'color',
		name: 'Color'
	},
	{
		id: 'size',
		name: 'Size'
	},
	{
		id: 'weight',
		name: 'Weight'
	},
	{
		id: 'style',
		name: 'Style'
	},
	{
		id: 'lineHeight',
		name: 'Line height'
	},
	{
		id: 'transform',
		name: 'Transform'
	},
	{
		id: 'decorations',
		name: 'Decorations'
	},
	{
		id: 'shadows',
		name: 'Shadows'
	}
];

Style.generatePropertyEditorHtml.text = function ($container, forbidden, states, currentState, metaVersion, baseId, universalPropertyId, customOptions) {
	var values = states[currentState].values,

		fontFamilies = [],

		spectrumShadowCallback = function ($shadowContainer) {
			return function (color) {
				if (!$.contains(document.documentElement, $shadowContainer[0]))
					return;

				states[currentState].values.shadows.list[$shadowContainer.index()].color = color;

				Style.updateActiveSubjectStyle();
			};
		},

		generateShadowEditor = function (shadow) {
			return '<div>' +
					'<div><span class="remove">Remove</span></div>' +
					'<div>Horizontal: ' +
						'<input type="text" class="x numeric" value="' + shadow.x.value + '" /> ' +
						'<select class="xUnit numericUnit">' +
							'<option value="px"' + (shadow.x.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
							'<option value="em"' + (shadow.x.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'</select> Vertical: ' +
						'<input type="text" class="y numeric" value="' + shadow.y.value + '" /> ' +
						'<select class="yUnit numericUnit">' +
							'<option value="px"' + (shadow.y.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
							'<option value="em"' + (shadow.y.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'</select> ' +
					'</div>' +
					'<div>Radius: ' +
						'<input type="text" class="radius numeric" value="' + shadow.radius.value + '" /> ' +
						'<select class="radiusUnit numericUnit">' +
							'<option value="px"' + (shadow.radius.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
							'<option value="em"' + (shadow.radius.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'</select> ' +
						'<input type="text" class="spectrumPicker" />' +
					'</div>' +
				'</div>';
		},

		initShadowEditor = function (shadow) {
			var $shadowEditor = $(generateShadowEditor(shadow)).appendTo($shadowsList),
				$shadowColorPicker;

			$shadowColorPicker = $('> div > input.spectrumPicker', $shadowEditor).spectrum(
				spectrumSettings(
					shadow.color,
					spectrumShadowCallback($shadowEditor)
				)
			);

			rendering.activeColorPickers.push($shadowColorPicker);
		},

		$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar'),

		$fontFamilySelector,

		$shadowsContainer,
		$shadowsContentWrapper,
		$shadowsContent,
		$noShadowsMessage,
		$addShadow,
		$shadowsList,
		$shadowsTrigger,

		$decorationsContainer,
		$decorationsTrigger,
		$underlineCheckbox,
		$overlineCheckbox,
		$lineThroughCheckbox,

		$transformContainer,
		$transformTrigger,
		$transformContentWrapper,
		$noTransformRadio,
		$uppercaseTransformRadio,
		$lowercaseTransformRadio,
		$capitalizeTransformRadio,

		$colorInput,

		$fontStyleCheckbox,
		$fontWeightSelect,

		setFamily = $.inArray('fontFamily', forbidden) == -1,
		setColor = $.inArray('color', forbidden) == -1,
		setSize = $.inArray('size', forbidden) == -1,
		setLineHeight = $.inArray('lineHeight', forbidden) == -1,
		setStyle = $.inArray('style', forbidden) == -1,
		setWeight = $.inArray('weight', forbidden) == -1,
		setShadows = $.inArray('shadows', forbidden) == -1,
		setDecorations = $.inArray('decorations', forbidden) == -1,
		setTransform = $.inArray('transform', forbidden) == -1,
		
		updateFontFamiliesCollection = function () {
			fontFamilies = [];

			if ($.isArray(values.customFontFamilies))
				fontFamilies = values.customFontFamilies;

			if ($.isArray(customOptions.customFonts))
				fontFamilies = fontFamilies.concat(customOptions.customFonts);

			if ($.isArray(config.defaultFonts))
				fontFamilies = fontFamilies.concat(config.defaultFonts);

			$fontFamilySelector.html('');

			$.each(fontFamilies, function (i, font) {
				$fontFamilySelector.append(
					'<option value="' + font.name + '"' +
					(values.fontFamily == font.name ? ' selected="selected"' : '') +
					'>' + font.name + '</option>'
				);
			});
		},

		triggerUpdateFont = function () {
			$('> div[class*=" subject_' + rendering.active.collection + '_"], > div[class^="subject_' + rendering.active.collection + '_"]', $styleSubjectsWrapper)
				.each(function () {
					$('.styleEditor > .editor .styleEditorSpacer ul.properties > li.text .propertyStatesWrapper .propertySubsection.fontFamily > select', this).trigger('updateFonts');
				});
		};

	if (setFamily || setColor) {
		$container.append(
			'<div>' +
				(setFamily ? '<div class="propertySubsection fontFamily"><select></select><span>Add/remove fonts</span></div>' : '') +
				(setColor ? '<span class="propertySubsection color"><input type="text" class="spectrumPicker" /></span>' : '') +
			'</div>'
		);

		if (setFamily) {
			$fontFamilySelector = $('> div > div.fontFamily > select', $container)
				.on('keydown keyup change', function () {
					states[currentState].values.fontFamily = $(this).val();

					Style.updateActiveSubjectStyle();
				})
				.on('updateFonts', function () {
					updateFontFamiliesCollection();
				});

			updateFontFamiliesCollection();

			$('> div > div.fontFamily > span', $container)
				.on('click', function () {
					var $fontManagerWrapper = $(
							'<div id="EasyDNNstyleWizardModalWrapper" class="fontManager">' +
								'<div>' +
									'<p class="modalTitle">Font manager</p>' +
									'<div class="wrapper">' +
										'<div>' +
											'<div class="fontList">' +
												'<p class="userMsg">Here are all the non-standard fonts that are currently available for this theme. ' +
												'Non-standard fonts are fonts that need to be loaded from a separate source because they don\'t usually come preinstalled on your operating system. ' +
												'The list will contain all the fonts that the designers recommend for use with the current theme. ' +
												'These fonts can\'t be removed, but you can add new fonts and use them in your styles. ' +
												'You can add any font that can be loaded with the CSS @import rule (like <a href="http://www.google.com/fonts" title="Google Fonts">Google Fonts</a>).</p>' +
												'<div class="standardScrollbar">' +
													'<div class="viewport"><div class="overview">' +
														'<ol class="fonts">' +
														'</ol>' +
														'<p class="noFonts">There are currently no custom fonts specified</p>' +
													'</div></div>' +
													'<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>' +
												'</div>' +
												'<div class="actionsBar"><span class="addForm">Add font</span><span class="close red">Close</span></div>' +
												'<div class="overlay fontSwap">' +
													'<p>Are you sure you want to delete this font?</p>' +
													'<div class="actions"><span>Yes, delete the font</span><span>Nope</span></div>' +
												'</div>' +
											'</div>' +
											'<div class="addFont">' +
												'<p class="sectionTitle">Add font</p>' +
												'<p class="userMsg">Please specify the name and URL for the font you want to add. You can add fonts from any online service that hosts fonts, like <a href="http://www.google.com/fonts" title="Google Fonts">Google Fonts</a>.</p>' +
												'<div class="field name">' +
													'<span class="label"><label for="styleWizard_fontManager_addFont_name">Name:</label></span>' +
													'<input class="textInput" id="styleWizard_fontManager_addFont_name" type="text" value="" />' +
												'</div>' +
												'<div class="field url">' +
													'<span class="label"><label for="styleWizard_fontManager_addFont_url">Url:</label></span>' +
													'<label for="styleWizard_fontManager_addFont_url" class="textInput"><span class="urlStart">http://</span><input id="styleWizard_fontManager_addFont_url" type="text" value="" /></label>' +
												'</div>' +
												'<div class="actionsBar"><span class="confirm">Add font</span><span class="cancel red">Cancel</span></div>' +
											'</div>' +
										'</div>' +
									'</div>' +
								'</div>' +
							'</div>'
						),

						$fontListContainer = $('> div > .wrapper > div > .fontList', $fontManagerWrapper),
						$addFontContainer = $('> div > .wrapper > div > .addFont', $fontManagerWrapper),
						$fontListScrollbar = $('> div.standardScrollbar', $fontListContainer),
						$fontList = $('ol.fonts', $fontListScrollbar),
						$noFontsMsg = $('p.noFonts', $fontListScrollbar),

						$nameInput = $('> .field.name > input.textInput', $addFontContainer),
						$urlInput = $('> .field.url > .textInput > input', $addFontContainer),

						$fontSwapOverlay = $('> .overlay.fontSwap', $fontListContainer),

						addFontToList = function (font) {
							var $li = $(
								'<li' + (font.userDefined ? ' class="userDefined"' : '') + '>' +
									(font.userDefined
										? '<span class="remove" title="Remove this font">Remove</span>'
										: ''
									) +
									'<div class="info">' +
										'<p class="title"></p>' +
										'<p class="url"></p>' +
									'</div>' +
								'</li>'
							)
								.data('fontName', font.name);

							$('> .info > .title', $li).text(font.name)
							$('> .info > .url', $li).text(font.importUrl.substring(font.importUrl.indexOf('//') + 2));

							$fontList.append($li);
						};

					if (customOptions.customFonts.length == 0) {
						$noFontsMsg.css('display', 'block');
						$fontList.css('display', 'none');
					} else {
						var i = 0;
						var l = customOptions.customFonts.length;

						for (; i < l; i++) {
							addFontToList(customOptions.customFonts[i]);
						}
					}

					$fontManagerWrapper
						.on('focus', 'label.textInput input', function () {
							$(this).parent().addClass('focus');
						})
						.on('blur', 'label.textInput input', function () {
							$(this).parent().removeClass('focus');
						})
						.appendTo('body')
						.fadeTo(200, 1);

					$fontListScrollbar.tinyscrollbar();

					$fontListContainer
						.on('click', '> .actionsBar > .addForm', function () {
							$nameInput.val('');
							$urlInput.val('');
							$(this).parents().eq(2).addClass('addForm');
						})
						.on('click', '> .actionsBar > .close', function () {
							$fontManagerWrapper.fadeTo(200, 0, function () {
								$fontManagerWrapper.remove();
							});
						})
						.on('click', '> .standardScrollbar ol.fonts > li.userDefined > .remove', function () {
							var $li = $(this).parent(),
								fontName = $li.data('fontName'),
								encodedFontName = Utils.html.encode(fontName),

								collectionIndex = rendering.active.collection,
								subjectIndex = rendering.active.subjects[collectionIndex],

								collection = collections[collectionIndex],
								subject = collection.subjects[subjectIndex],

								fontInProperties = function (styleDefinitions, styleValues) {
									var containsFont = false;

									if (styleDefinitions.properties && styleValues.properties)
										$.each(styleDefinitions.properties, function (propertyId, propertyDefinition) {
											var styleProperty = styleValues.properties[propertyId];

											if (
												propertyDefinition.type == 'text' &&
												styleProperty &&
												propertyDefinition.states
											) {
												$.each(propertyDefinition.states, function (i, state) {
													if (
														styleProperty[state.id] &&
														styleProperty[state.id].values &&
														styleProperty[state.id].values.fontFamily == fontName
													) {
														containsFont = true;
														return false;
													}
												});
											}

											if (containsFont)
												return false;
										});

									if (!containsFont && styleDefinitions.sections && styleValues.sections)
										$.each(styleDefinitions.sections, function (sectionId, sectionDefinition) {
											if (styleValues.sections[sectionId])
												containsFont = fontInProperties(sectionDefinition, styleValues.sections[sectionId]);

											if (containsFont)
												return false;
										});

									return containsFont;
								},

								fontInStyles = function (definition, styles) {
									var containsFont = false;

									$.each(styles, function (id, style) {
										containsFont = fontInProperties(definition, style.values);

										if (containsFont)
											return false;
									});

									return containsFont;
								},

								swapFontsInSections = function (newFont, sectionDefinitions, styleSection) {
									if (sectionDefinitions.properties && styleSection.properties)
										$.each(sectionDefinitions.properties, function (propertyId, propertyDefinition) {
											var styleProperty = styleSection.properties[propertyId];

											if (
												propertyDefinition.type == 'text' &&
												styleProperty &&
												propertyDefinition.states
											)
												$.each(propertyDefinition.states, function (i, state) {
													if (
														styleProperty[state.id] &&
														styleProperty[state.id].values &&
														styleProperty[state.id].values.fontFamily == fontName
													)
														styleProperty[state.id].values.fontFamily = newFont;
												});
										});

									if (sectionDefinitions.sections && styleSection.sections)
										$.each(sectionDefinitions.sections, function (sectionId, childSectionDefinition) {
											if (styleSection.sections[sectionId])
												swapFontsInSections(newFont, childSectionDefinition, styleSection.sections[sectionId]);
										});
								},

								stylesContainFont = false,

								$fontSelect,

								customStyles = collection.styleGroups[subject.styleGroup].styles.custom,

								styleDefinitions = collection.styleGroups[subject.styleGroup].styleDefinitions;

							if (customStyles)
								stylesContainFont = fontInStyles(
									styleDefinitions,
									customStyles
								);

							if (stylesContainFont) {
								$fontSwapOverlay.html(
									'<p>The font &quot;' + encodedFontName + '&quot; is in use. ' +
									'You need to select a replacement font before it can be removed.</p>'+
									'<p><label for="styleWizard_fontManager_replacementFontSelect">Please select a replacement font:</label><select id="styleWizard_fontManager_replacementFontSelect"></select></p>' +
									'<div class="actionsBar"><span class="confirm red">Replace and remove ' + encodedFontName +
									'</span><span class="cancel">Cancel</span></div>'
								);

								$fontSelect = $('> p > select', $fontSwapOverlay);

								$.each(fontFamilies, function (i, font) {
									if (font.name == fontName)
										return;

									$fontSelect.append(
										$('<option />')
											.attr('value', font.name)
											.text(font.name)
									);
								});
							} else {
								$fontSwapOverlay.html(
									'<p>Are you sure you want to remove the font &quot;' + encodedFontName + '&quot;?</p>' +
									'<div class="actionsBar"><span class="confirm red">Yes, remove the font</span><span class="cancel">No</span></div>'
								);
							}

							$fontSwapOverlay.addClass('show');

							$('> .actionsBar > .confirm', $fontSwapOverlay).click(function () {
								var newFont;

								if (stylesContainFont) {
									$.each(customStyles, function (id, style) {
										swapFontsInSections($fontSelect.val(), styleDefinitions, style.values);
									});
								}

								$.each(customOptions.customFonts, function (i, font) {
									if (font.name != fontName)
										return;

									customOptions.customFonts.splice(i, 1);
									$li.slideUp(200, function () {
										$li.remove();

										$fontListScrollbar.tinyscrollbar_update('relative');
									});

									return false;
								});

								$fontSwapOverlay.removeClass('show');
								triggerUpdateFont();
							});

							$('> .actionsBar > .cancel', $fontSwapOverlay).click(function () {
								$fontSwapOverlay.removeClass('show');
							});
						});

					$addFontContainer
						.on('click', '> .actionsBar > .confirm', function () {
							var font = {
								name: $nameInput.val().replace('"').replace('\''),
								importUrl: '//' + $urlInput.val().replace('"').replace('\''),
								userDefined: true
							};

							customOptions.customFonts.push(font);

							$noFontsMsg.css('display', '');
							$fontList.css('display', '');

							addFontToList(font);

							$fontListScrollbar.tinyscrollbar_update('bottom');
							$(this).parents().eq(2).removeClass('addForm');
							triggerUpdateFont();
						})
						.on('click', '> .actionsBar > .cancel', function () {
							$(this).parents().eq(2).removeClass('addForm');
						});
				});
		}

		if (setColor) {
			$colorInput = $('> div > .propertySubsection.color > .spectrumPicker', $container).spectrum(
				spectrumSettings(
					values.color,
					function (color) {
						states[currentState].values.color = color;

						Style.updateActiveSubjectStyle();
					}
				)
			);

			rendering.activeColorPickers.push($colorInput);

			$('> div > .propertySubsection.color', $container).on('disabling', function () {
				$colorInput.spectrum('hide');
			});
		}
	}

	if (setSize || setLineHeight) {
		if (setSize)
			$container.append(
				'<div class="propertySubsection size">Size: ' +
					'<input type="text" class="size numeric" value="' + values.size.value + '" /> ' +
					'<select class="sizeUnit numericUnit">' +
						'<option value="px"' + (values.size.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
						'<option value="em"' + (values.size.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'<option value="%"' + (values.size.unit == '%' ? ' selected="selected"' : '') + '>%</option>' +
					'</select> ' +
				'</div>'
			);

		if (setLineHeight)
			$container.append(
				'<div class="propertySubsection lineHeight">Line height: ' +
					'<input type="text" class="lineHeight numeric" value="' + values.lineHeight.value + '" /> ' +
					'<select class="lineHeightUnit numericUnit">' +
						'<option value=""' + (values.lineHeight.unit == '' ? ' selected="selected"' : '') + '><em>font size ratio</em></option>' +
						'<option value="px"' + (values.lineHeight.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
						'<option value="em"' + (values.lineHeight.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'<option value="%"' + (values.lineHeight.unit == '%' ? ' selected="selected"' : '') + '>%</option>' +
					'</select> ' +
				'</div>'
			);

		$('> div > input.size, > div > input.lineHeight', $container)
			.on('keydown', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					size,
					unit,
					field = $this.hasClass('size') ? 'size' : 'lineHeight';

				if (e.which != 38 && e.which != 40)
					return;

				unit = states[currentState].values[field].unit;

				if (oldWidth == '')
					size = 0
				else {
					if (unit == 'px')
						size = parseInt(oldWidth, 10);
					else
						size = parseFloat(oldWidth, 10);
				}

				switch (e.which) {
				case 38:
					size += 1;
					break;

				case 40:
					size -= 1;

					if (size < 0)
						size = 0;
					break;
				}

				$this
					.val(size)
					.data('stepChange', true);

				states[currentState].values[field].value = size;

				Style.updateActiveSubjectStyle();
			})
			.on('keyup change', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					endingWithDot = false,
					size,
					inputWidth = '',
					unit,
					field = $this.hasClass('size') ? 'size' : 'lineHeight';

				unit = states[currentState].values[field].unit;

				if (unit == 'px')
					size = parseInt(oldWidth, 10);
				else {
					endingWithDot = oldWidth[oldWidth.length - 1] == '.';
					size = parseFloat(oldWidth, 10);
				}

				if (isNaN(size) || typeof size != 'number' || size < 0)
					size = 0;

				if ($this.data('stepChange') == true || oldWidth == '0' || (e.type != 'keyup' || size != 0)) {
					$this.data('stepChange', false);
					inputWidth = size + (endingWithDot ? '.' : '');
				}

				$this.val(inputWidth);

				states[currentState].values[field].value = size;

				Style.updateActiveSubjectStyle();
			});

		$('> div > select.sizeUnit, > div > select.lineHeightUnit', $container).on('keydown keyup change', function () {
			var $this = $(this),
				field = $this.hasClass('sizeUnit') ? 'size' : 'lineHeight';

			states[currentState].values[field].unit = $this.val();

			Style.updateActiveSubjectStyle();
		});
	}

	if (setStyle || setWeight) {
		$container.append(
			'<div>' +
				(setWeight
					? '<label class="propertySubsection weight">Weight: <select>' +
							'<option value="normal">Normal</option>' +
							'<option value="bold">Bold</option>' +
							'<option value="100">100</option>' +
							'<option value="200">200</option>' +
							'<option value="300">300</option>' +
							'<option value="400">400</option>' +
							'<option value="500">500</option>' +
							'<option value="600">600</option>' +
							'<option value="700">700</option>' +
							'<option value="800">800</option>' +
							'<option value="900">900</option>' +
						'</select></label>'
					: ''
				) +
				(setStyle ? '<label class="propertySubsection style"><input type="checkbox" class="style" value="1" />Italic</label>' : '') +
			'</div>'
		);

		$fontStyleCheckbox = $('> div input.style', $container);
		$fontWeightSelect = $('> div > .propertySubsection.weight > select', $container);

		if (setStyle)
			$fontStyleCheckbox
				.prop('checked', values.style == 'italic')
				.on('change', function () {
					var val = 'normal';

					if (this.checked)
						val = 'italic';

					states[currentState].values['style'] = val;

					Style.updateActiveSubjectStyle();
				});

		if (setWeight)
			$fontWeightSelect
				.val(values.weight)
				.on('change', function () {
					states[currentState].values['weight'] = $fontWeightSelect.val();

					Style.updateActiveSubjectStyle();
				});
	}

	if (setShadows) {
		$container.append(
			'<div class="collapsableOptionsContainer propertySubsection shadows">' +
				'<div class="trigger"><label><input type="checkbox" value="1" />Shadows</label></div>' +
				'<div class="contentWrapper"><div class="content">' +
					'<span>Add shadow</span>' +
					'<p>No shadows set</p>' +
					'<div class="shadowsList"></div>' +
				'</div></div>' +
			'</div>'
		);

		$shadowsContainer = $('> .collapsableOptionsContainer.shadows', $container);
		$shadowsTrigger = $('> .trigger input', $shadowsContainer);
		$shadowsContentWrapper = $('> .contentWrapper', $shadowsContainer);
		$shadowsContent = $('> .content', $shadowsContentWrapper);
		$addShadow = $('> span', $shadowsContent);
		$noShadowsMessage = $('> p', $shadowsContent);
		$shadowsList = $('> .shadowsList', $shadowsContent);

		$shadowsTrigger.on('change', function () {
			states[currentState].values.shadows.show = this.checked;

			Style.updateActiveSubjectStyle();
		});

		if (typeof values.shadows == 'object' && values.shadows.show && values.shadows.list.length > 0) {
			$shadowsContainer.addClass('expanded');
			$shadowsTrigger[0].checked = true;
			$shadowsContentWrapper.css('display', 'block');
			$noShadowsMessage.css('display', 'none');

			$.each(values.shadows.list, function (i, shadow) { initShadowEditor(shadow); });
		} else {
			$noShadowsMessage.css('display', 'block');
			$shadowsList.css('display', 'none');
			$shadowsTrigger[0].checked = false;
		}

		$shadowsList
			.on('click', '> div > div > span.remove', function () {
				var $shadowEditorContainer = $(this).parents().eq(1);

				$('> div > input.spectrumPicker', $shadowEditorContainer).spectrum('destroy');
				states[currentState].values.shadows.list.splice($shadowEditorContainer.index(), 1);
				$shadowEditorContainer.remove();

				if (states[currentState].values.shadows.list.length == 0) {
					$noShadowsMessage.css('display', 'block');
					$shadowsList.css('display', 'none');
				}

				Style.updateActiveSubjectStyle();

				$styleEditorContainer.tinyscrollbar_update('relative');
			})
			.on('keydown', 'input.numeric', function (e) {
				var $this = $(this),
					oldValue = $this.val(),
					offset,
					option = $this.hasClass('radius') ? 'radius' : ($this.hasClass('x') ? 'x' : 'y'),
					optionValues = states[currentState].values.shadows.list[$this.parents().eq(1).index()][option];

				if (e.which != 38 && e.which != 40)
					return;

				if (oldValue == '')
					offset = 0
				else {
					if (optionValues.unit == 'px')
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

					if (option == 'radius' && offset < 0)
						offset = 0;
					break;
				}

				$this
					.val(offset)
					.data('stepChange', true);

				optionValues.value = offset;

				Style.updateActiveSubjectStyle();
			})
			.on('keyup change', 'input.numeric', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					endingWithDot = false,
					inputWidth = '',
					offset,
					option = $this.hasClass('radius') ? 'radius' : ($this.hasClass('x') ? 'x' : 'y'),
					optionValues = states[currentState].values.shadows.list[$this.parents().eq(1).index()][option];

				if (optionValues.unit == 'px')
					offset = parseInt(oldWidth, 10);
				else {
					endingWithDot = oldWidth[oldWidth.length - 1] == '.';
					offset = parseFloat(oldWidth, 10);
				}

				if (isNaN(offset) || typeof offset != 'number' || (option == 'radius' && offset < 0))
					offset = 0;

				if ($this.data('stepChange') == true || oldWidth == '0' || (e.type != 'keyup' || offset != 0)) {
					$this.data('stepChange', false);
					inputWidth = offset + (endingWithDot ? '.' : '');
				}

				$this.val(inputWidth);

				optionValues.value = offset;

				Style.updateActiveSubjectStyle();
			})
			.on('keydown keyup change', 'select.numericUnit', function () {
				var $this = $(this),
					option = $this.hasClass('radiusUnit') ? 'radius' : ($this.hasClass('xUnit') ? 'x' : 'y');

				states[currentState].values.shadows.list[$this.parents().eq(1).index()][option].unit = $this.val();

				Style.updateActiveSubjectStyle();
			});

		$addShadow
			.on('click', function () {
				var shadow = {
					x: {
						value: 1,
						unit: 'px'
					},
					y: {
						value: 1,
						unit: 'px'
					},
					radius: {
						value: 2,
						unit: 'px'
					},
					color: '#000000'
				};

				if (states[currentState].values.shadows.list.length == 0) {
					$noShadowsMessage.css('display', 'none');
					$shadowsList.css('display', 'block');
				}

				states[currentState].values.shadows.list.push(shadow);

				initShadowEditor(shadow);

				Style.updateActiveSubjectStyle();

				$styleEditorContainer.tinyscrollbar_update('relative');
			});

		$('> .propertySubsection.shadows', $container).on('disabling', function () {
			$('input.spectrumPicker', $shadowsList).spectrum('hide');
		});
	}

	if (setDecorations) {
		$container.append(
			'<div class="collapsableOptionsContainer propertySubsection decorations">' +
				'<div class="trigger"><label><input type="checkbox" value="1" />Decoration</label></div>' +
				'<div class="contentWrapper"><div class="content">' +
					'<label><input type="checkbox" value="1" class="underline" />Underline</label> ' +
					'<label><input type="checkbox" value="1" class="overline" />Overline</label> ' +
					'<label><input type="checkbox" value="1" class="lineThrough" />Line through</label> ' +
				'</div></div>' +
			'</div>'
		);

		$decorationsContainer = $('> .collapsableOptionsContainer.decorations', $container);
		$decorationsTrigger = $('> .trigger input', $decorationsContainer);
		$underlineCheckbox = $('input.underline', $decorationsContainer);
		$overlineCheckbox = $('input.overline', $decorationsContainer);
		$lineThroughCheckbox = $('input.lineThrough', $decorationsContainer);

		$underlineCheckbox
			.on('change', function () {
				states[currentState].values.decorations.underline = this.checked;

				Style.updateActiveSubjectStyle();
			})[0].checked = values.decorations.underline === true;

		$overlineCheckbox
			.on('change', function () {
				states[currentState].values.decorations.overline = this.checked;

				Style.updateActiveSubjectStyle();
			})[0].checked = values.decorations.overline === true;

		$lineThroughCheckbox
			.on('change', function () {
				states[currentState].values.decorations.lineThrough = this.checked;

				Style.updateActiveSubjectStyle();
			})[0].checked = values.decorations.lineThrough === true;

		if (values.decorations.underline === true || values.decorations.overline === true || values.decorations.lineThrough === true) {
			$decorationsTrigger[0].checked = true;
			$decorationsContainer.addClass('expanded');
			$('> .contentWrapper', $decorationsContainer).css('display', 'block');
		}

		$decorationsTrigger.on('change', function () {
			states[currentState].values.decorations.underline = false;
			states[currentState].values.decorations.overline = false;
			states[currentState].values.decorations.lineThrough = false;

			$underlineCheckbox[0].checked = false;
			$overlineCheckbox[0].checked = false;
			$lineThroughCheckbox[0].checked = false;

			Style.updateActiveSubjectStyle();
		});
	}

	if (setTransform) {
		$container.append(
			'<div class="collapsableOptionsContainer propertySubsection transform">' +
				'<div class="trigger"><label><input type="checkbox" value="1" />Transform</label></div>' +
				'<div class="contentWrapper"><div class="content">' +
					'<label><input type="radio" value="1" class="none" name="' + baseId + '_transformRadios" />None</label> ' +
					'<label><input type="radio" value="1" class="uppercase" name="' + baseId + '_transformRadios" />Uppercase</label> ' +
					'<label><input type="radio" value="1" class="lowercase" name="' + baseId + '_transformRadios" />Lowercase</label> ' +
					'<label><input type="radio" value="1" class="capitalize" name="' + baseId + '_transformRadios" />Capitalize</label> ' +
				'</div></div>' +
			'</div>'
		);

		$transformContainer = $('> .collapsableOptionsContainer.transform', $container);
		$transformTrigger = $('> .trigger input', $transformContainer);
		$transformContentWrapper = $('> .contentWrapper', $transformContainer);
		$noTransformRadio = $('input.none', $transformContentWrapper);
		$uppercaseTransformRadio = $('input.uppercase', $transformContentWrapper);
		$lowercaseTransformRadio = $('input.lowercase', $transformContentWrapper);
		$capitalizeTransformRadio = $('input.capitalize', $transformContentWrapper);

		if (values.transform == undefined || values.transform == '' || values.transform == 'none') {
			$noTransformRadio[0].checked = true;
		} else {
			$transformTrigger[0].checked = true;
			$transformContainer.addClass('expanded');
			$transformContentWrapper.css('display', 'block');

			switch (values.transform) {
			case 'uppercase':
				$uppercaseTransformRadio[0].checked = true;
				break;

			case 'lowercase':
				$lowercaseTransformRadio[0].checked = true;
				break;

			case 'capitalize':
				$capitalizeTransformRadio[0].checked = true;
				break;
			}
		}

		$('input', $transformContentWrapper).on('change', function () {
			var $this = $(this),
				newTransform = '';

			if ($this.hasClass('uppercase'))
				newTransform = 'uppercase';
			else if ($this.hasClass('lowercase'))
				newTransform = 'lowercase';
			else if ($this.hasClass('capitalize'))
				newTransform = 'capitalize';

			states[currentState].values.transform = newTransform;

			Style.updateActiveSubjectStyle();
		});

		$transformTrigger.on('change', function () {
			if (this.checked)
				return;

			$noTransformRadio[0].checked = true;

			states[currentState].values.transform = '';

			Style.updateActiveSubjectStyle();
		});
	}
};
