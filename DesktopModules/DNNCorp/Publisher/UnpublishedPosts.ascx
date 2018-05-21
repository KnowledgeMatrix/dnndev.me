<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UnpublishedPosts.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.UnpublishedPosts" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass="edit-bar-panel unpublished-posts" data-bind="css: {expanded: visible}">
    <div class="edit-bar-panel-title">
        <h2><%= LocalizeString("UnpublishedPostsTitle") %></h2>
        <div data-bind="click: cancel" class="edit-bar-panel-close" title="<%= LocalizeString("CloseUnpublishedPosts") %>"></div>
    </div>
    <div class="edit-bar-panel-container">
       <table class="cmxtbl" id="userstbl">
            <thead>
                <tr>
                    <th><%= LocalizeString("Name")%></th>
                    <th><%= LocalizeString("DateCreated")%></th>
                    <th><%= LocalizeString("Author")%></th>
                    <th><%= LocalizeString("Actions")%></th>
                </tr>
            </thead>
            <tbody data-bind="foreach: unpublishedPosts">
                <tr>
                    <td class="unpublished-field unpublished-title"><span data-bind="text: title"></span></td>
                    <td class="unpublished-field unpublished-createOnDate"><span data-bind="text: createdOnDate"></span></td>
                    <td><span data-bind="text: authorName"></span></td>
                    <td class="unpublished-posts-actions">
                        <a data-bind="attr: {href: viewUrl}" class="unpublished-show" title="<%= LocalizeString("ViewUnpublished") %>" aria-label="<%= LocalizeString("ViewUnpublished") %>"></a>
                        <a data-bind="attr: {href: editUrl}" class="unpublished-edit" title="<%= LocalizeString("EditUnpublished") %>" aria-label="<%= LocalizeString("EditUnpublished") %>"></a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
     <script type="text/javascript">
        (function ($) {
            $(document).ready(function () {
                var unpublishedPostsManagerConfig = {
                    moduleId: <%= ModuleId %>, 
                    bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                    unpublishedPosts: <%= JsonConvert.SerializeObject(UnpublishedPostsList) %>
                };
                dnn.modules.publisher.UnpublishedPostsManager.init(unpublishedPostsManagerConfig);
            });
        }(jQuery));
    </script>
</asp:Panel>