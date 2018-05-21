"use strict";define(['jquery','knockout'],function($,ko){var bindViewModel,rootFolder,utility,helper;var init=function(koObject,connectionHelper,pluginFolder,util){bindViewModel=koObject;rootFolder=pluginFolder;utility=util;helper=connectionHelper;initBindViewModel();}
var initBindViewModel=function(){bindViewModel.useTagManagerForGAChanged=function(viewModel,e){viewModel.configurations[1].value(e.target.checked?"true":"false");return true;}}
var onSave=function(koObject){}
return{init:init,onSave:onSave}});