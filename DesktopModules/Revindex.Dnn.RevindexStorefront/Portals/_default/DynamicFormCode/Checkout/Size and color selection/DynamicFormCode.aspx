<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomSizeDropDownList" Text="Size:" runat="server" ID="CustomSizeLabel" CssClass="dnnLabel dnnFormLabel"/>
    <asp:DropDownList ID="CustomSizeDropDownList" runat="server" CausesValidation="True">
      <asp:ListItem Text="Small" Value="Small" />
      <asp:ListItem Text="Medium" Value="Medium" />
      <asp:ListItem Text="Large" Value="Large" />
    </asp:DropDownList>
  </div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomColorRadioButtonList" Text="Color:" runat="server" ID="CustomColorLabel" CssClass="dnnLabel dnnFormLabel"/>
    <asp:RadioButtonList ID="CustomColorRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="dnnFormRadioButtons" RepeatLayout="Flow">
      <asp:ListItem style="background-color:#99CCFF" Text="Blue" Value="Blue" />
      <asp:ListItem style="background-color:#CCCC99" Text="Brown" Value="Brown" />
      <asp:ListItem style="background-color:#FFCCFF" Text="Pink" Value="Pink" />
    </asp:RadioButtonList>
  </div>
</div>