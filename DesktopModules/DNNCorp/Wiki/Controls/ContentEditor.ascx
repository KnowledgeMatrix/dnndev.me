<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContentEditor.ascx.cs" Inherits="DotNetNuke.Professional.Wiki.Controls.ContentEditor" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>

<asp:Panel runat="server" ID="ScopeWrapper" CssClass="wiki-article-creator-container dnnClear">
    <asp:Panel runat="server" ID="DialogScope">
        <div class="dialog-scope dnnClear">
            <!-- ko ifnot: primaryArticle -->
            <!-- ko ifnot: isMobileView -->
            <h2 class="dnnFormSectionHead"><a href="#" class="dnnSectionExpanded"><%= LocalizeString("CommonHeader") %></a></h2>
            <!-- /ko -->
            <!-- /ko -->
            <div class="dnnClear dialog-section">
                <div class="dnnForm wiki-editor-form">
                    <!-- ko ifnot: primaryArticle -->
                    <div class="dnnFormItem">
                        <div class="dnnLabel"><label><span class="dnnFormRequired"><%= GetString("plTitle") %></span></label></div>
                        <input type="text" data-bind="value: title, enable: canEditOtherFields" class="wiki-editor-title customValidate validateArticleTitle" maxlength="<%= SocialConstants.TitleMaxLength %>" autofocus="autofocus" />
                    </div>
                    <!-- /ko -->
                    <!-- ko ifnot: primaryArticle -->
                    <div class="dnnFormItem">
                        <div class="dnnLabel"><label><span class="dnnFormRequired"><%= GetString("plPostType") %></span></label></div>
                        <select data-bind="options: availableTypes, optionsText: 'localizedText', optionsValue: 'articleTypeId', value: articleType, enable: canEditOtherFields"
                            class="article-type customValidate validateArticleType"></select>
                    </div>
                    <!-- /ko -->
                    <!-- ko ifnot: primaryArticle -->
                    <!-- ko ifnot: isMobileView -->
                    <div class="dnnFormItem wiki-editor-toc">
                        <div class="dnnLabel"><label><span><%= GetString("plToc") %></span></label></div>
                        <input type="checkbox" class="normalCheckBox" data-bind="checked: toc, enable: canEditOtherFields" />
                    </div>
                    <!-- /ko -->
                    <!-- ko if: isMobileView -->
                    <div class="dnnFormItem wiki-editor-toc">
                        <div class="dnnLabel">
                            <label><%= GetString("plToc") %></label>
                            <input type="checkbox" class="normalCheckBox" data-bind="checked: toc, enable: canEditOtherFields" />
                        </div>
                    </div>
                    <!-- /ko -->
                    <!-- /ko -->
                    <!-- ko ifnot: isMobileView -->
                    <div class="dnnFormItem" data-bind="style: { 'margin-top': primaryArticle() ? '15px' : '0px' }">
                        <div class="dnnLabel"><label><span class="dnnFormRequired"><%= GetString("plContent") %></span></label></div>
                        <span class="wiki-hint">
                            <%= LocalizeString("ContentHint") %>
                        </span>
                    </div>
                    <!-- /ko -->
                    <div class="dnnFormItem wiki-editor">
                        <textarea class="required" rows="7" cols="30" id="content"></textarea>
                    </div>
                    <% if (CanModerate)
                       { %>
                    <!-- ko ifnot: primaryArticle -->
                    <!-- ko ifnot: isMobileView -->
                    <div class="dnnFormItem">
                        <div class="dnnLabel"><label><span><%= GetString("plApproved") %></span></label></div>
                        <input type="checkbox" class="normalCheckBox" data-bind="checked: approved" />
                    </div>
                    <!-- /ko -->
                    <!-- ko if: isMobileView -->
                    <div class="dnnFormItem">
                        <div class="dnnLabel">
                            <label><%= GetString("plApproved") %></label>
                            <input type="checkbox" class="normalCheckBox" data-bind="checked: approved" />
                        </div>
                    </div>
                    <!-- /ko -->
                    <!-- /ko -->
                    <% } %>
                    <!-- ko ifnot: primaryArticle -->
                    <div class="dnnFormItem">
                        <div class="dnnLabel"><label><span class="dnnFormRequired"><%= GetString("plTags") %></span></label></div>
                        <input type="text" id="wiki-edit-tags" class="customValidate validateArticleTag" />
                    </div>
                    <!-- ko if: contentItemId() < 1 -->
                    <div class="dnnFormItem">
                        <!-- ko ifnot: $root.isMobileView -->
                        <div class="dnnLabel"><label for="subscribe"><%= GetString("Subscribe") %></label></div>
                        <input type="checkbox" data-bind="checked: subscribeToActivity" id="subscribe" class="normalCheckBox"/>
                        <!-- /ko -->
                        <!-- ko if: $root.isMobileView -->
                        <div class="dnnLabel">
				            <label for="subscribeMobileView"><%= GetString("Subscribe") %></label>
				            <input type="checkbox" data-bind="checked: subscribeToActivity" id="subscribeMobileView" class="normalCheckBox"/>
                        </div>
                        <!-- /ko -->
                    </div>
                    <!-- /ko -->
                    <!-- /ko -->	
                </div>
            </div>
            <!-- ko ifnot: isMobileView -->
            <!-- ko ifnot: primaryArticle -->
            <!-- ko if: canEditOtherFields -->
            <h2 class="dnnFormSectionHead"><a href="#"><%= LocalizeString("AdvancedHeader") %></a></h2>
            <div class="dnnClear">
                <div class="dnnForm">
                    <div class="dnnFormItem">
                            <div class="dnnLabel"><label><%= GetString("plSummary") %></label></div>
                            <span class="wiki-hint">&nbsp;</span>
                    </div>
                    <div class="dnnFormItem wiki-editor">
                        <textarea rows="7" cols="30" id="summary"></textarea>
                    </div>
                </div>
            </div>
            <!-- /ko -->
            <!-- /ko -->
            <!-- /ko -->
        </div>
        <div class="dnnClear dialog-footer">
            <ul class="dnnActions dnnRight">
                <li><a class="dnnSecondaryAction" data-bind="click: cancel"><%= LocalizeString("Cancel") %></a></li>        
                    <% if (CanModerate)
                    { %>
                <!-- ko if: primaryArticle -->
                <!-- ko if: articleId() > 0 -->
                <li><a class="dnnSecondaryAction" data-bind="click: remove">
                    <%= LocalizeString("Delete") %>
                </a></li>
                <!-- /ko -->
                <!-- /ko -->
                <% } %>               
                <li><a class="dnnPrimaryAction" data-bind="click: publish"><%= LocalizeString("Publish") %></a></li>
            </ul>
        </div>
    </asp:Panel>
</asp:Panel>

<script type="text/javascript">
    function wiki_contentEditorInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (typeof settings.moduleScope === 'undefined') {
            return;
        }
        try {
            window.dnn.social.applyBindings(new window.dnn.wiki.ContentEditor(settings), settings.moduleScope);
        } catch (ex) {
            window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>
