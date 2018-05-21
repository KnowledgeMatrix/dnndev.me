<%@ Control Language="C#" CodeBehind="Edit.ascx.cs" AutoEventWireup="true" Inherits="Mandeeps.DNN.Modules.LiveAccordion.Edit" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="URL" Src="~/controls/URLControl.ascx" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Mandeeps.Web" Namespace="Mandeeps.Web.UI.WebControls" TagPrefix="Mandeeps" %>
<%@ Register Namespace="Mandeeps.DNN.Modules.LiveAccordion.Components" Assembly="Mandeeps.DNN.Modules.LiveAccordion"
    TagPrefix="MButton" %>
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
</style>
<br />
<div class="livetabsdefaultdefault">
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <br />
            <div id="Info" runat="server" class="info">
                Get started with Live Accordion. Simply specify the name of your new pane and click
                "Add Pane"
            </div>
            <br />
            <asp:DropDownList ID="ddlLocalePreview" CssClass="ddllocalepreview" runat="server"
                AutoPostBack="True" OnSelectedIndexChanged="ddlLocalePreview_SelectedIndexChanged"
                Width="300px">
            </asp:DropDownList>
            <table width="100%" class="liveaccordion">
                <tr id="AddTab" runat="server" visible="false">
                    <td style="width: 150px">
                        <dnn:Label ID="lNewPane" Suffix=":" runat="server" HelpText="Create New Pane" Text="New Pane" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbNewPaneName" CssClass="tbnewpanename" runat="server" Width="295px"></asp:TextBox>&nbsp;
                        <asp:LinkButton ID="bCreatePane" OnClientClick="LiveAccordion.Add(); return false;"
                            Text="Add" CssClass="mbutton" resourcekey="bCreatePane" runat="server"></asp:LinkButton>
                        <br />
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
                            <ul runat="server" id="uPanesList">
                            </ul>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="panTab" runat="server" Visible="false">
                <br />
                <Mandeeps:TabStrip runat="server" ID="LiveAccordionEdit" TabsPersistence="true" Theme="Default"
                    ThemePath="~/DesktopModules/LiveAccordion/Resources/Tabs">
                    <Mandeeps:Tab ID="ContentTab" runat="server">
                        <div class="livetabsverticalvertical">
                            <Mandeeps:TabStrip runat="server" ID="VerticalContents" Theme="Vertical" ThemePath="~/DesktopModules/LiveAccordion/Resources/Tabs">
                                <Mandeeps:Tab ID="ContentSubTab" runat="server">
                                    <Mandeeps:TabStrip ID="HorizontalTabs" runat="server" TabsPersistence="true" LinkTheme="false">
                                        <Mandeeps:Tab ID="ContentTab1" runat="server">
                                            <dnn:TextEditor ID="tbContent" runat="server" width="100%" height="375px" OnPreRender="tbContent_PreRender">
                                            </dnn:TextEditor>
                                            <div id="ContentRow" runat="server" class="previewPanelContainer" visible="false">
                                                <div class="previewPanel">
                                                    <asp:Literal ID="ltContent" runat="server"></asp:Literal>
                                                </div>
                                            </div>
                                            <br />
                                            <asp:HiddenField ID="hfAction" runat="server" />
                                            <div runat="server" id="PublishChangesRow1" class="PublishChangesRow" style="margin-bottom: 0px;">
                                                <table width="100%" cellpadding="3" cellspacing="3">
                                                    <tr>
                                                        <td width="122">
                                                            <dnn:Label ID="lPublish" runat="server" HelpText="Publish." ResourceKey="lPublish"
                                                                Suffix=":" />
                                                        </td>
                                                        <td>
                                                            <asp:CheckBox Text="Publish Content" ID="cbPublishChanges" runat="server" CssClass="css-checkbox normalCheckBox"
                                                                OnCheckedChanged="cbPublishChanges_OnCheckedChanged" AutoPostBack="true" />
                                                            <%--<asp:CheckBox ID="cbPublishChanges" runat="server" CssClass="css-checkbox normalCheckBox"
                                                                AutoPostBack="true" OnSelectedIndexChanged="cbPublishChanges_SelectedIndexChanged" />--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--                                                <asp:CheckBoxList RepeatColumns="2" ID="cbPublishChanges" runat="server" CssClass="css-checkbox normalCheckBox"
                                                    AutoPostBack="true" OnSelectedIndexChanged="cbPublishChanges_SelectedIndexChanged">
                                                </asp:CheckBoxList>--%>
                                            </div>
                                            <div runat="server" id="LockStatusRow1" style="margin-bottom: 15px;">
                                                <table width="100%" cellpadding="3" cellspacing="3">
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
                                                    <tr>
                                                        <td width="122">
                                                            <dnn:Label ID="lLockStatus" runat="server" HelpText="Lock Status." ResourceKey="LockStatus"
                                                                Suffix=":" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lLockStatusValue" runat="server"></asp:Label><br /> <br />
                                                            <div id="WStatesInfo" runat="server" visible="false" class="caption" style="width: 294px;
                                                                margin-bottom: 15px;">
                                                                <asp:Label ID="lStatesInfo" runat="server" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </Mandeeps:Tab>
                                        <Mandeeps:Tab ID="VersionTab" runat="server">
                                            <div id="versioncomparison" class="versioncomparison" runat="server" style="display: block">
                                                <ul >
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
                                                        <asp:Label runat="server" ID="lMaximumHistory" resourcekey="MaximumHistory"></asp:Label>
                                                        <asp:Label ID="lMaximumNumber" runat="server"></asp:Label>
                                                    </li>
                                                </ul>
                                                <br />
                                                <telerik:RadGrid ID="gvVersion" runat="server" AutoGenerateColumns="false" OnItemDataBound="gvVersion_ItemDataBound"
                                                    AllowPaging="True" AllowSorting="True" GridLines="None" AllowMultiRowSelection="True">
                                                    <MasterTableView DataKeyNames="Version" NoMasterRecordsText="There is no version history for this content.">
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
                                                                    <MButton:PostBackImageButton ID="ibAccordionContentPreview" runat="server" OnClick="ibAccordionContentPreview_Click"
                                                                        ImageUrl="~/DesktopModules/LiveAccordion/Resources/Images/Preview.png" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-Width="5">
                                                                <ItemTemplate>
                                                                    <MButton:PostBackImageButton ID="bRollback" OnClientClick="return confirm('Are you sure want to roll back?');"
                                                                        runat="server" OnClick="bRollback_Click" ImageUrl="~/DesktopModules/LiveAccordion/Resources/Images/Rollback.png" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                            <telerik:GridTemplateColumn ItemStyle-Width="5">
                                                                <ItemTemplate>
                                                                    <MButton:PostBackImageButton ID="bDelete" OnClientClick="return confirm('Are you sure you want to delete?');"
                                                                        runat="server" OnClick="bDelete_Click" ImageUrl="~/DesktopModules/LiveAccordion/Resources/Images/Delete.gif" />
                                                                </ItemTemplate>
                                                            </telerik:GridTemplateColumn>
                                                        </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Selecting AllowRowSelect="True" />
                                                        <ClientEvents OnRowSelected="LiveAccordion.RowSelected" OnRowDeselected="LiveAccordion.RowDeselected" />
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                                <br />
                                                <asp:Label ID="lVCMessage" resourcekey="lVCMessage" runat="server"></asp:Label><br />
                                                <br />
                                                <asp:Button ID="lbVersionComparison" runat="server" resourcekey="lbVersionComparison"
                                                    CssClass="mbutton disable" OnClientClick="LiveAccordion.VersionComparison();"
                                                    OnClick="lbVersionComparison_Click" />
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
                                                    OnItemDataBound="gvWorkflowDetail_ItemDataBound">
                                                    <PagerStyle Mode="NextPrevAndNumeric"></PagerStyle>
                                                    <MasterTableView DataKeyNames="WorkflowLogID" NoMasterRecordsText="There is no workflow for this content.">
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
                                                    </MasterTableView>
                                                </telerik:RadGrid>
                                            </div>
                                        </Mandeeps:Tab>
                                    </Mandeeps:TabStrip>
                                </Mandeeps:Tab>
                                <Mandeeps:Tab ID="ModulesTab" runat="server">
                                    <asp:Label ID="lAddModules" runat="server" CssClass="tabheading" resourcekey="lAddModules"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr id="PortalRow" runat="server">
                                            <td width="230">
                                                <dnn:Label ID="lPortals" runat="server" Suffix=":" Text="Portal" HelpText="Select a portal">
                                                </dnn:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPortals" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPortals_SelectedIndexChanged"
                                                    Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label ID="lPages" Suffix=":" runat="server" HelpText="Select a page from your portal"
                                                    Text="Pages" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlPages" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPages_SelectedIndexChanged"
                                                    Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label Suffix=":" ID="lModules" runat="server" HelpText="Select a module" Text="Modules" />
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlModules" runat="server" Width="300px">
                                                </asp:DropDownList>
                                                &nbsp;
                                                <asp:LinkButton ID="bAddModule" runat="server" CssClass="mbutton" resourcekey="bAddModule"
                                                    OnClick="bAddModule_Click">Add</asp:LinkButton>
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
                                            <td>
                                                <dnn:Label Suffix=":" ID="lSelectedModules" runat="server" HelpText="Selected modules to show in pane"
                                                    Text="Selected Modules" />
                                            </td>
                                            <td>
                                                <table class="style1" style="margin-left: -3px;">
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
                                                <td>
                                                    <dnn:Label ID="lTagName" Suffix=":" runat="server" HelpText="[TagName] is used within Content in Wrapper Mode"
                                                        Text="Tag Name" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="tbTagName" runat="server" Width="295px"></asp:TextBox>
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
                                                <td>
                                                    <dnn:Label ID="lShowModuleContainer" Suffix=":" runat="server" Text="Show Module Container" />
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
                                                <td>
                                                    <dnn:Label ID="lDateExpire" Suffix=":" runat="server" HelpText="Apply start and end date of module"
                                                        Text="Apply Start/End Date" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="cbDateExpire" runat="server" Checked="True" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dnn:Label ID="lModulePermissions" Suffix=":" runat="server" HelpText="Apply module permissions"
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
                                                <td>
                                                    <dnn:Label ID="lInjectEvent" Suffix=":" runat="server" HelpText="Inject event for the module"
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
                            <Mandeeps:TabStrip runat="server" ID="VerticalSettings" Theme="Vertical" ThemePath="~/DesktopModules/LiveAccordion/Resources/Tabs">
                                <Mandeeps:Tab ID="BasicTab" runat="server">
                                    <asp:Label ID="lBasic" runat="server" CssClass="tabheading" resourcekey="lBasic"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr>
                                            <td width="240">
                                                <dnn:Label ID="lPaneName" runat="server" Suffix=":" HelpText="Allows you to rename the pane"
                                                    Text="Pane Name" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbPaneName" runat="server" Width="295px" Style="margin-bottom: 0px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label ID="lPaneHeader" runat="server" Suffix=":" HelpText="Allows you to customize the pane header. Use HTML editor and add icons and other formatting to your panes."
                                                    Text="Show Pane Header" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbPaneHeader" runat="server" AutoPostBack="true" OnCheckedChanged="cbPaneHeader_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr id="PaneHeader" runat="server" visible="false">
                                            <td colspan="2">
                                                <dnn:TextEditor ID="tbPaneHeader" runat="server" OnPreRender="tbPaneHeader_PreRender"
                                                    Width="100%" Height="300">
                                                </dnn:TextEditor>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr id="CustomizeBreaklineRow1" runat="server">
                                            <td>
                                                <dnn:Label ID="lCustomizeBreakline" Suffix=":" runat="server" HelpText="You can optionally specify your own breakline html..."
                                                    Text="Customize Breakline" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbCustomizeBreakline" runat="server" AutoPostBack="True" OnCheckedChanged="cbCustomizeBreakline_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr id="CustomizeBreaklineRow2" runat="server">
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbBreakline" runat="server" Height="50px" TextMode="MultiLine" Visible="False"
                                                    Width="300px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr id="LoadOnDemandRow" runat="server">
                                            <td>
                                                <dnn:Label ID="lLoadOnDemand" runat="server" Suffix=":" HelpText="Loads the content of tab only when the tab is activated by postback (Page Refresh). Useful to reduce the size of page and improve speed/performance. Since the content is only loaded on demand, it's not available to Search Engines and therefore the content will NOT BE INDEXED by Search Engines."
                                                    Text="Customize Breakline" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="cbLoadOnDemand" runat="server" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" id="NavigateUrlTable" runat="server">
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label ID="lNavigateUrl" Suffix=":" runat="server" HelpText="Links directly to the tab from any page"
                                                    Text="Navigate Url" />
                                            </td>
                                            <td>
                                                <dnn:URL ID="BrowseNavigateUrl" runat="server" ShowTabs="True" ShowNone="True" UrlType="T"
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
                                            <td width="240">
                                                <dnn:Label ID="lSearchable" Suffix=":" runat="server" HelpText="Enable DNN Search"
                                                    Text="Searchable" />
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
                                            <td>
                                                <dnn:Label ID="lSearchSummary" Suffix=":" runat="server" HelpText="Shown in Search Results"
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
                                    <asp:Label ID="lPermissionss" runat="server" Suffix=":" CssClass="tabheading" resourcekey="lPermissionss"></asp:Label>
                                    <hr size="1" style="color: #cccccc" />
                                    <table width="100%">
                                        <tr>
                                            <td width="240">
                                                <dnn:Label ID="lPermissions" Suffix=":" runat="server" HelpText="Tab Permissions"
                                                    Text="Permissions" />
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
                                            <td width="240">
                                                <dnn:Label ID="lUseToken" Suffix=":" runat="server" HelpText="Links directly to the tab from any page"
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
                                            <td>
                                                <dnn:Label ID="lPaneLink" Suffix=":" runat="server" HelpText="Links directly to the pane from any page"
                                                    Text="Pane Link" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbPaneLink" runat="server" Width="100%" ReadOnly="true"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label ID="lPaneLinkHtmlCode" Suffix=":" runat="server" HelpText="Links directly to the pane from any page"
                                                    Text="Link HTML Code" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="tbPaneLinkHtmlCode" runat="server" Height="75px" Width="100%" ReadOnly="true"
                                                    TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dnn:Label ID="lJavascriptLink" Suffix=":" runat="server" HelpText="Links directly to the pane from within page"
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
                <%-- <asp:LinkButton ID="bUpdate" runat="server" Text="Update Tab" CssClass="mbutton"
            resourcekey="bUpdate" OnClick="cmdUpdate_Click" />
        &nbsp;&nbsp;<asp:LinkButton resourcekey="cmdBack" ID="cmdBack" runat="server" Text="Back"
            CssClass="mbutton2" OnClick="cmdBack_Click" />--%>
                <table>
                    <tr id="SaveRow1" runat="server">
                        <td>
                            <asp:LinkButton ID="bAccordionUpdate" runat="server" CssClass="mbutton" resourceKey="bAccordionUpdate"
                                OnClick="bAccordionUpdate_Click"></asp:LinkButton>&nbsp; &nbsp;<asp:LinkButton resourcekey="cmdBack"
                                    ID="cmdBack" runat="server" Text="Back" CssClass="mbutton2" OnClick="cmdBack_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <div id="CommentRow1">
                <br />
                <asp:Label ID="lComment" runat="server" ResourceKey="HtmlCommentAdd" Style="font-weight: bold"></asp:Label><br />
                <br />
                <asp:TextBox ID="tbComment" runat="server" Height="180px" Width="450px" TextMode="MultiLine"></asp:TextBox>
                <%--<asp:LinkButton ID="bBackComment" runat="server" Font-Bold="true" resourceKey="BackComment"
                    OnClick="bBackComment_Click"></asp:LinkButton>--%>
            </div>
        </asp:View>
    </asp:MultiView>
    <div id="PreviewContainer" runat="server" class="previewPanelContainer" visible="false">
        <div class="previewPanel">
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </div>
    </div>
    <br />
    <asp:LinkButton ID="bAddComment" runat="server" CssClass="mbutton" Font-Bold="true"
        resourceKey="HtmlCommentAdd" Visible="false" OnClick="bAddComment_Click"></asp:LinkButton>&nbsp;
    &nbsp;<asp:LinkButton resourcekey="cmdBack1" ID="cmdBack1" runat="server" Text="Back"
        CssClass="mbutton" Visible="false" OnClick="cmdBack1_Click" />
</div>
<MButton:PostBackLinkButton ID="BindPaneId" runat="server">
</MButton:PostBackLinkButton>
