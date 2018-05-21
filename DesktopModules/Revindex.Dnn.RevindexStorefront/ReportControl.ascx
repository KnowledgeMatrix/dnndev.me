<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ReportControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:MultiView ID="ContentMultiView" runat="server">
    <asp:View ID="ListView" runat="server">
        <h2>Reports</h2>
        <div class="dnnForm rvdsfListContainer">
            <asp:GridView ID="ReportDefinitionGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="ReportDefinitionID" Width="100%" AllowPaging="False" OnRowDataBound="ReportDefinitionGridView_RowDataBound">
                <AlternatingRowStyle CssClass="dnnGridAltItem" />
                <HeaderStyle CssClass="dnnGridHeader" />
                <RowStyle CssClass="dnnGridItem" />
                <SelectedRowStyle CssClass="dnnGridSelectedItem" />
                <FooterStyle CssClass="dnnGridFooter" />
                <PagerStyle CssClass="dnnGridPager" />
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HyperLink ID="SelectHyperLink" runat="server" CssClass="rvdEditGridAction" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="ReportDefinitionObjectDataSource" runat="server" EnablePaging="False" SelectCountMethod="GetActiveReportDefinitionsCount" SelectMethod="GetActiveReportDefinitions" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ReportDefinitionController" DataObjectTypeName="Revindex.Business.Revindex.Revindex.Storefront.ReportDefinition">
                <SelectParameters>
                    <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                    <rvd1:UserControlParameter Name="reportGroup" PropertyName="ReportGroup" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>

    </asp:View>
    <asp:View ID="DetailsView" runat="server">
        <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
        <h2>Report: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
        <p><asp:Label ID="DescriptionLabel" runat="server" Text="" /></p>
        <div class="dnnForm rvdsfSearchContainer">
            <fieldset>
                <asp:ListView ID="DynamicFormListView" runat="server" GroupItemCount="1" OnItemCreated="DynamicFormListView_ItemCreated">
                    <LayoutTemplate>
                        <div runat="server" id="groupPlaceholder" />
                    </LayoutTemplate>
                    <GroupTemplate>
                        <div runat="server" id="itemPlaceholder" />
                    </GroupTemplate>
                    <ItemTemplate>
                        <div class="dnnFormItem rvdsfDynamicFormItem">
                            <asp:PlaceHolder ID="LabelDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
                            <asp:PlaceHolder ID="ValidatorDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
                            <asp:PlaceHolder ID="InputControlDynamicFormPlaceHolder" runat="server"></asp:PlaceHolder>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
            </fieldset>
            <ul class="dnnActions">
                <li>
                    <asp:LinkButton ID="ViewLinkButton" runat="server" Text="View report" OnClick="ViewLinkButton_Click" ValidationGroup="ReportControlDetailsView" CssClass="dnnPrimaryAction" />
                </li>
                <li>
                    <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                </li>
            </ul>
        </div>
        <div class="dnnForm">
            <fieldset>
                <asp:Literal ID="HtmlReportLiteral" runat="server"></asp:Literal>
            </fieldset>
        </div>
    </asp:View>
</asp:MultiView>
