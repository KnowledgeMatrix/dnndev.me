<%@ Control Language="C#" CodeBehind="Edit.ascx.cs" AutoEventWireup="true" Inherits="Mandeeps.DNN.Modules.LiveTabs.Edit" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register Assembly="Mandeeps.Web" Namespace="Mandeeps.Web.UI.WebControls" TagPrefix="Mandeeps" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Namespace="Mandeeps.DNN.Modules.LiveTabs.Components" Assembly="Mandeeps.DNN.Modules.LiveTabs"
    TagPrefix="LinkButton" %>
<%@ Register Namespace="Mandeeps.DNN.Modules.LiveTabs.Components" Assembly="Mandeeps.DNN.Modules.LiveTabs"
    TagPrefix="ImageButton" %>
<style type="text/css">
    .MNormal
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalBold
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
    }
    .MNormalRed
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: bold;
        color: #ff0000;
    }
    .MHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 20px;
        font-weight: normal;
        color: #333333;
    }
    .MSubHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
        color: #003366;
    }
    .MCommandButton
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalTextBox
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: normal;
    }
    a.mbutton
    {
        font-family: Helvetica,Arial,sans-serif;
        padding: 5px 10px;
        background: #818181;
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#818181, endColorstr=#656565);
        -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#818181, endColorstr=#656565)";
        background: -webkit-gradient(linear, left top, left bottom, from(#818181), to(#656565));
        background: -moz-linear-gradient(center top , #818181 0%, #656565 100%) repeat scroll 0 0 transparent;
        border-color: #FFFFFF;
        border-radius: 3px;
        color: #FFFFFF;
        font-weight: bold;
        text-decoration: none;
        text-shadow: 0 1px 1px #000000;
    }
    a.mbutton:hover
    {
        background: #4E4E4E;
        color: #ffffff;
        text-decoration: none;
    }
</style>
<asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
    <asp:View ID="View1" runat="server">
        <div class="livetabsdefaultdefault">
            <br />
            <div id="Info" runat="server" class="info">
                Get started with Live Tabs. Simply specify the name of your new tab and click "Add
                Tab"
            </div>
            <br />
            <asp:DropDownList CssClass="ddllocalepreview" ID="ddlLocalePreview" runat="server"
                OnSelectedIndexChanged="ddlLocalePreview_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList>
            <table class="livetabs" style="width: 100%">
                <tr id="AddNewTab" runat="server" visible="false">
                    <td style="width: 135px;">
                        <dnn:Label ID="lNewTab" runat="server" HelpText="Create New Tab" Text="New Tab" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbNewTabName" runat="server" CssClass="tbnewtabname" Width="180px"></asp:TextBox>&nbsp;
                        <asp:LinkButton ID="bCreateTab" CssClass="mbutton" resourcekey="bCreateTab" runat="server"
                            OnClientClick="LiveTabs.Add(); return false;" Text="Add"></asp:LinkButton>
                        <asp:Label ID="ValidateError" runat="server" CssClass="validateerror"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div style="overflow-y: auto; max-height: 180px">
                            <ul runat="server" id="uTabsList">
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>
            <div id="lttabcontainer" style="display:none;">
                <br />
                <Mandeeps:TabStrip runat="server" ID="LiveTabsEdit" TabsPersistence="true" Theme="Default"
                    ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                    <Mandeeps:Tab ID="ContentTab" runat="server">
                        <div class="livetabsverticalvertical">
                            <Mandeeps:TabStrip runat="server" ID="VerticalContents" Theme="Vertical" ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                                <Mandeeps:Tab ID="ContentSubTab" runat="server">
                                    <Mandeeps:TabStrip runat="server" ID="LiveTabsInternalEdit" TabsPersistence="true"
                                        Theme="Default" ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                                        <Mandeeps:Tab ID="HtmlContentTab" runat="server">
                                            <asp:Label ID="lContent" runat="server" CssClass="tabheading" resourcekey="lContent"></asp:Label>
                                            <hr size="1" style="color: #cccccc; width: 94%; margin-left: -3px;" />
                                            <dnn:TextEditor ID="tbContent" runat="server" OnPreRender="tbContent_PreRender" Width="97%"
                                                Height="400">
                                            </dnn:TextEditor>
                                            <br />
                                            <%--<asp:HiddenField ID="hfAction" runat="server" />--%>
                                            <div runat="server" id="PublishChangesRow1" class="PublishChangesRow">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="122">
                                                            <dnn:Label ID="lPublish" runat="server" HelpText="Publish." ResourceKey="lPublish"
                                                                Suffix=":" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="cbPublishChanges" runat="server" CssClass="css-checkbox normalCheckBox"
                                                                OnCheckedChanged="cbPublishChanges_OnCheckedChanged" AutoPostBack="true" />
                                                            <%--<asp:CheckBox ID="cbPublishChanges" runat="server" CssClass="css-checkbox normalCheckBox"
                                                                AutoPostBack="true" OnSelectedIndexChanged="cbPublishChanges_SelectedIndexChanged" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="122">
                                                            <dnn:Label ID="lLockAction" runat="server" HelpText="Lock Action." ResourceKey="lLockAction"
                                                                Suffix=":" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox ID="cbLockAction" runat="server" CssClass="css-checkbox normalCheckBox"
                                                                OnCheckedChanged="cbLockAction_OnCheckedChanged" AutoPostBack="true" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--<asp:CheckBoxList RepeatColumns="2" ID="cbPublishChanges" CssClass="normalCheckBox css-checkbox"
                                                    runat="server" AutoPostBack="true" OnSelectedIndexChanged="cbPublishChanges_SelectedIndexChanged">
                                                    <asp:ListItem resourcekey="PublishChanges" Value="1"></asp:ListItem>
                                                    <asp:ListItem resourcekey="LockContent" Value="2"></asp:ListItem>
                                                </asp:CheckBoxList>--%>
                                            </div>
                                            <div runat="server" id="LockStatusRow">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="122">
                                                            <dnn:Label ID="lLockStatus" runat="server" HelpText="Lock Status." ResourceKey="LockStatus"
                                                                Suffix=":" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lLockStatusValue" runat="server"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <div id="WStatesInfo" runat="server" visible="false" class="caption" style="width: 294px;
                                                                margin-left: 126px;">
                                                                <asp:Label ID="lStatesInfo" runat="server" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </Mandeeps:Tab>
                                        <Mandeeps:Tab ID="VersionTab" runat="server">
                                            <div id="versioncomparison" class="versioncomparison" runat="server" style="display: block">
                                                <ul>
                                                    <li>
                                                        <asp:Label runat="server" ID="lWorkflow" resourcekey="Workflow"></asp:Label>
                                                        <asp:Label ID="lWorkflowInfo" runat="server"></asp:Label>
                                                    </li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lState" resourcekey="State"></asp:Label>
                                                        <asp:Label ID="lStateInfo" runat="server"></asp:Label>
                                                    </li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lVersion" resourcekey="Version"></asp:Label>
                                                        <asp:Label ID="lVersionInfo" runat="server"></asp:Label>
                                                        <br />
                                                        <br />
                                                    </li>
                                                    <li>
                                                        <asp:Label runat="server" ID="lMaximumHistory" resourcekey="MaximumHistory" Style="font-style: italic;"></asp:Label>
                                                        <asp:Label ID="lMaximumNumber" runat="server"></asp:Label>
                                                    </li>
                                                </ul>
                                                <br />
                                                <telerik:RadGrid ID="gvVersion" runat="server" AutoGenerateColumns="false" OnItemDataBound="gvVersion_ItemDataBound"
                                                    AllowPaging="True" AllowSorting="True" GridLines="Both" AllowMultiRowSelection="True"
                                                    width="95%">
                                                    <mastertableview datakeynames="Version" nomasterrecordstext="There is no version history for this content.">
                                                        <Columns>
                                                            <telerik:GridClientSelectColumn UniqueName="Compare" HeaderText="Compare">
                                                            </telerik:GridClientSelectColumn>
                                                            <telerik:GridBoundColumn HeaderText="Version" UniqueName="Versions" DataField="Version">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Created Date" DataField="CreatedOn" UniqueName="CreatedDate">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Created By" DataField="CreatedBy" UniqueName="CreatedBy">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="State" UniqueName="State" DataField="StateID">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-Width="5">
                                                                <ItemTemplate>
                                                                    <ImageButton:postbackimagebutton id="ibHtmlContentPreview" runat="server" onclick="ibHtmlContentPreview_Click"
                                                                        imageurl="~/DesktopModules/LiveTabs/Resources/Images/Preview.png" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-Width="5">
                                                                <ItemTemplate>
                                                                    <ImageButton:postbackimagebutton id="bRollback" onclientclick="return confirm('Are you sure want to roll back?');"
                                                                        runat="server" onclick="bRollback_Click" imageurl="~/DesktopModules/LiveTabs/Resources/Images/Rollback.png" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-Width="5">
                                                                <ItemTemplate>
                                                                    <ImageButton:postbackimagebutton id="bDelete" onclientclick="return confirm('Are you sure you want to delete?');"
                                                                        runat="server" onclick="bDelete_Click" imageurl="~/DesktopModules/LiveTabs/Resources/Images/Delete.gif" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </mastertableview>
                                                    <clientsettings>
                                                        <Selecting AllowRowSelect="True" />
                                                        <ClientEvents OnRowSelected="LiveTabs.RowSelected" OnRowDeselected="LiveTabs.RowDeselected" />
                                                    </clientsettings>
                                                </telerik:RadGrid>
                                                <br />
                                                <asp:Label ID="lVCMessage" resourcekey="lVCMessage" runat="server"></asp:Label><br />
                                                <br />
                                                <asp:Button ID="lbVersionComparison" runat="server" resourcekey="lbVersionComparison"
                                                    CssClass="mbutton disable" OnClientClick="LiveTabs.VersionComparison();" OnClick="lbVersionComparison_Click" />
                                            </div>
                                            <div id="backtocomparison" runat="server" style="display: none">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="50%">
                                                            <asp:DropDownList ID="ddlVersionComparisonLeft" runat="server" AutoPostBack="true"
                                                                CssClass="comparisonleft" Width="225px" OnSelectedIndexChanged="ddlVersionComparisonLeft_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlVersionComparisonRight" runat="server" AutoPostBack="true"
                                                                CssClass="comparisonright" Width="225px" OnSelectedIndexChanged="ddlVersionComparisonRight_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="vertical-align: top">
                                                            <div class="previewPanelContainer">
                                                                <div class="previewPanel">
                                                                    <asp:Literal ID="ltLeftContent" runat="server"></asp:Literal></div>
                                                            </div>
                                                            <ul class="comparisonButtons">
                                                                <li>
                                                                    <asp:LinkButton ID="lbComparisonDesign" runat="server" resourcekey="lbComparisonDesign"
                                                                        CssClass="selected" OnClick="lbComparisonDesign_Click"></asp:LinkButton></li>
                                                                <li>
                                                                    <asp:LinkButton ID="lbComparisonHtml" runat="server" resourcekey="lbComparisonHtml"
                                                                        CssClass="" OnClick="lbComparisonHtml_Click"></asp:LinkButton></li>
                                                            </ul>
                                                        </td>
                                                        <td style="vertical-align: top">
                                                            <div class="previewPanelContainer">
                                                                <div class="previewPanel">
                                                                    <asp:Literal ID="ltRightContent" runat="server"></asp:Literal></div>
                                                            </div>
                                                            <asp:Label ID="lLegend" runat="server" resourcekey="lLegend"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <br />
                                                <asp:Button ID="lbBackToVersion" runat="server" resourcekey="lbBackToVersion" CssClass="mbutton cursor"
                                                    OnClick="lbBackToVersion_Click" />
                                            </div>
                                        </Mandeeps:Tab>
                                        <Mandeeps:Tab ID="ContentPreveiwTab" runat="server">
                                            <asp:DropDownList ID="ddlVersionPreview" runat="server" AutoPostBack="true" Width="225px"
                                                CssClass="contentpreview" OnSelectedIndexChanged="ddlVersionPreview_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <div class="previewPanelContainer">
                                                <div class="previewPanel">
                                                    <asp:Literal ID="ltversionPreview" runat="server"></asp:Literal>
                                                </div>
                                            </div>
                                            <div id="WorkflowDetail" runat="server">
                                                <br />
                                                <asp:Label runat="server" ID="lWorkfowdetail" resourcekey="WorkflowDetail" Style="font-weight: bold"></asp:Label>
                                                <br />
                                                <br />
                                                <telerik:RadGrid ID="gvWorkflowDetail" runat="server" AutoGenerateColumns="false"
                                                    AllowPaging="True" PageSize="10" AllowSorting="True" GridLines="None" AllowMultiRowSelection="True"
                                                    OnItemDataBound="gvWorkflowDetail_ItemDataBound" width="95%">
                                                    <pagerstyle mode="NextPrevAndNumeric"></pagerstyle>
                                                    <mastertableview datakeynames="WorkflowLogID" nomasterrecordstext="There is no workflow for this content.">
                                                        <Columns>
                                                            <telerik:GridBoundColumn HeaderText="Date" DataField="ReviewedOn" UniqueName="ReviewedOn">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="User" DataField="ReviewedBy" UniqueName="ReviewedBy">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="State" UniqueName="State" DataField="StateID">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Approved" DataField="Approved" UniqueName="Approved">
                                                            </telerik:GridBoundColumn>
                                                            <telerik:GridBoundColumn HeaderText="Comments" DataField="Comment" UniqueName="Comments">
                                                            </telerik:GridBoundColumn>
                                                        </Columns>
                                                    </mastertableview>
                                                </telerik:RadGrid>
                                            </div>
                                        </Mandeeps:Tab>
                                    </Mandeeps:TabStrip>
                                </Mandeeps:Tab>
                                <Mandeeps:Tab ID="ModulesTab" runat="server">
                                    <asp:Label ID="lModules" runat="server" CssClass="tabheading" resourcekey="lModules"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr id="PortalRow" runat="server">
                                            <td width="200">
                                                <dnn:Label ID="lPortals" runat="server" Text="Portal" HelpText="Select a portal">
                                                </dnn:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPortals" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPortals_SelectedIndexChanged"
                                                    Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lPages" runat="server" HelpText="Select a page from your portal" Text="Pages" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPages" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged"
                                                    Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lModuless" runat="server" HelpText="Select a module" Text="Modules" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlModules" runat="server" Width="300px">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <asp:LinkButton ID="bAddModule" runat="server" CssClass="mbutton" resourcekey="bAddModule"
                                                    OnClick="bAddModule_Click"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lSelectedModules" runat="server" HelpText="Selected modules to show in tab"
                                                    Text="Selected Modules" />
                                            </td>
                                            <td>
                                                <table style="margin-left: -3px;">
                                                    <tr>
                                                        <td rowspan="3">
                                                            <asp:ListBox ID="lbModules" runat="server" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="lbModules_SelectedIndexChanged">
                                                            </asp:ListBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="ibModuleUp" runat="server" ImageUrl="~/images/action_up.gif"
                                                                OnClick="bModuleUp_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="ibRemoveModule" runat="server" ImageUrl="~/images/action_delete.gif"
                                                                OnClick="bRemoveModule_Click" Style="height: 16px" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="ibModuleDown" runat="server" ImageUrl="~/images/action_down.gif"
                                                                OnClick="bModuleDown_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <asp:Panel ID="ModuleSettings" runat="server">
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 225px">
                                                    <dnn:Label ID="lTagName" runat="server" HelpText="[TagName] is used within Content in Wrapper Mode"
                                                        Text="Tag Name" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbTagName" runat="server" Width="295px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 225px">
                                                    <dnn:Label ID="lShowModuleContainer" runat="server" Text="Show Module Container" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbShowModuleContainer" runat="server" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 225px">
                                                    <dnn:Label ID="lDateExpire" runat="server" HelpText="Enforce start and end date of module"
                                                        Text="Apply Start/End Date" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbDateExpire" runat="server" Checked="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 225px">
                                                    <dnn:Label ID="lModulePermissions" runat="server" HelpText="Enforces module permissions"
                                                        Text="Apply Module Permissions" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbModulePermissions" runat="server" Checked="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 225px">
                                                    <dnn:Label ID="lInjectEvent" runat="server" HelpText="Inject event for the module"
                                                        Text="Inject event" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlInjectEvent" runat="server">
                                                        <asp:ListItem resourcekey="Automatic" Value="Automatic" />
                                                        <asp:ListItem resourcekey="PageInit" Value="PageInit" />
                                                        <asp:ListItem resourcekey="PageLoad" Value="PageLoad" />
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:LinkButton ID="bUpdateTagName" runat="server" CssClass="mbutton" OnClick="bUpdateTagName_Click"
                                                        resourcekey="bUpdateTagName"></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </asp:Panel>
                                    </table>
                                </Mandeeps:Tab>
                            </Mandeeps:TabStrip>
                        </div>
                    </Mandeeps:Tab>
                    <Mandeeps:Tab ID="SettingsTab" runat="server">
                        <div class="livetabsverticalvertical">
                            <Mandeeps:TabStrip runat="server" ID="VerticalSettings" Theme="Vertical" ThemePath="~/DesktopModules/LiveTabs/Resources/Tabs">
                                <Mandeeps:Tab ID="BasicTab" runat="server">
                                    <asp:Label ID="lBasic" runat="server" CssClass="tabheading" resourcekey="lBasic"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lTabName" runat="server" HelpText="Allows you to rename the tab" Text="Tab Name" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbTabName" runat="server" Width="295px" Style="margin-bottom: 0px;"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lTabHeader" runat="server" HelpText="Allows you to customize the tab header. Use HTML editor and add icons and other formatting to your tabs."
                                                    Text="Show Tab Header" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbTabHeader" runat="server" AutoPostBack="true" OnCheckedChanged="cbTabHeader_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr id="TabHeader" runat="server" visible="false">
                                            <td colspan="2">
                                                <dnn:TextEditor ID="tbTabHeader" Visible="true" OnPreRender="tbTabHeader_PreRender"
                                                    runat="server" Width="100%" Height="300">
                                                </dnn:TextEditor>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="CustomizeBreaklineRow1" runat="server">
                                            <td style="width: 225px">
                                                <dnn:Label ID="lCustomizeBreakline" runat="server" HelpText="You can optionally specify your own breakline html..."
                                                    Text="Customize Breakline" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbCustomizeBreakline" runat="server" AutoPostBack="True" OnCheckedChanged="cbCustomizeBreakline_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr id="CustomizeBreaklineRow2" runat="server">
                                            <td style="width: 225px">
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbBreakline" runat="server" Height="50px" TextMode="MultiLine" Visible="False"
                                                    Width="300px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="LoadOnDemandRow" runat="server">
                                            <td style="width: 225px">
                                                <dnn:Label ID="lLoadOnDemand" runat="server" HelpText="You can optionally specify your own breakline html..."
                                                    Text="Customize Breakline" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbLoadOnDemand" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" id="NavigateUrlTable" runat="server">
                                        <tr>
                                            <td style="width: 225px">
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lNavigateUrl" runat="server" HelpText="Links directly to the tab from any page"
                                                    Text="Navigate Url" />
                                            </td>
                                            <td>
                                                <dnn:URL ID="BrowseNavigateUrl" runat="server" ShowTabs="True" ShowNone="true" UrlType="T"
                                                    ShowNewWindow="False" ShowSecure="true" ShowLog="false" ShowTrack="false" ShowUpLoad="false"
                                                    ShowDatabase="True" ShowUrls="True" ShowFiles="false">
                                                </dnn:URL>
                                            </td>
                                        </tr>
                                    </table>
                                </Mandeeps:Tab>
                                <Mandeeps:Tab ID="SearchTab" runat="server">
                                    <asp:Label ID="lSearch" runat="server" CssClass="tabheading" resourcekey="lSearch"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lSearchable" runat="server" HelpText="Enable DNN Search" Text="Searchable" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbSearchable" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lSearchSummary" runat="server" HelpText="Shown in Search Results"
                                                    Text="Search Summary" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbSearchSummary" runat="server" TextMode="MultiLine" Width="100%"
                                                    Height="100px"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </Mandeeps:Tab>
                                <Mandeeps:Tab ID="PermissionsTab" runat="server">
                                    <asp:Label ID="lPermissions" runat="server" CssClass="tabheading" resourcekey="lPermissions"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lPermissionss" runat="server" HelpText="Tab Permissions" Text="Permissions" />
                                            </td>
                                            <td>
                                                <asp:CheckBoxList ID="cblPermissions" runat="server" CssClass="MNormal" RepeatLayout="Flow">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>
                                    </table>
                                </Mandeeps:Tab>
                                <Mandeeps:Tab ID="IntegrationTab" runat="server">
                                    <asp:Label ID="lIntegration" runat="server" CssClass="tabheading" resourcekey="lIntegration"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr id="UseToken" runat="server" visible="false">
                                            <td style="width: 225px">
                                                <dnn:Label ID="lUseToken" runat="server" HelpText="Links directly to the tab from any page"
                                                    Text="Use Token" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbUseToken" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="UseToken1" runat="server" visible="false">
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lTabLink" runat="server" HelpText="Links directly to the tab from any page"
                                                    Text="Tab Link" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbTabLink" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lTabLinkHtmlCode" runat="server" HelpText="Links directly to the tab from any page"
                                                    Text="Link HTML Code" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbTabLinkHtmlCode" runat="server" Height="75px" Width="100%" ReadOnly="true"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 225px">
                                                <dnn:Label ID="lJavascriptLink" runat="server" HelpText="Links directly to the tab from within page"
                                                    Text="Javascript Link" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbJavascriptLink" runat="server" Height="75px" Width="100%" ReadOnly="true"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </Mandeeps:Tab>
                            </Mandeeps:TabStrip>
                        </div>
                    </Mandeeps:Tab>
                </Mandeeps:TabStrip>
                <br />
                <table>
                    <tr id="SaveRow1" runat="server">
                        <td>
                            <asp:LinkButton ID="bUpdate" runat="server" Text="Update Tab" CssClass="mbutton"
                                resourcekey="bUpdate" OnClick="cmdUpdate_Click" />&nbsp; &nbsp;<asp:LinkButton resourcekey="cmdBack"
                                    ID="cmdBack" runat="server" Text="Back" CssClass="mbutton2" OnClick="cmdBack_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <br />
        </div>
    </asp:View>
    <asp:View ID="View2" runat="server">
        <div id="CommentRow1">
            <br />
            <asp:Label ID="lComment" runat="server" ResourceKey="TabCommentAdd" Style="font-weight: bold"></asp:Label><br />
            <br />
            <asp:TextBox ID="tbComment" runat="server" Height="180px" Width="450px" TextMode="MultiLine"></asp:TextBox><br />
            <br />
        </div>
    </asp:View>
</asp:MultiView>
<br />
<asp:LinkButton ID="bAddComment" runat="server" CssClass="mbutton" Visible="false"
    Font-Bold="true" resourceKey="TabCommentAdd" OnClick="bAddComment_Click"></asp:LinkButton>&nbsp;
&nbsp;<asp:LinkButton resourcekey="cmdBack1" ID="cmdBack1" runat="server" Text="Back"
    CssClass="mbutton" Visible="false" OnClick="cmdBack1_Click" />
<linkbutton:postbacklinkbutton id="BindTabId" runat="server">
</linkbutton:postbacklinkbutton>
