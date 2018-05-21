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