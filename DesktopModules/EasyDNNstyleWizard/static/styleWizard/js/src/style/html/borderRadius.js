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
