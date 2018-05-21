<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SetRevindexStorefront.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.SetRevindexStorefront" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="OperationModeLabelControl" runat="server" Text="Operation mode:" />
			<asp:RadioButtonList ID="OperationModeRadioButtonList" runat="server">
                <asp:ListItem Text="Merchant" Value="1" />
                <asp:ListItem Text="Seller" Value="2" />
			</asp:RadioButtonList>
		</div>
	</fieldset>
</div>
