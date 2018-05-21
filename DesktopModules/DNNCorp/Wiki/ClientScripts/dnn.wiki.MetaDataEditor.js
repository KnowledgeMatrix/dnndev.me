// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.

if (typeof dnn === 'undefined' || !dnn ) dnn = {};
if (typeof dnn.wiki === 'undefined') dnn.wiki = {};

(function(dnn) {
    'use strict';

    dnn.wiki.MetaDataEditor = function MetaDataEditor(settings) {
        var that = this;

        var social = new dnn.social.Module(settings);

        this.list = window.ko.observableArray();

        this.addedEmptyFilePlaceHolder = false;

        $.each(settings.metadatas || [],
            function (unused, metadata) {
                if (metadata.Enabled) {
                    var setting = dnn.social.komodel(metadata);
                    setting.value = window.ko.observable();
                    that.list.push(setting);
                }
            });

        $.each(settings.metadataValues.dataTable || [],
            function (key, value) {
                for (var i = 0; i < that.list().length; ++i) {
                    if (that.list()[i].key() == key) {
                        that.list()[i].value(value);
                        break;
                    }
                }
            });

        dnn.wiki.editMeta = function () {
            var localizer = social.getLocalizationController();

            var options = {
                modal: true,
                autoOpen: true,
                dialogClass: 'dnnFormPopup',
                closeOnEscape: false,
                title: localizer.getString('EditMetaData'),
                resizable: false,
                minWidth: 690,
                buttons:
                [
                    {
                        priority: 'primary',
                        'class': 'dnnPrimaryAction',
                        text: localizer.getString('Save'),
                        click: that.save
                    },
                    {
                        priority: 'secondary',
                        'class': 'dnnSecondaryAction',
                        text: localizer.getString('Cancel'),
                        click: that.cancel
                    }
                ]
            };

            $(settings.moduleScope).dialog(options);

            dnn.social.EventQueue.push(that.bindControls);
        };

        this.getImageId = function () {
            try {
                var dnnFileUploadSettings = dnn.dnnFileUpload.settings[settings.imageScope];
                var filesCombo = dnn[dnnFileUploadSettings.filesComboId];
                var selectedFileId = filesCombo.selectedItem() ? filesCombo.selectedItem().key : "-1";
                return parseInt(selectedFileId);
            } catch (ex) { }
            
            return -1;
        };

        this.save = function () {
            var failure = function (xhr, status) {
                var localizer = social.getLocalizationController();

                var text = localizer.getString('UnableToSaveText');
                
                if (typeof status === 'string') {
                    text += ': ';
                    text += status;
                }

                $.dnnAlert({
                    title: localizer.getString('UnableToSave'),
                    text: text
                });
            };

            var success = function() {
                that.cancel();

                var msg = {
                    event: 'LoadMetadata'
                };

                dnn.social.ipc.post(settings, 'DNNCorp/Wiki', msg);
            };

            var loading = function (b) {
                var c = $(settings.moduleScope);
                if (b) {
                    c.addClass('loading');
                } else {
                    c.removeClass('loading');
                }
            };

            var table = {};

            $.each(that.list(),
                function (unused, m) {
                    table[m.settingId()] = m.value();
                });

            var params = {
                articleId: settings.articleId,
                dataTable: table,
                imageId: that.getImageId()
            };

            var service = social.getService('Content');

            service.post('SetMetaData', params, success, failure, loading);
        };

        this.cancel = function () {
            $(settings.moduleScope).dialog('close');
        };

        this.bindControls = function () {
            $('.meta-datepicker').datepicker();

            var center = function() {
                $(settings.moduleScope).dialog('option', 'position', 'center');
            };

            $('#tab-selector-metadata').click(
                function () {
                    $('.wiki-meta-tabs > ul.dnnAdminTabNav > li').removeClass('ui-tabs-active');
                    $(this).parent().addClass('ui-tabs-active');
                    $('#tabs-image').hide();
                    $('#tabs-metadata').show();
                    center();
                    return false;
                });

            $('#tab-selector-image').click(
                function () {
                    $('.wiki-meta-tabs > ul.dnnAdminTabNav > li').removeClass('ui-tabs-active');
                    $(this).parent().addClass('ui-tabs-active');
                    $('#tabs-metadata').hide();
                    $('#tabs-image').show();
                    center();
                    return false;
                });

            $('#tab-selector-image').click();
        };

        this.binded = function() {
            if (!settings.modal) {
                this.bindControls();
            }
        };
    };
})(window.dnn);
