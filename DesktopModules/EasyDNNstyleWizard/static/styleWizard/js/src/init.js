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
