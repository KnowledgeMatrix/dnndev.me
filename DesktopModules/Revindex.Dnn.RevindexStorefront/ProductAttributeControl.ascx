<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductAttributeControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductAttributeControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="ProductAttributeGridView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" OnRowDeleting="ProductAttributeGridView_RowDeleting" CssClass="dnnGrid" GridLines="None" DataKeyNames="ProductAttributeID" OnPageIndexChanging="ProductAttributeGridView_PageIndexChanging" OnSorting="ProductAttributeGridView_Sorting" OnRowDataBound="ProductAttributeGridView_RowDataBound">
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
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Name" HeaderText="Attribute" SortExpression="Name" />
                                <asp:BoundField DataField="Value" HeaderText="Value" />
                            </Columns>
                        </asp:GridView>
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                            </li>
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
                </asp:View>
                <asp:View ID="DetailsView" runat="server">
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
                    <h2>Attribute: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div class="dnnForm">
                        <fieldset>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="ProductAttributeIDLabelControl" runat="server" Text="Product Attribute ID:" />
                                <asp:Label ID="ProductAttributeIDLabel" runat="server"></asp:Label>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="ProductAttributeDefinitionLabelControl" runat="server" Text="Product Attribute Definition:" />
                                <asp:DropDownList ID="ProductAttributeDefinitionDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ProductAttributeDefinitionDropDownList_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="dnnFormItem">
                                <dnn1:LabelControl ID="ValueLabelControl" runat="server" Text="Value:" />
                                <asp:RangeValidator ID="IntegerRangeValidator" runat="server" ControlToValidate="IntegerValueTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2147483647" MinimumValue="-2147483648" Type="Integer" ValidationGroup="ProductAttributeDetailsViewControl">Integer value is invalid.</asp:RangeValidator>
                                <asp:RangeValidator ID="DecimalRangeValidator" runat="server" ControlToValidate="DecimalValueTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="9999999" MinimumValue="-99999999" Type="Double" ValidationGroup="ProductAttributeDetailsViewControl">Decimal value is invalid.</asp:RangeValidator>
                                <asp:DropDownList ID="BooleanValueDropDownList" runat="server">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem Value="1">Yes</asp:ListItem>
                                    <asp:ListItem Value="0">No</asp:ListItem>
                                </asp:DropDownList>
                                <dnn1:TextEditor ID="StringValueTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Mode="RICH" Width="100%" Height="250px" />
                                <asp:TextBox ID="IntegerValueTextBox" runat="server"></asp:TextBox>
                                <asp:CheckBoxList ID="SelectionValueCheckBoxList" runat="server">
                                </asp:CheckBoxList>
                                <asp:TextBox ID="DecimalValueTextBox" runat="server"></asp:TextBox>
                            </div>
                        </fieldset>
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ProductAttributeDetailsViewControl" />
                            </li>
                            <li>
                                <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                            </li>
                        </ul>
                    </div>
                </asp:View>
            </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
</div>
