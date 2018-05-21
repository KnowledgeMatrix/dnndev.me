<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomEmailTextBox" Text="Email:" runat="server" ID="CustomEmailLabel" CssClass="dnnLabel dnnFormLabel dnnFormRequired"/>
    <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" ControlToValidate="CustomEmailTextBox" ErrorMessage="Email is missing" ID="CustomEmailRequiredFieldValidator" runat="server" Text="" Display="Dynamic"/>
    <asp:RegularExpressionValidator CssClass="dnnFormMessage dnnFormError" ControlToValidate="CustomEmailTextBox" ErrorMessage="Email is invalid" ID="CustomEmailRegularExpressionValidator" runat="server" Text="" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic" />
    <asp:TextBox ID="CustomEmailTextBox" runat="server" CssClass="dnnFormRequired"/>
  </div>
</div>