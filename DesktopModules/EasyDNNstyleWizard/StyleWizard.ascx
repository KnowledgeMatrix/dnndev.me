<%@ control language="C#" inherits="EasyDNNSolutions.EasyDNNstyleWizard.StyleWizard, App_Web_stylewizard.ascx.794c5fcb" autoeventwireup="true" enableviewstate="false" %>

<%=mainJs %>

<div runat="server" id ="mainContainer" visible="true" class="styleWizardModuleContainer">
	<asp:Literal runat="server" id ="mainInformationSection" visible="false"></asp:Literal>
	<asp:Literal runat="server" id ="errorsContainer" visible="false"></asp:Literal>
	<div runat="server" id="debugContainer" class="debugging" visible="false">
		<div class="jsonDebugger">
			<button class="trigger">Debug JSON</button>
			<div class="results" style="display: none;"></div>
		</div>
	</div>
</div>