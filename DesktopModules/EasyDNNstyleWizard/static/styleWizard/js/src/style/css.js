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
