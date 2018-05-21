// DotNetNuke® - http://www.dnnsoftware.com
//
// Copyright (c) 2002-2016, DNN Corp.
// All rights reserved.
"use strict";
define(['jquery',
        'knockout',
        'templatePath/scripts/PersonaBarDialog',
        'knockout.validation.min',
		'dnn.servicesframework',
        'dnn.jquery',
        'dnn.extensions',
        'dnn.jquery.extensions',
        'dnn.DataStructures',
        'jquery.mousewheel',
        'dnn.jScrollBar',
        'dnn.TreeView',
        'dnn.DynamicTreeView',
        'dnn.DropDownList',
		'css.DropDownList',
        'jquery.tokeninput',
        'css!../../../../Admin/Dnn.PersonaBar/css/tokenInput.css',
		'css.jScrollBar'],
function ($, ko, PersonaBarDialog) {
    var bindViewModel,
        advancedViewModel,
        rootFolder,
        utility,
        helper,
        rules,
        fields,
        allFields,
        singleField,
        dnnRolesArray,
        dnnRolesObject,
        $roleTokenInput;

    var constants = {
        AUTOMATIC_TICKET_CREATION_SETTING_NAME: "Zendesk_AutoTicketCreationEnabled",
        CREATE_TICKETS_FOR_ANSWERS_AFTER_HOURS_SETTING_NAME: "ZenDesk_CreateAnswersTicketsAfterHours",
        CREATE_TICKETS_FOR_DISCUSSIONS_AFTER_HOURS_SETTING_NAME: "ZenDesk_CreateDiscussionsTicketAfterHours",
        CREATE_TICKETS_FOR_ROLES: "ZenDesk_CreateTicketForRoles"
    };

    var init = function (koObject, connectionHelper, pluginFolder, util) {
        bindViewModel = koObject;
        rootFolder = pluginFolder;
        utility = util;
        helper = connectionHelper;

        $(document.body).on('click', '#connector-Zendesk .advancedSetting', onAdvancedClick);

        initRequiredResources();
        getAdvancedViewModel();
    }

    var onSave = function (koObject) {
        var automaticTicketCreationEnabled = getConfigurationObservable(constants.AUTOMATIC_TICKET_CREATION_SETTING_NAME);
        if (!automaticTicketCreationEnabled) {
            return;
        }
        automaticTicketCreationEnabled.value(advancedViewModel.isAutomaticTicketCreationEnabled() + '');
    }

    var initRequiredResources = function () {
        if (typeof dnn === 'undefined') {
            window.Sys = !window.Sys ? window.top.Sys : window.Sys;
            window.dnn = !window.dnn ? window.top.dnn : window.dnn;
        }
    }

    var initTokenInput = function (roles) {
        $roleTokenInput = $('#zendeskRolePicker');
        $roleTokenInput.tokenInput(roles, {
            propertyToSearch: 'RoleName',
            preventDuplicates: true,
            resultsFormatter: function (item) {
                return '<li>' + item[this.propertyToSearch] + "</li>"; // Default formatter
            },
            onAdd: function (item) {
                advancedViewModel.createTicketForRoles.push(item.id);
            },
            onDelete: function (item) {
                var roles = advancedViewModel.createTicketForRoles;
                var indexOf = roles.indexOf(item.id);
                if (indexOf === -1) {
                    return;
                }
                roles.splice(indexOf, 1);
            },
            onReady: function() {
                $('#token-input-' + $roleTokenInput.Attr('id')).Attr('aria-label', 'Token');
            }
        });
        var roles = getConfigurationObservable(constants.CREATE_TICKETS_FOR_ROLES);
        if (roles) {
            roles = roles.value().split(',');
            $.each(roles, function (index, roleId) {
                var role = dnnRolesObject[roleId];
                if (role) {
                    $roleTokenInput.tokenInput('add', {
                        id: role.RoleId,
                        RoleId: role.RoleId,
                        RoleName: role.RoleName
                    });
                }
            });
        }
    }

    var bindAutoTicketCreationSettings = function () {
        var createTicketForAnswersValue = getConfigurationObservable(constants.CREATE_TICKETS_FOR_ANSWERS_AFTER_HOURS_SETTING_NAME);
        createTicketForAnswersValue = !createTicketForAnswersValue ? 0 : createTicketForAnswersValue.value();
        advancedViewModel.createTicketForAnswersAfterHours(createTicketForAnswersValue);
        var createTicketForDiscussionsValue = getConfigurationObservable(constants.CREATE_TICKETS_FOR_DISCUSSIONS_AFTER_HOURS_SETTING_NAME);
        createTicketForDiscussionsValue = !createTicketForDiscussionsValue ? 0 : createTicketForDiscussionsValue.value();
        advancedViewModel.createTicketForDiscussionAfterHours(createTicketForDiscussionsValue);
    }

    var bindRoles = function () {
        if (!dnnRolesArray) {
            utility.sf.moduleRoot = 'DNNCorp/ZendeskConnector';
            utility.sf.controller = 'Services';
            utility.sf.get('GetAvailableRoles', {}, function (data) {
                dnnRolesObject = {};
                $.each(data.roles, function (index, role) {
                    role.id = role.RoleId; // token input needs an id property
                    dnnRolesObject[role.RoleId] = role;
                });
                dnnRolesArray = data.roles;
                initTokenInput(dnnRolesArray);
            });
        } else {
            initTokenInput(dnnRolesArray);
        }
    }

    var onAfterBind = function () {
        advancedViewModel.fields().length = 0;

        advancedViewModel.fields.push({
            id: 1,
            fieldName: "Subject",
            fieldType: "text",
            removable: false
        });

        advancedViewModel.fields.push({
            id: 2,
            fieldName: "Description",
            fieldType: "textarea",
            removable: false
        });

        if (!allFields) {
            utility.sf.moduleRoot = 'DNNCorp/ZendeskConnector';
            utility.sf.controller = 'Services';
            utility.sf.get('GetFields', {}, function (data) {
                allFields = data;

                var savedFieldIds = splitFieldIdSettings();

                if (savedFieldIds.length > 0) {
                    for (var i = 0; i < savedFieldIds.length; i++) {
                        processFieldAdd(savedFieldIds[i]);

                        for (var j = 0; j < allFields.length; j++) {
                            if (allFields[j].FieldId === parseInt(savedFieldIds[i])) {
                                allFields.splice(j, 1);
                            }
                        }
                    }
                }

                createFieldsDropDown();
            });
        } else {
            createFieldsDropDown();
        }
        bindRoles();
        bindAutoTicketCreationSettings();

        $(document.body).on('click', '.conn-zd-addField', addFieldClick);
    }

    var createFieldsDropDown = function () {
        if (advancedViewModel && advancedViewModel.fieldData().length == 0) {
            advancedViewModel.fieldData.push({ FieldName: bindViewModel.resx.SelectAField, FieldId: -1 });

            for (var i = 0; i < allFields.length; i++) {
                advancedViewModel.fieldData.push(allFields[i]);
            }
        }

        if (advancedViewModel.fieldData().length <= 1) {
            $('.conn-zd-advancedSetting .addFields').hide();
            $('.conn-zd-advancedSetting .noFields').show();
        } else {
            $('.conn-zd-advancedSetting .addFields').show();
            $('.conn-zd-advancedSetting .noFields').hide();
        }
    }

    var getAutomaticTicketCreationBooleanValue = function () {
        var automaticTicketCreationValue =
               getConfigurationObservable(constants.AUTOMATIC_TICKET_CREATION_SETTING_NAME);
        if (!automaticTicketCreationValue) {
            automaticTicketCreationValue = "";
        } else {
            automaticTicketCreationValue = automaticTicketCreationValue.value();
        }
        return automaticTicketCreationValue.toLowerCase() === 'true';
    }

    var getAdvancedViewModel = function () {
        if (!advancedViewModel) {


            advancedViewModel = {

                createTicketForAnswersAfterHours: ko.observable('').extend({ required: true, number: true }),
                createTicketForDiscussionAfterHours: ko.observable('').extend({ required: true, number: true }),
                createTicketForRoles: ko.observableArray([]),
                editModel: {
                    id: ko.observable(-1),
                    label: ko.observable('').extend({ required: true }),
                    value: ko.observable('').extend({ required: true }),
                    page: ko.observable(''),
                    field: ko.observable(''),
                    role: ko.observable('-1')
                },
                isAutomaticTicketCreationEnabled: ko.observable(getAutomaticTicketCreationBooleanValue()),
                rules: ko.observableArray(rules),
                fields: ko.observableArray(fields),
                fieldData: ko.observableArray([]),
                resx: bindViewModel.resx,
                showSuccessMessage: ko.observable(false),
                showErrorMessage: ko.observable(''),
                errorMessage: ko.observable(''),
                removeField: onRemoveField
            }
        } else {
            resetEditModel();
        }

        return advancedViewModel;
    }

    var getConfigurationObservable = function (propertyName) {
        var configurations = bindViewModel.configurations;
        for (var i = 0; i < configurations.length; i++) {
            var configuration = configurations[i];
            if (configuration.name === propertyName) {

                return configuration;
            }
        }
        return null;
    }

    var resetEditModel = function () {

    }

    var splitFieldIdSettings = function () {
        var fieldIdArray = [];
        for (var i = bindViewModel.configurations.length - 1; i >= 0; i--) {
            var config = bindViewModel.configurations[i];
            if (config.name === 'ZenDesk_FieldIds') {
                fieldIdArray = config.value() ?  config.value().split(',') : [];
            }
        }

        return fieldIdArray;
    }

    var activateScheduleComplete = function(activated) {
        if (!activated) {
            advancedViewModel.errorMessage(bindViewModel.resx.ErrorActivatingScheduleTask);
            advancedViewModel.showErrorMessage(true);
        }
    }

    var activateScheduler = function () {
        utility.sf.moduleRoot = 'DNNCorp/ZendeskConnector';
        utility.sf.controller = 'Services';
        utility.sf.post('ActivateScheduleTask', {}, function (data) {
            activateScheduleComplete(data.activated);
        });
    }

    var onSaveComplete = function (connected, success) {
        advancedViewModel.showSuccessMessage(success);

        if (!success) {
            advancedViewModel.errorMessage(bindViewModel.resx.AdvancedSettingsErrorSaving);
            advancedViewModel.showErrorMessage(true);
        } else {
            if (advancedViewModel.isAutomaticTicketCreationEnabled()) {
                activateScheduler();
            }
        }
    }

    var onAdvancedSettingAccept = function () {
        advancedViewModel.showSuccessMessage(false);
        advancedViewModel.showErrorMessage(false);
        advancedViewModel.errorMessage('');
        //we don't need to validate as there are no open ended fields for user input
        //var editModel = advancedViewModel.editModel;
        //var result = ko.validation.group(editModel, { deep: true });
        //if (!editModel.isValid()) {
        //    result.showAllMessages(true);
        //    return;
        //}
        var createTicketForAnswersInterval = advancedViewModel.createTicketForAnswersAfterHours;
        var createTicketForDiscussionsInterval = advancedViewModel.createTicketForDiscussionAfterHours;
        if (advancedViewModel.isAutomaticTicketCreationEnabled() && (!createTicketForAnswersInterval.isValid() || !createTicketForDiscussionsInterval.isValid())) {
            return false;
        }

        var fieldsArray = advancedViewModel.fields();
        var fieldIdList = "";

        //loop through the fields
        for (var i = 0; i < fieldsArray.length; i++) {
            //check if the field is not one of the defaults
            if (fieldsArray[i].id > 2 || fieldsArray[i].id < -1) {
                fieldIdList += fieldsArray[i].id + ',';
            }
        }

        //trim the last comma
        fieldIdList = fieldIdList.replace(/,\s*$/, "");

        bindViewModel.configurations.push({
            name: 'ZenDesk_FieldIds',
            value: ko.protectedObservable(fieldIdList)
        });

        var configurations = bindViewModel.configurations;
        for (var i = 0; i < configurations.length; i++) {
            var configuration = configurations[i];
            if (configuration.name === constants.CREATE_TICKETS_FOR_ANSWERS_AFTER_HOURS_SETTING_NAME) {
                configuration.value(createTicketForAnswersInterval());
            } else if (configuration.name === constants.CREATE_TICKETS_FOR_DISCUSSIONS_AFTER_HOURS_SETTING_NAME) {
                configuration.value(createTicketForDiscussionsInterval());
            } else if (configuration.name === constants.CREATE_TICKETS_FOR_ROLES) {
                configuration.value(advancedViewModel.createTicketForRoles().join(','));
            }
        }

        helper.saveConnection(bindViewModel, onSaveComplete, true);
    }

    var onAdvancedSettingCancel = function () {

    }

    var onRemoveField = function (item, e) {
        //confirm that we want to remove the field
        utility.confirm(bindViewModel.resx.RemoveConfirm,
                        bindViewModel.resx.Removebtn,
                        bindViewModel.resx.Cancelbtn,
                        function () {
                            doRemoveField(item);
                        });
    }

    var doRemoveField = function (item) {
        //get the array from the observable
        var fieldsArray = advancedViewModel.fields();

        for (var i = 0; i < fieldsArray.length; i++) {
            if (fieldsArray[i].id === item.id) {
                //put the item back in the drop down.
                allFields.push({
                    FieldId: fieldsArray[i].id,
                    FieldName: fieldsArray[i].fieldName
                });

                //remove it from the table
                fieldsArray.splice(i, 1);

                break;
            }
        }

        //push the change back to the observable
        advancedViewModel.fields(fieldsArray);

        //reset the add field dropdown
        advancedViewModel.fieldData().length = 0;
        createFieldsDropDown();
    }

    var onAdvancedClick = function () {
        require(['text!rootPath' + rootFolder + 'advanced.htm'], function (html) {
            var dialog = new PersonaBarDialog({
                inObject: $('body'),
                width: 771,
                title: bindViewModel.resx.AdvancedSettings,
                innerTitle: bindViewModel.resx.AdvancedSettingsTitle,
                cancelBtnLbl: 'Close',
                acceptBtnLbl: 'Save',
                onAcceptCallback: onAdvancedSettingAccept,
                closeOnAccept: false,
                onCloseCallback: onAdvancedSettingCancel
            }, html, getAdvancedViewModel, onAfterBind);
        });
    }

    var processFieldAdd = function (fieldId) {
        utility.sf.moduleRoot = 'DNNCorp/ZendeskConnector';
        utility.sf.controller = 'Services';
        utility.sf.get('GetField', { FieldId: fieldId }, function (data) {
            singleField = data;

            if (singleField && singleField.id) {
                advancedViewModel.fields.push({
                    id: singleField.id,
                    fieldName: singleField.title,
                    fieldType: singleField.type,
                    removable: true
                });

                for (var i = 0; i < allFields.length; i++) {
                    if (allFields[i].FieldId === fieldId) {
                        allFields.splice(i, 1);
                    }
                }

                advancedViewModel.fieldData().length = 0;
                createFieldsDropDown();
            }
        });
    }

    var addFieldClick = function () {
        var fieldId = advancedViewModel.editModel.field();
        processFieldAdd(fieldId);
    }

    return {
        init: init,
        onSave: onSave
    }
});