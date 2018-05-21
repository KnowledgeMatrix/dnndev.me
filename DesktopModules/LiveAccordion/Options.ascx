<%@ Control Language="C#" CodeBehind="Options.ascx.cs" AutoEventWireup="true" Inherits="Mandeeps.DNN.Modules.LiveAccordion.Options" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/Labelcontrol.ascx" %>
<%@ Register Assembly="Mandeeps.Web" Namespace="Mandeeps.Web.UI.WebControls" TagPrefix="Mandeeps" %>
<style type="text/css">
    .MNormal
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalBold
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
    }
    .MNormalRed
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: bold;
        color: #ff0000;
    }
    .MHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 20px;
        font-weight: normal;
        color: #333333;
    }
    .MSubHead
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: bold;
        color: #003366;
    }
    .MCommandButton
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 11px;
        font-weight: normal;
    }
    .MNormalTextBox
    {
        font-family: Tahoma, Arial, Helvetica;
        font-size: 12px;
        font-weight: normal;
    }
    .verticalalign tr td{vertical-align:top;}
</style>
<div class="livetabsverticalvertical">
    <Mandeeps:TabStrip runat="server" ID="VerticalTabs" CssClass="verticalalign" Theme="Vertical" ThemePath="~/DesktopModules/LiveAccordion/Resources/Tabs">
        <Mandeeps:Tab ID="BasicTab" runat="server">
            <asp:Label ID="lBasic" runat="server" CssClass="tabheading" resourcekey="lBasic"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td colspan="2">
                        <div style="font-size: 11px; background-color: InactiveBorder; border-radius: 5px;
                            -moz-border-radius: 5px; webkit-border-radius: 5px; border: 1px solid #999999;
                            padding: 5px;">
                            <asp:Label ID="lStateInfo" runat="server" /></div>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td width="230">
                        <dnn:Label ID="lTabMode" runat="server" HelpText="Hides Single Tab - Use if you don't want to show a lone tab."
                            Text="Tab Mode" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlPaneMode" runat="server" Width="225px" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlTabMode_SelectedIndexChanged">
                            <asp:ListItem Value="Default" resourcekey="Default" Selected="True"></asp:ListItem>
                            <asp:ListItem Value="Advanced" resourcekey="Advanced"></asp:ListItem>
                            <asp:ListItem Value="SQLQuery" resourcekey="SQLQuery"></asp:ListItem>
                            <asp:ListItem Value="RSSFeed" resourcekey="RSSFeed"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="FeedUrl" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lFeedUrl" runat="server" Text="Feed Url" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbFeeUrl" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="MaxTitleLength" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lMaxTitleLength" runat="server" Text="Max Title Length" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbMaxTitleLength" runat="server" Width="75px"></asp:TextBox>&nbsp;
                        <asp:DropDownList ID="ddlTitleLengthUnit" runat="server" Width="135px">
                            <asp:ListItem Value="Character" resourcekey="Character" Selected="True">Character</asp:ListItem>
                            <asp:ListItem Value="Words" resourcekey="Words">Words</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="MaxPanelength" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lMaxPaneLength" runat="server" HelpText="Specify maximum number of pane"
                            Text="Maximum Panes" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbMaxPaneLength" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="UseToken" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lUseToken" runat="server" Text="Use Token" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbUseToken" runat="server" Width="220px"></asp:TextBox>
                    </td>
                </tr>
                <tr id="CatchTime" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lCacheTime" runat="server" Text="Catch Time" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbCacheTime" runat="server" Width="75px"></asp:TextBox>&nbsp;
                        <asp:Label ID="lMinutes" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr id="SqlIntegration" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lSQLConnection" runat="server" HelpText="The Source of the Image to Add." />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSQLConnection" Style="width: 225px;" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr id="SqlQuery" runat="server" visible="false">
                    <td>
                        <dnn:Label ID="lSQLquery" runat="server" HelpText="The Source of the Image to Add." />
                    </td>
                    <td>
                        <asp:TextBox ID="tbSQLquery" Visible="true" runat="server" Style="width: 550px" Rows="9"
                            TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lLayout" runat="server" CssClass="tabheading" resourcekey="lLayout"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td width="230">
                        <dnn:Label ID="lWidth" runat="server" HelpText="Optionally specify a width; otherwise, module will dynamically resize."
                            Text="Width" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbSpecifyWidth" runat="server" AutoPostBack="True" OnCheckedChanged="cbSpecifyWidth_CheckedChanged"
                            resourcekey="cbSpecifyWidth" Text="Specify Width" />
                    </td>
                </tr>
                <tr id="RowWidth" runat="server" visible="False">
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="tbWidth" runat="server" Width="75px"></asp:TextBox>
                        &nbsp;<asp:Label ID="lWidthPixels" runat="server" resourcekey="lWidthPixels" Font-Italic="True"
                            Font-Size="10pt" Text="pixels"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lHeight" runat="server" HelpText="Optionally specify a height; otherwise, module will dynamically resize"
                            Text="Height" />
                    </td>
                    <td>
                        <asp:RadioButton ID="rbAutoHeight" runat="server" AutoPostBack="True" GroupName="MLAHeight"
                            resourcekey="rbAutoHeight" OnCheckedChanged="rbAutoHeight_CheckedChanged" Text="Auto Height" />
                        <br />
                        <asp:RadioButton ID="rbDynamicHeight" runat="server" AutoPostBack="True" GroupName="MLAHeight"
                            resourcekey="rbDynamicHeight" OnCheckedChanged="rbDynamicHeight_CheckedChanged"
                            Text="Dynamic Height" />
                        <br />
                        <asp:RadioButton ID="rbSpecifyHeight" runat="server" AutoPostBack="True" GroupName="MLAHeight"
                            resourcekey="rbSpecifyHeight" OnCheckedChanged="rbSpecifyHeight_CheckedChanged"
                            Text="Specify Height" />
                    </td>
                </tr>
                <tr id="RowHeight" runat="server" visible="False">
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:TextBox ID="tbHeight" runat="server" Width="75px"></asp:TextBox>
                        <asp:Label ID="lHeightPixels" runat="server" resourcekey="lWidthPixels" Font-Italic="True"
                            Font-Size="10pt" Text="pixels"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lEffects" runat="server" CssClass="tabheading" resourcekey="lEffects"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table style="width: 550px; text-align: left;">
                <tr>
                    <td style="width: 230px">
                        <dnn:Label ID="lAnimated" runat="server" HelpText="Animation" Text="Animation" />
                    </td>
                    <td>
                        <asp:RadioButtonList ID="rbAnimated" runat="server">
                            <asp:ListItem Value="None" resourcekey="rbAnimatedNone">None</asp:ListItem>
                            <asp:ListItem Value="Slide" resourcekey="rbAnimatedSlide">Slide</asp:ListItem>
                            <asp:ListItem Value="BounceSlide" resourcekey="rbAnimatedBounceSlide">BounceSlide</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
        <Mandeeps:Tab ID="AdvancedTab" runat="server">
            <asp:Label ID="lAdvancedSettings" runat="server" CssClass="tabheading" resourcekey="lAdvancedSettings"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td width="230">
                        <dnn:Label ID="lSelectOnMouseover" runat="server" HelpText="Automatically selects the tab on mouseover"
                            Text="Auto Select Tab" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbSelectOnMouseover" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lPanesPersistence" runat="server" HelpText="Remembers the last selected pane on postback or when user returns to the page"
                            Text="Panes Persistence" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbPanesPersistence" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lEnableThemeScript" runat="server" HelpText="If enabled read the javascript file with same name of selected theme from the directory of theme. e.g. Mytheme/Mytheme.js"
                            Text="Enable ThemeScript" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbEnableThemeScript" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lIntelligentPaneLink" runat="server" HelpText="Enables Scroll to pane link"
                            Text="Intelligent Pane Link" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbIntelligentPaneLink" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lCollapsible" runat="server" HelpText="Remembers the last selected tab on postback or when user returns to the page"
                            Text="Collapsible" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbCollapsible" runat="server" AutoPostBack="True" OnCheckedChanged="cbCollapsible_CheckedChanged" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lCollapsed" runat="server" HelpText="Collapsed" Text="Initially Collapsed"
                            Visible="False" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbCollapsed" runat="server" Visible="False" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lLoadOnDemand" runat="server" HelpText="Hides Single Tab - Use if you don't want to show a lone tab."
                            Text="Load on Demand" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbLoadAndDemand" runat="server" Visible="True" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:Label ID="lAnalytic" runat="server" CssClass="tabheading" resourcekey="lAnalytic"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td width="230">
                        <dnn:Label ID="lTrackClicks" runat="server" HelpText="Track individual tab clicks using Google Analytics"
                            Text="Track Clicks" Visible="True" />
                    </td>
                    <td>
                        <asp:CheckBox ID="cbTrackClicks" runat="server" OnCheckedChanged="cbTrackClicks_CheckedChanged"
                            AutoPostBack="True" />
                    </td>
                </tr>
            </table>
            <table style="width: 100%" id="TableTrackClicks" runat="server" visible="false">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lEventCategory" runat="server" HelpText="Google Analytics Event Tracking Category"
                            Text="Event Category" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackCategory" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lEventAction" runat="server" HelpText="Google Analytics Event Tracking Action"
                            Text="Event Action" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackAction" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:Label ID="lEventLabel" runat="server" HelpText="Google Analytics Event Tracking Label"
                            Text="Event Label" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackLabel" runat="server" Width="350px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        <asp:RadioButton ID="rbTrackingCodeExists" runat="server" resourcekey="rbTrackingCodeExists"
                            GroupName="GA" Text="Google Analytics Tracking Code is already on the page..."
                            AutoPostBack="True" CssClass="MNormal" OnCheckedChanged="rbTrackingCodeExists_CheckedChanged" />
                        <br />
                        <asp:RadioButton ID="rbInsertTrackingCode" runat="server" resourcekey="rbInsertTrackingCode"
                            AutoPostBack="True" GroupName="GA" OnCheckedChanged="rbInsertTrackingCode_CheckedChanged"
                            Text="Let me provide my Google Analytics Tracking code..." CssClass="MNormal" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 230px" valign="top">
                        <dnn:Label ID="lTrackingCode" runat="server" HelpText="Provide the Google Analytics Tracking code"
                            Text="Tracking Code" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbTrackingCode" runat="server" Height="200px" TextMode="MultiLine"
                            Width="350px"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
        <Mandeeps:Tab ID="ThemeTab" runat="server">
            <asp:Label ID="lThemeHeading" runat="server" CssClass="tabheading" resourcekey="lThemeHeading"></asp:Label>
            <hr size="1" style="color: #cccccc" />
            <table width="100%">
                <tr>
                    <td style="width: 130px">
                        <dnn:Label ID="lThemes" runat="server" HelpText="Available Themes" Text="Themes" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlThemes" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlThemes_SelectedIndexChanged"
                            Width="200px">
                        </asp:DropDownList>
                    </td>
                    <td rowspan="9">
                        <asp:Image ID="imgSkin" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
        <Mandeeps:Tab ID="WorkflowTab" runat="server">
            <table width="100%" cellpadding="3px" cellspacing="3px">
                <tr>
                    <td width="230px">
                        <dnn:label id="lHistoryMaximum" runat="server" helptext="Set Maximum History." suffix=":"
                            resourcekey="lHistoryMaximum" />
                    </td>
                    <td>
                        <asp:TextBox ID="tbHistoryMaximum" runat="server" Width="300"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dnn:label id="lWorkflow" runat="server" helptext="Select Workflow to apply." suffix=":"
                            resourcekey="lWorkflow" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlWorkflow" Width="160" runat="server" OnSelectedIndexChanged="ddlWorkflow_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="lnkManageWorkflows" runat="server" CssClass="mbutton" resourceKey="lnkManageWorkflows"
                            OnClick="lnkManageWorkflows_Click"></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td>
                        <br style="line-height: 5px" />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <div class="caption" style="width: 294px;">
                            <asp:Label ID="lWorlflowStateInfo" runat="server"></asp:Label></div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <br />
                    </td>
                </tr>
                <tr id="ApplyWorkflow" runat="server">
                    <td>
                        <dnn:label id="lapplyLhWorkflow" runat="server" helptext="Select which object this workflow applies to."
                            suffix=":" resourcekey="lapplyLhWorkflow" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlapplyLhworkflow" runat="server" Width="160">
                            <asp:ListItem Value="Module" resourcekey="ApplyModule" />
                            <asp:ListItem Value="Page" resourcekey="ApplyPage" />
                            <asp:ListItem Value="Site" resourcekey="ApplySite" />
                        </asp:DropDownList>
                        <asp:CheckBox ID="cbReplaceSettings" runat="server" resourcekey="cbReplaceSettings"
                            Font-Bold="true" />
                    </td>
                </tr>
            </table>
        </Mandeeps:Tab>
    </Mandeeps:TabStrip>
    <br />
    <asp:LinkButton ID="bUpdate" resourcekey="bUpdate" runat="server" CssClass="mbutton"
        OnClick="bUpdate_Click"></asp:LinkButton>
    <asp:LinkButton ID="cmdCancel" runat="server" resourcekey="cmdCancel" Text="Return"
        CssClass="mbutton2" CausesValidation="False" OnClick="cmdCancel_Click" />
</div>
