<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TagsFilter.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.TagsFilter" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher-filter" runat="server">
    
    <h6><%= LocalizeString("Tags") %></h6>

    <ul class="filter-list" data-bind="foreach: items, visible: items().length !== 0">
        <li data-bind="css: { selected: $root.selectedTags.indexOf(name) >= 0 }">
            <span  data-bind="text: count"></span>
            <a data-bind="text: name, click: $root.selectTag "></a>
        </li>
    </ul>
    
    <pager params="getPage: getPage, lastPage: lastPage"></pager>
    
    <script type="text/javascript">
        jQuery(function() {            
            var config = {
                moduleId: <%= ModuleInstanceContext.ModuleId %>,
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                items: <% = Json.Serialize(Items) %>,
                pageSize: <% = PageSize %>,
                count: <% = Json.Serialize(Count) %>,
                selectedTags: dnn.modules.publisher.CardViewManager.selectedTags
            };
                        
            dnn.modules.publisher.TagsFilterManager.init(config);
        });
    </script>
</asp:Panel>