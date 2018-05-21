<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DynamicFormResultEditorControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.DynamicFormResultEditorControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<asp:Panel runat="server" ID="DynamicFormResultEditorPanel" CssClass="rvdsfFormDynamicFormResultEditor">
	<asp:ListView ID="DynamicFormResultListView" runat="server">
		<LayoutTemplate>
			<fieldset>
				<div runat="server" id="itemPlaceHolder" />
			</fieldset>
		</LayoutTemplate>
		<ItemTemplate>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="IDLabelControl" runat="server" Text='<%# String.Format("{0}:", Eval("IDLabelControl_Text")) %>'></dnn1:LabelControl>
				<asp:TextBox ID="ValueTextBox" runat="server" Text='<%# Eval("ValueTextBox_Text") %>' FieldID='<%# Eval("ValueTextBox_FieldID") %>' TextMode="MultiLine" ControlType='<%# Eval("ValueTextBox_ControlType") %>' />
				<asp:HyperLink ID="DownloadHyperLink" runat="server" Text="" NavigateUrl='<%# Eval("DownloadHyperLink_NavigateUrl") %>' Visible='<%# Convert.ToBoolean(Eval("DownloadHyperLink_Visible")) %>' CssClass="rvdViewGridAction" Target="_blank" />
			</div>
		</ItemTemplate>
	</asp:ListView>
</asp:Panel>
