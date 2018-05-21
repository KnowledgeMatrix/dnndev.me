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