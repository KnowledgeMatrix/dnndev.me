<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="VISIBILITY" Src="~/Admin/Containers/Visibility.ascx" %>
<div class="DNNContainer_Title_h6 spacingBottom">
    <h6><dnn:TITLE runat="server" id="dnnTITLE" CssClass="TitleH6" /></h6>
    <div id="contentPane" runat="server"></div>
</div>