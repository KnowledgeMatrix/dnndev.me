<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecurityConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SecurityConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>Security</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
    <fieldset>
        <asp:Panel ID="SecuritySellerRolePanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecuritySellerRoleLabelControl" runat="server" Text="Seller role:" HelpText="Choose the role that will be assigned to the registered seller and needed to access seller resources." />
            <asp:ListBox ID="SecuritySellerRoleListBox" runat="server" CssClass="rvdFormListBox">
            </asp:ListBox>
        </asp:Panel>
        <asp:Panel ID="SecurityAllowedProductRolePanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecurityAllowedProductRoleLabelControl" runat="server" Text="Allowed roles:" HelpText="List of allowable roles for action assignment. Use CTRL + mouse click to select multiple items." />
            <asp:ListBox ID="SecurityAllowedProductRoleListBox" runat="server" CssClass="rvdFormListBox" SelectionMode="Multiple">
            </asp:ListBox>
        </asp:Panel>
        <asp:Panel ID="SecurityAllowedProductRoleGroupPanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecurityAllowedProductRoleGroupLabelControl" runat="server" Text="Allowed role groups:" HelpText="List of allowable role groups for action assignment. Use CTRL + mouse click to select multiple items." />
            <asp:ListBox ID="SecurityAllowedProductRoleGroupListBox" runat="server" CssClass="rvdFormListBox" SelectionMode="Multiple">
            </asp:ListBox>
        </asp:Panel>
        <asp:Panel ID="SecurityActionSqlActivePanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecurityActionSqlActiveLabelControl" runat="server" Text="Allow SQL in action rules:" HelpText="Allow action rules to execute SQL queries. The user who makes the modifications to your action rules will potentially be able to access any data in or across your Web portal(s)." />
            <asp:CheckBox ID="SecurityActionSqlActiveCheckBox" runat="server" />
        </asp:Panel>
        <asp:Panel ID="SecurityDisplayTemplateServerCodeActivePanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecurityDisplayTemplateServerCodeActiveLabelControl" runat="server" Text="Allow display template server code edit:" HelpText="Allow server-side code modification to the custom display template. The user who makes the modifications to your display template will potentially be able to access any data in or across your Web portal(s)." />
            <asp:CheckBox ID="SecurityDisplayTemplateServerCodeActiveCheckBox" runat="server" />
        </asp:Panel>
		<asp:Panel ID="SecurityReportCustomActivePanel" runat="server" CssClass="dnnFormItem">
            <dnn1:LabelControl ID="SecurityReportCustomActiveLabelControl" runat="server" Text="Allow custom reports:" HelpText="The user who creates or makes the modifications to your custom reports will potentially be able to access, write and delete any data in or across your Web portal(s)." />
            <asp:CheckBox ID="SecurityReportCustomActiveCheckBox" runat="server" />
        </asp:Panel>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="SecurityEncryptionKeyLabelControl" runat="server" Text="Encryption key:" HelpText="This key is used to encrypt all sensitive data (e.g. credit card numbers, etc.) and should be kept private. Enter some text between 6 and 20 characters long to change key." CssClass="dnnFormRequired" />
            <div class="rvdFormSubContainer">
                <asp:Panel ID="SecurityEncryptionKeyPanel" runat="server" Visible="False">
                    <div class="dnnFormItem">
                        <asp:TextBox ID="SecurityEncryptionKeyTextBox" runat="server" MaxLength="20" CssClass="dnnFormRequired"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="SecurityEncryptionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Encryption key is required.</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="SecurityEncryptionKeyTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^[\S]{6,20}$" ValidationGroup="ConfigurationDetailsViewControl">Encryption key is invalid.</asp:RegularExpressionValidator>
                    </div>
                    <asp:Label ID="SecurityEncryptionKeyWarningLabel" runat="server" Text="All previously encrypted data will be re-saved with the new encryption key. This process could take several minutes to complete. It is recommended to take a full backup before running this operation." CssClass="dnnFormMessage dnnFormWarning" />
                </asp:Panel>
                <asp:LinkButton ID="ChangeEncryptionKeyLinkButton" runat="server" CausesValidation="False" OnClick="ChangeEncryptionKeyLinkButton_Click" CssClass="dnnSecondaryAction">Change</asp:LinkButton>
            </div>
        </div>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="SecurityStoreACHLabelControl" runat="server" Text="Store ACH:" />
            <asp:CheckBox ID="SecurityStoreACHCheckBox" runat="server" />
            <asp:LinkButton ID="DeleteACHLinkButton" runat="server" CausesValidation="False" OnClick="DeleteACHLinkButton_Click" CssClass="dnnSecondaryAction" OnClientClick="return confirm('Are you sure you want to delete all data?')">Delete data</asp:LinkButton>
        </div>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="SecurityStoreCreditCardLabelControl" runat="server" Text="Store credit card:" />
            <asp:CheckBox ID="SecurityStoreCreditCardCheckBox" runat="server" />
            <asp:LinkButton ID="DeleteCreditCardLinkButton" runat="server" CausesValidation="False" OnClick="DeleteCreditCardLinkButton_Click" CssClass="dnnSecondaryAction" OnClientClick="return confirm('Are you sure you want to delete all data?')">Delete data</asp:LinkButton>
        </div>
        <div class="dnnFormItem">
            <dnn1:LabelControl ID="SecurityStoreCreditCardVerificationLabelControl" runat="server" Text="Store credit card verification:" HelpText="Allow the system to store the credit card CVV information. You should only enable this feature when using with test credit cards on your development site and not in actual production." />
            <asp:CheckBox ID="SecurityStoreCreditCardVerificationCheckBox" runat="server" />
            <asp:LinkButton ID="DeleteCreditCardVerificationLinkButton" runat="server" CausesValidation="False" OnClick="DeleteCreditCardVerificationLinkButton_Click" CssClass="dnnSecondaryAction" OnClientClick="return confirm('Are you sure you want to delete all data?')">Delete data</asp:LinkButton>
        </div>
    </fieldset>
    <ul class="dnnActions">
        <li>
            <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
    </ul>
</div>
