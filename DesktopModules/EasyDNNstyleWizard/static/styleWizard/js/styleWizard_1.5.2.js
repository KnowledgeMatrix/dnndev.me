/*!
 * StyleWizard
 * www.easydnnsolutions.com/modules/easydnnstylewizard/
 *
 * Copyright 2013 EasyDNNsolutions.com
 * StyleWizard is developed by EasyDNNsolutions.com. It can be used only
 * as an integral part of EasyDNNsolutions.com modules. All unauthorized
 * copying or use of the code or parts of the code is prohibited.
 */

(function ($, window, document, undefined) {
	'use strict';

var styleWizardInitialized = false,

	Core = {},
	Utils = {},
	Style = {},

	defaultStyleId = 'default',

	cssImports = [],
	cssImportsAdded = false,

	collections,
	collectionsBackup,

	config,

	_ = function (s) {
		return config.localization[s] == undefined ? s : config.localization[s]
	},

	spectrumSettings = function (originalColor, callback) {
		var callbackInvoke = function (color) {
			if (callback) {
				callback(Utils.css.generateColorText(color));
			}
		};

		return {
			color: originalColor,
			showInput: true,
			allowEmpty: true,
			showAlpha: true,
			showPalette: false,
			showInitial: true,
			preferredFormat: 'hex',
			change: callbackInvoke,
			move: callbackInvoke,
			hide: callbackInvoke,
			containerClassName: 'styleWizardPicker',
			replacerClassName: 'styleWizardPicker',
			chooseText: "OK",
			cancelText: "Cancel",
			clickoutFiresChange: true
		};
	},

	rendering = {
		baseWrapper: {
			height: 0,
			outerWidth: 0
		},
		headerWrapper: {
			outerHeight: 0
		},
		footerWrapper: {
			outerHeight: 0
		},
		styleSubjectSelectionWrapper: {
			outerHeight: 0
		},
		styleSubjectsWrapper: {
			width: 0,
			height: 0
		},
		styleEditor: {
			header: {
				outerHeight: 0
			}
		},
		active: {
			collection: -1,
			subjects: []
		},
		hidden: true,
		interfaceSide: 'left',
		activeColorPickers: []
	},

	propertyTypeSubsesctions = {},

	savingInProgress = [],

	interfaceStateCookie = 'edsStyleWizardInterfaceVisible_',

	$window = $(window),

	$styleWizard,

	$interfaceToggle,
	$interfaceSideToggle,
	$headerWrapper,
	$footerWrapper,
	$styleSubjectSelectionWrapper,
	$styleSubjectsWrapper,
	$introContainer,
	$collectionListContainer,
	$collectionSaveSelect;
Core.resize = function () {
	rendering.baseWrapper.height = $styleWizard.height();

	rendering.styleSubjectsWrapper.width = $styleSubjectsWrapper.width();
	Core.innerResize();
};

Core.innerResize = function () {
	var collectionIndex = rendering.active.collection,
		$activeSubjectWrapper = $('> .subject_' + collectionIndex + '_' + rendering.active.subjects[collectionIndex], $styleSubjectsWrapper);

	rendering.styleSubjectSelectionWrapper.outerHeight = $styleSubjectSelectionWrapper.is(':visible') ? $styleSubjectSelectionWrapper.outerHeight(true) : 0;
	rendering.headerWrapper.outerHeight = $headerWrapper.outerHeight(true);
	rendering.footerWrapper.outerHeight = $footerWrapper.outerHeight(true);
	rendering.styleSubjectsWrapper.height = rendering.baseWrapper.height - rendering.styleSubjectSelectionWrapper.outerHeight - rendering.headerWrapper.outerHeight - rendering.footerWrapper.outerHeight;

	$styleSubjectsWrapper.height(rendering.styleSubjectsWrapper.height);

	if ($introContainer.is(':visible')) {
		$introContainer
			.height(rendering.styleSubjectsWrapper.height)
			.tinyscrollbar_update('relative');
	}

	if ($activeSubjectWrapper.length > 0) {
		$('> .edStyleWizard_slider > .styleSelection', $activeSubjectWrapper).tinyscrollbar_update('relative');

		if (rendering.styleEditor.header.outerHeight == 0)
			rendering.styleEditor.header.outerHeight = $('> .edStyleWizard_slider > .styleEditor > .header', $activeSubjectWrapper).outerHeight(true);

		$('> .edStyleWizard_slider > .styleEditor > .editor', $activeSubjectWrapper)
			.height(rendering.styleSubjectsWrapper.height - rendering.styleEditor.header.outerHeight)
			.tinyscrollbar_update('relative');
	}
};

Core.openActiveCollection = function () {
	var collectionIndex = rendering.active.collection,
		subjects = collections[collectionIndex].subjects,
		dropdownOptions = '',
		$styleSubjectSelection;

	$introContainer.css('display', 'none');
	$styleSubjectsWrapper.css('display', 'block');

	if (subjects.length > 1) {
		$.each(subjects, function (i, use) {
			dropdownOptions += '<option>' + Utils.html.encode(use.name) + '</option>';
		});

		$styleSubjectSelection = $styleSubjectSelectionWrapper
			.css('display', 'block')
			.find('> select')
				.html(dropdownOptions);

		$styleSubjectSelection[0].selectedIndex = rendering.active.subjects[collectionIndex];
	} else {
		$styleSubjectSelectionWrapper.css('display', 'none');
	}

	$('> li', $collectionListContainer)
		.removeClass('active')
		.eq(collectionIndex)
			.addClass('active');

	Core.openActiveSubject();
};

Core.openActiveSubject = function () {
	var activeCollectionIndex = rendering.active.collection,
		activeSubjectIndex = rendering.active.subjects[activeCollectionIndex],
		collection = collections[activeCollectionIndex],
		subject = collection.subjects[activeSubjectIndex],
		existingStyles = collection.styleGroups[subject.styleGroup].styles,

		$subjectWrapper = $('> .subject_' + activeCollectionIndex + '_' + activeSubjectIndex, $styleSubjectsWrapper),
		$subjectSlider,
		$styleSelectionWrapper,
		$styleSelection,

		activeStyleType = subject.activeStyle.type,
		activeStyleTypeClass;

	if (!(existingStyles[activeStyleType] && existingStyles[activeStyleType][subject.activeStyle.id])) {
		activeStyleType = subject.activeStyle.type = 'predefined';
		subject.activeStyle.id = 'default';
	}

	if ($subjectWrapper.length == 0) {
		Core.initSubjectLayout(activeCollectionIndex, activeSubjectIndex);
		$subjectWrapper = $('> .subject_' + activeCollectionIndex + '_' + activeSubjectIndex, $styleSubjectsWrapper);
	}

	$subjectSlider = $('> .edStyleWizard_slider', $subjectWrapper);
	$styleSelectionWrapper = $('.styleSelection', $subjectSlider);
	$styleSelection = $('> .viewport > .overview', $styleSelectionWrapper);

	activeStyleTypeClass = '.' + activeStyleType;

	$('> .styleTypes >', $styleSelection)
		.css('display', 'none')
		.filter(activeStyleTypeClass)
			.css('display', 'block');

	$('> .styleTypeSelection >', $styleSelection)
		.removeClass('active')
		.filter(activeStyleTypeClass)
			.addClass('active');

	$('> .styleTypes > div > ol > li', $styleSelection).removeClass('actionsOverlayActive');

	$('>', $styleSubjectsWrapper).css('display', 'none');
	$subjectWrapper.css('display', 'block');

	Core.innerResize();
};

Core.initSubjectLayout = function (collectionIndex, subjectIndex) {
	var collection = collections[collectionIndex],
		subject = collection.subjects[subjectIndex],
		styleGroupDefinition = collection.styleGroups[subject.styleGroup],

		styleSelectionHtml = '',

		$subjectWrapper = $(
			'<div class="subject_' + collectionIndex + '_' + subjectIndex + '">' +
				'<div class="edStyleWizard_slider">' +
					'<div class="styleSelection standardScrollbar">' +
						'<div class="viewport"><div class="overview"></div></div>' +
						'<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>' +
					'</div>' +
					'<div class="styleEditor">' +
						'<div class="header">' +
							'<div class="back"><span class="icon"></span><span class="text">Back to style selection</span></div>' +
							'<div class="styleName"><label><span>Style name:</span><input type="text" name="styleName" value="" /></label></div>' +
						'</div>' +
						'<div class="editor standardScrollbar">' +
							'<div class="viewport"><div class="overview"><div class="styleEditorSpacer"></div></div></div>' +
							'<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>' +
						'</div>' +
					'</div>' +
				'</div>' +
			'</div>'
		),
		$subjectSlider = $('> .edStyleWizard_slider', $subjectWrapper),
		$styleSelectionWrapper = $('> .styleSelection', $subjectSlider),
		$styleSelection = $('> .viewport > .overview', $styleSelectionWrapper),
		$predefinedStylesList,
		$customStylesList,
		$styleEditorWrapper = $('> .styleEditor', $subjectSlider),
		$styleEditorContainer = $('> .editor', $styleEditorWrapper),

		customStylesExist = false,

		additionalResourcesHtml = '',
		variableContentHtml = '';

	subject.initialActiveStyle = $.extend({}, subject.activeStyle);

	$subjectSlider.width(rendering.styleSubjectsWrapper.width * 2);
	$('>', $subjectSlider).width(rendering.styleSubjectsWrapper.width);

	if (styleGroupDefinition.themeObjectSettings) {
		if (styleGroupDefinition.themeObjectSettings.additionalResources)
			$.each(styleGroupDefinition.themeObjectSettings.additionalResources, function (sectionId, sectionDefinition) {
				var optionsHtml = '',
					selectedOptions = [],
					noRadioButtonSelected = true;

				if (
					subject.activeThemeObjectSettings &&
					subject.activeThemeObjectSettings.additionalResources &&
					$.isArray(subject.activeThemeObjectSettings.additionalResources[sectionId])
				)
					selectedOptions = subject.activeThemeObjectSettings.additionalResources[sectionId];

				$.each(sectionDefinition.options, function (optionId, option) {
					var selected = false,
						encodedName = Utils.html.encode(option.name);

					if (sectionDefinition.singleSelection) {
						if (selectedOptions.length > 0 && selectedOptions[0] == optionId) {
							selected = true;
							noRadioButtonSelected = false;
						}
					} else {
						if (selectedOptions.length > 0 && $.inArray(optionId, selectedOptions) != -1)
							selected = true;
					}

					optionsHtml +=
						'<div class="optionId_' +
						optionId +
						(selected ? ' activeOption' : '') +
						'" data-option-id="' +
						optionId +
						'" title="' +
						encodedName +
						'"><span>' +
						encodedName +
						'</span></div>';
				});

				if (sectionDefinition.singleSelection) {
					optionsHtml =
						'<div class="optionNone' +
						(noRadioButtonSelected ? ' activeOption' : '') +
						'"><span>' +
						Utils.html.encode(sectionDefinition.noneSelectedText) +
						'</span></div>' +
						optionsHtml;
				}

				if (optionsHtml == '')
					return;

				additionalResourcesHtml +=
					'<div class="contentSectionBox selectionType_' +
					(sectionDefinition.singleSelection
						? 'single'
						: 'multi'
					) + ' section_' + sectionId + '" data-section-id="' + sectionId +'">' +
						'<div class="name"><span>' + Utils.html.encode(sectionDefinition.name) + '</span></div>' +
						'<div class="contentWrapper">' +
							optionsHtml +
						'</div>' +
					'</div>';
			});

		if (styleGroupDefinition.themeObjectSettings.variableContentSections)
			$.each(styleGroupDefinition.themeObjectSettings.variableContentSections, function (i, sectionDefinition) {
				var optionsHtml = '',
					selectedOption = '';

				if (sectionDefinition.show != undefined && $.inArray(subject.templateGroup, sectionDefinition.show) == -1)
					return;

				if (
					subject.activeThemeObjectSettings &&
					subject.activeThemeObjectSettings.variableContentSections &&
					subject.activeThemeObjectSettings.variableContentSections[sectionDefinition.templateGroup]
				)
					selectedOption = subject.activeThemeObjectSettings.variableContentSections[sectionDefinition.templateGroup];

				if (selectedOption == '')
					selectedOption = 'default';

				$.each(sectionDefinition.options, function (optionId, option) {
					var selected = false,
						encodedName = Utils.html.encode(option.name);

					optionsHtml +=
						'<div class="optionId_' +
						optionId +
						(selectedOption == optionId ? ' activeOption initiallySelected' : '') +
						'" data-option-id="' +
						optionId +
						'" title="' +
						encodedName +
						'">' +
						(option.img
							? '<img alt="' + encodedName + ' content preview image" src="' +
								styleGroupDefinition.styleAssetsClientRoot + option.img +
								'" />'
							: '<span class="name">' +
								encodedName +
								'</span>'
						) +
						'<span class="refreshWarning">Save and refresh page to view changes</span>' +
						'</div>';
				});

				if (optionsHtml == '')
					return;

				variableContentHtml +=
					'<div class="contentSectionBox section_' + sectionDefinition.templateGroup + '" data-section-id="' + sectionDefinition.templateGroup +'">' +
						'<div class="name"><span>' + Utils.html.encode(sectionDefinition.name) + '</span></div>' +
						'<div class="contentWrapper">' +
							optionsHtml +
						'</div>' +
					'</div>';
			});
	}

	if (additionalResourcesHtml != '')
		additionalResourcesHtml = '<div class="additionalResourceSeletion">' + additionalResourcesHtml + '</div>';

	if (variableContentHtml != '')
		variableContentHtml = '<div class="variableContentSeletion">' + variableContentHtml + '</div>';

	styleSelectionHtml =
		'<ul class="styleTypeSelection"><li class="predefined"><span>' + _('Predefined') + '</span></li><li class="custom"><span>' + _('Custom') + '</span></li></ul>' +
		'<div class="styleTypes">' +
			'<div class="predefined" style="display: none;">' +
				'<ol></ol>' +
			'</div>' +
			'<div class="custom" style="display: none;">' +
				'<ol></ol>' +
			'</div>' +
		'</div>' +
		additionalResourcesHtml +
		variableContentHtml;

	$styleSelection.html(styleSelectionHtml);

	$predefinedStylesList = $('> .styleTypes > .predefined > ol', $styleSelection);

	$.each(styleGroupDefinition.styles.predefined, function (styleId, style) {
		var nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup);

		if (
			style.show != undefined &&
			$.inArray(subject.templateGroup, style.show) == -1 &&
			!Utils.array.containsArrayElement(subject.additionalTemplateGroups, style.show)
		)
			return;

		$predefinedStylesList.append(Core.generateStyleListItem({
			name: nameAndColors.name,
			type: 'predefined',
			colors: nameAndColors.colors,
			active: subject.activeStyle.type == 'predefined' && subject.activeStyle.id == styleId,
			id: styleId
		}));
	});

	if (!$.isEmptyObject(styleGroupDefinition.styles.custom)) {
		$customStylesList = $('> .styleTypes > .custom > ol', $styleSelection);

		$.each(styleGroupDefinition.styles.custom, function (styleId, style) {
			var nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup);

			if (
				style.show &&
				$.inArray(subject.templateGroup, style.show) == -1 &&
				!Utils.array.containsArrayElement(subject.additionalTemplateGroups, style.show)
			)
				return;

			customStylesExist = true;

			$customStylesList.append(Core.generateStyleListItem({
				name: nameAndColors.name,
				type: 'custom',
				colors: nameAndColors.colors,
				active: subject.activeStyle.type == 'custom' && subject.activeStyle.id == styleId,
				id: styleId
			}));
		});
	}

	if (!customStylesExist)
		$('> .styleTypeSelection > .custom', $styleSelection).css('display', 'none');

	$subjectWrapper
		.data('subjectIndex', subjectIndex)
		.appendTo($styleSubjectsWrapper);
	$styleSelectionWrapper.tinyscrollbar();
	$styleEditorContainer.tinyscrollbar();
};

Core.generateStyleListItem = function (args) {
	var customType = args.type == 'custom',
		$li = $(
			'<li class="' + (args.active ? 'active' : '') + (customType ? ' ' + args.id : ' predefined_' + args.id) + '">' +
				'<ol class="colorPreview"></ol>' +
				'<span>' + Utils.html.encode(args.name) + '</span>' +
				'<div class="overlayWrapper">' +
					'<div class="actionsOverlay">' +
						'<div class="action edit" title="' + _('Edit style') + '"><span>' + _('Edit style') + '</span></div>' +
						(
							customType ? '<div class="action delete" title="' + _('Delete style') + '"><span>' + _('Delete style') + '</span></div>' : ''
						) +
						'<div class="action close" title="' + _('Close actions') + '"><span>' + _('Close actions') + '</span></div>' +
					'</div>' +
					'<div class="standardOverlay">' +
						'<div class="openActionsOverlay" title="' + _('Open actions') + '"><span>' + _('Open actions') + '</span></div>' +
					'</div>' +
				'</div>' +
			'</li>'
		),
		$colorPreview = $('> .colorPreview', $li);

	if (args.colors != undefined && args.colors.length > 0) {
		$.each(args.colors, function (i, color) {
			$colorPreview.prepend($('<li></li>').css('background', color));
		});
	}

	return $li.data('styleId', args.id);
};

Core.cloneStyle = function (args) {
	var collection = collections[args.collection],
		styleGroup = collection.subjects[args.subject].styleGroup,
		collectionStyles = collection.styleGroups[styleGroup].styles,
		sourceStyle = collectionStyles[args.type][args.id],
		newStyle = {},
		newId,

		templateGroup;

	if (collectionStyles['custom'] == undefined)
		collectionStyles['custom'] = {};

	do {
		newId = 's' + Utils.string.random(10).toLowerCase();
	} while (collectionStyles['custom'][newId] != undefined);

	$.extend(true, newStyle, sourceStyle);

	for (templateGroup in newStyle.templateGroups) {
		newStyle.templateGroups[templateGroup].name += ' Copy';
	}

	if (args.type == 'predefined')
		newStyle.originalStyleId = args.id;
	else
		newStyle.originalStyleId = sourceStyle.originalStyleId;

	newStyle.baseCss = '';

	collectionStyles['custom'][newId] = newStyle;

	return newId;
};

Core.setupStyleEditor = function () {
	var collectionIndex = rendering.active.collection,
		subjectIndex = rendering.active.subjects[collectionIndex],

		collection = collections[collectionIndex],
		subject = collection.subjects[subjectIndex],
		styleGroup = collection.styleGroups[subject.styleGroup],
		style = styleGroup.styles.custom[subject.activeStyle.id],

		nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup),

		baseCss = styleGroup.styles.predefined[style.originalStyleId].baseCss,

		$subjectWrapper = $('> .subject_' + collectionIndex + '_' + subjectIndex, $styleSubjectsWrapper),
		$styleEditorWrapper = $('> > .styleEditor', $subjectWrapper),
		$styleEditorHeader = $('> .header', $styleEditorWrapper),
		$styleEditorSpacer = $('> .editor > .viewport > .overview > .styleEditorSpacer', $styleEditorWrapper),

		concatedTemplateGroups = [];

	if (style == undefined)
		return;

	if (typeof baseCss != 'string')
		baseCss = '';

	if (rendering.activeColorPickers.length > 0) {
		$.each(rendering.activeColorPickers, function (i, $picker) {
			$picker.spectrum('destroy');
		});

		rendering.activeColorPickers = [];
	}

	Style.changeSectionStyle({
		collectionType: collection.type,
		styleSwitchCriteria: subject.styleSwitchCriteria,
		styleGroup: subject.styleGroup,
		globalFontFamilies: styleGroup.customFontFamilies,
		template: subject.template,
		themeName: styleGroup.themeName,
		assetsRootPath: styleGroup.styleAssetsClientRoot,
		style: {
			type: 'custom',
			id: subject.activeStyle.id,
			definition: styleGroup.styleDefinitions,
			values: style.values,
			baseCss: baseCss
		},
		metaVersion: styleGroup.metaVersion
	});

	$('> .styleName input', $styleEditorHeader).val(nameAndColors.name);

	$styleEditorSpacer.html('');

	if ($.isArray(subject.additionalTemplateGroups))
		concatedTemplateGroups = subject.additionalTemplateGroups;

	concatedTemplateGroups.push(subject.templateGroup);

	Core.generateStyleEditorElements(
		$styleEditorSpacer,
		styleGroup.styleDefinitions,
		style.values,
		concatedTemplateGroups,
		subject.subCollection,
		'styleWizardEditor_' + collection.type + '_' + subjectIndex + '_' + subject.activeStyle.id,
		'',
		styleGroup.customFontFamilies,
		styleGroup.metaVersion
	);
};

Core.generateStyleEditorElements = function ($container, definition, values, templateGroups, subCollection, parentId, universalPropertyId, customFontFamilies, metaVersion) {
	var $propertiesContainer,
		$sectionsContainer;

	if (definition.properties && values.properties) {

		$propertiesContainer = $('<ul class="properties mainCollapsibleBoxes" />').appendTo($container);

		$.each(definition.properties, function (propertyId, property) {
			var $li,
				propertyType = property.type,
				$propertyContent;

			if (propertyType == 'opacity' && metaVersion < 2)
				return;

			if (
				(
					typeof subCollection == 'string' &&
					subCollection != '' &&
					typeof property.subCollection == 'string' &&
					property.subCollection != '' &&
					!Utils.style.hasSubCollection(property.subCollection, subCollection)
				) ||
				values.properties[propertyId] == undefined ||
				(property.show && !Utils.array.containsArrayElement(templateGroups, property.show)) ||
				(!$.isArray(property.show) && property.hide && Utils.array.containsArrayElement(templateGroups, property.hide))
			)
				return;

			$li = $('<li class="' + propertyType + '">' +
					'<div class="toggleContainer">' +
						'<div class="name property"></div>' +
						'<div class="descendantIndicator"></div>' +
					'</div>' +
					'<div class="toggleContent">' +
						(property.states.length > 1 ? '<ol></ol>' : '') +
						'<div class="propertyStatesWrapper"></div>' +
						'<div class="descendantIndicator property"></div>' +
					'</div>' +
				'</li>').appendTo($propertiesContainer);

			$('> .toggleContainer > .name', $li).text(property.name);
			$propertyContent = $('> .toggleContent', $li).css('display', 'none');

			$li.data('propertyInitializer', function () {
				var stateSelectionHtml = '';

				$.each(property.states, function (i, state) {
					var $div = $('<div />'),
						customPropertyOptions = {};

					$div.addClass(propertyType).appendTo($('> .toggleContent > .propertyStatesWrapper', $li));

					if (property.states.length > 1)
						stateSelectionHtml += '<li' + (state.id == 'default' ? ' class="active"' : '') + '><span>' + Utils.html.encode(state.name) + '</span></li>';

					if (propertyType == 'text')
						customPropertyOptions = {
							customFonts: ($.isArray(customFontFamilies) && customFontFamilies.length > 0 ? customFontFamilies : [])
						};

					Style.generatePropertyEditorHtml(
						$div,
						propertyType,
						state.forbidden,
						values.properties[propertyId],
						state.id,
						parentId + '_' + propertyId + '_' + i,
						universalPropertyId + propertyId,
						metaVersion,
						customPropertyOptions
					);
					Style.propertyStateSubsectionDropdown($div, propertyType, state.forbidden, values.properties[propertyId][state.id], metaVersion);

					if (state.id != 'default')
						$div.css('display', 'none');
				});

				$('> ol', $propertyContent).html(stateSelectionHtml);
			});
		});
	}

	if (definition.sections && values.sections) {
		$sectionsContainer = $('<ul class="sections mainCollapsibleBoxes" />').appendTo($container);

		$.each(definition.sections, function (sectionId, section) {
			var $li,
				$content;

			if (
				values.sections[sectionId] == undefined ||
				(section.show && !Utils.array.containsArrayElement(templateGroups, section.show)) ||
				(!$.isArray(section.show) && section.hide && Utils.array.containsArrayElement(templateGroups, section.hide))
			)
				return;

			$li = $('<li>' +
					'<div class="toggleContainer">' +
						'<div class="name"></div>' +
						'<div class="descendantIndicator"></div>' +
					'</div>' +
					'<div class="toggleContent"></div>' +
				'</li>').appendTo($sectionsContainer),
			$content = $('> .toggleContent', $li);

			$('> .toggleContainer > .name', $li).text(section.name);

			Core.generateStyleEditorElements(
				$content,
				section,
				values.sections[sectionId],
				templateGroups,
				subCollection,
				parentId + '_' + sectionId,
				universalPropertyId + sectionId + '_',
				customFontFamilies,
				metaVersion
			);

			if ($('> .properties >', $content).length > 0 || $('> .sections >', $content).length > 0)
				$content.css('display', 'none');
			else
				$li.remove();
		});
	}
};

Core.toggleInterface = function (show, saveState) {
	if (show) {
		rendering.hidden = false;

		$interfaceToggle
			.html('<span />Hide')
			.addClass('showInterface');
		$styleWizard.addClass('showInterface');
		$collectionListContainer.addClass('showInterface');
		$interfaceSideToggle.addClass('showInterface');
	} else {
		rendering.hidden = true;

		$interfaceToggle
			.html('<span />StyleWizard')
			.removeClass('showInterface');
		$styleWizard.removeClass('showInterface');
		$collectionListContainer.removeClass('showInterface');
		$interfaceSideToggle.removeClass('showInterface');
	}

	if (saveState)
		Core.saveInterfaceState();
};

Core.saveInterfaceState = function () {
	$.cookie(
		interfaceStateCookie,
		JSON.stringify({
			side: rendering.interfaceSide,
			hidden: rendering.hidden
		}),
		{path: '/'}
	);
};
Style.changeSectionStyle = function (args) {
	var $sections,
		sectionsSelectors,
		sectionBaseSelector = '',
		styleTagId = 'eds_' + args.collectionType + '_' + args.styleGroup,
		styleClass = '.eds_style_' + args.style.type + '_' + args.style.id,
		baseCss = Utils.style.replaceCssTokens(
			args.style.baseCss,
			styleClass,
			args.themeName,
			args.assetsRootPath
		),

		tokenValues = {
			themeName: args.themeName,
			styleType: args.style.type,
			styleId: args.style.id
		};

	if (args.collectionType != 'skin') {
		sectionsSelectors = '.eds_' + args.collectionType + '_' + args.themeName + '.eds_template_' + args.template;

		if (args.styleSwitchCriteria) {
			sectionsSelectors += '.eds_styleSwitchCriteria_' + args.styleSwitchCriteria;
		}

		$sections = $(sectionsSelectors);

		Utils.css.removeClassContaining($sections, 'eds_style_');

		if (args.style.type == 'predefined' && args.style.id == defaultStyleId)
			return;

		styleTagId += '_' + args.style.type + '_' + args.style.id;

		$sections.addClass('eds_style_' + args.style.type + '_' + args.style.id);
		sectionBaseSelector = '.eds_' + args.collectionType + '_' + args.themeName + styleClass;
	}

	Style.updateStyleTag(
		styleTagId,
		baseCss + Style.generateStyleCss(args.style.definition, args.style.values, sectionBaseSelector, args.assetsRootPath, tokenValues, args.globalFontFamilies, args.metaVersion)
	);
};

Style.updateActiveSubjectStyle = function () {
	var collectionIndex = rendering.active.collection,
		subjectIndex = rendering.active.subjects[collectionIndex],

		collection = collections[collectionIndex],
		subject = collection.subjects[subjectIndex],
		styleGroup = collection.styleGroups[subject.styleGroup],
		collectionType = collection.type,
		activeStyleType = subject.activeStyle.type,
		activeStyleId = subject.activeStyle.id,

		styleTagId = 'eds_' + collectionType + '_' + subject.styleGroup,
		sectionBaseSelector = '',
		style = styleGroup.styles[activeStyleType][activeStyleId],

		baseCss = '',
		styleClass = '.eds_style_' + activeStyleType + '_' + activeStyleId,

		tokenValues = {
			themeName: styleGroup.themeName,
			styleType: activeStyleType,
			styleId: activeStyleId
		};

	if (collectionType != 'skin') {
		styleTagId += '_' + activeStyleType + '_' + activeStyleId;
		sectionBaseSelector = '.eds_' + collectionType + '_' + styleGroup.themeName + styleClass;
	}

	if (activeStyleType == 'predefined')
		baseCss = style.baseCss;
	else
		baseCss = styleGroup.styles.predefined[style.originalStyleId].baseCss;

	if (typeof baseCss != 'string')
		baseCss = '';

	baseCss = Utils.style.replaceCssTokens(
		baseCss,
		styleClass,
		styleGroup.themeName,
		styleGroup.styleAssetsClientRoot
	);

	Style.updateStyleTag(
		styleTagId,
		baseCss + Style.generateStyleCss(styleGroup.styleDefinitions, style.values, sectionBaseSelector, styleGroup.styleAssetsClientRoot, tokenValues, styleGroup.customFontFamilies, styleGroup.metaVersion)
	);
};

Style.updateStyleTag = function (id, css) {
	Style.updateCssImports();

	$('head > style#' + id).remove();
	$('<style type="text/css" />')
		.html(css)
		.attr('id', id)
		.appendTo('head');
};

Style.addCssImport = function (resource) {
	if ($.inArray(resource, cssImports) === -1) {
		cssImports.push(resource);
		cssImportsAdded = true;
	}
};

Style.updateCssImports = function () {
	var tagId = 'styleWizardCssImports',
		$tag = $('head > style#' + tagId),
		imports = '';

	if (!cssImportsAdded)
		return;

	cssImportsAdded = false;

	$.each(cssImports, function (i, url) {
		imports += '@import url(' + url + ');';
	});

	if (imports == '')
		return;

	$tag.remove();
	$tag = $('<style type="text/css" id="' + tagId + '" />').appendTo('head');

	$tag.html(imports);
};

Style.generateStyleCss = function (styleDefinition, styleValues, baseSelector, assetsRootPath, tokenValues, globalFontFamilies, metaVersion) {
	var returnCss = '',
		selectorsCss = {};

	if (typeof styleDefinition.properties == 'object' && styleValues.properties) {
		$.each(styleDefinition.properties, function (id, propertyDefinition) {
			var propertieStateValues = styleValues.properties[id];

			if (propertieStateValues == undefined)
				return;

			$.each(propertyDefinition.states, function (i, stateDefinition) {
				var css,
					completeSelectors = '';

				try {
					css = Style.generateCssFromProperty(
						propertyDefinition.type,
						propertieStateValues[stateDefinition.id],
						stateDefinition.forbidden,
						stateDefinition.important,
						assetsRootPath,
						globalFontFamilies,
						metaVersion
					);
				} catch (e) {
					console.log({
						message: 'Error while generating property css.',
						styleDefinition: styleDefinition,
						propertyId: id,
						stateId: stateDefinition.id
					});
					throw e;
				}

				if (!$.isArray(stateDefinition.selectors) || stateDefinition.selectors.length == 0)
					return;

				$.each(stateDefinition.selectors, function (i, selector) {
					var styleTypeAndId = (tokenValues.styleType == 'custom' ? 'custom_' : '') + tokenValues.styleId;

					if (selector[0] == '!') {
						selector = selector.substr(1)
							.replace(/_-ThemeName-_/g, tokenValues.themeName)
							.replace(/_-StyleTypeAndId-_/g, styleTypeAndId);

						completeSelectors += selector + ',';

						return;
					}

					var templateGroups = [''];

					if (baseSelector && $.isArray(propertyDefinition.show))
						templateGroups = propertyDefinition.show;

					var subCollections = (propertyDefinition.subCollection || '').split('|'),
						i = 0,
						j = 0,
						collectionsL = subCollections.length,
						templateGroupL = templateGroups.length;

					for (; i < collectionsL; i++) {
						var subCollectionClass = subCollections[i].trim();

						if (typeof subCollectionClass == 'string' && subCollectionClass != '')
							subCollectionClass = '.eds_subCollection_' + subCollectionClass;

						for (; j < templateGroupL; j++) {
							var templateGroupClass = templateGroups[j];

							if (typeof templateGroupClass == 'string' && templateGroupClass != '')
								templateGroupClass = '.eds_templateGroup_' + templateGroupClass;

							completeSelectors += baseSelector + subCollectionClass + templateGroupClass + selector + ',';
						}
					}
				});

				completeSelectors = completeSelectors.substring(0, completeSelectors.length - 1);

				if (selectorsCss[completeSelectors] == undefined)
					selectorsCss[completeSelectors] = '';

				selectorsCss[completeSelectors] += css;
			});
		});

		$.each(selectorsCss, function (selector, css) {
			if (!css)
				return;

			returnCss += selector + '{' + css + '}';
		});
	}

	if (typeof styleDefinition.sections == 'object' && styleValues.sections)
		$.each(styleDefinition.sections, function (id, sectionDefinition) {
			var sectionValue = styleValues.sections[id];

			if (sectionValue == undefined)
				return;

			returnCss += Style.generateStyleCss(sectionDefinition, sectionValue, baseSelector, assetsRootPath, tokenValues, globalFontFamilies, metaVersion);
		});

	return returnCss;
};

Style.listStylesThatUseBackgroundImage = function (imageName, imageType, propertyPath) {
	var collectionIndex = rendering.active.collection,
		subjectIndex = rendering.active.subjects[collectionIndex],

		collection = collections[collectionIndex],
		subject = collection.subjects[subjectIndex],
		styleGroupStyles = collection.styleGroups[subject.styleGroup].styles,

		stylesWithImage = {
			predefined: {},
			custom: {}
		};

	if (typeof propertyPath == 'string') {
		if (propertyPath == '')
			return {};

		propertyPath = propertyPath.split('_');
	}

	if (propertyPath.length == 0)
		return {};

	if (imageType == 'predefined' && styleGroupStyles[imageType])
		$.each(styleGroupStyles[imageType], function (styleId, style) {
			$.each(Style.getStyleProperty(style.values, $.extend([], propertyPath)), function (i, state) {
				if (typeof state.values.image != 'object')
					return;

				if (state.values.image.type == imageType && state.values.image.file == imageName) {
					stylesWithImage[imageType][styleId] = style;
					return false;
				}
			});
		});

	$.each(styleGroupStyles['custom'], function (styleId, style) {
		$.each(Style.getStyleProperty(style.values, $.extend([], propertyPath)), function (i, state) {
			if (typeof state.values.image != 'object')
				return;

			if (state.values.image.type == 'uploaded' && state.values.image.file == imageName) {
				stylesWithImage.custom[styleId] = style;
				return false;
			}
		});
	});

	return stylesWithImage;
}

Style.getStyleProperty = function (styleSection, propertyPath) {
	var childSectionId;

	if (propertyPath.length == 1) {
		return styleSection.properties[propertyPath[0]];
	}

	childSectionId = propertyPath[0];
	propertyPath = propertyPath.splice(propertyPath.length - (propertyPath.length - 1));

	if (styleSection.sections == undefined || styleSection.sections[childSectionId] == undefined)
		return undefined;

	return Style.getStyleProperty(styleSection.sections[childSectionId], propertyPath);
}

Style.generateCssFromProperty = function (type, state, disabled, important, assetsRootPath, globalFontFamilies, metaVersion) {
	var propertyTypeGenerator = Style.generateCssFromProperty[type];

	if (propertyTypeGenerator == undefined || (type == 'opacity' && metaVersion < 2))
		return '';

	if (!$.isArray(disabled))
		disabled = [];

	if ($.isArray(state.disabled))
		disabled = disabled.concat(state.disabled);

	return propertyTypeGenerator(state.values, disabled, important, metaVersion, assetsRootPath, globalFontFamilies);
};

Style.generateCssFromProperty.background = function (values, disabled, important, metaVersion, assetsRootPath) {
	var css = '',
		animation,
		animationImportant;

	if (values.color)
		values.color = Utils.css.filterColorText(values.color);

	if ($.inArray('color', disabled) === -1) {
		css = 'background-color:' + values.color;

		if ($.inArray('color', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('image', disabled) === -1) {
		css += 'background-image:';
		if (typeof values.image != 'object' || typeof values.image.completeUrl != 'string' || values.image.completeUrl == '')
			css += 'none';
		else
			css += 'url("' + values.image.completeUrl.replace(/_-StyleAssetsClientRoot-_/g, assetsRootPath) + '")';

		if ($.inArray('image', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('repeat', disabled) === -1) {
		css += 'background-repeat:';
		if (typeof values.repeat != 'string' || values.repeat == '')
			css += 'repeat';
		else
			css += values.repeat;

		if ($.inArray('repeat', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('attachment', disabled) === -1) {
		css += 'background-attachment:';
		if (typeof values.attachment != 'string' || values.attachment == '')
			css += 'scroll';
		else
			css += values.attachment;

		if ($.inArray('attachment', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('position', disabled) === -1) {
		css += 'background-position:';
		css += values.position.horizontal.value + values.position.horizontal.unit + ' ';
		css += values.position.vertical.value + values.position.vertical.unit;

		if ($.inArray('attachment', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('animation', disabled) === -1 && metaVersion > 1) {
		animation = values.animation.name + ' ' + values.animation.duration + 's linear infinite';

		if ($.inArray('animation', important) > -1)
			animation += '!important';

		animation += ';';

		$.each(['', '-ms-', '-moz-', '-webkit-'], function (i, prefix) {
			css += prefix + 'animation:' + animation;
		});
	}

	return css;
};

Style.generateCssFromProperty.text = function (values, disabled, important, metaVersion, assetsRootPath, globalFontFamilies) {
	var css = '',
		textShadowCss = 'text-shadow:',
		textDecorationCss = '',
		fontImportUrl = undefined,
		combinedFontFamilies = [];

	if ($.inArray('fontFamily', disabled) === -1) {
		if ($.isArray(values.customFontFamilies))
			combinedFontFamilies = values.customFontFamilies;

		if ($.isArray(globalFontFamilies))
			combinedFontFamilies = combinedFontFamilies.concat(globalFontFamilies);

		fontImportUrl = Utils.style.getImportUrlFromFont(combinedFontFamilies, values.fontFamily);
		if (fontImportUrl)
			Style.addCssImport(fontImportUrl);

		css = 'font-family:"' + values.fontFamily + '"';

		if ($.inArray('fontFamily', important) > -1)
			css += '!important';

		css += ';';
	}

	if (values.color)
		values.color = Utils.css.filterColorText(values.color);

	if ($.inArray('color', disabled) === -1) {
		css += 'color:' + values.color;

		if ($.inArray('color', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('size', disabled) === -1) {
		css += 'font-size:' + values.size.value + values.size.unit;

		if ($.inArray('size', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('style', disabled) === -1) {
		css += 'font-style:' + values.style;

		if ($.inArray('style', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('weight', disabled) === -1) {
		css += 'font-weight:' + values.weight;

		if ($.inArray('weight', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('lineHeight', disabled) === -1) {
		css += 'line-height:' + values.lineHeight.value + values.lineHeight.unit;

		if ($.inArray('lineHeight', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('transform', disabled) === -1) {
		css += 'text-transform:';

		switch (values.transform) {
		case 'uppercase':
			css += 'uppercase';
			break;

		case 'lowercase':
			css += 'lowercase';
			break;

		case 'capitalize':
			css += 'capitalize';
			break;

		default:
			css += 'none';
		}

		if ($.inArray('transform', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('decorations', disabled) === -1) {
		if (typeof values.decorations == 'object') {
			if (values.decorations.underline === true)
				textDecorationCss = ' underline';

			if (values.decorations.overline === true)
				textDecorationCss += ' overline';

			if (values.decorations.lineThrough === true)
				textDecorationCss += ' line-through';
		}

		if (textDecorationCss == '')
			textDecorationCss = 'none';

		css += 'text-decoration:' + textDecorationCss;

		if ($.inArray('decorations', important) > -1)
			css += '!important';

		css += ';';
	}

	if ($.inArray('shadows', disabled) === -1) {
		if (typeof values.shadows == 'object' && values.shadows.show && $.isArray(values.shadows.list) && values.shadows.list.length > 0) {
			$.each(values.shadows.list, function (i, shadow) {
				values.shadows.list[i].color = Utils.css.filterColorText(values.shadows.list[i].color);
				shadow.color = values.shadows.list[i].color;
				textShadowCss += shadow.x.value + shadow.x.unit + ' ' + shadow.y.value + shadow.y.unit + ' ' + shadow.radius.value + shadow.radius.unit + ' ' + shadow.color + ', ';
			});
			textShadowCss = textShadowCss.substr(0, textShadowCss.length - 2);
		} else {
			textShadowCss += 'none';
		}

		css += textShadowCss;

		if ($.inArray('shadows', important) > -1)
			css += '!important';

		css += ';';
	}

	return css;
};

Style.generateCssFromProperty.border = function (values, disabled, important, metaVersion) {
	var css = '',
		direction,
		setTop = $.inArray('topSide', disabled) == -1,
		setBottom = $.inArray('bottomSide', disabled) == -1,
		setLeft = $.inArray('leftSide', disabled) == -1,
		setRight = $.inArray('rightSide', disabled) == -1,
		widthImportant = $.inArray('width', important) > -1,
		styleImportant = $.inArray('style', important) > -1,
		colorImportant = $.inArray('color', important) > -1,

		generateBorderCss = function (border, direction) {
			var css = '';

			if (direction)
				direction += '-';
			else
				direction = '';

			if ($.inArray('width', disabled) == -1)
				css += 'border-' + direction + 'width:' + border.width.value + border.width.unit + (widthImportant ? '!important' : '') + ';';

			if ($.inArray('style', disabled) == -1)
				css += 'border-' + direction + 'style:' + border.style + (styleImportant ? '!important' : '') + ';';

			if ($.inArray('color', disabled) == -1)
				css += 'border-' + direction + 'color:' + border.color + (colorImportant ? '!important' : '') + ';';

			return css;
		};

	if (typeof values != 'object')
		return '';

	if (
		values.width ||
		values.style ||
		values.color
	) {
		if (values.color)
			values.color = Utils.css.filterColorText(values.color);

		if (setTop && setBottom && setLeft && setRight)
			return generateBorderCss(values);

		values = {
			top: values,
			bottom: values,
			left: values,
			right: values
		};
	}

	$.each(values, function (direction, border) {
		if ($.inArray(direction + 'Side', disabled) != -1)
			return;

		if (border.color)
			values[direction].color = Utils.css.filterColorText(values[direction].color);

		border.color = values[direction].color;

		css += generateBorderCss(border, direction);
	});

	return css;
};

Style.generateCssFromProperty.boxShadow = function (values, disabled, important, metaVersion) {
	var css = 'box-shadow:',
		i = 0,
		setShadows = $.inArray('shadows', disabled) == -1,
		shadow;

	if (!setShadows || typeof values != 'object')
		return '';

	if (values.show === false || !$.isArray(values.list) || values.list.length == 0) {
		css += 'none';
	} else {
		for (; i < values.list.length; i++) {
			values.list[i].color = Utils.css.filterColorText(values.list[i].color);

			shadow = values.list[i];

			css += (shadow.inset ? 'inset ' : '') +
				shadow.x.value + shadow.x.unit + ' ' +
				shadow.y.value + shadow.y.unit + ' ' +
				shadow.blur.value + shadow.blur.unit + ' ' +
				shadow.spread.value + shadow.spread.unit + ' ' +
				shadow.color + ', ';
		}

		css = css.substr(0, css.length - 2);
	}

	if ($.inArray('shadows', important) > -1)
		css += '!important';

	css += ';';

	return css;
};

Style.generateCssFromProperty.opacity = function (values, disabled, important, metaVersion) {
	var css = 'opacity:',
		opacity;

	if ($.inArray('opacity', disabled) > -1 || typeof values != 'object')
		return '';

	opacity = values.opacity;

	if (opacity < 0)
		opacity = 0;
	if (opacity > 1)
		opacity = 1;

	css += Math.round(opacity * 100) / 100;

	if ($.inArray('opacity', important) > -1)
		css += '!important';

	return css + ';';
};

Style.generateCssFromProperty.borderRadius = function (values, disabled, important, metaVersion) {
	var css = '',

		setTopLeft = $.inArray('topLeft', disabled) == -1,
		setTopRight = $.inArray('topRight', disabled) == -1,
		setBottomLeft = $.inArray('bottomLeft', disabled) == -1,
		setBottomRight = $.inArray('bottomRight', disabled) == -1,

		cssCorners = {
			topLeft: 'top-left',
			topRight: 'top-right',
			bottomLeft: 'bottom-left',
			bottomRight: 'bottom-right'
		},

		generateRadiusCss = function (values, corner) {
			var css = '',
				cssCorner = '';

			if (corner && cssCorners[corner])
				cssCorner = cssCorners[corner] + '-';
			else
				corner = '';

			css += 'border-' + cssCorner + 'radius:' + values.first.value + values.first.unit

			if ($.inArray('second', disabled) == -1) {
				if (cssCorner)
					css += ' ';
				else
					css += '/';

				css += values.second.value + values.second.unit
			}

			if (
				$.inArray('all', important) > -1 ||
				(corner != '' && $.inArray(corner, important) > -1)
			)
				css += '!important';

			return css + ';';
		};

	if (typeof values != 'object')
		return '';

	if (values.first) {
		if (setTopLeft && setTopRight && setBottomLeft && setBottomRight)
			return generateRadiusCss(values);

		values = {
			topLeft: values,
			topRight: values,
			bottomLeft: values,
			bottomRight: values
		};
	}

	$.each(values, function (corner, cornerValues) {
		if ($.inArray(corner, disabled) != -1)
			return;

		css += generateRadiusCss(cornerValues, corner);
	});

	return css;
};

Style.generatePropertyEditorHtml = function ($container, type, forbidden, states, currentState, baseId, universalPropertyId, metaVersion, customOptions) {
	var propertyTypeGenerator = Style.generatePropertyEditorHtml[type];

	if (propertyTypeGenerator == undefined)
		return;

	if (!$.isArray(forbidden))
		forbidden = [];

	return propertyTypeGenerator($container, forbidden, states, currentState, metaVersion, baseId, universalPropertyId, customOptions);
};

Style.propertyStateSubsectionDropdown = function ($container, type, forbidden, state, metaVersion) {
	var subsections = propertyTypeSubsesctions[type],
		$subsectionsDropdownWrapper,
		$subsectionsDropdownContainer,
		$subsectionsDropdownList,
		$subsectionsDropdownTrigger,
		$styleEditorContainer;

	if (subsections == undefined || subsections.length == 0)
		return;

	$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar');

	$subsectionsDropdownWrapper = $(
		'<div class="subsectionsSelectionDropdownWrapper">' +
			'<div class="trigger"><span class="text">Subsections</span><span class="icon"><span></span></span></div>' +
			'<div class="dropdown">' +
				'<ol />' +
			'</div>' +
		'</div>'
	).prependTo($container);
	$subsectionsDropdownContainer = $('> div.dropdown', $subsectionsDropdownWrapper);
	$subsectionsDropdownList = $('> ol', $subsectionsDropdownContainer);
	$subsectionsDropdownTrigger = $('> div.trigger', $subsectionsDropdownWrapper);

	$subsectionsDropdownTrigger.on('click', function () {
		$subsectionsDropdownWrapper.toggleClass('expanded');
		$styleEditorContainer.tinyscrollbar_update('relative');
	});

	$.each(subsections, function (i, subsection) {
		var $li,
			$input,
			$propertySubsection;

		if (
			$.inArray(subsection.id, forbidden) > -1 ||
			(
				type == 'background' &&
				subsection.id == 'animation' &&
				metaVersion < 2
			)
		)
			return;

		$li = $('<li><span><label><input type="checkbox" />' + Utils.html.encode(subsection.name) + '</label></span></li>');
		$input = $('input', $li);
		$propertySubsection = $('.propertySubsection.' + subsection.id, $container);

		if ($.inArray(subsection.id, state.disabled) === -1) {
			$input[0].checked = true;
			$propertySubsection.removeClass('hide');
		} else {
			$input[0].checked = false;
			$propertySubsection.addClass('hide');
		}

		$input.on('change', function () {
			var subsectionIndex = $.inArray(subsection.id, state.disabled);

			if ($input[0].checked) {
				if (subsectionIndex != -1)
					state.disabled = Utils.array.removeItem(subsection.id, state.disabled);

				$propertySubsection
					.trigger('enabling')
					.removeClass('hide');
			} else {
				if (subsectionIndex === -1) {
					if (state.disabled == undefined)
						state.disabled = [];

					state.disabled.push(subsection.id);
				}

				$propertySubsection
					.trigger('disabling')
					.addClass('hide');
			}

			$styleEditorContainer.tinyscrollbar_update('relative');
			Style.updateActiveSubjectStyle();
		});

		$li.appendTo($subsectionsDropdownList);
	});
};
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

propertyTypeSubsesctions['border'] = [
	{
		id: 'width',
		name: 'Width'
	},
	{
		id: 'style',
		name: 'Style'
	},
	{
		id: 'color',
		name: 'Color'
	},
	{
		id: 'topSide',
		name: 'Top'
	},
	{
		id: 'bottomSide',
		name: 'Bottom'
	},
	{
		id: 'leftSide',
		name: 'Left'
	},
	{
		id: 'rightSide',
		name: 'Right'
	}
];

Style.generatePropertyEditorHtml.border = function ($container, forbidden, states, currentState, metaVersion) {
	var $detailToggleContainer = $('<ul class="assignmentStyleSelection"><li><span>Uniform border</span></li><li><span>Specify each side</span></li></ul>'),
		$oneForAllContainer,
		$eachSideContainer,
		$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar'),

		values = states[currentState].values,
		oneForAllValues,

		specifiedSides = !(values.color != undefined || values.width != undefined || values.style != undefined),

		setWidth = $.inArray('width', forbidden) == -1,
		setStyle = $.inArray('style', forbidden) == -1,
		setColor = $.inArray('color', forbidden) == -1,

		activeSide = 'top',
		forbidenSideCount = 0,

		generateInputTemplate = function (vals) {
			var template = '';

			if (setWidth)
				template = '<div class="propertySubsection width">' +
					'<input type="text" class="width numeric" value="' + vals.width.value + '" /> ' +
					'<select class="widthUnit numericUnit">' +
						'<option value="px"' + (vals.width.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
						'<option value="em"' + (vals.width.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
					'</select> ' +
				'</div>';

			if (setStyle)
				template += '<div class="propertySubsection style">' +
					'<select class="style">' +
						'<option value="solid"' + (vals.style == 'solid' ? ' selected="selected"' : '') + '>solid</option>' +
						'<option value="dotted"' + (vals.style == 'dotted' ? ' selected="selected"' : '') + '>dotted</option>' +
						'<option value="dashed"' + (vals.style == 'dashed' ? ' selected="selected"' : '') + '>dashed</option>' +
						'<option value="double"' + (vals.style == 'double' ? ' selected="selected"' : '') + '>double</option>' +
						'<option value="groove"' + (vals.style == 'groove' ? ' selected="selected"' : '') + '>groove</option>' +
						'<option value="ridge"' + (vals.style == 'ridge' ? ' selected="selected"' : '') + '>ridge</option>' +
						'<option value="inset"' + (vals.style == 'inset' ? ' selected="selected"' : '') + '>inset</option>' +
						'<option value="outset"' + (vals.style == 'outset' ? ' selected="selected"' : '') + '>outset</option>' +
					'</select> ' +
				'</div>';

			if (setColor)
				template += '<div class="propertySubsection color">' +
					'<input type="text" class="spectrumPicker" />' +
				'</div>';

			return template;
		},

		spectrumCallback = function (side) {
			return function (color) {
				if (specifiedSides)
					states[currentState].values[side].color = color;
				else
					states[currentState].values.color = color;

				Style.updateActiveSubjectStyle();
			};
		},

		updateActiveSide = function () {
			var cornerSet = false,
				run = function (ignoreDisabled) {
					['top', 'right', 'bottom', 'left'].map(function (side) {
						if (
							$.inArray(side + 'Side', forbidden) != -1 ||
							(!ignoreDisabled && $.inArray(side + 'Side', states[currentState].disabled) != -1) ||
							typeof states[currentState].values[side] != 'object'
						)
							return;

						activeSide = side;
						cornerSet = true;
					});
				};

			run();

			if (!cornerSet)
				run(true);
		};

	$container.append($detailToggleContainer, '<div class="borderEditor"><div class="oneForAll"></div><div class="eachSide"></div></div>');

	$oneForAllContainer = $('> div > .oneForAll', $container);
	$eachSideContainer = $('> div > .eachSide', $container);

	updateActiveSide();

	if (specifiedSides) {
		$('> li', $detailToggleContainer).eq(1).addClass('active');

		oneForAllValues = values[activeSide];
	} else {
		$('> li', $detailToggleContainer).eq(0).addClass('active');

		oneForAllValues = values;
	}

	['top', 'right', 'bottom', 'left'].map(function (side) {
		var $div;

		if ($.inArray(side + 'Side', forbidden) != -1) {
			forbidenSideCount += 1

			return;
		}

		$div = $('<div />')
			.addClass('propertySubsection ' + side + 'Side')
			.html(
				side[0].toUpperCase() + side.substr(1) + ': ' +
				generateInputTemplate(specifiedSides ? values[side] : values)
			)
			.data('borderSide', side)
			.appendTo($eachSideContainer);

		if (setColor)
			rendering.activeColorPickers.push(
				$('input.spectrumPicker', $div).spectrum(
					spectrumSettings(
						(specifiedSides ? values[side].color : values.color),
						spectrumCallback(side)
					)
				)
			);
	});

	if (forbidenSideCount >= 3)
		$detailToggleContainer.css('display', 'none');
	else
		$oneForAllContainer.append(generateInputTemplate(oneForAllValues));

	if (setColor) {
		rendering.activeColorPickers.push(
			$('input.spectrumPicker', $oneForAllContainer).spectrum(
				spectrumSettings(
					(specifiedSides ? values[activeSide].color : values.color),
					spectrumCallback(activeSide)
				)
			)
		);

		$('.propertySubsection.color', $container).on('disabling', function () {
			$('input.spectrumPicker', $container).spectrum('hide');
		});
	}

	if (specifiedSides || forbidenSideCount >= 3)
		$oneForAllContainer.css('display', 'none');
	else
		$eachSideContainer.css('display', 'none');

	if (setWidth) {
		$('input.width', $container)
			.on('keydown', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					width,
					unit;

				if (e.which != 38 && e.which != 40)
					return;

				if (specifiedSides)
					unit = states[currentState].values[$this.parents().eq(1).data('borderSide')].width.unit;
				else
					unit = states[currentState].values.width.unit;

				if (oldWidth == '')
					width = 0
				else {
					if (unit == 'px')
						width = parseInt(oldWidth, 10);
					else
						width = parseFloat(oldWidth, 10);
				}

				switch (e.which) {
				case 38:
					width += 1;
					break;

				case 40:
					width -= 1;

					if (width < 0)
						width = 0;
					break;
				}

				$this
					.val(width)
					.data('stepChange', true);

				if (specifiedSides)
					states[currentState].values[$this.parents().eq(1).data('borderSide')].width.value = width;
				else
					states[currentState].values.width.value = width;

				Style.updateActiveSubjectStyle();
			})
			.on('keyup change', function (e) {
				var $this = $(this),
					oldWidth = $this.val(),
					endingWithDot = false,
					width,
					inputWidth = '',
					unit;

				if (specifiedSides)
					unit = states[currentState].values[$this.parents().eq(1).data('borderSide')].width.unit;
				else
					unit = states[currentState].values.width.unit;

				if (unit == 'px')
					width = parseInt(oldWidth, 10);
				else {
					endingWithDot = oldWidth[oldWidth.length - 1] == '.';
					width = parseFloat(oldWidth, 10);
				}

				if (isNaN(width) || typeof width != 'number' || width < 0)
					width = 0;

				if ($this.data('stepChange') == true || oldWidth == '0' || (e.type != 'keyup' || width != 0)) {
					$this.data('stepChange', false);
					inputWidth = width + (endingWithDot ? '.' : '');
				}

				$this.val(inputWidth);

				if (specifiedSides)
					states[currentState].values[$this.parents().eq(1).data('borderSide')].width.value = width;
				else
					states[currentState].values.width.value = width;

				Style.updateActiveSubjectStyle();
			});

		$('select.widthUnit', $container).on('keydown keyup change', function () {
			var $this = $(this),
				value = $this.val();

			if (specifiedSides)
				states[currentState].values[$this.parents().eq(1).data('borderSide')].width.unit = value;
			else
				states[currentState].values.width.unit = value;

			Style.updateActiveSubjectStyle();
		});
	}

	if (setStyle)
		$('select.style', $container).on('keydown keyup change', function () {
			var $this = $(this),
				value = $this.val();

			if (specifiedSides)
				states[currentState].values[$this.parents().eq(1).data('borderSide')].style = value;
			else
				states[currentState].values.style = value;

			Style.updateActiveSubjectStyle();
		});

	$detailToggleContainer.on('click', '> li', function () {
		var $clicked = $(this),
			oldValues,
			newValues;

		if ($clicked.hasClass('active'))
			return;

		$clicked
			.addClass('active')
			.siblings()
				.removeClass('active');

		oldValues = $.extend(true, {}, states[currentState].values);

		specifiedSides = $clicked.index() == 1;

		if (specifiedSides) {
			states[currentState].values = {
				top: $.extend(true, {}, oldValues),
				right: $.extend(true, {}, oldValues),
				bottom: $.extend(true, {}, oldValues),
				left: $.extend(true, {}, oldValues)
			};

			if (setColor) {
				$('input.spectrumPicker', $oneForAllContainer).spectrum('hide');

				$('input.spectrumPicker', $eachSideContainer).spectrum('set', oldValues.color);
			}

			if (setWidth) {
				$('input.width', $eachSideContainer).val(oldValues.width.value);
				$('select.widthUnit option[value="' + oldValues.width.unit + '"]', $eachSideContainer).prop('selected', true);
			}

			if (setStyle)
				$('select.style option[value="' + oldValues.style + '"]', $eachSideContainer).prop('selected', true);

			$oneForAllContainer.css('display', 'none');
			$eachSideContainer.css('display', '');
		} else {
			updateActiveSide();
			newValues = oldValues[activeSide];

			states[currentState].values = newValues;

			if (setColor) {
				$('input.spectrumPicker', $eachSideContainer).spectrum('hide');

				$('input.spectrumPicker', $oneForAllContainer).spectrum('set', newValues.color);
			}

			if (setWidth) {
				$('input.width', $oneForAllContainer).val(newValues.width.value);
				$('select.widthUnit option[value="' + newValues.width.unit + '"]', $oneForAllContainer)[0].selected = true;
			}

			if (setStyle)
				$('select.style option[value="' + newValues.style + '"]', $oneForAllContainer)[0].selected = true;

			$oneForAllContainer.css('display', '');
			$eachSideContainer.css('display', 'none');

			Style.updateActiveSubjectStyle();
		}

		$styleEditorContainer.tinyscrollbar_update('relative');
	});
};

propertyTypeSubsesctions['borderRadius'] = [
	{
		id: 'topLeft',
		name: 'Top left'
	},
	{
		id: 'topRight',
		name: 'Top right'
	},
	{
		id: 'bottomLeft',
		name: 'Bottom left'
	},
	{
		id: 'bottomRight',
		name: 'Bottom right'
	},
	{
		id: 'second',
		name: 'Second radius'
	}
];

Style.generatePropertyEditorHtml.borderRadius = function ($container, forbidden, states, currentState, metaVersion) {
	var $detailToggleContainer = $('<ul class="assignmentStyleSelection"><li><span>Uniform radius</span></li><li><span>Specify each corner</span></li></ul>'),
		$oneForAllContainer,
		$eachCornerContainer,
		$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar'),

		values = states[currentState].values,
		oneForAllValues,

		specifiedCorners = !(values.first != undefined),

		setSecond = $.inArray('second', forbidden) == -1,

		activeCorner = 'topLeft',
		forbidenCornerCount = 0,

		generateInputTemplate = function (vals) {
			var template = '';

			template = '<input type="text" class="first numeric" value="' + vals.first.value + '" /> ' +
				'<select class="firstUnit numericUnit">' +
					'<option value="px"' + (vals.first.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
					'<option value="%"' + (vals.first.unit == '%' ? ' selected="selected"' : '') + '>%</option>' +
					'<option value="em"' + (vals.first.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
				'</select>';

			if (setSecond)
				template += '<span class="propertySubsection second"> / ' +
					'<input type="text" class="second numeric" value="' + vals.second.value + '" /> ' +
					'<select class="secondUnit numericUnit">' +
						'<option value="px"' + (vals.second.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
						'<option value="%"' + (vals.second.unit == '%' ? ' selected="selected"' : '') + '>%</option>' +
						'<option value="em"' + (vals.second.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
					'</select> ' +
				'</span>';

			return template;
		},

		updateActiveCorner = function () {
			var cornerSet = false,
				run = function (ignoreDisabled) {
					['topLeft', 'topRight', 'bottomLeft', 'bottomRight'].map(function (corner) {
						if (
							$.inArray(corner, forbidden) != -1 ||
							(!ignoreDisabled && $.inArray(corner, states[currentState].disabled) != -1) ||
							typeof states[currentState].values[corner] != 'object'
						)
							return;

						activeCorner = corner;
						cornerSet = true;
					});
				};

			run();

			if (!cornerSet)
				run(true);
		},

		cornerNames = {
			'topLeft': 'Top left',
			'topRight': 'Top right',
			'bottomLeft': 'Bottom left',
			'bottomRight': 'Bottom right'
		};

	$container.append(
		$detailToggleContainer,
		'<div class="borderEditor radius"><div class="oneForAll"></div><div class="eachCorner"></div></div>'
	);

	$oneForAllContainer = $('> div > .oneForAll', $container);
	$eachCornerContainer = $('> div > .eachCorner', $container);

	updateActiveCorner();

	if (specifiedCorners) {
		$('> li', $detailToggleContainer).eq(1).addClass('active');

		oneForAllValues = values[activeCorner];
	} else {
		$('> li', $detailToggleContainer).eq(0).addClass('active');

		oneForAllValues = values;
	}

	['topLeft', 'topRight', 'bottomLeft', 'bottomRight'].map(function (corner) {
		var $div;

		if ($.inArray(corner, forbidden) != -1) {
			forbidenCornerCount += 1

			return;
		}

		$div = $('<div />')
			.addClass('propertySubsection cornerSubsectionContainer ' + corner)
			.html(
				cornerNames[corner] + ': ' +
				generateInputTemplate(specifiedCorners ? values[corner] : values)
			)
			.data('borderRadiusCorner', corner)
			.appendTo($eachCornerContainer);
	});

	if (forbidenCornerCount > 2)
		$detailToggleContainer.css('display', 'none');
	else
		$oneForAllContainer.append(generateInputTemplate(oneForAllValues));

	if (specifiedCorners || forbidenCornerCount > 2)
		$oneForAllContainer.css('display', 'none');
	else
		$eachCornerContainer.css('display', 'none');

	$('input.numeric', $container)
		.on('keydown', function (e) {
			var $this = $(this),
				oldNumber = $this.val(),
				number,
				unit,
				field = $this.hasClass('first') ? 'first' : 'second',
				side;

			if (e.which != 38 && e.which != 40)
				return;

			if (specifiedCorners) {
				side = $this.parents().filter('.cornerSubsectionContainer').data('borderRadiusCorner');
				unit = states[currentState].values[side][field].unit;
			} else
				unit = states[currentState].values[field].unit;

			if (oldNumber == '')
				number = 0
			else {
				if (unit == 'px')
					number = parseInt(oldNumber, 10);
				else
					number = parseFloat(oldNumber, 10);
			}

			switch (e.which) {
			case 38:
				number += 1;
				break;

			case 40:
				number -= 1;

				if (number < 0)
					number = 0;
				break;
			}

			$this
				.val(number)
				.data('stepChange', true);

			if (specifiedCorners)
				states[currentState].values[side][field].value = number;
			else
				states[currentState].values[field].value = number;

			Style.updateActiveSubjectStyle();
		})
		.on('keyup change', function (e) {
			var $this = $(this),
				oldNumber = $this.val(),
				endingWithDot = false,
				number,
				inputNumber = '',
				unit,
				field = $this.hasClass('first') ? 'first' : 'second',
				side;

			if (specifiedCorners) {
				side = $this.parents().filter('.cornerSubsectionContainer').data('borderRadiusCorner');
				unit = states[currentState].values[side][field].unit;
			} else
				unit = states[currentState].values[field].unit;

			if (unit == 'px')
				number = parseInt(oldNumber, 10);
			else {
				endingWithDot = oldNumber[oldNumber.length - 1] == '.';
				number = parseFloat(oldNumber, 10);
			}

			if (isNaN(number) || typeof number != 'number' || number < 0)
				number = 0;

			if ($this.data('stepChange') == true || oldNumber == '0' || (e.type != 'keyup' || number != 0)) {
				$this.data('stepChange', false);
				inputNumber = number + (endingWithDot ? '.' : '');
			}

			$this.val(inputNumber);

			if (specifiedCorners)
				states[currentState].values[side][field].value = number;
			else
				states[currentState].values[field].value = number;

			Style.updateActiveSubjectStyle();
		});

	$('select.numericUnit', $container).on('keydown keyup change', function () {
		var $this = $(this),
			field = $this.hasClass('firstUnit') ? 'first' : 'second',
			value = $this.val();

		if (specifiedCorners)
			states[currentState].values[$this.parents().filter('.cornerSubsectionContainer').data('borderRadiusCorner')][field].unit = value;
		else
			states[currentState].values[field].unit = value;

		Style.updateActiveSubjectStyle();
	});

	$detailToggleContainer.on('click', '> li', function () {
		var $clicked = $(this),
			oldValues,
			newValues;

		if ($clicked.hasClass('active'))
			return;

		$clicked
			.addClass('active')
			.siblings()
				.removeClass('active');

		oldValues = $.extend(true, {}, states[currentState].values);

		specifiedCorners = $clicked.index() == 1;

		if (specifiedCorners) {
			states[currentState].values = {
				topLeft: $.extend(true, {}, oldValues),
				topRight: $.extend(true, {}, oldValues),
				bottomLeft: $.extend(true, {}, oldValues),
				bottomRight: $.extend(true, {}, oldValues)
			};

			$('input.first', $eachCornerContainer).val(oldValues.first.value);
			$('select.firstUnit option[value="' + oldValues.first.unit + '"]', $eachCornerContainer).prop('selected', true);

			if (setSecond) {
				$('input.second', $eachCornerContainer).val(oldValues.second.value);
				$('select.secondUnit option[value="' + oldValues.second.unit + '"]', $eachCornerContainer).prop('selected', true);
			}

			$oneForAllContainer.css('display', 'none');
			$eachCornerContainer.css('display', '');
		} else {
			updateActiveCorner();
			newValues = oldValues[activeCorner];

			states[currentState].values = newValues;

			$('input.first', $oneForAllContainer).val(newValues.first.value);
			$('select.firstUnit option[value="' + newValues.first.unit + '"]', $oneForAllContainer).prop('selected', true);

			if (setSecond) {
				$('input.second', $oneForAllContainer).val(newValues.second.value);
				$('select.secondUnit option[value="' + newValues.second.unit + '"]', $oneForAllContainer).prop('selected', true);
			}

			$oneForAllContainer.css('display', '');
			$eachCornerContainer.css('display', 'none');

			Style.updateActiveSubjectStyle();
		}

		$styleEditorContainer.tinyscrollbar_update('relative');
	});
};

propertyTypeSubsesctions['boxShadow'] = [
	{
		id: 'shadows',
		name: 'Shadows'
	}
];

Style.generatePropertyEditorHtml.boxShadow = function ($container, forbidden, states, currentState, metaVersion) {
	var values = states[currentState].values,

		spectrumShadowCallback = function ($shadowContainer) {
			return function (color) {
				if (!$.contains(document.documentElement, $shadowContainer[0]))
					return;

				states[currentState].values.list[$shadowContainer.index()].color = color;

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
					'<div>Blur: ' +
						'<input type="text" class="blur numeric" value="' + shadow.blur.value + '" /> ' +
						'<select class="blurUnit numericUnit">' +
							'<option value="px"' + (shadow.blur.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
							'<option value="em"' + (shadow.blur.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'</select> Spread: ' +
						'<input type="text" class="spread numeric" value="' + shadow.spread.value + '" /> ' +
						'<select class="spreadUnit numericUnit">' +
							'<option value="px"' + (shadow.spread.unit == 'px' ? ' selected="selected"' : '') + '>px</option>' +
							'<option value="em"' + (shadow.spread.unit == 'em' ? ' selected="selected"' : '') + '>em</option>' +
						'</select> ' +
						'<input type="text" class="spectrumPicker" />' +
					'</div>' +
					'<div><label><input type="checkbox" class="inset"' + (shadow.inset ? ' checked="checked"' : '') + ' />Inset</label></div>' +
				'</div>';
		},

		initShadowEditor = function (shadow) {
			var $shadowEditor = $(generateShadowEditor(shadow)).appendTo($shadowsList);

			rendering.activeColorPickers.push(
				$('> div > input.spectrumPicker', $shadowEditor).spectrum(
					spectrumSettings(
						shadow.color,
						spectrumShadowCallback($shadowEditor)
					)
				)
			);
		},

		$styleEditorContainer = $container.parents('.styleEditor > .editor.standardScrollbar'),

		$shadowsContainer,
		$shadowsContentWrapper,
		$shadowsContent,
		$noShadowsMessage,
		$addShadow,
		$shadowsList,
		$shadowsTrigger;

	if ($.inArray('shadows', forbidden) == -1) {
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
			states[currentState].values.show = this.checked;

			if (states[currentState].values.list && states[currentState].values.list.length > 0) {
				$noShadowsMessage.css('display', 'none');
				$shadowsList.css('display', 'block');
			} else {
				$noShadowsMessage.css('display', 'block');
				$shadowsList.css('display', 'none');
			}

			Style.updateActiveSubjectStyle();
		});

		$noShadowsMessage.css('display', 'block');
		$shadowsList.css('display', 'none');
		$shadowsTrigger[0].checked = false;

		if (typeof values == 'object') {
			if (values.show && values.list.length > 0) {
				$shadowsContainer.addClass('expanded');
				$shadowsTrigger[0].checked = true;
				$shadowsContentWrapper.css('display', 'block');
				$noShadowsMessage.css('display', 'none');
				$shadowsList.css('display', 'block');
			}

			if (values.list.length > 0) {
				$.each(values.list, function (i, shadow) { initShadowEditor(shadow); });
			}
		}

		$shadowsList
			.on('click', '> div > div > span.remove', function () {
				var $shadowEditorContainer = $(this).parents().eq(1);

				$('> div > input.spectrumPicker', $shadowEditorContainer).spectrum('destroy');
				states[currentState].values.list.splice($shadowEditorContainer.index(), 1);
				$shadowEditorContainer.remove();

				if (states[currentState].values.list.length == 0) {
					$noShadowsMessage.css('display', 'block');
					$shadowsList.css('display', 'none');
				}

				Style.updateActiveSubjectStyle();

				$styleEditorContainer.tinyscrollbar_update('relative');
			})
			.on('change', '> div input.inset', function () {
				states[currentState].values.list[$(this).parents().eq(2).index()].inset = this.checked;

				Style.updateActiveSubjectStyle();
			})
			.on('keydown', 'input.numeric', function (e) {
				var $this = $(this),
					oldValue = $this.val(),
					offset,
					option = $this.hasClass('blur') ? 'blur' :
						($this.hasClass('spread') ? 'spread' :
							($this.hasClass('x') ? 'x' : 'y')),
					optionValues = states[currentState].values.list[$this.parents().eq(1).index()][option];

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

					if (option == 'blur' && offset < 0)
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
					option = $this.hasClass('blur') ? 'blur' :
						($this.hasClass('spread') ? 'spread' :
							($this.hasClass('x') ? 'x' : 'y')),
					optionValues = states[currentState].values.list[$this.parents().eq(1).index()][option];

				if (optionValues.unit == 'px')
					offset = parseInt(oldWidth, 10);
				else {
					endingWithDot = oldWidth[oldWidth.length - 1] == '.';
					offset = parseFloat(oldWidth, 10);
				}

				if (isNaN(offset) || typeof offset != 'number' || (option == 'blur' && offset < 0))
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
					option = $this.hasClass('blur') ? 'blur' :
						($this.hasClass('spread') ? 'spread' :
							($this.hasClass('x') ? 'x' : 'y'));

				states[currentState].values.list[$this.parents().eq(1).index()][option].unit = $this.val();

				Style.updateActiveSubjectStyle();
			});

		$addShadow
			.on('click', function () {
				var shadow = {
					"inset": false,
					"x": {
						"value": 1,
						"unit": "px"
					},
					"y": {
						"value": 1,
						"unit": "px"
					},
					"blur": {
						"value": 3,
						"unit": "px"
					},
					"spread": {
						"value": 0,
						"unit": "px"
					},
					"color": "#000000"
				};

				if (states[currentState].values.list.length == 0) {
					$noShadowsMessage.css('display', 'none');
					$shadowsList.css('display', 'block');
				}

				states[currentState].values.list.push(shadow);

				initShadowEditor(shadow);

				Style.updateActiveSubjectStyle();

				$styleEditorContainer.tinyscrollbar_update('relative');
			});

		$('> .propertySubsection.shadows', $container).on('disabling', function () {
			$('input.spectrumPicker', $shadowsList).spectrum('hide');
		});
	}
};
propertyTypeSubsesctions['opacity'] = [
	{
		id: 'opacity',
		name: 'Opacity'
	}
];

Style.generatePropertyEditorHtml.opacity = function ($container, forbidden, states, currentState, metaVersion) {
	if ($.inArray('opacity', forbidden) == -1) {
		$container.append(
			'<div class="propertySubsection opacity">Opacity: ' +
				'<input type="text" class="opacity numeric" value="" /> %' +
			'</div>'
		);

		$('> div > input.opacity', $container)
			.val(Math.round(states[currentState].values.opacity * 100))
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
					value += 5;
					break;

				case 40:
					value -= 5;
					break;
				}

				if (value < 0)
					value = 0;
				else if (value > 100)
					value = 100;

				$this
					.val(value)
					.data('stepChange', true);

				states[currentState].values.opacity = Math.round(value) / 100;

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
				else if (value > 100)
					value = 100;

				if ($this.data('stepChange') == true || oldWidth == '0' || e.type != 'keyup' || value != 0) {
					$this.data('stepChange', false);
					newValue = value;
				}

				$this.val(newValue);

				states[currentState].values.opacity = Math.round(value) / 100;

				Style.updateActiveSubjectStyle();
			});
	}
};

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

Utils.html = {
	encode: function (s) {
		return $('<p />').text(s).html();
	},
	decode: function (s) {
		return $('<p />').html(s).text();
	}
};

Utils.css = {
	removeClassContaining: function ($elements, classSubstring) {
		$elements.each(function () {
			var $element = $(this),
				classes = $.map($element.attr('class').split(' '), function(cssClass) {
					if (cssClass.indexOf(classSubstring) === -1)
						return cssClass;
					else
						return undefined;
				});

			$element.attr('class', classes.join(' '));
		});
	},
	generateColorText: function (color) {
		if (color == null || !color.isValid() || color.getAlpha() == 0)
			return 'transparent';

		if (color.getAlpha() == 1)
			return color.toHexString();

		return color.toRgbString();
	},
	filterColorText: function (color) {
		return Utils.css.generateColorText(tinycolor(color));
	}
};

Utils.string = {
	random: function (length) {
		var result = '',
			chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
			i = length;

		for (; i > 0; --i)
			result += chars[Math.round(Math.random() * (chars.length - 1))];

		return result;
	}
};

Utils.files = {
	readableFileSize: function (bytes) {
		var i = 0;

		bytes = parseInt(bytes, 10);

		while (bytes > 1023) {
			i += 1;
			bytes = bytes / 1024;
		}

		bytes = bytes.toFixed(2);

		switch (i) {
		case 1:
			return bytes + ' KB';

		case 2:
			return bytes + ' MB';

		case 3:
			return bytes + ' GB';

		case 4:
			return bytes + ' PB';

		default:
			return bytes + ' B';
		}
	}
};

Utils.array = {
	removeItem: function (items, a) {
		var i = $.inArray(items, a);

		while (i != -1) {
			a.splice(i, 1);
			i = $.inArray(items, a);
		}

		return a;
	},
	containsArrayElement: function (needleArray, haystackArray) {
		var result = false;

		$.each(haystackArray, function (i, value) {
			if ($.inArray(value, needleArray) == -1)
				return;

			result = true;
			return false;
		});

		return result;
	}
};

Utils.style = {
	getNameAndColors: function (style, templateGroup) {
		var nameAndColors = style.templateGroups[templateGroup];

		return nameAndColors ? nameAndColors : style.templateGroups["default"];
	},
	replaceCssTokens: function (css, styleClass, themeName, assetsRootPath) {
		if (typeof css != 'string')
			return '';

		return css
			.replace(/_-StyleClass-_/g, styleClass)
			.replace(/_-ThemeName-_/g, themeName)
			.replace(/_-StyleAssetsClientRoot-_/g, assetsRootPath);
	},
	getImportUrlFromFont: function (customFonts, fontName) {
		var returnUrl = undefined;

		$.each(customFonts, function (i, customFont) {
			if ($.isPlainObject(customFont) && customFont.name == fontName) {
				returnUrl = customFont.importUrl;
				return false;
			}
		});

		return returnUrl;
	},
	hasSubCollection: function (targetSubCollection, subCollections) {
		if (typeof subCollections != 'string' || subCollections == '')
			return false;

		var found = false;

		$.each(subCollections.split('|'), function (i, collection) {
			if (collection.trim() == targetSubCollection) {
				found = true;
				return false;
			}
		});

		return found;
	}
};
window.StyleWizard = function () {
	var self = this,
		skinWizardHtml = '';

	collections = arguments.length > 0 ? arguments[0] : [];
	$.extend(true, collectionsBackup, collections);

	config = $.extend(true, {
			defaultFonts: [
				{
					name: 'Arial'
				},
				{
					name: 'Arial Black'
				},
				{
					name: 'Verdana'
				},
				{
					name: 'Times New Roman'
				},
				{
					name: 'Avant Garde'
				},
				{
					name: 'Georgia'
				},
				{
					name: 'Courier New'
				},
				{
					name: 'Impact'
				},
				{
					name: 'Tahoma'
				},
				{
					name: 'Comic Sans MS'
				},
				{
					name: 'Lucida Console'
				}
			],
			moduleId: 0,
			backend: '',
			localization: {}
		},
		(arguments.length > 1 ? arguments[1] : {}));

	if (styleWizardInitialized)
		return;

	styleWizardInitialized = true;

	skinWizardHtml = '<div id="EasyDNNstyleWizard">' +
			'<div class="headerWrapper">' +
				'<div class="logos">' +
					'<a class="eds" target="_blank" href="http://www.easydnnsolutions.com/" title="EasyDNNSolutions.com">EasyDNNSolutions.com</a>' +
					'<a class="styleWizard" target="_blank" href="http://www.easydnnsolutions.com/modules/easydnnstylewizard/" title="EasyDNNSolutions StyleWizard">EasyDNNstyleWizard</a>' +
				'</div>' +
			'</div>' +
			'<div class="styleSubjectSelectionWrapper" style="display: none;">' +
				'<select></select>' +
			'</div>' +
			'<div class="styleSubjectsWrapper" style="display: none;"></div>' +
			'<div class="introContainer standardScrollbar">' +
				'<div class="viewport"><div class="overview"><div class="intro"></div></div></div>' +
				'<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>' +
			'</div>' +
			'<div class="footerWrapper">' +
				'<div class="actions">' +
					'<span class="action save">Save</span>' +
					'<select class="collectionSaveSelect"></select>' +
				'</div>' +
			'</div>' +
		'</div>';

	$styleWizard = $(skinWizardHtml).appendTo('body');

	$interfaceSideToggle = $('<span id="EasyDNNstyleWizardSideToggle" title="Switch sides">Switch sides</span>').appendTo('body');
	$collectionListContainer = $('<ol id="EasyDNNstyleWizardCollections"></ol>').appendTo('body');
	$interfaceToggle = $('<div id="EasyDNNstyleWizardToggle"><span></span>Show</div>').appendTo('body');
	$headerWrapper = $('> .headerWrapper', $styleWizard);
	$footerWrapper = $('> .footerWrapper', $styleWizard);
	$styleSubjectSelectionWrapper = $('> .styleSubjectSelectionWrapper', $styleWizard);
	$styleSubjectsWrapper = $('> .styleSubjectsWrapper', $styleWizard);
	$introContainer = $('> .introContainer', $styleWizard);
	$collectionSaveSelect = $('> .actions > .collectionSaveSelect', $footerWrapper);

	rendering.baseWrapper.outerWidth = $styleWizard.outerWidth();

	interfaceStateCookie += config.moduleId;

	if (collections.length > 1)
		$collectionSaveSelect
			.append('<option value="all">All</option>')
			.addClass('show');

	$.each(collections, function (i, collection) {
		if (collections.length > 1)
			$collectionSaveSelect.append(
				'<option value="' + collection.type + '">' + collection.name + '</option>'
			);

		rendering.active.subjects.push(0);

		$('<li class="' + collection.type + '"><span>' + collection.name + '</span></li>')
			.data('type', collection.type)
			.appendTo($collectionListContainer);
	});

	$collectionListContainer.on('click', '> li', function () {
		var $clicked = $(this),
			collectionIndex = $clicked.index();

		if (rendering.active.collection == collectionIndex)
			return;

		rendering.active.collection = collectionIndex;
		Core.openActiveCollection();
	});

	$introContainer.tinyscrollbar();

	Core.resize();
	$window
		.resize(function () {
			Core.resize();
		})
		.scroll(function () {
			$.each(rendering.activeColorPickers, function (i, $picker) {
				$picker.spectrum('reflow');
			});
		});

	rendering.interfaceSide = 'right';

	try {
		var savedState = JSON.parse($.cookie(interfaceStateCookie));
		rendering.interfaceSide = savedState.side;
		rendering.hidden = savedState.hidden;
	} catch (e) {}

	if (rendering.interfaceSide == 'right') {
		$interfaceSideToggle.addClass('rightSideInterface');
		$interfaceToggle.addClass('rightSideInterface');
		$collectionListContainer.addClass('rightSideInterface');
		$styleWizard.addClass('rightSideInterface');
	}

	Core.toggleInterface(!rendering.hidden);

	$interfaceToggle.on('click', function () {
		Core.toggleInterface(rendering.hidden, true);
	});

	setTimeout(function () {
		$interfaceSideToggle.addClass('animateVisibility');
		$styleWizard.addClass('animateVisibility');
		$collectionListContainer.addClass('animateVisibility');
		$interfaceToggle.addClass('animateVisibility')
	}, 200);

	var sideToggleInProggress = false;
	$interfaceSideToggle
		.on('click', function () {
			if (sideToggleInProggress)
				return;

			sideToggleInProggress = true;

			Core.toggleInterface(false);

			setTimeout(
				function () {
					$styleWizard.removeClass('animateVisibility');
					$collectionListContainer.removeClass('animateVisibility');
					$interfaceToggle.removeClass('animateVisibility');
					$interfaceSideToggle.removeClass('animateVisibility');

					if (rendering.interfaceSide == 'left') {
						rendering.interfaceSide = 'right';
						$interfaceSideToggle.addClass('rightSideInterface');
						$interfaceToggle.addClass('rightSideInterface');
						$collectionListContainer.addClass('rightSideInterface');
						$styleWizard.addClass('rightSideInterface');
					} else {
						rendering.interfaceSide = 'left';
						$interfaceSideToggle.removeClass('rightSideInterface');
						$interfaceToggle.removeClass('rightSideInterface');
						$collectionListContainer.removeClass('rightSideInterface');
						$styleWizard.removeClass('rightSideInterface');
					}

					setTimeout(
						function () {
							$styleWizard.addClass('animateVisibility');
							$collectionListContainer.addClass('animateVisibility');
							$interfaceToggle.addClass('animateVisibility');
							$interfaceSideToggle.addClass('animateVisibility');

							Core.toggleInterface(true);
							sideToggleInProggress = false;

							Core.saveInterfaceState();
						},
						200
					);
				},
				200
			);
		});

	$('> select', $styleSubjectSelectionWrapper).on('change', function () {
		rendering.active.subjects[rendering.active.collection] = this.selectedIndex;
		Core.openActiveSubject();
	});

	$('> .actions > .save', $footerWrapper).on('click', function () {
		var saveCollection = $collectionSaveSelect.hasClass('show') ? $collectionSaveSelect.val() : 'all',
			$saveOverlay,

			requestsCompleted = function () {
				var $mainMessage;

				if (!minimalTimeoutPassed || savingInProgress.length != 0)
					return;

				$mainMessage = $('p.mainMessage', $saveOverlay);

				if (saveErrorOccurred)
					$mainMessage
						.addClass('error')
						.text(saveErrorMessage);
				else
					$mainMessage
						.addClass('success')
						.text('All styles saved successfully');

				$('> div', $saveOverlay).append('<div class="actions"><span>Ok</span></div>');
			},

			minimalTimeout,
			minimalTimeoutPassed = false,

			saveErrorOccurred = false,
			saveErrorMessage = 'An error occured while saving',

			removingOverlay = false;

		if (savingInProgress.length > 0)
			return;

		$saveOverlay = $(
				'<div id="EasyDNNstyleWizardModalWrapper" class="save">' +
					'<div>' +
						'<p class="mainMessage">Saving styles...</p>' +
					'</div>' +
				'</div>'
			)
			.appendTo('body')
			.fadeTo(200, 1)
			.on('click', '> div > .actions > span', function () {
				if (removingOverlay)
					return;

				removingOverlay = true;

				$saveOverlay.fadeTo(200, 0, function () {
					$saveOverlay.remove();
				});
			});

		minimalTimeout = setTimeout(
			function () {
				minimalTimeoutPassed = true;

				requestsCompleted();
			},
			1000
		);

		$.each(collections, function (i, collection) {
			if (saveCollection != 'all' && collection.type != saveCollection)
				return;

			savingInProgress.push(collection.type);

			$.ajax({
				type: 'post',
				data: {
					collection: collection.type,
					action: 'saveCollection',
					collectionJson: JSON.stringify(collection)
				},
				dataType: 'json',
				success: function (response) {
					if (response.success == undefined || !response.success)
						saveErrorOccurred = true;
				},
				error: function (xhr) {
					if (xhr.status == 403)
						saveErrorMessage = 'You don\'t have permission to make changes';

					saveErrorOccurred = true;
				},
				complete: function () {
					savingInProgress.splice(savingInProgress.indexOf(collection.type), 1);

					requestsCompleted();
				},
				timeout: 1200000,
				url: config.backend
			});
		});
	});

	$styleSubjectsWrapper
		.on('click', '> div > .edStyleWizard_slider > .styleSelection .styleTypeSelection > li', function () {
			var $clicked = $(this);

			if ($clicked.hasClass('active'))
				return;

			$clicked
				.addClass('active')
				.siblings()
					.removeClass('active');

			$('>', $clicked.parent().siblings('.styleTypes'))
				.css('display', 'none')
				.eq($clicked.index())
					.css('display', 'block')
					.find('li')
						.removeClass('actionsOverlayActive');

			$clicked.parents('.edStyleWizard_slider > .styleSelection.standardScrollbar').tinyscrollbar_update('relative');
		})
		.on('click', '> div > .edStyleWizard_slider .additionalResourceSeletion > div > div.contentWrapper > div', function () {
			var collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				$this = $(this),
				$optionsContainer = $this.parent(),
				selectedOptionId = $this.data('optionId'),

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				styleGroup = collection.styleGroups[subject.styleGroup],

				sectionId = $optionsContainer.parent().data('sectionId'),
				section = styleGroup.themeObjectSettings.additionalResources[sectionId],

				activeOptions = [],

				baseResourceId =
					'eds_' +
					collection.type +
					'_' +
					subject.styleGroup +
					'_' +
					subject.template +
					'_additionalResource_' +
					sectionId +
					'_',

				headHtml = '',
				activeOptionClass = 'activeOption';

			if (section.singleSelection) {
				if ($this.hasClass(activeOptionClass))
					return;

				$this
					.addClass(activeOptionClass)
					.siblings()
						.removeClass(activeOptionClass);
			} else
				$this.toggleClass(activeOptionClass);

			$('head > link[id^="' + baseResourceId + '"]').remove();

			if (selectedOptionId) {
				if (section.singleSelection)
					activeOptions.push(selectedOptionId);
				else {
					$('>', $optionsContainer).each(function (i, div) {
						var $div = $(div);

						if ($div.hasClass(activeOptionClass)) {
							activeOptions.push($div.data('optionId'));
						}
					});
				}
			}

			if (!subject.activeThemeObjectSettings)
				subject.activeThemeObjectSettings = {};

			if (!subject.activeThemeObjectSettings.additionalResources)
				subject.activeThemeObjectSettings.additionalResources = {};

			subject.activeThemeObjectSettings.additionalResources[sectionId] = activeOptions;

			$.each(activeOptions, function (i, optionId) {
				var option = section.options[optionId],
					i,
					l;

				if (option && $.isArray(option.css)) {
					i = 0;
					l = option.css.length;
					for (; i < l; i++) {
						headHtml +=
							'<link id="' +
							baseResourceId +
							optionId +
							'_css_' +
							i +
							'" rel="stylesheet" type="text/css" href="' +
							styleGroup.styleAssetsClientRoot +
							option.css[i] +
							'" />';
					}
				}
			});

			$('head').append(headHtml);
		})
		.on('click', '> div > .edStyleWizard_slider .variableContentSeletion > div > div.contentWrapper > div', function () {
			var collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				$this = $(this),
				$optionsContainer = $this.parent(),
				$allOptions = $('>', $optionsContainer),
				selectedOptionId = $this.data('optionId'),

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				styleGroup = collection.styleGroups[subject.styleGroup],

				sectionId = $optionsContainer.parent().data('sectionId'),

				initiallySelectedClass = 'initiallySelected',
				showRefreshWarningClass = 'showRefreshWarning',
				activeOptionClass = 'activeOption';

			if ($this.hasClass(activeOptionClass))
				return;

			if (subject.activeThemeObjectSettings == undefined)
				subject.activeThemeObjectSettings = {};

			if (subject.activeThemeObjectSettings.variableContentSections == undefined)
				subject.activeThemeObjectSettings.variableContentSections = {};

			subject.activeThemeObjectSettings.variableContentSections[sectionId] = selectedOptionId;

			$allOptions.removeClass(showRefreshWarningClass);

			if (!$this.hasClass(initiallySelectedClass))
				$this.addClass(showRefreshWarningClass);

			$allOptions.removeClass(activeOptionClass);
			$this.addClass(activeOptionClass);
		})
		.on('click', '> div > .edStyleWizard_slider .styleTypes > div > ol > li > div > .standardOverlay, > div > .edStyleWizard_slider .styleTypes > div > ol > li > span', function () {
			var collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				$this = $(this),
				$li = this.tagName.toLowerCase() == 'span' ? $this.parent() : $this.parents().eq(1),
				styleType = $li.parents().eq(1).hasClass('predefined') ? 'predefined' : 'custom',
				styleId = $li.data('styleId'),

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				styleGroup,
				style,

				baseCss = '';

			$li.siblings().removeClass('actionsOverlayActive');

			if (subject.activeStyle.type == styleType && subject.activeStyle.id == styleId)
				return;

			subject.activeStyle.type = styleType;
			subject.activeStyle.id = styleId;

			styleGroup = collection.styleGroups[subject.styleGroup];
			style = styleGroup.styles[styleType][styleId];

			$('> div > ol > li', $li.parents().eq(2)).removeClass('active');
			$li.addClass('active');

			if (styleType == 'predefined')
				baseCss = style.baseCss;
			else
				baseCss = styleGroup.styles.predefined[style.originalStyleId].baseCss;

			if (typeof baseCss != 'string')
				baseCss = '';

			Style.changeSectionStyle({
				collectionType: collection.type,
				styleSwitchCriteria: subject.styleSwitchCriteria,
				styleGroup: subject.styleGroup,
				globalFontFamilies: styleGroup.customFontFamilies,
				template: subject.template,
				themeName: styleGroup.themeName,
				assetsRootPath: styleGroup.styleAssetsClientRoot,
				style: {
					type: styleType,
					id: styleId,
					definition: styleGroup.styleDefinitions,
					values: style.values,
					baseCss: baseCss
				},
				metaVersion: styleGroup.metaVersion
			});
		})
		.on('click', '> div > .edStyleWizard_slider .styleTypes > div > ol > li > div > .standardOverlay > .openActionsOverlay', function () {
			$(this).parents().eq(2)
				.addClass('actionsOverlayActive');

			return false;
		})
		.on('click', '> div > .edStyleWizard_slider .styleTypes > div > ol > li > div > .actionsOverlay > .action.close', function () {
			$(this).parents().eq(2)
				.removeClass('actionsOverlayActive');

			return false;
		})
		.on('click', '> div > .edStyleWizard_slider .styleTypes .actionsOverlay > .action.delete', function () {
			var $this = $(this),
				$li = $this.parents().eq(2),

				styleType = $li.parents().eq(1).hasClass('predefined') ? 'predefined' : 'custom',
				styleId = $li.data('styleId'),

				collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				styleGroup = collection.styleGroups[subject.styleGroup],

				$modalWrapper,
				$loadingMsg,
				$mainWrapper,
				$mainContent,
				$mainActions,
				$styleTypes = $('> .subject_' + collectionIndex + '_' + subjectIndex + ' > > .styleSelection .styleTypes', $styleSubjectsWrapper),
				$styleTypeSelection = $styleTypes.siblings('.styleTypeSelection'),

				updateMainWrapperPosition = function () {
					$mainWrapper.css('margin-top', - Math.ceil($mainWrapper.height() / 2));
				},

				styleUsageError = function () {
					$mainWrapper.addClass('show');
					$mainContent.html('<p class="error">An error occurred while checking where the style is used.</p>');
					$mainActions.html('<span class="checkUsageAgain">Try again</span><span class="cancel">Cancel</span>');

					updateMainWrapperPosition();
				},

				deleteConfirmationDialog = function (response) {
					$mainContent.html(response.dialogHtmlContent);
					$mainActions.html('<span class="deleteStyle">Confirm deletion</span><span class="cancel">Cancel</span>');
					$mainWrapper.addClass('show');

					updateMainWrapperPosition();
				},

				destroyOverlay = function () {
					$modalWrapper
						.stop(true)
						.fadeTo(
							200,
							0,
							function () {
								$modalWrapper.remove();
							}
						)
				},

				getStyleUsage = function () {
					$.ajax({
						data: {
							action: 'getStyleUsage',
							styleType: styleType,
							styleId: styleId,
							themeName: styleGroup.themeName,
							collectionPortalId: styleGroup.portalId,
							collection: collection.type
						},
						dataType: 'json',
						success: function (response) {
							if (response.success == undefined || !response.success) {
								styleUsageError();
								return;
							}

							deleteConfirmationDialog(response);
						},
						error: function () {
							styleUsageError();
						},
						timeout: 15000,
						url: config.backend
					});
				},

				deleteStyle = function () {
					$.ajax({
						data: {
							action: 'deleteStyle',
							styleId: styleId,
							themeName: styleGroup.themeName,
							collectionPortalId: styleGroup.portalId,
							collection: collection.type
						},
						dataType: 'json',
						success: function (response) {
							var baseCss = '',
								otherStyleType,
								styleTypeSwitched = false,
								defaultStyle;

							if (response.success == undefined || !response.success) {
								styleDeletionError();
								return;
							}

							$loadingMsg
								.text('The style was successfully deleted')
								.addClass('positive');

							updateMainWrapperPosition();

							if (subject.activeStyle.type == styleType && subject.activeStyle.id == styleId) {
								defaultStyle = styleGroup.styles['predefined']['default'];

								baseCss = typeof defaultStyle.baseCss == 'string';

								if (typeof baseCss != 'string')
									baseCss = '';

								subject.activeStyle = {
									type: 'predefined',
									id: 'default'
								};

								Style.changeSectionStyle({
									collectionType: collection.type,
									styleSwitchCriteria: subject.styleSwitchCriteria,
									styleGroup: subject.styleGroup,
									globalFontFamilies: styleGroup.customFontFamilies,
									template: subject.template,
									themeName: styleGroup.themeName,
									assetsRootPath: styleGroup.styleAssetsClientRoot,
									style: {
										type: 'predefined',
										id: 'default',
										definition: styleGroup.styleDefinitions,
										values: defaultStyle.values,
										baseCss: baseCss
									},
									metaVersion: styleGroup.metaVersion
								});

								if (styleType != 'predefined')
									styleTypeSwitched = true;

								$('> .predefined > ol > li.predefined_default', $styleTypes).addClass('active');
							}

							otherStyleType = styleType == 'custom' ? 'predefined' : 'custom';

							delete styleGroup.styles[styleType][styleId];

							if ($.isEmptyObject(styleGroup.styles[styleType])) {
								delete styleGroup.styles[styleType];
								styleTypeSwitched = true;

								$('> .' + styleType, $styleTypeSelection).css('display', 'none');
							}

							$('> .' + styleType + ' > ol > li.' + styleId, $styleTypes).remove();

							if (styleTypeSwitched) {
								$('> .' + otherStyleType, $styleTypes).css('display', 'block');
								$('> .' + styleType, $styleTypes).css('display', 'none');

								$('>', $styleTypeSelection)
									.removeClass('active')
									.filter('.' + otherStyleType)
										.addClass('active');
							}

							setTimeout(destroyOverlay, 2000);
						},
						error: function () {
							styleDeletionError();
						},
						timeout: 15000,
						url: config.backend
					});
				},

				styleDeletionError = function () {
					$mainContent.html('<p class="error">An error occurred while deleting the style.</p>');
					$mainActions.html('<span class="deleteStyle">Try again</span><span class="cancel">Cancel</span>');
					$mainWrapper.addClass('show');

					updateMainWrapperPosition();
				};

			$('body').append(
				'<div id="EasyDNNstyleWizardModalWrapper" class="deleteStyle">' +
					'<div class="loading"></div>' +
					'<div class="main">' +
						'<div class="content"></div>' +
						'<div class="actions"></div>' +
					'</div>' +
				'</div>'
			);

			$modalWrapper = $('#EasyDNNstyleWizardModalWrapper.deleteStyle');

			$loadingMsg = $('> .loading', $modalWrapper);
			$loadingMsg.text('Checking style usage...');
			$mainWrapper = $('> .main', $modalWrapper);
			$mainContent = $('> .content', $mainWrapper);
			$mainActions = $('> .actions', $mainWrapper);

			$mainActions
				.on('click', '> span.cancel', function () {
					destroyOverlay();
				})
				.on('click', '> span.checkUsageAgain', function () {
					$mainWrapper.removeClass('show');
					getStyleUsage();
				})
				.on('click', '> span.deleteStyle', function () {
					$mainWrapper.removeClass('show');
					deleteStyle();
				});

			getStyleUsage();
		})
		.on('click', '> div > .edStyleWizard_slider .styleTypes .actionsOverlay > .action.edit', function () {
			var $this = $(this),
				$parents = $this.parents(),
				$slider = $parents.filter('.styleSubjectsWrapper > div > div'),
				$li = $parents.eq(2),

				styleType = $li.parents().eq(1).hasClass('predefined') ? 'predefined' : 'custom',
				styleId = $li.data('styleId'),

				collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				collectionStyles = collection.styleGroups[subject.styleGroup].styles,
				style,
				$styleTypes = $('> .subject_' + collectionIndex + '_' + subjectIndex + ' > > .styleSelection .styleTypes', $styleSubjectsWrapper),

				$otherSubjectWrappers,

				nameAndColors;

			$('> > ol > li', $styleTypes).removeClass('active actionsOverlayActive');

			if (styleType == 'predefined') {
				styleId = Core.cloneStyle({
					collection: collectionIndex,
					subject: subjectIndex,
					type: styleType,
					id: styleId
				});
				styleType = 'custom';

				$('>', $styleTypes.siblings('.styleTypeSelection'))
					.removeClass('active')
					.css('display', '')
					.filter('.custom')
						.addClass('active');

				style = collectionStyles[styleType][styleId];

				nameAndColors = Utils.style.getNameAndColors(style, subject.templateGroup);

				$('>', $styleTypes)
					.css('display', 'none')
					.filter('.' + styleType)
						.css('display', 'block')
						.find('> ol')
							.append(Core.generateStyleListItem({
								name: nameAndColors.name,
								type: styleType,
								colors: nameAndColors.colors,
								active: true,
								id: styleId
							}));

				$otherSubjectWrappers = $('> div[class*=" subject_' + collectionIndex + '_"], > div[class^="subject_' + collectionIndex + '_"]', $styleSubjectsWrapper);

				$otherSubjectWrappers.each(function () {
					var $this = $(this),
						currentSubjectIndex = $this.data('subjectIndex'),
						currentSubject,
						$styleSelectionOverview,
						concatedTemplateGroups = [];

					if (currentSubjectIndex == subjectIndex)
						return;

					currentSubject = collection.subjects[currentSubjectIndex];

					if ($.isArray(currentSubject.additionalTemplateGroups))
						concatedTemplateGroups = currentSubject.additionalTemplateGroups;

					concatedTemplateGroups.push(currentSubject.templateGroup);

					if (
						currentSubject == undefined || (
							style.show &&
							!Utils.array.containsArrayElement(concatedTemplateGroups, style.show)
						)
					)
						return;

					$styleSelectionOverview = $('> > .styleSelection > .viewport > .overview', $this);

					$('> .styleTypeSelection > .custom', $styleSelectionOverview).css('display', '');
					$('> .styleTypes > .custom > ol', $styleSelectionOverview).append(
						Core.generateStyleListItem({
							name: nameAndColors.name,
							type: styleType,
							colors: nameAndColors.colors,
							active: false,
							id: styleId
						})
					);
				});

				$('> .styleSelection', $slider).tinyscrollbar_update('relative');
			} else {
				$li.addClass('active');
			}

			subject.activeStyle.type = styleType;
			subject.activeStyle.id = styleId;

			Core.setupStyleEditor();

			$('> .styleEditor > .editor', $slider).tinyscrollbar_update('relative');

			$slider.animate(
				{
					left: - rendering.styleSubjectsWrapper.width
				},
				200
			);
		})
		.on('click', '> div > .edStyleWizard_slider > .styleEditor > .header > .back', function () {
			var $styleEditor = $(this).parents().eq(1);

			$(this).parents().eq(2)
				.stop(true)
				.animate(
					{
						left: 0
					},
					100
				);
		})
		.on('click', '> div > .edStyleWizard_slider > .styleEditor .styleEditorSpacer .toggleContainer > div.name', function () {
			var $clicked = $(this),
				$parents = $clicked.parents(),
				$content = $parents.eq(0).siblings('.toggleContent'),
				$li = $parents.eq(1),
				$editorWrapper = $parents.filter('.styleEditor > .editor'),
				animationCallback = function () {
					$editorWrapper.tinyscrollbar_update('relative');
				},
				propertyInitializer = $li.data('propertyInitializer');

			if (propertyInitializer) {
				propertyInitializer();

				$li.data('propertyInitializer', false);
			}

			if ($li.hasClass('expanded')) {
				$li.removeClass('expanded');
				$content.slideUp(100, animationCallback);
			} else {
				$li.addClass('expanded');
				$content.slideDown(100, animationCallback);
			}

			return false;
		})
		.on('click', '> div > .edStyleWizard_slider > .styleEditor .styleEditorSpacer ul.properties .toggleContent > ol > li', function () {
			var $clicked = $(this);

			if ($clicked.hasClass('active'))
				return;

			$clicked
				.addClass('active')
				.siblings()
					.removeClass('active');

			$('> div', $clicked.parent().siblings('.propertyStatesWrapper'))
				.css('display', 'none')
				.eq($clicked.index())
					.css('display', '');

			$clicked.parents('.styleEditor > .editor').tinyscrollbar_update('relative');
		})
		.on('change', '> div > .edStyleWizard_slider > .styleEditor .styleEditorSpacer ul.properties .toggleContent .collapsableOptionsContainer > .trigger input', function () {
			var $checkbox = $(this),
				$collapsableOptionsContainer = $checkbox.parents().eq(2),
				$contentWrapper = $('> .contentWrapper', $collapsableOptionsContainer),
				callback = function () {
					$checkbox.parents('.styleEditor > .editor').tinyscrollbar_update('relative');
				};

			if (this.checked) {
				$collapsableOptionsContainer.addClass('expanded');

				$contentWrapper.stop(true).slideDown(100, callback);
			} else {
				$collapsableOptionsContainer.removeClass('expanded');

				$contentWrapper.stop(true).slideUp(100, callback);
			}

			$checkbox.parents('.styleEditor > .editor').tinyscrollbar_update('relative');
		})
		.on('change', '> div > .edStyleWizard_slider > .styleEditor > .header > .styleName input', function () {
			var $input = $(this),
				collectionIndex = rendering.active.collection,
				subjectIndex = rendering.active.subjects[collectionIndex],

				collection = collections[collectionIndex],
				subject = collection.subjects[subjectIndex],
				style = collection.styleGroups[subject.styleGroup].styles[subject.activeStyle.type][subject.activeStyle.id],

				styleTemplateGroup = style.templateGroups[subject.templateGroup] ? subject.templateGroup : "default",

				newName;

			newName = $('> .styleSelection .styleTypes > .custom > ol > li.' + subject.activeStyle.id + ' > span', $input.parents().eq(4))
				.text($input.val())
				.html();

			style.templateGroups[styleTemplateGroup].name = newName;
		});
};

})(eds1_10, window, document);