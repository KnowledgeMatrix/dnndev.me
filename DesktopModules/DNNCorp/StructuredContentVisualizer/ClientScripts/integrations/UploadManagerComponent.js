﻿
define(['knockout','text!evoqLibraryPath/UploadManager.html','dnn.jquery','dnn.servicesframework','dnn.extensions','dnn.DataStructures','dnn.jquery.extensions','jquery.fileupload','dnn.DropDownList','dnn.jScrollBar','evoqLibraryPath/RequestUtils','evoqLibraryPath/dnn.Localization','evoqLibraryPath/UploadManager','evoqLibraryPath/ko.folderPicker','css!evoqLibraryCssPath/upload.css','evoqLibraryPath/../../../../Resources/Shared/scripts/TreeView/dnn.DynamicTreeView','evoqLibraryPath/../../../../Resources/Shared/scripts/TreeView/dnn.TreeView','css!evoqLibraryPath/../../../../Resources/Shared/components/DropDownList/dnn.DropDownList.css'],function(ko,template){'use strict';window.ko=ko;var TIMEOUT_FOR_LOCALIZATION_RESOURCES=100;var UPLOAD_COMPONENT_CLASS=' > .upload';var _config,_localizationLoaded;_config={resx:false};_localizationLoaded=false;function localizeTemplate(template,resx){for(var key in resx){var regex=new RegExp("\\[\\["+key+"\\]\\]","g");template=template.replace(regex,resx[key]);}
return template;};function createUploadManager(parentId,maxFileSize,resx){var config={bindingElementSelector:parentId+UPLOAD_COMPONENT_CLASS,moduleName:'structuredcontentvisualizer',fileUploadControllerName:'FileUpload',uploadFromUrlMethodName:'UploadFromUrl',uploadFileMethodName:'UploadImage',multipleFiles:false,fromUrlTabVisible:false,acceptedFilesAttribute:'',fileBrowserModuleName:'structuredcontentvisualizer',fileBrowserControllerName:'FileUpload',getFilesMethodName:'GetImages',dragAndDropImageLiteral:resx.DragAndDropImage,dragAndDropDocumentLiteral:resx.DragAndDropDocument,dragAndDropImagesLiteral:resx.DragAndDropImages,dragAndDropDocumentsLiteral:resx.DragAndDropDocuments,insertImageLiteral:resx.InsertImage,insertDocumentLiteral:resx.InsertDocument,insertImagesLiteral:resx.InsertImages,insertDocumentsLiteral:resx.InsertDocuments,lazyFilesLoad:true,uploadFileTabVisible:true,maxFileSize:_config.maxFileSize+"",fileIsTooLargeLiteral:_config.resx.FileIsTooLargeError.replace("{0}",_config.maxFileSize/(1024*1024))+" Mb"};var uploadManager=window.dnn.ui.components.upload.createUploadManager();uploadManager.init(config);return uploadManager;};function create(parentSelector,callback){if(!_localizationLoaded){setTimeout(function(){create(parentSelector,callback);},TIMEOUT_FOR_LOCALIZATION_RESOURCES);return;}
template=localizeTemplate(template,_config.resx);$(parentSelector).empty();$(parentSelector).append(template);setTimeout(function(){var uploadManager=createUploadManager(parentSelector,_config.maxFileSize,_config.resx);callback(uploadManager);},0);};function loadConfiguration(){if(!_config.resx){_config.resx=true;var localizationOptionsUpload={service:'DNNCorp/EvoqLibrary',controller:'UploadManagerConfig',resxName:'UploadResx',resourceSettings:{method:'GetSettings',callback200:function(data){_config.maxFileSize=data.maxFileSize;}},resources:{method:'GetLocalization',paramName:'localization',callback200:function(data){_localizationLoaded=true;_config.resx=data.localization;},callbackError:function(data){console.log('Error',data);}}};new dnn.utils.Localization(localizationOptionsUpload);}};function configureVerificationToken(){var inIframe=window!=window.top;if(inIframe)
{var parentVerificationToken=parent.$('[name="__RequestVerificationToken"]');parentVerificationToken.clone().appendTo(document.body);}};function init(){loadConfiguration();configureVerificationToken();};return{init:init,create:create}});