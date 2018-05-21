'use strict';
define([
        'jquery',
        'knockout',
        './dnn.DestinationFolderPicker',
        'dnn.DataStructures',
        'dnn.TreeView',
        'dnn.DynamicTreeView',
        'dnn.jquery.extensions',
        'dnn.extensions',
        'dnn.servicesframework',
        'dnn.jScrollBar',
        'css.DropDownList'
],

function ($, ko) {
    var createFolderPicker = function (element, koOptions) {
        if (dnn[element.id]) {
            return;
        }

        var koElement = koOptions.koElement;

        var rootNodeId = koOptions.options.services.rootNodeId;
        if (typeof rootNodeId === "function") {
            koOptions.options.services.rootNodeId = rootNodeId();
        }
        var params = koOptions.options.services.parameters;
        if (typeof params === "function") {
            koOptions.options.services.parameters = params();
        }

        var options = {
            onSelectedFolder: function (folderId) {
                koElement(folderId);
            },
            services: {
                moduleId: '',
                serviceRoot: 'personaBar',
                getTreeMethod: 'Assets/GetFolders',
                sortTreeMethod: 'Assets/SortFolders',
                getNodeDescendantsMethod: 'Assets/GetFolderDescendants',
                searchTreeMethod: 'Assets/SearchFolders',
                getTreeWithNodeMethod: 'Assets/GetTreePathForFolder',
                rootId: 'Root',
                parameters: {}
            }
        };

        $.extend(true, options, koOptions.options);

        dnn.createDestinationFolderPicker(element, options, {});
    }

    var paramsChanged = function (param1, param2) {
        for (var a in param1) {
            if (param1.hasOwnProperty(a) && param2[a] !== param1[a]) {
                return true;
            }
        }

        return false;
    }

    ko.bindingHandlers.destinationFolderSelector = {
        init: function (element, valueAccessor) {
            var koOptions = valueAccessor();
            if (typeof koOptions.enabled == "undefined" || koOptions.enabled === true) {
                createFolderPicker(element, koOptions);
            }
        },
        update: function (element, valueAccessor) {
            var koOptions = valueAccessor();

            if (koOptions.enabled === true) {
                createFolderPicker(element, koOptions);
            }

            var folderPicker = dnn[element.id];
            if (folderPicker) {

                var params = koOptions.options.services.parameters;
                if (typeof params === "function") {
                    params = params();
                }

                var originParams = folderPicker.options.services.parameters;
                if (paramsChanged(originParams, params)) {
                    folderPicker.options.services.parameters = params;

                    if (folderPicker._treeView) {
                        folderPicker._treeView.controller.parameters = params;

                        folderPicker._treeView._$searchInput.val("");
                        folderPicker._treeView._$clearButton.hide();
                        folderPicker._treeView._search();
                    }
                }
            }
        }
    };
});
