<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditPostDetails.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.EditPostDetail" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="edit-bar-panel edit-post-details" data-bind="css: {expanded: visible}, validationOptions: validationOptions">
    <div class="edit-bar-panel-title">
        <h2><%= LocalizeString("EditPostDetails") %></h2>
        <div data-bind="click: cancel" class="edit-bar-panel-close" title="<%= LocalizeString("ClosePostDetails") %>"></div>
    </div>
    <div class="edit-bar-panel-container">
        <div class="left">
            <span class="field-label" data-bind="css: {'required': !isPostCreation}">
                <%= LocalizeString("Title") %>
            </span>
            <div class="dnnFormItem">
                <input type="text" data-bind="value: model.title" class="field" aria-label="Title"/>
            </div>
            <span class="field-label">
                <%= LocalizeString("Description") %>
            </span>
            <textarea class="field" data-bind="value: model.description" aria-label="Description"></textarea>
            <span class="field-label" data-bind="css: {'required': !isPostCreation}">
                <%= LocalizeString("URL") %>
            </span>
            <div class="fake-input-field">
                <div class="dnnFormItem">
                    <span class="fixed-value" data-bind="html: publisherUrl"></span>
                    <input type="text" data-bind="value: model.slug" class="field" aria-label="Slug">
                </div>
            </div>
        </div>
        <div class="right" style="padding-top: 30px;">
            <% if (HasDisqusBeenConfigured)
               { %>
            <input type="checkbox" class="field" data-bind="checked: model.allowedComments" aria-label="Allow Comments" /> 
            <span class="checkbox-field-label"><%= LocalizeString("AllowedComments") %></span>
            <% } %>
            <input type="checkbox" class="field" data-bind="checked: model.featured" aria-label="Featured" /> 
            <span class="checkbox-field-label"><%= LocalizeString("Featured") %></span>
                
            <span class="field-label">
                <%= LocalizeString("Tags") %>
            </span>
            <div class="dnnFormItem">
                <input type="text" value="Tags" class="field" data-bind="tagsInput: model.tags, settings: { minInputWidth: '300px', placeholder: '<%= LocalizeString("TagsPlaceHolder") %>' }" aria-label="Tags"/>
            </div>
        </div>
        <div class="actions" data-bind="visible: !isPostCreation">
            <a class="btn btn-cancel"
                data-bind="click: cancel"><%= LocalizeString("Cancel") %></a>
            <a class="btn btn-accept"
                data-bind="click: save"><%= LocalizeString("Save") %></a>
        </div>
        <div style="clear: both;"></div>
    </div>
    <script type="text/javascript">
        (function ($) {
            $(document).ready(function () {
                
                var postDetailManagerConfig = {
                    moduleId: <%= ModuleId %>, 
                    tabId: <%= TabId %>,
                    contentItemId: <%= ContentItemId ?? 0 %>,
                    bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                    listUrl: '<%= ListUrl %>/',
                    post: <%= PostMetadataJson %>,
                    resx: {
                        titleIsRequired: '<%= LocalizeString("TitleIsRequired") %>',
                        urlIsRequired: '<%= LocalizeString("UrlIsRequired") %>',
                        urlIsNotValid: '<%= LocalizeString("UrlIsNotValid") %>',
                        urlIsInUse: '<%= LocalizeString("UrlIsInUse") %>'
                    }
                };
                dnn.modules.publisher.EditPostDetailsManager.init(postDetailManagerConfig);
            });
        }(jQuery));
    </script>
</asp:Panel>