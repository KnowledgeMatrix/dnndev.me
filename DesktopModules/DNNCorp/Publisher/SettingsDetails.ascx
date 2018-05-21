<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsDetails.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.SettingsDetails" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="edit-bar-panel settings" data-bind="css: {expanded: visible}">
    <div class="edit-bar-panel-title">
        <h2><%= LocalizeString("SettingsTitle") %></h2>
        <div data-bind="click: cancel" class="edit-bar-panel-close" title="<%= LocalizeString("CloseSettings") %>"></div>
    </div>
    <div class="edit-bar-panel-container">
        <div class="left">            
            <span class="field-label">
                <%= LocalizeString("SettingsLabelSelectWorkflow") %>
            </span>

            <select data-bind="options: workflows,
                    optionsText: 'workflowName',
                    optionsValue: 'workflowId',
                    value: selectedWorkflowId" aria-label="Workflows">
            </select>
        </div>
    
        <div class="right">
            <span class="field-label">
                <%= LocalizeString("EnableSharing") %>
            </span>    
        
            <input id="enableTwitter" data-bind="checked: twitterEnabled" type="checkbox" class="share"/>
            <label for="enableTwitter" class="share twitter">Share</label>

            <input id="enableFacebook" data-bind="checked: facebookEnabled" type="checkbox" class="share"/>
            <label for="enableFacebook" class="share facebook">Share</label>

            <input id="enableLinkedin" data-bind="checked: linkedInEnabled" type="checkbox" class="share"/>
            <label for="enableLinkedin" class="share linkedin">Share</label>

            <input id="enablePinterest" data-bind="checked: pinterestEnabled" type="checkbox" class="share"/>
            <label for="enablePinterest" class="share pinterest">Share</label>
            
            <input id="enableRss" data-bind="checked: rssEnabled" type="checkbox" class="share"/>
            <label for="enableRss" class="share rss">Share</label>
        </div>

        <div class="actions">
            <a class="btn btn-cancel"
                data-bind="click: cancel"><%= LocalizeString("Cancel") %></a>
            <a class="btn btn-accept"
                data-bind="click: save"><%= LocalizeString("Save") %></a>
        </div>
    </div>
    
    <script type="text/javascript">
        (function ($) {
            $(document).ready(function () {
                var settingsManagerConfig = { moduleId: <%= ModuleId %>, bindingElementSelector: '#<%= ScopeWrapper.ClientID %>' };
                dnn.modules.publisher.SettingsManager.init(settingsManagerConfig);
            });
        }(jQuery));
    </script>
</asp:Panel>