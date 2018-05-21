<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReviewWork.ascx.cs"
    Inherits="Mandeeps.DNN.Library.Workflow.UI.ReviewWork" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<style type="text/css">
.mbutton2 {font-weight: bold;padding: 8px;text-decoration: none; color:#003366;}
.mbutton2:hover {text-decoration:underline; color:#000}
</style>
<div id="PlaceHolder" runat="server">
    <table width="100%" cellpadding="3" cellspacing="3">
        <tr>
            <td width="180px" align="left">
                <dnn:label id="lContentType" runat="server" helptext="Content Type." suffix=":" resourcekey="lContentType" />
            </td>
            <td>
                <asp:DropDownList ID="ddlContentType" runat="server" Width="150" OnSelectedIndexChanged="ddlContentType_SelectedIndexChanged"
                    AutoPostBack="true">
                    <asp:ListItem Text="All" Value="all" Selected="True"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label id="lWorkflow" runat="server" helptext="Workflow" suffix=":" resourcekey="lWorkflow" />
            </td>
            <td>
                <asp:DropDownList ID="ddlWorkflow" CssClass="ddl" runat="server" Width="150" OnSelectedIndexChanged="ddlWorkflow_SelectedIndexChanged"
                    AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <dnn:label id="lWorkflowStates" runat="server" helptext="Workflow States" suffix=":"
                    resourcekey="lWorkflowStates" />
            </td>
            <td>
                <asp:DropDownList ID="ddlWorkflowStates" CssClass="ddl" runat="server" Width="150" OnSelectedIndexChanged="ddlWorkflowStates_SelectedIndexChanged"
                AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <br />
    <telerik:RadGrid ID="gvWorkflowReviewDetail" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" OnNeedDataSource="gvWorkflowReviewDetail_NeedDataSource"
        OnItemDataBound="gvWorkflowReviewDetail_ItemDataBound">
        <MasterTableView datakeynames="ContentID">
                    <RowIndicatorColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </RowIndicatorColumn>
                    <ExpandCollapseColumn>
                        <HeaderStyle Width="20px"></HeaderStyle>
                    </ExpandCollapseColumn>
                    <Columns>
                        <telerik:GridBoundColumn HeaderText="ContentType" UniqueName="ContentType">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="Title" UniqueName="Title">
                            <ItemTemplate>
                                <asp:LinkButton OnClick="Titlelink_Click" ID="lbTitle"  runat="server">Title</asp:LinkButton>&nbsp;<br />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                        <telerik:GridBoundColumn HeaderText="Workflow" UniqueName="Workflow">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn HeaderText="State" UniqueName="State">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
    </telerik:RadGrid>
    <br />
    <asp:LinkButton ID="bHtmlCancel" runat="server" CssClass="mbutton2" resourceKey="bHtmlCancel"
                            OnClick="bHtmlCancel_Click"></asp:LinkButton>
</div>
