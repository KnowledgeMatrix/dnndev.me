<%@ Control language="C#" Inherits="DotNetNuke.Professional.ActivityStream.ActivityFilterBuilder" AutoEventWireup="false"  Codebehind="ActivityFilterBuilder.ascx.cs" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnclear">
    <asp:PlaceHolder runat="server" ID="plhContent" />
    <div id="postFields" class="dnnForm">
        <input type="text" id="FilterId" data-bind="value: FilterId" style="display: none"/>
        <div class="dnnFormItem">
            <div class="dnnLabel"><label for="FilterName"><span class="dnnFormRequired"><%= Localize("FilterName") %></span></label></div>
            <input type="text" maxlength="256" id="FilterName" class="required" data-bind="value: FilterName" />
            <span></span>
        </div>
        <div class="dnnFormItem">
            <div class="dnnLabel"><label for="FilterAuthors"><span><%= Localize("Authors") %></span></label></div>
            <input type="text" id="FilterAuthors" />
        </div>
        <div class="dnnFormItem">
            <div class="dnnLabel"><label for="FilterGroups"><span><%= Localize("Groups") %></span></label></div>
            <input type="text" id="FilterGroups" />
        </div>
        <div class="dnnFormItem">
            <div class="dnnLabel"><label></label></div>
            <div class="contentTypesContainer">
                <ul class="filterTypes" data-bind="foreach: FilterTypes" id="FilterTypes">
                    <li class="filterType" data-bind="attr: { value: FilterTypeId}, click: $parent.SelectDeselectTypeFilter">
                        <div id="checkboxImg" data-bind="css: {checked: Selected(), unchecked: !Selected()}"></div><span data-bind="text: FilterType"></span>
                    </li>
                </ul>
            </div>
        </div>
    </div>  
    <div class="dnnClear dialog-footer">
        <ul class="dnnActions dnnRight">
            <li> <a href="#" id="cancel" data-bind="click: Cancel" class="dnnSecondaryAction"><%= Localize("Cancel") %></a></li>
            <li><a href="#" id="delete" data-bind="click: Delete, visible: canDelete" class="dnnSecondaryAction"><%= Localize("Delete") %></a>    </li>
            <li><a href="#" id="saveUpdate" data-bind="click: SaveUpdate" class="dnnPrimaryAction"><span id="saveUpdateText" data-bind="    html: saveUpdateText"></span></a>  </li>
        </ul>
    </div>
</asp:Panel>

<script type="text/javascript">
    function activityFilterBuilderInit(settings) {
        if ('<%= Authenticated %>'.toLowerCase() == 'true') {
            settings.moduleScope = $(settings.moduleScope)[0];
            var sf = $.ServicesFramework(settings.moduleId);
            var params = {
                portalId: <%= PortalId %>,
                moduleId: settings.moduleId,
                userId: <%= UserId %>,
                authorKey: '<%= FilterKeyAuthor %>',
                groupKey: '<%= FilterKeyGroup %>',
                typeKey: '<%= FilterKeyType %>',
                filterId: $('#filterBuilder').data('FilterId')
            };                    
            dnn.social.applyBindings(new dnn.activityFilterBuilder.ViewModel($, ko, settings, sf, params), settings.moduleScope);
        }
    }
</script>
