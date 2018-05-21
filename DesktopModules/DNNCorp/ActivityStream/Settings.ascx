<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.ActivityStream.Settings" CodeBehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<style>
    .dnnFormItem td label {
        white-space: nowrap;
        text-align: left;
    }
</style>
<div class="dnnFormItem">
    <dnn:label controlname="chkEnableEditor" resourcekey="EnableEditor" Text="Enable Editor" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkEnableEditor" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="chkAllowFiles" resourcekey="AllowFiles" Text="Allow Files" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkAllowFiles" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="chkAllowPhotos" resourcekey="AllowPhotos" Text="Allow Photos" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkAllowPhotos" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="ddlMaxFiles" resourcekey="MaxFiles" Text="Max Files Per Journal" Suffix=":" runat="server" />
    <asp:DropDownList runat="server" ID="ddlMaxFiles">
        <asp:ListItem Value="1">1</asp:ListItem>
        <asp:ListItem Value="2">2</asp:ListItem>
        <asp:ListItem Value="3">3</asp:ListItem>
        <asp:ListItem Value="4">4</asp:ListItem>
        <asp:ListItem Value="5">5</asp:ListItem>
        <asp:ListItem Value="6">6</asp:ListItem>
        <asp:ListItem Value="7">7</asp:ListItem>
        <asp:ListItem Value="8">8</asp:ListItem>
        <asp:ListItem Value="9">9</asp:ListItem>
        <asp:ListItem Value="10">10</asp:ListItem>
    </asp:DropDownList>
</div>
<div class="dnnFormItem">
    <dnn:label controlname="chkEnableViewFilters" resourcekey="EnableViewFilters" Text="Enable View Filters" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkEnableViewFilters" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="chkEnableGrouping" id="lblEnableGrouping" Suffix=":" runat="server" />
    <asp:CheckBox ID="chkEnableGrouping" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:label controlname="drpDefaultPageSize" resourcekey="DefaultPageSize" Suffix=":" runat="server" />
    <asp:DropDownList ID="drpDefaultPageSize" runat="server">
        <asp:ListItem Value="5">5</asp:ListItem>
        <asp:ListItem Value="10">10</asp:ListItem>
        <asp:ListItem Value="20">20</asp:ListItem>
        <asp:ListItem Value="30">30</asp:ListItem>
        <asp:ListItem Value="40">40</asp:ListItem>
        <asp:ListItem Value="50">50</asp:ListItem>
        <asp:ListItem Value="75">75</asp:ListItem>
        <asp:ListItem Value="100">100</asp:ListItem>
    </asp:DropDownList>
</div>
<div class="dnnFormItem">
    <dnn:label controlname="drpMaxMessageLength" resourcekey="MaxMessageLength" Suffix=":" runat="server" />
    <asp:DropDownList ID="drpMaxMessageLength" runat="server">
        <asp:ListItem Value="140">140</asp:ListItem>
        <asp:ListItem Value="250">250</asp:ListItem>
        <asp:ListItem Value="500">500</asp:ListItem>
        <asp:ListItem Value="1000">1000</asp:ListItem>
        <asp:ListItem Value="2000">2000</asp:ListItem>
    </asp:DropDownList>

</div>
<div class="dnnFormItem">
    <dnn:label resourcekey="JournalFilters" Suffix=":" runat="server" />
    <asp:CheckBoxList ID="chkJournalFilters" runat="server" />
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#<%=chkEnableEditor.ClientID %>').click(function () {
            if (this.checked) {
                $('#<%=chkAllowFiles.ClientID %>').removeAttr("disabled");
                $('#<%=chkAllowPhotos.ClientID %>').removeAttr("disabled");
            } else {
                $('#<%=chkAllowFiles.ClientID %>').attr("disabled", true);
                $('#<%=chkAllowPhotos.ClientID %>').attr("disabled", true);
            }
        });
    });

</script>
