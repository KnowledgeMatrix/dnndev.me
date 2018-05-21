<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BlogEditor.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.Controls.BlogEditor" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Import Namespace="SocialConstants=DotNetNuke.SocialLibrary.Components.Common.Constants" %>

<div data-bind="stopBindings: true">
    <asp:Panel ID="ScopeWrapper" runat="server">
        <div id="postFields" class="dnnForm blog-settings-container dnnClear" data-bind="with: primaryView.selectedBlog">
            <div class="dnnFormItem">
                <div class="dnnLabel"><label for="contentTitle"><span class="dnnFormRequired"><%= GetString("BlogTitle") %></span></label></div>
                <input type="text" data-bind="value: title" maxlength="<%= SocialConstants.TitleMaxLength %>" id="contentTitle" class="required blog-edit-title" />
            </div>
        
            <div class="dnnFormItem" style="margin-bottom: 12px">
                <!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel" style="margin-top: 20px;"><label for="ddlAuthorized"><span><%= GetString("PublicBlog") %></span></label></div>
                <div class="dnnMultipleControls">
                    <select data-bind="options: $root.visibilityOptions, optionsValue: 'value', optionsText: 'text', value: authorized" id="ddlAuthorized"></select>
                    <div>
                          <%= GetString("DescriptionBlogVisibility") %>
                    </div>
                </div>
                <!-- /ko -->
                
                <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label><span><%= GetString("PublicBlog") %></span></label>
                </div>
				<select data-bind="options: $root.visibilityOptions, optionsValue: 'value', optionsText: 'text', value: authorized"></select>
                <!-- /ko -->
            </div>
            
            <div class="dnnFormItem">
                <!-- ko ifnot: $root.isMobileView -->
                <div class="dnnLabel" style="margin-top: 20px;"><label for="ddlAuthorMode"><span><%= GetString("AuthorMode") %></span></label></div>
                <div class="dnnMultipleControls">
                    <select data-bind="options: $root.authorMode, optionsValue: 'value', optionsText: 'mode', value: authorMode" id="ddlAuthorMode"></select>
                    <div>
                         <%= GetString("DescriptionBlogAuthorMode") %>
                    </div>
                </div>
                <!-- /ko -->
                
                <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label><span><%= GetString("AuthorMode") %></span></label>
                </div>
                <select data-bind="options: $root.authorMode, optionsValue: 'value', optionsText: 'mode', value: authorMode"></select>
                <!-- /ko -->
            </div>
            
            <div class="dnnFormItem">
                <!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel" style="margin-top: 15px;"><label for="chkSyndicate"><span><%= GetString("Syndicate") %></span></label></div>
                <div class="dnnMultipleControls">
                    <input type="checkbox" data-bind="checked: syndicated" id="chkSyndicate" class="normalCheckBox" style="display:inline-block; margin-top: 6px" />
                    <p class="dnnRight">
                        <%= GetString("DescriptionBlogSyndicate") %>
                    </p>
                </div>
                <!-- /ko -->
                
                <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label for="chkSyndicateMobileView"><span><%= GetString("Syndicate") %></span></label>
				    <input type="checkbox" data-bind="checked: syndicated" id="chkSyndicateMobileView" class="normalCheckBox"/>
                </div>
                <!-- /ko -->
            </div>
             
			<div class="dnnFormItem" data-bind="visible: $root.allowComments">
			    <!-- ko ifnot: $root.isMobileView -->
				<div class="dnnLabel"><label for="chkAllowComments"><span><%= GetString("AllowComments") %></span></label></div>
				<div data-bind="css: { dnnMultipleControls: blogId() > 0 }">
                    <input type="checkbox" data-bind="checked: allowComments" id="chkAllowComments" class="normalCheckBox" style="display:inline-block; margin-top: 6px" />
                    <p class="dnnRight" data-bind="visible: blogId() > 0, html: blogPostCount() == 1 ? '<%= GetString("BlogNumberOfEntriesOne") %>    '.format(blogPostCount()) : '<%= GetString("BlogNumberOfEntriesMany") %>    '.format(blogPostCount()) ">
                    </p>
                </div>
                <!-- /ko -->
                
                <!-- ko if: $root.isMobileView -->
                <div class="dnnLabel">
				    <label for="chkAllowCommentsMobileView"><span><%= GetString("AllowComments") %></span></label>
				    <input type="checkbox" data-bind="checked: allowComments" id="chkAllowCommentsMobileView" class="normalCheckBox"/>
                </div>
                <!-- /ko -->
			</div>
        </div>
        <!-- ko ifnot: $root.isMobileView -->
        <div class="blog-meta-url" data-bind="visible: $root.allowWLW">
            <strong><%= GetString("MetaWebBlogUrl") %>:</strong><br/>
			<span id="lblBlogPostUrl" data-bind="text: $root.wlwPostUrl"></span>
	    </div>
        <!-- /ko -->
        
        <div class="dnnClear dialog-footer">
            <span data-bind="visible: editMode()">
                <ul class="dnnActions dnnRight">
                    <li><a href="javascript:void(0)" id="btnDelete" class="dnnSecondaryAction"><%= GetString("Delete") %></a></li>
                    <li><a href="javascript:void(0)" data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Cancel") %> </a></li>
                    <li><a href="javascript:void(0)" data-bind="click: $root.save" class="dnnPrimaryAction"><%= GetString("Update") %></a></li>
                </ul>
            </span>
            <span data-bind="visible: !editMode()">
                <ul class="dnnActions dnnRight">
                    <li><a id="saveBlog" href="javascript:void(0)" data-bind="click: $root.cancel" class="dnnSecondaryAction"><%= GetString("Cancel") %> </a></li>
                    <li><a href="javascript:void(0)" data-bind="click: $root.save" class="dnnPrimaryAction"><%= GetString("CreateBlog") %></a></li>
                </ul>
            </span>           
        </div>

     </asp:Panel>

</div>

<script type="text/javascript">
    function editInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        var validator = new window.dnn.social.Validator($, window.ko, settings);
        settings.validate = validator.validate;
        var primaryView = window.ko.contextFor($(settings.parentId)[0]).$root;
        settings.primaryView = primaryView;
        var viewModel = new window.dnn.blogs.BlogEditView($, window.ko, settings);

        try {
            window.dnn.social.applyBindings(viewModel, settings.moduleScope);
            $("#btnDelete").dnnConfirm({
                text: '<%= GetString("DeleteBlog_Desc.Text") %>',
                 yesText: '<%= Localization.GetString("Yes.Text", Localization.GlobalResourceFile) %>',
                 noText: '<%= Localization.GetString("No.Text", Localization.GlobalResourceFile) %>',
                 title: '<%= GetString("DeleteBlog.Text") %>',
                 isButton: false,
                 callbackTrue: function () {
                     window.ko.contextFor(settings.moduleScope).$root.remove(this);
                 }
             });
        } catch(ex) {
           window.dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }
</script>