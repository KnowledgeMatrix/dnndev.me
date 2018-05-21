<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Display.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.Portals._default.Display.CartSummary.Standard4.Display" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<div class="rvdsfCartSummaryContainer">

	<script type="text/javascript">

	    // Show the cart detail on mouse over		
	    var cartDetailTimer = null;
	    jQuery(document).ready(function ($)
	    {
	        var cartModifiedMessageLabel = jQuery("#<%= CartModifiedMessageLabel.ClientID %>");
		    if (cartModifiedMessageLabel.length)
		    {
		        cartModifiedMessageLabel.slideDown().delay(5000).slideUp();
		    }

		    if ($("div.rvdsfCartSummaryDetailContainer").length)
		    {
		        $("div.rvdsfCartSummaryAbstractContainer").hover(function ()
		        {
		            $("div.rvdsfCartSummaryDetailContainer").slideDown();
		        },
                function ()
                {
                    cartDetailTimer = setTimeout(function ()
                    {
                        $("div.rvdsfCartSummaryDetailContainer").slideUp();
                    }, 2000);
                });

		        $("div.rvdsfCartSummaryDetailContainer").hover(function ()
		        {
		            clearTimeout(cartDetailTimer);
		        },
                function ()
                {
                    cartDetailTimer = setTimeout(function ()
                    {
                        $("div.rvdsfCartSummaryDetailContainer").slideUp();
                    }, 2000);
                });
		    }
		});
	</script>
    
    <div class="rvdsfCartSummaryAbstractContainer">
        <asp:HyperLink ID="ViewCartHyperLink" runat="server" CssClass="rvdsfViewCartAction" />
		<div class="rvdsfCartSummaryDetailItem">
			<dnn1:LabelControl ID="SalesOrderDetailCountLabelControl" runat="server" />
			<asp:Label ID="SalesOrderDetailCountLabel" runat="server" CssClass="rvdsfSalesOrderDetailCount" />
		</div>
    </div>
    <asp:Label ID="CartModifiedMessageLabel" runat="server" resourcekey="CartModifiedMessageLabel" CssClass="rvdsfCartModifiedMessage"></asp:Label>
	<asp:Panel ID="CartDetailViewPanel" runat="server" CssClass="dnnFormPopup rvdsfCartSummaryDetailContainer">
        <asp:GridView ID="SalesOrderDetailGridView" CssClass="dnnGrid rvdsfSalesOrderDetailGrid" GridLines="None" runat="server" AutoGenerateColumns="False" DataKeyNames="SalesOrderDetailID" >
			<HeaderStyle CssClass="dnnGridHeader" />
			<RowStyle CssClass="dnnGridItem" />
			<AlternatingRowStyle CssClass="dnnGridAltItem" />
			<SelectedRowStyle CssClass="dnnGridSelectedItem" />
			<FooterStyle CssClass="dnnGridFooter" />
			<PagerStyle CssClass="dnnGridPager" />
			<Columns>
				<asp:TemplateField HeaderText="ItemHeaderSalesOrderDetailGridView">
					<ItemTemplate>
						<asp:HyperLink ID="GalleryHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' CssClass="rvdsfCartGalleryThumbnail">
							<asp:Image ID="GalleryImage" AlternateText='<%# Eval("GalleryImage_AlternateText") %>' ImageUrl='<%# Eval("GalleryImage_ImageUrl") %>' Visible='<%# Convert.ToBoolean(Eval("GalleryImage_Visible")) %>' runat="server" />
						</asp:HyperLink>
						<div class="rvdsfCartProduct">
							<asp:HyperLink ID="ProductNameHyperLink" runat="server" NavigateUrl='<%# Eval("ProductUrl") %>' Text='<%# Eval("ProductName") %>'></asp:HyperLink>
							<dl class="rvdsfDynamicFormResults">
								<asp:Literal ID="DynamicFormResultLiteral" runat="server" Text='<%# Eval("DynamicFormResult") %>' />
							</dl>
						</div>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField DataField="Price" HeaderText="PriceHeaderSalesOrderDetailGridView" />
                <asp:BoundField DataField="Quantity" HeaderText="QuantityHeaderSalesOrderDetailGridView" />
                <asp:BoundField DataField="Amount" HeaderText="AmountHeaderSalesOrderDetailGridView" />
			</Columns>
		</asp:GridView>
        <div class="rvdsfCartTotalAmountContainer">
			<div class="dnnFormItem rvdsfSubTotalAmount">
				<dnn1:LabelControl ID="SubTotalLabelControl" runat="server" />
			    <asp:Label ID="SubTotalLabel" runat="server" CssClass="rvdsfSubTotalAmount" />
			</div>
			<asp:Panel ID="RewardsPointQualifiedPanel" runat="server" CssClass="dnnFormItem rvdsfRewardsPointAmount">
				<dnn1:LabelControl ID="RewardsPointQualifiedLabelControl" runat="server" />
				<asp:Label ID="RewardsPointQualifiedLabel" runat="server"></asp:Label>
			</asp:Panel>
		</div>
        <div class="rvdsfCartSummaryActions">
		    <asp:HyperLink ID="EditCartHyperLink" runat="server" resourcekey="EditCartHyperLink" CssClass="dnnSecondaryAction rvdsfEditCartAction" />
		    <asp:HyperLink ID="CheckoutHyperLink" runat="server" resourcekey="CheckoutHyperLink" CssClass="dnnPrimaryAction rvdsfCheckoutAction" />
	    </div>
	    <div class="rvdsfCartSummaryPaymentAcceptanceContainer">
		    <asp:Label ID="PaymentAcceptanceMarkLabel" runat="server" resourcekey="PaymentAcceptanceMarkLabel"></asp:Label>
	    </div>
	</asp:Panel>
</div>
