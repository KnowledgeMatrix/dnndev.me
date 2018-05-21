<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateWizard.ascx.cs" Inherits="DotNetNuke.Professional.GroupDirectory.Controls.CreateWizard" %>
<%@ Register TagPrefix="dnn" TagName="FilePickerUploader" Src="~/controls/filepickeruploader.ascx" %>
<%@ Register TagPrefix="dnn" TagName="GroupInviteMembers" Src="~/DesktopModules/DNNCorp/SocialLibrary/Controls/GroupInviteMembers.ascx" %>

<asp:Panel ID="ScopeWrapper" runat="server">
    <div class="social-wizard" id="wizard" style="overflow: auto;">
        
        <ul class="wizard-tabs">
            <li id="details-step">
                <!-- ko ifnot: isMobileView -->
                <a href="javascript:void(0)" data-bind="click: switchTo0">
                    <div class="wizardStep">
                        <span class="wizardStepNumber">1</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= GetString("WizardDetailsStepTitle") %></span>
                            <span class="wizardStepDescription"><%= GetString("WizardDetailsStepDescription") %></span>
                        </div>
                        <span class="wizardStepArrow"></span>
                    </div>
                </a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                <div class="wizardStep">
					<span class="wizardStepNumber">1</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= GetString("WizardDetailsStepTitle") %></span>
                        <span class="wizardStepDescription"><%= GetString("WizardDetailsStepDescription") %></span>
                    </div>
				</div>
                <!-- /ko -->
            </li>
            <li id="features-step">
                <!-- ko ifnot: isMobileView -->
                <a href="javascript:void(0)" data-bind="click: switchTo1">
                    <div class="wizardStep">
                        <span class="wizardStepNumber">2</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= GetString("WizardFeaturesStepTitle") %></span>
                            <span class="wizardStepDescription"><%= GetString("WizardFeaturesStepDescription") %></span>
                        </div>
                        <span class="wizardStepArrow"></span>
                    </div>
                </a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                <div class="wizardStep">
					<span class="wizardStepNumber">2</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= GetString("WizardFeaturesStepTitle") %></span>
                        <span class="wizardStepDescription"><%= GetString("WizardFeaturesStepDescription") %></span>
                    </div>
				</div>
                <!-- /ko -->
            </li>
            <li id="invite-step">
                <!-- ko ifnot: isMobileView -->
                <a href="javascript:void(0)" data-bind="click: switchTo2">
                    <div class="wizardStep">
                        <span id="wizardInviteStepNumber" class="wizardStepNumber">3</span>
                        <div class="dnnLeft">
                            <span class="wizardStepTitle"><%= GetString("WizardInviteStepTitle") %></span>
                            <span class="wizardStepDescription"><%= GetString("WizardInviteStepDescription") %></span>
                        </div>
                    </div>
                </a>
                <!-- /ko -->
                <!-- ko if: isMobileView -->
                 <div class="wizardStep">
					<span class="wizardStepNumber">3</span>
                    <div class="dnnLeft">
                        <span class="wizardStepTitle"><%= GetString("WizardInviteStepTitle") %></span>
                        <span class="wizardStepDescription"><%= GetString("WizardInviteStepDescription") %></span>
                    </div>
				</div>
                <!-- /ko -->
            </li>
        </ul>

        <div class="wizardPage" id="details-page">
            <div class="dnnForm">
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label>
                            <span class="dnnFormRequired"><%= GetString("GroupName") %></span>
                        </label>
                    </div>
                    <input type="text" maxlength="50" id="groupName" data-bind="value: groupName" class="required group-text-input group-add-name customValidate validateGroupName validateGroupNameDoesNotExist" autofocus="autofocus" />
                </div>
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label>
                            <span class="dnnFormRequired"><%= GetString("Description") %></span>
                        </label>
                    </div>
                    <textarea class="required group-text-input" maxlength="1000" rows="7" cols="30" id="content" data-bind="value: description"></textarea>
                </div>             
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label for="tags">
                            <span class="dnnFormRequired"><%= GetString("Tags") %></span>
                        </label>
                    </div>
                    <input type="text" id="tags" class="required group-tag-input" />
                </div>
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label>
                            <span class="dnnFormRequired"><%= GetString("GroupPicture") %></span>
                        </label>
                    </div>
                    <div>
                        <dnn:FilePickerUploader id="groupImageFile" runat="server" class="required" />
                        <input type="hidden" id="validateGroupImageId" class="customValidate validateGroupImage" />
                    </div>
                </div>
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label>
                            <span class="dnnFormRequired"><%= GetString("Accessibility") %></span>
                        </label>
                    </div>
                    <div class="accessibility">
                        <div>
                            <div class="accessibility-label">
                                <input type="radio" name="create-group-accessibility" value="public" data-bind="checked: Accessibility, click: canInviteByEmail" />
                                <label><%=GetString("Public.Text")%></label>
                            </div>
                            <div class="accessibility-help"><%=GetString("Public.Help")%></div>
                            <div class="accessibility-review">
                                <input id="reviewMembers" class="reviewMembers" type="checkbox" data-bind="checked: reviewMembers" /><label><%=GetString("ReviewNewMembers") %></label>
                                <div class="mustBeApproved"><%=GetString("MembersMustBeApproved")%></div>
                            </div>
                        </div>
                        <div>
                            <div class="accessibility-label">
                                <input type="radio" name="create-group-accessibility" value="private" data-bind="checked: Accessibility, click: canInviteByEmail" />
                                <label><%=GetString("Private.Text")%></label>
                            </div>
                            <div class="accessibility-help"><%=GetString("Private.Help")%></div>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        <div class="wizardPage" id="features-page">
            <div class="dnnForm">
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label for="groupSpacesTabs">
                            <span class="dnnFormRequired"><%= GetString("GroupFeatures") %>: </span>
                        </label>
                    </div>
                    <input type="hidden" class="customValidate validateGroupFeatures"/>
                    <div id="groupSpacesTabs" class="checkboxlist">
                        <% var i = 0;
                           foreach (var tab in GroupTabs) 
                           { %>
                                <div style="margin-left: 16px">
                                    <input type="checkbox" class="dnnCheckbox" id="<%= "tab_" + tab.TabId %>" value="<%= tab.TabId %>"
                                           data-bind="click: $root.updateSelectedTabs, checked: tabs()[<%= i %>].selected" />
                                    <span> <%= tab.TabName %></span>                                    
                                </div>
                        <%   i++;
                           } %>
                    </div>
                </div>
                <div class="dnnFormItem groupTabs" style="display: none">
                    <div class="dnnLabel">
                        <label>
                            <span class="dnnFormRequired"><%= GetString("GroupHomePage") %>: </span>
                        </label>
                    </div>
                    <div class="groupTabs-container">
                        <select data-bind="options: selectedTabs, optionsText: function (item) { return item.tabName; }, optionsValue: function (item) { return item.tabId; }, value: homeTabId"></select>
                    </div>
                </div>
            </div>
        </div>
        <div id="invite-page" data-bind="stopBindings: true" class="wizardPage invite-page">
            <dnn:GroupInviteMembers id="InviteMembers" runat="server"></dnn:GroupInviteMembers>
        </div>
        <div class="dnnClear dialog-footer">
            <ul class="dnnActions dnnRight">
                 <li><a id="prev" data-bind="click: $root.prev" class="dnnSecondaryAction"><%=GetString("Previous") %></a></li>
                 <li><a id="next" data-bind="click: $root.next" class="dnnPrimaryAction"><%=GetString("Next") %></a></li>
            </ul>
        </div>
    </div>
    <div id="groupUnderModeration" style="display:none" >
	    <div class="dnnClear dnnFormMessage dnnFormSuccess">
	        <%= GetString("WaitForModeration") %>
	    </div>
        <div>
            <a id="close" class="dnnSecondaryAction" data-bind="click: closeGroupUnderModerationDialog"><%=GetString("Close") %></a>
        </div>
    </div>
</asp:Panel>

<script type="text/javascript">
    function createInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        settings.validator = validator;
        settings.validate = validator.validate;

        try {
            window.dnn.social.applyBindings(new window.dnn.groupDirectory.CreateWizard($, window.ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }

</script>
