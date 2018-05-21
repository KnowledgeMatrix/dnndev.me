<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.View" %>
<%@ Import Namespace="DotNetNuke.Enterprise.Publisher.Components.Common" %>
<%@ Register TagPrefix="publisher" TagName="EditPostDetails" Src="EditPostDetails.ascx" %>
<%@ Register TagPrefix="publisher" TagName="ChangeAuthor" Src="ChangeAuthor.ascx" %>
<%@ Register TagPrefix="publisher" TagName="SettingsDetails" Src="SettingsDetails.ascx" %>
<%@ Register TagPrefix="publisher" TagName="UnpublishedPosts" Src="UnpublishedPosts.ascx" %>

<asp:Panel ID="EditBarScopeWrapper" CssClass="editbar-wrapper" runat="server" Visible="False">
    <div id="edit-bar" class="publisher-editbar">
        <div>
            <ul class="menuEditBar">
                <% if (CanEditModule && ViewMode == ViewMode.List)
                   { %>
                    <li class="settings left-button" data-bind="click: toggleSettingsPanel">
                        <div class="submenuEditBar"><%= LocalizeString("Settings") %></div>
                    </li>
                    <% if (AnyUnpublishPosts)
                       { %>
                            <li class="unpublished-posts left-button" data-bind="click: toggleUnpublishedPostsPanel">
                                <div class="submenuEditBar"><%= LocalizeString("UnpublishedPosts") %></div>
                            </li>
                    <% } %>
                <% } %>
                <% if (ViewMode == ViewMode.Edit) 
                   { %>
                <li class="delete-post left-button" data-bind="click: deletePost">
                    <div class="submenuEditBar"><%= LocalizeString("DeletePost") %></div>
                </li>   
                <% } %>
                <% if (ViewMode == ViewMode.Edit || ViewMode == ViewMode.Create) 
                   { %>
                <li class="edit-post left-button" data-bind="click: toggleEditPostDetailPanel">
                    <div class="submenuEditBar"><%= LocalizeString("EditPostDetails") %></div>
                </li>    
                <li class="change-author left-button" data-bind="click: toggleChangeAuthorPanel">
                    <div class="submenuEditBar"><%= LocalizeString("ChangeAuthor") %></div>
                </li>    
                <% } %>
            </ul>
        </div>
        <div class="right-section">
            <% if (ViewMode == ViewMode.List)
               { %>
                    <a class="primary-button right-button" href="<%= CreatePostUrl %>"><%= LocalizeString("CreatePost") %></a>
            <% } %>

            <% if (ViewMode == ViewMode.Detail)
               { %>
                    <a class="primary-button right-button" href="<%= EditPostUrl %>"><%= LocalizeString("EditPost") %></a>
            <% } %>
            
            <% if (ViewMode == ViewMode.Create || ViewMode == ViewMode.Edit)
               { %>
                <div data-bind="visible: publishingModel.loadReady()" style="display: none;">
                    <!-- ko if: publishingModel.state.HasPendingChanges() -->
                    <span class="edit-mode-message"><%= LocalizeString("EditPostInfoMessage") %></span>
                    <button class="primary-button right-button" data-bind="visible: publishingModel.state.showSubmit,
                        click: publishingModel.submit, enable: !publishingModel.isSaving()"><%= LocalizeString("SubmitPost") %></button>
                    <button class="primary-button right-button" data-bind="visible: publishingModel.state.showApprove,
                        click: publishingModel.approve, enable: !publishingModel.isSaving()"><%= LocalizeString("ApprovePost") %></button>
                    <button class="primary-button right-button" data-bind="visible: publishingModel.state.showPublish,
                        click: publishingModel.publish, enable: !publishingModel.isSaving()"><%= LocalizeString("PublishPost") %></button>  
                    <button class="secondary-button right-button" data-bind="visible: publishingModel.state.showReject, 
                        click: publishingModel.reject, enable: !publishingModel.isSaving()"><%= LocalizeString("Reject") %></button>
                    <button class="secondary-button right-button" data-bind="visible: publishingModel.state.showDiscard, 
                        click: publishingModel.discard, enable: !publishingModel.isSaving()"><%= LocalizeString("DiscardPost") %></button>  
                    <button class="secondary-button right-button" data-bind="visible: publishingModel.state.showSave, 
                        click: publishingModel.save, enable: !publishingModel.isSaving()"><%= LocalizeString("SavePost") %></button>
                    <!-- /ko -->
                    <a class="close-button right-button" href="<%= CloseUrl %>"
                                data-bind="visible: publishingModel.state.showClose"><%= LocalizeString("ClosePost") %></a>       
                </div>
            <% } %>            
        </div>        
    </div>
    
    <publisher:SettingsDetails ID="SettingsDetails" runat="server" Visible="False"></publisher:SettingsDetails> 
    <publisher:UnpublishedPosts ID="UnpublishedPosts" runat="server" Visible="False"></publisher:UnpublishedPosts>  
    <publisher:EditPostDetails ID="EditPostDetails" runat="server" Visible="False"></publisher:EditPostDetails>    
    <publisher:ChangeAuthor ID="ChangeAuthor" runat="server" Visible="False"></publisher:ChangeAuthor>

    <script type="text/javascript">
        (function ($) {
            $(document).ready(function () {
                var moduleId = <%= ModuleId %>;
                var publishingState = <%= InitialState %>;
                var publishingResx = {
                    submit: {
                        title: "<%= LocalizeString("SubmitDialogTitle") %>",
                        innerTitle: "<%= LocalizeString("SubmitDialogInnerTitle") %>",
                        cancelBtnLbl: "<%= LocalizeString("Cancel") %>",
                        acceptBtnLbl: "<%= LocalizeString("SubmitDialogAccept") %>"
                    },
                    approve: {
                        title: "<%= LocalizeString("ApproveDialogTitle") %>",
                        innerTitle: "<%= LocalizeString("ApproveDialogInnerTitle") %>",
                        cancelBtnLbl: "<%= LocalizeString("Cancel") %>",
                        acceptBtnLbl: "<%= LocalizeString("ApproveDialogAccept") %>"
                    },
                    reject: {
                        title: "<%= LocalizeString("RejectDialogTitle") %>",
                        innerTitle: "<%= LocalizeString("RejectDialogInnerTitle") %>",
                        cancelBtnLbl: "<%= LocalizeString("Cancel") %>",
                        acceptBtnLbl: "<%= LocalizeString("RejectDialogAccept") %>"
                    },
                    discard: {
                        title: "<%= LocalizeString("DiscardDialogTitle") %>",
                        innerTitle: "<%= LocalizeString("DiscardDialogInnerTitle") %>",
                        cancelBtnLbl: "<%= LocalizeString("Cancel") %>",
                        acceptBtnLbl: "<%= LocalizeString("DiscardDialogAccept") %>",
                        dialog: {
                            dialogTitle: "<%= LocalizeString("WorkFlowDiscardTitle") %>",
                            dialogText: "<%= LocalizeString("WorkFlowDiscardConfirmText") %>",
                            yesText: "<%= LocalizeString("WorkFlowDiscardConfirmYes") %>",
                            noText: "<%= LocalizeString("WorkFlowDiscardConfirmCancel") %>",
                        }
                    },
                    toasts: {
                        publishedSuccessfully: "<%= LocalizeString("PublishToastMessage") %>",
                        discardedSuccessfully: "<%= LocalizeString("DiscardToastMessage") %>",
                        savedSuccessfully :"<%= LocalizeString("SaveToastMessage") %>"
                    },
                    hasPendingChangesToBeSaved: "<%= LocalizeString("HasPendingChangesToBeSaved") %>"
                };

                dnn.modules.publisher.RequestUtils.init(moduleId);
                dnn.modules.publisher.PublishingManager.init(publishingState, publishingResx, '<%= ListUrl %>/', '<%= ViewPostUrlPattern %>');

                var editBarManagerConfig = { moduleId: moduleId, bindingElementSelector: '#<%= EditBarScopeWrapper.ClientID %>' };
                dnn.modules.publisher.EditBarManager.init(editBarManagerConfig);

                var editbarWrapper = $('#<%= EditBarScopeWrapper.ClientID %>');
                editbarWrapper.appendTo(document.body);
                
                var timeOut;
                $(window).resize(function() {
                    clearTimeout(timeOut);
                    timeOut = setTimeout(function() {
                        editbarWrapper.width($(document.body).innerWidth());
                        editbarWrapper.show(); // it forces properly render in IE9
                    }, 10);
                });
            });
        }(jQuery));
    </script>
</asp:Panel>

<asp:PlaceHolder ID="UserControlPlaceHolder" runat="server" />
