<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="EditEntry.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.EditEntry" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="FilePickerUploader" Src="~/controls/filepickeruploader.ascx" %>

<div class="dnnBlogEditEntry blog-list-container dnnClear" id="dnnBlogEditEntry">
    <div class="blog-entry-form-container dnnForm">
        <h2 id="dnnSitePanel-Common" class="dnnFormSectionHead" data-bind="visible: !isMobileView()"><a href="" class="dnnSectionExpanded"><%= LocalizeString("CommonSection") %></a></h2>

        <div class="basic-form">
            <div class="dnnFormItem">
                <dnn:Label ID="lblTitle" runat="server" controlname="txtTitle" suffix=":" CssClass="dnnFormRequired" />
                <asp:TextBox ID="txtTitle" runat="server" CssClass="required" autofocus="autofocus" />
            </div>

            <div class="dnnFormItem editorContainer">
                <asp:TextBox runat="server" ID="txtBlogEntryText" TextMode="MultiLine" CssClass="required"></asp:TextBox>
            </div>
            
            <asp:Panel ID="pnlApproved" runat="server" CssClass="dnnFormItem dnnFormItemCheckbox">
                <dnn:Label ID="lblApproved" runat="server" controlname="chkApproved" suffix=":" />
                <asp:CheckBox ID="chkApproved" runat="server" CssClass="normalCheckBox" />
            </asp:Panel>

            <div class="dnnFormItem dnnClear">
                <dnn:Label ID="lblTags" runat="server" controlname="txtTags" suffix=":" CssClass="dnnFormRequired" />
                <asp:TextBox ID="txtTags" runat="server" CssClass="required" />
            </div>

            <div class="dnnMultipleControls blog-author-select dnnClear">
                <p><asp:Literal runat="server" ID="literalAuthor"></asp:Literal></p>
                <asp:DropDownList runat="server" DataTextField="Title" DataValueField="BlogId"  ID="ddlAuthoringBlogs" />
            </div>

        </div>

        <h2 id="dnnSitePanel-Advanced" class="dnnFormSectionHead" data-bind="visible: !isMobileView()"><a href="javascript:void(0)" class="dnnSectionExpanded"><%= LocalizeString("AdvSection") %></a></h2>

        <div data-bind="visible: !isMobileView()">
            <div class="dnnFormItem">
                <dnn:Label ID="lblSummary" runat="server" controlname="txtDescriptionText" suffix=":" />
                <div class="dnnClear"></div>
            </div>
            <div class="editorContainer">
                <asp:TextBox runat="server" ID="txtDescriptionText" TextMode="MultiLine" />
            </div>

            <div class="dnnFormItem">
                <dnn:Label ID="lblSummaryImage" runat="server" suffix=":" />
                <dnn:FilePickerUploader ID="ctlSummaryImage" runat="server" />
                <div class="dnnClear"></div>
            </div>

            <div class="dnnFormItem dnnMultipleControlsFormItem">
                <dnn:Label ID="lblPublishDate" runat="server" ControlName="dpEntryDate" Suffix=":" CssClass="dnnFormRequired" />
                <div class="dnnMultipleControls">
                    <div>
                         <div class="timeZone">
                            <label>Time Zone: </label><asp:Label runat="server" ID="lblTimeZoneName"></asp:Label>
                        </div> 
                        <asp:TextBox runat="server" ID="txtDate" CssClass="entry-publishdate"></asp:TextBox>
                        <div class="timeInput">
                            <span class="timeIndicator"></span>
                            <asp:DropDownList runat="server" ID="lstHours">
                            </asp:DropDownList>
                            <span>:</span>
                            <asp:DropDownList runat="server" ID="lstMinutes">
                                <asp:ListItem Selected="True">00</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>30</asp:ListItem>
                                <asp:ListItem>45</asp:ListItem>
                            </asp:DropDownList>
                            <asp:DropDownList runat="server" ID="lstTimeAMPM">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div>
                        <span><%= Localization.GetString("PublishTimeZoneNote", LocalResourceFile) %></span>
                        <em>
                            <asp:Literal runat="server" ID="litTimezone" /></em>
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlComments" runat="server" CssClass="dnnFormItem dnnFormItemCheckbox dnnMultipleControlsFormItem">
                <dnn:Label ID="lblAllowComments" runat="server" controlname="chkAllowComments" suffix=":" />
                <div class="dnnMultipleControls">
                    <asp:CheckBox ID="chkAllowComments" runat="server" CssClass="normalCheckBox" />
                    <p class="dnnRight">
                        <%= Localization.GetString("AllowCommentsNote", LocalResourceFile) %>
                    </p>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlPinned" runat="server" CssClass="dnnFormItem dnnFormItemCheckbox dnnMultipleControlsFormItem">
                <dnn:Label ID="lblPinned" ResourceKey="lblPinned" runat="server" controlname="chkPinned" suffix=":" />
                <div class="dnnMultipleControls">
                    <asp:CheckBox ID="chkPinned" runat="server" CssClass="normalCheckBox" />
                    <p class="dnnRight">
                        <%= Localization.GetString("PinnedNote", LocalResourceFile) %>
                    </p>
                </div>
            </asp:Panel>
        </div>

        <div class="dnnClear dialog-footer">
            <ul class="dnnActions dnnRight">
                <li><asp:LinkButton ID="cmdRelated" ResourceKey="cmdRelated" runat="server" CssClass="dnnSecondaryAction"></asp:LinkButton></li>
                <li><asp:HyperLink ID="hlCancel" ResourceKey="cmdCancel" runat="server" CssClass="dnnSecondaryAction" /></li>
                <li><asp:LinkButton ID="cmdDelete" ResourceKey="cmdDelete" runat="server" CssClass="dnnSecondaryAction" CausesValidation="False" Visible="False" /></li>
                <li> <asp:LinkButton ID="cmdPublish" runat="server" CssClass="dnnPrimaryAction" resourcekey="cmdPublish" /></li>
            </ul>
        </div>
        <asp:HiddenField runat="server" ID="fldRevisionSequence" EnableViewState="False" Value="0"/>
    </div>
</div>
<script type="text/javascript">
    (function ($) {
        $(function () {
             
            var validator = new window.dnn.social.Validator($, window.ko);

            var viewModel = {

                moduleScope: document.getElementById('dnnBlogEditEntry'),

                validate: validator.validate,

                switchingView: function () {
                    $(".ui-dialog-content").dialog("close");
                },

                switchedView: function () {
                    if (this.isMobileView()) {
                        $('#dnnBlogEditEntry').addClass('dnnFormPopup').addClass('dnnFormPopupMobileView');
                    } else {
                        $('#dnnBlogEditEntry').removeClass('dnnFormPopup').removeClass('dnnFormPopupMobileView');
                    }

                    this.bindControls();
                },

                bindControls: function () {
                    if (!this.isMobileView()) {
                        $('#dnnBlogEditEntry').dnnPanels({ regionToToggleSelector: 'div' });
                    }

                    $('#<%= cmdDelete.ClientID %>').dnnConfirm({
                        text: '<%= LocalizeString("DeleteItem") %>',
                        yesText: '<%= Localization.GetString("Yes.Text", Localization.SharedResourceFile) %>',
                        noText: '<%= Localization.GetString("No.Text", Localization.SharedResourceFile) %>',
                        title: '<%= Localization.GetString("Confirm.Text", Localization.SharedResourceFile) %>'
                    });

                    $('#<%= txtTags.ClientID %>').dnnTagsInput({
                        width: '57%',
                        defaultText: '<%= LocalizeString("AddTags") %>',
                        minInputWidth: '200px'
                    });

                    if (typeof $.datepicker !== 'undefined') {
                        $.datepicker._defaults.firstDay = 1;
                        $.datepicker._defaults.dayNames = [
                            '<%= RegionalDateTimeSettings["sun"] %>',
                            '<%= RegionalDateTimeSettings["mon"] %>',
                            '<%= RegionalDateTimeSettings["tue"] %>',
                            '<%= RegionalDateTimeSettings["wed"] %>',
                            '<%= RegionalDateTimeSettings["thu"] %>',
                            '<%= RegionalDateTimeSettings["fri"] %>',
                            '<%= RegionalDateTimeSettings["sat"] %>'
                        ];
                        $.datepicker._defaults.monthNames = [
                            '<%= RegionalDateTimeSettings["jan"] %>',
                            '<%= RegionalDateTimeSettings["feb"] %>',
                            '<%= RegionalDateTimeSettings["mar"] %>',
                            '<%= RegionalDateTimeSettings["apr"] %>',
                            '<%= RegionalDateTimeSettings["may"] %>',
                            '<%= RegionalDateTimeSettings["jun"] %>',
                            '<%= RegionalDateTimeSettings["jul"] %>',
                            '<%= RegionalDateTimeSettings["aug"] %>',
                            '<%= RegionalDateTimeSettings["sep"] %>',
                            '<%= RegionalDateTimeSettings["oct"] %>',
                            '<%= RegionalDateTimeSettings["nov"] %>',
                            '<%= RegionalDateTimeSettings["dec"] %>'
                        ];

                        $('#<%= txtDate.ClientID %>').datepicker({
                            dateFormat: '<%= RegionalDateTimeSettings["dateFormat"] %>',
                            showOn: "button",
                            buttonImage: '<%= ResolveClientUrl("~/desktopmodules/dnncorp/sociallibrary/images/datepicker.png") %>',
                            buttonImageOnly: true,
                            showOtherMonths: true,
                            selectOtherMonths: true
                        });
                    }

                    if (this.contentEditor) {
                        try {
                            $('#<%= txtBlogEntryText.ClientID %>').dnnRedactor('core.destroy');
                        } catch (e) {
                        }
                    }

                    if (this.summaryEditor) {
                        try {
                            $('#<%= txtDescriptionText.ClientID %>').dnnRedactor('core.destroy');
                        } catch (e) {
                        }
                    }

                    var editorSettings = {
                        toolbar: '<%= EditorConfig.Toolbar %>',
                        allowIframe: <%= EditorConfig.AllowIframe ? "true": "false" %>,
                        allowScript: <%= EditorConfig.AllowScript ? "true": "false" %>,
                        allowEmbed: <%= EditorConfig.AllowEmbed ? "true": "false" %>
                        };

                    var module = $('#<%= txtBlogEntryText.ClientID %>').addClass('validateErrorAfterParent');
                    dnn.social.initRedactor(module, null, 'rich', this.isMobileView(), '<%= ResolveClientUrl("~/api/dnncorp/blogs/social/") %>', editorSettings,
                        function(redactor) {
                            this.contentEditor = redactor;
                            dnn.social.initUserMentions(module, <%=ModuleId%> , 'Blogs', false, redactor);
                        });
                    
                    var summaryEditorModule = $('#<%= txtDescriptionText.ClientID %>');
                    <% if (BlogSettings.AllowSummaryHtml)
                       { %>
                    dnn.social.initRedactor(summaryEditorModule, null, 'rich', this.isMobileView(), '<%= ResolveClientUrl("~/api/dnncorp/blogs/social/") %>', editorSettings,
                        function(redactor) {
                            this.summaryEditor = redactor;
                            dnn.social.initUserMentions(summaryEditorModule, <%=ModuleId%> , 'Blogs', false, redactor);
                        });
                    <% }
                       else
                       { %>
                    dnn.social.initRedactor(summaryEditorModule, 
                        {
                            shortcuts: [],
                            toolbar: false,
                            paragraphy: false,
                            convertDivs: false,
                            linebreaks: true,
                            tabFocus: false
                        },
                        'rich', this.isMobileView(), '<%= ResolveClientUrl("~/api/blogs/social/") %>', editorSettings,
                        function(redactor) {
                            this.summaryEditor = redactor;
                            dnn.social.initUserMentions(summaryEditorModule, <%=ModuleId%> , 'Blogs', false, redactor);
                        });
                    <% } %>

                    $('#<%= ddlAuthoringBlogs.ClientID %>').unbind('change').bind('change', function() {
                        var val = $(this).val();
                        var sf = $.ServicesFramework(<%= ModuleId %>);
                        $.ajax({
                            type: "GET",
                            url: sf.getServiceRoot('DNNCorp/Blogs') + "BlogEdit/" + "GetBlogInfo",
                            beforeSend: sf.setModuleHeaders,
                            data: { blogId: val },
                            async: true,
                            cache: false
                        }).done(function (response) {
                            $('.blog-author-select > p').html(response.publishingAuthor);
                            if (response.allowComments) {
                                $('#<%= pnlComments.ClientID %>').show();
                                $('#<%= chkAllowComments.ClientID %>')[0].checked = true;
                            } else {
                                $('#<%= pnlComments.ClientID %>').hide();
                                $('#<%= chkAllowComments.ClientID %>')[0].checked = false;
                            }
                            
                        });
                    });
                },

                binded: function () {
                    $(".blogListModule").hide();
                    $("#blogArchive").hide();
                    $(".relatedcontent-detail-container").hide();
                    $(".social-share-container").hide();
                    var self = this;

                    $('#<%= cmdPublish.ClientID %>').click(function () {
                        if (!self.validate($('.blog-entry-form-container.dnnForm .basic-form'))) {
                            return false;
                        }

                        $(this).addClass('disabled');

                        var html = $('#<%= txtBlogEntryText.ClientID %>').dnnRedactor('code.getCleanHtml');
                        $('#<%= txtBlogEntryText.ClientID %>').val(html);

                        var summary = $('#<%= txtDescriptionText.ClientID %>').dnnRedactor('code.getCleanHtml');
                        if (!summary || typeof summary !== 'string') {
                            summary = '';
                        }

                        $('#<%= txtDescriptionText.ClientID %>').val(summary);
                        return true;
                    });
                    
                    self.switchedView();}
            };

            window.dnn.social.MobileView.init($, window.ko, viewModel, viewModel.switchingView, viewModel.switchedView);
            window.dnn.social.applyBindings(viewModel, viewModel.moduleScope);
        });
    }(jQuery));

</script>
