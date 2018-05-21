<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Search.ascx.cs" Inherits="DotNetNuke.Enterprise.Publisher.Search" %>

<asp:Panel ID="ScopeWrapper" CssClass="publisher-search" runat="server">

    <input type="search" class="search-input" placeholder="<%= LocalizeString("Search") %>"
           data-bind="value: inputSearchText, valueUpdate: 'afterkeydown', event: { keypress: keyPress }" aria-label="Search"/>

    <a class="search-button" data-bind="click: doSearch"></a>
    
    <div class="publisher-filter" data-bind="visible: viewing().length > 0">
        <h6><%= LocalizeString("Viewing") %></h6>

        <input type="text" data-bind="tokenInput: viewing, onDelete: onRemovedFilter" aria-label="Filter"/>
    </div>
    
    <script type="text/javascript">
        jQuery(function() {            
            var config = {
                moduleId: <%= ModuleInstanceContext.ModuleId %>,
                bindingElementSelector: '#<%= ScopeWrapper.ClientID %>',
                searchText: dnn.modules.publisher.CardViewManager.searchText,
                selectedTags: dnn.modules.publisher.CardViewManager.selectedTags,
                selectedAuthor: dnn.modules.publisher.CardViewManager.selectedAuthor
            };
                        
            dnn.modules.publisher.SearchManager.init(config);
        });
    </script>
</asp:Panel>