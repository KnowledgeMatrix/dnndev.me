﻿
﻿
window.dnn=dnn||{};window.dnn.personalizedTabs=dnn.personalizedTabs||{};(function IIFE(){var EditBarMasterTabManagerClass;EditBarMasterTabManagerClass=(function IIFE(){'use strict';var _viewModel,service;var _templateLoader;var _editBarContentPersonalizationCommonManager;var resx,resxSettings;var dnnEditBarActiveCallback,iniListeners,createViewModel;EditBarMasterTabManager.class='EditBarMasterTabManager';EditBarMasterTabManager.type='Class';_viewModel={};function EditBarMasterTabManager(){_templateLoader=new window.dnn.personalizedTabs.TemplateLoader();iniListeners();}
iniListeners=function(){$(document).on("dnnEditBarActive",function(event,data){dnnEditBarActiveCallback();});}
createViewModel=function(){_viewModel={};};dnnEditBarActiveCallback=function(){createViewModel();_editBarContentPersonalizationCommonManager=new window.dnn.personalizedTabs.EditBarContentPersonalizationCommonManager();}
return EditBarMasterTabManager;})();window.dnn.personalizedTabs.EditBarMasterTabManager=EditBarMasterTabManagerClass;}).call(this);$(window).load(function(){var EditBarMasterTabManager=new window.dnn.personalizedTabs.EditBarMasterTabManager();});