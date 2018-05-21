<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BaseEditorControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.BaseEditorControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<dnn2:DnnWindowManager ID="RuleDnnWindowManager" runat="server" Style="z-index: 1001">
	<Windows>
		<dnn2:DnnWindow runat="server" ID="EditTextDnnWindow" Title="Edit Value" Modal="False" Behaviors="Close,Move" Width="750" Height="480" Skin="Default" ReloadOnShow="True" ShowContentDuringLoad="False" OnClientClose="DnnWindowOnClientCloseHandler" OnClientShow="DnnWindowOnClientShowHandler">
			<ContentTemplate>
				<asp:Panel ID="EditTextPanel" runat="server" DefaultButton="SaveEditTextLinkButton" CssClass="dnnForm">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="TextEditTextLabelControl" runat="server" Text="Text:" />
							<asp:TextBox ID="TextEditTextTextBox" runat="server" TextMode="MultiLine" Width="100%" Height="200"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="WordWrapTextLabelControl" runat="server" Text="Word wrap:" />
							<input type="checkbox" onclick="if (this.checked) document.getElementById('<%= TextEditTextTextBox.ClientID %>').wrap='virtual'; else document.getElementById('<%= TextEditTextTextBox.ClientID %>').wrap='off';" checked="checked" />
						</div>
					</fieldset>
					<ul class="dnnActions">
						<li>
							<asp:LinkButton ID="SaveEditTextLinkButton" runat="server" Text="OK" OnClientClick="SaveEditTextDnnWindow(); return false" CausesValidation="false" AutoPostBack="False" CssClass="dnnPrimaryAction rvdOKAction" /></li>
					</ul>
				</asp:Panel>
			</ContentTemplate>
		</dnn2:DnnWindow>
		<dnn2:DnnWindow runat="server" ID="EditNameDnnWindow" Title="Edit Name" Modal="False" Behaviors="Close,Move" Width="700" Height="260" Skin="Default" ReloadOnShow="True" ShowContentDuringLoad="False" OnClientClose="DnnWindowOnClientCloseHandler" OnClientShow="DnnWindowOnClientShowHandler" KeepInScreenBounds="True">
			<ContentTemplate>
				<asp:Panel ID="EditNamePanel" runat="server" DefaultButton="SaveEditNameLinkButton" CssClass="dnnForm">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="NameEditNameLabelControl" runat="server" Text="Name:" />
							<asp:TextBox ID="NameEditNameTextBox" runat="server"></asp:TextBox>
						</div>
					</fieldset>
					<ul class="dnnActions">
						<li>
							<asp:LinkButton ID="SaveEditNameLinkButton" runat="server" Text="OK" OnClientClick="SaveEditNameDnnWindow(); return false;" CausesValidation="false" AutoPostBack="False" CssClass="dnnPrimaryAction rvdOKAction" /></li>
					</ul>
				</asp:Panel>
			</ContentTemplate>
		</dnn2:DnnWindow>
		<dnn2:DnnWindow runat="server" ID="EditXmlAttributeDnnWindow" Title="Edit XML Attribute" Modal="False" Behaviors="Close,Move" Width="700" Height="260" Skin="Default" ReloadOnShow="True" ShowContentDuringLoad="False" OnClientClose="DnnWindowOnClientCloseHandler" OnClientShow="DnnWindowOnClientShowHandler">
			<ContentTemplate>
				<asp:Panel ID="EditXmlAttributePanel" runat="server" DefaultButton="SaveEditXmlAttributeLinkButton" CssClass="dnnForm">
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="NameEditXmlAttributeLabelControl" runat="server" Text="Name:" />
							<asp:TextBox ID="NameEditXmlAttributeTextBox" runat="server"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ValueEditXmlAttributeLabelControl" runat="server" Text="Value:" />
							<asp:TextBox ID="ValueEditXmlAttributeTextBox" runat="server" TextMode="SingleLine" />
						</div>
					</fieldset>
					<ul class="dnnActions">
						<li>
							<asp:LinkButton ID="SaveEditXmlAttributeLinkButton" runat="server" Text="OK" OnClientClick="SaveEditXmlAttributeDnnWindow(); return false;" CausesValidation="false" AutoPostBack="False" CssClass="dnnPrimaryAction rvdOKAction" /></li>
					</ul>
				</asp:Panel>
			</ContentTemplate>
		</dnn2:DnnWindow>
		<dnn2:DnnWindow runat="server" ID="EditXslAttributeDnnWindow" Title="Edit XSL Attribute" Modal="False" Behaviors="Close,Move" Width="800" Height="650" Skin="Default" ReloadOnShow="True" OnClientClose="DnnWindowOnClientCloseHandler" OnClientShow="DnnWindowOnClientShowHandler">
			<ContentTemplate>
				<asp:Panel ID="EditXslAttributePanel" runat="server" DefaultButton="SaveEditXslAttributeLinkButton" CssClass="dnnForm">
					<fieldset>
						<p>
							<asp:Label ID="AttributeDescriptionXslAttributeLabel" runat="server"></asp:Label>
						</p>
						<dnn2:DnnSplitter ID="DnnSplitter1" runat="server" Width="100%" Height="250px" BackColor="White">
							<dnn2:DnnSplitPane ID="DnnSplitPane1" runat="server" Width="40%" Scrolling="None">
								<dnn2:DnnTreeView ID="XslAttributeDnnTreeView" runat="server" Height="100%" Width="100%" EnableDragAndDrop="True" OnClientNodeDropping="XslAttributeDnnTreeView_ClientNodeDropping" OnClientNodeClicked="XslAttributeDnnTreeView_ClientNodeClicked">
								</dnn2:DnnTreeView>
							</dnn2:DnnSplitPane>
							<dnn2:DnnSplitBar ID="DnnSplitBar1" runat="server" />
							<dnn2:DnnSplitPane ID="DescriptionXslAttributeDnnSplitPane" runat="server" Width="60%" Scrolling="Both">
								<div style="margin: 10px;">
									<asp:Label ID="FunctionDescriptionXslAttributeLabel" runat="server"></asp:Label>
								</div>
							</dnn2:DnnSplitPane>
						</dnn2:DnnSplitter>
					</fieldset>
					<fieldset>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="ExpressionEditXslAttributeLabelControl" runat="server" Text="Expression:" />
							<asp:TextBox ID="ValueEditXslAttributeTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="120px" onmouseover="this.focus()"></asp:TextBox>
						</div>
						<div class="dnnFormItem">
							<dnn1:LabelControl ID="WordWrapEditXslAttributeLabelControl" runat="server" Text="Word wrap:" />
							<input type="checkbox" onclick="if (this.checked) document.getElementById('<%= ValueEditXslAttributeTextBox.ClientID %>').wrap='virtual'; else document.getElementById('<%= ValueEditXslAttributeTextBox.ClientID %>').wrap='off';" checked="checked" />
						</div>
					</fieldset>
					<ul class="dnnActions">
						<li>
							<asp:LinkButton ID="SaveEditXslAttributeLinkButton" runat="server" Text="OK" OnClientClick="SaveEditXslAttributeDnnWindow(); return false" CausesValidation="false" AutoPostBack="False" CssClass="dnnPrimaryAction rvdOKAction" /></li>
					</ul>
				</asp:Panel>
			</ContentTemplate>
		</dnn2:DnnWindow>
	</Windows>
</dnn2:DnnWindowManager>
