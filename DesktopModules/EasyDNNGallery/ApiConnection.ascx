<%@ control language="C#" autoeventwireup="true" inherits="EasyDNN.Modules.EasyDNNGallery.ApiConnection, App_Web_apiconnection.ascx.af09375b" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:Panel ID="pnlMain" runat="server">
	<div id="EDGAdminContent">
		<div class="topBarWrapper">
			<div class="wrapper">
				<ul class="links">
					<li>
						<asp:Label ID="lblApiConectionTitle" runat="server" Text="API Connection" resourcekey="lblApiConectionTitle" Font-Bold="True"></asp:Label>
					</li>
				</ul>
				<ul class="actions">
					<li class="dashboardBtn">
						<asp:HyperLink ID="hlDasboard" runat="server">Dasboard</asp:HyperLink>
					</li>
					<li class="close">
						<asp:HyperLink ID="hlPowerOff" runat="server" ToolTip="Close" resourcekey="lbPowerOffResource1">Exit</asp:HyperLink>
					</li>
				</ul>
			</div>
		</div>
		<div class="mainContentWrapper">
			<div class="contentSectionWrapper color1">
				<div class="clearfix"></div>
				<div class="listItems owerFlowVisible">
					<div class="listItemsTable">
						<table>
							<tr>
								<td>
									<dnn:Label ID="lblGoogleMapsApiKey" runat="server" HelpText="Enter Google Maps API Key." Text="Enter Google Maps API Key:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbGoogleMapsAPIkey" runat="server" CssClass="large" ValidationGroup="vgSaveGooglMapsApi"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbGoogleMapsAPIkey" resourcekey="rfvtbGoogleMapsAPIkey.ErrorMessage" runat="server" ControlToValidate="tbGoogleMapsAPIkey" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSaveGooglMapsApi" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:Label ID="lblGoogleMapsSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveGoogleMapsApi" resourcekey="btnSaveGoogleMapsApi" runat="server" Text="Save Google Maps API key" OnClick="btnSaveGoogleMapsApi_Click" ValidationGroup="vgSaveGooglMapsApi" CssClass="itemEditAdd" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblGoogleReCaptchaSiteKey" runat="server" HelpText="Enter Google ReCaptcha Site key." Text="Enter Google ReCaptcha Site key:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbGoogleReCaptchaSiteKey" runat="server" CssClass="large" ValidationGroup="vgSaveGooglReCaptcha"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbGoogleReCaptchaSiteKey" runat="server" ControlToValidate="tbGoogleReCaptchaSiteKey" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSaveGooglReCaptcha" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr style="background-color:transparent;">
								<td>
									<dnn:Label ID="lblGoogleReCaptchaKey" runat="server" HelpText="Enter Google ReCaptcha Secret key." Text="Enter Google ReCaptcha Secret key:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbGoogleReCaptchaSecretKey" runat="server" CssClass="large" ValidationGroup="vgSaveGooglReCaptcha"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbGoogleReCaptchaSecretKey" runat="server" ControlToValidate="tbGoogleReCaptchaSecretKey" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSaveGooglReCaptcha" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:Label ID="lblGoogleReCaptchaSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr style="background-color:#e9e9e9;">
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveGoogleReCaptcha" runat="server" Text="Save Google ReCaptcha key" ValidationGroup="vgSaveGooglReCaptcha" CssClass="itemEditAdd" OnClick="btnSaveGoogleReCaptcha_Click" />
									</div>
								</td>
							</tr>
							<tr style="background-color:transparent;">
								<td colspan="2"></td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblAddThisProfileID" runat="server" HelpText="Enter AddThis Profile ID." Text="Enter AddThis Profile ID:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbAddThisProfileID" runat="server" CssClass="large" ValidationGroup="vgSaveAddThisProfileID"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbAddThisProfileID" resourcekey="rfvtbWistiaApiKey.ErrorMessage" runat="server" ControlToValidate="tbAddThisProfileID" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSaveAddThisProfileID" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:Label ID="lblAddThisProfileIDSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveAddThisProfileID" resourcekey="btnSaveAddThisProfileID" runat="server" Text="Save AddThis Profile ID" OnClick="btnSaveAddThisProfileID_Click" ValidationGroup="vgSaveAddThisProfileID" CssClass="itemEditAdd" />
									</div>
								</td>
							</tr>
							<tr style="background-color:transparent;">
								<td colspan="2"></td>
							</tr>
							<tr style="background-color:transparent;">
								<td>
									<dnn:Label ID="lblFlowplayerCommercialKey" runat="server" HelpText="Enter Flowplayer commercial key." Text="Enter Flowplayer commercial key:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbFlowplayerKey" runat="server" CssClass="large" ValidationGroup="vgFlowplayerCommercialKey"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvFlowplayerCommercialKey" runat="server" ControlToValidate="tbFlowplayerKey" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgFlowplayerCommercialKey" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblFlowplayerLogo" runat="server" HelpText="Enter Flowplayer logo. Enter full absolute path to the image." Text="Enter Flowplayer logo:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbFlowplayerLogoUrl" runat="server" CssClass="large" ValidationGroup="vgFlowplayerCommercialKey"></asp:TextBox>
								</td>
							</tr>
							<tr>
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="lbSaveFlowplayerCommercialKey" runat="server" Text="Save Flowplayer key and logo" ValidationGroup="vgFlowplayerCommercialKey" CssClass="itemEditAdd" OnClick="lbSaveFlowplayerCommercialKey_Click" />
										<asp:Label ID="lblFlowplayerCommercialKeySaveMessage" runat="server" EnableViewState="False"></asp:Label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr class="color1HighLighted">
								<td colspan="2">
									Video upload
								</td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblWistiaApiKey" runat="server" HelpText="Enter Wistia API key." Text="Enter Wistia API key:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbWistiaApiKey" runat="server" CssClass="large" ValidationGroup="vgSaveWistiaApi"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbWistiaApiKey" resourcekey="rfvtbWistiaApiKey.ErrorMessage" runat="server" ControlToValidate="tbWistiaApiKey" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgSaveWistiaApi" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:RegularExpressionValidator Display="Dynamic" ControlToValidate="tbWistiaApiKey" ID="revWistiaApiKey" ValidationExpression="^[\s\S]{32,}$" runat="server" ErrorMessage="Please enter valid api key." CssClass="smallInfo warning"></asp:RegularExpressionValidator>
									<asp:Label ID="lblWistiaSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveWistiaApiKey" resourcekey="btnSaveWistiaApiKey" runat="server" Text="Save Wistia API key" OnClick="btnSaveWistiaApiKey_Click" ValidationGroup="vgSaveWistiaApi" CssClass="itemEditAdd" />
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<dnn:Label ID="lblVimeoAPIToken" runat="server" HelpText="Enter Viemo API acess token." Text="Enter Viemo API acess token:" />
								</td>
								<td class="textLeft">
									<asp:TextBox ID="tbVimeoAPIToken" runat="server" CssClass="large" ValidationGroup="vgVimeoAPIToken"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvtbVimeoAPIToken" resourcekey="rfvtbVimeoAPIToken.ErrorMessage" runat="server" ControlToValidate="tbVimeoAPIToken" Display="Dynamic" ErrorMessage="This field is required." ValidationGroup="vgVimeoAPIToken" CssClass="smallInfo warning"></asp:RequiredFieldValidator>
									<asp:Label ID="lblVimeoAPITokenSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr>
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="btnSaveVimeoAPIToken" resourcekey="btnSaveVimeoAPIToken" runat="server" Text="Save Vimeo API token" ValidationGroup="vgVimeoAPIToken" CssClass="itemEditAdd" OnClick="btnSaveVimeoAPIToken_Click" />
									</div>
								</td>
							</tr>
							<tr runat="server" id="trPreferedVideoService" visible="false">
								<td>
									<dnn:Label ID="lblPreferedVideoService" runat="server" HelpText="Select prefered video service." Text="Prefered video service:" />
								</td>
								<td class="textLeft">
									<asp:DropDownList ID="ddlPreferdVideoService" runat="server"></asp:DropDownList>
									<asp:Label ID="lblPreferedVideoServiceSaveMessage" runat="server" EnableViewState="False"></asp:Label>
								</td>
							</tr>
							<tr runat="server" id="trSavePreferedVideoService" visible="false">
								<td></td>
								<td class="textLeft">
									<div class="itemActions itemEditActions">
										<asp:LinkButton ID="lbSavePreferdVideoService" runat="server" Text="Save prefered video service" CssClass="itemEditAdd" OnClick="lbSavePreferdVideoService_Click" />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</asp:Panel>
