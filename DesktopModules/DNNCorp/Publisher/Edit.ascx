<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.Edit" %>
<%@ Register TagPrefix="evoq" TagName="Upload" Src="~/DesktopModules/DNNCorp/EvoqLibrary/UI/UserControls/Upload.ascx" %>

<evoq:Upload ID="Upload" runat="server" ModuleName="Publisher" FileUploadControllerName="FileUpload" 
            AllowedExtensions=".jpg,.jpe,.jpeg,.bmp,.gif,.png,.ico,.svg" UploadFromUrlMethodName="UploadFromUrl" UploadFileMethodName ="UploadFile" 
            FileBrowserModuleName="DNNCorp/EvoqLibrary" FileBrowserControllerName="Redactor" GetFilesMethodName="GetImages" />

<asp:Panel ID="ScopeWrapper" CssClass="publisher-edit DnnModule-Publisher-BackgroundColor DnnModule-Publisher-Color" runat="server" data-bind="css: { 'editing-image': editingImage }">
    
    <div class="image" data-bind="style: { backgroundImage: previousImageBackground }, 
                                    css: { editing: editingImage, highlight: highlightImage }, 
                                    visible: post.mainImageUrl() !== null,
                                    event: { animationend: animationEnd, webkitAnimationEnd: animationEnd, click: hidePanels }">        
        <div class="actions DnnModule-Publisher-BackgroundShadowColor" data-bind="visible: post.mainImageUrl() !== null">
            <a class="edit" data-bind="click: editMainImage" aria-label="Edit"></a>
            <a class="delete" data-bind="click: deleteMainImage" aria-label="Delete"></a>
        </div>        
        
        <div class="image-wrapper DnnModule-Publisher-BackgroundColor">
            <img data-bind="attr: { src: post.mainImageUrl(), alt: 'Background'  }, visible: post.mainImageUrl()" />            
        </div>
        
    </div>

    <div class="change-image-dialog" data-bind="visible: post.mainImageUrl() === null, event: { click: hidePanels }"></div>
    
    <h1 class="title padding" contenteditable="true" data-bind="text: post.title() || '<%= LocalizeString("AddTitle") %>', event: { blur: updateTitle, focus: hidePanels }" placeholder="<%= LocalizeString("AddTitle") %>" title="<% = LocalizeString("ClickToEdit") %>"></h1>
    
    <%-- IE only code - h1 content editable has issues in IE when copy/paste html --%>
    <input class="title padding" data-bind="value: post.title, placeholder:true, event: { focus: hidePanels }" placeholder="<%= LocalizeString("AddTitle") %>" aria-label="<%= LocalizeString("ClickToEdit") %>"/>

    <div class="content-container padding">
        <div class="content" runat="server" ID="PostContent"></div>
    </div>
    <script type="text/javascript">
        jQuery(function() {            
            var config = {
                moduleId: <%= ModuleId %>,
                contentItemId: <%= ContentItemId.HasValue ? ContentItemId.Value.ToString() : "null" %>,
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                contentSelector: '#<%= PostContent.ClientID %>',
                editPostUrlPattern: '<%= EditPostUrlPattern %>',
                listUrl: '<%= ListUrl %>',
                post: <%= PostJson %>,
                uploadPanelSelector: '#<%= Upload.ClientID %>_ScopeWrapper',
                hidePanels: window.dnn.modules.publisher.EditBarManager.hidePanels,
                resx: {
                    emptyTitleText: '<%= LocalizeString("AddTitle") %>',
                    emptyEditContentText: '<%= LocalizeString("TypeStory") %>',
                    deleteConfirmText: '<%= LocalizeString("DeleteConfirm") %>',
                    deleteConfirmTitleText: '<%= LocalizeString("DeleteConfirmTitle") %>',
                    yesText:'<%= LocalizeString("Yes") %>',
                    noText: '<%= LocalizeString("No") %>',
                    changeImageText: '<%= LocalizeString("ChangeImage") %>',
                    closeText: '<%= LocalizeString("Close") %>',
                    titleIsRequired: '<%= LocalizeString("TitleIsRequired") %>',
                    bodyIsRequired: '<%= LocalizeString("BodyIsRequired") %>',                        
                }
            };

            var editPostManager = dnn.modules.publisher.EditPostManager;
            editPostManager.init(config);
            
            if (!window.dnn.HTMLPro.resx) {
                window.dnn.HTMLPro.resx = {
                    culture: 'en',
                    redactor: false,
                    inlineEditor: false,
                    imageEditing: false
                };
            }
            
            // Get inline editor localization
            if (!window.dnn.HTMLPro.resx.inlineEditor) {
                var publisherResources = {
                    emptyEditContentText: '<%= LocalizeString("TypeStory") %>',
                    errorSavingText: '<%= LocalizeString("ErrorOnSavePost") %>'
                };
                window.dnn.HTMLPro.resx.inlineEditor = publisherResources;
                var localizationOptionsInlineEditor = {
                    service: 'DNNCorp/EvoqLibrary',
                    controller: 'Localization',
                    resxName: 'InlineEditorResx',
                    resourceSettings: {
                        method: 'GetInlineEditorSettings'
                    },
                    resources: {
                        method: 'GetInlineEditor',
                        paramName: 'localization',
                        callback200: function (data) {
                            $.extend(data.localization, publisherResources);
                            window.dnn.HTMLPro.InlineEditing.setResx(data.localization);
                        },
                        callbackError: function (data) {console.log('Error', data)}
                    }
                };

                new dnn.utils.Localization(localizationOptionsInlineEditor);
            }

            // Get image editing localization
            if (!window.dnn.HTMLPro.resx.imageEditing) {
                window.dnn.HTMLPro.resx.imageEditing = true;
                var localizationOptionsImageEditing = {
                    service: 'DNNCorp/EvoqLibrary',
                    controller: 'Localization',
                    resxName: 'ImageEditingResx',
                    resourceSettings: {
                        method: 'GetImageEditingSettings'
                    },
                    resources: {
                        method: 'GetImageEditing',
                        paramName: 'localization',
                        callback200: function (data) {
                            window.dnn.HTMLPro.InlineEditing.setImageEditingResx(data.localization);
                        },
                        callbackError: function (data) { console.log('Error', data); }
                    }
                };

                new dnn.utils.Localization(localizationOptionsImageEditing);
            }

            var options = {
                moduleId: <%= ModuleId %>,
                clientId: '<%= PostContent.ClientID %>',
                canUpload: <%= CanUpload.ToString().ToLower() %>,
                maxFileSize: '<%= MaxFileSize %>',
                autoSaveEnabled: false,
                onChangeCallback: editPostManager.notifyBodyChange,
                onEditorInitCallback: window.dnn.modules.publisher.EditBarManager.hidePanels
            };

            new window.dnn.HTMLPro.InlineEditing(options, window.dnn.HTMLPro.resx);
        });
    </script>
</asp:Panel>
   