<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomPriceTextBox" Text="Custom price:" runat="server" ID="CustomPriceLabel" CssClass="dnnLabel dnnFormLabel"/>
    <asp:RangeValidator CssClass="dnnFormMessage dnnFormError" ID="CustomPriceRangeValidator" MinimumValue="1.00" MaximumValue="10.00" Text="" Type="Double" ControlToValidate="CustomPriceTextBox" runat="server" ErrorMessage="Price must be between 1.00 to 10.00" Display="Dynamic" />
    <!-- The following logic works in conjunction with a product modifier rule to override the base price -->
    <asp:TextBox ID="CustomPriceTextBox" runat="server" />
  </div>
</div>