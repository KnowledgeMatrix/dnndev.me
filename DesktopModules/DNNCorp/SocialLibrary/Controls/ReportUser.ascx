<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportUser.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.ReportUser" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>
<div data-bind="stopBindings: true" style="display: none;">
    <asp:Panel runat="server" ID="ScopeWrapper">
        <div class="social-report-content">
            <h3>
                <span data-bind="html: title"></span>
            </h3>
            <div class="social-report-reason-list">
                <ul>
                    <li>
                        <input id="socialReport-spammer" class="normalRadioButton" type="radio" name="reason" value="4" data-bind="checked: reason" /> 
                        <label for="socialReport-spammer"> <%= Localization.GetString("ReportSpammer", DotNetNuke.SocialLibrary.Components.Common.Constants.SharedResources) %></label>
                    </li>
                    <li>
                        <input id="socialReport-inappropriate" class="normalRadioButton" type="radio" name="reason" value="5" data-bind="checked: reason" /> 
                        <label for="socialReport-inappropriate"> <%= Localization.GetString("ReportInappropriateBehaviour", DotNetNuke.SocialLibrary.Components.Common.Constants.SharedResources) %></label>
                    </li>
                    <li>
                        <input id="socialReport-other" class="normalRadioButton" type="radio" name="reason" value="3" data-bind="checked: reason" /> 
                        <label for="socialReport-other"> <%= Localization.GetString("ReportOther", DotNetNuke.SocialLibrary.Components.Common.Constants.SharedResources) %></label>
                    </li>
                </ul>
            </div>
            <div class="social-report-other">
                <textarea data-bind="value: otherText"></textarea>
            </div>
    
            <div class="content-reported" style="display:none">
                
                <div class="dnnClear dnnFormMessage dnnFormSuccess">
                    <%= Localization.GetString("ContentReported", DotNetNuke.SocialLibrary.Components.Common.Constants.SharedResources) %>  
                </div>

                <div class="ui-dialog-buttonset">
                    <button type="button" id="btnClose" class="dnnPrimaryAction" data-bind="click: $root.cancel" >
                        <span class="ui-button-text"> <%= Localization.GetString("Close", DotNetNuke.SocialLibrary.Components.Common.Constants.SharedResources) %>  </span>
                    </button>
                </div>

            </div>

        </div>

    </asp:Panel>
</div>
<% if (Visible)
   { %>
    <script type='text/javascript'>
        $(function () {
	    var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
            settings.controller = '<%= ControllerName %>';
            settings.reportedUserId = <%= ReportedUserId %>;
            settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
            settings.parentControlScopeId = '<%= ParentControlScopeId %>';

            if (String.isEmpty(settings.controller)) {
                throw Error('No reporting controller name set');
            }

            var model = new dnn.social.ReportControl($, window.ko, settings);

            dnn.social.reportUser = function (userId) {
                model.raiseUser(userId);
            };

            window.ko.applyBindings(model, settings.moduleScope);
        });
    </script>
<% } %>