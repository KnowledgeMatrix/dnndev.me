<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BasicDynamicFormDetailsViewControl.ascx.cs" Inherits="Revindex.Dnn.RevindexStorefront.WebUserControls.BasicDynamicFormDetailsViewControl" %>
<%@ Register Src="~/Controls/labelcontrol.ascx" TagName="LabelControl" TagPrefix="dnn1" %>
<%@ Register Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" TagPrefix="dnn2" %>
<%@ Register Src="ListItemControl.ascx" TagName="ListItemControl" TagPrefix="uc1" %>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="FieldTypeBasicDynamicFormLabelControl" runat="server" Text="Field type:" HelpText="The type of input control to display on screen." />
	<asp:DropDownList ID="FieldTypeBasicDynamicFormDropDownList" runat="server" OnSelectedIndexChanged="FieldTypeBasicDynamicFormDropDownList_SelectedIndexChanged" AutoPostBack="True">
		<asp:ListItem Text="Calendar" Value="CalendarFieldTypeBasicDynamicFormView" Selected="True" />
		<asp:ListItem Text="CheckBox" Value="CheckBoxFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="CheckBoxList" Value="CheckBoxListFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="DatePicker" Value="DatePickerFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="DropDownList" Value="DropDownListFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="FileUpload" Value="FileUploadFieldTypeBasicDynamicFormView" />
        <asp:ListItem Text="Hidden" Value="HiddenFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="ListBox" Value="ListBoxFieldTypeBasicDynamicFormView" />
        <asp:ListItem Text="Literal" Value="LiteralFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="RadioButtonList" Value="RadioButtonListFieldTypeBasicDynamicFormView" />
		<asp:ListItem Text="TextBox" Value="TextBoxFieldTypeBasicDynamicFormView" />
	</asp:DropDownList>
</div>
<div class="dnnFormItem">
	<dnn1:LabelControl ID="FieldIDBasicDynamicFormLabelControl" runat="server" Text="ID:" CssClass="dnnFormRequired" HelpText="The ID is used to identify the field internally. Enter a unique ID for this field (e.g. &quot;Custom_Date&quot;). The first letter must begin with an alphabet. The ID can only contain alphabets, underscore and numbers without spaces." />
	<asp:RequiredFieldValidator ID="FieldIDBasicDynamicFormRequiredFieldValidator" runat="server" Text="ID is required." Display="Dynamic" CssClass="dnnFormMessage dnnFormError" ValidationGroup="FieldBasicDynamicFormDetailsViewControl" ControlToValidate="FieldIDBasicDynamicFormTextBox"></asp:RequiredFieldValidator>
	<asp:RegularExpressionValidator ID="FieldIDBasicDynamicFormRegularExpressionValidator" runat="server" ControlToValidate="FieldIDBasicDynamicFormTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" Text="ID is invalid." ValidationGroup="FieldBasicDynamicFormDetailsViewControl" ValidationExpression="^[a-zA-Z][a-zA-Z0-9_]+$"></asp:RegularExpressionValidator>
	<asp:TextBox ID="FieldIDBasicDynamicFormTextBox" runat="server" CssClass="dnnFormRequired"></asp:TextBox>
</div>
<asp:Panel ID="InputFieldPanel" runat="server">
    <div class="dnnFormItem">
	    <dnn1:LabelControl ID="FieldLabelBasicDynamicFormLabelControl" runat="server" Text="Label:" HelpText="The label is the text that appears to the left of the input field on the web page." />
	    <asp:TextBox ID="FieldLabelBasicDynamicFormTextBox" runat="server"></asp:TextBox>
    </div>
    <div class="dnnFormItem">
	    <dnn1:LabelControl ID="FieldRequiredBasicDynamicFormLabelControl" runat="server" Text="Required:" HelpText="Indicate if the input field value is required." />
	    <asp:CheckBox ID="FieldRequiredBasicDynamicFormCheckBox" runat="server" />
    </div>
    <div class="dnnFormItem">
	    <dnn1:LabelControl ID="FieldValidatorTextBasicDynamicFormLabelControl" runat="server" Text="Validator text:" HelpText="The validation message to display on error." />
	    <asp:TextBox ID="FieldValidatorTextBasicDynamicFormTextBox" runat="server" Text="*"></asp:TextBox>
    </div>
    <div class="dnnFormItem">
	    <dnn1:LabelControl ID="FieldInputControlWidthBasicDynamicFormLabelControl" runat="server" Text="Input control width:" HelpText="The width of the input control or leave blank for default value (px or %)." />
	    <asp:RegularExpressionValidator ID="FieldInputControlWidthBasicDynamicFormRegularExpressionValidator" runat="server" ControlToValidate="FieldInputControlWidthBasicDynamicFormTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" Text="Input width is invalid." ValidationGroup="FieldBasicDynamicFormDetailsViewControl" ValidationExpression="^\d+\s*(px|%){0,1}$"></asp:RegularExpressionValidator>
	    <asp:TextBox ID="FieldInputControlWidthBasicDynamicFormTextBox" runat="server"></asp:TextBox>
    </div>
    <div class="dnnFormItem">
	    <dnn1:LabelControl ID="FieldInputControlHeightBasicDynamicFormLabelControl" runat="server" Text="Input control height:" HelpText="The height of the input control or leave blank for default value (px or %)." />
	    <asp:RegularExpressionValidator ID="FieldInputControlHeightBasicDynamicFormRegularExpressionValidator" runat="server" ControlToValidate="FieldInputControlHeightBasicDynamicFormTextBox" Display="Dynamic" CssClass="dnnFormMessage dnnFormError" Text="Input height is invalid." ValidationGroup="FieldBasicDynamicFormDetailsViewControl" ValidationExpression="^\d+\s*(px|%){0,1}$"></asp:RegularExpressionValidator>
	    <asp:TextBox ID="FieldInputControlHeightBasicDynamicFormTextBox" runat="server"></asp:TextBox>
    </div>
</asp:Panel>
<asp:MultiView ID="FieldTypeBasicDynamicFormDetailsViewMultiView" runat="server" ActiveViewIndex="0">
	<asp:View ID="CalendarFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SelectedDateCalendarFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Selected date:" HelpText="Default selected date." />
			<dnn2:DnnDatePicker ID="SelectedDateCalendarFieldTypeBasicDynamicFormDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
			</dnn2:DnnDatePicker>
		</div>
	</asp:View>
	<asp:View ID="CheckBoxFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackCheckBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackCheckBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationCheckBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationCheckBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CheckedCheckBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Checked:" HelpText="Indicate if checkbox is checked by default." />
			<asp:CheckBox ID="CheckedCheckBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
	</asp:View>
	<asp:View ID="CheckBoxListFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackCheckBoxListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackCheckBoxListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationCheckBoxListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationCheckBoxListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RepeatDirectionCheckBoxListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Repeat direction:" HelpText="Determine how list items are displayed on screen." />
			<asp:RadioButtonList ID="RepeatDirectionCheckBoxListFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Horizontal" Value="Horizontal" />
				<asp:ListItem Text="Vertical" Value="Vertical" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ListItemCheckBoxListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="List items:" HelpText="List of selectable items. Each list item contains a name that is displayed to the end user and a value that is internally being stored." />
			<uc1:ListItemControl ID="ListItemCheckBoxListFieldTypeBasicDynamicFormListItemControl" runat="server" Height="120px" AllowReorder="True" AllowDelete="True" AutoPostBack="True" />
		</div>
	</asp:View>
	<asp:View ID="DatePickerFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackDatePickerFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackDatePickerFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SelectedDateDatePickerFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Selected date:" HelpText="Default selected date." />
			<dnn2:DnnDatePicker ID="SelectedDateDatePickerFieldTypeBasicDynamicFormDnnDatePicker" runat="server" ShowPopupOnFocus="True" DatePopupButton-Visible="False" DateInput-DateFormat="yyyy-MM-dd" DateInput-EmptyMessage="YYYY-MM-DD">
			</dnn2:DnnDatePicker>
		</div>
	</asp:View>
	<asp:View ID="DropDownListFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackDropDownListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackDropDownListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationDropDownListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationDropDownListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ListItemDropDownListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="List items:" HelpText="List of selectable items. Each list item contains a name that is displayed to the end user and a value that is internally being stored." />
			<uc1:ListItemControl ID="ListItemDropDownListFieldTypeBasicDynamicFormListItemControl" runat="server" Height="120px" AllowReorder="True" AllowDelete="True" AutoPostBack="True" />
		</div>
	</asp:View>
	<asp:View ID="FileUploadFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="FileExtensionFileUploadFieldTypeBasicDynamicFormLabelControl" runat="server" Text="File extension:" HelpText="List of valid file extensions acceptable for upload. Separate each file extension by a pipe (e.g. .gif|.GIF|.jpg|.JPG|.jpeg|.JPEG|.png|.PNG). Leave blank to accept any file." />
			<asp:TextBox ID="FileExtensionFileUploadFieldTypeBasicDynamicFormTextBox" runat="server"></asp:TextBox>
		</div>
	</asp:View>
    <asp:View ID="HiddenFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ValueHiddenFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Default value:" HelpText="Default hidden value." />
			<asp:TextBox ID="ValueHiddenFieldTypeBasicDynamicFormTextBox" runat="server" Height="80px" TextMode="MultiLine"></asp:TextBox>
		</div>
	</asp:View>
	<asp:View ID="ListBoxFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackListBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackListBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationListBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationListBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="SelectionModeListBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Selection mode:" HelpText="Determine how the list items can be selected." />
			<asp:RadioButtonList ID="SelectionModeListBoxFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Multiple" Value="Multiple" />
				<asp:ListItem Text="Single" Value="Single" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ListItemListBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="List items:" HelpText="List of selectable items. Each list item contains a name that is displayed to the end user and a value that is internally being stored." />
			<uc1:ListItemControl ID="ListItemListBoxFieldTypeBasicDynamicFormListItemControl" runat="server" Height="120px" AllowReorder="True" AllowDelete="True" AutoPostBack="True" />
		</div>
	</asp:View>
        <asp:View ID="LiteralFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TextLiteralFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Default text:" HelpText="Default literal text." />
			<asp:TextBox ID="TextLiteralFieldTypeBasicDynamicFormTextBox" runat="server" Height="200px" TextMode="MultiLine"></asp:TextBox>
		</div>
	</asp:View>
	<asp:View ID="RadioButtonListFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackRadioButtonListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackRadioButtonListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationRadioButtonListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationRadioButtonListFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="RepeatDirectionRadioButtonListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Repeat direction:" HelpText="Determine how list items are displayed on screen." />
			<asp:RadioButtonList ID="RepeatDirectionRadioButtonListFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Horizontal" Value="Horizontal" />
				<asp:ListItem Text="Vertical" Value="Vertical" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="ListItemRadioButtonListFieldTypeBasicDynamicFormLabelControl" runat="server" Text="List items:" HelpText="List of selectable items. Each list item contains a name that is displayed to the end user and a value that is internally being stored." />
			<uc1:ListItemControl ID="ListItemRadioButtonListFieldTypeBasicDynamicFormListItemControl" runat="server" Height="120px" AllowReorder="True" AllowDelete="True" AutoPostBack="True" />
		</div>
	</asp:View>
	<asp:View ID="TextBoxFieldTypeBasicDynamicFormView" runat="server">
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="AutoPostBackTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Auto update:" HelpText="Indicates whether an automatic postback to the server occurs when an action is performed on the control." />
			<asp:CheckBox ID="AutoPostBackTextBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="CausesValidationTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Causes validation:" HelpText="Indicates whether validation is performed when an action is performed on the control." />
			<asp:CheckBox ID="CausesValidationTextBoxFieldTypeBasicDynamicFormCheckBox" runat="server" />
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TextTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Default text:" HelpText="Default text value that will be displayed in the input field on screen." />
			<asp:TextBox ID="TextTextBoxFieldTypeBasicDynamicFormTextBox" runat="server" Height="80px" TextMode="MultiLine"></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="TextModeTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Text mode:" HelpText="Determine if textbox should allow multiple lines or single line data entry." />
			<asp:RadioButtonList ID="TextModeTextBoxFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Multiple lines" Value="MultiLine" />
				<asp:ListItem Text="Single line" Value="SingleLine" Selected="True" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="DataTypeTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Data type:" HelpText="Specify the type of data allowed to be entered." />
			<asp:RadioButtonList ID="DataTypeTextBoxFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="Date" Value="Date" />
				<asp:ListItem Text="Decimal" Value="Decimal" />
				<asp:ListItem Text="Integer" Value="Integer" />
				<asp:ListItem Text="String" Value="String" Selected="True" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MinimumValueTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Min value:" HelpText="Specify the minimum value that can be entered or leave blank for any value." />
			<asp:TextBox ID="MinimumValueTextBoxFieldTypeBasicDynamicFormTextBox" runat="server" ></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaximumValueTextBoxFieldTypeBasicDynamicFormLabelControl1" runat="server" Text="Max value:" HelpText="Specify the maximum value that can be entered or leave blank for any value." />
			<asp:TextBox ID="MaximumValueTextBoxFieldTypeBasicDynamicFormTextBox" runat="server" ></asp:TextBox>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="WrapTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Wrap:" HelpText="Determine if text entered will automatically wrap if it overflows the textbox boundary." />
			<asp:RadioButtonList ID="WrapTextBoxFieldTypeBasicDynamicFormRadioButtonList" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="dnnFormRadioButtons">
				<asp:ListItem Text="False" Value="False" Selected="True" />
				<asp:ListItem Text="True" Value="True" />
			</asp:RadioButtonList>
		</div>
		<div class="dnnFormItem">
			<dnn1:LabelControl ID="MaxLengthTextBoxFieldTypeBasicDynamicFormLabelControl" runat="server" Text="Max length:" HelpText="The maximum length of text that can be entered. Leave blank for unlimited." />
			<dnn2:DnnNumericTextBox ID="MaxLengthTextBoxFieldTypeBasicDynamicFormDnnNumericTextBox" runat="server" EnableSingleInputRendering="False" Skin="" NumberFormat-DecimalDigits="0" NumberFormat-GroupSizes="9" MinValue="0">
			</dnn2:DnnNumericTextBox>
		</div>
	</asp:View>
</asp:MultiView>