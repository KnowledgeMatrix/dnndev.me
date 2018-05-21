<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchControl.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.SearchControl" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>
<div data-bind="stopBindings: true">
    <asp:Panel runat="server" ID="ScopeWrapper">
        <%-- NORMAL VIEW --%>
        <!-- ko ifnot: isMobileView -->
        <div class="searchControl-normalView ko-container" id="divSearchNormal">
            <div class="dnnTableFilter dnnClear" data-bind="escapeKey: hideSuggestions">
                <div class="dnnFilterSet">
                    <h3><%= TitleText %></h3>
                    <table>
                        <tr>
                            <td>
                                <div class="txtWrapper">
                                    <input type="text" data-bind="value: query, valueUpdate: 'afterkeydown'" placeholder="<%= PlaceHolderText %>" autocomplete="off" />
                                </div>
                                 <% if (!HideCreateButton)
                                    { %>
                                <a href="javascript:void(0)" data-bind="click: submit"><%= CreateText %></a>
                                <% } %>
                            </td>
                            <td>
                                <a data-bind="click: searchBtnClicked" class="dnnPrimaryAction"><%= SearchText %></a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="search-suggestion">
                <div class="triangle"></div>
                <% if (!HideCreateButton)
                   { %>
                <div class="search-suggestion-instruction pinkLink">
                    <p><%= LocalizeString("IWouldLikeTo") %></p>
                    <a data-bind="click: submit" class="dnnPrimaryAction search-suggestion-btn"><%= CreateText %></a>
                </div>
                <% } %>
                <div class="search-suggestion-title">
                    <a data-bind="click: searchBtnClicked"><%= ViewRelatedText %> (<span data-bind="    text: totalRecords"></span>)</a>
                </div>
                <div>
                    <ul class='search-suggestion-list'>
                        <!-- ko foreach: results -->
                        <li>
                            <a class='dnnSocialLink' data-bind="attr: { href: url() }">
                                <span data-bind="html: title"></span>
                            </a>
                        </li>
                        <!-- /ko -->
                    </ul>
                </div>
            </div>
        </div>
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>
    
        <%-- MOBILE VIEW --%>
        <!-- ko if: isMobileView -->
        <div class="searchControl-mobileView ko-container" id="divSearchMobile">
            <div class="dnnMobileTableFilter dnnClear">
                <div class="dnnMobileFilterSet">
                    <a data-bind="click: hideSuggestionsMobileView" class="dnnMobileFilterSet-Cancel">Cancel</a>
                    <input type="text" placeholder="Search" autocomplete="off" data-bind="value: query, valueUpdate: 'afterkeydown'"  />
                </div>
            </div>
            <div class='dnnMobileSocialSearchResult'>
                <ul>
                    <!-- ko foreach: results -->
                    <li>
                        <a class='dnnSocialLink' data-bind="attr: { href: url() }">
                            <span data-bind="html: title"></span>
                        </a>
                    </li>
                    <!-- /ko -->
                </ul>
                <% if (!HideCreateButton)
                   { %>
                <a data-bind="click: submit" class="dnnMobileCreateNewButton-searchResult"><%= CreateText %></a>
                <% } %>
            </div>
            <% if (!HideCreateButton)
               { %>
            <a data-bind="click: submit" class="dnnMobileCreateNewButton"><%= CreateText %></a>
            <% } %>
        </div>
        <!-- /ko -->
        <%-- END NORMAL VIEW --%>
    </asp:Panel>
</div>
<script type="text/javascript">
    (function () {
        var searchControl = document.getElementById('<%= ScopeWrapper.ClientID %>');
        if (searchControl && searchControl.offsetWidth > 600)
            searchControl.getElementsByClassName('searchControl-normalView')[0].style.display = 'block';

        $(function() {
            var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
            settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
            settings.placeholder = '<%= PlaceHolderText %>';
            settings.contentTypeId = <%= ContentTypeId %>;
            settings.groupId = <%= GroupId %>;
            settings.roleGroupId = <%= RoleGroupId %>;
            settings.maximumSearchItems = <%= MaximumSearchItems %>;
            settings.searchUrl = '<%= SearchResultsUrl %>';
            if (!settings.moduleScope) {
                return;
            }

            try {
                dnn.social.applyBindings(new dnn.social.SearchControl(settings), settings.moduleScope);
            } catch(ex) {
                dnn.social.topLevelExceptionHandler(settings, ex);
            }
        });
    })();
</script>
