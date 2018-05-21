
if(typeof dnn==="undefined"||dnn===null){dnn={};};(function($){"use strict";var formVisualizerDesktopModuleId;var serviceName="FormBuilderVisualizer";function loadParams(){var sf=$.dnnSF();var serviceRoot=sf.getServiceRoot(serviceName);var serviceUrl=serviceRoot+"Visualizer/getparams";return $.ajax({url:serviceUrl,type:"GET",beforeSend:sf.setModuleHeaders});}
function getToken(success,error,forceNewToken){var sf=$.dnnSF();var serviceRoot=sf.getServiceRoot("formbuilderlibrary");var serviceUrl=serviceRoot+"authorization/GetAuthorizationToken";$.ajax({url:serviceUrl,type:"POST",data:{forceNewToken:forceNewToken},beforeSend:sf.setModuleHeaders}).success(function onSuccess(data){var token=data.token;success(token);}).error(function onError(err){error(err);});}
function appendScript(url){var script=document.createElement('script');script.type='text/javascript';script.src=url;document.body.appendChild(script);}
function getBundleLanguage(culture){var fallbackLanguage="en";var availableLanguages=["en"];return availableLanguages.indexOf(culture)>0?culture:fallbackLanguage;}
function loadScript(config){var publicPath=config.bundlePublicPath;var debugMode=config.debugMode;if(debugMode===true){window.__REACT_DEVTOOLS_GLOBAL_HOOK__;}
var language=getBundleLanguage(config.culture);var url=publicPath+"bundle-"+language+".js";appendScript(url);function formInitCallback(){var options={getToken:getToken,tokenKey:config.tokenKey,addModule:addModule,closeModal:closeModal,publicPath:publicPath,apiServicePath:config.apiServicePath}
window.dnn.formVisualizer.init(options);}
window.dnnInitForm=formInitCallback;}
function closeModal(){var moduleDialog=getModuleDialog();moduleDialog.close();moduleDialog.getModuleManager().getHandler().click();}
function addModule(options){var moduleDialog=getModuleDialog();moduleDialog.addModule(formVisualizerDesktopModuleId,function onAddedModule(tabModuleId){var serviceController=new dnn.dnnModuleService({service:serviceName,controller:"Settings",async:false,moduleId:tabModuleId});function successCallbackHandler(){$(document).trigger("changeOnPageContent");window.dnn.formVisualizer.notifyAddedModule();}
serviceController.request('Set','POST',options,successCallbackHandler);},true);}
function addFormBuilderVisualizerDivContainer(){var formId="formBuilderVisualizer";var $Form=$("#"+formId);if($Form.length===0){$Form=$("<div id='"+formId+"' data-init-callback='dnnInitForm'></div>");$(document.body).append($Form);}
return $Form;}
function getModuleListItem(desktopModuleId){var $dialogElement=getModuleDialogElement();var $moduleList=$dialogElement.find('.dnnModuleList ul');return $moduleList.find('.dnnModuleItem[data-moduleid="'+desktopModuleId+'"]');}
function getModuleDialog(){return dnn.ContentEditorManager.getModuleDialog();}
function getModuleDialogElement(){return getModuleDialog().getElement();}
var openFormBuilderVisualizerModalAttempt=0;function openFormBuilderVisualizerModal(){if(window.dnn.formVisualizer){var $dialogElement=getModuleDialogElement();var initialWidth=$dialogElement.outerWidth();var initialHeight=$dialogElement.outerHeight();var centerX=$dialogElement.offset().left+initialWidth/2;window.dnn.formVisualizer.openModal(centerX,initialWidth,initialHeight);return;}
openFormBuilderVisualizerModalAttempt++;if(openFormBuilderVisualizerModalAttempt===50){console.error("Cannot load Form modal");openFormBuilderVisualizerModalAttempt=0;return;}
setTimeout(function(){openFormBuilderVisualizerModal();},100);}
function registerAddFormBuilderVisualizerModuleEventHandler()
{var $moduleListItem=getModuleListItem(formVisualizerDesktopModuleId);if($moduleListItem.length!==0){$moduleListItem.click(function onModuleListItemClick(e){e.preventDefault();e.stopImmediatePropagation();openFormBuilderVisualizerModal();});}}
function registerOnAddModuleCompleteEventHandler(){var $moduleDialog=getModuleDialogElement();$moduleDialog.on('addmodulecomplete',function(e,newModule){dnn.ContentEditorManager.catchSortEvents(function(){newModule.trigger('editmodule');});});}
function addModuleEventHandler(desktopModuleId){formVisualizerDesktopModuleId=desktopModuleId;registerAddFormBuilderVisualizerModuleEventHandler();if(window.dnn.formVisualizerModuleEditorInitialized){return;}
addFormBuilderVisualizerDivContainer();loadParams().success(loadScript);registerOnAddModuleCompleteEventHandler();window.dnn.formVisualizerModuleEditorInitialized=true;}
return{addModuleHandler:addModuleEventHandler};})(jQuery);