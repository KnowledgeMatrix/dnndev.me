<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GroupEditWizard.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.GroupEditWizard" %>
<%@ Register TagPrefix="dnn" TagName="FilePickerUploader" Src="~/controls/filepickeruploader.ascx" %>

<asp:Panel ID="ScopeWrapper" runat="server">
    <div id="postFields" class="dnnForm group-container">
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label>              
                    <span class="dnnFormRequired"><%= GetString("GroupName") %></span>
                </label>
            </div>
            <input type="text" maxlength="50" id="groupName" data-bind="value: groupName" class="required group-text-input group-add-name customValidate validateGroupName" />
        </div>
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label>
                    <span class="dnnFormRequired"><%= GetString("Description") %></span>
                </label>
            </div>            
            <textarea class="required group-text-input" maxlength="1000" rows="7" cols="30" id="groupDescription" data-bind="value: description"></textarea>
        </div>
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label for="tags">
                    <span class="dnnFormRequired"><%= GetString("Tags") %></span>
                </label>
            </div>
            <input type="text" id="groupTags" class="required" />
        </div>
        <br/>
        <div class="dnnFormItem">
            <div class="dnnLabel">
                <label>
                    <span class="dnnFormRequired"><%= GetString("GroupPicture") %></span>
                </label>
            </div>
            <div>
                <dnn:FilePickerUploader id="groupImageFile" runat="server" class="required" />
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
                        <input type="radio" name="edit-group-accessibility" value="public" data-bind="checked: accessibility, click: accessibilityChange" /> 
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
                        <input type="radio" name="edit-group-accessibility" value="private" data-bind="checked: accessibility, click: accessibilityChange" />                       
                        <label><%=GetString("Private.Text")%></label>
                    </div>
                    <div class="accessibility-help"><%=GetString("Private.Help")%></div>
                </div>
            </div>    
        </div>       
    </div>
    <div class="dnnClear dialog-footer">
        <ul class="dnnActions dnnRight">	     
	        <li><a href="#" data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Cancel") %></a></li>
            <li><a data-bind="click: $root.update" class="dnnPrimaryAction"><%= GetString("SaveGroup") %></a></li>
        </ul>
    </div>
</asp:Panel>

<script type="text/javascript">
    function editGroupInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        var sf = $.ServicesFramework(settings.moduleId);
        settings.validator = validator;
        settings.validate = validator.validate;

        try {
            window.dnn.social.applyBindings(new window.dnn.social.GroupEditWizard($, window.ko, sf, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }

</script>
