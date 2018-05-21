define([
    'jquery',
    'main/config',
    'main/../../../../DesktopModules/DNNCorp/EvoqLibrary/ClientScripts/UploadManagerComponent',
    'css!../../../../../../../DesktopModules/DNNCorp/EvoqLibrary/Css/upload.css',
    'css!../../../../../../../Resources/Shared/components/DropDownList/dnn.DropDownList.css'],
function ($, config, uploadManagerComponent) {
    var PARENT_SELECTOR = "#form-filePickerEvoqParentId";

    function getFileTypeOptions(fileType, cf) {
        var options = {
            method: "",
            extensions: "",
            documentsLiterals: false
        }
        if (fileType === "document") {
            options.method = "UploadDocument";
            options.extensions = cf.filePickerDocumentsExtensions;
            options.getFilesMethod = "GetDocuments";
            options.documentsLiterals = true;
        }
        else if (fileType === "file") {
            options.method = "UploadFile";
            options.extensions = (cf.filePickerDocumentsExtensions + ',').replace(/\,$/, '').concat(',').concat(cf.filePickerImagesExtensions);
            options.getFilesMethod = "GetFiles";
            options.documentsLiterals = true;
        }
        else {
            options.method = "UploadImage";
            options.extensions = cf.filePickerImagesExtensions;
            options.getFilesMethod = "GetImages";
        }
        return options;
    };

    function initUploadManager(wrapper, cf, options) {
        uploadManagerComponent.create(PARENT_SELECTOR,
            function (uploadManager) {
                var fileTypeOptions = getFileTypeOptions(options.fileType, cf);
                uploadManager.setOnImageUploaded(options.onFilesUpload);
                uploadManager.setOnError(options.onError);
                uploadManager.setMultipleFiles(options.multipleFiles);
                uploadManager.setUploadFileMethodName(fileTypeOptions.method);
                uploadManager.setAcceptedFilesAttribute(fileTypeOptions.extensions);
                uploadManager.setGetFilesMethodName(fileTypeOptions.getFilesMethod);
                uploadManager.showDocumentsLiterals(fileTypeOptions.documentsLiterals);
                uploadManager.clearSelectedFiles();
                uploadManager.setUploadFileTabVisible(options.allowUpload || false);

                moveFilePicker($(PARENT_SELECTOR).children("div").eq(0),
                $("#" + wrapper));
            }
        );
    };

    function moveFilePicker(filePicker, destWrapper) {
        filePicker.appendTo(destWrapper);
    }

    var renderFilePicker = function (wrapper, options) {
        var cf = config.init();
        initUploadManager(wrapper, cf, options);
    };

    var removeFilePicker = function (wrapper) {
        moveFilePicker($("#" + wrapper).children("div").eq(0),
            $(PARENT_SELECTOR));
    }

    uploadManagerComponent.init();

    return {
        init: function init(wrapper, options) {
            renderFilePicker(wrapper, options);
        },
        close: function close(wrapper) {
            removeFilePicker(wrapper);
        }
    }
});
