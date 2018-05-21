<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LicenseSetControl.ascx.cs" Inherits="Revindex.Web.UI.WebUserControls.Dnn.LicenseSetControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<div>
	<asp:GridView ID="LicenseGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowSorting="False" AutoGenerateColumns="False" AllowPaging="False" OnSelectedIndexChanged="LicenseGridView_SelectedIndexChanged" DataKeyNames="ProductLicenseGUID" OnRowDeleting="LicenseGridView_RowDeleting">
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
					<asp:LinkButton ID="DeleteLinkButtonFieldTaskGridView" runat="server" CommandName="Delete" CausesValidation="False" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
				</ItemTemplate>
			</asp:TemplateField>
			<asp:BoundField DataField="ProductLicenseGUID" HeaderText="GUID" />
			<asp:BoundField DataField="ProductName" HeaderText="Product name" />
			<asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
		</Columns>
	</asp:GridView>
	<ul class="dnnActions dnnClear">
		<li>
			<asp:LinkButton ID="AddLinkButton" runat="server" OnClick="AddLinkButton_Click" CssClass="dnnPrimaryAction">Add new</asp:LinkButton></li>
	</ul>
	<asp:PlaceHolder ID="MessagePlaceHolder" runat="server"></asp:PlaceHolder>
	<asp:Panel ID="DetailsViewPanel" runat="server" CssClass="dnnForm">
		<fieldset>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductLicenseGUIDLabelControl" runat="server" Text="GUID:" />
				<asp:Label ID="ProductLicenseGUIDLabel" runat="server" Text=""></asp:Label>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="LicenseKeyLabelControl" runat="server" Text="License key:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LicenseKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="LicenseControl">License key is required.</asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="LicenseKeyTextBox" CssClass="dnnFormMessage dnnFormError" Text="Invalid license key entered. The license key is a very long string. Please make sure you are entering the actual license key and not the license GUID." ValidationGroup="LicenseControl" ValidationExpression="^[A-Za-z0-9+=/|]{60,}$"></asp:RegularExpressionValidator>
				<asp:TextBox ID="LicenseKeyTextBox" runat="server" Rows="10" TextMode="MultiLine" CssClass="dnnFormRequired"></asp:TextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ProductNameLabelControl" runat="server" Text="Product name:" />
				<asp:Label ID="ProductNameLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="EditionLabelControl" runat="server" Text="Edition:" />
				<asp:Label ID="EditionLabel" runat="server"></asp:Label>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="VersionLabelControl" runat="server" Text="Version:" />
				<asp:Label ID="VersionLabel" runat="server"></asp:Label>
			</div>
			<asp:Panel ID="ActivatedPanel" runat="server" CssClass="dnnFormItem">
				<dnn1:LabelControl ID="ActivatedLabelControl" runat="server" Text="Activated:" />
				<asp:CheckBox ID="ActivatedCheckBox" runat="server" Enabled="False" />
			</asp:Panel>
		</fieldset>
		<ul class="dnnActions dnnClear">
			<li>
				<asp:LinkButton ID="SaveLinkButton" runat="server" OnClick="SaveLinkButton_Click" Text="Save" ValidationGroup="LicenseControl" CssClass="dnnPrimaryAction" /></li>
		</ul>
		<asp:Panel ID="ActivationPanel" runat="server" CssClass="dnnForm">
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ActivationLabelControl" runat="server" Text="Activation:" />
				<span>This license key requires activation. If you are setting up another instance with a license key that you have already activated for the same machine, use the manual activation step and enter the activation key instead.</span>
			</div>
			<asp:MultiView ID="ActivationMultiView" runat="server" ActiveViewIndex="0">
				<asp:View ID="AutomaticActivationView" runat="server">
					<ul class="dnnActions dnnClear">
						<li>
							<asp:LinkButton ID="AutomaticActivateLinkButton" runat="server" OnClick="AutomaticActivateLinkButton_Click" Text="Activate license now" CssClass="dnnPrimaryAction" /></li>
						<li>
							<asp:LinkButton ID="ManualActivationLinkButton" runat="server" OnClick="ManualActivationLinkButton_Click" CssClass="dnnSecondaryAction">Perform manual activation</asp:LinkButton></li>
					</ul>
				</asp:View>
				<asp:View ID="ManualActivationView" runat="server">
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="ActivationRequestLabelControl" runat="server" Text="Activation request:" />
						<asp:TextBox ID="ActivationRequestTextBox" runat="server" BackColor="#EEEEEE" ReadOnly="True" Rows="5" TextMode="MultiLine"></asp:TextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="ActivationKeyLabelControl" runat="server" Text="Activation key:" CssClass="dnnFormRequired" />
						<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ActivationKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ManualActivationControl">Activation key is required.</asp:RequiredFieldValidator>
						<asp:TextBox ID="ActivationKeyTextBox" runat="server" Rows="5" TextMode="MultiLine" CssClass="dnnFormRequired"></asp:TextBox>
					</div>
					<ul class="dnnActions dnnClear">
						<li>
							<asp:LinkButton ID="ManualActivateLinkButton" runat="server" OnClick="ManualActivateLinkButton_Click" Text="Activate" ValidationGroup="ManualActivationControl" CssClass="dnnPrimaryAction" /></li>
						<li>
							<asp:LinkButton ID="AutomaticActivationLinkButton" runat="server" OnClick="AutomaticActivationLinkButton_Click" CssClass="dnnSecondaryAction">Use instant activation</asp:LinkButton></li>
					</ul>
				</asp:View>
			</asp:MultiView>
		</asp:Panel>
	</asp:Panel>
</div>
