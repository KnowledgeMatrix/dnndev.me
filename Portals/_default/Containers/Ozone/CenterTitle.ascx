<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="StyleWizard" TagName="Container" Src="~/DesktopModules/EasyDNNstyleWizard/SkinObjects/Container.ascx" %>
<div class="<StyleWizard:Container runat="server" id="OzoneContainer" templateGroup="titleStyle1" /> eds_titleSeparator eds_centerTitle">
	<h2><dnn:TITLE runat="server" id="dnnTITLE" CssClass="eds_containerTitle" /></h2>
	<div id="ContentPane" runat="server"></div>
	<div class="eds_clear"></div>
</div>
