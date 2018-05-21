<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RelatedProductControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.RelatedProductControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <div class="dnnForm">
                <fieldset>
                    <div class="dnnFormItem">
                        <dnn1:LabelControl ID="SearchLabelControl" runat="server" Text="Search product:" />
                        <div class="rvdFormSubContainer">
                            <dnn2:DnnComboBox ID="SearchProductDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SearchProductDnnComboBox_ItemsRequested" AutoPostBack="false" CausesValidation="False" MaxHeight="200px">
                            </dnn2:DnnComboBox>
                            <asp:LinkButton ID="AddLinkButton" runat="server" CssClass="dnnPrimaryAction rvdAddAction" Text="Add relation" OnClick="AddLinkButton_Click" />
                            <asp:CheckBox ID="BidirectionalAddCheckBox" runat="server" Text="Relate both ways" Checked="true" />
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="dnnFormItem">
                        <dnn1:LabelControl ID="RelatedLabelControl" runat="server" Text="" />
                        <asp:DataList ID="RelatedProductDataList" runat="server" OnItemCommand="RelatedProductDataList_ItemCommand" OnItemDataBound="RelatedProductDataList_ItemDataBound">
                            <ItemTemplate>
                                <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction" CommandArgument='<%# Eval("ProductID")%>'></asp:LinkButton>
                                <span><a href='<%# Eval("Url") %>'><%# Eval("Name") %></a></span>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>
                </fieldset>
            </div>
            <div class="dnnForm">
                <ul class="dnnActions dnnClear">
                    <li>
                        <asp:HyperLink ID="ImportHyperLink" runat="server" Text="Import" CssClass="dnnSecondaryAction rvdImportAction" />
                    </li>
                    <li>
                        <asp:HyperLink ID="ExportViewHyperLink" runat="server" Text="Export view" CssClass="dnnSecondaryAction rvdExportAction" />
                    </li>
                    <li>
                        <asp:HyperLink ID="ExportAllHyperLink" runat="server" Text="Export all" CssClass="dnnSecondaryAction rvdExportAction" />
                    </li>
                </ul>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
