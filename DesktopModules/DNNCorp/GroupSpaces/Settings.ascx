<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.GroupSpaces.Settings" Codebehind="Settings.ascx.cs" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="dnnFormItem">
    <dnn:label controlname="featuresListMode" resourcekey="FeaturesListMode" Text="Features List Mode" Suffix=":" runat="server" />   
    <div class="featureListModeContainer">
	    <div class="featureListModeWarning dnnFormMessage dnnFormWarning">
		    <asp:label ID="featureListWarning" runat="server" resourcekey="FeaturesListModeWarning"></asp:label>
		</div>
	    <asp:RadioButtonList ID="featuresListMode" runat="server">
	        <asp:ListItem Value="1" resourcekey="SingleLevel" Selected="True">Single Level</asp:ListItem>
	        <asp:ListItem Value="2" resourcekey="TwoLevel">Two Level (Child Pages)</asp:ListItem>
	    </asp:RadioButtonList>
    </div>
</div>
