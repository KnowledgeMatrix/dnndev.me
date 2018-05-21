<%@ Control Language="C#" AutoEventWireup="false" Inherits="DotNetNuke.Professional.SocialShare.Settings" Codebehind="Settings.ascx.cs" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<div class="dnnClear dnnForm dnnSocialShareSettings" id="dnnSocialShareSettings">
    <div class="dnnFormItem">
        <dnn:label runat="server" id="ShareLabel" suffix=":" controlname="chkShareLabel" />
        <asp:CheckBox runat="server" ID="chkShareLabel" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_GooglePlus" suffix=":" controlname="chkGoogle" />
        <asp:CheckBox runat="server" ID="chkGoogle" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_Twitter" suffix=":" controlname="chkTwitter" />
        <asp:CheckBox runat="server" ID="chkTwitter" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_LinkedIn" suffix=":" controlname="chkLinkedIn" />
        <asp:CheckBox runat="server" ID="chkLinkedIn" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_Facebook" suffix=":" controlname="chkFacebook" />
        <asp:CheckBox runat="server" ID="chkFacebook" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_Pinterest" suffix=":" controlname="chkPinterest" />
        <asp:CheckBox runat="server" ID="chkPinterest" />
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_Facebook_Like" suffix=":" controlname="chkFacebookLike" />
        <asp:CheckBox runat="server" ID="chkFacebookLike" AutoPostBack="True"/>
    </div>
    <div class="dnnFormItem">
        <dnn:label runat="server" id="Service_Facebook_Like_Style" suffix=":" controlname="ddlFacebookStyle" />
        <asp:DropDownList runat="server" ID="ddlFacebookStyle">
            <Items>
                <asp:ListItem Value="standard" Text="Standard"></asp:ListItem>
                <asp:ListItem Value="button" Text="Like button only"></asp:ListItem>
                <asp:ListItem Value="button_count" Text="Like button, Share count"></asp:ListItem>
            </Items>
        </asp:DropDownList>
    </div>     
    <div class="dnnFormItem">
        <dnn:label runat="server" id="PreferredTransformer" suffix=":" controlname="rblTransformer" />
        <asp:RadioButtonList ID="rblTransformer" runat="server" CssClass="dnnFormRadioButtons" RepeatDirection="Horizontal">
            <asp:ListItem Value="isgd" resourcekey="Service_isgd" Selected="True" />
            <asp:ListItem Value="tinyurl" resourcekey="Service_tinyurl" />
            <asp:ListItem Value="bitly" resourcekey="Service_bitly" />
            <asp:ListItem Value="cligs" resourcekey="Service_cligs" />
        </asp:RadioButtonList>
    </div>
    <div class="dnnClear" id="divBitly">
        <div class="dnnFormItem">
		    <dnn:Label runat="server" id="BitlyUsername" CssClass="dnnFormRequired" suffix=":" controlname="txtBitlyUsername"  />
		    <asp:TextBox runat="server" ID="txtBitlyUsername" CssClass="required" />
	    </div>
	    <div class="dnnFormItem">
		    <dnn:label runat="server" id="BitlyApiKey" CssClass="dnnFormRequired" suffix=":" controlname="txtBitlyApiKey"  />
		    <asp:TextBox runat="server" ID="txtBitlyApiKey" CssClass="required" />
	    </div>
    </div>
    <div class="dnnClear" id="divCligs">
        <div class="dnnFormItem">
		    <dnn:Label runat="server" id="CligsAppId" CssClass="dnnFormRequired" suffix=":" controlname="txtCligsAppId" />
		    <asp:TextBox runat="server" ID="txtCligsAppId" CssClass="required" />
	    </div>
	    <div class="dnnFormItem">
		    <dnn:label runat="server" id="CligsKey" CssClass="dnnFormRequired" suffix=":" controlname="txtCligsKey" />
		    <asp:TextBox runat="server" ID="txtCligsKey" CssClass="required" />
	    </div>
    </div>
</div>
<script language="javascript" type="text/javascript">
/*globals jQuery, window, Sys */
(function($, sys) {
    function toggleServiceType(animation) {
        var serviceType = $('#<%= rblTransformer.ClientID %> input:checked').val(); /*any,bitly*/
        if (serviceType == "bitly") {
            animation ? $('#divBitly').slideDown('fast') : $('#divBitly').show();
            animation ? $('#divCligs').slideUp() : $('#divCligs').hide();
        }
        else if (serviceType == "cligs") {
            animation ? $('#divCligs').slideDown('fast') : $('#divCligs').show();
            animation ? $('#divBitly').slideUp() : $('#divBitly').hide();
        } else {
            animation ? $('#divBitly').slideUp('') : $('#divBitly').hide();
            animation ? $('#divCligs').slideUp('') : $('#divCligs').hide();
        }
    }

    function setupDnnSiteSettings() {
        toggleServiceType(false);
        $('#<%= rblTransformer.ClientID %>').change(function () {
            toggleServiceType(true);
        });
    }
    
    $(document).ready(function () {
        setupDnnSiteSettings();
        sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
            setupDnnSiteSettings();
        });
    });
} (jQuery, window.Sys));
</script>