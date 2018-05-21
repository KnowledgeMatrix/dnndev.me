<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CollapsibleTextEditorControl.ascx.cs"
	Inherits="Revindex.Web.UI.WebUserControls.Dnn.CollapsibleTextEditorControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
	Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/Controls/texteditor.ascx" TagName="TextEditor" TagPrefix="uc1" %>
<div id="CollapsiblePanel" runat="server" enableviewstate="False">
	<uc1:TextEditor ID="MainTextEditor" runat="server" />
</div><asp:Image ID="EditImage" ImageUrl="~/images/edit.gif" runat="server" style="cursor:pointer" EnableViewState="False" />