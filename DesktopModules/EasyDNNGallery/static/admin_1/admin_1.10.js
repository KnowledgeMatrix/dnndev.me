(function ($, undefined) {

	$(function () {
		var $flashMessagesContainer = $('#EDGAdminContent > .flashMessages');

		$('#EDGAdminContent .infoMessages').each(function () {
			var $this = $(this),
				$div = $('<div><span></span></div>'),
				$span = $('> span', $div);

			if ($this.hasClass('static'))
				return;

			$span[0].className = $this[0].className;

			$span.text($this.text());
			$flashMessagesContainer.append($div);

			$this.css('display', 'none');

			setTimeout(
				function () {
					$div.fadeOut(400, function () {
						$div.remove();
					});
				},
				7000
			);
		});
	});
})(eds1_10);