<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CheckoutConfigurationDynamicFormCodeControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.CheckoutConfigurationDynamicFormCodeControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/DynamicFormCodeEditorControl.ascx" TagName="DynamicFormCodeEditorControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/BasicDynamicFormDetailsViewControl.ascx" TagName="BasicDynamicFormDetailsViewControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="CodeTypeLabelControl" runat="server" Text="Dynamic form:" HelpText="Add custom fields to the checkout page to capture additional data using checkbox, dropdownlist, fileupload, textbox, etc." />
	<asp:DropDownList ID="CodeTypeDropDownList" runat="server" OnSelectedIndexChanged="CodeTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None" Value=""></asp:ListItem>
		<asp:ListItem Text="Basic" Value="BasicDynamicFormView"></asp:ListItem>
		<asp:ListItem Text="Custom code (OBSOLETE: Please create/migrate using Basic type)" Value="CustomCodeView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="BasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FieldBasicDynamicFormLabelControl" runat="server" Text="Fields:" HelpText="Form fields to display." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="FieldBasicDynamicFormMessagePlaceHolder" runat="server" />
				<asp:GridView ID="FieldBasicDynamicFormGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="ID" OnRowDeleting="FieldBasicDynamicFormGridView_RowDeleting" OnSelectedIndexChanged="FieldBasicDynamicFormGridView_SelectedIndexChanged" OnRowCommand="FieldBasicDynamicFormGridView_RowCommand" OnRowCreated="FieldBasicDynamicFormGridView_RowCreated">
					<AlternatingRowStyle CssClass="dnnGridAltItem" />
					<HeaderStyle CssClass="dnnGridHeader" />
					<RowStyle CssClass="dnnGridItem" />
					<SelectedRowStyle CssClass="dnnGridSelectedItem" />
					<FooterStyle CssClass="dnnGridFooter" />
					<PagerStyle CssClass="dnnGridPager" />
					<Columns>
                        <asp:CommandField ShowSelectButton="True" SelectText="" ControlStyle-CssClass="rvdEditGridAction" />
                        <asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="DeleteLinkButton" runat="server" CausesValidation="false" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
							</ItemTemplate>
						</asp:TemplateField>
                        <asp:TemplateField>
							<ItemTemplate>
								<asp:LinkButton ID="MoveUpLinkButton" runat="server" CausesValidation="false" CommandName="MoveUp" CssClass="rvdUpGridAction" />
								<asp:LinkButton ID="MoveDownLinkButton" runat="server" CausesValidation="false" CommandName="MoveDown" CssClass="rvdDownGridAction" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="ID" HeaderText="ID" />
						<asp:BoundField DataField="Type" HeaderText="Type" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddFieldBasicDynamicFormLinkButton" runat="server" Text="Add new" OnClick="AddFieldBasicDynamicFormLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="FieldBasicDynamicFormDetailsViewPanel" runat="server" CssClass="dnnForm">
					<fieldset>
						<uc1:BasicDynamicFormDetailsViewControl id="FieldBasicDynamicFormDetailsViewControl" runat="server" ValidationGroup="FieldBasicDynamicFormDetailsViewControl" />
					</fieldset>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveFieldBasicDynamicFormLinkButton" runat="server" Text="OK" OnClick="SaveFieldBasicDynamicFormLinkButton_Click" ValidationGroup="FieldBasicDynamicFormDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="CustomCodeView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DynamicFormLabelControl" runat="server" Text="ASP.NET/HTML code:" HelpText="Add HTML, Javascript and ASP.NET controls to present to the customer on the checkout page. When using ASP.NET control, make sure the ID is unique by prefixing it with a word to avoid conflicting with other controls on the page." />
			<uc1:DynamicFormCodeEditorControl ID="DynamicFormCodeEditor" runat="server" Width="100%" ModuleControl="Checkout" />
		</div>
	</asp:View>
</asp:MultiView>