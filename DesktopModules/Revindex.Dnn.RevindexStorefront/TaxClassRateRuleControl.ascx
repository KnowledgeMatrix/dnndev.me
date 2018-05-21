<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TaxClassRateRuleControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.TaxClassRateRuleControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="WebUserControls/FormulaEditorControl.ascx" TagName="FormulaEditorControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="RuleTypeLabelControl" runat="server" Text="Rate rule:" />
	<asp:DropDownList ID="RuleTypeDropDownList" runat="server" OnSelectedIndexChanged="RuleTypeDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="None - zero amount" Value=""></asp:ListItem>
		<asp:ListItem Text="Europe VAT - follow standard EU regulations" Value="EuropeVATView"></asp:ListItem>
        <asp:ListItem Text="Europe VAT MOSS - follow EU regulations based on customer location" Value="EuropeVATMOSSView"></asp:ListItem>
		<asp:ListItem Text="Flat rate - based on sales amount" Value="FlatRateView"></asp:ListItem>
		<asp:ListItem Text="Regional rate - based on customer location" Value="RegionalRateView"></asp:ListItem>
		<asp:ListItem Text="Custom rule" Value="CustomRuleView"></asp:ListItem>
	</asp:DropDownList>
</div>
<asp:MultiView ID="FormulaMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="EuropeVATView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate1EuropeVATLabelControl" runat="server" Text="Tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="TaxRate1EuropeVATRequiredFieldValidator" runat="server" ControlToValidate="TaxRate1EuropeVATDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="TaxRate1EuropeVATDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
    <asp:View ID="EuropeVATMOSSView" runat="server">
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ATTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Austria tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ATTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="ATTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ATTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="BETaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Belgium tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BETaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="BETaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BETaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="BGTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Bulgaria tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="BGTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="BGTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="BGTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CZTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Czech Republic tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="CZTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="CZTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="CZTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="HRTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Croatia tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="HRTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="HRTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="HRTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="CYTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Cyprus tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="CYTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="CYTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="CYTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="DKTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Denmark tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DKTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="DKTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DKTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="EETaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Estonia tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="EETaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="EETaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="EETaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="FITaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Finland tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="FITaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="FITaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="FITaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="FRTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="France tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="FRTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="FRTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="FRTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="DETaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Germany tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="DETaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="DETaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="DETaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GRTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Greece tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GRTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="GRTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="GRTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="HUTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Hungary tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="HUTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="HUTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="HUTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="IETaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Ireland tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="IETaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="IETaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="IETaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ITTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Italy tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ITTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="ITTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ITTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="LVTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Latvia tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="LVTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="LVTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="LVTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="LTTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Lithuania tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="LTTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="LTTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="LTTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="LUTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Luxembourg tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="LUTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="LUTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="LUTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="MTTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Malta tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="MTTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="MTTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="MTTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="NLTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Netherlands tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="NLTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="NLTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="NLTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="PLTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Poland tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="PLTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="PLTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PLTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="PTTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Portugal tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="PTTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="PTTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="PTTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ROTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Romania tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ROTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="ROTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ROTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SKTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Slovakia tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="SKTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="SKTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="SKTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SITaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Slovenia tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="SITaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="SITaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="SITaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="ESTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Spain tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="ESTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="ESTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="ESTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="SETaxRate1EuropeVATMOSSLabelControl" runat="server" Text="Sweden tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="SETaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="SETaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="SETaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
        <div class="dnnFormItem">
			<dnn1:LabelControl ID="GBTaxRate1EuropeVATMOSSLabelControl" runat="server" Text="United Kingdom tax rate (%):" HelpText="Enter the percentage rate." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GBTaxRate1EuropeVATMOSSRequiredFieldValidator" runat="server" ControlToValidate="GBTaxRate1EuropeVATMOSSDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="TaxClassDetailsViewControl">Tax rate is required.</asp:RequiredFieldValidator>
			<dnn2:DnnNumericTextBox ID="GBTaxRate1EuropeVATMOSSDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" CssClass="dnnFormRequired" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="FlatRateView" runat="server">
		<p>Enter up to 5 tax levels to break down and charge different tax rates by country, state, county, city and municipal level. The sum of the individual tax amounts is what the customer will pay in taxes. If you don't care about tax levels, you can simply put your entire tax amount in the first level 1.</p>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate1FlatRateLabelControl" runat="server" Text="Tax rate level 1 (%):" HelpText="For tax reporting purposes, enter the percentage rate for level 1 (and optionally up to 5 levels) to represent the tax breakdown at various government levels (country, state, county, city, municipal, etc.)" />
			<dnn2:DnnNumericTextBox ID="TaxRate1FlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate2FlatRateLabelControl" runat="server" Text="Tax rate level 2 (%):" />
			<dnn2:DnnNumericTextBox ID="TaxRate2FlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate3FlatRateLabelControl" runat="server" Text="Tax rate level 3 (%):" />
			<dnn2:DnnNumericTextBox ID="TaxRate3FlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate4FlatRateLabelControl" runat="server" Text="Tax rate level 4 (%):" />
			<dnn2:DnnNumericTextBox ID="TaxRate4FlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TaxRate5FlatRateLabelControl" runat="server" Text="Tax rate level 5 (%):" />
			<dnn2:DnnNumericTextBox ID="TaxRate5FlatRateDnnNumericTextBox" runat="server" Skin="" EnableSingleInputRendering="False" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
	<asp:View ID="RegionalRateView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AddressTypeRegionalRateLabelControl" runat="server" Text="Match address type:" HelpText="Determine how tax calculation should match against which type of address." />
			<asp:RadioButtonList ID="AddressTypeRegionalRateRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Billing" Value="billing" Selected="True" />
				<asp:ListItem Text="Shipping" Value="shipping" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RegionRegionalRateLabelControl" runat="server" Text="Regions:" HelpText="Tax is calculated by finding the closest matching region to apply the tax rate." />
			<div class="rvdFormSubContainer">
				<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
				<asp:GridView ID="RegionRegionalRateGridView" runat="server" CssClass="dnnGrid" GridLines="None" AutoGenerateColumns="False" DataKeyNames="CountryCode,SubdivisionCode,PostalCode" OnRowDeleting="RegionRegionalRateGridView_RowDeleting" OnSelectedIndexChanged="RegionRegionalRateGridView_SelectedIndexChanged">
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
						<asp:BoundField DataField="Country" HeaderText="Country" />
						<asp:BoundField DataField="Subdivision" HeaderText="State/Province" />
						<asp:BoundField DataField="PostalCode" HeaderText="Postal code" />
						<asp:BoundField DataField="TaxRate1" HeaderText="Tax rate 1" />
						<asp:BoundField DataField="TaxRate2" HeaderText="Tax rate 2" />
						<asp:BoundField DataField="TaxRate3" HeaderText="Tax rate 3" />
						<asp:BoundField DataField="TaxRate4" HeaderText="Tax rate 4" />
						<asp:BoundField DataField="TaxRate5" HeaderText="Tax rate 5" />
					</Columns>
				</asp:GridView>
				<div class="rvdActions">
					<asp:LinkButton ID="AddRegionRegionalRateLinkButton" runat="server" Text="Add new" OnClick="AddRegionRegionalRateLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdAddNewAction" />
				</div>
				<asp:Panel ID="RegionRegionalRateDetailsViewPanel" runat="server">
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="CountryCodeRegionalRateDetailsViewLabelControl" runat="server" Text="Country:" />
						<asp:DropDownList ID="CountryCodeRegionalRateDetailsViewDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="CountryCodeRegionalRateDetailsViewDropDownList_SelectedIndexChanged">
							<asp:ListItem Text="Any" Value="" />
							<asp:ListItem Text="Afghanistan" Value="AF" />
							<asp:ListItem Text="&#197;land Islands" Value="AX" />
							<asp:ListItem Text="Albania" Value="AL" />
							<asp:ListItem Text="Algeria" Value="DZ" />
							<asp:ListItem Text="American Samoa" Value="AS" />
							<asp:ListItem Text="Andorra" Value="AD" />
							<asp:ListItem Text="Angola" Value="AO" />
							<asp:ListItem Text="Anguilla" Value="AI" />
							<asp:ListItem Text="Antarctica" Value="AQ" />
							<asp:ListItem Text="Antigua and Barbuda" Value="AG" />
							<asp:ListItem Text="Argentina" Value="AR" />
							<asp:ListItem Text="Armenia" Value="AM" />
							<asp:ListItem Text="Aruba" Value="AW" />
							<asp:ListItem Text="Australia" Value="AU" />
							<asp:ListItem Text="Austria" Value="AT" />
							<asp:ListItem Text="Azerbaijan" Value="AZ" />
							<asp:ListItem Text="Bahamas" Value="BS" />
							<asp:ListItem Text="Bahrain" Value="BH" />
							<asp:ListItem Text="Bangladesh" Value="BD" />
							<asp:ListItem Text="Barbados" Value="BB" />
							<asp:ListItem Text="Belarus" Value="BY" />
							<asp:ListItem Text="Belgium" Value="BE" />
							<asp:ListItem Text="Belize" Value="BZ" />
							<asp:ListItem Text="Benin" Value="BJ" />
							<asp:ListItem Text="Bermuda" Value="BM" />
							<asp:ListItem Text="Bhutan" Value="BT" />
							<asp:ListItem Text="Bolivia" Value="BO" />
							<asp:ListItem Text="Bosnia and Herzegovina" Value="BA" />
							<asp:ListItem Text="Botswana" Value="BW" />
							<asp:ListItem Text="Bouvet Island" Value="BV" />
							<asp:ListItem Text="Brazil" Value="BR" />
							<asp:ListItem Text="British Indian Ocean Territory" Value="IO" />
							<asp:ListItem Text="Brunei Darussalam" Value="BN" />
							<asp:ListItem Text="Bulgaria" Value="BG" />
							<asp:ListItem Text="Burkina Faso" Value="BF" />
							<asp:ListItem Text="Burundi" Value="BI" />
							<asp:ListItem Text="Cambodia" Value="KH" />
							<asp:ListItem Text="Cameroon" Value="CM" />
							<asp:ListItem Text="Canada" Value="CA" />
							<asp:ListItem Text="Cape Verde" Value="CV" />
							<asp:ListItem Text="Cayman Islands" Value="KY" />
							<asp:ListItem Text="Central African Republic" Value="CF" />
							<asp:ListItem Text="Chad" Value="TD" />
							<asp:ListItem Text="Chile" Value="CL" />
							<asp:ListItem Text="China" Value="CN" />
							<asp:ListItem Text="Christmas Island" Value="CX" />
							<asp:ListItem Text="Cocos (Keeling) Islands" Value="CC" />
							<asp:ListItem Text="Colombia" Value="CO" />
							<asp:ListItem Text="Comoros" Value="KM" />
							<asp:ListItem Text="Congo" Value="CG" />
							<asp:ListItem Text="Congo, The Democratic Republic Of The" Value="CD" />
							<asp:ListItem Text="Cook Islands" Value="CK" />
							<asp:ListItem Text="Costa Rica" Value="CR" />
							<asp:ListItem Text="C&#244;te D'Ivoire" Value="CI" />
							<asp:ListItem Text="Croatia" Value="HR" />
							<asp:ListItem Text="Cuba" Value="CU" />
							<asp:ListItem Text="Cyprus" Value="CY" />
							<asp:ListItem Text="Czech Republic" Value="CZ" />
							<asp:ListItem Text="Denmark" Value="DK" />
							<asp:ListItem Text="Djibouti" Value="DJ" />
							<asp:ListItem Text="Dominica" Value="DM" />
							<asp:ListItem Text="Dominican Republic" Value="DO" />
							<asp:ListItem Text="Ecuador" Value="EC" />
							<asp:ListItem Text="Egypt" Value="EG" />
							<asp:ListItem Text="El Salvador" Value="SV" />
							<asp:ListItem Text="Equatorial Guinea" Value="GQ" />
							<asp:ListItem Text="Eritrea" Value="ER" />
							<asp:ListItem Text="Estonia" Value="EE" />
							<asp:ListItem Text="Ethiopia" Value="ET" />
							<asp:ListItem Text="Falkland Islands  (Malvinas)" Value="FK" />
							<asp:ListItem Text="Faroe Islands" Value="FO" />
							<asp:ListItem Text="Fiji" Value="FJ" />
							<asp:ListItem Text="Finland" Value="FI" />
							<asp:ListItem Text="France" Value="FR" />
							<asp:ListItem Text="French Guiana" Value="GF" />
							<asp:ListItem Text="French Polynesia" Value="PF" />
							<asp:ListItem Text="French Southern Territories" Value="TF" />
							<asp:ListItem Text="Gabon" Value="GA" />
							<asp:ListItem Text="Gambia" Value="GM" />
							<asp:ListItem Text="Georgia" Value="GE" />
							<asp:ListItem Text="Germany" Value="DE" />
							<asp:ListItem Text="Ghana" Value="GH" />
							<asp:ListItem Text="Gibraltar" Value="GI" />
							<asp:ListItem Text="Greece" Value="GR" />
							<asp:ListItem Text="Greenland" Value="GL" />
							<asp:ListItem Text="Grenada" Value="GD" />
							<asp:ListItem Text="Guadeloupe" Value="GP" />
							<asp:ListItem Text="Guam" Value="GU" />
							<asp:ListItem Text="Guatemala" Value="GT" />
							<asp:ListItem Text="Guernsey" Value="GG" />
							<asp:ListItem Text="Guinea" Value="GN" />
							<asp:ListItem Text="Guinea-Bissau" Value="GW" />
							<asp:ListItem Text="Guyana" Value="GY" />
							<asp:ListItem Text="Haiti" Value="HT" />
							<asp:ListItem Text="Heard and McDonald Islands" Value="HM" />
							<asp:ListItem Text="Holy See (Vatican City State)" Value="VA" />
							<asp:ListItem Text="Honduras" Value="HN" />
							<asp:ListItem Text="Hong Kong" Value="HK" />
							<asp:ListItem Text="Hungary" Value="HU" />
							<asp:ListItem Text="Iceland" Value="IS" />
							<asp:ListItem Text="India" Value="IN" />
							<asp:ListItem Text="Indonesia" Value="ID" />
							<asp:ListItem Text="Iran, Islamic Republic Of" Value="IR" />
							<asp:ListItem Text="Iraq" Value="IQ" />
							<asp:ListItem Text="Ireland" Value="IE" />
							<asp:ListItem Text="Isle of Man" Value="IM" />
							<asp:ListItem Text="Israel" Value="IL" />
							<asp:ListItem Text="Italy" Value="IT" />
							<asp:ListItem Text="Jamaica" Value="JM" />
							<asp:ListItem Text="Japan" Value="JP" />
							<asp:ListItem Text="Jersey" Value="JE" />
							<asp:ListItem Text="Jordan" Value="JO" />
							<asp:ListItem Text="Kazakhstan" Value="KZ" />
							<asp:ListItem Text="Kenya" Value="KE" />
							<asp:ListItem Text="Kiribati" Value="KI" />
							<asp:ListItem Text="Korea, Democratic People's Republic Of" Value="KP" />
							<asp:ListItem Text="Korea, Republic of" Value="KR" />
							<asp:ListItem Text="Kuwait" Value="KW" />
							<asp:ListItem Text="Kyrgyzstan" Value="KG" />
							<asp:ListItem Text="Lao People's Democratic Republic" Value="LA" />
							<asp:ListItem Text="Latvia" Value="LV" />
							<asp:ListItem Text="Lebanon" Value="LB" />
							<asp:ListItem Text="Lesotho" Value="LS" />
							<asp:ListItem Text="Liberia" Value="LR" />
							<asp:ListItem Text="Libyan Arab Jamahiriya" Value="LY" />
							<asp:ListItem Text="Liechtenstein" Value="LI" />
							<asp:ListItem Text="Lithuania" Value="LT" />
							<asp:ListItem Text="Luxembourg" Value="LU" />
							<asp:ListItem Text="Macao" Value="MO" />
							<asp:ListItem Text="Macedonia, the Former Yugoslav Republic Of" Value="MK" />
							<asp:ListItem Text="Madagascar" Value="MG" />
							<asp:ListItem Text="Malawi" Value="MW" />
							<asp:ListItem Text="Malaysia" Value="MY" />
							<asp:ListItem Text="Maldives" Value="MV" />
							<asp:ListItem Text="Mali" Value="ML" />
							<asp:ListItem Text="Malta" Value="MT" />
							<asp:ListItem Text="Marshall Islands" Value="MH" />
							<asp:ListItem Text="Martinique" Value="MQ" />
							<asp:ListItem Text="Mauritania" Value="MR" />
							<asp:ListItem Text="Mauritius" Value="MU" />
							<asp:ListItem Text="Mayotte" Value="YT" />
							<asp:ListItem Text="Mexico" Value="MX" />
							<asp:ListItem Text="Micronesia, Federated States Of" Value="FM" />
							<asp:ListItem Text="Moldova, Republic of" Value="MD" />
							<asp:ListItem Text="Monaco" Value="MC" />
							<asp:ListItem Text="Mongolia" Value="MN" />
							<asp:ListItem Text="Montenegro" Value="ME" />
							<asp:ListItem Text="Montserrat" Value="MS" />
							<asp:ListItem Text="Morocco" Value="MA" />
							<asp:ListItem Text="Mozambique" Value="MZ" />
							<asp:ListItem Text="Myanmar" Value="MM" />
							<asp:ListItem Text="Namibia" Value="NA" />
							<asp:ListItem Text="Nauru" Value="NR" />
							<asp:ListItem Text="Nepal" Value="NP" />
							<asp:ListItem Text="Netherlands" Value="NL" />
							<asp:ListItem Text="Netherlands Antilles" Value="AN" />
							<asp:ListItem Text="New Caledonia" Value="NC" />
							<asp:ListItem Text="New Zealand" Value="NZ" />
							<asp:ListItem Text="Nicaragua" Value="NI" />
							<asp:ListItem Text="Niger" Value="NE" />
							<asp:ListItem Text="Nigeria" Value="NG" />
							<asp:ListItem Text="Niue" Value="NU" />
							<asp:ListItem Text="Norfolk Island" Value="NF" />
							<asp:ListItem Text="Northern Mariana Islands" Value="MP" />
							<asp:ListItem Text="Norway" Value="NO" />
							<asp:ListItem Text="Oman" Value="OM" />
							<asp:ListItem Text="Pakistan" Value="PK" />
							<asp:ListItem Text="Palau" Value="PW" />
							<asp:ListItem Text="Palestinian Territory, Occupied" Value="PS" />
							<asp:ListItem Text="Panama" Value="PA" />
							<asp:ListItem Text="Papua New Guinea" Value="PG" />
							<asp:ListItem Text="Paraguay" Value="PY" />
							<asp:ListItem Text="Peru" Value="PE" />
							<asp:ListItem Text="Philippines" Value="PH" />
							<asp:ListItem Text="Pitcairn" Value="PN" />
							<asp:ListItem Text="Poland" Value="PL" />
							<asp:ListItem Text="Portugal" Value="PT" />
							<asp:ListItem Text="Puerto Rico" Value="PR" />
							<asp:ListItem Text="Qatar" Value="QA" />
							<asp:ListItem Text="R&#233;union" Value="RE" />
							<asp:ListItem Text="Romania" Value="RO" />
							<asp:ListItem Text="Russian Federation" Value="RU" />
							<asp:ListItem Text="Rwanda" Value="RW" />
							<asp:ListItem Text="Saint Barth&#233;lemy" Value="BL" />
							<asp:ListItem Text="Saint Helena" Value="SH" />
							<asp:ListItem Text="Saint Kitts And Nevis" Value="KN" />
							<asp:ListItem Text="Saint Lucia" Value="LC" />
							<asp:ListItem Text="Saint Martin" Value="MF" />
							<asp:ListItem Text="Saint Pierre And Miquelon" Value="PM" />
							<asp:ListItem Text="Saint Vincent And The Grenedines" Value="VC" />
							<asp:ListItem Text="Samoa" Value="WS" />
							<asp:ListItem Text="San Marino" Value="SM" />
							<asp:ListItem Text="Sao Tome and Principe" Value="ST" />
							<asp:ListItem Text="Saudi Arabia" Value="SA" />
							<asp:ListItem Text="Senegal" Value="SN" />
							<asp:ListItem Text="Serbia" Value="RS" />
							<asp:ListItem Text="Seychelles" Value="SC" />
							<asp:ListItem Text="Sierra Leone" Value="SL" />
							<asp:ListItem Text="Singapore" Value="SG" />
							<asp:ListItem Text="Slovakia" Value="SK" />
							<asp:ListItem Text="Slovenia" Value="SI" />
							<asp:ListItem Text="Solomon Islands" Value="SB" />
							<asp:ListItem Text="Somalia" Value="SO" />
							<asp:ListItem Text="South Africa" Value="ZA" />
							<asp:ListItem Text="South Georgia and the South Sandwich Islands" Value="GS" />
							<asp:ListItem Text="Spain" Value="ES" />
							<asp:ListItem Text="Sri Lanka" Value="LK" />
							<asp:ListItem Text="Sudan" Value="SD" />
							<asp:ListItem Text="Suriname" Value="SR" />
							<asp:ListItem Text="Svalbard And Jan Mayen" Value="SJ" />
							<asp:ListItem Text="Swaziland" Value="SZ" />
							<asp:ListItem Text="Sweden" Value="SE" />
							<asp:ListItem Text="Switzerland" Value="CH" />
							<asp:ListItem Text="Syrian Arab Republic" Value="SY" />
							<asp:ListItem Text="Taiwan, Province Of China" Value="TW" />
							<asp:ListItem Text="Tajikistan" Value="TJ" />
							<asp:ListItem Text="Tanzania, United Republic of" Value="TZ" />
							<asp:ListItem Text="Thailand" Value="TH" />
							<asp:ListItem Text="Timor-Leste" Value="TL" />
							<asp:ListItem Text="Togo" Value="TG" />
							<asp:ListItem Text="Tokelau" Value="TK" />
							<asp:ListItem Text="Tonga" Value="TO" />
							<asp:ListItem Text="Trinidad and Tobago" Value="TT" />
							<asp:ListItem Text="Tunisia" Value="TN" />
							<asp:ListItem Text="Turkey" Value="TR" />
							<asp:ListItem Text="Turkmenistan" Value="TM" />
							<asp:ListItem Text="Turks and Caicos Islands" Value="TC" />
							<asp:ListItem Text="Tuvalu" Value="TV" />
							<asp:ListItem Text="Uganda" Value="UG" />
							<asp:ListItem Text="Ukraine" Value="UA" />
							<asp:ListItem Text="United Arab Emirates" Value="AE" />
							<asp:ListItem Text="United Kingdom" Value="GB" />
							<asp:ListItem Text="United States" Value="US" />
							<asp:ListItem Text="United States Minor Outlying Islands" Value="UM" />
							<asp:ListItem Text="Uruguay" Value="UY" />
							<asp:ListItem Text="Uzbekistan" Value="UZ" />
							<asp:ListItem Text="Vanuatu" Value="VU" />
							<asp:ListItem Text="Venezuela, Bolivarian Republic of" Value="VE" />
							<asp:ListItem Text="Viet Nam" Value="VN" />
							<asp:ListItem Text="Virgin Islands, British" Value="VG" />
							<asp:ListItem Text="Virgin Islands, U.S." Value="VI" />
							<asp:ListItem Text="Wallis and Futuna" Value="WF" />
							<asp:ListItem Text="Western Sahara" Value="EH" />
							<asp:ListItem Text="Yemen" Value="YE" />
							<asp:ListItem Text="Zambia" Value="ZM" />
							<asp:ListItem Text="Zimbabwe" Value="ZW" />
						</asp:DropDownList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="SubdivisionCodeRegionalRateDetailsViewLabelControl" runat="server" Text="State/Province:" />
						<asp:DropDownList ID="SubdivisionCodeRegionalRateDetailsViewDropDownList" runat="server">
						</asp:DropDownList>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="PostalCodeRegionalRateDetailsViewLabelControl" runat="server" Text="Postal code:" HelpText="Enter a postal code to match or leave blank to match any postal code. If you enter a substring 902 postal code, it will also match 90210. This allows you to group your postal code into manageable regions." />
						<asp:TextBox ID="PostalCodeRegionalRateDetailsViewTextBox" runat="server"></asp:TextBox>
					</div>
					<p>Enter up to 5 tax levels to break down and charge different tax rates by country, state, county, city and municipal level. The sum of the individual tax amounts is what the customer will pay in taxes. If you don't care about tax levels, you can simply put your entire tax amount in the first level 1.</p>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="TaxRate1RegionalRateDetailsViewLabelControl" runat="server" Text="Tax rate level 1 (%):" HelpText="For tax reporting purposes, enter the percentage rate for level 1 (and optionally up to 5 levels) to represent the tax breakdown at various government levels (country, state, county, municipal, town, etc.)" />
						<dnn2:DnnNumericTextBox ID="TaxRate1RegionalRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="TaxRate2RegionalRateDetailsViewLabelControl" runat="server" Text="Tax rate level 2 (%):" />
						<dnn2:DnnNumericTextBox ID="TaxRate2RegionalRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="TaxRate3RegionalRateDetailsViewLabelControl" runat="server" Text="Tax rate level 3 (%):" />
						<dnn2:DnnNumericTextBox ID="TaxRate3RegionalRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="TaxRate4RegionalRateDetailsViewLabelControl" runat="server" Text="Tax rate level 4 (%):" />
						<dnn2:DnnNumericTextBox ID="TaxRate4RegionalRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="dnnFormItem">
						<dnn1:LabelControl ID="TaxRate5RegionalRateDetailsViewLabelControl" runat="server" Text="Tax rate level 5 (%):" />
						<dnn2:DnnNumericTextBox ID="TaxRate5RegionalRateDetailsViewDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0">
						</dnn2:DnnNumericTextBox>
					</div>
					<div class="rvdActions">
						<asp:LinkButton ID="SaveRegionRegionalRateLinkButton" runat="server" Text="OK" OnClick="SaveRegionRegionalRateLinkButton_Click" ValidationGroup="RegionRegionalRateDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
					</div>
				</asp:Panel>
			</div>
		</div>
	</asp:View>
	<asp:View ID="CustomRuleView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RateRuleLabelControl" runat="server" Text="XSLT rule:" />
			<uc1:FormulaEditorControl ID="RateRuleFormulaEditor" runat="server" Width="100%" ModuleControl="TaxClassRate" />
		</div>
	</asp:View>
</asp:MultiView>