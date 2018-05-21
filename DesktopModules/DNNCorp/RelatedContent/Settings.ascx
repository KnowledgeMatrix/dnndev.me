<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Professional.RelatedContent.RelationshipsSettings" %>
<%@ Import Namespace="DotNetNuke.Services.Localization" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div id="dnnRelationshipSettings">
    <div class="dnnFormExpandContent">
        <a href=""><%=Localization.GetString("ExpandAll", Localization.SharedResourceFile)%></a>
    </div>
    <h2 id="dnnPanel-General" class="dnnFormSectionHead">
        <a href="dnnSectionExpanded"><%= LocalizeString("InitialView")%></a>
    </h2>
    <fieldset>
        <div class="dnnFormItem">
            <dnn:label controlname="drpNumberItems" id="NumberOfItems" runat="server" suffix=":" />
            <asp:dropdownlist runat="server" id="drpNumberItems">
                <asp:ListItem Text="1" Value="1" />
                <asp:ListItem Text="2" Value="2" />
                <asp:ListItem Text="3" Value="3" />
                <asp:ListItem Text="5" Value="5" />
                <asp:ListItem Text="10" Value="10" />
                <asp:ListItem Text="15" Value="15" />       
                <asp:ListItem Text="20" Value="20" />
                <asp:ListItem Text="25" Value="25" />   
                <asp:ListItem Text="30" Value="30" />
            </asp:dropdownlist>
        </div>
        <div class="dnnFormItem" style="display:none;">
            <dnn:label controlname="chkShowTags" id="lblShowTags" runat="server" suffix=":" />
            <asp:CheckBox ID="chkShowTags" runat="server" />
        </div>
    </fieldset>
    <h2 id="dnnPanel-Sorting" class="dnnFormSectionHead"><a href=""><%= LocalizeString("Sorting") %></a></h2>
    <fieldset>
        <div class="dnnFormItem">
            <dnn:label controlname="drpSort" id="SortMethod" runat="server" suffix=":" />
            <asp:dropdownlist runat="server" id="drpSort">
                <asp:ListItem Text="Date" Value="date" resourcekey="Date" />
                <asp:ListItem Text="Title" Value="title" resourcekey="Title" />
            </asp:dropdownlist>
        </div>
        <div class="dnnFormItem">
            <dnn:label controlname="drpOrder" id="SortOrder" runat="server" suffix=":" />
            <asp:DropDownList runat="server" ID="drpOrder">
                <asp:ListItem Text="Ascending" Value="ascending" resourcekey="Ascending" />
                <asp:ListItem Text="Descending" Value="descending" resourcekey="Descending" />
            </asp:DropDownList>
       </div>
    </fieldset>
    <h2 id="dnnPanel-Filtering" class="dnnFormSectionHead"><a href=""><%= LocalizeString("Filtering") %></a></h2>
    <fieldset>
        <div class="dnnFormItem">
            <dnn:Label controlname="txtTag" id="FilterOnTag" runat="server" suffix=":" />
            <asp:TextBox runat="server" ID="txtTag"></asp:TextBox>
        </div>
        <div class="dnnFormItem">
            <dnn:Label controlname="drpContentType" id="FilterOnContentType" runat="server" suffix=":" />
            <asp:DropDownList runat="server" ID="drpContentType" />
        </div>
    </fieldset>
    <asp:HiddenField runat="server" ID="tags" Value="" />
    <h2 id="dnnPanel-Templates" class="dnnFormSectionHead"><a href=""><%= LocalizeString("Templates") %></a></h2>
    <fieldset>
        <div class="dnnClear">
            <div class="dnnFormMessage dnnFormInfo"><%= LocalizeString("TemplateHelp") %></div>
        </div>
        <div class="dnnFormItem">
            <dnn:Label controlname="txtHeader" id="TemplateHeader" runat="server" suffix=":" />
            <asp:TextBox runat="server" ID="txtHeader" TextMode="MultiLine" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label controlname="txtItem" id="TemplateItem" runat="server" suffix=":" />
            <asp:TextBox runat="server" ID="txtItem" TextMode="MultiLine" />
        </div>
        <div class="dnnFormItem">
            <dnn:Label controlname="txtFooter" id="TemplateFooter" runat="server" suffix=":" />
            <asp:TextBox runat="server" ID="txtFooter" TextMode="MultiLine" />
        </div>
    </fieldset>
</div>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function ($, Sys) {

    function setupRCSettings() {
        $('#dnnRelationshipSettings .dnnFormExpandContent a').dnnExpandAll({ expandText: '<%=Localization.GetSafeJSString("ExpandAll", Localization.SharedResourceFile)%>', collapseText: '<%=Localization.GetSafeJSString("CollapseAll", Localization.SharedResourceFile)%>', targetArea: '#dnnRelationshipSettings' });
    }

    $(document).ready(function () {
        setupRCSettings();
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setupRCSettings();
        });
    });

} (jQuery, window.Sys));
</script>