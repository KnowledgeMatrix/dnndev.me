<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompanyResponse.ascx.cs" Inherits="DotNetNuke.Professional.Ideas.Controls.CompanyResponse" %>

<div data-bind="stopBindings: true">
    <asp:Panel ID="ScopeWrapper" runat="server">
        <div id="ideaResponseFields" class="dnnForm dnnClear" data-bind="with: model">
            <div class="dnnFormItem">
                <div class="dnnLabel"><label for="txtCompanyResponse"><span class="dnnFormRequired"><%= GetString("lblResponse") %></span></label></div>
                <textarea data-bind="value: $root.companyResponse" cols="100" maxlength="150" id="txtCompanyResponse" class="required idea-add-response"></textarea>
            </div>
             <div class="dnnFormItem" data-bind="visible: $root.moderator">
                <div class="dnnLabel"><label for="status"><span><%= GetString("lblStatus") %></span></label></div>
                <select data-bind="options: $root.statusList, optionsValue: 'value', optionsText: 'status', value: $root.status" id="status"></select>
            </div>
        </div>
        <div class="dnnClear dialog-footer">
                <ul class="dnnActions dnnRight">
                    <li><button type="button" id="btnCancel" data-bind="click: $root.cancel" class="dnnSecondaryAction"><span class="ui-button-text"><%= GetString("Cancel") %></span></button></li>
                    <li><button type="button" id="btnSaveResponse" data-bind="click: $root.save" class="dnnPrimaryAction"><span class="ui-button-text"><%= GetString("Save") %></span></button></li>
                </ul>
            </div>
     </asp:Panel>
</div>
<script type="text/javascript">
    function responseInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        settings.validate = validator.validate;
	    var model = <%= SerializedIdeaInfo() %>;
        try {
            window.dnn.social.applyBindings(new window.dnn.ideas.ResponseView($, window.ko, settings, model), settings.moduleScope);
        } catch(ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>