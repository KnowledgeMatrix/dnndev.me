﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CouponControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CouponControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="CouponAvailabilityRuleControl.ascx" TagName="CouponAvailabilityRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#CouponDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
            jQuery('#CouponDetailsViewTabPanel').dnnTabs();
        });
    </script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Coupons</h2>
					<p>Coupons are simply special codes that you hand out to customers so they can in turn use to trigger a discount during checkout. Make sure to create a marketing promotion to tell the system what sort of discount to offer when a coupon code is detected.</p>
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="CouponGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CouponID" OnRowDeleting="CouponGridView_RowDeleting" OnRowDataBound="CouponGridView_RowDataBound">
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
                                <asp:BoundField DataField="Code" HeaderText="Code" SortExpression="Code" />
                                <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                                <asp:BoundField DataField="StartDate" HeaderText="Start date" SortExpression="StartDate" />
                                <asp:BoundField DataField="StopDate" HeaderText="Stop date" SortExpression="StopDate" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="CouponObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.CouponController">
                            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:Parameter Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />
                                <rvd1:UserControlParameter Name="portalID" PropertyName="PortalId" Type="Int32" />
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
                    <h2>Coupon: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div id="CouponDetailsViewTabPanel" class="dnnForm">
                        <ul class="dnnAdminTabNav dnnClear">
                            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                                <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                            <li><a href="#<%= AvailabilityDetailsViewPanel.ClientID %>">
                                <asp:Label ID="AvailabilityDetailsViewTabLabel" runat="server" Text="Availability" /></a></li>
                        </ul>
                        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CouponIDLabelControl" runat="server" Text="Coupon ID:" />
                                    <asp:Label runat="server" ID="CouponIDLabel"></asp:Label>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="CodeLabelControl" runat="server" Text="Code:" HelpText="Provide a coupon code to be given to users. Coupon code should only use alphanumeric characters and no space." CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="CodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="CouponDetailsViewControl">Code is required.</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="CodeTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="CouponDetailsViewControl">Code is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="CodeTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Rows="8" TextMode="MultiLine" MaxLength="4000"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ActiveLabelControl" runat="server" Text="Active:" HelpText="Enable or disable the coupon." />
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date (yyyy-mm-dd) to begin running coupon. Leave blank if coupon is available immediately." Text="Start date:" />
                                    <dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StopDateLabelControl" runat="server" EnableViewState="False" HelpText="Enter a stop date (yyyy-mm-dd) to end running coupon. Leave blank if coupon is available perpetually." Text="Stop date:" />
                                    <dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="InventoryLabelControl" runat="server" HelpText="Empty value indicates unlimited inventory on hand." Text="Inventory:" />
                                    <dnn2:DnnNumericTextBox ID="InventoryDnnNumericTextBox" runat="server" Skin="" Value="1000" MinValue="0" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False">
                                    </dnn2:DnnNumericTextBox>
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="AvailabilityDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <uc1:CouponAvailabilityRuleControl ID="AvailabilityRuleControl" runat="server" Width="100%" />
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <div class="dnnForm">
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CouponDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="CouponDetailsViewControl" />
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
