<%@ Control language="c#" CodeBehind="DefaultTaxAdmin.ascx.cs" Inherits="CartViper.Modules.Store.WebControls.Tax.DefaultTaxAdmin" AutoEventWireup="True" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<div class="infoCaption">
    <asp:Label runat="server" ID="lblInfo" resourcekey="lblInfo"></asp:Label>
</div>

   <table style="text-align:left; float:left; width:800px" runat="server" id="pnlTax">
            <tr>
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                    <dnn:label id="lblTaxAddress" runat="server" controlname="ddlTaxAddress" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlTaxAddress" AutoPostBack="true" 
                        onselectedindexchanged="ddlTaxAddress_SelectedIndexChanged"></asp:DropDownList>
                </td>
            </tr>    
            <tr>
                <td class="NormalBold" style="vertical-align:top;">
                    <dnn:label id="lblTaxFreeRoles" runat="server" controlname="ddlTaxAddress" suffix=":"></dnn:label>
                </td>
                <td>
                    <div class="cvRoleSelectorPanel">
                        <asp:CheckBoxList runat="server" ID="cltDnnRole" AutoPostBack="true" 
                            onselectedindexchanged="cltDnnRole_SelectedIndexChanged"></asp:CheckBoxList>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                    <dnn:label id="lblTaxStoreCountryOnly" runat="server" controlname="chkTaxStoreCountryOnly" suffix=":"></dnn:label>
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="chkTaxStoreCountryOnly"></asp:CheckBox>
                </td>
            </tr>
            
                    
            <tr runat="server" id="trExtTaxService">
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
	                <dnn:label id="lblExtTaxService" runat="server" controlname="ddlExtTax" suffix=":"></dnn:label>
	            </td>
	            <td style="vertical-align:top;">
	                <asp:DropDownList runat="server" ID="ddlExtTax" AutoPostBack="true"
                        onselectedindexchanged="ddlExtTax_SelectedIndexChanged"></asp:DropDownList>
	            </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Panel runat="server" id="pnlExtTaxService" />
                </td>
            </tr>
            <tr>           
	            <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
	                <dnn:label id="lblTaxOptions" runat="server" controlname="ddlTaxOptions" suffix=":"></dnn:label>
	            </td>
	            <td style="vertical-align:top;">
	                <asp:DropDownList runat="server" ID="ddlTaxOptions" AutoPostBack="true"
                        onselectedindexchanged="ddlTaxOptions_SelectedIndexChanged"></asp:DropDownList>
	            </td>
            </tr>
            <tr runat="server" id="pnlStandardTaxRate">           
                    <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                          <dnn:label id="lblStandardTaxRate" runat="server" controlname="txtTaxRate" suffix=":"></dnn:label>  
                    </td>
                    <td>
                        <asp:DropDownList id="ddlTaxTableState" runat="server" DataTextField="Text" DataValueField="Value"></asp:DropDownList>

                        <asp:TextBox Columns="5" runat="server" ID="txtTaxRate"></asp:TextBox> <span class="NormalRed" style="margin:0px 5px">*</span>
                        <asp:RequiredFieldValidator ValidationGroup="btnSaveTaxRate" ID="RequiredFieldValidator1" Display="Dynamic" 
                            ControlToValidate="txtTaxRate" runat="server" resourcekey="RequiredFieldValidator1" CssClass="NormalRed"></asp:RequiredFieldValidator>
                        <asp:linkbutton CssClass="CvStandardButton" id="Linkbutton1" ValidationGroup="btnSaveTaxRate" runat="server" resourcekey="btnSaveTaxRate" CommandName="saveTaxRate" oncommand="Linkbutton1_Command">Save Tax Rate</asp:linkbutton>
                        <asp:Label runat="server" CssClass="adminPercentageInfo" ID="lblPercentage1" resourcekey="lblPercentage" />
                        
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="Normal">
                       
                    </td>
                </tr>
                <tr runat="server" id="pnlTaxTable2">

                    <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
	                    <dnn:label id="lblTaxTable" runat="server" controlname="ddlTaxOptions" suffix=":"></dnn:label>
	                </td>
                    <td>
                        <asp:GridView Width="330px" runat="server" ID="gvTaxTable" AutoGenerateColumns="false" 
                            EmptyDataText="No Tax Rates Entered Yet." 
                            onrowcommand="gvTaxTable_RowCommand" onrowdeleting="gvTaxTable_RowDeleting" 
                            onrowediting="gvTaxTable_RowEditing" onrowupdating="gvTaxTable_RowUpdating" CssClass="stripe">
                               <Columns>
                                    <asp:BoundField ItemStyle-Width ="150px" DataField="State" HeaderText="State" />
                                        <asp:BoundField ItemStyle-Width="45px" DataField="TaxRate" HeaderText="Tax Rate" />
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton CssClass="CvStandardButton" runat="server" ID="lnkDelete" CommandArgument='<%# Eval("Id") %>' CommandName="delete" Text="Delete"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                               </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr runat="server" id="pnlZip2tax">
                <td colspan="2">
                    <table>
                        <tr>
                         <td colspan="2">
                            <div class="infoCaption">
                                Note this tax option is only supported for the USA / Canada and in order to use this tax option you need to purchase
                                and upload the CSV files for the states you would like to support tax rates for from <a target="_blank" href="http://www.zip2tax.com/Website/pagesProducts/z2t_services.asp#PageSection3">Zip2Tax</a>
                            </div>
                         </td>
                     </tr>
                         <tr>
                             <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                                <dnn:label id="lblUpload" runat="server" controlname="fuUpload" suffix=":"></dnn:label>      
                              </td>
                              <td>
                                    <asp:FileUpload runat="server" ID="fuUpload" />
                                    <asp:Button runat="server" ID="btnUpload" Text="Upload" 
                                        onclick="btnUpload_Click" />
                              </td>
                            </tr>
                            <tr><td colspan="2">&nbsp;</td></tr>
                            <tr>
                                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                                <dnn:label id="lblLastUploadHelp" runat="server" controlname="lblLastUpload" suffix=":"></dnn:label>      
                              </td>
                                <td><asp:Label Font-Bold="true" runat="server" ID="lblLastUpload"></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Panel runat="server" ID="pnlResult"></asp:Panel>
                                </td>
                            </tr>
                    </table>
                    </td>
                </tr>
                <tr runat="server" id="pnlNewyorkCountyTax">  
                    <td colspan="2">
                                    <table>
                                        <tr>          
                                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                                        <dnn:label id="lblCountyRate" runat="server" controlname="ddlNewYorkCounty" suffix=":"></dnn:label>      
                                </td>
                                <td>
                                    <asp:DropDownList id="ddlNewYorkCounty" runat="server"></asp:DropDownList>
                                    <asp:TextBox Columns="5" runat="server" ID="txtNewYorkCountyRate"></asp:TextBox><span class="NormalRed" style="margin:0px 5px">*</span>
                                     <asp:RequiredFieldValidator ValidationGroup="btnSaveCountyRate" ID="RequiredFieldValidator5" CssClass="NormalRed" Display="Dynamic" ControlToValidate="txtNewYorkCountyRate" runat="server" resourcekey="RequiredFieldValidator1"></asp:RequiredFieldValidator>
                                    <asp:linkbutton CssClass="CvStandardButton" id="Linkbutton3" ValidationGroup="btnSaveCountyRate" runat="server" resourcekey="btnSaveCountyRate" CommandName="saveNYCountyTaxRate" oncommand="Linkbutton1_Command">Save Tax Rate</asp:linkbutton>
                                    <asp:Label runat="server" CssClass="adminPercentageInfo" ID="Label4" resourcekey="lblPercentage" />
                                               
                                </td>
                            </tr>
                            <tr><td colspan="2">&nbsp;</td></tr>
                            <tr>
                                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;"> 
                                    <dnn:label id="lblCountyTaxes" runat="server" controlname="ddlTaxOptions" suffix=":"></dnn:label>
                                </td>
                                <td>
                                     <asp:GridView Width="330px" runat="server" ID="gvCountyTaxRates" AutoGenerateColumns="false" 
                                        EmptyDataText="No Tax Rates Entered Yet." 
                                        onrowcommand="gvCountyTaxRates_RowCommand" onrowdeleting="gvCountyTaxRates_RowDeleting" 
                                        onrowediting="gvCountyTaxRates_RowEditing" onrowupdating="gvCountyTaxRates_RowUpdating" CssClass="stripe">
                                           <Columns>
                                                <asp:BoundField ItemStyle-Width ="150px" DataField="County" HeaderText="State" />
                                                    <asp:BoundField ItemStyle-Width="45px" DataField="CountyTaxRate" HeaderText="Tax Rate" />
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:LinkButton CssClass="CvStandardButton" runat="server" ID="lnkDelete" CommandArgument='<%# Eval("CountyId") %>' CommandName="delete" Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                           </Columns>
                                    </asp:GridView>
                                </td>
                                    </tr>
                        </table>
                    </td>  
                </tr>
    </table>

    
    <table style="text-align:left; float:left; width:800px" runat="server" id="pnlVat">
            <tr>
                <td class="NormalBold" colspan="2">
	                <dnn:label id="lblVatRates" runat="server" controlname="pnlVat" suffix=":"></dnn:label>
	            </td>
            </tr>
            <tr>
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                      <dnn:label id="lblZeroVatRate" runat="server" controlname="txtZeroVatRate" suffix=":"></dnn:label>  
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtZeroVatRate"></asp:TextBox><span class="NormalRed" style="margin:0px 5px">*</span>
                    <asp:RequiredFieldValidator CssClass="NormalRed" ValidationGroup="btnSaveVAT" ID="RequiredFieldValidator2" Display="Dynamic" 
                        ControlToValidate="txtZeroVatRate" runat="server" resourcekey="RequiredFieldValidator2"></asp:RequiredFieldValidator>
                    <asp:Label runat="server" CssClass="adminPercentageInfo" ID="Label1" resourcekey="lblPercentage" />
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                      <dnn:label id="lblReducedVatRate" runat="server" controlname="txtReducedVatRate" suffix=":"></dnn:label>  
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtReducedVatRate"></asp:TextBox><span class="NormalRed" style="margin:0px 5px">*</span>
                     <asp:RequiredFieldValidator CssClass="NormalRed" ValidationGroup="btnSaveVAT" ID="RequiredFieldValidator3" Display="Dynamic" 
                    ControlToValidate="txtReducedVatRate" runat="server" resourcekey="RequiredFieldValidator3"></asp:RequiredFieldValidator>
                    <asp:Label runat="server" CssClass="adminPercentageInfo" ID="Label2" resourcekey="lblPercentage" />
                </td>
            </tr>
            <tr>
                <td class="NormalBold" style="vertical-align:top; width:150px; white-space:nowrap;">
                      <dnn:label id="lblStandardVatRate" runat="server" controlname="txtStandardVatRate" suffix=":"></dnn:label>  
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtStandardVatRate"></asp:TextBox><span class="NormalRed" style="margin:0px 5px">*</span>
                     <asp:RequiredFieldValidator CssClass="NormalRed" ValidationGroup="btnSaveVAT" ID="RequiredFieldValidator4" Display="Dynamic" 
                        ControlToValidate="txtStandardVatRate" runat="server" resourcekey="RequiredFieldValidator4"></asp:RequiredFieldValidator>
                    <asp:Label runat="server" CssClass="adminPercentageInfo" ID="Label3" resourcekey="lblPercentage" />
                </td>
            </tr>
            <tr>
                <td colspan="2" class="Normal">
                    <asp:linkbutton id="Linkbutton2" CssClass="CvStandardButton" ValidationGroup="btnSaveVAT" runat="server" resourcekey="btnSaveVAT" 
                                CommandName="btnSaveVAT" oncommand="Linkbutton1_Command"></asp:linkbutton>
                </td>
            </tr>
    
</table>

     <script type="text/javascript">
         /* <![CDATA[ */
         jQuery(document).ready(function () {
             jQuery(".stripe tr").mouseover(function () { jQuery(this).addClass("over"); }).mouseout(function () { jQuery(this).removeClass("over"); });
             jQuery(".stripe tr:even").addClass("alt");
             jQuery(".stripe tr:first").addClass("stripeHeader");
             jQuery(".stripe tr:first").removeClass("alt").unbind();
         });
         /* ]]> */
    </script>