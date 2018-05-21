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
