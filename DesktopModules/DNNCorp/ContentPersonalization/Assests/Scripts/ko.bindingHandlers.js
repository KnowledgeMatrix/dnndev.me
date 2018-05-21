﻿
﻿
ko.bindingHandlers.jScrollPane={init:function(element,valueAccessor){var options=valueAccessor()||{};$(element).jScrollPane(options);$(window).resize(function(){var scroll=$(element).data("jsp");if(scroll){scroll.reinitialise();}});}};ko.bindingHandlers.draggable={init:function(element,valueAccessor,allBindingsAccessor,viewModel,context){var options=valueAccessor();var item=ko.utils.unwrapObservable(options).item;options.helper=function(evt,ui){var $element=$(element);var h=$element.clone().css({width:$element.width(),height:$element.height(),});h.addClass('draggableRule');h.data('ko.draggable.data',item);return h;};$(element).draggable(options);}};ko.bindingHandlers.droppable={init:function(element,valueAccessor,allBindingsAccessor,viewModel,context){var options=valueAccessor()||{};var addMethod=options.addMethod;options.drop=function(event,ui){var item=ui.helper.data('ko.draggable.data');addMethod(item);};$(element).droppable(options);}};ko.bindingHandlers.tokenInput={init:function(element,valueAccessor,allBindingsAccessor,viewModel){var listOfItems=valueAccessor();var settings=allBindingsAccessor().settings;var tokenLimit=(settings.tokenLimit)?settings.tokenLimit:null;$(element).tokenInput(settings.url,{idPrefix:viewModel.id,theme:settings.theme,prePopulate:listOfItems(),resultsFormatter:settings.resultsFormatter,minChars:2,preventDuplicates:true,hintText:'',tokenLimit:tokenLimit,onAdd:function(item){listOfItems.push(item);},onDelete:function(item){listOfItems.remove(item);},onError:function(xhr,status){},onReady:function(){$('.token-input-input-token-'+settings.theme+' input').attr('aria-label','Token Input');},tokenLimit:settings.tokenLimit||null});if(allBindingsAccessor().hasFocus){$("ul","div#"+viewModel.id).click();}
if(listOfItems.subscribe){listOfItems.subscribe(function(newValue){var $element=$(element);if(newValue.length===0&&$element.tokenInput("get").length!==0){$element.tokenInput("clear");}});}}};ko.bindingHandlers.autoComplete={init:function(element,valueAccessor,allBindingsAccessor,viewModel,bindingContext){var url=allBindingsAccessor().source;var value=valueAccessor();var firstTime=true;$(element).autocomplete({minLength:2,messages:{noResults:'',results:function(){}},autoFocus:true,appendTo:'.personalizedPageDialog',source:function(request,response){$.ajax({beforeSend:$.dnnSF().setModuleHeaders,url:url,data:{q:request.term},dataType:"json",type:"GET",success:function(data){response(data);}});},select:function(event,ui){var selectedItem=ui.item;value(selectedItem.value);},open:function(){var menuElement=$(this).data("uiAutocomplete").menu.element;menuElement.addClass("personalizedPageDialog");if(firstTime){menuElement.hide();firstTime=false;}}});},update:function(element,valueAccessor,allBindingsAccessor,viewModel){var allBindings=allBindingsAccessor();var modelValue=allBindings.autoComplete();if(modelValue){$(element).val(ko.utils.unwrapObservable(modelValue));}}};ko.bindingHandlers.pagePicker={init:function(element,valueAccessor){var koOptions=valueAccessor();var selectPageCallback=koOptions.selectPageCallback;var koElement=koOptions.koElement;var id="#{0}".replace(/\{0\}/g,element.id);var selectPageProxyCallback=function(){selectPageCallback.call(koElement,this.selectedItem());};var containerSelector=koOptions.containerSelector;if(containerSelector){$(element).appendTo(containerSelector);}
var options={disabled:false,initialState:{selectedItem:koOptions.selectedPage},services:{moduleId:'',serviceRoot:'InternalServices',getTreeMethod:'ItemListService/GetPages',sortTreeMethod:'ItemListService/SortPages',getNodeDescendantsMethod:'ItemListService/GetPageDescendants',searchTreeMethod:'ItemListService/SearchPages',getTreeWithNodeMethod:'ItemListService/GetTreePathForPage',rootId:'Root',parameters:{includeDisabled:false,includeAllTypes:false,includeActive:false,includeHostPages:false,roles:''}},onSelectionChangedBackScript:selectPageProxyCallback};$.extend(options,koOptions.options);dnn.createDropDownList(id,options,{});}};ko.bindingHandlers.datePicker={init:function(element,valueAccessor,allBindings){var format="MM/DD/YYYY";var defaultMinDate="01/01/1753";var value=valueAccessor();var valueUnwrapped=ko.unwrap(value);$(element.parentElement).appendTo(".personalizedPageDialog");var minDate=allBindings.get('minDate');if(minDate){minDate.subscribe(function(value){var picker=$(element).data("picker");var date=!(value instanceof Date)?new Date(defaultMinDate):new Date(value.getTime());date.setHours(0,0,0,0);picker.setMinDate(date);picker.setDate(moment(date).format(format));});}else{minDate=new Date(defaultMinDate);}
var picker=new Pikaday({minDate:minDate,defaultDate:valueUnwrapped,format:format,bound:false,onSelect:function(){value(picker.toString());}});$(element).append(picker.el);$(element).data("picker",picker);},update:function(element,valueAccessor){var value=valueAccessor();var valueUnwrapped=ko.unwrap(value);var picker=$(element).data("picker");picker.setDate(valueUnwrapped);}};