<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.GroupDirectory.Settings" Codebehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnFormItem">
    <dnn:label controlname="drpViewMode" resourcekey="ViewMode" Text="View Mode" Suffix=":" runat="server" />   
    <asp:RadioButtonList ID="drpViewMode" runat="server">
        <asp:ListItem Value="Thumbnail" resourcekey="Thumbnail" Selected="True">Thumbnail</asp:ListItem>
        <asp:ListItem Value="List" resourcekey="List">List</asp:ListItem>
    </asp:RadioButtonList>
</div>

<div class="dnnFormItem">
    <dnn:label controlname="lstRoleGroup" resourcekey="DefaultRoleGroup" Text="Default Role Group" Suffix=":" runat="server" />
    <asp:DropDownList id="selectRoleGroup" runat="server"></asp:DropDownList>
</div>

<div class="dnnFormItem" id="trListPageSize">
    <dnn:label controlname="txtPageSize" resourcekey="GroupListPageSize" Text="Group List Page Size" Suffix=":" runat="server" />
    <asp:TextBox ID="txtPageSize" runat="server" Text="6" />
    <asp:RangeValidator runat="server" ID="rangePageSize" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" 
        ControlToValidate="txtPageSize" resourcekey="PageSizeValidation" MinimumValue="1" MaximumValue="9999" Type="Integer"></asp:RangeValidator>
</div>

<div class="dnnFormItem">
    <dnn:label controlname="lstSortField" resourcekey="GroupListSortField" Text="List Sort By" Suffix=":" runat="server" />
    <asp:DropDownList ID="lstSortField" runat="server">        
        <asp:ListItem Selected="True" Value="groupName" resourcekey="GroupName"></asp:ListItem>
        <asp:ListItem Value="memberCount" resourcekey="MostMembers"></asp:ListItem>
        <asp:ListItem Value="lastActivityDate" resourcekey="RecentActivity">Recent Activity</asp:ListItem>
        <asp:ListItem Value="createdOnDate" resourcekey="DateCreated"></asp:ListItem>       
    </asp:DropDownList>
</div>

<div class="dnnFormItem">
    <dnn:label controlname="chkGroupModeration" resourcekey="GroupModeration" Text="Groups Require Approval" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkGroupModeration" runat="server" />
</div>
