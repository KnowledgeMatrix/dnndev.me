<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomDateTextBox" Text="Date:" runat="server" ID="CustomDateLabel" CssClass="dnnLabel dnnFormLabel dnnFormRequired"/>
    <asp:RequiredFieldValidator CssClass="dnnFormMessage dnnFormError" ControlToValidate="CustomDateTextBox" ErrorMessage="Date is missing" ID="CustomDateRequiredFieldValidator" runat="server" Text="" Display="Dynamic" />
    <!-- The following textbox uses the jQuery DatePicker calender UI -->
    <asp:TextBox ID="CustomDateTextBox" runat="server" CssClass="dnnFormRequired"/>
  </div>
  <!-- Choose the jQuery CSS theme from Microsoft Content Delivery Network or from your own local storage. See http://www.asp.net/ajaxlibrary/cdn.ashx for more information.-->
  <link rel="Stylesheet" href="https://ajax.aspnetcdn.com/ajax/jquery.ui/1.8.10/themes/ui-lightness/jquery-ui.css" />
  <script type="text/javascript">
    jQuery(function() {
    jQuery("input[id$='CustomDateTextBox']").datepicker();
    });
  </script>
</div>