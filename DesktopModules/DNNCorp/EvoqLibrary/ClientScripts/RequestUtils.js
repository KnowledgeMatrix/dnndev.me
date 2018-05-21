﻿
window.dnn=dnn||{};window.dnn.ui=dnn.ui||{};window.dnn.ui.components=dnn.ui.components||{};window.dnn.ui.components.upload=dnn.ui.components.upload||{};window.dnn.ui.components.upload.createRequestUtils=function(){return(function($){"use strict";var serviceFramework,moduleId;var init,getServiceUrl,request,setHeaders,showError,getQueryParameters;showError=function(xhr){var r=JSON.parse(xhr.responseText);var message="";if(xhr.status===422){for(var i=0;i<r.length;i++){message+=r[i].Error+"<br />";}}else{message=r.Message;}
$.dnnAlert({title:'An error has occurred',text:message});};init=function(moduleIdentifier){serviceFramework=$.dnnSF.call(this,moduleIdentifier);moduleId=moduleIdentifier;};getServiceUrl=function(serviceName,controller){return serviceFramework.getServiceRoot(serviceName)+controller+'/';};request=function(serviceName,controller,method,type,params,callback,errorCallBack,completeCallback,sync){$.ajax({url:getServiceUrl(serviceName,controller)+method,type:type,data:params,async:!sync,beforeSend:serviceFramework.setModuleHeaders,success:function(data){if(typeof callback=="function"){callback(data);}},error:function(xhr){if(typeof errorCallBack=="function"){errorCallBack(xhr);}else{showError(xhr);}},complete:function(xhr,status){if(typeof completeCallback=="function"){completeCallback(xhr,status);}}});};setHeaders=function(xhr){serviceFramework.setModuleHeaders(xhr);};getQueryParameters=function(str){str=(str||document.location.search);if(str.length===0)return{};var parts=str.replace(/(^\?)/,'').split("&");return $.map(parts,function(n){return n=n.split("="),this[n[0]]=decodeURIComponent(n[1]),this}.bind({}))[0];};return{request:request,getServiceUrl:getServiceUrl,setHeaders:setHeaders,init:init,showError:showError,getQueryParameters:getQueryParameters};}(jQuery||$));}