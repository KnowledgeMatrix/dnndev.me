<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <!-- The following logic works in conjunction with a product modifier rule to override the base price -->
    <asp:Label AssociatedControlID="CustomCPUDropDownList" Text="CPU:" runat="server" ID="CustomCPULabel" CssClass="dnnLabel dnnFormLabel dnnFormRequired"/>
    <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" ControlToValidate="CustomCPUDropDownList" ErrorMessage="CPU is missing" ID="CustomCPURequiredFieldValidator" runat="server" Text="" Display="Dynamic" />
    <asp:DropDownList ID="CustomCPUDropDownList" runat="server" CssClass="dnnFormRequired">
      <asp:ListItem Text="--- Select one ---" Value="" />
      <asp:ListItem Text="Intel Xeon 100 ($10)" Value="10" />
      <asp:ListItem Text="Intel Xeon 500 ($50)" Value="50" />
    </asp:DropDownList>
  </div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomMemoryDropDownList" Text="Memory:" runat="server" ID="CustomMemoryLabel" CssClass="dnnLabel dnnFormLabel dnnFormRequired"/>
    <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" ControlToValidate="CustomMemoryDropDownList" ErrorMessage="Memory is missing" ID="CustomMemoryRequiredFieldValidator" runat="server" Text="" Display="Dynamic" />
    <asp:DropDownList ID="CustomMemoryDropDownList" runat="server" CssClass="dnnFormRequired">
      <asp:ListItem Value="" Text="--- Select one ---" />
      <asp:ListItem Text="1GB ($10)" Value="10" />
      <asp:ListItem Text="2GB ($20)" Value="20" />
    </asp:DropDownList>
  </div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomOptionsCheckBoxList" Text="Options:" runat="server" ID="CustomOptionsLabel" CssClass="dnnLabel dnnFormLabel"/>
    <asp:CheckBoxList ID="CustomOptionsCheckBoxList" runat="server" RepeatLayout="Flow" CssClass="rvdFormCheckBoxes">
      <asp:ListItem Text="Laptop bag ($15)" Value="15" />
      <asp:ListItem Text="Anti-virus ($7)" Value="7" />
    </asp:CheckBoxList>
  </div>
</div>