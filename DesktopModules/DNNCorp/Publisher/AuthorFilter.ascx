<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AuthorFilter.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.AuthorFilter" %>
<%@ Import Namespace="DotNetNuke.Common.Utilities" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher-filter" runat="server">
    
    <h6><%= LocalizeString("Authors") %></h6>    
    
    <ul class="filter-list" data-bind="foreach: items, visible: items().length !== 0">
        <li data-bind="css: { selected: $root.selectedAuthor() && $data.key == $root.selectedAuthor().key }">
            <span data-bind="text: count"></span>
            <a data-bind="text: name, click: $root.selectAuthor "></a>
        </li>        
    </ul>
    
    <pager params="getPage: getPage, lastPage: lastPage"></pager>

    <script type="text/javascript">
        jQuery(function() {            
            var config = {
                moduleId: <%= ModuleInstanceContext.ModuleId %>,
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                items: <% = Json.Serialize(Items) %>,
                pageSize: <% = Json.Serialize(PageSize) %>,
                count: <% = Json.Serialize(Count) %>,
                selectedAuthor: dnn.modules.publisher.CardViewManager.selectedAuthor
            };
                        
            dnn.modules.publisher.AuthorFilterManager.init(config);
        });
    </script>
</asp:Panel>