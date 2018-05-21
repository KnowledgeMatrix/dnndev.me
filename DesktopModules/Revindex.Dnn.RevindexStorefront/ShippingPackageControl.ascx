<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ShippingPackageControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.ShippingPackageControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<div class="rvdFormSubContainer">
	<asp:MultiView ID="ContentMultiView" runat="server">
		<asp:View ID="ListView" runat="server">
			<dnn2:DnnTreeView ID="ShippingPackageDnnTreeView" runat="server" EnableDragAndDrop="True" EnableDragAndDropBetweenNodes="True" CheckBoxes="False" OnNodeClick="ShippingPackageDnnTreeView_NodeClick" OnNodeDrop="ShippingPackageDnnTreeView_NodeDrop">
			</dnn2:DnnTreeView>
			<div class="dnnActions dnnClear">
				<asp:LinkButton ID="AddShippingPackageLinkButton" runat="server" CssClass="dnnPrimaryAction rvdAddNewAction" Text="Add new" OnClick="AddShippingPackageLinkButton_Click" ValidationGroup="ShippingPackageDetailsViewControl" CausesValidation="False"></asp:LinkButton>
			</div>
		</asp:View>
		<asp:View ID="ShippingPackageDetailsView" runat="server">
			<asp:HiddenField ID="GuidShippingPackageHiddenField" runat="server" />
			<asp:HiddenField ID="InternalDepthShippingPackageHiddenField" runat="server" />
			<asp:HiddenField ID="InternalWidthShippingPackageHiddenField" runat="server" />
			<asp:HiddenField ID="InternalHeightShippingPackageHiddenField" runat="server" />
			<asp:HiddenField ID="MaxQuantityCapacityShippingPackageHiddenField" runat="server" />
			<asp:HiddenField ID="MaxWeightCapacityShippingPackageHiddenField" runat="server" />
			<asp:Panel ID="CopyPackagePanel" runat="server" CssClass ="dnnFormItem">
				<dnn1:LabelControl ID="CopyPackageLabelControl" runat="server" Text="Copy from package:" />
				<asp:DropDownList ID="CopyPackageDropDownList" runat="server" OnSelectedIndexChanged="CopyPackageDropDownList_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
			</asp:Panel>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="NameShippingPackageLabelControl" runat="server" Text="Name:" />
				<asp:TextBox ID="NameShippingPackageTextBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="PackageTypeShippingPackageLabelControl" runat="server" Text="Package type:" />
				<asp:DropDownList ID="PackageTypeShippingPackageDropDownList" runat="server">
					<asp:ListItem Value="3000" Text="Bag"></asp:ListItem>
					<asp:ListItem Value="2000" Text="Box"></asp:ListItem>
					<asp:ListItem Value="1000" Text="Envelope"></asp:ListItem>
					<asp:ListItem Value="5000" Text="Pallet"></asp:ListItem>
					<asp:ListItem Value="4000" Text="Tube"></asp:ListItem>
					<asp:ListItem Value="1" Text="Unspecified"></asp:ListItem>
				</asp:DropDownList>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WidthShippingPackageLabelControl" runat="server" Text="Width:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="WidthShippingPackageRequiredFieldValidator" runat="server" ControlToValidate="WidthShippingPackageDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Weight is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="WidthShippingPackageDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="HeightShippingPackageLabelControl" runat="server" Text="Height:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="HeightShippingPackageRequiredFieldValidator" runat="server" ControlToValidate="HeightShippingPackageDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Height is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="HeightShippingPackageDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="DepthShippingPackageLabelControl" runat="server" Text="Depth:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="DepthShippingPackageRequiredFieldValidator" runat="server" ControlToValidate="DepthShippingPackageDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Depth is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="DepthShippingPackageDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WeightShippingPackageLabelControl" runat="server" Text="Weight:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="WeightShippingPackageRequiredFieldValidator" runat="server" ControlToValidate="WeightShippingPackageDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Weight is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="WeightShippingPackageDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="InsurredAmountShippingPackageLabelControl" runat="server" Text="Insurred amount:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="InsurredAmountShippingPackageRequiredFieldValidator" runat="server" ControlToValidate="InsurredAmountShippingPackageDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Insurred amount is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="InsurredAmountShippingPackageDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="ShippingCodeShippingPackageLabelControl" runat="server" Text="Shipping code:" />
				<asp:TextBox ID="ShippingCodeShippingPackageTextBox" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="QuantityShippingPackageLabelControl" runat="server" Text="Total items:" />
				<asp:Label ID="QuantityShippingPackageLabel" runat="server" style="margin-right: 40px" />
				<asp:LinkButton ID="AddShippingItemLinkButton" runat="server" CssClass="dnnPrimaryAction rvdAddNewAction" Text="Add new" OnClick="AddShippingItemLinkButton_Click" ValidationGroup="ShippingPackageDetailsViewControl" CausesValidation="False"></asp:LinkButton>
			</div>
			<div class="rvdActions">
				<asp:LinkButton ID="SaveShippingPackageButton" runat="server" CssClass="dnnPrimaryAction rvdSaveAction" Text="OK" OnClick="SaveShippingPackageButton_Click" ValidationGroup="ShippingPackageDetailsViewControl"></asp:LinkButton>
				<asp:LinkButton ID="DeleteShippingPackageLinkButton" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="dnnSecondaryAction rvdDeleteAction" OnClick="DeleteShippingPackageLinkButton_Click" Text="Delete"></asp:LinkButton>
				<asp:LinkButton ID="CancelShippingPackageButton" runat="server" CssClass="dnnSecondaryAction rvdCancelAction" Text="Cancel" OnClick="CancelShippingPackageButton_Click" CausesValidation="False"></asp:LinkButton>
			</div>
		</asp:View>
		<asp:View ID="ShippingItemDetailsView" runat="server">
			<asp:HiddenField ID="GuidShippingItemHiddenField" runat="server" />
			<asp:HiddenField ID="ParentGuidShippingItemHiddenField" runat="server" />
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="SalesOrderDetailIDShippingItemLabelControl" runat="server" Text="Order detail:" />
				<asp:DropDownList ID="SalesOrderDetailIDShippingItemDropDownList" runat="server" OnSelectedIndexChanged="SalesOrderDetailIDShippingItemDropDownList_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="QuantityShippingItemLabelControl" runat="server" Text="Quantity:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="QuantityShippingItemRequiredFieldValidator" runat="server" ControlToValidate="QuantityShippingItemDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Quantity is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="QuantityShippingItemDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="1" EnableSingleInputRendering="False" Value="1" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="InsurredAmountShippingItemLabelControl" runat="server" Text="Insurred amount:" CssClass="dnnFormRequired" />
				<asp:RequiredFieldValidator ID="InsurredAmountShippingItemRequiredFieldValidator" runat="server" ControlToValidate="InsurredAmountShippingItemDnnNumericTextBox" CssClass="dnnFormMessage dnnFormError" Display="Dynamic" ValidationGroup="ShippingPackageDetailsViewControl">Insurred amount is required.</asp:RequiredFieldValidator>
				<dnn2:DnnNumericTextBox ID="InsurredAmountShippingItemDnnNumericTextBox" runat="server" Skin="" NumberFormat-DecimalDigits="4" NumberFormat-GroupSizes="9" MinValue="0" EnableSingleInputRendering="False" Value="0.00" CssClass="dnnFormRequired">
				</dnn2:DnnNumericTextBox>
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WidthShippingItemLabelControl" runat="server" Text="Width:" />
				<asp:Label ID="WidthShippingItemLabel" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="HeightShippingItemLabelControl" runat="server" Text="Height:" />
				<asp:Label ID="HeightShippingItemLabel" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="DepthShippingItemLabelControl" runat="server" Text="Depth:" />
				<asp:Label ID="DepthShippingItemLabel" runat="server" />
			</div>
			<div class="dnnFormItem">
				<dnn1:LabelControl ID="WeightShippingItemLabelControl" runat="server" Text="Weight:" />
				<asp:Label ID="WeightShippingItemLabel" runat="server" />
			</div>
			<div class="rvdActions">
				<asp:LinkButton ID="SaveShippingItemButton" runat="server" CssClass="dnnPrimaryAction rvdSaveAction" Text="OK" OnClick="SaveShippingItemButton_Click" ValidationGroup="ShippingPackageDetailsViewControl"></asp:LinkButton>
				<asp:LinkButton ID="DeleteShippingItemLinkButton" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this item?')" CssClass="dnnSecondaryAction rvdDeleteAction" OnClick="DeleteShippingItemLinkButton_Click" Text="Delete"></asp:LinkButton>
				<asp:LinkButton ID="CancelShippingItemButton" runat="server" CssClass="dnnSecondaryAction rvdCancelAction" Text="Cancel" OnClick="CancelShippingItemButton_Click" CausesValidation="False"></asp:LinkButton>
			</div>
		</asp:View>
	</asp:MultiView>
</div>
