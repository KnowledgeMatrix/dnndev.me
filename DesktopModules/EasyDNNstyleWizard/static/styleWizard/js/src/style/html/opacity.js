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
