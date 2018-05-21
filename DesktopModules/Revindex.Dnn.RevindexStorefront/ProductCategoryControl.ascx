<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCategoryControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductCategoryControl" %>
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
                            <asp:LinkButton ID="AddLinkButton" runat="server" CssClass="dnnPrimaryAction rvdAddAction" Text="Add product" OnClick="AddLinkButton_Click" />
                        </div>
                    </div>
                </fieldset>
                <fieldset>
                    <div class="dnnFormItem">
                        <dnn1:LabelControl ID="ProductCategoryLabelControl" runat="server" Text="" />
                        <div class="rvdFormSubContainer">
                            <asp:ListBox runat="server" ID="ProductCategoryListBox" SelectionMode="Multiple" CssClass="rvdFormListBox"></asp:ListBox>
                            <asp:LinkButton ID="RemoveLinkButton" runat="server" Text="Remove selected product" OnClick="RemoveLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdExcludeAction" />
                        </div>
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
