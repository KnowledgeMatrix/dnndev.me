<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductVariantBookingRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ProductVariantBookingRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="BookingRuleLabelControl" runat="server" Text="Exclude dates:" HelpText="Exclude any special dates from selection such as holidays or closing dates."></dnn1:LabelControl>
	<div class="rvdFormSubContainer">
		<asp:ListBox ID="SelectionListBox" runat="server" AutoPostBack="True" OnSelectedIndexChanged="SelectionListBox_SelectedIndexChanged" CssClass="rvdFormListBox"></asp:ListBox>
		<div class="rvdActions">
			<asp:LinkButton ID="AddSelectionLinkButton" runat="server" CausesValidation="False" Text="Add item" OnClick="AddSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" />
		</div>
		<asp:Panel ID="EditSelectionPanel" runat="server">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="StartDateLabelControl" runat="server" Text="Date:" CssClass="dnnFormRequired"/>
				<asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="StartDateDnnDatePicker" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ProductVariantBookingRuleDetailsViewControl">Date is required.</asp:RequiredFieldValidator>
				<dnn2:DnnDatePicker ID="StartDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD" CssClass="rvdDateTimeInput" >
				</dnn2:DnnDatePicker>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="RepeatLabelControl" runat="server" Text="Repeat:" HelpText="Determine if this special date should be repeated. For example, if you selected a date that falls on Monday and you set it to repeat Weekly, then every Monday in the future will be excluded." />
				<asp:DropDownList ID="RepeatDropDownList" runat="server">
					<asp:ListItem Text="Never" Value="" />
					<asp:ListItem Text="Daily" Value="day" />
					<asp:ListItem Text="Weekly" Value="week" />
					<asp:ListItem Text="Monthly" Value="month" />
					<asp:ListItem Text="Yearly" Value="year" />
				</asp:DropDownList>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="StopDateValueLabelControl" runat="server" Text="Until:" HelpText="Enter a date to stop repeating. Leave blank to repeat indefinitely." />
				<dnn2:DnnDatePicker ID="StopDateDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD" CssClass="rvdDateTimeInput" >
				</dnn2:DnnDatePicker>
			</div>
			<div class="rvdActions">
				<asp:LinkButton ID="SaveSelectionLinkButton" runat="server" Text="OK" OnClick="SaveSelectionLinkButton_Click" CssClass="dnnPrimaryAction rvdOKAction" ValidationGroup="ProductVariantBookingRuleDetailsViewControl" />
				<asp:LinkButton ID="DeleteLinkButton" runat="server" Text="Delete" OnClick="DeleteLinkButton_Click" CssClass="dnnSecondaryAction rvdDeleteAction" CausesValidation="False" />
			</div>
		</asp:Panel>
	</div>
</div>
