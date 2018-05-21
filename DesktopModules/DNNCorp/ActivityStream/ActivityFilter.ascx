<%@ Control language="C#" Inherits="DotNetNuke.Professional.ActivityStream.ActivityFilter" AutoEventWireup="false"  Codebehind="ActivityFilter.ascx.cs" %>
<%@ Register TagPrefix="filter" TagName="FilterBuilder" src="ActivityFilterBuilder.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper" CssClass="dnnClear">
    <asp:PlaceHolder runat="server" ID="plhContent" />
    <ul class="filters dnnClear" data-bind="foreach: Filters" id="ulFilters">
        <li class="filter">
            <div>
                <a href="#" data-bind="click: $root.sendFilterMessage">
                    <span data-bind="html: FilterName"></span>
                </a>
                <a href="#" class="editFilter" data-bind="click: $parent.showFilterEditor"></a>
            </div>
        </li> 
    </ul>
    <hr class="linkDivider" /> 
    <div id="createNew" runat="server" class="createNew dnnRight">
        <a data-bind="click: showFilterEditor" href="#"><%= LocalizeString("CreateNewFilter") %></a>
    </div>
 </asp:Panel>   
<div class="activityFilterBuilder" id="filterEditorContainer" data-bind="dialog: FilterEditor" style="display:none;">
    <filter:FilterBuilder id="filterEditor" runat="server" />
</div>
<script type="text/javascript">
    function activityStreamFiltersInit(settings) {
        if ('<%= Authenticated %>'.toLowerCase() == 'true') {
            settings.moduleScope = $(settings.moduleScope)[0];
            settings.filterBuilderId = '<%= string.Format("#{0}", filterEditor.FindControl("ScopeWrapper").ClientID) %>';
            var sf = $.ServicesFramework(settings.moduleId);
            var params = { userId: <%= UserId %>};
            dnn.social.applyBindings(new dnn.activityStreamFilters.ViewModel($, ko, settings, sf, params), settings.moduleScope);
        }
    }   
</script>
