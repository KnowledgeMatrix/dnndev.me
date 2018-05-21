<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PackageControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.PackageControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<asp:MultiView ID="ContentMultiView" runat="server">
    <asp:View ID="ListView" runat="server">
        <h2>Packages</h2>
        <asp:Panel ID="SearchPanel" runat="server" CssClass="dnnForm rvdsfSearchContainer">
            <fieldset>
                <div class="dnnFormItem">
                    <dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
                    <dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
                </div>
            </fieldset>
        </asp:Panel>
        <div class="dnnForm rvdsfListContainer">
            <asp:GridView ID="PackageGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="PackageID" OnRowDeleting="PackageGridView_RowDeleting" OnRowDataBound="PackageGridView_RowDataBound">
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
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="PackageType" HeaderText="Type" />
                    <asp:BoundField DataField="Width" HeaderText="Width" SortExpression="Width" />
                    <asp:BoundField DataField="Height" HeaderText="Height" SortExpression="Height" />
                    <asp:BoundField DataField="Depth" HeaderText="Depth" SortExpression="Depth" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="PackageObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.PackageController">
                <SelectParameters>
                    <asp:Parameter Name="sortExpression" Type="String" />
                    <asp:Parameter Name="maximumRows" Type="Int32" />
                    <asp:Parameter Name="startRowIndex" Type="Int32" />
                    <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
                    <asp:ControlParameter ControlID="SellerSearchDnnComboBox" Name="sellerID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <ul class="dnnActions dnnClear">
                <li>
                    <asp:HyperLink ID="AddHyperLink" runat="server" Text="Add new" CssClass="dnnPrimaryAction rvdAddNewAction" />
                </li>
            </ul>
        </div>
    </asp:View>
    <asp:View ID="DetailsView" runat="server">
        <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction" />
        <h2>Package: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
        <div class="dnnForm">
            <fieldset>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="PackageIDLabelControl" runat="server" Text="Package ID:" />
                    <asp:Label ID="PackageIDLabel" runat="server"></asp:Label>
                </div>
                <asp:Panel ID="SellerPanel" runat="server" CssClass="dnnFormItem">
                    <dnn1:LabelControl ID="SellerLabelControl" runat="server" HelpText="Enter the name if this item belongs to a seller." Text="Seller:" />
                    <dnn2:DnnComboBox ID="SellerDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px"></dnn2:DnnComboBox>
                </asp:Panel>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" HelpText="Provide a name for this package (e.g. &quot;Medium box&quot;)" CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="PackageDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
                    <asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="PackageTypeLabelControl" runat="server" Text="Package type:" HelpText="Specify the type of packaging." />
                    <asp:DropDownList ID="PackageTypeDropDownList" runat="server">
                        <asp:ListItem Value="3000" Text="Bag"></asp:ListItem>
                        <asp:ListItem Value="2000" Text="Box"></asp:ListItem>
                        <asp:ListItem Value="1000" Text="Envelope"></asp:ListItem>
						<asp:ListItem Value="5000" Text="Pallet"></asp:ListItem>
                        <asp:ListItem Value="4000" Text="Tube"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Unspecified"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="WeightLabelControl" runat="server" Text="Weight ({0}):" HelpText="The weight of the package without the content." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="WeightRequiredFieldValidator" runat="server" ControlToValidate="WeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Weight is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="WeightRangeValidator" runat="server" ControlToValidate="WeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Weight is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="WeightTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="WidthLabelControl" runat="server" Text="Width ({0}):" HelpText="The external width of the package." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="WidthRequiredFieldValidator" runat="server" ControlToValidate="WidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="WidthRangeValidator" runat="server" ControlToValidate="WidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Width is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="WidthTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="HeightLabelControl" runat="server" Text="Height ({0}):" HelpText="The external height of the package." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="HeightRequiredFieldValidator" runat="server" ControlToValidate="HeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Height is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="HeightRangeValidator" runat="server" ControlToValidate="HeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Height is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="HeightTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="DepthLabelControl" runat="server" Text="Depth ({0}):" HelpText="The external depth of the package." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="DepthRequiredFieldValidator" runat="server" ControlToValidate="DepthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Depth is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="DepthRangeValidator" runat="server" ControlToValidate="DepthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Depth is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="DepthTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="InternalWidthLabelControl" runat="server" Text="Internal width ({0}):" HelpText="The internal width of the package where content will be stored. If you don't know this value, enter the same value as the external width." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="InternalWidthRequiredFieldValidator" runat="server" ControlToValidate="InternalWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Internal width is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="InternalWidthRangeValidator" runat="server" ControlToValidate="InternalWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Internal width is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="InternalWidthTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="InternalHeightLabelControl" runat="server" Text="Internal height ({0}):" HelpText="The internal height of the package where content will be stored. If you don't know this value, enter the same value as the external height." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="InternalHeightRequiredFieldValidator" runat="server" ControlToValidate="InternalHeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Internal height is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="InternalHeightRangeValidator" runat="server" ControlToValidate="InternalHeightTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Internal height is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="InternalHeightTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="InternalDepthLabelControl" runat="server" Text="Internal depth ({0}):" HelpText="The internal depth of the package where content will be stored. If you don't know this value, enter the same value as the external depth." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="InternalDepthRequiredFieldValidator" runat="server" ControlToValidate="InternalDepthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Internal depth is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="InternalDepthRangeValidator" runat="server" ControlToValidate="InternalDepthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Internal depth is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="InternalDepthTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="MaxWeightCapacityLabelControl" runat="server" Text="Max weight capacity ({0}):" HelpText="The maximum weight this package is rated to hold. If you don't know this value, enter an arbitrary large number." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="MaxWeightCapacityRequiredFieldValidator" runat="server" ControlToValidate="MaxWeightCapacityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Max weight capacity is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="MaxWeightCapacityRangeValidator" runat="server" ControlToValidate="MaxWeightCapacityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="0" Type="Double" ValidationGroup="PackageDetailsViewControl">Max weight capacity is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="MaxWeightCapacityTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="MaxQuantityCapacityLabelControl" runat="server" Text="Max quantity capacity:" HelpText="The maximum quantity of items this package is rated to hold. If you don't know this value, enter an arbitrary large number." CssClass="dnnFormRequired" />
                    <asp:RequiredFieldValidator ID="MaxQuantityCapacityRequiredFieldValidator" runat="server" ControlToValidate="MaxQuantityCapacityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="PackageDetailsViewControl">Max quantity capacity is required.</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="MaxQuantityCapacityRangeValidator" runat="server" ControlToValidate="MaxQuantityCapacityTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000000000" MinimumValue="1" Type="Double" ValidationGroup="PackageDetailsViewControl">Max quantity capacity is invalid.</asp:RangeValidator>
                    <asp:TextBox ID="MaxQuantityCapacityTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                </div>
                <div class="dnnFormItem">
                    <dnn1:LabelControl ID="ShippingCodeLabelControl" runat="server" Text="Shipping code:" HelpText="Shipping code may be used by your shipping provider to classify this package to obtain a more accurate quote. Leave blank if you don't have a shipping code. For example, the freight class code 50, as governed by the NMFC, indicates the package is durable enough to fit on a 4x4 pallet." />
                    <asp:TextBox ID="ShippingCodeTextBox" runat="server" MaxLength="50"></asp:TextBox>
                </div>
            </fieldset>
            <ul class="dnnActions">
                <li>
                    <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="PackageDetailsViewControl" />
                </li>
                <li>
                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="PackageDetailsViewControl" />
                </li>
                <li>
                    <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel" />
                </li>
            </ul>
        </div>
    </asp:View>
</asp:MultiView>

