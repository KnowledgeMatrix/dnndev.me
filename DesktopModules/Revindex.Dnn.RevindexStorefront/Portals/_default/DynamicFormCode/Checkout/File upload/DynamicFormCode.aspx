<div>
  <div class="dnnFormItem rvdsfDynamicFormItem">
    <asp:Label AssociatedControlID="CustomImageFileUpload" Text="Upload image:" runat="server" ID="CustomImageFileUploadLabel" CssClass="dnnLabel dnnFormLabel"/>
    <asp:RegularExpressionValidator ValidationExpression=".+?(.gif|.GIF|.jpg|.JPG|.jpeg|.JPEG|.png|.PNG)$" ControlToValidate="CustomImageFileUpload" runat="server" ErrorMessage="Only GIF, JPG and PNG files allowed" CssClass="dnnFormMessage dnnFormError" Text="" Display="Dynamic" ID="CustomImageRegularExpressionValidator" />
    <asp:FileUpload ID="CustomImageFileUpload" runat="server" />
  </div>
</div>