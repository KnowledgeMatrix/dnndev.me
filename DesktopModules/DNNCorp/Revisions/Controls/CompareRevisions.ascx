<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CompareRevisions.ascx.cs" Inherits="DotNetNuke.Social.Revisions.Controls.CompareRevisions" %>
<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper" CssClass="revision-compare-container">
        <div class="compare-container">
            <div class="revision revision-left">
                <div class="revision-selector">
                    <select data-bind="options: $root.revisions, optionsValue: 'revisionId', optionsText: 'description', value: leftRevisionId"></select>
                </div>
                <div class="revision-compare-area" data-bind="html: left"></div>
            </div>

            <div class="revision revision-right">
                <div class="revision-selector">
                    <select data-bind="options: $root.revisions, optionsValue: 'revisionId', optionsText: 'description', value: rightRevisionId"></select>
                </div>
                <div class="revision-compare-area" data-bind="html: right"></div>
            </div>
            <div class="dnnClear"></div>
        </div>
        <div class="dnnClear"></div>
    </asp:Panel>
</div>

<script type="text/javascript">
    function revisions_compareInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        var model = new window.dnn.revisions.CompareControl(settings);
        var compareControlBinded = false;
        window.dnn.revisions.compare = function (left, right) {
            if (!compareControlBinded) {
                window.dnn.social.applyBindings(model, settings.moduleScope);
                compareControlBinded = true;
            }

            var options = {
                modal: true,
                autoOpen: true,
                closeOnEscape: false,
                dialogClass: 'dnnFormPopup',
                title: '<%= LocalizeString("Compare") %>',
                minWidth: 820,
                resizable: false,
                buttons: [
                    {
                        priority: 'primary',
                        'class': 'dnnPrimaryAction',
                        text: '<%= LocalizeString("OK") %>',
                        click: model.close
                    }
                ],
                open: function() {
                    model.load(left, right);
                }
            };
            $(settings.moduleScope).dialog(options);
        };
    }
</script>