<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Upload.ascx.cs" Inherits="Evoq.UI.UserControls.Upload" %>
<%@ Import Namespace="Newtonsoft.Json" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="upload">
    <ul class="dnnButtonGroup">
        <li data-bind="visible: uploadFileTabVisible">
            <a href="#upload-file" class="upload-file" 
                data-bind="click: activateTab, css: { active: activeTab() == 'upload-file' }">
                <%= LocalizeString("UploadFile") %>
            </a>
        </li>
        <li>
            <a href="#stored-location" class="stored-location" 
                data-bind="click: activateTab, css: { active: activeTab() == 'stored-location' }">
                <%= LocalizeString("StoredLocation") %>
            </a>
        </li>
        <li data-bind="visible: fromUrlTabVisible">
            <a href="#from-url" class="from-url" 
                data-bind="click: activateTab, css: { active: activeTab() == 'from-url' } ">
                <%= LocalizeString("FromUrl") %>
            </a>
        </li>
    </ul>
    <div id="upload-file" class="upload-file" data-bind="visible: activeTab() == 'upload-file'">
        <div class="droparea" data-bind="visible: !uploading(), event: { dragover: dragOver, dragleave: dragLeave }, css: { dragover: draggingOver }">
            <div class="drag-and-drop" data-bind="text: dragAndDropLiteral"></div>
            <div class="or-borders"><div class="or"><%= LocalizeString("Or") %></div></div>
            <div class="browse"><%= LocalizeString("Browse") %></div>
            <input type="file" data-bind="attr:{'multiple': multipleFilesAttribute, 'accept': acceptedFilesAttribute}" name="postfile" id="uploader" aria-label="File" />    
        </div>
        <div class="progress" data-bind="visible: uploading()">
            <div class="upload-status-progress complete">
                <div class="bar">
                    <span data-bind="style: { width: uploadPercent() + '%' }"></span>
                </div>
                <span class="btn-cancel"></span>
            </div>
        </div>
    </div>
    <div id="stored-location" class="stored-location" data-bind="visible: activeTab() == 'stored-location'">
        <div class="stored-location-top">
            
            <input type="text" data-bind="value: searchInput, valueUpdate: 'afterkeydown'" class="stored-location-search" placeholder="<%= LocalizeString("Search") %>" aria-label="Search">
            
            <div id="folderPicker<%= ModuleId %>" class="folder dnnDropDownList"
                    data-bind="folderPicker: {
                                koElement: currentFolder,
                                selectFolderCallback: selectedFolderChanged,
                                selectedItemText: '<%= LocalizeString("RecentUploads") %>',
                                options: {
                                    selectedItemCss: 'selected-item',
                                    internalStateFieldId: null,
                                    services: {
                                        parameters: {
                                            permission: 'READ,ADD'
                                        }
                                    },
                                    itemList: {
                                        firstItem: {
                                            key: -1, value: '<%= LocalizeString("RecentUploads") %>'
                                        },
                                        disableUnspecifiedOrder: true
                                    }
                                }
                            }">
                <div class="selected-item">
                    <a href="javascript:void(0);" class="selected-value"><%=LocalizeString("SelectAFolder") %></a>
                </div>
            </div>
        </div>
        <div class="stored-location-list" data-bind="foreach: storedFiles">
            <span class="thumb_wrapper" data-bind="css: { checked:  $root.isFileSelected(id) }, click: $root.itemClick">
                <span class="thumb_holder">
                    <img data-bind="attr: { src: thumb, rel: thumb, title: title, alt: title }" alt="File image">
                    <span class="active-state"></span>
                </span>
                <div class="name" data-bind="text: title"></div>
            </span>        
        </div>
        
        <div class="buttons">
            <a href="javascript:void(0);" class="insert-image" data-bind="click: insertFileClicked, text: insertFileLiteral">Insert Image(s)</a>            
        </div>
    </div>
    <div id="from-url" class="from-url" data-bind="visible: activeTab() == 'from-url'">
            
        <div data-bind="visible: !uploadingFromUrl()">
            <label><%= LocalizeString("EnterUrl") %> (<span class="example_url"><%= LocalizeString("ExampleUrl") %></span>)</label>
            <input type="text" data-bind="value: uploadUrl, valueUpdate: 'afterkeydown', css: { error: uploadUrl() != '' && !previewAvailable() }" aria-label="File">

            <a href="javascript:void(0);" class="upload" data-bind="click: uploadFromUrl"><%= LocalizeString("Upload") %></a>

            <div class="preview"><img data-bind="visible: previewAvailable, attr: { src: previewUrl }, event: { error: hidePreview }" alt="Preview" /></div>            
        </div>
        <div data-bind="visible: uploadingFromUrl()" class="uploading">
            <div></div>
        </div>
    </div>
     <script type="text/javascript">
         jQuery(function() {
             var moduleId = <%= ModuleId %>;
             var config = {
                 moduleId: moduleId,
                 tabId: <%= TabId %>,
                 bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                 moduleName:'<%= ModuleName %>',
                 fileUploadControllerName:'<%= FileUploadControllerName %>',
                 uploadFromUrlMethodName:'<%= UploadFromUrlMethodName %>',
                 uploadFileMethodName:'<%= UploadFileMethodName %>',
                 multipleFiles:<%= JsonConvert.SerializeObject(MultipleFiles) %>,
                 fromUrlTabVisible:<%= JsonConvert.SerializeObject(FromUrlTabVisible) %>,
                 acceptedFilesAttribute:'<%= !string.IsNullOrEmpty(AllowedExtensions) ? AllowedExtensions.Trim() : "" %>',
                 fileBrowserModuleName:'<%= FileBrowserModuleName %>',
                 fileBrowserControllerName:'<%= FileBrowserControllerName %>',
                 getFilesMethodName:'<%= GetFilesMethodName %>',
                 dragAndDropImageLiteral: '<%= LocalizeString("DragAndDropImage") %>',
                 dragAndDropDocumentLiteral: '<%= LocalizeString("DragAndDropDocument") %>',
                 dragAndDropImagesLiteral: '<%= LocalizeString("DragAndDropImages") %>',
                 dragAndDropDocumentsLiteral: '<%= LocalizeString("DragAndDropDocuments") %>',
                 insertImageLiteral: '<%= LocalizeString("InsertImage") %>',
                 insertDocumentLiteral: '<%= LocalizeString("InsertDocument") %>',
                 insertImagesLiteral: '<%= LocalizeString("InsertImages") %>',
                 insertDocumentsLiteral: '<%= LocalizeString("InsertDocuments") %>',
                 lazyFilesLoad: <%= JsonConvert.SerializeObject(LazyFilesLoad) %>,
                 uploadFileTabVisible:<%= JsonConvert.SerializeObject(UploadFileTabVisible) %>,
                 maxFileSize: '<%= MaxFileSize %>',
                 fileIsTooLargeLiteral: '<%= FileIsTooLarge %>'
             };
             var uploadManager = window.dnn.ui.components.upload.createUploadManager();
             uploadManager.init(config);
             window.dnn.ui.components.upload['UploadManager' + moduleId] = uploadManager;
         });
    </script>

</asp:Panel>