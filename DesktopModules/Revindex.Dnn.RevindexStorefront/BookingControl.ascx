<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BookingControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.BookingControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>
<asp:PlaceHolder runat="server">

	<script type="text/javascript">
		jQuery(document).ready(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
		Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
		{
			jQuery('#<%= SearchPanel.ClientID %>').dnnPanels();
		});
	</script>

</asp:PlaceHolder>
<div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
		<ContentTemplate>
			<h2>Bookings</h2>
			<asp:Panel ID="SearchPanel" runat="server" DefaultButton="SearchLinkButton" CssClass="dnnForm rvdsfSearchContainer">
				<h2 id="SearchFormSectionHead" class="dnnFormSectionHead">
					<a href="#" class="dnnSectionExpanded">Search</a></h2>
				<fieldset class="rvdSplit2">
					<div class="dnnFormItem">
						<dnn1:LabelControl runat="server" ID="SellerSearchLabelControl" Text="Seller:" HelpText="View items belonging to a specific seller."></dnn1:LabelControl>
						<dnn2:DnnComboBox ID="SellerSearchDnnComboBox" runat="server" AllowCustomText="True" EnableLoadOnDemand="True" OnItemsRequested="SellerSearchDnnComboBox_ItemsRequested" AutoPostBack="True" CausesValidation="False" MaxHeight="200px" OnSelectedIndexChanged="SellerSearchDnnComboBox_SelectedIndexChanged"></dnn2:DnnComboBox>
					</div>
					<div class="rvdActions">
						<asp:LinkButton ID="SearchLinkButton" runat="server" Text="Search" OnClick="SearchLinkButton_Click" CausesValidation="false" CssClass="dnnPrimaryAction rvdSearchAction" />
					</div>
				</fieldset>
			</asp:Panel>
			<div class="dnnForm rvdsfListContainer">
				<dnn2:DnnScheduler ID="BookingDnnScheduler" runat="server" RenderMode="Lightweight" ReadOnly="False" DataStartField="StartDate" DataSubjectField="Subject" DataEndField="StopDate" DataKeyField="ID" Height="700px" OnClientAppointmentClick="OnClientAppointmentClick" EnableDescriptionField="True" DataDescriptionField="Description" MonthView-AdaptiveRowHeight="False" OnNavigationComplete="BookingDnnScheduler_NavigationComplete" AllowInsert="False" AllowEdit="False" AllowDelete="False" MonthView-VisibleAppointmentsPerDay="3" />
				<script type="text/javascript">
					function OnClientAppointmentClick(sender, eventArgs)
					{
						var apt = eventArgs.get_appointment();
						location.href = apt.get_description();
					}
				</script>
			</div>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
