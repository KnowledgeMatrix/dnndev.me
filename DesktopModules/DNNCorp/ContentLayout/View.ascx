<%@ Control language="C#" Inherits="DotNetNuke.Professional.ContentLayout.View" CodeBehind="View.ascx.cs" AutoEventWireup="false" ViewStateMode="Disabled" EnableViewState="false"  %>

<div id="LayoutContainer" runat="server" class="layoutContainer container-fluid dnn-cl">
    <div class="row" runat="server" id="Row">
    </div>
</div>
<asp:Panel runat="server" ID="EditorScript" Visible="False">
<script type="text/javascript">
	(function($) {
		$(window).load(function () {
			$('#<%=LayoutContainer.ClientID%>').dnnLayoutEditor({
				desktopModuleId: <%=DesktopModuleId%>,
				moduleId: <%=ModuleId%>,
				layoutPrefix: '<%=LayoutPrefix%>'
			});
		});
	})(jQuery);
</script>
</asp:Panel>