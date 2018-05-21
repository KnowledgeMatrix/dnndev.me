<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangeAuthor.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.ChangeAuthor" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>
<asp:Panel ID="ScopeWrapper" runat="server" CssClass="edit-bar-panel change-author" data-bind="css: {expanded: visible}">
    <div class="edit-bar-panel-title">
        <h2 data-bind="with: author">
            <%= LocalizeString("PostAuthor") %>:
            <img data-bind="attr: { src: avatar, alt: displayName }">
            <span data-bind="text: displayName"></span>                
        </h2>
        <div data-bind="click: hide" class="edit-bar-panel-close" title="<%= LocalizeString("CloseChangeAuthor") %>"></div>
    </div>
    <h3><%= LocalizeString("SelectUserToChange") %></h3>        
    <div class="edit-bar-panel-container">
        <table class="cmxtbl" id="userstbl">
            <colgroup>
                <col class="users-col-name">
                <col class="users-col-email">
                <col class="users-col-joined">
            </colgroup>
            <thead>
                <tr>
                    <th><a data-column="displayName" data-bind="click: sort, attr: { 'class': sortColumnClass('displayName') }"><%= LocalizeString("Name")%></a></th>
                    <th><a data-column="email" data-bind="click: sort, attr: { 'class': sortColumnClass('email') }"><%= LocalizeString("Email")%></a></th>
                    <th><a data-column="joined" data-bind="click: sort, attr: { 'class': sortColumnClass('joined') }"><%= LocalizeString("Joined")%></a></th>
                </tr>
            </thead>
            <tbody data-bind="foreach: users">
                <tr data-bind="click: $parent.setAuthor">
                    <td>
                        <div class="useravatar">
                            <span><em>
                                <img data-bind="attr: { src: avatar, alt: displayName }"></em></span>
                        </div>
                        <div class="username">
                            <label data-bind="text: displayName"></label>
                            <span data-bind="text: userName"></span>
                        </div>
                    </td>
                    <td><a class="email-link" data-bind="text: email, attr: { 'href': 'mailto:' + email }"></a></td>
                    <td><span data-bind="text: joinedText"></span></td>
                </tr>
            </tbody>
        </table>
    </div>
    <script type="text/javascript">
        $(function () {
            var changeAuthorManagerConfig = {
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                contentItemId: <%= Post.ContentItemId %>,
                authorDisplayName: <%= Json.Serialize(Post.AuthorDisplayName) %>,
                authorAvatar: <%= Json.Serialize(GetAuthorAvatar()) %>,
                authorUserId: <%= Post.AuthorUserId %>,
                resx: {
                    authorSuccessfullyChanged: <%= Json.Serialize(LocalizeString("AuthorSuccessfullyChanged")) %>
                }
            };
            dnn.modules.publisher.ChangeAuthorManager.init(changeAuthorManagerConfig);
        });
    </script>
</asp:Panel>