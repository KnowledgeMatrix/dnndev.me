<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContentExchange.ascx.cs" Inherits="DotNetNuke.SocialLibrary.Controls.ContentExchange" %>
<%@ Import Namespace="DotNetNuke.SocialLibrary" %>
<div data-bind="stopBindings: true" style="display: none;">
    <asp:Panel runat="server" ID="ScopeWrapper">
        <div class="social-content-exchange">
            <div class="dnnForm social-content-exchange-form">
                <div class="social-content-exchange-title">
                    <span data-bind="html: title"></span>
                </div>
                <div class="social-content-exchange-summary">
                    <span data-bind="html: summary"></span>
                </div>
                <div class="dnnFormItem">
                    <div class="dnnLabel"><label for="socialContentType"><span><%= GetString("Destination") %></span></label></div>
                    <select data-bind="options: $root.destinationsList, optionsValue: 'socialContentTypeId', optionsText: 'socialContentTypeName', value: socialContentTypeId, event:{ change: onChangeDestination }" id="socialContentType"></select>  
                </div>
                <div class="dnnFormItem" data-bind="visible: isPageVisible">
                    <div class="dnnLabel"><label for="page"><span><%= GetString("Page") %></span></label></div>
                    <select data-bind="options: $root.tabsList, optionsValue: 'tabId', optionsText: 'tabName', value: tabId, event:{change: onChangePage }" id="page"></select>  
                </div>
                <div class="dnnFormItem" data-bind="visible: isModuleVisible">
                    <div class="dnnLabel"><label for="module"><span><%= GetString("Area") %></span></label></div>
                    <select data-bind="options: $root.modulesList, optionsValue: 'moduleId', optionsText: 'moduleName', value: moduleId, event:{change: onChangeModule }" id="module"></select>  
                </div>
                <div class="dnnFormItem" data-bind="visible: isGroupVisible">
                    <div class="dnnLabel"><label for="group"><span><%= GetString("Group") %></span></label></div>
                    <select data-bind="options: $root.groupsList, optionsValue: 'groupId', optionsText: 'groupName', value: groupId" id="group" 
                        class="customValidate validateGroup"></select>  
                </div>
                <!-- ko with: componentFactory.resolve('ContentExchangeSearch') -->
                <div data-bind="visible: $root.isParentVisible" style="margin-bottom: 18px;">
                    <div class="content-exchange-search-parent-header" data-bind="visible: $root.isParentVisible">
                        <label for="contentTextSearch"><span><%= GetString("DestinationContentTitle") %></span></label>
                        <span><input id="contentTextSearch" type="text" data-bind="value: searchText, valueUpdate: 'afterkeydown'" placeholder="<%= GetString("SearchCommentItems") %>" /></span>
                    </div>
                    <div id="parentsList">
                        <input type="hidden" class="customValidate validateParent" />
                        <table class="dnnTableDisplay">
                            <tbody>
                                <!-- ko foreach: results -->
                                <tr data-bind="with: item, click: toggleSelection, attr: { 'class': rowStyle() }">
                                    <td>
                                        <a class='dnnSocialLink' data-bind="attr: { href: contentItemUrl }, html: contentTitle"></a>
                                    </td>
                                </tr>
                                <!-- /ko -->
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- /ko -->
                <div class="dnnFormItem"  data-bind="visible: $root.isContentTitleVisible">
                    <div class="dnnLabel"><label><span><%= GetString("ContentTitle") %></span></label></div>
                    <input type="text" class="customValidate validateContentTitle" id="contentTitle" maxlength="100" data-bind="value: contentTitle">
                </div>
                <div class="dnnFormItem"  data-bind="visible: $root.isWikiModuleVisible">
                    <div class="dnnLabel"><label><span><%= GetString("plPostType") %></span></label></div>
                    <select data-bind="options: $root.availableTypes, optionsText: 'localizedText', optionsValue: 'articleTypeId', value: $root.articleTypeId, enable: $root.isWikiModuleVisible"
                        class="customValidate validateArticleType"></select>
                </div>
                <div class="dnnFormItem" data-bind="visible: $root.isCopyCommentsVisible">
                    <div class="dnnLabel"><label><span></span></label></div>
                    <input id="copyComments" type="checkbox" data-bind="checked: $root.copyComments" />
                    <span><%=GetString("CopyComments") %></span>
                </div>
                <div class="dnnFormItem" id="errorMessage" style="text-align: center"></div>
            </div>
        </div>
    </asp:Panel>
</div>
<% if (Visible)
   { %>
    <script type='text/javascript'>
        $(function () {
            var settings = <%= SocialModule.GetSettingsAsJsonString(ModuleContext) %>;
            settings.moduleScope = $('#<%= ScopeWrapper.ClientID %>')[0];
            settings.parentControlScopeId = '<%= ParentControlScopeId %>';
            settings.contentItemId = <%= ContentItemId %>;
            settings.sourceContentType = '<%= SourceContentType %>';
            settings.sourceContentTypeId = '<%= SourceContentTypeId %>';

            var model = new dnn.social.ContentExchange($, window.ko, settings);

            dnn.social.contentExchange = function (options) {
                model.raise(options);
            };

            window.ko.applyBindings(model, settings.moduleScope);
        });
    </script>
<% } %>