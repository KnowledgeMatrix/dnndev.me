<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GalleryConfigurationControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.GalleryConfigurationControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<h2>
	Gallery</h2>
<asp:PlaceHolder ID="MessagePlaceHolder" runat="server" />
<div class="dnnForm">
	<fieldset>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsDetailedWidthLabelControl" runat="server" Text="Detailed width:" HelpText="&quot;Detailed&quot; is the large size image shown when the customer wants to see a detailed image." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GalleryProductsDetailedWidthRequiredFieldValidator" runat="server" ControlToValidate="GalleryProductsDetailedWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="GalleryProductsDetailedWidthRangeValidator" runat="server" ControlToValidate="GalleryProductsDetailedWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RangeValidator>
			<asp:TextBox ID="GalleryProductsDetailedWidthTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsDisplayWidthLabelControl" runat="server" Text="Display width:" HelpText="&quot;Display&quot; is the medium size image shown on the product detail page." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GalleryProductsDisplayWidthRequiredFieldValidator" runat="server" ControlToValidate="GalleryProductsDisplayWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="GalleryProductsDisplayWidthRangeValidator" runat="server" ControlToValidate="GalleryProductsDisplayWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RangeValidator>
			<asp:TextBox ID="GalleryProductsDisplayWidthTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsTileWidthLabelControl" runat="server" Text="Tile width:" HelpText="Set the width for the small icon tiles underneath the product detail display image." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GalleryProductsTileWidthRequiredFieldValidator" runat="server" ControlToValidate="GalleryProductsTileWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="GalleryProductsTileWidthRangeValidator" runat="server" ControlToValidate="GalleryProductsTileWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RangeValidator>
			<asp:TextBox ID="GalleryProductsTileWidthTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsThumbnailWidthLabelControl" runat="server" Text="Thumbnail width:" HelpText="&quot;Thumbnail&quot; is the small size image shown on the product list page." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GalleryProductsThumbnailWidthLabelControlRequiredFieldValidator" runat="server" ControlToValidate="GalleryProductsThumbnailWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="GalleryProductsThumbnailWidthLabelControlRangeValidator" runat="server" ControlToValidate="GalleryProductsThumbnailWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RangeValidator>
			<asp:TextBox ID="GalleryProductsThumbnailWidthTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsZoomActiveLabelControl" runat="server" Text="Enable zoom:" HelpText="If you enable zoom, you need to ensure your set of related gallery images in different sizes have the same display order value." />
			<asp:CheckBox ID="GalleryProductsZoomActiveCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsZoomEffectLabelControl" runat="server" Text="Zoom effect:" HelpText="The zoom effect to use." />
			<asp:DropDownList ID="GalleryProductsZoomEffectDropDownList" runat="server">
				<asp:ListItem Text="Standard" Value="standard" />
				<asp:ListItem Text="InnerZoom" Value="innerzoom" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsZoomPositionLabelControl" runat="server" Text="Zoom position:" HelpText="The zoom position left or right of the display gallery." />
			<asp:DropDownList ID="GalleryProductsZoomPositionDropDownList" runat="server">
				<asp:ListItem Text="Left" Value="left" />
				<asp:ListItem Text="Right" Value="right" />
			</asp:DropDownList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="GalleryProductsZoomWidthLabelControl" runat="server" Text="Zoom width:" HelpText="The width of the zoom window." CssClass="dnnFormRequired"/>
			<asp:RequiredFieldValidator ID="GalleryProductsZoomWidthRequiredFieldValidator" runat="server" ControlToValidate="GalleryProductsTileWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ConfigurationDetailsViewControl">Width is required.</asp:RequiredFieldValidator>
			<asp:RangeValidator ID="GalleryProductsZoomWidthRangeValidator" runat="server" ControlToValidate="GalleryProductsZoomWidthTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" MaximumValue="2000" MinimumValue="0" Type="Integer" ValidationGroup="ConfigurationDetailsViewControl">Width is invalid.</asp:RangeValidator>
			<asp:TextBox ID="GalleryProductsZoomWidthTextBox" runat="server" MaxLength="50" CssClass="dnnFormRequired" />
		</div>
	</fieldset>
	<ul class="dnnActions">
		<li>
			<asp:LinkButton ID="SaveLinkButton" runat="server" Text="Save" OnClick="SaveLinkButton_Click" ValidationGroup="ConfigurationDetailsViewControl" CssClass="dnnPrimaryAction rvdSaveAction" /></li>
	</ul>
</div>
