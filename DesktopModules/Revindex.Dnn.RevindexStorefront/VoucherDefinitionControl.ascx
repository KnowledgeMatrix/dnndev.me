<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VoucherDefinitionControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.VoucherDefinitionControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/BaseEditorControl.ascx" TagName="BaseEditorControl" TagPrefix="uc1" %>
<%@ Register Src="VoucherDefinitionPromotionRuleControl.ascx" TagName="VoucherDefinitionPromotionRuleControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<uc1:BaseEditorControl ID="BaseEditorControl1" runat="server" />
<asp:PlaceHolder runat="server">

    <script type="text/javascript">
        jQuery(document).ready(function ()
        {
            jQuery('#VoucherDefinitionDetailsViewTabPanel').dnnTabs();
        });
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
        {
            jQuery('#VoucherDefinitionDetailsViewTabPanel').dnnTabs();
        });
    </script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Voucher definitions</h2>
                    <div class="dnnForm rvdsfListContainer">
                        <asp:GridView ID="VoucherDefinitionGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="VoucherDefinitionID" OnRowDeleting="VoucherDefinitionGridView_RowDeleting" OnRowDataBound="VoucherDefinitionGridView_RowDataBound">
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
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
                                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                                <asp:BoundField DataField="StartDate" HeaderText="Start date" SortExpression="StartDate" DataFormatString="{0:yyyy-MM-dd}" />
                                <asp:BoundField DataField="StopDate" HeaderText="Stop date" SortExpression="StopDate" DataFormatString="{0:yyyy-MM-dd}" />
                            </Columns>
                        </asp:GridView>
                        <asp:ObjectDataSource ID="VoucherDefinitionObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.VoucherDefinitionController">
                            <SelectParameters>
                                <asp:Parameter Name="sortExpression" Type="String" />
                                <asp:Parameter Name="maximumRows" Type="Int32" />
                                <asp:Parameter Name="startRowIndex" Type="Int32" />
								<asp:Parameter Name="deleted" Type="Boolean" DefaultValue="false"></asp:Parameter>
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
                    <h2>Voucher definition: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
                    <div id="VoucherDefinitionDetailsViewTabPanel" class="dnnForm">
                        <ul class="dnnAdminTabNav dnnClear">
                            <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
                                <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
                            <li><a href="#<%= PromotionDetailsViewPanel.ClientID %>">
                                <asp:Label ID="PromotionDetailsViewTabLabel" runat="server" Text="Promotion" /></a></li>
                        </ul>
                        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="VoucherDefinitionIDLabelControl" runat="server" Text="Voucher Definition ID:" />
                                    <asp:Label runat="server" ID="VoucherDefinitionIDLabel"></asp:Label>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" CssClass="dnnFormRequired" />
                                    <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDefinitionDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="SalesPromotionDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
                                    <asp:TextBox ID="NameTextBox" runat="server" MaxLength="100" CssClass="dnnFormRequired"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="DescriptionLabelControl" runat="server" Text="Description:" />
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Rows="8" TextMode="MultiLine" MaxLength="4000"></asp:TextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="ActiveLabelControl" runat="server" Text="Active:" />
                                    <asp:CheckBox ID="ActiveCheckBox" runat="server" />
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="AmountLabelControl" runat="server" HelpText="Enter the voucher starting balance amount without the money symbol. (e.g. 10.50)" Text="Amount:" CssClass="dnnFormRequired"></dnn1:LabelControl>
                                    <asp:RequiredFieldValidator ID="AmountRequiredFieldValidator" runat="server" ControlToValidate="AmountDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDefinitionDetailsViewControl">Amount is required.</asp:RequiredFieldValidator>
                                    <dnn2:DnnNumericTextBox ID="AmountDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
                                    </dnn2:DnnNumericTextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StartDateLabelControl" runat="server" HelpText="Enter a start date when voucher is valid to be used. Leave blank if voucher is available immediately." Text="Start date:" />
                                    <dnn2:DnnDateTimePicker ID="StartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StopDateTypeLabelControl" runat="server" EnableViewState="False" HelpText="Enter a fixed stop date or calculated interval when voucher would expire from the issue date. Leave blank date or a zero interval value if voucher is available perpetually." Text="Stop date:" />
                                    <asp:RadioButtonList ID="StopDateTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="StopDateTypeRadioButtonList_SelectedIndexChanged" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
                                        <asp:ListItem Text="Fixed date" Value="Fixed date" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Interval" Value="Interval"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="StopDateLabelControl" runat="server" EnableViewState="False" HelpText="Enter a fixed stop date or calculated interval when voucher would expire from the issue date. Leave blank date or a zero interval value if voucher is available perpetually." Text="" />
                                    <asp:MultiView ID="StopDateTypeMultiView" runat="server" ActiveViewIndex="0">
                                        <asp:View ID="FixedStopDateView" runat="server">
                                            <dnn2:DnnDateTimePicker ID="StopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                            </dnn2:DnnDateTimePicker>
                                        </asp:View>
                                        <asp:View ID="ExpiryIntervalView" runat="server">
                                            <asp:RequiredFieldValidator ID="ExpiryRequiredFieldValidator" runat="server" ControlToValidate="ExpiryIntervalDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDefinitionDetailsViewControl">Expiry interval is required.</asp:RequiredFieldValidator>
                                            <dnn2:DnnNumericTextBox ID="ExpiryIntervalDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Value="0">
                                            </dnn2:DnnNumericTextBox>
                                            <asp:DropDownList ID="ExpiryIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
                                                <asp:ListItem Value="1">Day</asp:ListItem>
                                                <asp:ListItem Value="2">Week</asp:ListItem>
                                                <asp:ListItem Value="3">Month</asp:ListItem>
                                                <asp:ListItem Value="4">Year</asp:ListItem>
                                            </asp:DropDownList>
                                        </asp:View>
                                    </asp:MultiView>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="MaxRedemptionLabelControl" runat="server" HelpText="Empty value indicates voucher can be redeemed unlimited number of times." Text="Max redemption:"></dnn1:LabelControl>
                                    <dnn2:DnnNumericTextBox ID="MaxRedemptionDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" EnableSingleInputRendering="False" MinValue="1">
                                    </dnn2:DnnNumericTextBox>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PaymentLimitTypeLabelControl" runat="server" HelpText="The maximum amount that can be redeemed in a single order. By default, a voucher can be used to pay up to the limit of the total amount." Text="Payment limit:"></dnn1:LabelControl>
                                    <asp:RadioButtonList ID="PaymentLimitTypeRadioButtonList" runat="server" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
                                        <asp:ListItem Text="Sub total amount" Value="2" />
                                        <asp:ListItem Text="Total amount" Value="1" Selected="True" />
                                    </asp:RadioButtonList>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="TransferableLabelControl" runat="server" HelpText="Indicate if the issued voucher can be used by any user or only by the assigned user. If transferable, the issued voucher can be used by anyone who has knowledge of the voucher code." Text="Transferable:" />
                                    <asp:CheckBox ID="TransferableCheckBox" runat="server" />
                                </div>
                            </fieldset>
                        </asp:Panel>
                        <asp:Panel ID="PromotionDetailsViewPanel" runat="server" CssClass="dnnClear">
                            <fieldset>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PromotionStartDateLabelControl" runat="server" HelpText="Enter a start date when promotion on the voucher begins. Leave blank if promotion starts immediately." Text="Promotion start date:" />
                                    <dnn2:DnnDateTimePicker ID="PromotionStartDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                    </dnn2:DnnDateTimePicker>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PromotionStopDateTypeLabelControl" runat="server" EnableViewState="False" HelpText="Enter a fixed stop date or calculated interval when promotion would end from the issue date. Leave blank date or a zero interval value if promotion is available perpetually." Text="Promotion stop date:" />
                                    <asp:RadioButtonList ID="PromotionStopDateTypeRadioButtonList" runat="server" RepeatDirection="Horizontal" AutoPostBack="True" OnSelectedIndexChanged="PromotionStopDateTypeRadioButtonList_SelectedIndexChanged" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
                                        <asp:ListItem Text="Fixed date" Value="Fixed date" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Interval" Value="Interval"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                                <div class="dnnFormItem">
                                    <dnn1:LabelControl ID="PromotionStopDateLabelControl" runat="server" EnableViewState="False" HelpText="Enter a fixed stop date or calculated interval when promotion would end from the issue date. Leave blank date or a zero interval value if promotion is available perpetually." Text="" />
                                    <asp:MultiView ID="PromotionStopDateTypeMultiView" runat="server" ActiveViewIndex="0">
                                        <asp:View ID="FixedPromotionStopDateView" runat="server">
                                            <dnn2:DnnDateTimePicker ID="PromotionStopDateDnnDateTimePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd HH:mm" DateInput-EmptyMessage="YYYY-MM-DD HH:mm" CssClass="rvdDateTimeInput">
                                            </dnn2:DnnDateTimePicker>
                                        </asp:View>
                                        <asp:View ID="PromotionExpiryIntervalView" runat="server">
                                            <asp:RequiredFieldValidator ID="PromotionExpiryRequiredFieldValidator" runat="server" ControlToValidate="PromotionExpiryIntervalDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="VoucherDefinitionDetailsViewControl">PromotionExpiry interval is required.</asp:RequiredFieldValidator>
                                            <dnn2:DnnNumericTextBox ID="PromotionExpiryIntervalDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" CssClass="dnnFormRequired rvdQuantityInput" Value="0">
                                            </dnn2:DnnNumericTextBox>
                                            <asp:DropDownList ID="PromotionExpiryIntervalTypeDropDownList" runat="server" CssClass="rvdUnitInput">
                                                <asp:ListItem Value="1">Day</asp:ListItem>
                                                <asp:ListItem Value="2">Week</asp:ListItem>
                                                <asp:ListItem Value="3">Month</asp:ListItem>
                                                <asp:ListItem Value="4">Year</asp:ListItem>
                                            </asp:DropDownList>
                                        </asp:View>
                                    </asp:MultiView>
                                </div>
                                <uc1:VoucherDefinitionPromotionRuleControl ID="PromotionRuleControl" runat="server" Width="100%" />
                            </fieldset>
                        </asp:Panel>
                    </div>
                    <div class="dnnForm">
                        <ul class="dnnActions">
                            <li>
                                <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="VoucherDefinitionDetailsViewControl" />
                            </li>
                            <li>
                                <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="VoucherDefinitionDetailsViewControl" />
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
