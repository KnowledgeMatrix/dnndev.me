<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.Ideas.Settings" CodeBehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnForm">
    <div class="dnnFormItem">
        <dnn:label id="lblMode" runat="server" suffix=":" ControlName="ddlMode" />
        <asp:DropDownList runat="server" ID="ddlMode">
            <asp:ListItem Value="0" resourcekey="liNormal"></asp:ListItem>
            <asp:ListItem Value="1" resourcekey="liGroup"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="dnnFormItem">
        <dnn:label id="plMaxVotesPerItem" runat="server" controlname="ddlMaxVotesPerItem" suffix=":" />
        <asp:DropDownList ID="ddlMaxVotesPerItem" runat="server" Width="100" />
    </div>
    <div class="dnnFormItem">
        <dnn:label id="plMaxVotesPerUser" runat="server" controlname="ddlMaxVotesPerUser" suffix=":" />
        <asp:DropDownList ID="ddlMaxVotesPerUser" runat="server" Width="100" />
        <asp:CompareValidator runat="server" ControlToCompare="ddlMaxVotesPerItem" ControlToValidate="ddlMaxVotesPerUser" Operator="GreaterThan"
            ValueToCompare="Value" Display="Dynamic" Type="Integer" resourcekey="MaxVotesPerUser.ErrorMessage" />
    </div>
    <div class="dnnFormItem">
        <dnn:label id="plAllowNewIdeas" runat="server" controlname="chkAllowNewIdeas" suffix=":" />
        <asp:CheckBox ID="chkAllowNewIdeas" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:label id="plAllowVoting" runat="server" controlname="chkAllowVoting" suffix=":" />
        <asp:CheckBox ID="chkAllowVoting" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label id="plSearchResults" runat="server" controlname="txtSearchResults" suffix=": " />
        <asp:TextBox runat="server" ID="txtSearchResults"></asp:TextBox>
    </div>
    <div class="dnnFormItem">
        <dnn:label id="plShowCategories" runat="server" controlname="chkShowCategories" suffix=":" />
        <asp:CheckBox ID="chkShowCategories" runat="server" />
    </div>
    <div class="dnnFormItem" id="rootVocabulary">
        <dnn:label id="plRootCategory" runat="server" controlname="drpRootCategory" suffix=":" />
        <asp:DropDownList ID="drpRootCategory" runat="server" Width="150" />
        <asp:HyperLink runat="server" ID="lnkAddVocabulary" Visible="False" resourcekey="AddVocabularyLink" Target="_blank"></asp:HyperLink>
        &nbsp;|&nbsp;
                <asp:LinkButton runat="server" ID="lnkRefreshVocabularyList" resourcekey="RefreshVocabularyList" OnClick="OnRefreshVocabClick"></asp:LinkButton>
    </div>
</div>
