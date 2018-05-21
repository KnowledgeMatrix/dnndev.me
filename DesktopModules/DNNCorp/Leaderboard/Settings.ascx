<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="DotNetNuke.Professional.Leaderboard.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel runat="server" ID="ScopeWrapper">
    <div id="leaderboardSettings" class="dnnForm dnnClear">
        <fieldset>
            <legend></legend>
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="PageSize" suffix=":" />
                <asp:DropDownList runat="server" ID="lstPageSize">
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="10" Value="10" />
                    <asp:ListItem Text="15" Value="15" />
                    <asp:ListItem Text="20" Value="20" />
                    <asp:ListItem Text="25" Value="25" />
                    <asp:ListItem Text="30" Value="30" />
                    <asp:ListItem Text="50" Value="50" />
                    <asp:ListItem Text="100" Value="100" />
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="Interval" suffix=":" />
                <asp:DropDownList runat="server" ID="lstInterval">
                    <asp:ListItem Value="AllTime" resourcekey="IntervalAllTime" />
                    <asp:ListItem Value="Year" resourcekey="IntervalYear" />
                    <asp:ListItem Value="Month" resourcekey="IntervalMonth" />
                    <asp:ListItem Value="Week" resourcekey="IntervalWeek" />
                    <asp:ListItem Value="Day" resourcekey="IntervalDay" />
                </asp:DropDownList>
            </div>
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="ShowModePanel" suffix=":" />
                <asp:CheckBox ID="checkShowModePanel" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="ShowModeButtons" suffix=":" />
                <asp:CheckBox ID="checkShowModeButtons" runat="server" />
            </div>
            <div class="dnnFormItem">
                <dnn:Label runat="server" id="plDisplayMode" suffix=":" />
                <div>
                    <input type="radio" name="mode" value="allusers" id="modeAllUsers" data-bind="checked: mode" />
                    <label for="modeAllUsers"><%= LocalizeString("AllUsers") %></label>
                    <input type="radio" name="mode" value="friends" id="modeFriends" data-bind="checked: mode" />
                    <label for="modeFriends"><%= LocalizeString("Friends") %></label>
                    <input type="radio" name="mode" value="members" id="modeMembers" data-bind="checked: mode" />
                    <label for="modeMembers"><%= LocalizeString("Members") %></label>
                </div>
            </div>
            <!-- ko if: mode() == 'members' -->
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="Group" suffix=":" />
                <select id="group" data-bind="options: roles, optionsText: 'name', optionsValue: 'roleId', value: selectedGroup"></select>
            </div>
            <!-- /ko -->
            <div class="dnnFormItem">
                <dnn:Label id="plRankMode" runat="server" suffix=":" />
                 <asp:DropDownList runat="server" ID="lstRankMode"></asp:DropDownList>
            </div>
            <div class="dnnFormItem" style="display:none;">
                <dnn:Label runat="server" ResourceKey="ExcludedRoles" suffix=":" />
                <div class="roleList">
                    <input name="excludedRoles" id="excludedRoles" value="" />
                </div>
            </div>
        </fieldset>       
        <h2 class="dnnFormSectionHead" id="dnnPanel-TemplateSection">
            <a href="#"><%= LocalizeString("ConfigurationTemplate") %></a>
        </h2>
        <fieldset>
            <legend></legend>
            <div class="dnnFormItem">
                <dnn:Label runat="server" ResourceKey="TemplateSelection" suffix=":" />
                <asp:DropDownList ID="templateSelect" runat="server">
                    <asp:ListItem Value="Default" resourcekey="liDefault" />
                    <asp:ListItem Value="Sidebar" resourcekey="liSide" />
                    <asp:ListItem Value="Predefined1" resourcekey="liPredef1" />
                    <asp:ListItem Value="Predefined2" resourcekey="liPredef2" />
                    <asp:ListItem Value="Customise" resourcekey="liCustom" />
                </asp:DropDownList>
            </div>
            <div class="dnnForm dnnClear leaderboard-customisedSettings">
                <div class="dnnFormItem">
                    <dnn:Label runat="server" ResourceKey="HeaderTemplate" suffix=":" />
                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txtHeaderTemplate"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label runat="server" ResourceKey="ItemTemplate" suffix=":" />
                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txtItemTemplate"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label runat="server" ResourceKey="HighlightTemplate" suffix=":" />
                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txtHighTemplate"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn:Label runat="server" ResourceKey="FooterTemplate" suffix=":" />
                    <asp:TextBox runat="server" TextMode="MultiLine" ID="txtFooterTemplate"></asp:TextBox>
                </div>
            </div>
        </fieldset>
    </div>
    <asp:HiddenField runat="server" ID="hfdHiddenRoles" />
    <asp:HiddenField runat="server" ID="hfdSelectedRole" />
    <asp:HiddenField runat="server" ID="hfdMode" />
</asp:Panel>
<script type="text/javascript">
    function leaderboardSettingsInit(settings) {
        settings.moduleScope = $(settings.moduleScope)[0];
        if (!settings.moduleScope) {
            return;
        }

        settings.hiddenMode = $(settings.hiddenMode)[0];
        settings.hiddenRoles = $(settings.hiddenRoles)[0];
        settings.hiddenSelectedRoleId = $(settings.hiddenSelectedRoles)[0];

        try {
            ko.applyBindings(new dnn.leaderboard.Settings($, ko, settings), settings.moduleScope);
        } catch(ex) {
            dnn.social.topLevelExceptionHandler(settings, ex);
        }
    }

    $(function() {
        var toggleCustomisedTemplateSettings = function() {
            var val = $('#<%= templateSelect.ClientID %>').val();
            if (val !== 'Customise') {
                $('#<%= ScopeWrapper.ClientID %> .leaderboard-customisedSettings').hide();
            } else {
                $('#<%= ScopeWrapper.ClientID %> .leaderboard-customisedSettings').show();
            }
        };

        $('#<%= templateSelect.ClientID %>').change(toggleCustomisedTemplateSettings).change();
    });
</script>