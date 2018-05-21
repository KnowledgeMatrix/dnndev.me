//
// Requires Revindex/Global.js
//

var Revindex = Revindex || {};
Revindex.Dnn = Revindex.Dnn || {};
Revindex.Dnn.RevindexStorefront = Revindex.Dnn.RevindexStorefront || {};

Revindex.Dnn.RevindexStorefront.BaseEditor = new function()
{
    this.AttributeDescriptionXslAttributeLabelID = "";
    this.FunctionDescriptionXslAttributeLabelID = "";
    this.EditNameDnnWindowID = "";
    this.EditTextDnnWindowID = "";
    this.EditXmlAttributeDnnWindowID = "";
    this.EditXslAttributeDnnWindowID = "";
    this.PortalID = 0;
    this.XslAttributeDnnTreeViewID = "";
}

function XmlElement(name, maxOccurences, description)
{
    this.Name = name;
    this.MaxOccurences = maxOccurences;
    this.Description = description;
    this.Attributes = {};
    this.AllowableParentElements = [];
    this.AllowableChildElements = [];
}

function Attribute(name, description, value, isRequired)
{
    this.Name = name;
    this.Description = description;
    this.Value = value;
    this.IsRequired = isRequired;
}

function XPathFunction(category, name, value, description)
{
    this.Category = category;
    this.Name = name;
    this.Value = value;
    this.Description = description;
}

function ValidateXmlName(name)
{
    return (name != null && name.match(/^[_:a-z][-._:a-z0-9]*$/i) != null);
}

function BuildElementDisplayNameFromTreeNode(treeNode)
{
    var text = treeNode.get_value();
    for (var attrName in treeNode.get_attributes()._data)
    {
        if (attrName != '____type' && treeNode.get_attributes().getAttribute(attrName) != '___UNDEFINED___')
            text += ' ' + attrName.substring(3) + '="' + treeNode.get_attributes().getAttribute(attrName) + '"';
    }

    return text;
}

// List of known ASP elements
var aspElements = {};

var aspElement = new XmlElement('asp:CheckBox', 0, 'Single checkmark box');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['Checked'] = new Attribute('Checked', '', 'True', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomCheckBox1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['TextAlign'] = new Attribute('TextAlign', '', 'Left', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:CheckBoxList', 0, 'List of checkmark boxes');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['CellPadding'] = new Attribute('CellPadding', '', '0px', false);
aspElement.Attributes['CellSpacing'] = new Attribute('CellSpacing', '', '0px', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '300px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomCheckBoxList1', true);
aspElement.Attributes['RepeatColumns'] = new Attribute('RepeatColumns', '', '1', false);
aspElement.Attributes['RepeatDirection'] = new Attribute('RepeatDirection', '', 'Vertical', false);
aspElement.Attributes['RepeatLayout'] = new Attribute('RepeatLayout', '', 'OrderedList', false);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SelectedIndex'] = new Attribute('SelectedIndex', '', '0', false);
aspElement.Attributes['SelectedValue'] = new Attribute('SelectedValue', '', '', false);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', 'integer', false);
aspElement.Attributes['TextAlign'] = new Attribute('TextAlign', '', 'Left', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElement.AllowableChildElements = ['asp:ListItem'];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:CompareValidator', 0, 'Validate values between two fields');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['ControlToValidate'] = new Attribute('ControlToValidate', '', 'CustomTextBox1', true);
aspElement.Attributes['ControlToCompare'] = new Attribute('ControlToCompare', '', 'CustomTextBox2', true);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['CultureInvariantValues'] = new Attribute('CultureInvariantValues', '', 'True', false);
aspElement.Attributes['Display'] = new Attribute('Display', '', 'Dynamic', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableClientScript'] = new Attribute('EnableClientScript', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ErrorMessage'] = new Attribute('ErrorMessage', '', 'Values are not equal', true);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomCompareValidator1', true);
aspElement.Attributes['Operator'] = new Attribute('Operator', '', 'Equal', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Type'] = new Attribute('Type', '', 'Double', true);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:CustomValidator', 0, 'Validate using custom script');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['ClientValidationFunction'] = new Attribute('ClientValidationFunction', '', '', true);
aspElement.Attributes['ControlToValidate'] = new Attribute('ControlToValidate', '', 'CustomTextBox1', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['CultureInvariantValues'] = new Attribute('CultureInvariantValues', '', 'True', false);
aspElement.Attributes['Display'] = new Attribute('Display', '', 'Dynamic', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableClientScript'] = new Attribute('EnableClientScript', '', 'True', true);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ErrorMessage'] = new Attribute('ErrorMessage', '', 'Missing value', true);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomValidator1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:DropDownList', 0, 'Drop down list control');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '300px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomDropDownList1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SelectedIndex'] = new Attribute('SelectedIndex', '', '0', false);
aspElement.Attributes['SelectedValue'] = new Attribute('SelectedValue', '', '', false);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElement.AllowableChildElements = ['asp:ListItem'];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:FileUpload', 0, 'Single file upload control');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '100px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomFileUpload1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:HiddenField', 0, 'Hidden field invisible on screen');
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomHiddenField1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Value'] = new Attribute('Value', '', '', true);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:HyperLink', 0, 'Navigation link');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomHyperLink1', true);
aspElement.Attributes['ImageUrl'] = new Attribute('ImageUrl', '', '', false);
aspElement.Attributes['NavigateUrl'] = new Attribute('NavigateUrl', '', '', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Target'] = new Attribute('Target', '', '_blank', true);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:Label', 0, 'Text label');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomLabel1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:ListBox', 0, 'Multi select list control');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '300px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomListBox1', true);
aspElement.Attributes['Rows'] = new Attribute('Rows', '', '10', false);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SelectedIndex'] = new Attribute('SelectedIndex', '', '0', false);
aspElement.Attributes['SelectedValue'] = new Attribute('SelectedValue', '', '', false);
aspElement.Attributes['SelectionMode'] = new Attribute('SelectionMode', '', 'Multiple', false);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElement.AllowableChildElements = ['asp:ListItem'];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:RadioButton', 0, 'Single radio button control');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['Checked'] = new Attribute('Checked', '', 'True', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['GroupName'] = new Attribute('GroupName', '', '', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomRadioButton1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['TextAlign'] = new Attribute('TextAlign', '', 'Left', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:RadioButtonList', 0, 'List of radio button controls');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'True', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['CellPadding'] = new Attribute('CellPadding', '', '0px', false);
aspElement.Attributes['CellSpacing'] = new Attribute('CellSpacing', '', '0px', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '300px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomRadioButtonList1', true);
aspElement.Attributes['RepeatColumns'] = new Attribute('RepeatColumns', '', '1', false);
aspElement.Attributes['RepeatDirection'] = new Attribute('RepeatDirection', '', 'Vertical', false);
aspElement.Attributes['RepeatLayout'] = new Attribute('RepeatLayout', '', 'OrderedList', false);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SelectedIndex'] = new Attribute('SelectedIndex', '', '0', false);
aspElement.Attributes['SelectedValue'] = new Attribute('SelectedValue', '', '', false);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', 'integer', false);
aspElement.Attributes['TextAlign'] = new Attribute('TextAlign', '', 'Left', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElement.AllowableChildElements = ['asp:ListItem'];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:ListItem', 0, 'Data item within list controls');
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['Selected'] = new Attribute('Selected', '', 'True', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['Value'] = new Attribute('Value', '', '', true);
aspElement.AllowableParentElements = ['asp:CheckBoxList', 'asp:DropDownList', 'asp:ListBox', 'asp:RadioButtonList'];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:RangeValidator', 0, 'Validate a range of values');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['ControlToValidate'] = new Attribute('ControlToValidate', '', 'CustomTextBox1', true);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['CultureInvariantValues'] = new Attribute('CultureInvariantValues', '', 'True', false);
aspElement.Attributes['Display'] = new Attribute('Display', '', 'Dynamic', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableClientScript'] = new Attribute('EnableClientScript', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ErrorMessage'] = new Attribute('ErrorMessage', '', 'Invalid range', true);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomRangeValidator1', true);
aspElement.Attributes['MaximumValue'] = new Attribute('MaximumValue', '', '10000', true);
aspElement.Attributes['MinimumValue'] = new Attribute('MinimumValue', '', '0', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Type'] = new Attribute('Type', '', 'Double', true);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:RegularExpressionValidator', 0, 'Validate value with regular expression');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['ControlToValidate'] = new Attribute('ControlToValidate', '', 'CustomTextBox1', true);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['CultureInvariantValues'] = new Attribute('CultureInvariantValues', '', 'True', false);
aspElement.Attributes['Display'] = new Attribute('Display', '', 'Dynamic', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableClientScript'] = new Attribute('EnableClientScript', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ErrorMessage'] = new Attribute('ErrorMessage', '', 'Invalid value', true);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomRegularExpressionValidator1', true);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['ValidationExpression'] = new Attribute('ValidationExpression', '', '^\\w$', true);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:RequiredFieldValidator', 0, 'Validate required value');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AssociatedControlID'] = new Attribute('AssociatedControlID', '', '', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['ControlToValidate'] = new Attribute('ControlToValidate', '', 'CustomTextBox1', true);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['CultureInvariantValues'] = new Attribute('CultureInvariantValues', '', 'True', false);
aspElement.Attributes['Display'] = new Attribute('Display', '', 'Dynamic', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableClientScript'] = new Attribute('EnableClientScript', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['ErrorMessage'] = new Attribute('ErrorMessage', '', 'Missing value', true);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomRequiredFieldValidator1', true);
aspElement.Attributes['InitialValue'] = new Attribute('InitialValue', '', '', false);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;

aspElement = new XmlElement('asp:TextBox', 0, 'Single or multiline input text box');
aspElement.Attributes['AccessKey'] = new Attribute('AccessKey', '', '', false);
aspElement.Attributes['AutoPostBack'] = new Attribute('AutoPostBack', '', 'False', false);
aspElement.Attributes['BackColor'] = new Attribute('BackColor', '', '#dddddd', false);
aspElement.Attributes['BorderColor'] = new Attribute('BorderColor', '', '#dddddd', false);
aspElement.Attributes['BorderStyle'] = new Attribute('BorderStyle', '', 'Solid', false);
aspElement.Attributes['BorderWidth'] = new Attribute('BorderWidth', '', '1px', false);
aspElement.Attributes['CausesValidation'] = new Attribute('CausesValidation', '', 'True', false);
aspElement.Attributes['Columns'] = new Attribute('Columns', '', '50', false);
aspElement.Attributes['CssClass'] = new Attribute('CssClass', '', '', false);
aspElement.Attributes['Enabled'] = new Attribute('Enabled', '', 'True', false);
aspElement.Attributes['EnableTheming'] = new Attribute('EnableTheming', '', 'True', false);
aspElement.Attributes['EnableViewState'] = new Attribute('EnableViewState', '', 'True', false);
aspElement.Attributes['Font-Bold'] = new Attribute('Bold', '', 'True', false);
aspElement.Attributes['Font-Italic'] = new Attribute('Italic', '', 'True', false);
aspElement.Attributes['Font-Names'] = new Attribute('Names', '', 'Arial', false);
aspElement.Attributes['Font-Overline'] = new Attribute('Overline', '', 'True', false);
aspElement.Attributes['Font-Size'] = new Attribute('Size', '', '10pt', false);
aspElement.Attributes['Font-Strikeout'] = new Attribute('Strikeout', '', 'True', false);
aspElement.Attributes['Font-Underline'] = new Attribute('Underline', '', 'True', false);
aspElement.Attributes['ForeColor'] = new Attribute('ForeColor', '', '#dddddd', false);
aspElement.Attributes['Height'] = new Attribute('Height', '', '20px', false);
aspElement.Attributes['ID'] = new Attribute('ID', '', 'CustomTextBox1', true);
aspElement.Attributes['MaxLength'] = new Attribute('MaxLength', '', '100', false);
aspElement.Attributes['ReadOnly'] = new Attribute('ReadOnly', '', 'True', false);
aspElement.Attributes['Rows'] = new Attribute('Rows', '', '1', false);
aspElement.Attributes['runat'] = new Attribute('runat', '', 'server', true);
aspElement.Attributes['SkinID'] = new Attribute('SkinID', '', '', false);
aspElement.Attributes['Style'] = new Attribute('Style', '', '', false);
aspElement.Attributes['TabIndex'] = new Attribute('TabIndex', '', '0', false);
aspElement.Attributes['Text'] = new Attribute('Text', '', '', true);
aspElement.Attributes['TextMode'] = new Attribute('TextMode', '', 'MultiLine', false);
aspElement.Attributes['ToolTip'] = new Attribute('ToolTip', '', '', false);
aspElement.Attributes['ValidationGroup'] = new Attribute('ValidationGroup', '', '', false);
aspElement.Attributes['Visible'] = new Attribute('Visible', '', 'True', false);
aspElement.Attributes['Width'] = new Attribute('Width', '', '100px', false);
aspElement.Attributes['Wrap'] = new Attribute('Wrap', '', 'True', false);
aspElement.AllowableParentElements = [''];
aspElements[aspElement.Name] = aspElement;


// List of known XSL elements
var xslElements = {};

var xslElement = new XmlElement('xsl:apply-templates', 0, 'Invoke processor to find template to apply');
xslElement.Attributes['select'] = new Attribute('select', 'Can be used to process nodes selected by an expression, instead of processing all children. The value of the select attribute is an Expressions, which must evaluate to a node-set. The selected node-set is processed in document order, unless a different sort order has been specified.', '', false);
xslElement.Attributes['mode'] = new Attribute('mode', 'The mode attribute allows an element as specified by its Qualified Names to be processed multiple times, each time producing a different result.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['xsl:sort', 'xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:attribute', 0, 'Create attribute onto an element');
xslElement.Attributes['name'] = new Attribute('name', 'The name of the attribute to create.', '', true);
xslElement.Attributes['namespace'] = new Attribute('namespace', 'The namespace Uniform Resource Identifier (URI) of the created attribute.', '', false);
xslElement.AllowableParentElements = ['xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['xsl:apply-imports', 'xsl:apply-templates', 'xsl:call-template', 'xsl:choose', 'xsl:copy', 'xsl:copy-of', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:number', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:attribute-set', 0, 'Define a named set of attributes');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names of the attribute set.', '', true);
xslElement.Attributes['use-attribute-sets'] = new Attribute('use-attribute-sets', 'A white space-separated list of attribute sets, specified as a Qualified Names.', '', false);
xslElement.AllowableParentElements = ['xsl:stylesheet', 'xsl:transform'];
xslElement.AllowableChildElements = ['xsl:attribute'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:call-template', 0, 'Invoke a template by name');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names name of the template to be invoked.', '', true);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:choose', 0, 'Test multiple conditions');
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['xsl:otherwise', 'xsl:when'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:copy', 0, 'Copy the current node from source to output');
xslElement.Attributes['use-attribute-sets'] = new Attribute('use-attribute-sets', 'A white space separated list of attribute sets, specified as a list of Qualified Names.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:copy-of', 0, 'Insert subtree & result tree fragment');
xslElement.Attributes['select'] = new Attribute('select', 'XPath Expressions identifying nodes to be copied. The subtree below each of these nodes is copied to the result tree in its entirety.', '', true);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:decimal-format', 0, 'Controls the interpretation of a format pattern used by the format-number function.');
xslElement.Attributes['name'] = new Attribute('name', 'The qualified name of the decimal-format.', '', false);
xslElement.Attributes['decimal-separator'] = new Attribute('decimal-separator', 'The character used to separate the integer and the fraction part of a number. The default is ".".', '', false);
xslElement.Attributes['grouping-separator'] = new Attribute('grouping-separator', 'The character used to separate groups of digits. The default is ",".', '', false);
xslElement.Attributes['infinity'] = new Attribute('infinity', 'The string used to represent infinity; the default value is the string "Infinity".', '', false);
xslElement.Attributes['minus-sign'] = new Attribute('minus-sign', 'The character used as the default minus sign; the default value is the hyphen character "-".', '', false);
xslElement.Attributes['NaN'] = new Attribute('NaN', 'The string used to represent the NaN value; the default value is the string "NaN".', '', false);
xslElement.Attributes['percent'] = new Attribute('percent', 'The character used as a percent sign; the default value is the percent character "%".', '', false);
xslElement.Attributes['per-mille'] = new Attribute('per-mille', 'The character used as a per thousand sign; the default value is the Unicode per-mille character.', '', false);
xslElement.Attributes['zero-digit'] = new Attribute('zero-digit', 'The character used as the digit zero; the default value is the digit zero "0".', '', false);
xslElement.Attributes['digit'] = new Attribute('digit', 'The character used in a format pattern to indicate a place where a leading zero digit is required. The default value is "#".', '', false);
xslElement.Attributes['pattern-separator'] = new Attribute('pattern-separator', 'The character used to separate positive and negative sub patterns in a pattern. The default value is the semi-colon character ";".', '', false);
xslElement.AllowableParentElements = ['xsl:stylesheet', 'xsl:transform'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:element', 0, 'Create output element with the specified name');
xslElement.Attributes['name'] = new Attribute('name', 'The name of the element to create.', '', true);
xslElement.Attributes['namespace'] = new Attribute('namespace', 'The namespace Uniform Resource Identifier (URI) of the created attribute.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:for-each', 0, 'Apply instruction repeatedly to each node in a set');
xslElement.Attributes['select'] = new Attribute('select', 'Expressions evaluated on the current context to determine the set of nodes to iterate over.', '', true);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['', 'xsl:apply-imports', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:number', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:sort', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:function', 0, 'Define a function');
xslElement.Attributes['name'] = new Attribute('name', 'The function name must have a non-default namespace prefix.', '', false);
xslElement.AllowableParentElements = ['xsl:transform', 'xsl:stylesheet'];
xslElement.AllowableChildElements = ['', 'xsl:apply-imports', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:number', 'xsl:param', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:if', 0, 'Test single condition');
xslElement.Attributes['test'] = new Attribute('test', 'The condition in the source data to test.', '', true);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:key', 0, 'Assign elements to key-value pair used with key() function');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names name of the template to be invoked.', '', true);
xslElement.Attributes['match'] = new Attribute('match', 'Specifies the Patterns that identifies a node that holds this key.', '', true);
xslElement.Attributes['use'] = new Attribute('use', 'Specifies an Expressions to be used as the value of the key. The key value can be one of the following: an attribute, a child element, or the content of the matched element.', '', true);
xslElement.AllowableParentElements = ['xsl:stylesheet', 'xsl:transform'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:number', 0, 'Insert a formatted number into the result tree');
xslElement.Attributes['level'] = new Attribute('level', 'Specifies what levels of the source tree should be considered; it has the values \"single\", \"multiple\" and \"any\". The default is \"single\".', '', false);
xslElement.Attributes['count'] = new Attribute('count', 'A Patterns that specifies what nodes should be counted at those levels.', '', false);
xslElement.Attributes['from'] = new Attribute('from', 'A Patterns that specifies where counting starts.', '', false);
xslElement.Attributes['value'] = new Attribute('value', 'Specifies the expression to be converted to a number and output to the result tree.', '', false);
xslElement.Attributes['format'] = new Attribute('format', 'A sequence of tokens that specifies the format to be used for each number in the list.', '', false);
xslElement.Attributes['lang'] = new Attribute('lang', 'Specifies which language\'s alphabet is used.', '', false);
xslElement.Attributes['letter-value'] = new Attribute('letter-value', 'Disambiguates between numbering sequences that use letters.', '', false);
xslElement.Attributes['grouping-separator'] = new Attribute('grouping-separator', 'Gives the separator used as a grouping (e.g. thousands) separator in decimal numbering sequences.', '', false);
xslElement.Attributes['grouping-size'] = new Attribute('grouping-size', 'Specifies the size (normally 3) of the grouping..', '', false);
xslElement.AllowableParentElements = ['', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:otherwise', 0, 'Default condition used in xsl:choose');
xslElement.AllowableParentElements = ['xsl:choose'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:param', 0, 'Declare a named parameter for use in xsl:template');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names name of the parameter.', '', true);
xslElement.Attributes['select'] = new Attribute('select', 'The value of the attribute is an Expressions, and the value of the variable is the object that results from evaluating the expression. When this attribute is specified, the xsl:param element must be empty.', '', false);
xslElement.AllowableParentElements = ['xsl:stylesheet', 'xsl:template', 'xsl:transform'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:sequence', 0, 'Construct abitrary sequence');
xslElement.Attributes['select'] = new Attribute('select', 'The input to generate the sequence.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:sort', 0, 'Sort nodes used in xsl:for-each or xsl:apply-templates');
xslElement.Attributes['select'] = new Attribute('select', 'The sort key for the node.', '', false);
xslElement.Attributes['lang'] = new Attribute('lang', 'The language alphabet used to determine sort order.', '', false);
xslElement.Attributes['data-type'] = new Attribute('data-type', 'The data type of the strings. Valid values are \"text\", \"number\", \"QName\".', '', false);
xslElement.Attributes['order'] = new Attribute('order', 'The sort order for the strings. The default is \"ascending\".', '', false);
xslElement.Attributes['case-order'] = new Attribute('case-order', 'The order in which to sort strings by capitalization.', '', false);
xslElement.AllowableParentElements = ['xsl:apply-templates', 'xsl:for-each'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:template', 0, 'Define template for generating output');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names to be expanded.', '', false);
xslElement.Attributes['match'] = new Attribute('match', 'A pattern that identifies the source node or nodes to which the rule applies.', '', false);
xslElement.Attributes['priority'] = new Attribute('priority', 'The priority number for the template.', '', false);
xslElement.Attributes['mode'] = new Attribute('mode', 'The mode value. This value allows an element to be processed multiple times, each time producing a different result.', '', false);
xslElement.AllowableParentElements = ['xsl:stylesheet', 'xsl:transform'];
xslElement.AllowableChildElements = ['', 'xsl:apply-imports', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:number', 'xsl:param', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:transform', 1, 'Define the root of the transform');
xslElement.Attributes['version'] = new Attribute('version', 'The version of XSLT.', '', true);
xslElement.Attributes['id'] = new Attribute('id', 'A unique identifier that facilitates embedding style sheets.', '', false);
xslElement.Attributes['extension-element-prefixes'] = new Attribute('extension-element-prefixes', 'A white space separated list of namespace prefixes used for extension elements.', '', false);
xslElement.Attributes['exclude-result-prefixes'] = new Attribute('exclude-result-prefixes', 'A white space separated list of namespace prefixes that should not be sent to the output.', '', false);
xslElement.AllowableChildElements = ['xsl:attribute-set', 'xsl:function', 'xsl:import', 'xsl:include', 'xsl:output', 'xsl:param', 'xsl:template', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:value-of', 0, 'Insert the value of the selected node as text');
xslElement.Attributes['select'] = new Attribute('select', 'The Expressions to be evaluated against the current context.', '', true);
xslElement.Attributes['disable-output-escaping'] = new Attribute('disable-output-escaping', 'Default is \"no\". If the value is \"yes\", the text node generated will be output without any escaping.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:fallback', 'xsl:for-each', 'xsl:if', 'xsl:message', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:sequence', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:variable', 0, 'Specify value bound to expression');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names of the variable.', '', true);
xslElement.Attributes['select'] = new Attribute('select', 'The value of the attribute is an Expressions, and the value of the variable is the object that results from evaluating the expression. When this attribute is specified, the content of xsl:variable must be empty.', '', false);
xslElement.AllowableParentElements = ['', 'xsl:attribute', 'xsl:comment', 'xsl:copy', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:otherwise', 'xsl:param', 'xsl:processing-instruction', 'xsl:stylesheet', 'xsl:transform', 'xsl:template', 'xsl:variable', 'xsl:when', 'xsl:with-param'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:when', 0, 'Provide test condition used in xsl:choose');
xslElement.Attributes['test'] = new Attribute('test', 'The condition in the source data to test.', '', true);
xslElement.AllowableParentElements = ['xsl:choose'];
xslElement.AllowableChildElements = ['', 'xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;

xslElement = new XmlElement('xsl:with-param', 0, 'Pass a parameter to a template');
xslElement.Attributes['name'] = new Attribute('name', 'The Qualified Names of the parameter.', '', true);
xslElement.Attributes['select'] = new Attribute('select', 'The condition in the source data to test.', '', false);
xslElement.AllowableParentElements = ['xsl:apply-templates', 'xsl:call-template'];
xslElement.AllowableChildElements = ['xsl:apply-templates', 'xsl:attribute', 'xsl:call-template', 'xsl:choose', 'xsl:comment', 'xsl:copy', 'xsl:copy-of', 'xsl:element', 'xsl:for-each', 'xsl:if', 'xsl:processing-instruction', 'xsl:text', 'xsl:value-of', 'xsl:variable'];
xslElements[xslElement.Name] = xslElement;


// List of known XPath functions
var xPathFunctions = {};

xPathFunctions['|'] = new XPathFunction('Operators', '|', ' | ', 'Computes two node-sets.<br/><br/><b>Example:</b><br/> /in/user/userID | /in/user/username<br/><br/><b>Result:</b><br/> Returns a node-set with the user ID and username.');
xPathFunctions['+'] = new XPathFunction('Operators', '+', ' + ', 'Addition.<br/><br/><b>Example:</b><br/> 2 | 3<br/><br/><b>Result:</b><br/> 5');
xPathFunctions['-'] = new XPathFunction('Operators', '-', ' - ', 'Subtraction.<br/><br/><b>Example:</b><br/> 5 - 2<br/><br/><b>Result:</b><br/> 3');
xPathFunctions['*'] = new XPathFunction('Operators', '*', ' * ', 'Multiplication.<br/><br/><b>Example:</b><br/> 2 * 3<br/><br/><b>Result:</b><br/> 6');
xPathFunctions['div'] = new XPathFunction('Operators', 'div', ' div ', 'Division.<br/><br/><b>Example:</b><br/> 6 div 2<br/><br/><b>Result:</b><br/> 3');
xPathFunctions['mod'] = new XPathFunction('Operators', 'mod', ' mod ', 'Modulus.<br/><br/><b>Example:</b><br/> 5 mod 2<br/><br/><b>Result:</b><br/> 1');
xPathFunctions['='] = new XPathFunction('Operators', '=', ' = ', 'Logical equal.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount = 10.00<br/><br/><b>Result:</b><br/> true if sub-total equals 10, otherwise false.');
xPathFunctions['!='] = new XPathFunction('Operators', '!=', ' != ', 'Logical not equal.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount != 10<br/><br/><b>Result:</b><br/> true if sub-total does not equals 10, otherwise false.');
xPathFunctions['<'] = new XPathFunction('Operators', '<', ' < ', 'Logical less than.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount &lt; 10<br/><br/><b>Result:</b><br/> true if sub-total is less than 10, otherwise false.');
xPathFunctions['<='] = new XPathFunction('Operators', '<=', ' <= ', 'Logical less than or equal.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount &lt;= 10<br/><br/><b>Result:</b><br/> true if sub-total is less than or equal to 10, otherwise false.');
xPathFunctions['>'] = new XPathFunction('Operators', '>', ' > ', 'Logical greater than.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount &gt; 10<br/><br/><b>Result:</b><br/> true if sub-total is greater than 10, otherwise false.');
xPathFunctions['>='] = new XPathFunction('Operators', '>=', ' >= ', 'Logical greater than equal.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount &gt;= 10<br/><br/><b>Result:</b><br/> true if sub-total is greater than or equal to 10, otherwise false.');
xPathFunctions['or'] = new XPathFunction('Operators', 'or', ' or ', 'Logical OR of two operands.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount = 10 or /in/salesOrder/subTotalAmount = 20<br/><br/><b>Result:</b><br/> true if sub-total equals 10 or sub-total equals 20, otherwise false.');
xPathFunctions['and'] = new XPathFunction('Operators', 'and', ' and ', 'Logical AND of two operands.<br/><br/><b>Example:</b><br/> /in/salesOrder/subTotalAmount = 10 and /in/salesOrder/shippingCountryCode = \'US\'<br/><br/><b>Result:</b><br/> true if sub-total equals 10 and shipping country equals United States.');
xPathFunctions['to'] = new XPathFunction('Operators', 'to', ' to ', 'Returns a sequence of consecutive integers in a given range.<br/><br/><b>Example:</b><br/> 1 to 3<br/><br/><b>Result:</b><br/> (1, 2, 3)');

xPathFunctions['avg((arg,arg,...))'] = new XPathFunction('Aggregates', 'avg((arg,arg,...))', 'avg(())', 'Returns the average of the argument values.<br/><br/><b>Example:</b><br/>avg((1,2,3))<br/><br/><b>Result:</b><br/>2');
xPathFunctions['count((item,item,...))'] = new XPathFunction('Aggregates', 'count((item,item,...))', 'count(())', 'Returns the count of nodes.');
xPathFunctions['max((arg,arg,...))'] = new XPathFunction('Aggregates', 'max((arg,arg,...))', 'max(())', 'Returns the argument that is greater than the others.<br/><br/><b>Example:</b><br/>max((1,2,3))<br/><br/><b>Result:</b><br/>3<br/><br/><b>Example:</b><br/>max((\'a\', \'k\'))<br/><br/><b>Result:</b><br/>\'k\'');
xPathFunctions['min((arg,arg,...))'] = new XPathFunction('Aggregates', 'min((arg,arg,...))', 'min(())', 'Returns the argument that is less than the others.<br/><br/><b>Example:</b><br/>min((1,2,3))<br/><br/><b>Result:</b><br/>1<br/><br/><b>Example:</b><br/>min((\'a\', \'k\'))<br/><br/><b>Result:</b><br/>\'a\'');
xPathFunctions['sum(arg,arg,...)'] = new XPathFunction('Aggregates', 'sum(arg,arg,...)', 'sum()', 'Returns the sum of the numeric value of each node in the specified node-set.');

xPathFunctions['boolean(arg)'] = new XPathFunction('Boolean', 'boolean(arg)', 'boolean()', 'Returns a boolean value for a number, string, or node-set.');
xPathFunctions['false()'] = new XPathFunction('Boolean', 'false()', 'false()', 'Returns the boolean value false.<br/><br/><b>Example:</b><br/>false()<br/><br/><b>Result:</b><br/>false');
xPathFunctions['not(arg)'] = new XPathFunction('Boolean', 'not(arg)', 'not()', 'The argument is first reduced to a boolean value by applying the boolean() function. Returns true if the boolean value is false, and false if the boolean value is true.<br/><br/><b>Example:</b><br/>not(true())<br/><br/><b>Result:</b><br/>false');
xPathFunctions['true()'] = new XPathFunction('Boolean', 'true()', 'true()', 'Returns the boolean value true.<br/><br/><b>Example:</b><br/>true()<br/><br/><b>Result:</b><br/>true');

xPathFunctions['dateTime(date,time)'] = new XPathFunction('Date & Time', 'dateTime(date,time)', 'dateTime(,)', 'Converts the arguments to a date and a time.');
xPathFunctions['adjust-dateTime-to-timezone(datetime,timezone)'] = new XPathFunction('Date & Time', 'adjust-dateTime-to-timezone(datetime,timezone)', 'adjust-dateTime-to-timezone(,)', 'If the timezone argument is empty, it returns a dateTime without a timezone. Otherwise, it returns a dateTime with a timezone.');
xPathFunctions['adjust-date-to-timezone(date,timezone)'] = new XPathFunction('Date & Time', 'adjust-date-to-timezone(date,timezone)', 'adjust-date-to-timezone(,)', 'If the timezone argument is empty, it returns a date without a timezone. Otherwise, it returns a date with a timezone.');
xPathFunctions['adjust-time-to-timezone(time,timezone)'] = new XPathFunction('Date & Time', 'adjust-time-to-timezone(time,timezone)', 'adjust-time-to-timezone(,)', 'If the timezone argument is empty, it returns a time without a timezone. Otherwise, it returns a time with a timezone.');
xPathFunctions['current-date()'] = new XPathFunction('Date & Time', 'current-date()', 'current-date()', 'Returns the current date with timezone.');
xPathFunctions['current-dateTime()'] = new XPathFunction('Date & Time', 'current-dateTime()', 'current-dateTime()', 'Returns the current date & time with timezone.');
xPathFunctions['current-time()'] = new XPathFunction('Date & Time', 'current-time()', 'current-time()', 'Returns the current time with timezone.');
xPathFunctions['day-from-date(date)'] = new XPathFunction('Date & Time', 'day-from-date(date)', 'day-from-date()', 'Returns an integer that represents the day in the localized value of the argument.<br/><br/><b>Example:</b><br/>day-from-date(xs:date(\"2005-04-23\"))<br/><br/><b>Result:</b><br/>23');
xPathFunctions['day-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'day-from-dateTime(datetime)', 'day-from-dateTime()', 'Returns an integer that represents the day component in the localized value of the argument.<br/><br/><b>Example:</b><br/>day-from-dateTime(xs:dateTime(\"2005-01-10T12:30-04:10\"))<br/><br/><b>Result:</b><br/>10');
xPathFunctions['days-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'days-from-duration(datetimedur)', 'days-from-duration()', 'Returns an integer that represents the days component in the canonical lexical representation of the value of the argument.');
xPathFunctions['format-date(date, format)'] = new XPathFunction('Date & Time', 'format-date(date, format)', 'format-date(date, format)', 'Returns a string containing a date value formatted for display.');
xPathFunctions['format-dateTime(datetime, format)'] = new XPathFunction('Date & Time', 'format-dateTime(datetime, format)', 'format-dateTime(datetime, format)', 'Returns a string containing a datetime value formatted for display.');
xPathFunctions['format-time(time, format)'] = new XPathFunction('Date & Time', 'format-time(time, format)', 'format-time(time, format)', 'Returns a string containing a time value formatted for display.');
xPathFunctions['hours-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'hours-from-dateTime(datetime)', 'hours-from-dateTime()', 'Returns an integer that represents the hours component in the localized value of the argument.<br/><br/><b>Example:</b><br/>hours-from-dateTime(xs:dateTime(\"2005-01-10T12:30-04:10\"))<br/><br/><b>Result:</b><br/>12');
xPathFunctions['hours-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'hours-from-duration(datetimedur)', 'hours-from-duration()', 'Returns an integer that represents the hours component in the canonical lexical representation of the value of the argument.');
xPathFunctions['hours-from-time(time)'] = new XPathFunction('Date & Time', 'hours-from-time(time)', 'hours-from-time()', 'Returns an integer that represents the hours component in the localized value of the argument.<br/><br/><b>Example:</b><br/>hours-from-time(xs:time(\"10:22:00\"))<br/><br/><b>Result:</b><br/>10');
xPathFunctions['implicit-timezone()'] = new XPathFunction('Date & Time', 'implicit-timezone()', 'implicit-timezone()', 'Returns the value of the implicit timezone.');
xPathFunctions['minutes-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'minutes-from-dateTime(datetime)', 'minutes-from-dateTime()', 'Returns an integer that represents the minutes component in the localized value of the argument.<br/><br/><b>Example:</b><br/>minutes-from-dateTime(xs:dateTime(\"2005-01-10T12:30-04:10\"))<br/><br/><b>Result:</b><br/>30');
xPathFunctions['minutes-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'minutes-from-duration(datetimedur)', 'minutes-from-duration()', 'Returns an integer that represents the minutes component in the canonical lexical representation of the value of the argument.');
xPathFunctions['minutes-from-time(time)'] = new XPathFunction('Date & Time', 'minutes-from-time(time)', 'minutes-from-time()', 'Returns an integer that represents the minutes component in the localized value of the argument.<br/><br/><b>Example:</b><br/>minutes-from-time(xs:time(\"10:22:00\"))<br/><br/><b>Result:</b><br/>22');
xPathFunctions['month-from-date(date)'] = new XPathFunction('Date & Time', 'month-from-date(date)', 'month-from-date()', 'Returns an integer that represents the month in the localized value of the argument.<br/><br/><b>Example:</b><br/>month-from-date(xs:date(\"2005-04-23\"))<br/><br/><b>Result:</b><br/>4');
xPathFunctions['month-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'month-from-dateTime(datetime)', 'month-from-dateTime()', 'Returns an integer that represents the month component in the localized value of the argument.<br/><br/><b>Example:</b><br/>month-from-dateTime(xs:dateTime(\"2005-01-10T12:30-04:10\"))<br/><br/><b>Result:</b><br/>01');
xPathFunctions['months-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'months-from-duration(datetimedur)', 'months-from-duration()', 'Returns an integer that represents the months component in the canonical lexical representation of the value of the argument.');
xPathFunctions['seconds-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'seconds-from-dateTime(datetime)', 'seconds-from-dateTime()', 'Returns a decimal that represents the seconds component in the localized value of the argument.<br/><br/><b>Example:</b><br/>seconds-from-dateTime(xs:dateTime(\"2005-01-10T12:30:00-04:10\"))<br/><br/><b>Result:</b><br/>0');
xPathFunctions['seconds-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'seconds-from-duration(datetimedur)', 'seconds-from-duration()', 'Returns a decimal that represents the seconds component in the canonical lexical representation of the value of the argument.');
xPathFunctions['seconds-from-time(time)'] = new XPathFunction('Date & Time', 'seconds-from-time(time)', 'seconds-from-time()', 'Returns an integer that represents the seconds component in the localized value of the argument.<br/><br/><b>Example:</b><br/>seconds-from-time(xs:time(\"10:22:00\"))<br/><br/><b>Result:</b><br/>0');
xPathFunctions['timezone-from-date(date)'] = new XPathFunction('Date & Time', 'timezone-from-date(date)', 'timezone-from-date()', 'Returns the time zone component of the argument if any.');
xPathFunctions['timezone-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'timezone-from-dateTime(datetime)', 'timezone-from-dateTime()', 'Returns the time zone component of the argument if any.');
xPathFunctions['timezone-from-time(time)'] = new XPathFunction('Date & Time', 'timezone-from-time(time)', 'timezone-from-time()', 'Returns the time zone component of the argument if any.');
xPathFunctions['year-from-date(date)'] = new XPathFunction('Date & Time', 'year-from-date(date)', 'year-from-date()', 'Returns an integer that represents the year in the localized value of the argument.<br/><br/><b>Example:</b><br/>year-from-date(xs:date(\"2005-04-23\"))<br/><br/><b>Result:</b><br/>2005');
xPathFunctions['year-from-dateTime(datetime)'] = new XPathFunction('Date & Time', 'year-from-dateTime(datetime)', 'year-from-dateTime()', 'Returns an integer that represents the year component in the localized value of the argument.<br/><br/><b>Example:</b><br/>year-from-dateTime(xs:dateTime(\"2005-01-10T12:30-04:10\"))<br/><br/><b>Result:</b><br/>2005');
xPathFunctions['years-from-duration(datetimedur)'] = new XPathFunction('Date & Time', 'years-from-duration(datetimedur)', 'years-from-duration()', 'Returns an integer that represents the years component in the canonical lexical representation of the value of the argument.');

xPathFunctions['base-uri(node)'] = new XPathFunction('Nodes', 'base-uri(node)', 'base-uri()', 'Returns the value of the base-uri property of the current or specified node.');
xPathFunctions['deep-equal(param1,param2,collation)'] = new XPathFunction('Nodes', 'deep-equal(param1,param2,collation)', 'deep-equal(,,)', 'Returns true if param1 and param2 are deep-equal to each other, otherwise it returns false.');
xPathFunctions['default-collation()'] = new XPathFunction('Nodes', 'default-collation()', 'default-collation()', 'Returns the value of the default collation.');
xPathFunctions['document-uri(node)'] = new XPathFunction('Nodes', 'document-uri(node)', 'document-uri()', 'Returns the value of the document-uri property for the specified node.');
xPathFunctions['in-scope-prefixes()'] = new XPathFunction('Nodes', 'in-scope-prefixes()', 'in-scope-prefixes()', '');
xPathFunctions['lang(lang)'] = new XPathFunction('Nodes', 'lang(lang)', 'lang()', 'Returns true if the language of the current node matches the language of the specified language.<br/><br/><b>Example:</b><br/>Lang(\"en\") is true for.&lt;p xml:lang=\"en\"&gt;...</p><br/><br/><b>Example:</b><br/>Lang(\"de\") is false for. &lt;p xml:lang=\"en\"&gt;...</p>');
xPathFunctions['last()'] = new XPathFunction('Nodes', 'last()', 'last()', 'Returns the number of items in the processed node list.<br/><br/><b>Example:</b><br/>//book[last()]<br/><br/><b>Result:</b><br/>Selects the last book element');
xPathFunctions['local-name(nodeset)'] = new XPathFunction('Nodes', 'local-name(nodeset)', 'local-name()', 'Returns the name of the current node if no argument is specified or the first node in the specified node set - without the namespace prefix.');
xPathFunctions['local-name-from-QName()'] = new XPathFunction('Nodes', 'local-name-from-QName()', 'local-name-from-QName()', '');
xPathFunctions['name(nodeset)'] = new XPathFunction('Nodes', 'name(nodeset)', 'name()', 'Returns the name of the current node if no argument is specified or the first node in the specified node set.');
xPathFunctions['namespace-uri(nodeset)'] = new XPathFunction('Nodes', 'namespace-uri(nodeset)', 'namespace-uri()', 'Returns the namespace URI of the current node if no argument is specified or the first node in the specified node set.');
xPathFunctions['namespace-uri-for-prefix()'] = new XPathFunction('Nodes', 'namespace-uri-for-prefix()', 'namespace-uri-for-prefix()', '');
xPathFunctions['namespace-uri-from-QName()'] = new XPathFunction('Nodes', 'namespace-uri-from-QName()', 'namespace-uri-from-QName()', '');
xPathFunctions['nilled(node)'] = new XPathFunction('Nodes', 'nilled(node)', 'nilled()', 'Returns a Boolean value indicating whether the argument node is nilled.');
xPathFunctions['node-name(node)'] = new XPathFunction('Nodes', 'node-name(node)', 'node-name()', 'Returns the node-name of the argument node.');
xPathFunctions['position()'] = new XPathFunction('Nodes', 'position()', 'position()', 'Returns the index position of the node that is currently being processed.<br/><br/><b>Example:</b><br/>//book[position()&lt;=3]<br/><br/><b>Result:</b><br/>Selects the first three book elements ');
xPathFunctions['QName()'] = new XPathFunction('Nodes', 'QName()', 'QName()', '');
xPathFunctions['resolve-QName()'] = new XPathFunction('Nodes', 'resolve-QName()', 'resolve-QName()', '');
xPathFunctions['root(node)'] = new XPathFunction('Nodes', 'root(node)', 'root()', 'Returns the root of the tree to which the current node if no argument is specified or the root for the specified node belongs. This will usually be a document node.');
xPathFunctions['static-base-uri()'] = new XPathFunction('Nodes', 'static-base-uri()', 'static-base-uri()', 'Returns the value of the base-uri.');

xPathFunctions['abs(num)'] = new XPathFunction('Numeric', 'abs(num)', 'abs()', 'Returns the absolute value of the argument.<br/><br/><b>Example:</b><br/> abs(-3.14)<br/><br/><b>Result:</b><br/> 3.14');
xPathFunctions['ceiling(num)'] = new XPathFunction('Numeric', 'ceiling(num)', 'ceiling()', 'Returns the smallest integer that is greater than the number argument.<br/><br/><b>Example:</b><br/> ceiling(3.14)<br/><br/><b>Result:</b><br/> 4');
xPathFunctions['floor(num)'] = new XPathFunction('Numeric', 'floor(num)', 'floor()', 'Returns the largest integer that is not greater than the number argument.<br/><br/><b>Example:</b><br/> floor(3.14)<br/><br/><b>Result:</b><br/> 3');
xPathFunctions['number(arg)'] = new XPathFunction('Numeric', 'number(arg)', 'number()', 'Returns the numeric value of the argument. The argument could be a boolean, string, or node-set.<br/><br/><b>Example:</b><br/> number(\"100\")<br/> <br/><b>Result:</b><br/> 100');
xPathFunctions['round(num)'] = new XPathFunction('Numeric', 'round(num)', 'round()', 'Rounds the number argument to the nearest integer.<br/><br/><b>Example:</b><br/> round(3.14)<br/> <br/><b>Result:</b><br/> 3');
xPathFunctions['round-half-to-even(num)'] = new XPathFunction('Numeric', 'round-half-to-even(num)', 'round-half-to-even()', 'Rounds a numeric value to the nearest whole number, rounding x.5 towards the nearest even number.<br/><br/><b>Example:</b><br/> round-half-to-even(0.5)<br/><br/><b>Result:</b><br/> 0 <br/><br/><b>Example:</b><br/> round-half-to-even(1.5)<br/> <br/><b>Result:</b><br/> 2');

xPathFunctions['collection(string)'] = new XPathFunction('Sequences', 'collection(string)', 'collection()', '');
xPathFunctions['data(item.item,...)'] = new XPathFunction('Sequences', 'data(item.item,...)', 'data()', 'Takes a sequence of items and returns a sequence of atomic values.');
xPathFunctions['distinct-values((item,item,...),collation)'] = new XPathFunction('Sequences', 'distinct-values((item,item,...),collation)', 'distinct-values((),)', 'Returns only distinct (different) values.<br/><br/><b>Example:</b><br/>distinct-values((1, 2, 3, 1, 2))<br/><br/><b>Result:</b><br/>(1, 2, 3)');
xPathFunctions['doc(URI)'] = new XPathFunction('Sequences', 'doc(URI)', 'doc()', '');
xPathFunctions['doc-available(URI)'] = new XPathFunction('Sequences', 'doc-available(URI)', 'doc-available()', 'Returns true if the doc() function returns a document node, otherwise it returns false.');
xPathFunctions['empty(item,item,...)'] = new XPathFunction('Sequences', 'empty(item,item,...)', 'empty()', 'Returns true if the value of the arguments IS an empty sequence, otherwise it returns false.<br/><br/><b>Example:</b><br/>empty(remove((\"ab\", \"cd\"), 1))<br/><br/><b>Result:</b><br/>false');
xPathFunctions['exactly-one(item,item,...)'] = new XPathFunction('Sequences', 'exactly-one(item,item,...)', 'exactly-one()', 'Returns the argument if it contains exactly one item, otherwise it raises an error.');
xPathFunctions['exists(item,item,...)'] = new XPathFunction('Sequences', 'exists(item,item,...)', 'exists()', 'Returns true if the value of the arguments IS NOT an empty sequence, otherwise it returns false.<br/><br/><b>Example:</b><br/>exists(remove((\"ab\"), 1))<br/><br/><b>Result:</b><br/>false');
xPathFunctions['id((string,string,...),node)'] = new XPathFunction('Sequences', 'id((string,string,...),node)', 'id((),)', 'Returns a sequence of element nodes that have an ID value equal to the value of one or more of the values specified in the string argument.');
xPathFunctions['idref((string,string,...),node)'] = new XPathFunction('Sequences', 'idref((string,string,...),node)', 'idref((),)', 'Returns a sequence of element or attribute nodes that have an IDREF value equal to the value of one or more of the values specified in the string argument.');
xPathFunctions['index-of((item,item,...),searchitem)'] = new XPathFunction('Sequences', 'index-of((item,item,...),searchitem)', 'index-of((),)', 'Returns the positions within the sequence of items that are equal to the searchitem argument.<br/><br/><b>Example:</b><br/>index-of((15, 40, 25, 40, 10), 40)<br/><br/><b>Result:</b><br/>(2, 4)<br/><br/><b>Example:</b><br/>index-of((\"a\", \"dog\", \"and\", \"a\", \"duck\"), \"a\")<br/><br/><b>Result:</b><br/>(1, 4)<br/><br/><b>Example:</b><br/>index-of ((15, 40, 25, 40, 10), 18)<br/><br/><b>Result:</b><br/>()');
xPathFunctions['insert-before((item,item,...),pos,inserts)'] = new XPathFunction('Sequences', 'insert-before((item,item,...),pos,inserts)', 'insert-before((),,)', 'Returns a new sequence constructed from the value of the item arguments - with the value of the inserts argument inserted in the position specified by the pos argument.<br/><br/><b>Example:</b><br/>insert-before((\"ab\", \"cd\"), 0, \"gh\")<br/><br/><b>Result:</b><br/>(\"gh\", \"ab\", \"cd\")<br/><br/><b>Example:</b><br/>insert-before((\"ab\", \"cd\"), 1, \"gh\")<br/><br/><b>Result:</b><br/>(\"gh\", \"ab\", \"cd\")<br/><br/><b>Example:</b><br/>insert-before((\"ab\", \"cd\"), 2, \"gh\")<br/><br/><b>Result:</b><br/>(\"ab\", \"gh\", \"cd\")<br/><br/><b>Example:</b><br/>insert-before((\"ab\", \"cd\"), 5, \"gh\")<br/><br/><b>Result:</b><br/>(\"ab\", \"cd\", \"gh\")');
xPathFunctions['one-or-more(item,item,...)'] = new XPathFunction('Sequences', 'one-or-more(item,item,...)', 'one-or-more()', 'Returns the argument if it contains one or more items, otherwise it raises an error.');
xPathFunctions['remove((item,item,...),position)'] = new XPathFunction('Sequences', 'remove((item,item,...),position)', 'remove((),)', 'Returns a new sequence constructed from the value of the item arguments - with the item specified by the position argument removed.<br/><br/><b>Example:</b><br/>remove((\"ab\", \"cd\", \"ef\"), 0)<br/><br/><b>Result:</b><br/>(\"ab\", \"cd\", \"ef\")<br/><br/><b>Example:</b><br/>remove((\"ab\", \"cd\", \"ef\"), 1)<br/><br/><b>Result:</b><br/>(\"cd\", \"ef\")<br/><br/><b>Example:</b><br/>remove((\"ab\", \"cd\", \"ef\"), 4)<br/><br/><b>Result:</b><br/>(\"ab\", \"cd\", \"ef\")');
xPathFunctions['reverse((item,item,...))'] = new XPathFunction('Sequences', 'reverse((item,item,...))', 'reverse(())', 'Returns the reversed order of the items specified. <br/><br/><b>Example:</b><br/>reverse((\"ab\", \"cd\", \"ef\"))<br/><br/><b>Result:</b><br/>(\"ef\", \"cd\", \"ab\")<br/><br/><b>Example:</b><br/>reverse((\"ab\"))<br/><br/><b>Result:</b><br/>(\"ab\")');
xPathFunctions['subsequence((item,item,...),start,len)'] = new XPathFunction('Sequences', 'subsequence((item,item,...),start,len)', 'subsequence((),,)', 'Returns a sequence of items from the position specified by the start argument and continuing for the number of items specified by the len argument. The first item is located at position 1.<br/><br/><b>Example:</b><br/>subsequence(($item1, $item2, $item3,...), 3)<br/><br/><b>Result:</b><br/>($item3, ...)<br/><br/><b>Example:</b><br/>subsequence(($item1, $item2, $item3, ...), 2, 2)<br/><br/><b>Result:</b><br/>($item2, $item3)');
xPathFunctions['unordered((item,item,...))'] = new XPathFunction('Sequences', 'unordered((item,item,...))', 'unordered(())', 'Returns the items in an implementation dependent order.');
xPathFunctions['zero-or-one(item,item,...)'] = new XPathFunction('Sequences', 'zero-or-one(item,item,...)', 'zero-or-one()', 'Returns the argument if it contains zero or one items, otherwise it raises an error.');

xPathFunctions['codepoint-equal(comp1,comp2)'] = new XPathFunction('String', 'codepoint-equal(comp1,comp2)', 'codepoint-equal(,)', 'Returns true if the value of comp1 is equal to the value of comp2, according to the Unicode code point collation, otherwise it returns false');
xPathFunctions['codepoints-to-string(int,int,...)'] = new XPathFunction('String', 'codepoints-to-string(int,int,...)', 'codepoints-to-string()', 'Returns a string from a sequence of code points.<br/><br/><b>Example:</b><br/>codepoints-to-string(84, 104, 233, 114, 232, 115, 101)<br/><br/><b>Result:</b><br/>\'Thérèse\'');
xPathFunctions['compare(comp1,comp2,collation)'] = new XPathFunction('String', 'compare(comp1,comp2,collation)', 'compare(,,)', 'Returns -1 if comp1 is less than comp2, 0 if comp1 is equal to comp2, or 1 if comp1 is greater than comp2 (according to the rules of the collation that is used).<br/><br/><b>Example:</b><br/>compare(\'ghi\', \'ghi\')<br/><br/><b>Result:</b><br/>0');
xPathFunctions['concat(string,string,...)'] = new XPathFunction('String', 'concat(string,string,...)', 'concat(,)', 'Returns the concatenation of the strings.<br/><br/><b>Example:</b><br/>concat(\'XPath \',\'is \',\'fun\')<br/><br/><b>Result:</b><br/>\'XPath is fun\'');
xPathFunctions['contains(string1,string2)'] = new XPathFunction('String', 'contains(string1,string2)', 'contains(,)', 'Returns true if string1 contains string2, otherwise it returns false.<br/><br/><b>Example:</b><br/>contains(\'XML\',\'XM\')<br/><br/><b>Result:</b><br/>true');
xPathFunctions['ends-with(string1,string2)'] = new XPathFunction('String', 'ends-with(string1,string2)', 'ends-with(,)', 'Returns true if string1 ends with string2, otherwise it returns false.<br/><br/><b>Example:</b><br/>ends-with(\'XML\',\'X\')<br/><br/><b>Result:</b><br/>false');
xPathFunctions['escape-uri(stringURI,esc-res)'] = new XPathFunction('String', 'escape-uri(stringURI,esc-res)', 'escape-uri(,)', 'Applies the %HH escaping convention to a URI.<br/><br/><b>Example:</b><br/>escape-uri(\"http://example.com/test#car\", true())<br/><br/><b>Result:</b><br/>\"http%3A%2F%2Fexample.com%2Ftest#car\"<br/><br/><b>Example:</b><br/>escape-uri(\"http://example.com/test#car\", false())<br/><br/><b>Result:</b><br/>\"http://example.com/test#car\"<br/><br/><b>Example:</b><br/>escape-uri(\"http://example.com/~bébé\", false())<br/><br/><b>Result:</b><br/>\"http://example.com/~b%C3%A9b%C3%A9\"');
xPathFunctions['lower-case(string)'] = new XPathFunction('String', 'lower-case(string)', 'lower-case()', 'Converts the string argument to lower-case.<br/><br/><b>Example:</b><br/>lower-case(\'The XML\')<br/><br/><b>Result:</b><br/>\'the xml\'');
xPathFunctions['matches(string,pattern)'] = new XPathFunction('String', 'matches(string,pattern)', 'matches(,)', 'Returns true if the string argument matches the pattern, otherwise, it returns false.<br/><br/><b>Example:</b><br/>matches(\"Merano\", \"ran\")<br/><br/><b>Result:</b><br/>true');
xPathFunctions['normalize-space(string)'] = new XPathFunction('String', 'normalize-space(string)', 'normalize-space()', 'Removes leading and trailing spaces from the specified string, and replaces all internal sequences of white space with one and returns the result. If there is no string argument it does the same on the current node.<br/><br/><b>Example:</b><br/>normalize-space(\' The   XML \')<br/><br/><b>Result:</b><br/>\'The XML\'');
xPathFunctions['replace(string,pattern,replace)'] = new XPathFunction('String', 'replace(string,pattern,replace)', 'replace(,,)', 'Returns a string that is created by replacing the given pattern with the replace argument.<br/><br/><b>Example:</b><br/>replace(\"Bella Italia\", \"l\", \"*\")<br/><br/><b>Result:</b><br/>\'Be**a Ita*ia\' <br/><br/><b>Example:</b><br/>replace(\"Bella Italia\", \"l\", \"\")<br/><br/><b>Result:</b><br/>\'Bea Itaia\' ');
xPathFunctions['resolve-uri(relative,base)'] = new XPathFunction('String', 'resolve-uri(relative,base)', 'resolve-uri(,)', 'Resolves a relative URI against the base URI from the static context.');
xPathFunctions['starts-with(string1,string2)'] = new XPathFunction('String', 'starts-with(string1,string2)', 'starts-with(,)', 'Returns true if string1 starts with string2, otherwise it returns false.<br/><br/><b>Example:</b><br/>starts-with(\'XML\',\'X\')<br/><br/><b>Result:</b><br/>true');
xPathFunctions['string(arg)'] = new XPathFunction('String', 'string(arg)', 'string()', 'Returns the string value of the argument. The argument could be a number, boolean, or node-set.<br/><br/><b>Example:</b><br/>string(314)<br/><br/><b>Result:</b><br/>\"314\"');
xPathFunctions['string-join((string,string,...),sep)'] = new XPathFunction('String', 'string-join((string,string,...),sep)', 'string-join((,),)', 'Returns a string created by concatenating the string arguments and using the sep argument as the separator.<br/><br/><b>Example:</b><br/>string-join((\'We\', \'are\', \'having\', \'fun!\'), \' \')<br/><br/><b>Result:</b><br/>\' We are having fun! \'<br/><br/><b>Example:</b><br/>string-join((\'We\', \'are\', \'having\', \'fun\'))<br/><br/><b>Result:</b><br/>\'Wearehavingfun\'');
xPathFunctions['string-length(string)'] = new XPathFunction('String', 'string-length(string)', 'string-length()', 'Returns the length of the specified string. If there is no string argument it returns the length of the string value of the current node<br/><br/><b>Example:</b><br/>string-length(\'Beatles\')<br/><br/><b>Result:</b><br/>7');
xPathFunctions['string-to-codepoints(string)'] = new XPathFunction('String', 'string-to-codepoints(string)', 'string-to-codepoints()', 'Returns a sequence of code points from a string.<br/><br/><b>Example:</b><br/>string-to-codepoints(\"Thérèse\")<br/><br/><b>Result:</b><br/>84, 104, 233, 114, 232, 115, 101');
xPathFunctions['substring(string,start,len)'] = new XPathFunction('String', 'substring(string,start,len)', 'substring(,,)', 'Returns the substring from the start position to the specified length. Index of the first character is 1. If length is omitted it returns the substring from the start position to the end.<br/><br/><b>Example:</b><br/>substring(\'Beatles\',1,4)<br/><br/><b>Result:</b><br/>\'Beat\'<br/><br/><b>Example:</b><br/>substring(\'Beatles\',2)<br/><br/><b>Result:</b><br/>\'eatles\'');
xPathFunctions['substring-after(string1,string2)'] = new XPathFunction('String', 'substring-after(string1,string2)', 'substring-after(,)', 'Returns the remainder of string1 after string2 occurs in it. <br/><br/><b>Example:</b><br/>substring-after(\'12/10\',\'/\')<br/><br/><b>Result:</b><br/>\'10\'');
xPathFunctions['substring-before(string1,string2)'] = new XPathFunction('String', 'substring-before(string1,string2)', 'substring-before(,)', 'Returns the start of string1 before string2 occurs in it.<br/><br/><b>Example:</b><br/>substring-before(\'12/10\',\'/\')<br/><br/><b>Result:</b><br/>\'12\'');
xPathFunctions['tokenize(string,pattern)'] = new XPathFunction('String', 'tokenize(string,pattern)', 'tokenize(,)', '<br/><br/><b>Example:</b><br/>tokenize(\"XPath is fun\", \"\s+\")<br/><br/><b>Result:</b><br/>(\"XPath\", \"is\", \"fun\")');
xPathFunctions['translate(string1,string2,string3)'] = new XPathFunction('String', 'translate(string1,string2,string3)', 'translate(,,)', 'Converts string1 by replacing the characters in string2 with the characters in string3.<br/><br/><b>Example:</b><br/>translate(\'12:30\',\'30\',\'45\')<br/><br/><b>Result:</b><br/>\'12:45\'<br/><br/><b>Example:</b><br/>translate(\'12:30\',\'03\',\'54\')<br/><br/><b>Result:</b><br/>\'12:45\'<br/><br/><b>Example:</b><br/>translate(\'12:30\',\'0123\',\'abcd\')<br/><br/><b>Result:</b><br/>\'bc:da\'');
xPathFunctions['upper-case(string)'] = new XPathFunction('String', 'upper-case(string)', 'upper-case()', 'Converts the string argument to upper-case.<br/><br/><b>Example:</b><br/>upper-case(\'The XML\')<br/><br/><b>Result:</b><br/>\'THE XML\'');

function RenderDesignFromSource(treeView, sourceTextBox)
{
	// Clear treeview
	treeView.get_nodes().clear();

	if (sourceTextBox.value == '')
		return;

	try
	{
		// Need to add namespace declaration of asp tags
		// since it's usually omitted in text
		var xmlSource = sourceTextBox.value;

		if (sourceTextBox.value.indexOf("<asp:") >= 0)
			xmlSource = '<nswrapper xmlns:asp="http://www.microsoft.com/system.web">' + xmlSource + '</nswrapper>';

		var xDoc = Revindex.Xml.ParseXml(xmlSource);
		RenderDesignFromSourceRecursive(treeView, xDoc, null);

		// Mark tree enabled as valid
		treeView.set_enabled(true);
	}
	catch (ex)
	{
		treeView.get_nodes().clear();

		// Set disabled to indicate tree view is in error state
		treeView.set_enabled(false);
		throw ex;
	}
}

function RenderDesignFromSourceRecursive(treeView, xNode, currentNode)
{
	if (xNode != null)
	{
		if (xNode.nodeName == "#document")
		{
			for (var i = 0; i < xNode.childNodes.length; i++)
			{
				RenderDesignFromSourceRecursive(treeView, xNode.childNodes[i], currentNode);
			}
		}
		else if (xNode.nodeName == "#cdata-section")
		{
			var newNode = new Telerik.Web.UI.RadTreeNode();
			newNode.set_text(xNode.nodeValue);
			newNode.set_value(xNode.nodeValue);
			newNode.get_attributes().setAttribute("____type", "d");

			if (currentNode == null)
				treeView.get_nodes().add(newNode);
			else
			{
				currentNode.get_nodes().add(newNode);
				currentNode.set_expanded(true);
			}

			newNode.get_textElement().style.color = "#CC9900";
			newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlCDataIcon.gif"));
		}
		else if (xNode.nodeName == "#comment")
		{
			var newNode = new Telerik.Web.UI.RadTreeNode();
			newNode.set_text(xNode.nodeValue);
			newNode.set_value(xNode.nodeValue);
			newNode.get_attributes().setAttribute("____type", "c");

			if (currentNode == null)
				treeView.get_nodes().add(newNode);
			else
			{
				currentNode.get_nodes().add(newNode);
				currentNode.set_expanded(true);
			}

			newNode.get_textElement().style.color = "#009900";
			newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlCommentIcon.gif"));
		}
		else if (xNode.nodeName == "#text")
		{
			var textValue = xNode.nodeValue.replace(/^\s*/, '').replace(/\s*$/, '');
			if (textValue != '')
			{
				var newNode = new Telerik.Web.UI.RadTreeNode();
				newNode.set_text(textValue);
				newNode.set_value(textValue);
				newNode.get_attributes().setAttribute("____type", "t");

				if (currentNode == null)
					treeView.get_nodes().add(newNode);
				else
				{
					// Make special storageFileName clickable to support DynamicFormResultEditor
					if (currentNode.get_value() == "storageFileName")
					{
						newNode.set_navigateUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/Portals/") + Revindex.Dnn.RevindexStorefront.BaseEditor.PortalID + "/PostedFiles/" + escape(newNode.get_value()));
						newNode.set_target("_blank");
					}

					currentNode.get_nodes().add(newNode);
					currentNode.set_expanded(true);
				}

				newNode.get_textElement().style.color = "#6699FF";

				if (newNode.get_value().indexOf("asp:") == 0)
					newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AspElementIcon.gif"));
				else
					newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlTextIcon.gif"));
			}
		}
		else
		{
			// Element

			// Ignore special element that wraps asp.net code for
			// namespace support.
			if (xNode.nodeName == "nswrapper")
			{
				for (var i = 0; i < xNode.childNodes.length; i++)
				{
					RenderDesignFromSourceRecursive(treeView, xNode.childNodes[i], currentNode);
				}
				return;
			}
			
			var newNode = new Telerik.Web.UI.RadTreeNode();
			newNode.set_text(xNode.nodeName);
			newNode.set_value(xNode.nodeName);
			newNode.get_attributes().setAttribute("____type", "e");

			// Save attribute information into nodes
			for (var i in xNode.attributes)
			{
				if (xNode.attributes[i].name != undefined && xNode.attributes[i].value != undefined)
				{
					newNode.set_text(newNode.get_text() + " " + xNode.attributes[i].name + "=\"" + xNode.attributes[i].value + "\"");
					newNode.get_attributes().setAttribute('___' + xNode.attributes[i].name, xNode.attributes[i].value);
				}
			}

			if (currentNode == null)
				treeView.get_nodes().add(newNode);
			else
			{
				currentNode.get_nodes().add(newNode);
				currentNode.set_expanded(true);
			}

			if (xNode.nodeName.indexOf("xsl:") == 0)
			{
				newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XslElementIcon.gif"));
			}
			else
			{
				newNode.get_textElement().style.color = "#6699FF";
				newNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlElementIcon.gif"));
			}

			currentNode = newNode;
			for (var i = 0; i < xNode.childNodes.length; i++)
			{
				RenderDesignFromSourceRecursive(treeView, xNode.childNodes[i], currentNode);
			}
		}
	}
}

function RenderSourceFromDesign(sourceTextBox, treeView)
{
	// Only render to source if tree is in valid state
	if (treeView.get_enabled())
	{
		if (treeView.get_nodes().length == 0)
			sourceTextBox.value = "";
		else
		{
			sourceTextBox.value = "";
			RenderSourceFromDesignRecursive(sourceTextBox, treeView.get_nodes().getNode(0));
		}
	}
}

function RenderSourceFromDesignRecursive(sourceTextBox, treeNode)
{
	if (treeNode != null)
	{
		if (treeNode.get_attributes().getAttribute("____type") == "e")
		{			
			sourceTextBox.value += new Array(treeNode.get_level() + 1).join('  ') + '<' + treeNode.get_value();
			for (var attrName in treeNode.get_attributes()._data)
			{
				if (attrName != '____type' && treeNode.get_attributes().getAttribute(attrName) != '___UNDEFINED___')
					sourceTextBox.value += ' ' + attrName.substring(3) + '="' + Revindex.Web.HtmlEncode(treeNode.get_attributes().getAttribute(attrName)) + '"';
			}

			if (treeNode.get_nodes().get_count() == 0)
				sourceTextBox.value += "/>\r\n";
			else if (treeNode.get_nodes().get_count() == 1 && treeNode.get_nodes().getNode(0).get_attributes().getAttribute("____type") == "t")
			{
				sourceTextBox.value += ">";
				RenderSourceFromDesignRecursive(sourceTextBox, treeNode.get_nodes().getNode(0));
				sourceTextBox.value += '</' + treeNode.get_value() + ">\r\n";
			}
			else
			{
				sourceTextBox.value += ">\r\n";
				for (var i = 0; i < treeNode.get_nodes().get_count(); i++)
				{
					// Process each child element
					RenderSourceFromDesignRecursive(sourceTextBox, treeNode.get_nodes().getNode(i));
				}

				sourceTextBox.value += new Array(treeNode.get_level() + 1).join('  ') + '</' + treeNode.get_value() + ">\r\n";
			}
		}
		else if (treeNode.get_attributes().getAttribute("____type") == "t")
		{
			// If parent element is javascript node, do not escape the text.
			if (treeNode.get_parent().get_value() == "script")
				sourceTextBox.value += treeNode.get_value();
			else
				sourceTextBox.value += Revindex.Web.HtmlEncode(treeNode.get_value());
		}
		else if (treeNode.get_attributes().getAttribute("____type") == "c")
		{
			sourceTextBox.value += new Array(treeNode.get_level() + 1).join('  ') + '<!-- ' + Revindex.Web.HtmlEncode(treeNode.get_text()) + " -->\r\n";
		}
		else if (treeNode.get_attributes().getAttribute("____type") == "d")
		{
			sourceTextBox.value += new Array(treeNode.get_level() + 1).join('  ') + '<![CDATA[ ' + treeNode.get_text() + " ]]>\r\n";
		}
	}
}

function TreeViewDroppingHandler(sender, eventArgs)
{
	var destinationNode = eventArgs.get_destNode();
	var sourceNode = eventArgs.get_sourceNodes()[0];

	// Make sure drag and drop is from the same TreeView only
	if (destinationNode == null || sourceNode.get_treeView() != destinationNode.get_treeView())
		return;

	var treeView = destinationNode.get_treeView();
    if (eventArgs.get_dropPosition() == "above")
	{
		// Disallow dropping above root
		if (destinationNode.get_level() == 0)
			return;

		sourceNode.get_parent().get_nodes().remove(sourceNode);
		var destinationParent = destinationNode.get_parent();
        var index = destinationParent.get_nodes().indexOf(destinationNode);
        destinationParent.get_nodes().insert(index, sourceNode);
		destinationParent.set_expanded(true);
	}
	else if (eventArgs.get_dropPosition() == "over") 
	{
		// Disallow dropping onto non-element types
		if (destinationNode.get_attributes().getAttribute("____type").match(/[e]/i) == null)
			return;

		sourceNode.get_parent().get_nodes().remove(sourceNode);
		destinationNode.get_nodes().add(sourceNode);
		destinationNode.set_expanded(true);
	}
    else if (eventArgs.get_dropPosition() == "below")
	{
		sourceNode.get_parent().get_nodes().remove(sourceNode);
		var destinationParent = destinationNode.get_parent();
        var index = destinationParent.get_nodes().indexOf(destinationNode);
        destinationParent.get_nodes().insert(index + 1, sourceNode);
		destinationParent.set_expanded(true);
	}

	// Color is lost after dragging. Need to reset color.
	// Set color only after node is created because get_textElement returns the span object.
	SetTreeNodeColor(sourceNode);
	RenderSourceFromDesign(treeView._sourceTextBox, treeView);
} 

function XslAttributeDnnTreeView_ClientNodeClicked(sender, eventArgs)
{
	// Only show description for leafs that are actual commands
	if (eventArgs.get_node().get_nodes().get_count() == 0)
		jQuery("#" + Revindex.Dnn.RevindexStorefront.BaseEditor.FunctionDescriptionXslAttributeLabelID).html(xPathFunctions[eventArgs.get_node().get_text()].Description);
	else
		jQuery("#" + Revindex.Dnn.RevindexStorefront.BaseEditor.FunctionDescriptionXslAttributeLabelID).html('');
}

function XslAttributeDnnTreeView_ClientNodeDropping(sender, eventArgs) 
{
	var target = eventArgs.get_htmlElement();
	if (target.tagName == 'TEXTAREA')
	{
		// Insert at caret position
		if (document.selection) 
		{ 
			target.focus(); 
			var sel = document.selection.createRange(); 
			sel.text = eventArgs.get_sourceNode().get_value(); 
			target.focus(); 
		} 
		else if (target.selectionStart || target.selectionStart == '0') 
		{ 
			var startPos = target.selectionStart; 
			var endPos = target.selectionEnd; 
			var scrollTop = target.scrollTop; 
			target.value = target.value.substring(0, startPos) + eventArgs.get_sourceNode().get_value() + target.value.substring(endPos, target.value.length); 
			target.focus(); 
			target.selectionStart = startPos + eventArgs.get_sourceNode().get_value().length; 
			target.selectionEnd = startPos + eventArgs.get_sourceNode().get_value().length; 
			target.scrollTop = scrollTop; 
		} 
		else 
		{ 
			target.value += eventArgs.get_sourceNode().get_value(); 
			target.focus(); 
		}
	}
}

function GetTreeValuePathFromTreeNode(treeNode)
{
	var path = '';
	var parentTreeNode = treeNode;

	while (parentTreeNode != null)
	{
		path = '/' + parentTreeNode.get_value() + path;

		if (parentTreeNode.get_level() > 0)
			parentTreeNode = parentTreeNode.get_parent();
		else
			break;
	}
	
	return path;
}

function SetTreeNodeColor(treeNode)
{
	if (treeNode != null)
	{
		if (treeNode.get_attributes().getAttribute("____type") == "c")
			treeNode.get_textElement().style.color = "#009900";
		else if (treeNode.get_attributes().getAttribute("____type") == "e" && treeNode.get_value().indexOf("xsl:") < 0 && treeNode.get_value().indexOf("asp:") < 0)
			treeNode.get_textElement().style.color = "#6699FF";
		else if (treeNode.get_attributes().getAttribute("____type") == "t")
			treeNode.get_textElement().style.color = "#6699FF";
		else if (treeNode.get_attributes().getAttribute("____type") == "d")
			treeNode.get_textElement().style.color = "#CC9900";

		// Recursively call for children nodes
		for (var i = 0; i < treeNode.get_nodes().get_count(); i++)
		{
			SetTreeNodeColor(treeNode.get_nodes().getNode(i));
		}
	}
}

function HaveActiveChildMenuItems(menuItem)
{
	for (var i = 0; i < menuItem.get_items().get_count(); i++)
	{
		if (menuItem.get_items().getItem(i).get_visible())
			return true;
	}

	return false;
}

function ShowEditTextWindow(wnd, treeView, treeNode, nodeType, readOnly)
{
	// Enable any previous treeView that was disabled in case window got swaped.
	if (wnd._treeView != null)
		wnd._treeView.set_enabled(true);

	treeView.set_enabled(false);

	// Initialize controls
	jQuery("textarea[id$='TextEditTextTextBox']").val('');

	jQuery("textarea[id$='TextEditTextTextBox']").attr('readonly', readOnly);
	jQuery("input[id$='SaveEditTextButton']").attr('disabled', readOnly);

	if (treeNode != null)
		jQuery("textarea[id$='TextEditTextTextBox']").val(treeNode.get_value());

	wnd.show();

	// Hook up the window to reference the calling treeView
	wnd._treeView = treeView;
	wnd.argument = treeNode;
	wnd._nodeType = nodeType;
}

function ShowEditNameWindow(wnd, treeView, treeNode, readOnly)
{
	// Enable any previous treeView that was disabled in case window got swaped.
	if (wnd._treeView != null)
		wnd._treeView.set_enabled(true);

	treeView.set_enabled(false);

	// Initialize controls
	jQuery("input[id$='NameEditNameTextBox']").val('');

	jQuery("input[id$='NameEditNameTextBox']").attr('readonly', readOnly);
	jQuery("input[id$='SaveEditNameButton']").attr('disabled', readOnly);

	if (treeNode != null)
		jQuery("input[id$='NameEditNameTextBox']").val(treeNode.get_value());
	
	wnd.show();

	// Hook up the window to reference the calling treeView
	wnd._treeView = treeView;
	wnd.argument = treeNode;
}

function ShowEditXmlAttributeWindow(wnd, treeView, attrName, readOnly)
{
	// Enable any previous treeView that was disabled in case window got swaped.
	if (wnd._treeView != null)
		wnd._treeView.set_enabled(true);

	treeView.set_enabled(false);

	// Initialize controls
	jQuery("input[id$='NameEditXmlAttributeTextBox']").val('');
	jQuery("input[id$='ValueEditXmlAttributeTextBox']").val('');

	jQuery("input[id$='NameEditXmlAttributeTextBox']").attr('readonly', readOnly);
	jQuery("input[id$='SaveEditXmlAttributeButton']").attr('disabled', readOnly);

	if (attrName != '')
	{
		jQuery("input[id$='NameEditXmlAttributeTextBox']").val(attrName.substring(3));

		if (treeView.get_selectedNode().get_attributes().getAttribute(attrName) != '___UNDEFINED___')
			jQuery("input[id$='ValueEditXmlAttributeTextBox']").val(treeView.get_selectedNode().get_attributes().getAttribute(attrName));
	}
	wnd.show();

	// Hook up the window to reference the calling treeView
	wnd._treeView = treeView;
	wnd.argument = attrName;
}

function ShowEditXslAttributeWindow(wnd, treeView, treeNode, attrName, readOnly)
{
	// Enable any previous treeView that was disabled in case window got swaped.
	if (wnd._treeView != null)
		wnd._treeView.set_enabled(true);

	treeView.set_enabled(false);

	// Initialize controls
	jQuery("textarea[id$='ValueEditXslAttributeTextBox']").val('');

	jQuery("textarea[id$='ValueEditXslAttributeTextBox']").attr('readonly', readOnly);
	jQuery("input[id$='SaveEditXslAttributeButton']").attr('disabled', readOnly);

	var xslElement = xslElements[treeNode.get_value()];
	if (xslElement == null || xslElement.Attributes[attrName.substring(3)] == null)
		jQuery("#" + Revindex.Dnn.RevindexStorefront.BaseEditor.AttributeDescriptionXslAttributeLabelID).html('');
	else
		jQuery("#" + Revindex.Dnn.RevindexStorefront.BaseEditor.AttributeDescriptionXslAttributeLabelID).html(xslElement.Attributes[attrName.substring(3)].Description);

	// Init XPath functions
	var xPathTreeView = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.XslAttributeDnnTreeViewID);
	if (xPathTreeView.get_nodes().get_count() == 0)
	{
		for (var i in xPathFunctions)
		{
			// Create category if not already exist
			var categoryTreeNode = xPathTreeView.findNodeByText(xPathFunctions[i].Category);
			if (categoryTreeNode == null)
			{
				var categoryTreeNode = new Telerik.Web.UI.RadTreeNode();
				categoryTreeNode.set_text(xPathFunctions[i].Category);
				categoryTreeNode.set_value('');
				categoryTreeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/FolderIcon.gif"));
				xPathTreeView.get_nodes().add(categoryTreeNode);
			}

			// Create node under category
			var treeNode = new Telerik.Web.UI.RadTreeNode();
			treeNode.set_text(xPathFunctions[i].Name);
			treeNode.set_value(xPathFunctions[i].Value);
			categoryTreeNode.get_nodes().add(treeNode);
		}
	}

	if (attrName != '' && treeView.get_selectedNode().get_attributes().getAttribute(attrName) != '___UNDEFINED___')
	    jQuery("textarea[id$='ValueEditXslAttributeTextBox']").val(treeView.get_selectedNode().get_attributes().getAttribute(attrName));

	wnd.show();

	// Hook up the window to reference the calling treeView
	wnd._treeView = treeView;
	wnd.argument = attrName;
}

function SaveEditTextDnnWindow()
{
	var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
	var treeNode = wnd.argument;
	var nodeType = wnd._nodeType;
	var value = jQuery("textarea[id$='TextEditTextTextBox']").val();

	if (treeNode == null)
	{
		var treeNode = new Telerik.Web.UI.RadTreeNode();
		treeNode.set_text(value);
		treeNode.set_value(value);
		treeNode.get_attributes().setAttribute("____type", nodeType);

		if (nodeType == "t")		
			treeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlTextIcon.gif"));
		else if (nodeType == "c")
			treeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlCommentIcon.gif"));
		else if (nodeType == "d")
			treeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlCDataIcon.gif"));

		wnd._treeView.get_selectedNode().get_nodes().add(treeNode);
		wnd._treeView.get_selectedNode().set_expanded(true);

		wnd._treeView.unselectAllNodes();
		treeNode.set_selected(true);
	}
	else
	{
		treeNode.set_value(value);
		treeNode.set_text(value);
	}

	// Set color only after node is created because get_textElement returns the span object.
	SetTreeNodeColor(treeNode);

	wnd._treeView.set_enabled(true);
	wnd.hide();

	RenderSourceFromDesign(wnd._treeView._sourceTextBox, wnd._treeView);
}

function SaveEditNameDnnWindow()
{
	var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditNameDnnWindowID);
	var treeNode = wnd.argument;
	var elementName = jQuery("input[id$='NameEditNameTextBox']").val();

	if (!ValidateXmlName(elementName))
	{
		alert("Name is invalid.");
		return;
	}

	if (treeNode == null)
	{
		// Insert new element
		var treeNode = new Telerik.Web.UI.RadTreeNode();
		treeNode.get_attributes().setAttribute("____type", "e");
		treeNode.set_text(elementName);
		treeNode.set_value(elementName);
		treeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlElementIcon.gif"));
		wnd._treeView.get_selectedNode().get_nodes().add(treeNode);
		wnd._treeView.get_selectedNode().set_expanded(true);
		wnd._treeView.unselectAllNodes();
		treeNode.set_selected(true);
	}
	else
	{
		// Update element name
		treeNode.set_value(elementName);
		treeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XmlElementIcon.gif"));
		treeNode.set_text(BuildElementDisplayNameFromTreeNode(treeNode));
	}

	// Set color only after node is created because get_textElement returns the span object.
	SetTreeNodeColor(treeNode);

	wnd._treeView.set_enabled(true);
	wnd.hide();

	RenderSourceFromDesign(wnd._treeView._sourceTextBox, wnd._treeView);
}

function SaveEditXmlAttributeDnnWindow()
{
	var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXmlAttributeDnnWindowID);
	var treeNode = wnd._treeView.get_selectedNode();
	var attrName = wnd.argument;

	var newAttrName = jQuery("input[id$='NameEditXmlAttributeTextBox']").val();
	var attrValue = jQuery("input[id$='ValueEditXmlAttributeTextBox']").val();

	if (!ValidateXmlName(newAttrName))
	{
		alert("Attribute name is invalid.");
		return;
	}

	if (attrName != '')
	{
		// Edit attribute
		treeNode.get_attributes().removeAttribute(attrName);
	}

	treeNode.get_attributes().setAttribute('___' + newAttrName, attrValue);
	treeNode.set_text(BuildElementDisplayNameFromTreeNode(treeNode));

	// Set color only after node is created because get_textElement returns the span object.
	SetTreeNodeColor(treeNode);

	wnd._treeView.set_enabled(true);
	wnd.hide();

	RenderSourceFromDesign(wnd._treeView._sourceTextBox, wnd._treeView);
}

function SaveEditXslAttributeDnnWindow()
{
	var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXslAttributeDnnWindowID);
	var treeNode = wnd._treeView.get_selectedNode();
	var attrName = wnd.argument;
	var attrValue = jQuery("textarea[id$='ValueEditXslAttributeTextBox']").val();

	treeNode.get_attributes().setAttribute(attrName, attrValue);
	treeNode.set_text(BuildElementDisplayNameFromTreeNode(treeNode));

	// Set color only after node is created because get_textElement returns the span object.
	SetTreeNodeColor(treeNode);
	
	wnd._treeView.set_enabled(true);
	wnd.hide();

	RenderSourceFromDesign(wnd._treeView._sourceTextBox, wnd._treeView);
}

function DnnWindowOnClientShowHandler(sender, eventArgs)
{
	sender.center();
}

function DnnWindowOnClientCloseHandler(sender, eventArgs)
{
	sender._treeView.set_enabled(true);
}

function DnnTreeViewClientContextMenuClickedHandler(sender, eventArgs)
{
	var treeNode = eventArgs.get_node();
	var menuItem = eventArgs.get_menuItem();
	var treeView = treeNode.get_treeView();

	if (menuItem.get_value().indexOf("addattribute|") >= 0)
	{
		var attrName = '';
		if (menuItem.get_value().length > 13)
			attrName = menuItem.get_value().substring(13);	

		if (treeNode.get_value().indexOf("xsl:") == 0 && attrName != '')
		{
			var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXslAttributeDnnWindowID);
			ShowEditXslAttributeWindow(wnd, sender, treeNode, attrName, false);
		}
		else
		{
			var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXmlAttributeDnnWindowID);
			ShowEditXmlAttributeWindow(wnd, sender, attrName, false);
		}
	}
	else if (menuItem.get_value().indexOf("addcontrol|") == 0)
	{
		// Get instruction name
		var control = menuItem.get_value().substring(11);

		if (aspElements[control] != null)
		{
			var newTreeNode = new Telerik.Web.UI.RadTreeNode();
			newTreeNode.get_attributes().setAttribute("____type", "e");
			newTreeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/AspElementIcon.gif"));
			newTreeNode.set_text(control);
			newTreeNode.set_value(control);
			
			// Add required attributes
			for (var j in aspElements[control].Attributes)
			{
				if (aspElements[control].Attributes[j].IsRequired)
				{
					newTreeNode.set_text(newTreeNode.get_text() + " " + aspElements[control].Attributes[j].Name + "=\"" + aspElements[control].Attributes[j].Value + "\"");
					newTreeNode.get_attributes().setAttribute('___' + aspElements[control].Attributes[j].Name, aspElements[control].Attributes[j].Value);
				}
			}

			treeNode.get_nodes().add(newTreeNode);
			treeNode.set_expanded(true);

			// Set color only after node is created because get_textElement returns the span object.
			SetTreeNodeColor(newTreeNode);	

			sender.unselectAllNodes();
			newTreeNode.set_selected(true);
			RenderSourceFromDesign(treeView._sourceTextBox, treeView);
		}
	}
	else if (menuItem.get_value().indexOf("addelement|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditNameDnnWindowID);
		ShowEditNameWindow(wnd, sender, null, false);
	}
	else if (menuItem.get_value().indexOf("addinstruction|") == 0)
	{
		// Get instruction name
		var instruction = menuItem.get_value().substring(15);

		if (xslElements[instruction] != null)
		{
			var newTreeNode = new Telerik.Web.UI.RadTreeNode();
			newTreeNode.get_attributes().setAttribute("____type", "e");
			newTreeNode.set_imageUrl(Revindex.Web.ResolveUrl("~/DesktopModules/Revindex.Dnn.RevindexStorefront/WebUserControls/Media/XslElementIcon.gif"));
			newTreeNode.set_text(instruction);
			newTreeNode.set_value(instruction);
			
			// Add required attributes
			for (var j in xslElements[instruction].Attributes)
			{
				if (xslElements[instruction].Attributes[j].IsRequired)
				{
					newTreeNode.set_text(newTreeNode.get_text() + " " + xslElements[instruction].Attributes[j].Name + "=\"" + xslElements[instruction].Attributes[j].Value + "\"");
					newTreeNode.get_attributes().setAttribute('___' + xslElements[instruction].Attributes[j].Name, xslElements[instruction].Attributes[j].Value);
				}
			}

			treeNode.get_nodes().add(newTreeNode);
			treeNode.set_expanded(true);

			// Set color only after node is created because get_textElement returns the span object.
			SetTreeNodeColor(newTreeNode);	

			sender.unselectAllNodes();
			newTreeNode.set_selected(true);
			RenderSourceFromDesign(treeView._sourceTextBox, treeView);
		}
	}
	else if (menuItem.get_value().indexOf("addtext|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, null, "t", false);
	}
	else if (menuItem.get_value().indexOf("addcomment|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, null, "c", false);
	}
	else if (menuItem.get_value().indexOf("collapseall|") >= 0)
	{
	    var nodes = treeNode.get_allNodes();
	    for (var i = 0; i < nodes.length; i++) {
	        if (nodes[i].get_nodes() != null) {
	            nodes[i].collapse();
	        }
	    }
	    treeNode.collapse();
	}
	else if (menuItem.get_value().indexOf("editattribute|") >= 0)
	{
		var attrName = menuItem.get_value().substring(14);

		if (treeNode.get_value().indexOf("xsl:") == 0)
		{
			var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXslAttributeDnnWindowID);
			ShowEditXslAttributeWindow(wnd, sender, treeNode, attrName, false)
		}
		else
		{
			var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditXmlAttributeDnnWindowID);
			ShowEditXmlAttributeWindow(wnd, sender, attrName, false)
		}
	}
	else if (menuItem.get_value().indexOf("editcdata|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, treeNode, "d", false);
	}
	else if (menuItem.get_value().indexOf("editcomment|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, treeNode, "c", false);
	}
	else if (menuItem.get_value().indexOf("editname|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditNameDnnWindowID);
		ShowEditNameWindow(wnd, sender, treeNode, false);
	}
	else if (menuItem.get_value().indexOf("edittext|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, treeNode, "t", false);
	}
	else if (menuItem.get_value().indexOf("expandall|") >= 0)
	{
	    var nodes = treeNode.get_allNodes();
	    for (var i = 0; i < nodes.length; i++) {
	        if (nodes[i].get_nodes() != null) {
	            nodes[i].expand();
	        }
	    }
	    treeNode.expand();
	}
	else if (menuItem.get_value().indexOf("removeattribute|") == 0)
	{
		var attributeName = menuItem.get_value().substring(16);

		// Hack: Telerik bug doesn't track changes for removed attribute. 
		// Cannot use removeAttribute(name) function because it doesn't serialize the change
		// back to the server. Instead, we set a special ___UNDEFINED___ text and check for it
		// in the code where ever it is being used.
		treeNode.get_attributes().setAttribute(attributeName, '___UNDEFINED___');
		treeNode.set_text(BuildElementDisplayNameFromTreeNode(treeNode));
		RenderSourceFromDesign(treeView._sourceTextBox, treeView);
	}
	else if (menuItem.get_value().indexOf("removenode|") >= 0)
	{
		var parent = treeNode.get_parent();
        parent.get_nodes().remove(treeNode);
        RenderSourceFromDesign(treeView._sourceTextBox, treeView);
	}
	else if (menuItem.get_value().indexOf("viewtext|") >= 0)
	{
		var wnd = $find(Revindex.Dnn.RevindexStorefront.BaseEditor.EditTextDnnWindowID);
		ShowEditTextWindow(wnd, sender, treeNode, "t", true);
	}
}

// BUG: Adjust RadSplitter width when the object is originally hidden
// under a tab or accordion by periodically detecting when the object becomes visible
// and forcing it to resize. The RadSplitter doesn't size correctly when it's initially hidden from
// view. We need to use a timer to watch for the object when it turns visible
// and call it to resize.
Revindex.Dnn.RevindexStorefront.AutoResizeEditorPane = function ($obj)
{
    if ($obj.length > 0)
    {
        $obj.timer = setInterval(function ()
        {
            if ($obj.is(':visible'))
            {
                $find($obj.attr('id')).resize();
                $obj.find('div.rspPaneTabContainer').css('height', '80px');
                clearInterval($obj.timer);
            }
        }, 2000);
    }
}