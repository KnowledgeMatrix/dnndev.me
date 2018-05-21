<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RemoveUser.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.RemoveUser" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear scopeWrapper">
    <div id="removeUserFields" class="dnnForm removeUser-container">
        <div id="deleteWarning" runat="server" class="dnnFormMessage dnnFormWarning"><span><%=WarningMessage %></span></div>
        <div>
            <div>
                <input id="removeAllContent" type="checkbox" data-bind="checked: removeAllContent" class="normalCheckBox" />
                <label><%=GetString("RemoveAllContent") %></label>
            </div>
        </div>
        <br />
        <div class="dnnLabel reasonLabel">
            <label>
                <span class="dnnFormRequired"><%= GetString("ReasonDeleting") %></span>
            </label>
        </div>
        <br />
        <div class="reason">
            <textarea class="required reasonText" maxlength="400" rows="7" cols="30" id="deleteReason" data-bind="value: reason"></textarea>
        </div>
    </div>
    <div class="dnnClear dialog-footer">
        <ul class="dnnActions dnnRight">
            <li><a id="cancel" href="javascript:void(0)" data-bind="click: $root.cancel" class="dnnPrimaryAction"><%= GetString("Cancel") %></a></li>
            <li><a id="submit" data-bind="click: $root.submit" class="dnnSecondaryAction"><%= GetString("RemoveUser") %></a></li>
        </ul>
    </div>
</asp:Panel>

<script type='text/javascript'>
    function removeUserInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        settings.validator = validator;
        settings.validate = validator.validate;
        try {
            window.dnn.social.applyBindings(new dnn.social.RemoveUser($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
