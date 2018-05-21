<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManageWorkflow.ascx.cs"
    Inherits="Mandeeps.DNN.Library.Workflow.UI.ManageWorkflow" %>
<%@ Register Assembly="Mandeeps.DNN.Library.Workflow" Namespace="Mandeeps.DNN.Library.Workflow.UI.Controls"
    TagPrefix="Mandeeps" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<div id="PlaceHolder" runat="server">
    <asp:Label ID="lManageWorkflows" runat="server" Font-Bold="true" resourcekey="lManageWorkflows"></asp:Label>
    <hr size="1" style="color: #cccccc" />
    <table id="TableWorkflow" runat="server" width="100%" cellpadding="5" cellspacing="5">
        <tr>
            <td width="165" style="vertical-align: middle">
                <dnn:label id="lWorkflowOption" runat="server" helptext="Select Workflow to apply."
                    suffix=":" resourcekey="lWorkflowOption" />
            </td>
            <td>
                <asp:DropDownList ID="ddlWorkflow" CssClass="ddl" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlWorkflow_SelectedIndexChanged"
                    Width="295" >
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td width="165" style="vertical-align: middle">
                <dnn:label id="lWorkflowScope" runat="server" helptext="Select workflow scope" suffix=":"
                    resourcekey="lWorkflowScope" />
            </td>
            <td>
                <asp:DropDownList ID="ddlWorkflowScope" CssClass="ddl" runat="server" Width="295">
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="TitleRow">
            <td>
                <dnn:label id="lTitle" runat="server" helptext="Title of the Workflow." suffix=":"
                    resourcekey="lTitle" />
            </td>
            <td>
                <asp:TextBox ID="tbWorkflow" runat="server" Width="290"></asp:TextBox>
            </td>
        </tr>
        <tr id="DescriptionRow">
            <td>
                <dnn:label id="lDescription" runat="server" helptext="Description of the Workflow."
                    suffix=":" resourcekey="lDescription" />
            </td>
            <td>
                <asp:TextBox TextMode="MultiLine" ID="tbDescription" runat="server" Height="100"
                    Width="290"></asp:TextBox>
            </td>
        </tr>
        <tr id="DeletedRow">
            <td>
                <dnn:label id="lDeleted" runat="server" helptext="Name of the Articles." suffix=":"
                    resourcekey="lDeleted" />
                <br />
            </td>
            <td>
                <asp:CheckBox ID="cbDeleted" runat="server" />
                <br />
            </td>
        </tr>
        <tr id="ButtonsRow" runat="server">
            <td colspan="2">
                <asp:LinkButton ID="lbAddWorkflow" runat="server" CssClass="lnkbtn1" ForeColor="Black"
                    OnClick="AddWorkflow_Click" />
                <asp:LinkButton ID="lbCancelWorkflow" runat="server" resourcekey="CancelWorkflow"
                    CssClass="lnkbtn2" ForeColor="#003366" Font-Bold="true" OnClick="CancelWorkflow_Click" />
            </td>
        </tr>
    </table>
    <table id="WorkflowStatesTable" runat="server" visible="false" cellpadding="5" cellspacing="5">
        <tr id="Tr1">
            <td colspan="2">
                <hr />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lMangaeState" runat="server" Font-Bold="true" resourcekey="lMangaeState"></asp:Label>
                <hr size="1" style="color: #cccccc" />
            </td>
        </tr>
        <tr>
            <td width="165" colspan="2">
                <div class="caption">
                    <asp:Label ID="lWorkflowInfo" runat="server" resourcekey="lWorkflowInfo"></asp:Label>
                </div>
            </td>
        </tr>
        <tr>
            <td width="165" colspan="2">
                <telerik:radgrid id="gvState" style="width: 640px; overflow-x: auto;" runat="server"
                    allowpaging="True" allowsorting="True" autogeneratecolumns="False" gridlines="None"
                    onneeddatasource="gvState_NeedDataSource" onitemdatabound="gvState_ItemDataBound">
                    <mastertableview datakeynames="StateID" nomasterrecordstext="No State">
                                                <RowIndicatorColumn>
                                                    <HeaderStyle></HeaderStyle>
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn>
                                                    <HeaderStyle></HeaderStyle>
                                                </ExpandCollapseColumn>
                                                <Columns>
                                                    <telerik:GridBoundColumn ItemStyle-Width="200" DataField="Name" HeaderText="State"
                                                        UniqueName="State">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn ItemStyle-Width="350" DataField="IsActive" HeaderText="Active"
                                                        UniqueName="Active">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridBoundColumn ItemStyle-Width="350" DataField="Notify" HeaderText="Notify"
                                                        UniqueName="Notify">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn UniqueName="Sortable">
                                                        <ItemTemplate>
                                                            <asp:Image ID="Sortable" runat="server" ImageUrl="~/DesktopModules/Mandeeps/WorkflowLibrary/Resources/Images/Sortable.png"
                                                                Style="cursor: move"></asp:Image>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="StateID" UniqueName="Edit">
                                                        <ItemTemplate>
                                                            <asp:ImageButton OnClick="EditState_Click" CssClass="SortItems" ID="Edit" runat="server"
                                                                ImageUrl="~/DesktopModules/Mandeeps/WorkflowLibrary/Resources/Images/Edit.gif"></asp:ImageButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="StateID" UniqueName="Delete">
                                                        <ItemTemplate>
                                                            <asp:ImageButton OnClick="DeleteState_Click" ID="Delete" runat="server"
                                                                ImageUrl="~/DesktopModules/Mandeeps/WorkflowLibrary/Resources/Images/delete.gif"></asp:ImageButton>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    
                                                </Columns>
                                                <EditFormSettings>
                                                    <EditColumn UniqueName="EditCommandColumn1">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </mastertableview>
                    <headercontextmenu enableautoscroll="True">
                                            </headercontextmenu>
                </telerik:radgrid>
            </td>
        </tr>
        <tr>
            <td width="165" colspan="2">
                <asp:LinkButton ID="lbAddNewState" Style="float: right" runat="server" CssClass="lnkbtn1"
                    ForeColor="Black" resourcekey="AddNewState" OnClick="AddNewState_Click" />
            </td>
        </tr>
    </table>
    <table id="AddNewStateTable" runat="server" width="100%" visible="false" cellpadding="5"
        cellspacing="5">
        <tr>
            <td width="165">
                <dnn:Label ID="lState" runat="server" HelpText="Name of the State." Suffix=":" ResourceKey="lState" />
            </td>
            <td>
                <asp:TextBox ID="tbState" runat="server" Width="290"></asp:TextBox>
            </td>
        </tr>
        <tr id="WorkflowNotifyRow" runat="server" visible="false">
            <td>
                <dnn:Label ID="lNotify" runat="server" HelpText="Name of the notify" Suffix=":" ResourceKey="lNotify" />
            </td>
            <td>
                <asp:CheckBox ID="cbNotify" runat="server" />
            </td>
        </tr>
        <tr id="WorkflowActiveRow" runat="server" visible="false">
            <td>
                <dnn:Label ID="lActive" runat="server" HelpText="Name of the active" Suffix=":" ResourceKey="lActive" />
            </td>
            <td>
                <asp:CheckBox ID="cbActive" runat="server" Checked="true" />
            </td>
        </tr>
        <tr id="PermissionRow" runat="server" visible="false">
            <td>
                <dnn:Label ID="lPermissions" runat="server" HelpText="Workflow Permissions" Suffix=":"
                    ResourceKey="lPermissions" />
            </td>
            <td>
                <Mandeeps:GenericPermissionsGrid ID="permWorkflow" runat="server" PermissionCode="MANDEEPS_WORKFLOW_LIBRARY"
                    PermissionKey="Review Content">
                </Mandeeps:GenericPermissionsGrid>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:LinkButton CssClass="lnkbtn1" ForeColor="White" ID="bAddState" runat="server" resourcekey="AddState"
                    OnClick="AddState_Click" />
                <asp:LinkButton CssClass="lnkbtn2" Font-Bold="true" ID="bCancelState" ForeColor="#003366" runat="server" resourcekey="CancelState"
                    OnClick="CancelState_Click" />
            </td>
        </tr>
    </table>
    <hr />
    <br />
    <asp:LinkButton ID="BacktoBasic" runat="server" CssClass="lnkbtn1" ForeColor="White"
        resourcekey="bBack" OnClick="bBack_Click"></asp:LinkButton>
</div>
