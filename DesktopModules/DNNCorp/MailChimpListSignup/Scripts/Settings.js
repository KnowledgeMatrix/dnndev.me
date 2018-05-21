﻿
if(typeof dnn=='undefined')dnn={};if(typeof dnn.MailChimpListSignup=='undefined')dnn.MailChimpListSignup={};(function(dnn,$,ko){var constants={methods:{getLists:'GetLists'}}
dnn.MailChimpListSignup.Settings=function Settings(moduleId,model){var self=this;var service=$.ServicesFramework(moduleId);var allowListSelection=model.allowListSelection;var listsToSubscribe=model.listsToSubscribe?model.listsToSubscribe.split(','):[];var lists=model.lists;var totalLists=model.totalLists;var from=model.from;var to=model.to;self.allowListSelection=ko.observable(allowListSelection);self.listsToSubscribe=ko.observableArray(listsToSubscribe);self.lists=ko.observableArray(lists);self.from=ko.observable(from);self.to=ko.observable(to);self.totalLists=ko.observable(totalLists);self.loading=ko.observable(false);self.makeRequest=function(options){if(self.loading()){return;}
self.loading(true);if(options.requiresConfirmation){}
$.ajax({url:service.getServiceRoot('DNNCorp/MailChimpListSignup')+'Settings/'+options.endPoint,type:options.type,data:options.data,beforeSend:service.setModuleHeaders,success:options.success,error:options.error,complete:function(xhr,status){self.loading(false);}});}
self.nextPage=function(){var from=self.from();var to=self.to();var totalLists=self.totalLists();if(to==totalLists){return}
var options={endPoint:constants.methods.getLists,type:'GET',data:{listsOffset:to},success:function(result){self.lists(result.lists);self.from(result.from);self.to(result.to);self.totalLists(result.totalLists);},error:function(result,data){}}
self.makeRequest(options);}
self.previousPage=function(){var from=self.from();var to=self.to();var totalLists=self.totalLists();if(from<=1){return}
var options={endPoint:constants.methods.getLists,type:'GET',data:{listsOffset:from-constants.PAGE_SIZE-1},success:function(result){self.lists(result.lists);self.from(result.from);self.to(result.to);self.totalLists(result.totalLists);},error:function(result,data){}}
self.makeRequest(options);}};})(window.dnn,window.jQuery,window.ko);