getExplicitStyleValue = function ($element, styleProperty) {
	var propertyValue = '',
		styleAttribute = $element.attr('style'),
		zIndexStartPosition,
		semicolonPosition;

	if (typeof styleAttribute != 'string')
		return propertyValue;

	zIndexStartPosition = styleAttribute.indexOf(' ' + styleProperty + ':');

	if (zIndexStartPosition == -1) {
		zIndexStartPosition = styleAttribute.indexOf(';' + styleProperty + ':');

		if (zIndexStartPosition == -1) {
			zIndexStartPosition = styleAttribute.indexOf(styleProperty + ':');

			if (zIndexStartPosition != 0)
				return propertyValue;
		} else
			zIndexStartPosition++;
	} else
		zIndexStartPosition++;

	propertyValue = styleAttribute.substr(zIndexStartPosition + styleProperty.length + 1);
	semicolonPosition = propertyValue.indexOf(';');

	if (semicolonPosition == -1)
		return propertyValue.trim();

	propertyValue = propertyValue.substr(0, semicolonPosition).trim();

	return propertyValue;
};
eds1_10(function ($) {
	var $window = $(window),
		modalMessageCheckingTimeout;

	$('body')
		.on('click', '.edsgg_openModal', function () {
			var $clicked = $(this),
				$modalTarget = $('.eds_modalWrapper')
					.filter(function () {
						return $clicked.data('targetId') == this.id;
					}),
				$dnnModuleElements = $modalTarget.parents('.DnnModule'),
				$modalContent,
				$modalResizeWrapper,
				$modalContentTitle,
				initialHeight,
				maximumHeight = $modalTarget.data('maxContentHeight'),

				resizeContent = function () {
					var windowHeight = $window.height(),
						ContentHDiff = Math.round($modalContent.outerHeight(true) - $modalContent.height()),
						resizeWrapperHDiff = Math.round($modalResizeWrapper.outerHeight(true) - $modalResizeWrapper.height()),
						titleHeight = $modalContentTitle.outerHeight(true),
						maxHeight = windowHeight - ContentHDiff - resizeWrapperHDiff - titleHeight;

					if (typeof maximumHeight == 'number' && maxHeight > maximumHeight)
						maxHeight = maximumHeight;

					$modalResizeWrapper.height(maxHeight);
				};

			$dnnModuleElements.each(function () {
				var $this = $(this);

				$this
					.data('previousZIndex', getExplicitStyleValue($this, 'z-index'))
					.css('z-index', 99999);
			});

			$modalTarget.addClass("eds_modalVisible");
			$("> .eds_modalContent", $modalTarget).addClass("eds_fadeInDown");

			if ($modalTarget.hasClass('eds_resizable')) {
				$modalContent = $('>', $modalTarget);
				$modalContentTitle = $('> h3', $modalContent);
				$modalResizeWrapper = $('> div', $modalContent);

				initialHeight = $modalResizeWrapper.height();

				resizeContent()

				$window.on('resize.eds_modalWrapper', function () {
					resizeContent();
				});
			}

			modalMessageCheckingTimeout = setInterval(
				function () {
					var dataKey = 'edsgg_autoHideTrigger';

					$('.edsgg_flashMessages .edsgg_infoMessages', $modalTarget).each(function () {
						var $this = $(this);

						if ($this.is(':hidden') || $this.data(dataKey))
							return;

						if ($this.is(':animated'))
							$this
								.stop(true, true)
								.css('opacity', '');

						$this.data(dataKey, setTimeout(
							function () {
								if ($this.is(':hidden'))
									return;

								$this
									.data(dataKey, false)
									.fadeTo(400, 0, function () {
										$this.css({
											display: 'none',
											opacity: ''
										});
									});
							},
							7000
						));
					});
				},
				100
			);
		})
		.on('click', '.eds_modalClose', function () {
			var $clicked = $(this),
				$modalTarget = $('.eds_modalWrapper'),
				$dnnModuleElements = $modalTarget.parents('.DnnModule');

			clearInterval(modalMessageCheckingTimeout);

			$dnnModuleElements.each(function () {
				var $this = $(this);

				$this.css('z-index', $this.data('previousZIndex'));
			});

			$modalTarget
				.filter(function () {
					return $clicked.data('targetId') == this.id;
				})
					.removeClass("eds_modalVisible")
					.css('z-index', '');
			var redirectUrl = $('.eds_modalWrapper input[name=eds_gg_editMediaredirectOnClose]').val();
			var mediaDeleted = $('.eds_modalWrapper input[name=eds_gg_editMediaDeleted]').val();
			var formNeedRefresh = $('.eds_modalWrapper input[name=eds_gg_FormNeedRefresh]').val();
			if (redirectUrl && redirectUrl != "" && mediaDeleted == "true") {
				window.location = redirectUrl;
			}
			else if (formNeedRefresh != "false")
				window.location = window.location;
		});
});