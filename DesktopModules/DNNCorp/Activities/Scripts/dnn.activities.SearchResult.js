// DotNetNuke® - http://www.dnnsoftware.com
// Copyright (c) 2002-2016, DNN Corp.
// by DNN Corporation
// All Rights Reserved
if (typeof dnn === 'undefined' || !dnn) dnn = {};
if (typeof dnn.activities === 'undefined') dnn.activities = {};

(function (dnn) {
    'use strict';
    dnn.activities.SearchResult = function SearchResult($, ko, settings, root, social, model) {
        this.actionId = ko.observable(model.ScoringActionId);
        this.actionDefId = ko.observable(model.ScoringActionDefId);
        this.actionName = ko.observable(model.ActionDisplayName);
        this.actionDescription = ko.observable(model.ActionDescription);
        this.reputationPoints = ko.observable(model.ReputationPoints);
        this.moduleId = ko.observable(model.DesktopModuleId);
        this.moduleName = ko.observable(model.ModuleName);
        this.areaOfSite = ko.computed(function ()
        {
            if (model.ModuleName === 'Mechanics Management') {
                return 'User Profile';
            }
            else
            { return model.ModuleName; }
        });
    };
})(window.dnn);
