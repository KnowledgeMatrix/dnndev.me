<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="DNNContainer_Title_h5 spacingBottom">
    <h5><dnn:TITLE runat="server" id="dnnTITLE" CssClass="TitleH5" /></h5>
    <div id="contentPane" runat="server"></div>
</div>