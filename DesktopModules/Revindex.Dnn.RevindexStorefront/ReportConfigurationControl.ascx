<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReportConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ReportConfigurationControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Assembly="Revindex.Web.UI.WebControls" Namespace="Revindex.Web.UI.WebControls" TagPrefix="rvd1" %>
<%@ Register Src="WebUserControls/BasicDynamicFormDetailsViewControl.ascx" TagName="BasicDynamicFormDetailsViewControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BackControl.ascx" TagName="BackControl" TagPrefix="uc1" %>
<%@ Register Src="WebUserControls/Common/Dnn/BreadcrumbControl.ascx" TagName="BreadcrumbControl" TagPrefix="uc1" %>

<asp:PlaceHolder ID="PlaceHolder1" runat="server">

	<script type="text/javascript">
	    jQuery(document).ready(function ()
	    {
	        jQuery('#ReportConfigurationDetailsViewTabPanel').dnnTabs();
	    });
	    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function ()
	    {
	        jQuery('#ReportConfigurationDetailsViewTabPanel').dnnTabs();
	    });
	</script>

</asp:PlaceHolder>
<div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
	    <ContentTemplate>
            <asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
            <asp:MultiView ID="ContentMultiView" runat="server">
                <asp:View ID="ListView" runat="server">
                    <h2>Reports</h2>
                    <div class="dnnForm rvdsfListContainer">
			            <asp:GridView ID="ReportConfigurationGridView" runat="server" CssClass="dnnGrid" GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ReportDefinitionID" OnRowDeleting="ReportConfigurationGridView_RowDeleting" OnRowDataBound="ReportConfigurationGridView_RowDataBound" OnRowCommand="ReportConfigurationGridView_RowCommand">
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
							            <asp:LinkButton ID="CloneLinkButton" runat="server" CommandName="Clone" CausesValidation="false" CssClass="rvdCopyGridAction" ToolTip="Clone" CommandArgument='<%# Eval("ReportDefinitionID") %>'></asp:LinkButton>
						            </ItemTemplate>
					            </asp:TemplateField>
					            <asp:TemplateField>
						            <ItemTemplate>
							            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="rvdDeleteGridAction"></asp:LinkButton>
						            </ItemTemplate>
					            </asp:TemplateField>
					            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
					            <asp:BoundField DataField="ReportGroup" HeaderText="Report group" SortExpression="ReportGroup" />
					            <asp:CheckBoxField DataField="Active" HeaderText="Active" SortExpression="Active" />
					            <asp:CheckBoxField DataField="Standard" HeaderText="Standard" SortExpression="Standard" />
				            </Columns>
			            </asp:GridView>
			            <asp:ObjectDataSource ID="ReportConfigurationObjectDataSource" runat="server" EnablePaging="True" SelectCountMethod="GetCount" SelectMethod="GetAll" SortParameterName="sortExpression" TypeName="Revindex.Business.Revindex.Revindex.Storefront.ReportDefinitionController">
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
                    <uc1:BackControl ID="QuickBackControl" runat="server" Text="" CssClass="rvdsfBackAction"/>
                    <h2>Report: <uc1:BreadcrumbControl ID="BreadcrumbControl" runat="server" /></h2>
			        <div id="ReportConfigurationDetailsViewTabPanel" class="dnnForm">
				        <ul class="dnnAdminTabNav dnnClear">
					        <li><a href="#<%= GeneralDetailsViewPanel.ClientID %>">
						        <asp:Label ID="GeneralDetailsViewTabLabel" runat="server" Text="General" /></a></li>
					        <li><a href="#<%= DataSourceDetailsViewPanel.ClientID %>">
						        <asp:Label ID="DataSourceDetailsViewTabLabel" runat="server" Text="Data source" /></a></li>
					        <li><a href="#<%= ParameterDetailsViewPanel.ClientID %>">
						        <asp:Label ID="ParameterDetailsViewTabLabel" runat="server" Text="Parameter" /></a></li>
					        <li><a href="#<%= VisualizerDetailsViewPanel.ClientID %>">
						        <asp:Label ID="VisualizerDetailsViewTabLabel" runat="server" Text="Visualizer" /></a></li>
				        </ul>
				        <asp:Panel ID="GeneralDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="ReportDefinitionIDLabelControl" runat="server" Text="Report definition ID:" />
							        <asp:Label runat="server" ID="ReportDefinitionIDLabel"></asp:Label>
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="ReportDefinitionGUIDLabelControl" runat="server" Text="Report definition GUID:" />
							        <asp:Label runat="server" ID="ReportDefinitionGUIDLabel"></asp:Label>
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="NameLabelControl" runat="server" Text="Name:" CssClass="dnnFormRequired" />
							        <asp:RequiredFieldValidator ID="NameRequiredFieldValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ReportConfigurationDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
							        <asp:RegularExpressionValidator ID="NameRegularExpressionValidator" runat="server" ControlToValidate="NameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="[^;|\[\]&lt;&gt;{}^\\]+" ValidationGroup="ReportConfigurationDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
							        <asp:TextBox ID="NameTextBox" runat="server" CssClass="dnnFormRequired" MaxLength="100"></asp:TextBox>
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
							        <dnn1:LabelControl ID="AllPortalLabelControl" runat="server" HelpText="Determine if report should be available for all portals." Text="Display in all portals:" />
							        <asp:CheckBox ID="AllPortalCheckBox" runat="server" />
						        </div>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="ReportGroupLabelControl" runat="server" HelpText="The report will belong to which group heading." Text="Report group:" />
							        <asp:DropDownList ID="ReportGroupDropDownList" runat="server">
								        <asp:ListItem Text="Catalog" Value="1" Selected="True" />
                                        <asp:ListItem Text="Marketing" Value="3" />
								        <asp:ListItem Text="People" Value="4" />
								        <asp:ListItem Text="Sales" Value="2" />
							        </asp:DropDownList>
						        </div>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="DataSourceDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="QueryLabelControl" runat="server" Text="SQL query:" HelpText="Enter any SQL query. Use @ParamName token to specify input parameters." />
							        <asp:TextBox ID="QueryTextBox" runat="server" style="max-width:none" Width="100%" Height="600px" TextMode="MultiLine" Wrap="False"></asp:TextBox>
						        </div>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="ParameterDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="ParameterLabelControl" runat="server" Text="Parameters:" />
							        <div class="rvdFormSubContainer">
								        <asp:PlaceHolder ID="EditParameterMessagePlaceHolder" runat="server" />
							        </div>
							        <div class="rvdFormListBox">
								        <dnn2:DnnListBox ID="ParameterDnnListBox" runat="server" AutoPostBack="True" CausesValidation="False" OnSelectedIndexChanged="ParameterDnnListBox_SelectedIndexChanged" OnDeleted="ParameterDnnListBox_Deleted" AutoPostBackOnDelete="True" CheckBoxes="False" Height="120px" AllowReorder="True" AllowDelete="True">
								        </dnn2:DnnListBox>
								        <div class="rvdActions">
									        <asp:LinkButton ID="AddParameterLinkButton" runat="server" CausesValidation="False" Text="Add item" OnClick="AddParameterLinkButton_Click" CssClass="dnnPrimaryAction rvdAddNewAction" />
								        </div>
								        <asp:Panel ID="EditParameterPanel" runat="server">
									        <div class="dnnFormItem">
										        <dnn1:LabelControl ID="ParameterNameLabelControl" runat="server" Text="Name:" HelpText="Enter the parameter name that matches your data source parameter. E.g. If your datasource specifies @MyParam, then the name should be entered as @MyParam here." CssClass="dnnFormRequired" />
										        <asp:RequiredFieldValidator ID="ParameterNameRequiredFieldValidator" runat="server" ControlToValidate="ParameterNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ParameterReportConfigurationDetailsViewControl">Name is required.</asp:RequiredFieldValidator>
										        <asp:RegularExpressionValidator ID="ParameterNameRegularExpressionValidator" runat="server" ControlToValidate="ParameterNameTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationExpression="^@\w+$" ValidationGroup="ParameterReportConfigurationDetailsViewControl">Name is invalid.</asp:RegularExpressionValidator>
										        <asp:TextBox ID="ParameterNameTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
									        </div>
									        <div class="dnnFormItem">
										        <dnn1:LabelControl ID="ParameterDbTypeLabelControl" runat="server" Text="Database type:" HelpText="The underlying database type for this parameter." />
										        <asp:DropDownList ID="ParameterDbTypeDropDownList" runat="server">
											        <asp:ListItem Text="Binary" Value="1" />
											        <asp:ListItem Text="Byte" Value="2" />
											        <asp:ListItem Text="Boolean" Value="3" />
											        <asp:ListItem Text="Currency" Value="4" />
											        <asp:ListItem Text="Date" Value="5" />
											        <asp:ListItem Text="DateTime" Value="6" />
											        <asp:ListItem Text="Decimal" Value="7" />
											        <asp:ListItem Text="Double" Value="8" />
											        <asp:ListItem Text="Guid" Value="9" />
											        <asp:ListItem Text="Int16" Value="10" />
											        <asp:ListItem Text="Int32" Value="11" />
											        <asp:ListItem Text="Int64" Value="12" />
											        <asp:ListItem Text="SByte" Value="14" />
											        <asp:ListItem Text="Single" Value="15" />
											        <asp:ListItem Text="String" Value="16" />
											        <asp:ListItem Text="Time" Value="17" />
											        <asp:ListItem Text="UInt16" Value="18" />
											        <asp:ListItem Text="UInt32" Value="19" />
											        <asp:ListItem Text="UInt64" Value="20" />
											        <asp:ListItem Text="VarNumeric" Value="21" />
											        <asp:ListItem Text="Xml" Value="25" />
										        </asp:DropDownList>
									        </div>
									        <div class="dnnFormItem">
										        <dnn1:LabelControl ID="ParameterSourceLabelControl" runat="server" Text="Source:" HelpText="Determine where the parameter should source the value from." />
										        <asp:DropDownList ID="ParameterSourceDropDownList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ParameterSourceDropDownList_SelectedIndexChanged">
											        <asp:ListItem Text="Control" Value="ControlParameterSourceDetailsViewView" />
											        <asp:ListItem Text="Variable" Value="VariableParameterSourceDetailsViewView" />
										        </asp:DropDownList>
									        </div>
									        <asp:MultiView ID="ParameterSourceDetailsViewMultiView" runat="server" ActiveViewIndex="0">
										        <asp:View ID="ControlParameterSourceDetailsViewView" runat="server">
											        <uc1:BasicDynamicFormDetailsViewControl id="ControlParameterSourceBasicDynamicFormDetailsViewControl" runat="server" ValidationGroup="ParameterReportConfigurationDetailsViewControl" />
										        </asp:View>
										        <asp:View ID="VariableParameterSourceDetailsViewView" runat="server">
											        <div class="dnnFormItem">
												        <dnn1:LabelControl ID="VariableNameVariableParameterLabelControl" runat="server" Text="Variable name:" HelpText="Variable name." />
												        <asp:DropDownList ID="VariableNameVariableParameterDropDownList" runat="server">
													        <asp:ListItem Text="Date:Current" Value="Date:Current" />
													        <asp:ListItem Text="Date:Now" Value="Date:Now" />
													        <asp:ListItem Text="Membership:LastActivityDate" Value="Membership:LastActivityDate" />
													        <asp:ListItem Text="Membership:LastLockoutDate" Value="Membership:LastLockoutDate" />
													        <asp:ListItem Text="Membership:LastLoginDate" Value="Membership:LastLoginDate" />
													        <asp:ListItem Text="Membership:LastPasswordChangeDate" Value="Membership:LastPasswordChangeDate" />
													        <asp:ListItem Text="Membership:Email" Value="Membership:Email" />
													        <asp:ListItem Text="Membership:Username" Value="Membership:Username" />
													        <asp:ListItem Text="Module:PortalID" Value="Module:PortalID" />
													        <asp:ListItem Text="Module:TabID" Value="Module:TabID" />
													        <asp:ListItem Text="Module:TabModuleID" Value="Module:TabModuleID" />
													        <asp:ListItem Text="Module:ModuleID" Value="Module:ModuleID" />
													        <asp:ListItem Text="Module:PaneName" Value="Module:PaneName" />
													        <asp:ListItem Text="Module:ModuleTitle" Value="Module:ModuleTitle" />
													        <asp:ListItem Text="Module:Alignment" Value="Module:Alignment" />
													        <asp:ListItem Text="Module:Color" Value="Module:Color" />
													        <asp:ListItem Text="Module:Border" Value="Module:Border" />
													        <asp:ListItem Text="Module:IconFile" Value="Module:IconFile" />
													        <asp:ListItem Text="Module:Header" Value="Module:Header" />
													        <asp:ListItem Text="Module:Footer" Value="Module:Footer" />
													        <asp:ListItem Text="Module:FriendlyName" Value="Module:FriendlyName" />
													        <asp:ListItem Text="Module:Description" Value="Module:Description" />
													        <asp:ListItem Text="Module:Version" Value="Module:Version" />
													        <asp:ListItem Text="Module:BusinessControllerClass" Value="Module:BusinessControllerClass" />
													        <asp:ListItem Text="Module:ControlTitle" Value="Module:ControlTitle" />
													        <asp:ListItem Text="Module:HelpUrl" Value="Module:HelpUrl" />
													        <asp:ListItem Text="Portal:Url" Value="Portal:Url" />
													        <asp:ListItem Text="Portal:PortalID" Value="Portal:PortalID" />
													        <asp:ListItem Text="Portal:PortalName" Value="Portal:PortalName" />
													        <asp:ListItem Text="Portal:HomeDirectory" Value="Portal:HomeDirectory" />
													        <asp:ListItem Text="Portal:LogoFile" Value="Portal:LogoFile" />
													        <asp:ListItem Text="Portal:FooterText" Value="Portal:FooterText" />
													        <asp:ListItem Text="Portal:Currency" Value="Portal:Currency" />
													        <asp:ListItem Text="Portal:Email" Value="Portal:Email" />
													        <asp:ListItem Text="Portal:Description" Value="Portal:Description" />
													        <asp:ListItem Text="Portal:Keywords" Value="Portal:Keywords" />
													        <asp:ListItem Text="Portal:BackgroundFile" Value="Portal:BackgroundFile" />
													        <asp:ListItem Text="Portal:DefaultLanguage" Value="Portal:DefaultLanguage" />
													        <asp:ListItem Text="Profile:Cell" Value="Profile:Cell" />
													        <asp:ListItem Text="Profile:City" Value="Profile:City" />
													        <asp:ListItem Text="Profile:Country" Value="Profile:Country" />
													        <asp:ListItem Text="Profile:Fax" Value="Profile:Fax" />
													        <asp:ListItem Text="Profile:FirstName" Value="Profile:FirstName" />
													        <asp:ListItem Text="Profile:IM" Value="Profile:IM" />
													        <asp:ListItem Text="Profile:LastName" Value="Profile:LastName" />
													        <asp:ListItem Text="Profile:PostalCode" Value="Profile:PostalCode" />
													        <asp:ListItem Text="Profile:PreferredLocale" Value="Profile:PreferredLocale" />
													        <asp:ListItem Text="Profile:Region" Value="Profile:Region" />
													        <asp:ListItem Text="Profile:Street" Value="Profile:Street" />
													        <asp:ListItem Text="Profile:Telephone" Value="Profile:Telephone" />
													        <asp:ListItem Text="Profile:Unit" Value="Profile:Unit" />
													        <asp:ListItem Text="Profile:TimeZone" Value="Profile:TimeZone" />
													        <asp:ListItem Text="Profile:Website" Value="Profile:Website" />
													        <asp:ListItem Text="Tab:TabID" Value="Tab:TabID" />
													        <asp:ListItem Text="Tab:PortalID" Value="Tab:PortalID" />
													        <asp:ListItem Text="Tab:TabName" Value="Tab:TabName" />
													        <asp:ListItem Text="Tab:IconFile" Value="Tab:IconFile" />
													        <asp:ListItem Text="Tab:Title" Value="Tab:Title" />
													        <asp:ListItem Text="Tab:Description" Value="Tab:Description" />
													        <asp:ListItem Text="Tab:Keywords" Value="Tab:Keywords" />
													        <asp:ListItem Text="Tab:Url" Value="Tab:Url" />
													        <asp:ListItem Text="Tab:TabPath" Value="Tab:TabPath" />
													        <asp:ListItem Text="Tab:FullUrl" Value="Tab:FullUrl" />
													        <asp:ListItem Text="Ticks:Today" Value="Ticks:Today" />
													        <asp:ListItem Text="Ticks:Now" Value="Ticks:Now" />
													        <asp:ListItem Text="Ticks:TicksPerDay" Value="Ticks:TicksPerDay" />
													        <asp:ListItem Text="User:DisplayName" Value="User:DisplayName" />
													        <asp:ListItem Text="User:Email" Value="User:Email" />
													        <asp:ListItem Text="User:FirstName" Value="User:FirstName" />
													        <asp:ListItem Text="User:LastName" Value="User:LastName" />
													        <asp:ListItem Text="User:PortalID" Value="User:PortalID" />
													        <asp:ListItem Text="User:UserID" Value="User:UserID" />
													        <asp:ListItem Text="User:Username" Value="User:Username" />
													        <asp:ListItem Text="User:FullName" Value="User:FullName" />
												        </asp:DropDownList>
											        </div>
										        </asp:View>
									        </asp:MultiView>
									        <div class="rvdActions">
										        <asp:LinkButton ID="SaveParameterLinkButton" runat="server" Text="OK" OnClick="SaveParameterLinkButton_Click" ValidationGroup="ParameterReportConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdOKAction" />
									        </div>
								        </asp:Panel>
							        </div>
						        </div>
					        </fieldset>
				        </asp:Panel>
				        <asp:Panel ID="VisualizerDetailsViewPanel" runat="server" CssClass="dnnClear">
					        <fieldset>
						        <div class="dnnFormItem">
							        <dnn1:LabelControl ID="VisualizerLabelControl" runat="server" Text="HTML visualizer:" HelpText="Create the HTML to render the report. This field supports XSL tokens." />
							        <dnn1:TextEditor ID="VisualizerTextEditor" runat="server" ChooseRender="False" ChooseMode="False" DefaultMode="RICH" HtmlEncode="False" Width="100%" Height="600px" Mode="RICH" />
						        </div>
					        </fieldset>
				        </asp:Panel>
			        </div>
			        <div class="dnnForm">
				        <ul class="dnnActions">
					        <li>
						        <asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ReportConfigurationDetailsViewControl" />
					        </li>
                            <li>
			                    <asp:LinkButton ID="SaveAndBackLinkButton" runat="server" Text="Save & return" OnClick="SaveLinkButton_Click" CommandArgument="Back" CssClass="dnnPrimaryAction rvdSaveAction" ValidationGroup="ReportConfigurationDetailsViewControl" />
		                    </li>
                            <li>
                                <uc1:BackControl ID="BackControl1" runat="server" Text="Cancel"/>
                            </li>
				        </ul>
			        </div>
                </asp:View>
            </asp:MultiView>
	    </ContentTemplate>
    </asp:UpdatePanel>
</div>
