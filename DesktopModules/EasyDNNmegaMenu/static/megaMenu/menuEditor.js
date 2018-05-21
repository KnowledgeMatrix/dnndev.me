(function ($) {

	function edsMegaMenuEditor (elem, item) {
		var self = this,
			$mainWrapper = $(elem),
			$menuVisualizerWrapper = $('.edMegaMenu_menuVisualizerWrapper', $mainWrapper),
			$numOfColumnsSlider = $('.numOfColumnsSlider', $mainWrapper),
			$numberOfColumnsInput = $('.numberOfColumns', $mainWrapper),
			$sectionContentList = $('.edMegaMenu_mixedContent .edMegaMenu_sectionContentList', $mainWrapper),

			minimumSliderValue = 1;

		if ($sectionContentList.length)
			new Sortable($sectionContentList[0], {
				group: "contentList"
			});

		if (item.leftHtml != '' && item.rightHtml != '')
			minimumSliderValue = 3;
		else if (item.leftHtml != '' || item.rightHtml != '')
			minimumSliderValue = 2;

		if ($menuVisualizerWrapper.length > 0) {
			$numOfColumnsSlider
				.noUiSlider({
					start: item.numberOfColumns,
					step: 1,
					behaviour: 'snap',
					range: {
						'min': minimumSliderValue,
						'max': 6
					}
				})
				.on('set slide', function() {
					var newNumberOfColumns = parseInt($numOfColumnsSlider.val(), 10);
					$numberOfColumnsInput.val(newNumberOfColumns);
					$menuVisualizerWrapper.attr('class', 'edMegaMenu_menuVisualizerWrapper edMegaMenu_' + newNumberOfColumns + 'Column');
				});

			$numberOfColumnsInput
				.val(parseInt($numOfColumnsSlider.val(), 10))
				.on('change', function () {
					var newValue = parseInt($numberOfColumnsInput.val(), 10),
						valueChanged = false;

					if (newValue > 6 || newValue < 1)
						newValue = 1;

					if (item.leftHtml != '' && item.rightHtml != '' && newValue < 3) {
						newValue = 3;
						valueChanged = true;
					} else if ((item.leftHtml != '' || item.rightHtml != '') && newValue < 2) {
						newValue = 2;
						valueChanged = true;
					}

					if (valueChanged) {
						$numberOfColumnsInput.val(newValue);
						return;
					}

					$numOfColumnsSlider.val(newValue);
				})
				.on('submit', function () {
					return false;
				});
		}
	}

	edsMegaMenuEditor.prototype = {};

	$.fn.edsMegaMenuEditor = function (menuItem) {
		var instanceKey = 'edsMegaMenuEditorRun';

		return this.each(function () {
			var self = this;

			if (!$.data(self, instanceKey))
				$.data(self, instanceKey, new edsMegaMenuEditor(self, menuItem));
		});
	};

})(eds1_11);