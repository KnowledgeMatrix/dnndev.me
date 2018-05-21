'use strict';
define(['jquery',
        'knockout',
        'knockout.mapping',
        'main/validator',
        'main/config',
        'main/tabpanel',
        'main/pager',
        'jquery.easydropdown.min',
        'jquery.tokeninput.min',
        'main/permissionGrid',
        'main/permissionGridManager',
        'dnn.jquery',
        'main/koBindingHandlers/folderPicker',
        'main/koBindingHandlers/tagsInput',
        './destinationFolderSelector',
        'css.DropDownList',
        'css!../../../../../../Resources/Shared/Components/FileUpload/dnn.FileUpload.css',
        'css.jScrollBar'],

function ($, ko, komapping, validator, cf, tabpanel, pager) {
    ko.mapping = komapping;

    var config = cf.init();
    var utility = null;
    var wrapper = null;

    var permissionGrid;
    var fileUpload;

    var itemContainer = null;
    var containerTop = 0;
    var scrollItem = null;

    var itemsPerRow = 0;
    var itemsPerPage = 24;

    var animationDuration = 300;

    var viewModel = {
        currentFolder: ko.observable(),
        breadcrumb: ko.observableArray(),
        folderContent: ko.observableArray(),
        rootFolderId: ko.observable(-1),
        selectedPortal: ko.observable(-2),
        lastPage: ko.observable(),
        totalItemCount: ko.observable(),
        inputSearchText: ko.observable(''),
        searchText: ko.observable(''),
        selectedItem: ko.observable(),
        selectedSort: ko.observable("ItemName"),
        sortOptions: ko.observableArray(),
        detailOperation: ko.observable(),
        isGlobalFolder: ko.pureComputed(function () {
            return viewModel && viewModel.itemEditing.isFolder() && viewModel.itemEditing.portalId() === -1;
        }),
        destinationFolderId: ko.observable(),
        itemEditing: {
            itemId: ko.observable(null),
            portalId: ko.observable(),
            isFolder: ko.observable(),
            itemName: ko.observable(),
            fileNameFocused: ko.observable(false),
            folderNameFocused: ko.observable(false),
            iconUrl: ko.observable(),
            createdOnDate: ko.observable(),
            createdBy: ko.observable(),
            lastModifiedOnDate: ko.observable(),
            lastModifiedBy: ko.observable(),
            size: ko.observable(),
            title: ko.observable(),
            description: ko.observable(),
            subscribed: ko.observable(),
            url: ko.observable(),
            tags: ko.observable(),
            folderType: ko.observable(),
            workflows: ko.observableArray(),
            workflowId: ko.observable(),
            originalWorkflowId: ko.observable(),
            workflowAction: ko.observable(),
            versioning: ko.observable(),
            versions: {
                totalResults: ko.observable(0),
                results: ko.observableArray([])
            },
            workflow: ko.observable({}),
            workflowMessage: ko.observable(""),
            workflowHistoryColumns: ['Date', 'User', 'Action', 'Comment'],
            workflowHistory: ko.observableArray([])
        },
        folderAdding: {
            folderName: ko.observable(''),
            folderNameFocused: ko.observable(false),
            folderTypes: ko.observableArray(),
            parentFolderType: ko.observable(),
            selectedFolderType: ko.observable(),
            mappedName: ko.observable()
        },
        uploading: {
            imageUrl: ko.observable(),
            fileName: ko.observable(),
            showConfirmation: ko.observable(false),
            pendingfiles: null,
            overwrite: false
        },
        itemToHighlight: ko.observable(),
        loading: ko.observable(true),
        syncing: ko.observable(false),
        getRootFolderId: function() {
            return viewModel.rootFolderId();
        },
        getFolderPickerParameters: function () {
            return {
                pid: viewModel.selectedPortal()
            };
        },
        workflowVisible: function () {
            if (this.settings && this.settings.isHost && this.settings.manageGlobalAssets) {
                return false;
            }
            return true;
        },
        versioningVisible: function () {
            if (this.settings && this.settings.isHost && this.settings.manageGlobalAssets) {
                return false;
            }
            return true;
        }
    };

    viewModel.itemEditing.formatedItemName = ko.computed(function () {
        var itemName = viewModel.itemEditing.itemName();
        if (!itemName || itemName.length < 18) {
            return itemName;
        } else {
            var shortName = itemName.substr(0, 18) + "...";
            if (itemName.indexOf('.') > -1) {
                shortName += "." + itemName.split('.').pop();
            }

            return shortName;
        }
    });

    viewModel.itemEditing.workflowTabVisible = ko.computed(function() {
        return viewModel.itemEditing.workflow() ||
                (viewModel.itemEditing.workflowHistory() && viewModel.itemEditing.workflowHistory().length);
    });

    var mappingOptions = {
        create: function(options) {
            var item = ko.mapping.fromJS(options.data, {
                observe: ["ItemName", "WorkflowStateInProgress"]
                });
            item.selected = ko.observable(false);
            item.saved = ko.observable(false);
            item.highlight = ko.computed(function() {
                return item.saved()
                    || viewModel.itemToHighlight()
                        && item.IsFolder === viewModel.itemToHighlight().isFolder
                        && item.ItemName() === viewModel.itemToHighlight().itemName;
            });
            return item;
        }
    };

	var throttledSearchText = ko.computed(viewModel.inputSearchText)
                                .extend({ throttle: 400 });

	throttledSearchText.subscribe(function (text) {
	    if (text.length == 0 || text.length >= 3) {
	        viewModel.searchText(text);
        }
	}, viewModel);

    viewModel.doSearch = function() {
        var text = viewModel.searchText();
        if (text.length === 0) {
            refreshCurrentFolder();
        } else {
            search(viewModel.currentFolder().FolderID, text, 0, viewModel.selectedSort());
        }
    };

    viewModel.doSync = function() {
        var params = {
            folderId: viewModel.currentFolder().FolderID,
            recursive: true
        };        
        viewModel.syncing(true);
        assetsService().post('SynchronizeFolder', params, function () {
            viewModel.syncing(false);
            refreshCurrentFolder();
        }, function (x) {
            viewModel.syncing(false);
            failed(x);
            refreshCurrentFolder();
        });

    };

	viewModel.getPreviewVersionUrl = function (fileId, version) {
	    var sf = assetsService("Versions");
	    var serviceRoot = sf.getServiceRoot();
	    return serviceRoot + "assetsVersions/Preview?fileId=" + fileId + "&version=" + version;
    }

	viewModel.previewVersion = function previewVersion(version) {	    
	    downloadUrl(viewModel.getPreviewVersionUrl(version.FileID, version.Version));
	};

    viewModel.deleteVersion = function deleteVersion(version) {
        utility.confirm(
            utility.resx.Assets.ConfirmDeleteFileVersion,
            utility.resx.Assets.btn_Delete,
            utility.resx.Assets.btn_Cancel,
            function onConfirmDeletion() {
                var params = {
                    version: version.Version,
                    fileId: version.FileID
                }
                assetsService("Versions").post('DeleteVersion', params, function onDelete() {
                    utility.notify(utility.resx.Assets.SuccessFileVersionDeletion);
                    getFileDetails(version.FileID);
                    getVersions();
                    refreshCard(version.FileID);
                }, failed);
        });
    };
    viewModel.rollbackVersion = function rollbackVersion(version) {
        utility.confirm(
            utility.resx.Assets.ConfirmRollbackFileVersion.replace("[VERSION]", version.Version),
            utility.resx.Assets.btn_Rollback,
            utility.resx.Assets.btn_Cancel,
            function onConfirmDeletion() {
                var params = {
                    version: version.Version,
                    fileId: version.FileID
                }
                assetsService("Versions").post('RollbackVersion', params, function onRollback() {
                    utility.notify(utility.resx.Assets.SuccessFileVersionRollback);
                    getFileDetails(version.FileID);
                    getVersions();
                    refreshCard(version.FileID);
                }, failed);
            });
    };
    
    function refreshCard(fileId, isPublished) {

        // Update thumbanil in file details panel
        if (viewModel.itemEditing.itemId() === fileId) {
            var iconUrl = viewModel.itemEditing.iconUrl();
            var refreshIconUrl = addTimeStampQueryString(iconUrl);
            viewModel.itemEditing.iconUrl(addTimeStampQueryString(refreshIconUrl));
        }
        // Update thumbnail in card list
        var $cardThumbnail = $("#thumbnail-" + fileId);
        if ($cardThumbnail.length === 0) {
            return;
        }
        var url = $cardThumbnail.css("backgroundImage").replace("url(\"", "").replace("\")", "");
        var refreshIconUrl = addTimeStampQueryString(url);
        $cardThumbnail.css("backgroundImage", "url(" + refreshIconUrl + ")");

        if (isPublished) {            
            $cardThumbnail.closest(".card").find(".unpublished").css("display", "none");
        }
    }

    function addTimeStampQueryString(url) {
        return url + ((url.indexOf("?") === -1 ? "?" : "&") + "t" + Date.now());
    }

    function getVersions() {
        var item = viewModel.itemEditing;
        var pager = item.versions;
        var params = {
            pageIndex: pager.pageIndex(),
            pageSize: pager.pageSize,
            fileId: item.itemId()
        }
        assetsService("Versions").get('GetFileVersions', params, bindFileVersions, failed);
    }

    viewModel.searchText.subscribe(viewModel.doSearch);
    viewModel.selectedSort.subscribe(viewModel.doSearch);    

    viewModel.folderAdding.folderTypeDisabled = ko.computed(function() {
		return !viewModel.folderAdding.parentFolderType() || viewModel.folderAdding.parentFolderType().IsDefault === false;
	});

	viewModel.folderAdding.mappedNameHidden = ko.computed(function () {
		return !viewModel.folderAdding.selectedFolderType() || viewModel.folderAdding.selectedFolderType().IsDefault 
			|| !viewModel.folderAdding.parentFolderType() || !viewModel.folderAdding.parentFolderType().IsDefault;
	});

    var showTopPanel = function (panelClass, complete) {
        var panel = wrapper.find("div." + panelClass);
        if (panel.is(":visible")) {
            !complete || complete();
            return;
        }

        closeTopPanel(function () {
            $("div.body").animate({ scrollTop: 220 });
            var h = panel.outerHeight();
            panel.slideDown(animationDuration, complete);
            itemContainer.addClass("disabled").animate({ top: containerTop + h });
            viewModel.hideDetails();
        });
    };

    var closeTopPanel = function (complete) {
        itemContainer.removeClass("disabled");
        var panel = wrapper.find("div.top-panel:visible");
        if (panel.length == 1) {
            panel.slideUp(animationDuration, complete);
            itemContainer.animate({ top: containerTop });
        } else {
            !complete || complete();
        }
    };

    viewModel.addFolder = function () {
        var firstTab = wrapper.find('div.add-folder > ul.tabControl > li:first-child');
        firstTab.trigger('click');
        viewModel.folderAdding.folderName('');        

        loadTypes();
         
        showTopPanel("add-folder");
        viewModel.folderAdding.folderNameFocused(true);        

        viewModel.folderAdding.mappedName('');
    };

    var assetsService = function (suffix) {
        utility.sf.moduleRoot = 'personaBar';
        utility.sf.controller = 'assets' + (suffix || "");
        return utility.sf;
    };

    var getFolderType = function(d, id) {
        for (var i = 0; i < d.length; i++) {
            if (d[i].FolderMappingID == id) {
                return d[i];
            }
        }

        return null;
    };

    var loadTypes = function () {
        assetsService().get('GetFolderMappings', {pid: viewModel.selectedPortal()}, function (d) {
            viewModel.folderAdding.folderTypes.removeAll();
            ko.utils.arrayPushAll(viewModel.folderAdding.folderTypes, d);

            var defaultFolderTypeId = viewModel.currentFolder().FolderID == viewModel.getRootFolderId() ?
                config.defaultFolderMappingId : viewModel.currentFolder().FolderMappingID;

            viewModel.folderAdding.parentFolderType(getFolderType(d, viewModel.currentFolder().FolderMappingID));            
            viewModel.folderAdding.selectedFolderType(getFolderType(d, defaultFolderTypeId));
        });
    };

    var loadWorkflows = function (portalId) {
        if (typeof portalId === "undefined") {
            portalId = viewModel.selectedPortal();
        }
        assetsService().get('GetWorkflows', { pid: portalId }, function (d) {
            viewModel.itemEditing.workflows.removeAll();
            ko.utils.arrayPushAll(viewModel.itemEditing.workflows, d);
        });
    };

    viewModel.cancelFolder = function () {
        closeTopPanel();
    };

    viewModel.saveFolder = function () {
        if(!validator.validate(wrapper.find('div.top-panel.add-folder'))) return;

        var params = {
            FolderName: viewModel.folderAdding.folderName(),
            ParentFolderId: viewModel.currentFolder().FolderID,
            FolderMappingId: viewModel.folderAdding.selectedFolderType().FolderMappingID,
            MappedName: viewModel.folderAdding.mappedName()
        };

        assetsService().post('CreateNewFolder', params, function () {
            closeTopPanel();
            refreshCurrentFolder({ itemName: params.FolderName, isFolder: true });
        }, function (x) {
            failed(x);
            viewModel.folderAdding.folderNameFocused(true);
        });
    };

    var getCurrentFolderPath = function () {
        var path = '';
        for (var i = 1; i < viewModel.breadcrumb().length; i++) {
            path += viewModel.breadcrumb()[i].FolderName + '/';
        }

        return path;
    }

    viewModel.addAsset = function () {
        viewModel.uploading.showConfirmation(false);
        viewModel.uploading.imageUrl('');
        viewModel.uploading.overwrite = false;
        wrapper.find("#uploader").val("");

        fileUpload.setUploadPath(getCurrentFolderPath());
        showTopPanel("add-asset");        
    };

    viewModel.selectedPortal.subscribe(function() {
        var portalId = viewModel.selectedPortal();
        $.extend(fileUpload.options.parameters, { portalId: portalId });
        loadWorkflows();
    });

    viewModel.closeAddAsset = function() {
        closeTopPanel();
    };

    viewModel.itemClick = function (item, e) {
        if (itemContainer.is(".disabled")) {
            return;
        }

        if ($('body').is('.touch') && !item.selected()) {
        	viewModel.setSelectedItem(item);        	
            return;
        }

        if (item.IsFolder) {
            getFolderContent(item.ItemID);

            if (viewModel.rootFolderId() === -1) {
                viewModel.selectedPortal(item.PortalId);
                viewModel.rootFolderId(item.ItemID);
            }
        } else {
            viewModel.download(item);
        }

        return;
    };

    viewModel.itemTap = function (item, e) {        
        if (itemContainer.is(".disabled")) {
            return;
        }

        if (item.IsFolder) {
			item.selected(true);

			var uiElement = $(e.currentTarget).closest('div.item');
			itemContainer.find("div.item:not(.selected)").fadeOut();
			scrollTopElement(uiElement, function () {
				getFolderContent(item.ItemID);	
			});
        } else {
            viewModel.showDetails(item, e);
        }

        return;        
    };

    var scrollTopElement = function (uiElement, callback) {
        var scrollPos = scrollItem[0].scrollTop + uiElement.position().top - 4;
        scrollItem.animate({ scrollTop: scrollPos }, uiElement.position().top != 0 ? animationDuration : 0, 'swing', callback);
    };

	viewModel.setSelectedItem = function (item) {
		!viewModel.selectedItem() || viewModel.selectedItem().selected(false);
        viewModel.selectedItem(item);
        item.selected(true);
	};

    var focusEditName = function() {
        if (viewModel.itemEditing.isFolder()) {
            viewModel.itemEditing.folderNameFocused(true);
        } else {
            viewModel.itemEditing.fileNameFocused(true);
        }

		 wrapper.find('div.dnnTagsInput input[id$="_tag"]').each(function() {
	        var $input = $('#' + $(this).attr('id').replace('_tag', ''));
			if ($input.data('dnnTagInput')) {
				$(this).dnnResetAutosize($input.data('dnnTagInput'));
			}
	    });
    };

    function slideUpDetails(callback) {
        var itemDetails = wrapper.find("div.item-details");
        itemDetails.slideUp(itemDetails.is(":visible") ? animationDuration : 0, callback);
    }

    function slideDownDetails(item, element) {
        var uiElement = $(element.currentTarget).closest('div.item');
        scrollTopElement(uiElement, function () {
            var parentOffset = 46; // TODO: review this, calculate from paddings                
            var left = uiElement.position().left - parentOffset + uiElement.outerWidth() / 2;
            wrapper.find("div.details-selector > div").css({ left: left });

            var i = viewModel.folderContent.indexOf(item);

            if (itemsPerRow === 0) {
                var itemWidth = uiElement.outerWidth(true);
                var mainContainer = wrapper.find('div.item-container');
                itemsPerRow = Math.floor(mainContainer.width() / itemWidth);
            }
            var pos = Math.floor(i / itemsPerRow) * itemsPerRow + itemsPerRow - 1;
            var rightmostItem = itemContainer.find("div.item").eq(pos);
            if (rightmostItem.length === 0) {
                rightmostItem = itemContainer.find("div.item").last();
            }

            var itemDetails = wrapper.find("div.item-details");
            itemDetails.insertAfter(rightmostItem).slideDown(animationDuration, focusEditName);
        });
    }

    viewModel.showDetails = function (item, element) {
        if (viewModel.detailOperation() === "edit" && viewModel.itemEditing.itemId() === item.ItemID) {
            return;
        }

        viewModel.setSelectedItem(item);        
        
        item.saved(false);

        slideUpDetails(function () {
            
            viewModel.detailOperation("edit");
            viewModel.itemEditing.itemId(item.ItemID);
            viewModel.itemEditing.portalId(item.PortalId);
            viewModel.itemEditing.isFolder(item.IsFolder);
            viewModel.itemEditing.itemName(item.ItemName());
            viewModel.itemEditing.iconUrl(viewModel.iconUrl(item, wrapper.find("div.details-icon")[0]));

            if (item.IsFolder) {
                assetsService().get('GetFolderDetails', { folderId: item.ItemID }, bindFolderDetails, failed);

                if (viewModel.rootFolderId() === -1) {
                    loadWorkflows(item.PortalId);
                }
            } else {
                getFileDetails(item.ItemID);
                getVersions();
            }

            var firstTab = $(this).find('ul.tabControl > li:first-child');
            firstTab.trigger('click');

            slideDownDetails(item, element);
        });
    };

    function getFileDetails(fileId) {
        assetsService().get('GetFileDetails', { fileId: fileId }, bindFileDetails, failed);
    }

    viewModel.showMoveTo = function (item, element) {
        if (viewModel.detailOperation() === "move" && viewModel.itemEditing.itemId() === item.ItemID) {
            return;
        }

        slideUpDetails(function() {
            viewModel.detailOperation("move");
            viewModel.itemEditing.itemId(item.ItemID);
            viewModel.itemEditing.isFolder(item.IsFolder);
            viewModel.itemEditing.itemName(item.ItemName());
            slideDownDetails(item, element);
        });
    }

    viewModel.canCopy = function (item) {
        return !item.IsFolder;
    }

    viewModel.showCopyTo = function (item, element) {
        if (viewModel.detailOperation() === "copy" && viewModel.itemEditing.itemId() === item.ItemID) {
            return;
        }

        slideUpDetails(function() {
            viewModel.detailOperation("copy");
            viewModel.itemEditing.itemId(item.ItemID);
            viewModel.itemEditing.isFolder(item.IsFolder);
            viewModel.itemEditing.itemName(item.ItemName());
            slideDownDetails(item, element);
        });
    }

    function replaceConfirmation(replaceCallback) {
        var message = utility.resx.Assets.txt_ConfirmReplace.replace("[NAME]", viewModel.itemEditing.itemName());
        utility.confirm(message, utility.resx.Assets.btn_Replace, utility.resx.Assets.btn_Cancel, replaceCallback, viewModel.hideDetails);
    }

    viewModel.copy = function () {
        function success(result) {
            viewModel.hideDetails();
            if (viewModel.currentFolder().FolderID === parseInt(viewModel.destinationFolderId())) {
                refreshCurrentFolder({ itemName: result.ItemName, isFolder: viewModel.itemEditing.isFolder() });
            }
        }

        assetsService().post('CopyFile', {
            ItemId: viewModel.itemEditing.itemId(),
            DestinationFolderId: viewModel.destinationFolderId(),
            Overwrite: false
        }, function(result) {
            if (result.AlreadyExists) {
                replaceConfirmation(function () {
                    assetsService().post('CopyFile', {
                        ItemId: viewModel.itemEditing.itemId(),
                        DestinationFolderId: viewModel.destinationFolderId(),
                        Overwrite: true
                    }, success, failed);
                });
            } else {
                success(result);
            }
        }, failed);
    }

    viewModel.move = function () {
        if (viewModel.currentFolder().FolderID === parseInt(viewModel.destinationFolderId())) {
            utility.notify(utility.resx.Assets["DestinationFolderCannotMatchSourceFolder.Error"]);
            return;
        }

        var method = viewModel.itemEditing.isFolder() ? 'MoveFolder' : 'MoveFile';
        assetsService().post(method, {
            ItemId: viewModel.itemEditing.itemId(),
            DestinationFolderId: viewModel.destinationFolderId(),
            Overwrite: false
        }, function (result) {
            if (result.AlreadyExists) {
                replaceConfirmation(function() {
                    assetsService().post(method, {
                        ItemId: viewModel.itemEditing.itemId(),
                        DestinationFolderId: viewModel.destinationFolderId(),
                        Overwrite: true
                    }, refreshCurrentFolder, failed);
                });
            } else {                
                refreshCurrentFolder();
            }
        }, failed);
    }

    viewModel.canDownload = function(item) {
        return !item.IsFolder;
    }

    viewModel.download = function (item) {
        var url = utility.sf.getServiceRoot() + "assets/Download?fileId=" + item.ItemID;
        downloadUrl(url);
    }

    var $idown;
    function downloadUrl(url) {
        url += "&forceDownload=true";
        if ($idown) {
            $idown.attr('src', url);
        } else {
            $idown = $('<iframe>', { id: 'idown', src: url }).hide().appendTo('body');
        }
    }

    viewModel.delete = function (item, e) {
        viewModel.setSelectedItem(item);
        var msg = item.IsFolder ? utility.resx.Assets.txt_ConfirmDeleteFolder : utility.resx.Assets.txt_ConfirmDeleteAsset;
        utility.confirm(msg.replace('[NAME]', item.ItemName()), utility.resx.Assets.btn_Delete, utility.resx.Assets.btn_Cancel, function () {
            if (item.IsFolder) {
                assetsService().post('DeleteFolder', {
                    folderId: item.ItemID,
                    UnlinkAllowedStatus: false
                }, refreshCurrentFolder, failed);
            } else {
                assetsService().post('DeleteFile', {
                        fileId: item.ItemID
                }, refreshCurrentFolder, failed);
            }
        }, function () {
            item.selected(false);                
        });
    };

    viewModel.deleteCurrentFolder = function () {
        var msg = utility.resx.Assets.txt_ConfirmDeleteFolder.replace('[NAME]', viewModel.currentFolder().FolderName);
        utility.confirm(msg, utility.resx.Assets.btn_Delete, utility.resx.Assets.btn_Cancel, function () {
            assetsService().post('DeleteFolder', {
                folderId: viewModel.currentFolder().FolderID,
                UnlinkAllowedStatus: false
            }, viewModel.goToParentFolder(), failed);
        });
    };

    viewModel.canAdd = function () {
        var currentFolder = viewModel.currentFolder();
        return viewModel.settings.permissions
                && viewModel.settings.permissions.EDIT === true
                && currentFolder && currentFolder.CanAdd === true;
    }

    viewModel.canEdit = function (item) {
        if (!item) {
            return viewModel.settings.permissions
                && viewModel.settings.permissions.EDIT === true;
        }
        return viewModel.canMove(item) || viewModel.canDelete(item) || viewModel.canManage(item) || viewModel.canManage(item);
    }

    viewModel.canMove = function (item) {
        if (!item) {
            return false;
        }

        if (!item.IsFolder) {
            item = viewModel.currentFolder();
        }

        return viewModel.settings.permissions && viewModel.settings.permissions.EDIT === true && (item.CanMove === true || viewModel.canAdmin(item));
    }

    viewModel.canDelete = function (item) {
        if (!item) {
            return false;
        }

        if (!item.IsFolder) {
            item = viewModel.currentFolder();
        }

        return viewModel.settings.permissions && viewModel.settings.permissions.EDIT === true && (item.CanDelete === true || viewModel.canAdmin(item));
    }

    viewModel.canManage = function (item) {
        if (!item) {
            return false;
        }

        if (!item.IsFolder) {
            item = viewModel.currentFolder();
        }

        return viewModel.settings.permissions && viewModel.settings.permissions.EDIT === true && (item.CanManage === true || viewModel.canAdmin(item));
    }

    viewModel.canAdmin = function (item) {
        if (!item) {
            return false;
        }

        if (!item.IsFolder) {
            item = viewModel.currentFolder();
        }

        return viewModel.settings.permissions && viewModel.settings.permissions.EDIT === true && item.CanAdmin === true;
    }

    var changeSusbcription = function (value) {
        var method = value ? 'Subscribe' : 'Unsubscribe';
        var params = {
                    ItemId: viewModel.itemEditing.itemId(),
                    IsFolder: viewModel.itemEditing.isFolder()
                };
        assetsService().post(method, params, null, failed);
    };

    var getFullUrl = function (url) {
        if (url.indexOf("http://") == 0 || url.indexOf("https://") == 0) {
            return url;
        }

        return location.protocol + '//' + location.hostname + (location.port ? ':' + location.port : '') + url;
    };

    var bindFileDetails = function (data) {
        viewModel.itemEditing.createdOnDate(data.CreatedOnDate);
        viewModel.itemEditing.createdBy(data.CreatedBy);
        viewModel.itemEditing.lastModifiedOnDate(data.LastModifiedOnDate);
        viewModel.itemEditing.lastModifiedBy(data.LastModifiedBy);
        viewModel.itemEditing.size(data.Size);
        viewModel.itemEditing.title(data.Title);
        viewModel.itemEditing.description(data.Description);
        viewModel.itemEditing.url(getFullUrl(data.Url));
        viewModel.itemEditing.tags(data.Tags);
        viewModel.itemEditing.workflow(data.Workflow);
        viewModel.itemEditing.workflowHistory(data.WorkflowHistory);
        viewModel.itemEditing.workflowMessage("");

        !viewModel.subscribedSubscription || viewModel.subscribedSubscription.dispose();
        viewModel.itemEditing.subscribed(data.IsUserSubscribed);
        viewModel.subscribedSubscription = viewModel.itemEditing.subscribed.subscribe(changeSusbcription);
    };

    function bindFileVersions(data) {
        viewModel.itemEditing.versions.results(data.results);
        viewModel.itemEditing.versions.totalResults(data.totalResults);
    }

    var bindFolderDetails = function (data) {
        viewModel.itemEditing.createdOnDate(data.CreatedOnDate);
        viewModel.itemEditing.createdBy(data.CreatedBy);
        viewModel.itemEditing.lastModifiedOnDate(data.LastModifiedOnDate);
        viewModel.itemEditing.lastModifiedBy(data.LastModifiedBy);
        viewModel.itemEditing.folderType(data.Type);
        viewModel.itemEditing.versioning(data.IsVersioned);
        viewModel.itemEditing.workflowId(data.WorkflowId);
        viewModel.itemEditing.originalWorkflowId(data.WorkflowId);
        viewModel.itemEditing.workflowAction('publishAll');        

        !viewModel.subscribedSubscription || viewModel.subscribedSubscription.dispose();
        viewModel.itemEditing.subscribed(data.IsUserSubscribed);
        viewModel.subscribedSubscription = viewModel.itemEditing.subscribed.subscribe(changeSusbcription);

        buildPermissionGrid(data.Permissions);
    };

    var failed = function (x) {
    	var message = x.responseJSON.Message || 'Failed...';
		utility.notifyError(message);        
    };

    var buildPermissionGrid = function (data) {
        var gridContainer = wrapper.find('#folderPermissionsPanel > .folderPermissionsContainer');

        if (permissionGrid) {
            permissionGrid.getLayout().remove();
            permissionGrid = null;
        }

        var portalId = viewModel.selectedPortal();
        if (portalId === -2) {
            portalId = viewModel.itemEditing.portalId();
        }

        dnn.controls.PermissionGrid.resx = utility.resx.PersonaBar;

        var parent = { _getService: function() {
            var service = assetsService();
            return {
                get: function() {
                    service.get.apply(service, arguments);
                },
                post: function () {
                    service.post.apply(service, arguments);
                },
                getSearchUserUrl: function() {
                    return service.getServiceRoot() + service.controller + '/SearchUser?pid=' + portalId;
                }
            };
        } };
        permissionGrid = new dnn.controls.PermissionGrid(parent, data, { parameters: { pid: portalId } });
        gridContainer.prepend(permissionGrid.getLayout());
    };

    viewModel.hideDetails = function (notifySaved) {
        !viewModel.selectedItem() || viewModel.selectedItem().selected(false);
        viewModel.itemEditing.itemId(null);

        slideUpDetails(function() {
            wrapper.find("div.item-details").appendTo("div.item-details-container");

            if (notifySaved === true) {
                viewModel.selectedItem().saved(true);
                viewModel.selectedItem().ItemName(viewModel.itemEditing.itemName());
            }
        });        
    };

    viewModel.breadcrumbNavigate = function (folder) {
        if (viewModel.searchText() != '') {
        	viewModel.breadcrumb.splice(viewModel.breadcrumb.indexOf(folder));
            viewModel.currentFolder(folder);
            viewModel.inputSearchText('');
            viewModel.searchText('');
        } else {
            if (viewModel.currentFolder().FolderID != folder.FolderID) {
            	viewModel.breadcrumb.splice(viewModel.breadcrumb.indexOf(folder));
                getFolderContent(folder.FolderID);                
            }
        }
    };

    viewModel.resetSelectedPortal = function() {
        viewModel.inputSearchText('');
        viewModel.searchText('');
        viewModel.selectedPortal(-2);
        viewModel.rootFolderId(-1);
        viewModel.breadcrumb.removeAll();

        getFolderContent(viewModel.rootFolderId());
    };

    viewModel.breadcrumbFullText = ko.computed(function () {
        var names = [];
        ko.utils.arrayForEach(viewModel.breadcrumb(), function (x) { names.push(x.FolderName); });
        return names.join(" > ");
    });

    viewModel.goToParentFolder = function() {
        var i = viewModel.breadcrumb().length - 2;
        viewModel.breadcrumbNavigate(viewModel.breadcrumb()[i]);
    }

    viewModel.saveFileDetails = function () {
        if (!validator.validate(wrapper.find('div.file-details'))) return;

        var params = {
            fileId: viewModel.itemEditing.itemId(),
            fileName: viewModel.itemEditing.itemName(),
            title: viewModel.itemEditing.title(),
            description: viewModel.itemEditing.description(),
            tags: viewModel.itemEditing.tags()            
        }
        assetsService().post('SaveFileDetails', params, function () {
            viewModel.hideDetails(true);
        }, function (x) {
        	failed(x);
        	viewModel.itemEditing.fileNameFocused(true);
        });
    };

    viewModel.saveFolderDetails = function () {
        if (!validator.validate(wrapper.find('div.folder-details'))) return;

        var params = {
            folderId: viewModel.itemEditing.itemId(),
            folderName: viewModel.rootFolderId() === -1 ? "" : viewModel.itemEditing.itemName(),
            workflowId: viewModel.itemEditing.workflowId(),
            workflowAction: viewModel.itemEditing.workflowAction(),
            versioning: viewModel.itemEditing.versioning(),
            permissions: permissionGrid.getPermissions()
        }

        var hide = viewModel.hideDetails;
        assetsService().post('SaveFolderDetails', params, function () {
            hide(true);	                     
        }, function (x) {
        	failed(x);
        	viewModel.itemEditing.folderNameFocused(true);
		});
    };

    var search = function (folderId, searchText, page, sorting) {

        if (!page) {
            page = 0;            
        }

        var params = {
            folderId: folderId,
            search: searchText,
            pageIndex: 1,
            pageSize: itemsPerPage,
            sorting: sorting,
            culture: config.culture
        };

        assetsService().get('Search', params, function(d) {
            $("div.item-details").appendTo("div.item-details-container");

            if (page == 0) {
                viewModel.folderContent.removeAll();
                scrollTop();
                viewModel.lastPage(page);
            }

            var items = ko.mapping.fromJS(d.Items, mappingOptions);

            ko.utils.arrayPushAll(viewModel.folderContent, items());
            viewModel.totalItemCount(d.TotalCount);
        });
    }

    var scrollTop = function () {    	    
    	scrollItem[0].scrollTop = 0;
    };

    var refreshCurrentFolder = function (itemToHighlight) {
        getFolderContent(viewModel.currentFolder().FolderID, 0, itemToHighlight, viewModel.selectedSort());
    }

    var getFolderContent = function (folderId, page, itemToHighlight) {
        viewModel.itemToHighlight(itemToHighlight);
        viewModel.loading(true);

        if (!page) {
            page = 0;
        }

	    var params = {
	        folderId: folderId,
	        startIndex: page * itemsPerPage,
	        numItems: itemsPerPage,
	        sorting: viewModel.selectedSort()
	    };

	    viewModel.itemEditing.itemId(null);

	    assetsService().get('GetFolderContent', params, function (d) {
	        if (d.Folder.FolderID == viewModel.getRootFolderId()) {
                d.Folder.FolderName = viewModel.resx.lbl_Root;
            }

	        if (page == 0) {
	            $("div.item-details").appendTo("div.item-details-container");
	            viewModel.folderContent.removeAll();
	            viewModel.currentFolder(d.Folder);	            
	            scrollTop();	
	            
	            viewModel.lastPage(page);
	        }
	        
	        if (d.Folder.FolderID > -1 &&
	        (viewModel.breadcrumb().length == 0 || viewModel.breadcrumb()[viewModel.breadcrumb().length - 1].FolderID != d.Folder.FolderID)) {
	            viewModel.breadcrumb.push({
	                FolderID: d.Folder.FolderID,
	                FolderName: d.Folder.FolderName
	            });
	        }

	        var items = ko.mapping.fromJS(d.Items, mappingOptions);
            
	        ko.utils.arrayPushAll(viewModel.folderContent, items());
	        viewModel.totalItemCount(d.TotalCount);
	        viewModel.loading(false);
	    }, failed);
    };

    var goToFolder = function (folderId) {
        if (folderId !== -1) {
            assetsService().get('GetFolderPath', { folderId: folderId }, function (d) {
                viewModel.breadcrumb.removeAll();
                ko.utils.arrayPushAll(viewModel.breadcrumb, d);
            });
        }
        getFolderContent(folderId);
    };

    viewModel.selectedFolderChanged = function (folder) {
        if (viewModel.currentFolder().FolderID !== folder.key) {
            goToFolder(folder.key);	            
        }
    };

    var initFileUpload = function () {
        var panel = wrapper.find("div.add-asset > div.file-upload-panel");
        fileUpload = parent.dnn[config.fileUploadClientId];
        if (panel.is(":empty")) {
            fileUpload.$element.appendTo(panel);
            var scrollBar = fileUpload.$element.find('.fu-fileupload-statuses-container').data('jScrollbar');
            if (scrollBar) {
                scrollBar.options.document = document;
            }
            
            fileUpload.$element.on("show-statuses-container", function () {
                var h = wrapper.find("div.add-asset").outerHeight();
                itemContainer.animate({ top: 150 + h });
            }).on("onfileuploadcomplete", function (e, d) {
                var data = JSON.parse(d);
                if (data.fileId && data.alreadyExists === false) {
                    //closeTopPanel();
                    refreshCurrentFolder({ itemName: data.fileName, isFolder: false });
                }
            });
        }

        panel.find("a.upload-file").on("click", function () {
            panel.find("input[type=file]").click();
        });

        itemContainer.on("dragover", function (e) {
            e.stopPropagation();
            e.preventDefault();
            $(e.delegateTarget).addClass("drop-target");
	        e.originalEvent.dataTransfer.dropEffect = 'copy';
        }).on("dragleave", function(e) {
            e.stopPropagation();
            e.preventDefault();
            if (e.target == e.delegateTarget) {
                $(e.delegateTarget).removeClass("drop-target");                
            }
        }).on("drop", function (e) {
            e.stopPropagation();
            e.preventDefault();
            $(e.delegateTarget).removeClass("drop-target");

            var files = e.originalEvent.dataTransfer.files;

            fileUpload.setUploadPath(getCurrentFolderPath());
            showTopPanel("add-asset", function() {
                fileUpload.addFiles(files);                
            });
        });

        // override z-index for upload notification dialog
        var style = $("<style>" + 
                ".dnnFormPopup { z-index: 10000000; }" +
                ".dnnFormPopup .ui-widget-overlay { z-index: 9999999; }" +
            "</style>");                
        $('html > head', window.parent.document).append(style);
    };

    var isImage = function(url) {
        var imageExtensions = ["JPG", "JPE", "BMP", "GIF", "PNG", "JPEG", "ICO"];
        var ext = url.split(".").reverse()[0].toUpperCase();
        for (var i = 0; i < imageExtensions.length; i++) {
            if (imageExtensions[i] === ext) return true;
        }
        return false;
    };
    
    viewModel.replaceFile = function () {
        viewModel.uploading.overwrite = true;
        wrapper.find("#uploader").fileupload('add', { files: viewModel.uploading.pendingFiles });
    };

    viewModel.highlightItemName = function (itemName) {
        var pattern = viewModel.searchText();
        if (!pattern || pattern == "" || pattern.indexOf("?") != -1) {
            return itemName;
        }

        var words = pattern.split(' ');
        for (var w = 0; w < words.length; w++) {
            var word = words[w];
            if (word.indexOf('[') == 0 || word.indexOf('after:') == 0) {
                continue;
            }

            if (word.indexOf('\"') == 0 && word.lastIndexOf('\"') == word.length - 1) {
                word = word.substring(1, word.length - 1);
            }

            word = word.replace('*', '');
            var matches = itemName.match(new RegExp(word, "i"));
            if (matches) {
                for (var i = 0; i < matches.length; i++) {
                    itemName = itemName.replace(matches[i], "<font class='highlight'>" + matches[i] + "</font>");
                }
            }
        }

        return itemName;
    };

    viewModel.iconUrl = function (item, element) {
        var url = '';
        if (item.IsFolder) {
            url = item.IconUrl;
        } else {
            var $element = $(element);
            url = !item.ThumbnailAvailable ? item.IconUrl :
                    item.ThumbnailUrl
                        .replace(/(width=)[^\&]+/, '$1' + $element.width())
                        .replace(/(height=)[^\&]+/, '$1' + $element.height());
        }

        return url ? 'url("' + url + '")' : '';
    };

    viewModel.pendingPages = ko.computed(function () {
        var loadedItems = (viewModel.lastPage() + 1) * itemsPerPage;
        return loadedItems < viewModel.totalItemCount();
    });

    viewModel.getNextPage = function () {
        viewModel.lastPage(viewModel.lastPage() + 1);
        getFolderContent(viewModel.currentFolder().FolderID, viewModel.lastPage(), viewModel.itemToHighlight());
    };

    function workflowAction(method, completed) {
        var params = {
            fileId: viewModel.itemEditing.itemId(),
            currentStateId: viewModel.itemEditing.workflow().WorkflowStateId,
            userMessage: viewModel.itemEditing.workflowMessage()
        };
        assetsService("Workflow").post(method, params, completed, failed);
    }

    function removeWorkflowStateInProgress(fileId) {
        var item = ko.utils.arrayFirst(viewModel.folderContent(),
            function (item) {
                return item.ItemID === fileId && !item.Isfolder;
            });
        item.WorkflowStateInProgress(null);
    }

    function updateWorkflowStateInProgress(fileId, state) {
        var item = ko.utils.arrayFirst(viewModel.folderContent(),
            function (item) {
                return item.ItemID === fileId && !item.Isfolder;
            });
        item.WorkflowStateInProgress(state);
    }

    viewModel.completeWorkflowState = function () {
        workflowAction("CompleteWorkflowState", function (result) {
            utility.notify(utility.resx.Assets.WorkflowOperationProcessedSuccessfully);
            var fileId = viewModel.itemEditing.itemId();
            if (result.workflowHasBeenCompleted) {
                removeWorkflowStateInProgress(fileId);
                refreshCard(fileId, true);
            } else {
                updateWorkflowStateInProgress(fileId, result.currentState);
            }
            viewModel.hideDetails();
        });
    }

    viewModel.discardWorkflowState = function () {
        workflowAction("DiscardWorkflowState", function (result) {
            utility.notify(utility.resx.Assets.WorkflowOperationProcessedSuccessfully);
            if (result.fileHasBeenDeletedOnDiscard) {
                refreshCurrentFolder();
            } else {
                if (result.fileWorkflowHasBeenDiscarded) {
                    var fileId = viewModel.itemEditing.itemId();
                    removeWorkflowStateInProgress(fileId);
                    refreshCard(fileId, true);
                }
                viewModel.hideDetails();
            }
        });
    }

    return {
	    init: function (wrap, util, params, callback) {
	        wrapper = wrap;
			utility = util;
			tabpanel.init(viewModel);
			if (typeof window.String === 'undefined' || typeof window.String.format === 'undefined') {
			    window.String = !window.String ? window.top.String : window.String;
			    window.String.format = !window.String.format ? window.top.String.format : window.String.format;
			}

	        var resx = utility.resx.Assets;
	        pager.init(viewModel.itemEditing.versions, 10, getVersions, {
	            pager_ItemDesc: resx.pager_ItemDesc,
	            pager_ItemPagedDesc: resx.pager_ItemPagedDesc,
	            pager_PageDesc: resx.pager_PageDesc
	        });

	        viewModel.sortOptions([
	            { value: "LastModifiedOnDate", name: resx.sort_LastModified },
	            { value: "CreatedOnDate", name: resx.sort_DateUploaded },
	            { value: "ItemName", name: resx.sort_Alphabetical }
	        ]);

	        viewModel.settings =  params && params.settings ? params.settings : {};

			var defaults = { numberOfRows: 6 };
	        var p = $.extend({}, defaults, params);

	        itemContainer = wrapper.find('div.item-container');
	        containerTop = parseInt(itemContainer.css("top"));
	        scrollItem = p.scrollItem || itemContainer;

			itemContainer.on('scroll', function () {				
		        var scrollHeight = $(this)[0].scrollHeight;
		        var scrollPosition = $(this).scrollTop() + $(this).outerHeight();

		        if (scrollPosition >= scrollHeight - 50 - parseInt($(this).css('padding-bottom'))
                    && viewModel.pendingPages()) {
		            viewModel.getNextPage();
		        }
			});

	        initFileUpload();

	        wrapper.find('input[type="checkbox"].switch').dnnCheckbox({ cls: "dnnCheckbox" });

	        var $uploadCheckbox = wrapper.find('.fu-dialog-content .fu-dialog-content-header .dnnLeft > span input[type="checkbox"]');
	        $uploadCheckbox.dnnCheckbox();
	        utility.localizeErrMessages(validator);
	        
			var container = wrapper[0];
			viewModel.resx = resx;
			ko.applyBindings(viewModel, container);

			$('.header-container select').easyDropDown({});

			if (params && params.settings && typeof params.settings.portalId === "number") {
			    viewModel.selectedPortal(params.settings.portalId);
			    loadWorkflows();
			}

			if (params && params.settings && typeof params.settings.rootFolderId === "number") {
			    viewModel.rootFolderId(params.settings.rootFolderId);
			}

			var folderId = params && params.folderId ? params.folderId : viewModel.getRootFolderId();
	        goToFolder(folderId);

	        if (typeof callback === 'function') callback();
		},

        initMobile: function (wrap, util, params, callback) {

            var defaults = { numberOfRows: 10 };
            var p = $.extend({}, defaults, params);
            p.scrollItem = $("div.body");

            this.init(wrap, util, p, callback);
        },

        load: function (params, callback) {
            var folderId = params && params.folderId ? params.folderId : viewModel.getRootFolderId();
            goToFolder(folderId);

            if (typeof callback === 'function') callback();
        },

        loadMobile: function(params, callback) {
            this.load(params, callback);
        }
	};
});
