<%@ Control Language="C#" AutoEventWireup="false" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Professional.Blogs.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnForm dnnBlogOptions dnnClear" id="dnnBlogOptions">
    <div class="bobsContent dnnClear">
        <h2 id="dnnSitePanel-AdvancedSettings" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%= LocalizeString("secMisc") %></a></h2>
        <fieldset>
            <div class="dnnFormItem">
                <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode" />
                <asp:DropDownList runat="server" ID="ddlMode">
                    <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
                    <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblAllowWLW" runat="server" controlname="chkAllowWLW" suffix=":" />
                <asp:CheckBox ID="chkAllowWLW" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblUseWLWExcerpt" runat="server" controlname="chkUseWLWExcerpt" suffix=":" />
                <asp:CheckBox ID="chkUseWLWExcerpt" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblCommentMode" runat="server" controlname="lblShowGravatars" suffix=":" />
                <asp:DropDownList ID="ddlCommentMode" runat="server">
                    <asp:ListItem Value="-1" resourcekey="None" />
                    <asp:ListItem Value="0" resourcekey="Default" />
                    <asp:ListItem Value="1" resourcekey="InlineLogin" />
                </asp:DropDownList>
            </div>            
        </fieldset>	

        <h2 id="dnnSitePanel-GeneralSettings" class="dnnFormSectionHead"><a href="" class=""><%= LocalizeString("EntrySummary") %></a></h2>
        <fieldset>
            <div class="dnnFormItem">
                <dnn:label id="lblMandatory" runat="server" controlname="chkForceDescription" suffix=":" />
                <asp:CheckBox ID="chkForceDescription" runat="server" />
            </div>
            <div class="dnnFormItem" id="divSummary">
                <dnn:label id="lblSummary" runat="server" controlname="txtSummaryLimit" suffix=":" />
                <asp:TextBox ID="txtSummaryLimit" runat="server" />
                <asp:RequiredFieldValidator runat="server" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ID="requiredValidator1" ControlToValidate="txtSummaryLimit"><%= LocalizeString("FieldIsRequired") %></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" Text="This filed must be number" ValidationExpression="\d+" ID="regexValidator1" ControlToValidate="txtSummaryLimit" ></asp:RegularExpressionValidator>
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblEnforceSummaryTruncation" runat="server" suffix=":" controlname="lblEnforceSummaryTruncation" />
                <asp:CheckBox ID="chkEnforceSummaryTruncation" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblShowSummary" runat="server" controlname="chkShowSummary" suffix=":" />
                <asp:CheckBox ID="chkShowSummary" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblAllowSummaryHtml" runat="server" controlname="chkAllowSummaryHtml" suffix=":" />
                <asp:CheckBox ID="chkAllowSummaryHtml" runat="server" />
            </div>		
        </fieldset>
        
        <h2 id="dnnSitePanel-Templates" class="dnnFormSectionHead"><a href="" class=""><%= LocalizeString("Templates") %></a></h2>
        <fieldset>
            <div class="dnnFormItem" style="padding: 20px; background: #eee; margin: 0 0 10px 10px; width: 80%">
                <%= LocalizeString("TemplateTokenHelp") %>
            </div>
            <div class="dnnFormItem">
                <dnn:label id="lblListItemTemplate" runat="server" controlname="txtListItemTemplate" suffix=":" />
                <asp:TextBox ID="txtListItemTemplate" runat="server" TextMode="MultiLine" Height="200" />
            </div>
            <div class="dnnFormItem" id="div1">
                <dnn:label id="lblDetailItemTemplate" runat="server" controlname="txtDetailItemTemplate" suffix=":" />
                <asp:TextBox ID="txtDetailItemTemplate" runat="server"  TextMode="MultiLine" Height="200" />
            </div>
        </fieldset>
        
    </div>
</div>
<script language="javascript" type="text/javascript">
	/*globals jQuery, window, Sys */
    (function($, Sys) {

        function setupDnnBlogSettings() {
            handleSummaryDisplay();

            $('#dnnBlogOptions').dnnPanels();

            $('#<%= chkForceDescription.ClientID %>').click(function() {
                handleSummaryDisplay();
                return true;
            });

            function handleSummaryDisplay() {
                if ($('#<%= chkForceDescription.ClientID %>').prop('checked')) {
                    $("#divSummary").hide('highlight', '', 200, '');
                    $("#divSearchSummary").hide('highlight', '', 200, '');
                } else {
                    $("#divSummary").show('highlight', '', 200, '');
                    $("#divSearchSummary").show('highlight', '', 200, '');
                }
            }
        }

        $(document).ready(function() {
            setupDnnBlogSettings();
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
                setupDnnBlogSettings();
            });
        });

    }(jQuery, window.Sys));
</script>