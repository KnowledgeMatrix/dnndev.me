<%@ Control language="C#" Inherits="DotNetNuke.Modules.HtmlPro.HtmlModule" CodeBehind="HtmlModule.ascx.cs" AutoEventWireup="false"  %>

<div runat="server" id="lblContent"></div>

<asp:Panel runat="server" ID="InLineEditorScript">
<script type="text/javascript">
    $(document).ready(function addInlineEditingToModule() {
        var options, localizationOptionsInlineEditor, localizationOptionsImageEditing;

        window.dnn = window.dnn || {};
        window.dnn.HTMLPro = window.dnn.HTMLPro || {};

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
            window.dnn.HTMLPro.resx.inlineEditor = true;
            localizationOptionsInlineEditor = {
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
            localizationOptionsImageEditing = {
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

        options = {
            moduleId:  <%= ModuleId %>,
            clientId:  '<%= lblContent.ClientID %>',
            canUpload: <%= CanUpload.ToString().ToLower() %>,
            editUrl:   "<%= EditUrl() %>",
            maxFileSize: '<%= MaxFileSize %>',
            saveUrl: $.ServicesFramework(<%= ModuleId %>).getServiceRoot('HtmlPro') + 'HtmlTextPro/Save',
            saveSuccessCallback: function(data) {
                if (data.NewVersion) {
                    // Update UI: Buttons publish/discard in footer actions bar
                    $(document).trigger("changeOnPageContent");
                }
            },
            onEditorInitCallback: function() {
                $(document).trigger("dnnActionOnEditBar", this.module[0]);
            }
        };

        // Create inline editing Object
        new window.dnn.HTMLPro.InlineEditing(options, window.dnn.HTMLPro.resx);        
    });
</script>
</asp:Panel>
<asp:Panel runat="server" ID="MakeMasterPagePanel" Visible="False">
    <script type="text/javascript">
        $(document).ready(function addMakeMasterPageBehavior() {
            var options, controlClass, $makeMasterLink;

            // Create Make Master Page
            options = {
                moduleId:  <%= ModuleId %>,
                controlPrefix:  'makeMasterPage'
            }
            controlClass = options.controlPrefix + options.moduleId;
            $makeMasterLink = $("." + controlClass);
            if ($makeMasterLink.length > 0) {
                new window.dnn.HTMLPro.MakeMasterPage(options, $makeMasterLink);
            }                
        });        
    </script>
</asp:Panel>
