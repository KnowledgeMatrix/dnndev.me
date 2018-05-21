var requestInProgress = false;
function portfoliopro_LoadMoreMediaData(PortalID, ModuleID, websiteRoot) {
	eds1_10.ajaxSetup({ cache: false });
	var epage = eds1_10(this).data('epage');
	var loadedmedia = eds1_10(this).data('loadedmedia');
	if (requestInProgress == false) {
		eds1_10.ajax({
			cache: false,
			type: "GET",
			beforeSend: function (xhr) {
				requestInProgress = true;
			},
			url: websiteRoot + "DesktopModules/EasyDNNGallery/Services/PortfolioProLoadMediaHtmlData.ashx?portalid=" + PortalID + "&emodule=" + ModuleID,
			contentType: "application/json; charset=utf-8",
			cache: false,
			dataType: "json",
			data: { 'epage': epage, 'loadedmedia': loadedmedia },
			success: function (msg) {
				if (msg.status != undefined && msg.status === 'success') {
					var gridContainer = eds1_10('#grid-container' + ModuleID);
					gridContainer.cubeportfolio('appendItems', msg.formatedhtml,
					 function () { }
					 );
					eds1_10('#eds_pp_infinitescroll' + ModuleID).data('epage', epage + 1);
					eds1_10('#eds_pp_infinitescroll' + ModuleID).data('loadedmedia', msg.loadedmedia);
					eds1_10('#eds_pp_loadmore' + ModuleID).html(msg.buttontext);

					if (parseInt(msg.left) < 1) {
						eds1_10('#edgMoreMediaTriggerWrapper' + ModuleID).hide();
					}
					else {
						var me = $('#portfoliopro-lightbox-gallery .cbp-filter-item-active');
						var currentItems = parseInt($('.cbp-filter-counter', me).text());
						var maxMedia = parseInt(me.data('maxmedia'));
						if (currentItems >= maxMedia) {
							$('#edgMoreMediaTriggerWrapper' + ModuleID).hide();
						}
					}
				}
				else {
				}
			},

			complete: function (xhr, textStatus) {
				requestInProgress = false;
			}
		})
	}
};