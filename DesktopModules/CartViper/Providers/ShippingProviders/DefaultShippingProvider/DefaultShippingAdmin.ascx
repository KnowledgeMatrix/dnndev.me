<%@ Control language="c#" CodeBehind="DefaultShippingAdmin.ascx.cs" Inherits="CartViper.Modules.Store.Providers.Shipping.DefaultShippingProvider.DefaultShippingAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
    
     <div class="infoCaption">
        <asp:Label runat="server" ID="lblTextControlInfo" resourcekey="lblTextControlInfo" />
    </div><br /><br />

<table style="text-align:left;">
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td class="NormalBold" colspan="2">
            <dnn:label id="lblZipCodeBands" runat="server" controlname="rdShipByWeight" suffix=":"></dnn:label> 
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:datagrid id="grdZipCodes" runat="server" showheader="true" 
                showfooter="true" autogeneratecolumns="false" width="100%" AllowPaging="False" 
                CellPadding="5" CssClass="stripe" DataKeyField="ZipCodeBandId" 
                onitemcommand="grdZipCodes_ItemCommand">
			    <columns>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblZipCodePriorityTitle" Runat="server" resourcekey="lblZipCodePriorityTitle" cssclass="NormalBold">Priority</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="txtZipCodePriority" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Priority") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewZipCodePriority" runat="server" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblZipCodeTitle" Runat="server" resourcekey="lblZipCodeTitle" cssclass="NormalBold">Priority</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="txtZipCodes" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "ZipCodes") %>'></asp:TextBox><br />
                            <asp:Label runat="server" ID="label13" CssClass="adminPercentageInfo">Comma separated e.g. CA1,CA2,CA3</asp:Label>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewZipCodes" runat="server" cssclass="Normal"></asp:TextBox><br />
                            <asp:Label runat="server" ID="label13" CssClass="adminPercentageInfo">Comma separated e.g. CA1,CA2,CA3</asp:Label>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblCostTitle" Runat="server" resourcekey="lblCostTitle" cssclass="NormalBold">Cost</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="7" id="txtZipCodeCost" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Cost", "{0:N}") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="7" id="txtNewZipCodeCost" runat="server" style="text-align:right;" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                      <asp:TemplateColumn ItemStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="center">
                        <HeaderTemplate>
						    <asp:Label ID="lblDelete" Runat="server" resourcekey="lblDelete" cssclass="NormalBold">Delete</asp:Label>
					    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox Runat="server" ID="chkDeleteZipCode" cssclass="Normal"></asp:CheckBox>
                        </ItemTemplate>
                        <FooterTemplate>
					        <asp:LinkButton ID="lnkAddNewZipCode" runat="server" resourcekey="lnkAddNew" Text="Add" CssClass="Normal" CommandName="add"></asp:LinkButton>
					    </FooterTemplate>
                    </asp:TemplateColumn>
                </columns>
            </asp:datagrid>
        </td>
    </tr>
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
             <dnn:label id="lblChargeBy" runat="server" controlname="rdShipByWeight" suffix=":"></dnn:label>   
        </td>
        <td>
            <asp:RadioButton CssClass="cvshippingmethods" resourcekey="rdShipByWeight" runat="server" GroupName="shippingOptions" ID="rdShipByWeight" />&nbsp;&nbsp;
            <asp:RadioButton CssClass="cvshippingmethods" resourcekey="rdShipBySubtotal" runat="server" GroupName="shippingOptions" ID="rdShipBySubtotal" />&nbsp;&nbsp;
            <asp:RadioButton CssClass="cvshippingmethods" resourcekey="rdNoItemInCart" runat="server" GroupName="shippingOptions" ID="rdNoItemInCart" />
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="2" class="NormalBold">
            <dnn:label id="lblShippingValues" runat="server" controlname="grdShippingRates" suffix=":"></dnn:label>
        </td>
    </tr>
	<tr>
	    <td colspan="2">
	        <asp:datagrid onitemdatabound="grdShippingRates_ItemDataBound" id="grdShippingRates" runat="server" showheader="true" showfooter="true" autogeneratecolumns="false" width="100%" AllowPaging="False" CellPadding="5" CssClass="stripe" DataKeyField="ID">
			    <columns>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblShippingRatePriorityTitle" Runat="server" resourcekey="lblShippingRatePriorityTitle" cssclass="NormalBold">Priority</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Width="75px" id="txtPriority" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Priority") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Width="75px" id="txtNewPriority" runat="server" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>                    
                             <asp:Label ID="lblMinWeightTitle" Runat="server" resourcekey="lblMinWeightTitle" cssclass="cvMinWeight NormalBold">Min. Weight</asp:Label>
                            <asp:Label ID="Label1" Runat="server" resourcekey="lblMinSubtotalTitle" cssclass="cvMinSubtotal NormalBold">Min. Subtotal</asp:Label>  
                            <asp:Label ID="Label31" Runat="server" resourcekey="lblMinItemsTitle" cssclass="cvMinItems NormalBold">Max. Items</asp:Label>    
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="6" id="lblMinWeight" runat="server" style="text-align:right;" cssclass="Normal txtWeights" Text='<%# DataBinder.Eval(Container.DataItem, "MinWeight", "{0:N}")%>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="6" id="txtNewMinWeight" runat="server" style="text-align:right;" cssclass="Normal txtWeights"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>                         
                                <asp:Label ID="lblMaxWeightTitle" Runat="server" resourcekey="lblMaxWeightTitle" cssclass="cvMaxWeight NormalBold">Max. Weight</asp:Label>
                                 <asp:Label ID="Label2" Runat="server" resourcekey="lblMaxSubtotalTitle" cssclass="cvMaxSubtotal NormalBold">Max. Subtotal</asp:Label>  
                                 <asp:Label ID="Label32" Runat="server" resourcekey="lblMaxItemsTitle" cssclass="cvMaxItems NormalBold">Max. Items</asp:Label>                            				        
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="6" id="lblMaxWeight" runat="server" style="text-align:right;" cssclass="Normal txtWeights" Text='<%# DataBinder.Eval(Container.DataItem, "MaxWeight", "{0:N}")%>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="6" id="txtNewMaxWeight" runat="server" style="text-align:right;" cssclass="Normal txtWeights"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
				    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblCostTitle" Runat="server" resourcekey="lblCostTitle" cssclass="NormalBold">Cost</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="4" id="lblCost" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Cost", "{0:N}") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="4" id="txtNewCost" runat="server" style="text-align:right;" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblCostAsPercentageTitle" Runat="server" resourcekey="lblCostAsPercentageTitle" cssclass="lblCostAsPercentageTitle NormalBold">Cost</asp:Label>
                             <asp:Label ID="Label33" Runat="server" resourcekey="lblMaxItemsTitle" cssclass="cvMaxItems NormalBold">Max. Items</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:CheckBox runat="server" ID="chkCostAsPercentage" CssClass="chkWeights" />
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:CheckBox runat="server" ID="chkNewCostAsPercentage" CssClass="chkWeights" />
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn ItemStyle-HorizontalAlign="Right">
                        <HeaderTemplate>
                             <asp:Label ID="lblCountryTitle" Runat="server" resourcekey="lblCountryTitle" cssclass="NormalBold">Cost</asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:DropDownList id="ddlCountry" runat="server" DataValueField="Value" DataTextField="Text" style="padding:0px"></asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList id="ddlNewCountry" runat="server" DataValueField="Value" DataTextField="Text" style="padding:0px"></asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn ItemStyle-HorizontalAlign="Right">
                        <HeaderTemplate>
                             <asp:Label ID="lblDnnRoleTitle" Runat="server" resourcekey="lblDnnRoleTitle" cssclass="NormalBold">DNN Role</asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:DropDownList id="ddlDnnRole" runat="server" DataValueField="RoleId" DataTextField="RoleName" style="padding:0px"></asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList id="ddlDnnRoleNew" runat="server" DataValueField="RoleId" DataTextField="RoleName" style="padding:0px"></asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateColumn>
				    <asp:TemplateColumn ItemStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="center">
                        <HeaderTemplate>
						    <asp:Label ID="lblDelete" Runat="server" resourcekey="lblDelete" cssclass="NormalBold">Delete</asp:Label>
					    </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox Runat="server" ID="chkDelete" cssclass="Normal"></asp:CheckBox>
                        </ItemTemplate>
                        <FooterTemplate>
					        <asp:LinkButton ID="lnkAddNew" runat="server" resourcekey="lnkAddNew" Text="Add" CssClass="Normal" CommandName="Add"></asp:LinkButton>
					    </FooterTemplate>
                    </asp:TemplateColumn>
			    </columns>
				<PagerStyle Mode="NumericPages" HorizontalAlign="Center" CssClass="NormalBold"></PagerStyle>
			</asp:datagrid>
			<asp:Label ID="lblError" runat="server" Visible="false" CssClass="NormalBold" ForeColor="red"></asp:Label>
	    </td>
	</tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
	<tr>
		<td colspan="2" style="text-align:left;" class="Normal">
			<asp:validationsummary id="valSummary" runat="server" cssclass="NormalRed" displaymode="BulletList" enableclientscript="True" showsummary="False" showmessagebox="True" />
			<asp:linkbutton id="btnSaveShippingFee" runat="server" resourcekey="btnSaveShippingFee">Update Shipping Rates</asp:linkbutton>
		</td>
	</tr>

</table>



 <script type="text/javascript">
    /* <![CDATA[ */
     jQuery(document).ready(function () {
         SetHeaderTemplate();

         jQuery(".cvshippingmethods").click(function () {
             SetHeaderTemplate();
         });

         function SetHeaderTemplate() {

             if (jQuery("input[id*=rdShipByWeight]").is(':checked')) {
                 jQuery(".cvMaxWeight").show();
                 jQuery(".cvMinWeight").show();
                 jQuery(".lblCostAsPercentageTitle").show();

                 jQuery(".cvMaxSubtotal").hide();
                 jQuery(".cvMinSubtotal").hide();

                 jQuery(".cvMaxItems").hide();
                 jQuery(".cvMinItems").hide();

                 jQuery("txtWeights").removeAttr("disabled");
                 jQuery(".chkWeights").show();
             }
             else if(jQuery("input[id*=rdShipBySubtotal]").is(':checked')) {
                 jQuery(".cvMaxWeight").hide();
                 jQuery(".cvMinWeight").hide();
                 jQuery(".lblCostAsPercentageTitle").show();

                 jQuery(".cvMaxSubtotal").show();
                 jQuery(".cvMinSubtotal").show();

                 jQuery(".cvMaxItems").hide();
                 jQuery(".cvMinItems").hide();
                 jQuery(".txtWeights").removeAttr("readonly");
                 jQuery(".chkWeights").show();
             }
             else
             {
                //no items in the cart
                jQuery(".cvMaxItems").show();
                jQuery(".cvMinItems").show();
                jQuery(".lblCostAsPercentageTitle").hide();

                jQuery(".cvMaxWeight").hide();
                jQuery(".cvMinWeight").hide();

                jQuery(".cvMaxSubtotal").hide();
                jQuery(".cvMinSubtotal").hide();

                jQuery(".txtWeights").val("--");
                jQuery(".txtWeights").attr("readonly", "readonly");
                jQuery(".chkWeights").hide();
             }
         }

     });
     /* ]]> */
 </script>