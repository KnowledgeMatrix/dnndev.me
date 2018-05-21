<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ColumnTable.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.ColumnTable" %>

<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper">
        <table class="wiki-column-table">
            <tbody>
                <!-- ko foreach: rows -->
                <tr>
                    <!-- ko foreach: columns -->
                    <td data-bind="click: click, event: { mouseover: mouseOver }">
                        <span data-bind="text: sequence"></span>
                    </td>
                    <!-- /ko -->
                    <td data-bind="click: rspacer.click, event: { mouseover: rspacer.mouseOver }" class="spacer">
                        &nbsp;
                    </td>
                    <!-- /ko -->
                </tr>
                <!-- /ko -->
                <tr>
                    <td data-bind="click: bspacer.click, event: { mouseover: bspacer.mouseOver }, attr: { 'colspan': columnCount }" class="spacer bottom">
                        &nbsp;
                    </td>
                </tr>
            </tbody>
        </table>

        <asp:HiddenField runat="server" ID="hfdLayout" />
    </asp:Panel>
</div>

<script type="text/javascript">
    function wiki_columnTableInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.ColumnTable(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>