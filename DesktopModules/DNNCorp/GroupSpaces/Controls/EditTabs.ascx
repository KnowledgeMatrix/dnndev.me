<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditTabs.ascx.cs" Inherits="DotNetNuke.Professional.GroupSpaces.Controls.EditTabs" %>

<asp:Panel ID="ScopeWrapper" runat="server" CssClass="dnnClear scopeWrapper">
    <div id="groupFields" class="dnnForm groupTabs-container">
        <div class="noGroupFeatures">
            <div class="dnnFormItem">
                <div class="dnnLabel">
                    <label>
                        <span><%= GetString("NoGroupFeaturesAvailable") %> </span>
                    </label>
                </div>
            </div>
           <br/><br/>
        </div>
        <div class="groupFeatures">
            <div class="dnnFormItem">
                <div class="dnnLabel">
                    <label>
                        <span class="dnnFormRequired"><%= GetString("GroupFeatures") %>: </span>
                    </label>
                </div>
                <div id="groupSpacesTabs" class="checkboxlist">
                     <% foreach (var tab in GroupTabs) 
                        { %>
                            <div style="margin-left: 16px">
                                <input type="checkbox" class="dnnCheckbox" id="<%= "tab_" + tab.TabId %>" value="<%= tab.TabId %>"
                                    <%= tab.ShowTab ? "checked=\"checked\"" : "" %> data-bind="click: $root.updateSelectedTabs.bind($data, '<%= "tab_" + tab.TabId %>')">
                                <span><%= tab.TabName %></span>
                            </div>
                     <%  
                        } %>
                </div>
            </div>

            <div class="dnnFormItem" style="display:none">
                <div class="dnnLabel">
                    <label>
                        <span class="dnnFormRequired"><%= GetString("GroupHomePage") %>: </span>
                    </label>
                </div>
                <div>
                    <select data-bind="options: selectedTabs, optionsText: function (item) { return item.tabName; }, optionsValue: function (item) { return item.tabId; }, value: homeTabId"></select>
                </div>
            </div>
        </div>
    </div>
    <div class="dnnClear dialog-footer">
        <ul class="dnnActions dnnRight">
            <li><a id="save" data-bind="click: $root.updateGroupTabs" class="dnnPrimaryAction"><%= GetString("Save") %></a></li>
            <li><a id="cancel" href="#" data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Cancel") %></a></li>
        </ul>
    </div>
</asp:Panel>

<script type='text/javascript'>
    function editTabsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        try {
            window.dnn.social.applyBindings(new dnn.groupSpaces.EditTabs($, ko, settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
