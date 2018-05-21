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