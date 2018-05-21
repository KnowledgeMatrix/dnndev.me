(function ($, window, document, undefined) {

var initModule = function (settings) {
		var $mainContainer = $(this),

			$jsonDebugResponse = $('> .debugging > .jsonDebugger > .results', $mainContainer);

		$('> .debugging > .jsonDebugger > .trigger', $mainContainer).on('click', function () {
			var $this = $(this);

			if ($this.data('inProgress'))
				return false;

			$this
				.data('inProgress', true)
				.text('Validaton in progress...')
				.prop('disabled', true);

			$.ajax({
				url: settings.backendUrl,
				data: {
					action: 'jsonValidation'
				},
				timeout: 15000,
				dataType: 'json',
				cache: false,
				success: function (response) {
					var debuggingHtml = '';

					if (response.success == true) {
						for (var component in response.validation) {
							debuggingHtml += '<div class="collapsableInfoBox">' +
								'<div class="header"><span>' + htmlEncode(component.charAt(0).toUpperCase() + component.slice(1)) + '</span></div>' +
								'<div class="content">';

							for (var portal in response.validation[component]) {
								debuggingHtml += '<div class="collapsableInfoBox">' +
									'<div class="header"><span>' + htmlEncode(portal) + '</span></div>' +
									'<div class="content">';

								for (var theme in response.validation[component][portal]) {
									var themeMessages = response.validation[component][portal][theme];

									debuggingHtml += '<div class="collapsableInfoBox closed">' +
										'<div class="header"><span>' + htmlEncode(theme) + '</span></div>' +
										'<div class="content">';

									for (var i = 0, l = themeMessages.length; i < l; i++) {
										debuggingHtml += '<p class="error">' + htmlEncode(themeMessages[i]) + '</p>';
									}

									debuggingHtml += '</div></div>';
								}

								debuggingHtml += '</div></div>';
							}

							debuggingHtml += '</div></div>';
						}

						$jsonDebugResponse
							.html(debuggingHtml)
							.css('display', 'block');
					}
				},
				complete: function () {
					$this
						.data('inProgress', false)
						.text('Debug JSON')
						.prop('disabled', false);
				}
			});

			return false;
		});

		$jsonDebugResponse.on('click', 'div.collapsableInfoBox > div.header', function () {
			var $this = $(this);

			$this.parent().toggleClass('closed');
		});
	},

	htmlEncode = function (s) {
		return $('<p />').text(s).html();
	};

$.fn.styleWizardModuleInstance = function (settings) {
	return this.each(function () {
		initModule.call(this, settings);
	});
}

})(eds1_10, window, document);