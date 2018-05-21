<%@ Control language="C#" Inherits="DotNetNuke.Professional.Challenges.LatestSettings" AutoEventWireup="false"  Codebehind="LatestSettings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>
<div class="dnnClear dnnForm">
    <div class="dnnFormItem">
        <dnn:label id="lblPageSize" runat="server" suffix=":" ControlName="ddlPageSize"  />
        <asp:DropDownList runat="server" ID="ddlPageSize">
            <Items>
                <asp:ListItem Value="5">5</asp:ListItem>
                <asp:ListItem Value="10">10</asp:ListItem>
                <asp:ListItem Value="15">15</asp:ListItem>
                <asp:ListItem Value="20">20</asp:ListItem>
            </Items>
        </asp:DropDownList>
    </div>
</div>