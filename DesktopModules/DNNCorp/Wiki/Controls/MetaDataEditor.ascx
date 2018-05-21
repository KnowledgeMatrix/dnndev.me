<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MetaDataEditor.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.MetaDataEditor" %>

<%@ Register TagPrefix="dnn" TagName="FilePickerUploader" Src="~/controls/filepickeruploader.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="wiki-meta-tabs">
    <ul class="dnnAdminTabNav dnnClear">
        <li>
            <a id="tab-selector-image" href="#tabs-image">
                <%= LocalizeString("Image") %>
            </a>
        </li>
        <li>
            <a id="tab-selector-metadata" href="#tabs-metadata">
                <%= LocalizeString("MetaData") %>
            </a>
        </li>
    </ul>
    <div id="tabs-image" class="dnnClear" style="display: none;margin: 0 22px 0 22px">
        <div class="dnnForm">
            <dnn:FilePickerUploader id="ctlImage" runat="server" />
        </div>
        <div class="dnnClear"></div>
    </div>
    <div id="tabs-metadata" class="dnnClear" style="display: none;margin: 0 22px 0 22px">
        <p>
            <%= LocalizeString("MetaDataHint") %>
        </p>
        <div class="dnnForm">
            <fieldset>
                <!-- ko foreach: list -->
                <div class="dnnFormItem">
                    <div class="dnnLabel">
                        <label data-bind="text: localizedKey"></label>
                    </div>
                    <!-- ko if: fieldType() == 0 -->
                    <!-- date -->
                    <input type="text" class="meta-datepicker" data-bind="value: value" />
                    <!-- /ko -->
                    <!-- ko if: fieldType() == 1 -->
                    <!-- text -->
                    <input type="text" data-bind="value: value" />
                    <!-- /ko -->
                    <!-- ko if: fieldType() == 2 -->
                    <!-- url -->
                    <input type="text" data-bind="value: value" />
                    <!-- /ko -->
                    <!-- ko if: fieldType() == 3 -->
                    <!-- boolean -->
                    <input type="radio" data-bind="attr: { name: 'value-' + settingId() }" />
                    <%= LocalizeString("No") %>
                    <input type="radio" data-bind="attr: { name: 'value-' + settingId() }" />
                    <%= LocalizeString("Yes") %>
                    <!-- /ko -->
                    <!-- ko if: fieldType() == 4 -->
                    <!-- multiline text -->
                    <textarea data-bind="value: value"></textarea>
                    <!-- /ko -->
                </div>
                <!-- /ko -->
            </fieldset>
        </div>
    </div>
</asp:Panel>

<script type="text/javascript">
    function wiki_metadataEditorInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.MetaDataEditor(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
