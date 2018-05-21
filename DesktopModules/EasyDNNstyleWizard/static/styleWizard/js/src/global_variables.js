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