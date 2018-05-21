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