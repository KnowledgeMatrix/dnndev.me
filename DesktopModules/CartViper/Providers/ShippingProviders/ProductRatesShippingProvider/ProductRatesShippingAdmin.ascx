<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductRatesShippingAdmin.ascx.cs" Inherits="CartViper.Store.Providers.Shipping.ProductRatesShippingProvider.ProductRatesShippingAdmin" %>

<div class="infoCaption"><asp:Label runat="server" ID="lblHelp" resourcekey="lblHelp"></asp:Label></div>
<div style="clear:both"></div><br /><br />

        <asp:datagrid id="grdShippingBands" runat="server" showheader="true" 
        showfooter="true" autogeneratecolumns="false" width="100%" AllowPaging="False" 
        CellPadding="5" CssClass="stripe" DataKeyField="BandId" 
    onitemcommand="grdShippingBands_ItemCommand" 
    onitemdatabound="grdShippingBands_ItemDataBound">
			    <columns>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblPriorityTitle" Runat="server" resourcekey="lblPriorityTitle" cssclass="NormalBold">Priority</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="txtPriority" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "Priority") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewPriority" runat="server" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblLowerBandLimit" Runat="server" resourcekey="lblLowerBandLimit" cssclass="NormalBold">Lower Band Limit</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox id="txtLowerBandLimit" Columns="4" runat="server" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "LowerBandLimit") %>'></asp:TextBox><br />
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox id="txtNewLowerBandLimit" Columns="4" runat="server" cssclass="Normal"></asp:TextBox><br />
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblUpperBandLimit" Runat="server" resourcekey="lblUpperBandLimit" cssclass="NormalBold">Upper Band Limit</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="4" id="txtUpperBandLimit" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "UpperBandLimit") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="4" id="txtNewUpperBandLimit" runat="server" style="text-align:right;" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn ItemStyle-HorizontalAlign="Right">
                        <HeaderTemplate>
                             <asp:Label ID="lblCountryTitle" Runat="server" resourcekey="lblCountryTitle" cssclass="NormalBold">Country</asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:DropDownList id="ddlCountry" runat="server" DataValueField="Value" DataTextField="Text" style="padding:0px"></asp:DropDownList>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList id="ddlNewCountry" runat="server" DataValueField="Value" DataTextField="Text" style="padding:0px"></asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateColumn>
                      <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblFirstProductCost" Runat="server" resourcekey="lblFirstProductCost" cssclass="NormalBold">1st Product In Band Cost</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="4" id="txtFirstCost" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "FirstProductCost", "{0:N}") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="4" id="txtNewFirstCost" runat="server" style="text-align:right;" cssclass="Normal"></asp:TextBox>
					    </FooterTemplate>
				    </asp:TemplateColumn>
                    <asp:TemplateColumn>
					    <HeaderTemplate>
						    <asp:Label ID="lblSubsequentProductCost" Runat="server" resourcekey="lblSubsequentProductCost" cssclass="NormalBold">Subsequent Products In Band Cost</asp:Label>
					    </HeaderTemplate>
					    <ItemTemplate>
						    <asp:TextBox Columns="4" id="txtSubsequentCost" runat="server" style="text-align:right;" cssclass="Normal" Text='<%# DataBinder.Eval(Container.DataItem, "SubsequentProductCost", "{0:N}") %>'></asp:TextBox>
					    </ItemTemplate>
					    <FooterTemplate>
					        <asp:TextBox Columns="4" id="txtNewSubsequentCost" runat="server" style="text-align:right;" cssclass="Normal"></asp:TextBox>
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
					        <asp:LinkButton ID="lnkAddNewBand" runat="server" resourcekey="lnkAddNew" Text="Add" CssClass="Normal" CommandName="add"></asp:LinkButton>
					    </FooterTemplate>
                    </asp:TemplateColumn>
                </columns>
            </asp:datagrid><br /><br />

            <asp:Button runat="server" ID="btnSave" resourcekey="btnSave" 
    onclick="btnSave_Click" />