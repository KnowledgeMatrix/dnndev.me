<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QuickOrderConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.QuickOrderConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="DisplayTemplateDropDownListControl.ascx" TagName="DisplayTemplateDropDownListControl" TagPrefix="uc1" %>
<h2>
	Quick order</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="QuickOrderDisplayTemplateLabelControl" runat="server" Text="Display template:" HelpText="The selected display template determines how to display the Quick Order module."/>
			<uc1:DisplayTemplateDropDownListControl ID="QuickOrderDisplayTemplateDropDownListControl" runat="server"/>
			<asp:LinkButton ID="QuickOrderDisplayTemplateLinkButton" runat="server" CssClass="rvdLinkAction" Text="Edit" OnClick="QuickOrderDisplayTemplateLinkButton_Click" CausesValidation="False" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
