<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ModuleCompanions.ascx.cs" Inherits="Evoq.UI.ModuleCompanions" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.UI.WebControls.Internal" Assembly="DotNetNuke.Web" %>

<asp:Panel runat="server" CssClass="social-module-companions">
    <div class="companion-summary">
        <%= string.Format(LocalizeString("CompanionSummary.Text"),
                ModuleContext.Configuration.DesktopModule.FriendlyName,
                ModuleContext.Configuration.ParentTab.LocalizedTabName) %>
    </div>
    
    <br/>

    <div class="social-companions-panel dnnClear">
        <dnn:dnngrid id="grdCompanions" runat="server" autogeneratecolumns="false" AutoGenerateEditColumn="False" AllowMultiRowEdit="True" AllowAutomaticUpdates="True" Enabled="True">
            <headerstyle cssclass="dnnGridHeader" verticalalign="Top" />
            <itemstyle cssclass="dnnGridItem" horizontalalign="Left" />
            <alternatingitemstyle cssclass="dnnGridAltItem" />
            <edititemstyle cssclass="dnnFormInput" />
            <selecteditemstyle cssclass="dnnFormError" />
            <footerstyle cssclass="dnnGridFooter" />
            <pagerstyle cssclass="dnnGridPager" />
            <Columns>
                <dnn:DnnGridBoundColumn DataField="Title" HeaderText="CompanionModuleName" ReadOnly="True" />
            	<dnn:DnnGridTemplateColumn HeaderStyle-Width="150px" HeaderStyle-HorizontalAlign="Center" HeaderText="VisibleOnPage">
					<ItemTemplate>
					    <div style="text-align: center">
						    <asp:CheckBox ID="checkbox" runat="server" Checked='<%# Eval("Selected") %>'/>
                        </div>
					</ItemTemplate>
				</dnn:DnnGridTemplateColumn> 
            </Columns>
        </dnn:dnngrid>
    </div>
    
    <ul class="social-companions-actions dnnActions dnnClear">
        <li>
            <asp:LinkButton runat="server" ID="btnOK" CssClass="dnnPrimaryAction" Text="Save" resourcekey="Save" CausesValidation="False" />
        </li>
        <li>
            <asp:LinkButton runat="server" ID="btnCancel" CssClass="dnnSecondaryAction" Text="Cancel" resourcekey="Cancel" CausesValidation="False" />
        </li>
    </ul>
</asp:Panel>