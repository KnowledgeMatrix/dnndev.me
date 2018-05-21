<%@ Control Language="C#" AutoEventWireup="true" Inherits="DotNetNuke.Professional.Wiki.Settings" CodeBehind="Settings.ascx.cs" %>
<%@ Register tagPrefix="dnn" tagName="label" src="~/Controls/LabelControl.ascx" %>
<%@ Register tagPrefix="wiki" tagName="ColumnTable" src="Controls/ColumnTable.ascx" %>
<%@ Register TagPrefix="wiki" tagName="PostTypeSettings" src="Controls/PostTypeSettings.ascx" %>

<asp:Panel runat="server" ID="ScopeWrapper">
    <h2 id="dnnSitePanel-secMisc" class="dnnFormSectionHead"><a href="" class="dnnSectionExpanded"><%= LocalizeString("secMisc") %></a></h2>
    <fieldset>
        <div class="dnnFormItem">
            <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode" />
            <asp:DropDownList runat="server" ID="ddlMode">
                <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
                <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="dnnFormItem" style="display: none;">
            <dnn:label runat="server" ID="plLayout" ControlName="ctlColumns"/>
            <div class="wiki-column-table-hint">
                <em><%= LocalizeString("ColumnTableHint") %></em>
                <br/>
                <wiki:ColumnTable runat="server" ID="ctlColumns" />
            </div>
        </div>
        <div class="dnnFormItem">
            <dnn:label controlname="chkEnableComments" resourcekey="chkEnableComments" Suffix=":" runat="server" />
            <asp:CheckBox ID="chkEnableComments" runat="server" />
        </div>
    </fieldset>
    <h2 id="dnnSitePanel-PostTypes" class="dnnFormSectionHead"><a href="" class=""><%= LocalizeString("PostTypes") %></a></h2>
    <fieldset>
        <div class="dnnFormItem" style="display: none;">
            <dnn:label id="plRootCategory" runat="server" controlname="drpRootCategory" suffix=":" />
            <asp:DropDownList ID="drpRootCategory" runat="server" Width="150" />
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" ID="plPostType" ControlName="ctlPostTypes" />
            <wiki:PostTypeSettings runat="server" ID="ctlPostTypes" />
        </div>
     </fieldset>
</asp:Panel>