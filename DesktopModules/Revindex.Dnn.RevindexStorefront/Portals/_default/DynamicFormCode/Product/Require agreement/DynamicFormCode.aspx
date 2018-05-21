<div>
  <script type="text/javascript">
    function CustomAgreementCheckBox_ClientValidate(sender, e)
    {
    e.IsValid = jQuery("input[id$='CustomAgreementCheckBox']").is(':checked');
    }
  </script>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomAgreementCheckBox" Text="I agree to the terms:" runat="server" ID="CustomAgreementLabel" CssClass="dnnLabel dnnFormLabel dnnFormRequired"/>
    <asp:CheckBox runat="server" ID="CustomAgreementCheckBox" CssClass="dnnFormRequired"/>
    <asp:CustomValidator runat="server" ID="CustomAgreementValidator1" EnableClientScript="true" ClientValidationFunction="CustomAgreementCheckBox_ClientValidate" ErrorMessage="You must agree to proceed" CssClass="dnnFormMessage dnnFormError"/>
  </div>
</div>
