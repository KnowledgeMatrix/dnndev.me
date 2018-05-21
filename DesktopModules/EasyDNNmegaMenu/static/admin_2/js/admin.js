(function ($, undefined) {

'use strict';

var defaultOptions = {
	customMarkerBase: '',
	markerHtmlEditorUrl: '',
	map: {
		mapType: 'hybrid',
		center: {
			latitude: 48.965794,
			longitude: 14.765625
		},
		zoom: 4,
		scrollwheelZoom: true,
		width: {
			value: 100,
			unit: '%'
		},
		height: {
			value: 70,
			unit: '%'
		},
		heightRelativeToWidth: true,
		alternateMapTypes: {}
	},
	markers: []
};


function MapEditor (mapElement, options) {
	var self = this,
		$editorWrapper = $(mapElement),
		$main = $('> .edMegaMenu_main', $editorWrapper),
		$markersHiddenField = $('> input[type="hidden"]', $editorWrapper),
		$getCurrentLocation = $('.edMegaMenu_getCurrentLocation', $main),
		$map = $('.edMegaMenu_map', $main),
		$settingsContainer = $('> .edMegaMenu_settingsContainer', $editorWrapper),
		$settingsPages = $('> .edMegaMenu_pages', $settingsContainer),
		$generalSettingsPage = $('> .edMegaMenu_general > .contentSection > .contentWrapper', $settingsPages),
		$addEditMarker = $('> .edMegaMenu_addEditMarker > .contentSection > .contentWrapper', $settingsPages),
		$streetViewWrapper = $('> .edMegaMenu_streetView > .contentSection > .contentWrapper', $settingsPages),

		$mapLatitudeInput = $('> .edMegaMenu_latitude > input', $generalSettingsPage),
		$mapLongitudeInput = $('> .edMegaMenu_longitude > input', $generalSettingsPage),
		$mapZoomInput = $('> .edMegaMenu_zoom > input', $generalSettingsPage),
		$mapTypeSelect = $('> .edMegaMenu_type > select', $generalSettingsPage),
		$customMapTypes = $('> .edMegaMenu_customMapTypes', $generalSettingsPage),
		$customMapTypesSelect = $('> select', $customMapTypes),
		$scrollwheelInput = $('> .edMegaMenu_enableScrollwheel input', $generalSettingsPage),
		$markerListWrapper = $('> .edMegaMenu_markerListWrapper', $generalSettingsPage),
		$markerList = $('> ol', $markerListWrapper),

		$markerTitleInput = $('> .edMegaMenu_title > input', $addEditMarker),
		$markerLatitudeInput = $('> .edMegaMenu_latitude > input', $addEditMarker),
		$markerLongitudeInput = $('> .edMegaMenu_longitude > input', $addEditMarker),
		$markerHtmlInput = $('> .edMegaMenu_html > textarea', $addEditMarker),
		$markerIconInput = $('> .edMegaMenu_icon > .edMegaMenu_markerSelector', $addEditMarker),
		$topBarWrapper = $('.topBarWrapper'),

		$streetViewPositionInput = $('> input', $streetViewWrapper).eq(0),
		$streetViewHeadingInput = $('> input', $streetViewWrapper).eq(1),
		$streetViewPitchInput = $('> input', $streetViewWrapper).eq(2),
		$streetViewZoomInput = $('> input', $streetViewWrapper).eq(3),

		map,
		adminMapOptions,
		srcMap,
		markersMeta = [],
		activeMarkerIndex,
		activeMarkerMeta,
		activeMarkerMetaBackup,
		globalMarkerIndex = 0,

		activeClass = 'edMegaMenu_active',

		layout = function () {
			$map.height(Math.round($map.width() * .7));

			$settingsContainer.height($main.outerHeight(true));
		},

		stopEditingActiveMarker = function () {
			var marker = activeMarkerMeta.marker;

			activeMarkerMeta.editing = false;
			activeMarkerMeta.info.close();

			marker.setDraggable(false);
			marker.setCursor('');
			marker.setAnimation(null);
		},

		addMarkerToList = function (markerMeta) {
			var htmlEditorLink = markerMeta.id == 0 ? '' : '<a class="edMegaMenu_editHtml" href="' + options.markerHtmlEditorUrl.split('--markerId--').join(markerMeta.id) + '">HTML editor</a>',
				$li = $(
					'<li class="edMegaMenu_active">' +
						'<div class="styledCheckbox">' +
							'<input type="checkbox" /> <label></label>' +
						'</div>' +
						'<div class="edMegaMenu_actions">' +
							'<span class="edMegaMenu_edit">Edit</span>' + htmlEditorLink + '<span class="edMegaMenu_centerMap">Center map</span>' +
						'</div>' +
						'<span class="dndHandle"></span>' +
					'</li>'
				),
				checkboxId = 'markerInList' + globalMarkerIndex++;

			$li.hover(
				function () {
					markerMeta.marker.setAnimation(google.maps.Animation.BOUNCE);
				},
				function () {
					if (markerMeta.editing)
						return;

					markerMeta.marker.setAnimation(null);
				}
			);

			$('.styledCheckbox > input', $li)
				.attr('id', checkboxId);
			$('.styledCheckbox > label', $li)
				.attr('for', checkboxId)
				.text(markerMeta.title.trim());

			$markerList.append($li);
			$markerListWrapper.addClass('hasMarkers');

			if (initiated)
				$markerList.sortable();
		},

		updateMarkerJson = function () {
			var markerMeta,
				markersData = [],
				marker;

			for (marker in markersMeta) {
				markerMeta = markersMeta[marker]

				if (!markerMeta.title)
					continue;

				markersData.push({
					id: markerMeta.id,
					title: markerMeta.title,
					html: markerMeta.html,
					icon: (markerMeta.icon ? markerMeta.icon.group + '/' + markerMeta.icon.filename : undefined),
					position: {
						latitude: markerMeta.position.latitude(),
						longitude: markerMeta.position.longitude()
					}
				});
			}

			$markersHiddenField.val(JSON.stringify(markersData));
		},

		changesHappened = false,
		initiated = false,
		markerDragTmp,

		streetViewPanorama;

	if (!navigator.geolocation)
		$getCurrentLocation.css('display', 'none');

	$mapLatitudeInput.val(options.map.center.latitude);
	$mapLongitudeInput.val(options.map.center.longitude);
	$mapZoomInput.val(options.map.zoom);
	$scrollwheelInput[0].checked = options.map.scrollwheelZoom;

	if (options.map.mapType.substr(0, 6) == 'other:') {
		$mapTypeSelect.val('other');
	} else {
		$mapTypeSelect.val(options.map.mapType);
	}

	layout();
	$(window).on('resize', function () {
		layout();
	});

	adminMapOptions = $.extend(
		true,
		{},
		options.map,
		{
			heightRelativeToWidth: false,
			getUserLocation: false,
			clusterMarkers: true,
			loadCustomLayers: false
		}
	);

	adminMapOptions.alternateMapTypes = {};

	map = new edMap_1(
		$map[0],
		{
			options: adminMapOptions
		}
	)
		.on('init', function () {
			var markerData;

			if (srcMap)
				return;

			map.registerLocationInput($('.edMegaMenu_locationSearch > input[type="text"]', $main));
			srcMap = map.getSourceMap();

			if (adminMapOptions.mapType.substr(0, 6) == 'other:') {
				var alternateMapTypeMeta = options.map.alternateMapTypes[adminMapOptions.mapType.substr(6)];

				if (alternateMapTypeMeta) {
					srcMap.setOptions({
						mapTypeControlOptions: {
							mapTypeIds: [
								google.maps.MapTypeId.HYBRID,
								google.maps.MapTypeId.ROADMAP,
								google.maps.MapTypeId.SATELLITE,
								google.maps.MapTypeId.TERRAIN,
								adminMapOptions.mapType
							]
						}
					});

					srcMap.mapTypes.set(
						adminMapOptions.mapType,
						new google.maps.StyledMapType(
							JSON.parse(alternateMapTypeMeta.mapStyle),
							{
								name: alternateMapTypeMeta.name
							}
						)
					);

					map.type(adminMapOptions.mapType);
				} else {
					map.type('hybrid');
				}
			}

			for (var markerIndex in options.markers) {
				markerData = options.markers[markerIndex];
				if (!markerData.title)
					continue;

				(function () {
					var position = new LatLng_1(markerData.position.latitude, markerData.position.longitude),
						meta = {
							confirmed: true,
							editing: false,
							id: markerData.id,
							title: markerData.title,
							position: position,
							html: markerData.html,
							icon: markerData.icon,
							marker: new google.maps.Marker({
								position: position.toGoogle(),
								map: srcMap,
								title: markerData.title
							}),
							info: undefined
						};

					meta.info = new EdsInfoWindow_1({
						marker: meta.marker,
						map: map,
						content: markerData.html,
						panMapOnOpen: false
					});

					if (meta.icon) {
						meta.icon = meta.icon.split('/');
						meta.icon = {
							group: meta.icon[0],
							filename: meta.icon[1]
						};
						meta.marker.setIcon(options.customMarkerBase + markerData.icon);
					}

					markersMeta.push(meta);
					addMarkerToList(meta);

					google.maps.event.addListener(meta.marker, 'position_changed', function () {
						var markerPosition = meta.marker.getPosition();

						meta.position = new LatLng_1(markerPosition.lat(), markerPosition.lng());

						$markerLatitudeInput.val(meta.position.latitude());
						$markerLongitudeInput.val(meta.position.longitude());
					});
				})();
			}

			updateMarkerJson();

			$editorWrapper.addClass('edMegaMenu_loaded');
			$markerList
				.sortable({
					forcePlaceholderSize: true,
					handle: 'span.dndHandle'
				})
				.on('sortstart', function(e, ui) {
					markerDragTmp = markersMeta.splice(ui.item.index(), 1)[0];
				})
				.on('sortstop', function(e, ui) {
					markersMeta.splice(ui.item.index(), 0, markerDragTmp);
					updateMarkerJson();
				});

			streetViewPanorama = srcMap.getStreetView();

			google.maps.event.addListener(streetViewPanorama, 'visible_changed', function () {
				var pov;

				if (streetViewPanorama.getVisible()) {
					pov = streetViewPanorama.getPov();
					$settingsPages.addClass('secondPage streetView');

					$streetViewPositionInput.val(streetViewPanorama.getPosition().toUrlValue());
					$streetViewHeadingInput.val(pov.heading);
					$streetViewPitchInput.val(pov.pitch);
					$streetViewZoomInput.val(pov.zoom);
				} else {
					$settingsPages.removeClass('secondPage streetView');

					$streetViewPositionInput.val('');
					$streetViewHeadingInput.val('');
					$streetViewPitchInput.val('');
					$streetViewZoomInput.val('');
				}
			});

			google.maps.event.addListener(streetViewPanorama, 'pov_changed', function () {
				var pov = streetViewPanorama.getPov();

				$streetViewHeadingInput.val(pov.heading);
				$streetViewPitchInput.val(pov.pitch);
				$streetViewZoomInput.val(pov.zoom);
			});

			google.maps.event.addListener(streetViewPanorama, 'position_changed', function () {
				$streetViewPositionInput.val(streetViewPanorama.getPosition().toUrlValue());
			});

			initiated = true;
		})
		.on('center', function () {
			var center = map.center();

			$mapLatitudeInput.val(center.latitude());
			$mapLongitudeInput.val(center.longitude());
		})
		.on('zoom', function () {
			$mapZoomInput.val(map.zoom());
		})
		.on('type', function () {
			var currentMapType = map.type();

			if (currentMapType.substr(0, 6) == 'other:') {
				$mapTypeSelect.val('other');
				$customMapTypes.addClass('show');
				$customMapTypesSelect.val(currentMapType.substr(6));
			} else {
				$mapTypeSelect.val(currentMapType);
				$customMapTypes.removeClass('show');

				srcMap.setOptions({
					mapTypeControlOptions: {
						mapTypeIds: [
							google.maps.MapTypeId.HYBRID,
							google.maps.MapTypeId.ROADMAP,
							google.maps.MapTypeId.SATELLITE,
							google.maps.MapTypeId.TERRAIN
						]
					}
				});
			}
		});

	$getCurrentLocation.on('click', function () {
		navigator.geolocation.getCurrentPosition(
			function (p) {
				map.center(p.coords.latitude, p.coords.longitude);
				map.zoom(14);
			},
			function () {},
			{
				timeout: 30000,
				maximumAge: 60000
			}
		);

		return false;
	});

	$mapLatitudeInput.on('change keyup', function () {
		var value = parseFloat(this.value);

		if (!srcMap || typeof value != 'number' || isNaN(value))
			return false;

		map.center(value, map.center().longitude());

		return false;
	});

	$mapLongitudeInput.on('change keyup', function () {
		var value = parseFloat(this.value);

		if (!srcMap || typeof value != 'number' || isNaN(value))
			return false;

		map.center(map.center().latitude(), value);

		return false;
	});

	$mapZoomInput.on('change keyup', function () {
		var value = parseInt(this.value);

		if (!srcMap || typeof value != 'number' || isNaN(value))
			return false;

		map.zoom(value);

		return false;
	});

	var mapTypeUpdate = function () {
		if (!srcMap)
			return false;

		var newMapType = $mapTypeSelect.val();

		if (options.map.alternateMapTypes && newMapType == 'other') {
			newMapType = $customMapTypesSelect.val();
			var alternateMapTypeMeta = options.map.alternateMapTypes[newMapType];

			newMapType = 'other:' + newMapType;

			srcMap.setOptions({
				mapTypeControlOptions: {
					mapTypeIds: [
						google.maps.MapTypeId.HYBRID,
						google.maps.MapTypeId.ROADMAP,
						google.maps.MapTypeId.SATELLITE,
						google.maps.MapTypeId.TERRAIN,
						newMapType
					]
				}
			});

			srcMap.mapTypes.set(
				newMapType,
				new google.maps.StyledMapType(
					JSON.parse(alternateMapTypeMeta.mapStyle),
					{
						name: alternateMapTypeMeta.name
					}
				)
			);
		}

		map.type(newMapType);

		return false;
	};

	$mapTypeSelect.on('change', mapTypeUpdate);

	$customMapTypesSelect.on('change', mapTypeUpdate);

	$scrollwheelInput.on('change', function () {
		if (!srcMap)
			return;

		map.scrollwheelZoom(this.checked);
	});

	$markerList
		.on('change', 'input', function () {
			if ($('input', $markerList).filter(':checked').length == 0)
				$markerListWrapper.removeClass('markersChecked');
			else
				$markerListWrapper.addClass('markersChecked');

			return false;
		})
		.on('click', '> .edMegaMenu_active > .edMegaMenu_actions > .edMegaMenu_edit', function () {
			var $marker = $(this).parents().eq(1),
				markerIcon = '';

			if (!srcMap || $settingsPages.hasClass('secondPage'))
				return false;

			activeMarkerIndex = $('> .' + activeClass, $markerList).index($marker[0]);
			activeMarkerMeta = markersMeta[activeMarkerIndex];

			activeMarkerMetaBackup = {
				title: activeMarkerMeta.title,
				position: activeMarkerMeta.position.clone(),
				html: activeMarkerMeta.html
			};

			if (activeMarkerMeta.icon) {
				markerIcon = activeMarkerMeta.icon.group + '/' + activeMarkerMeta.icon.filename

				activeMarkerMetaBackup.icon = {
					group: activeMarkerMeta.icon.group,
					filename: activeMarkerMeta.icon.filename
				};
			}

			activeMarkerMeta.editing = true;
			activeMarkerMeta.marker.setDraggable(true);
			activeMarkerMeta.marker.setCursor('move');
			activeMarkerMeta.marker.setAnimation(google.maps.Animation.BOUNCE);

			$markerTitleInput.val(activeMarkerMeta.title);
			$markerLatitudeInput.val(activeMarkerMeta.position.latitude());
			$markerLongitudeInput.val(activeMarkerMeta.position.longitude());
			$markerHtmlInput.val(activeMarkerMeta.html);

			$markerIconInput.edMapsMarkerSelector('val', markerIcon);

			$settingsPages.addClass('secondPage');
			srcMap.setOptions({streetViewControl: false});

			return false;
		})
		.on('click', '> .edMegaMenu_active > .edMegaMenu_actions > .edMegaMenu_centerMap', function () {
			var $marker = $(this).parents().eq(1),
				markerMeta;

			if (!srcMap || $settingsPages.hasClass('secondPage'))
				return false;

			markerMeta = markersMeta[$('> .' + activeClass, $markerList).index($marker[0])];

			map.panTo(markerMeta.position);
		});

	$markerListWrapper.on('click', '.edMegaMenu_deleteSelected', function () {
		var $checkedMarkerInput = $('> .edMegaMenu_active input', $markerList).filter(':checked').eq(0),
			$marker,
			allMarkersDeleted,
			index;

		changesHappened = true;

		while ($checkedMarkerInput.length > 0) {
			$marker = $checkedMarkerInput.parents().eq(1);
			index = $('> .edMegaMenu_active', $markerList).index($marker[0]);

			markersMeta[index].marker.setMap(null);
			markersMeta.splice(index, 1);

			$marker
				.removeClass('edMegaMenu_active')
				.slideUp(200, function () {
					$marker.remove();
				});

			$checkedMarkerInput = $('> .edMegaMenu_active input', $markerList).filter(':checked').eq(0);
		}

		updateMarkerJson();

		$markerListWrapper.removeClass('markersChecked');

		if ($('> .edMegaMenu_active', $markerList).length == 0)
			$markerListWrapper.removeClass('hasMarkers');
	});

	$generalSettingsPage.on('click', 'button.addMarkerTrigger', function () {
		var markerTitle = 'New marker',
			markerPosition = map.center(),
			thisMarkerMeta;

		if (!srcMap)
			return false;

		thisMarkerMeta = {
			confirmed: false,
			editing: true,
			id: 0,
			title: markerTitle,
			position: markerPosition,
			html: '',
			icon: undefined,
			marker: new google.maps.Marker({
				position: markerPosition.toGoogle(),
				map: srcMap,
				title: markerTitle,
				cursor: 'move',
				draggable: true,
				animation: google.maps.Animation.BOUNCE
			}),
			info: undefined
		};

		thisMarkerMeta.info = new EdsInfoWindow_1({
			marker: thisMarkerMeta.marker,
			map: map,
			content: '',
			panMapOnOpen: false
		});

		activeMarkerMeta = thisMarkerMeta;

		markersMeta.push(activeMarkerMeta);
		activeMarkerIndex = markersMeta.length - 1;

		$markerTitleInput.val(markerTitle);
		$markerLatitudeInput.val(markerPosition.latitude());
		$markerLongitudeInput.val(markerPosition.longitude());
		$markerHtmlInput.val('');

		$markerIconInput.edMapsMarkerSelector('val', '');

		google.maps.event.addListener(activeMarkerMeta.marker, 'position_changed', function () {
			var markerPosition = activeMarkerMeta.marker.getPosition();

			activeMarkerMeta.position = new LatLng_1(markerPosition.lat(), markerPosition.lng());

			$markerLatitudeInput.val(activeMarkerMeta.position.latitude());
			$markerLongitudeInput.val(activeMarkerMeta.position.longitude());
		});

		$settingsPages.addClass('secondPage');
		srcMap.setOptions({streetViewControl: false});

		return false;
	});

	$addEditMarker
		.on('click', 'button.edMegaMenu_centerOnMap', function () {
			if (!activeMarkerMeta)
				return false;

			activeMarkerMeta.marker.setPosition(map.center().toGoogle());

			return false;
		})
		.on('click', 'button.edMegaMenu_confirm', function () {
			var trimmedTitle;

			if (!activeMarkerMeta)
				return false;

			trimmedTitle = activeMarkerMeta.title.trim();

			if (trimmedTitle == '') {
				$markerTitleInput.parent().addClass('edMegaMenu_error');
				return false;
			}

			stopEditingActiveMarker();

			if (activeMarkerMeta.confirmed) {
				$('.styledCheckbox > label', $('> .edMegaMenu_active', $markerList).eq(activeMarkerIndex)).text(trimmedTitle);
				activeMarkerMetaBackup = undefined;
			} else {
				activeMarkerMeta.confirmed = true;
				addMarkerToList(activeMarkerMeta);
			}

			activeMarkerMeta = undefined;

			$settingsPages.removeClass('secondPage');
			srcMap.setOptions({streetViewControl: true});

			updateMarkerJson();

			changesHappened = true;

			return false;
		})
		.on('click', 'button.edMegaMenu_cancel', function () {
			if (!activeMarkerMeta)
				return false;

			if (activeMarkerMeta.confirmed) {
				stopEditingActiveMarker();

				activeMarkerMeta.title = activeMarkerMetaBackup.title;
				activeMarkerMeta.position = activeMarkerMetaBackup.position;
				activeMarkerMeta.html = activeMarkerMetaBackup.html;
				activeMarkerMeta.icon = activeMarkerMetaBackup.icon;

				activeMarkerMetaBackup = undefined;

				activeMarkerMeta.marker.setPosition(activeMarkerMeta.position.toGoogle());
				activeMarkerMeta.marker.setTitle(activeMarkerMeta.title);
				activeMarkerMeta.info.setContent(activeMarkerMeta.html);
			} else {
				activeMarkerMeta.marker.setMap(null);
				markersMeta.splice(activeMarkerIndex, 1);
			}

			activeMarkerMeta.info.close();

			activeMarkerMeta = undefined;

			$settingsPages.removeClass('secondPage');
			srcMap.setOptions({streetViewControl: true});

			return false;
		});

	$streetViewWrapper
		.on('click', '.edMegaMenu_exit', function () {
			streetViewPanorama.setVisible(false);

			return false;
		});

	$markerLatitudeInput.on('change keyup', function () {
		var value = parseFloat(this.value),
			markerPosition;

		if (!activeMarkerMeta || typeof value != 'number' || isNaN(value))
			return false;

		markerPosition = activeMarkerMeta.marker.getPosition();

		activeMarkerMeta.position = new LatLng_1(value, markerPosition.lng());
		activeMarkerMeta.marker.setPosition(activeMarkerMeta.position.toGoogle());

		$markerLatitudeInput.val(activeMarkerMeta.position.latitude());

		return false;
	});

	$markerLongitudeInput.on('change keyup', function () {
		var value = parseFloat(this.value),
			markerPosition;

		if (!activeMarkerMeta || typeof value != 'number' || isNaN(value))
			return false;

		markerPosition = activeMarkerMeta.marker.getPosition();

		activeMarkerMeta.position = new LatLng_1(markerPosition.lat(), value);
		activeMarkerMeta.marker.setPosition(activeMarkerMeta.position.toGoogle());

		$markerLongitudeInput.val(activeMarkerMeta.position.longitude());

		return false;
	});

	$markerTitleInput.on('change keyup', function () {
		if (!activeMarkerMeta)
			return false;

		activeMarkerMeta.title = this.value;
		activeMarkerMeta.marker.setTitle(this.value);

		return false;
	});

	$markerHtmlInput.on('change keyup', function () {
		var newHtml;

		if (!activeMarkerMeta)
			return false;

		newHtml = this.value.trim();
		if (newHtml == '')
			activeMarkerMeta.info.close();
		else {
			activeMarkerMeta.info.setContent(newHtml);
			activeMarkerMeta.info.open();
		}

		activeMarkerMeta.html = newHtml;

		return false;
	});

	$markerIconInput.on('change', function () {
		var parts = $markerIconInput.edMapsMarkerSelector('val').split('/');

		if (parts.length > 1) {
			activeMarkerMeta.icon = {
				group: parts[0],
				filename: parts[1]
			};

			activeMarkerMeta.marker.setIcon(options.customMarkerBase + activeMarkerMeta.icon.group + '/' + activeMarkerMeta.icon.filename);
		} else {
			activeMarkerMeta.icon = undefined;
			activeMarkerMeta.marker.setIcon(null);
		}
	});

	if ($topBarWrapper.length != 0)
		$('> .wrapper > .actions > li.save > a, > .wrapper > .actions > li.saveAndClose > a', $topBarWrapper).on('click', function () {
			changesHappened = false;
		});

	var $themeSelection = $('select.edMegaMenu_themeSelection'),
		$themeStyleSelection = $('select.edMegaMenu_themeStyleSelection'),
		$mapMarkersTemplateSelection = $('select.edMegaMenu_mapMarkersTemplateSelection'),
		$newsMarkersTemplateSelection = $('select.edMegaMenu_newsMarkersTemplateSelection'),
		$themeSettingsHf = $('.edMegaMenu_theme > input[type="hidden"]');

	var themeSettings = JSON.parse($themeSettingsHf.val()),
		regenerateThemeSettingsJson = function () {
			themeSettings.name = $themeSelection.val();
			themeSettings.style = $themeStyleSelection.val();
			themeSettings.mapMarkersTemplate = $mapMarkersTemplateSelection.val();
			themeSettings.newsMarkersTemplate = $newsMarkersTemplateSelection.val();

			$themeSettingsHf.val(JSON.stringify(themeSettings));
		},
		initialThemeId;

	for (var theme in options.themes) {
		if (theme == themeSettings.name)
			initialThemeId = theme;

		$themeSelection.append(
			$('<option />')
				.attr('value', theme)
				.text(options.themes[theme].portalAndName)
		);
	}

	if (!initialThemeId)
		initialThemeId = '_default/Default';

	$themeSelection.val(initialThemeId);

	$themeSelection.on('change', function (ev, eventParams) {
		var selectedTheme = $themeSelection.val(),
			firstRun = false;

		if (eventParams)
			firstRun = eventParams.firstRun;

		$themeStyleSelection.html('');
		$mapMarkersTemplateSelection.html('');
		$newsMarkersTemplateSelection.html('');

		var themeMeta = options.themes[selectedTheme];

		if (!themeMeta)
			return;

		if (!themeMeta.styles[''])
			$themeStyleSelection.append(
				$('<option />')
					.attr('value', '')
					.text('Default')
			);

		for (var styleClass in themeMeta.styles) {
			$themeStyleSelection.append(
				$('<option />')
					.attr('value', styleClass)
					.text(themeMeta.styles[styleClass])
			);
		}

		for (var i = 0, l = themeMeta.mapMarkerTemplates.length; i < l; i++) {
			var template = themeMeta.mapMarkerTemplates[i];

			$mapMarkersTemplateSelection.append(
				$('<option />')
					.attr('value', template)
					.text(template)
			);
		}

		for (var i = 0, l = themeMeta.newsMarkerTemplates.length; i < l; i++) {
			var template = themeMeta.newsMarkerTemplates[i];

			$newsMarkersTemplateSelection.append(
				$('<option />')
					.attr('value', template)
					.text(template)
			);
		}

		if (firstRun) {
			$themeStyleSelection.val(themeSettings.style);
			$mapMarkersTemplateSelection.val(themeSettings.mapMarkersTemplate);
			$newsMarkersTemplateSelection.val(themeSettings.newsMarkersTemplate);
		}

		regenerateThemeSettingsJson();
	});

	$themeStyleSelection.on('change', function () {
		regenerateThemeSettingsJson();
	});
	$mapMarkersTemplateSelection.on('change', function () {
		regenerateThemeSettingsJson();
	});
	$newsMarkersTemplateSelection.on('change', function () {
		var $this = $(this);

		$newsMarkersTemplateSelection.val($this.val());

		regenerateThemeSettingsJson();
	});

	$themeSelection.trigger('change', {firstRun: true});

	window.onbeforeunload = function (e) {
		var message = 'You are about to exit the page without saving your changes.';

		if (changesHappened) {
			e.returnValue = message;
			return message;
		}
	}
}

MapEditor.prototype = {};


$.fn.edMapsMapEditor = function (options) {
	var instanceKey = 'edMapsMapEditorInstance';

	options = $.extend(true, {}, defaultOptions, options);

	return this.each(function () {
		var self = this;

		if (!$.data(self, instanceKey))
			$.data(self, instanceKey, new MapEditor(self, options));
	});
};

})(eds1_11);



(function ($, undefined) {

'use strict';

var markerSelectorCounter = 0,
	$form = $('body'),
	defaultOptions = {
		moduleRoot: '/DesktopModules/EasyDNNmaps/',
		avalibleMarkers: []
	};

function MarkerSelector (el, options) {
	var self = this,
		$trigger = $(el),
		$hiddenInput = $('> input[type="hidden"]', $trigger),
		active = $hiddenInput.val(),
		markerSelectorOpenClass = 'edMegaMenu_open',
		markerIndex = markerSelectorCounter++,
		$markerSelectorWindow,

		position = function () {
			if (!$markerSelectorWindow.hasClass(markerSelectorOpenClass))
				return;

			$markerSelectorWindow.css({
				top: $trigger.offset().top + $trigger.outerHeight(true),
				left: $trigger.offset().left - ($markerSelectorWindow.outerWidth(true) / 2) + ($trigger.outerWidth(true) / 2) - (($trigger.outerWidth(true) - $trigger.outerWidth()) / 2)
			});
		},

		setActiveMarker = function (el) {
			var $el = $(el);

			$el
				.addClass('edMegaMenu_active')
				.siblings()
					.removeClass('edMegaMenu_active');

			active = $el.parent().data('group') + '/' + $el.data('filename');

			updateMarkerSelectionUi();
		},

		updateMarkerSelectionUi = function () {
			var parts = active.split('/'),
				activeGroup,
				activeFile;

			$hiddenInput.val(active);
			$('> img', $trigger).attr(
				'src',
				options.moduleRoot + 'markers/' + (active == '' ? 'default.png' : active)
			);

			$trigger.trigger('change');

			if (!$markerSelectorWindow)
				return;

			if (parts.length == 1) {
				$markerSelectorWindow.addClass('edMegaMenu_defaultMarker');
				$('> .edMegaMenu_colorSelectorWrapper > ul > li', $markerSelectorWindow).removeClass('edMegaMenu_active');
			} else {
				$markerSelectorWindow.removeClass('edMegaMenu_defaultMarker');
			}
		};

	self._returningAValue = false;

	self.val = function (args) {
		if (args.length < 2) {
			self._returningAValue = true;
			return active;
		}

		active = args[1];
		updateMarkerSelectionUi();
	}

	if (!active)
		active = '';

	$trigger
		.on('click', function () {
			var triggersListHtml = '',
				groupListHtml = '',
				activeGroupName = '',
				$randomP = $('<p />'),
				hasCustomMarkers = false;

			if (!$markerSelectorWindow) {
				$.each(options.avalibleMarkers, function () {
					var group = this.group,
						groupActive = active.indexOf(group + '/') == 0,
						commonClasses = 'edMegaMenu_' + group + (groupActive ? ' edMegaMenu_active' : '');

					groupListHtml += '<div class="' + commonClasses + '" data-group="' + group + '">';

					if (group == 'custom') {
						hasCustomMarkers = true;
						triggersListHtml = '<li class="' + commonClasses + '" data-group="' + group + '" title="Custom"></li>' + triggersListHtml;
					} else {
						groupListHtml += '<img src="' + options.moduleRoot + 'markers/' + group + '/default.png" alt="" data-filename="default.png" />';
						triggersListHtml += '<li class="' + commonClasses + '" data-group="' + group + '" title="' + group + '"></li>';
					}

					if (groupActive)
						$.each(this.files, function () {
							var htmlEncoded = $randomP.text(this).html();

							groupListHtml += '<img src="' + options.moduleRoot + 'markers/' + group + '/' + htmlEncoded + '" alt="" data-filename="' + htmlEncoded + '" />';
						});

					groupListHtml += '</div>';
				});

				$markerSelectorWindow = $(
					'<div class="edMegaMenu_markerSelectorWindow" id="markerSelectorWindow' + markerIndex + '">' +
						'<div class="edMegaMenu_colorSelectorWrapper">' +
							'<span class="edMegaMenu_default" title="Default marker"><img src="' + options.moduleRoot + 'markers/default.png" alt="" /></span>' +
							'<ul>' +
								triggersListHtml +
							'</ul>' +
							'<span class="edMegaMenu_close" title="Close">Close</span>' +
						'</div>' +
						'<div class="edMegaMenu_markerGroupsWrapper">' +
							groupListHtml +
						'</div>' +
					'</div>'
				)
					.appendTo($form);

				$(window).on('resize', function () {
					position();
				});

				$markerSelectorWindow.on('click', '> .edMegaMenu_colorSelectorWrapper > .edMegaMenu_close', function () {
					$markerSelectorWindow.removeClass(markerSelectorOpenClass);
				});

				$markerSelectorWindow
					.on('click', '> .edMegaMenu_colorSelectorWrapper > .edMegaMenu_default', function () {
						active = '';
						updateMarkerSelectionUi();
					})
					.on('click', '> .edMegaMenu_colorSelectorWrapper > ul > li', function () {
						var $clicked = $(this),
							$groupMarkerContainer,
							clickedGroup = $clicked.data('group');

						if ($clicked.hasClass('edMegaMenu_active'))
							return;

						$clicked
							.addClass('edMegaMenu_active')
							.siblings()
								.removeClass('edMegaMenu_active');

						$groupMarkerContainer = $('> .edMegaMenu_markerGroupsWrapper >', $markerSelectorWindow)
							.removeClass('edMegaMenu_active')
							.filter('.edMegaMenu_' + clickedGroup)
								.addClass('edMegaMenu_active');

						if ($('>', $groupMarkerContainer).length < 2) {
							$.each(options.avalibleMarkers, function () {
								var groupHtml = '',
									group = this.group;

								if (group != clickedGroup)
									return;

								$.each(this.files, function () {
									var htmlEncoded = $randomP.text(this).html();

									groupHtml += '<img src="' + options.moduleRoot + 'markers/' + group + '/' + htmlEncoded + '" alt="" data-filename="' + htmlEncoded + '" />';
								});

								$groupMarkerContainer.append(groupHtml);

								return false;
							});
						}

						$.each(options.avalibleMarkers, function () {});

						setActiveMarker($('> img', $groupMarkerContainer)[0]);
					})
					.on('click', '> .edMegaMenu_markerGroupsWrapper > div > img', function () {
						setActiveMarker(this);
					});
			}

			if ($markerSelectorWindow.hasClass(markerSelectorOpenClass))
				return;

			$markerSelectorWindow.addClass(markerSelectorOpenClass);

			if (active == '')
				$markerSelectorWindow.addClass('edMegaMenu_defaultMarker');

			if (hasCustomMarkers)
				$markerSelectorWindow.addClass('edMegaMenu_hasCustomMarkers');

			position();
		});
}

MarkerSelector.prototype = {};


$.fn.edMapsMarkerSelector = function (firstArgument) {
	var instanceKey = 'edMapsMarkerSelectorInstance',
		args = arguments,
		options = {},
		valueReturned = false,
		returnValue;

	if (firstArgument == undefined || $.isPlainObject(firstArgument))
		options = $.extend(
			true,
			{},
			defaultOptions,
			firstArgument
		);

	this.each(function () {
		var self = this,
			instance = $.data(self, instanceKey);

		if (!instance) {
			instance = new MarkerSelector(self, options);
			$.data(self, instanceKey, instance);

			return;
		}

		if (typeof firstArgument == 'string' && instance[firstArgument]) {
			returnValue = instance[firstArgument](args);

			if (instance._returningAValue) {
				instance._returningAValue = false;
				valueReturned = true;

				return false;
			}
		}
	});

	if (valueReturned)
		return returnValue;

	return this;
};

})(eds1_11);


eds1_11(function ($) {
	'use strict';

	var $customOverlaysManager = $('.edMegaMenu_adminWrapper .edMegaMenu_customOverlaysManager').eq(0);

	if ($customOverlaysManager.length) {
		var $jsonInput = $('> input[type="hidden"]', $customOverlaysManager);
		var $ol = $('> ol', $customOverlaysManager);
		var overlayIndex = 0;

		var addOverlayItem = function (settings) {
			var newOverlayID = 'mapOverlay_' + overlayIndex++;

			var $li = $(
				'<li class="edMegaMenu_notYetSet">' +
					'<header>' +
						'<span class="title">' + edsMaps_mapEditorLocalization.overlayLayer + '</span>' +
						'<span class="remove">' + edsMaps_mapEditorLocalization.remove + '</span>' +
					'</header>' +
					'<div>' +
						'<div class="floatingLabel">' +
							'<input type="text" id="' + newOverlayID + '_sourceUrl" class="sourceUrl">' +
							'<label for="' + newOverlayID + '_sourceUrl">' + edsMaps_mapEditorLocalization.kmlKmzFileUrl + '</label>' +
						'</div>' +
						'<div class="styledCheckbox">' +
							'<input type="checkbox" id="' + newOverlayID + '_alterViewport" class="alterViewport" />' +
							'<label for="' + newOverlayID + '_alterViewport" class="tooltip">' + edsMaps_mapEditorLocalization.alterViewport + '</label>' +
						'</div>' +
					'</div>' +
				'</li>'
			)
				.appendTo($ol);

			$('.floatingLabel > input', $li).eds_floatingLabel();
			$('label.tooltip', $li)
				.data('tooltipContent', edsMaps_mapEditorLocalization.alterViewportTooltip)
				.eds_tooltipster();

			if (settings) {
				$li.removeClass('edMegaMenu_notYetSet');
				$('> header > span.title', $li).text(settings.file.url.substr(settings.file.url.lastIndexOf('/') + 1));
				$('> div input.sourceUrl', $li).val(settings.file.url);
				$('> div input[type="checkbox"]', $li)[0].checked = ! settings.preserveViewport;
			}
		};

		var updateOverlayJson = function () {
			var overlays = [];

			$('>', $ol).each(function () {
				var $li = $(this);

				if (
					$li.hasClass('edMegaMenu_notYetSet') ||
					$li.hasClass('edMegaMenu_removeStarted') ||
					$li.hasClass('edMegaMenu_inputError')
				)
					return;

				overlays.push({
					file: {
						type: 'url',
						url: $('> div input.sourceUrl', $li).val().trim()
					},
					preserveViewport: ! $('> div input[type="checkbox"]', $li)[0].checked
				});
			});

			$jsonInput.val(JSON.stringify(overlays));
		};

		var overlaysJson = $jsonInput.val();

		if (overlaysJson) {
			$.each(JSON.parse(overlaysJson), function () {
				addOverlayItem(this);
			});
		}

		$ol
			.sortable({
				forcePlaceholderSize: true,
				handle: 'header'
			})
			.on('sortupdate', function() {
				updateOverlayJson();
			})
			.on('click', '> li > header > span.remove', function () {
				var $li = $(this).parents().eq(1);

				if ($li.hasClass('edMegaMenu_removeStarted'))
					return;

				$li.addClass('edMegaMenu_removeStarted');

				setTimeout(
					function () {
						$li.remove()
						$ol.sortable();
						updateOverlayJson();
					},
					300
				);
			})
			.on('change', '> li input.sourceUrl', function () {
				var $input = $(this),
					newValue = $input.val().trim(),
					$li = $input.parents('li').eq(0),
					$title = $('> header > span.title', $li);

				$li.removeClass('edMegaMenu_inputError edMegaMenu_notYetSet');

				if (newValue) {
					if (/^(https?|ftp):\/\/(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(newValue)) {
						$title.text(newValue.substr(newValue.lastIndexOf('/') + 1));
						$li.removeClass('edMegaMenu_notYetSet');
					} else {
						$li.addClass('edMegaMenu_inputError');
						$title.text(edsMaps_mapEditorLocalization.urlIncorrect);
					}
				} else {
					$li.addClass('edMegaMenu_notYetSet');
					$title.text(edsMaps_mapEditorLocalization.overlayLayer);
				}

				updateOverlayJson();
			})
			.on('change', '> li input.alterViewport', function () {
				updateOverlayJson();
			});

		$('> p > button.add', $customOverlaysManager).on('click', function () {
			addOverlayItem();
			$ol.sortable();

			return false;
		});
	}
});
