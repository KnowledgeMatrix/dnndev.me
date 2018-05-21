<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format decimal-separator="." grouping-separator="," />
  <xsl:template match="/">
    <out>
      <mailFrom>
        <xsl:value-of select="in/configuration/generalEmailSender" />
      </mailFrom>
      <mailTo>
        <xsl:value-of select="in/user/email" />
      </mailTo>
      <subject>
        <xsl:value-of select="in/configuration/generalStoreName" /> Recurring Order Reminder
      </subject>
      <textBody xml:space="preserve">
Hi <xsl:value-of select="concat(in/user/firstName, ' ', in/user/lastName)" />

This is a friendly reminder that your recurring order will be processed on <xsl:value-of select="format-dateTime(in/recurringSalesOrders/recurringSalesOrder[1]/nextRecurringDate, '[FNn], [MNn] [D1o], [Y]')" />. Please ensure that your address and payment information on file are up-to-date to prevent any service interruption. We hope you continue enjoying our service. If you have any questions, please do not hesitate to contact us.
<xsl:variable name="ManageRecurringOrderUrl" select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/manageRecurringOrderTabs/tab[1]/tabID)" />
Visit link to manage your recurring orders:
<xsl:value-of select='$ManageRecurringOrderUrl' />

<xsl:for-each select="in/recurringSalesOrders/recurringSalesOrder">
Item    : <xsl:value-of select="productVariant/product/name" /> - <xsl:value-of select="productVariant/name" />
<xsl:for-each select="dynamicFormResult/fields/field"><xsl:value-of select="replace(@id, '_', ' ')" />: <xsl:value-of select="." />, </xsl:for-each>
Quantity:<xsl:value-of select="quantity" />

</xsl:for-each>
	    </textBody>
      <htmlBody xml:space="preserve">
<p>Hi <xsl:value-of select="concat(in/user/firstName, ' ', in/user/lastName)" /></p>
<p>
This is a friendly reminder that your recurring order will be processed on <xsl:value-of select="format-dateTime(in/recurringSalesOrders/recurringSalesOrder[1]/nextRecurringDate, '[FNn], [MNn] [D1o], [Y]')" />. Please ensure that your address and payment information on file are up-to-date to prevent any service interruption. We hope you continue enjoying our service. If you have any questions, please do not hesitate to contact us.</p>
<xsl:variable name="ManageRecurringOrderUrl" select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/manageRecurringOrderTabs/tab[1]/tabID)" />
<a><xsl:attribute name="href"><xsl:value-of select='$ManageRecurringOrderUrl' /></xsl:attribute>Click here to manage your recurring orders</a><br />
<br />
<table cellspacing="0" cellpadding="3" border="1" style="width: 100%;">
    <colgroup><col /><col /><col /></colgroup>
    <tbody>
        <tr>
            <td width="60%"><strong>Item</strong></td>
            <td width="15%"><strong>Quantity</strong></td>
        </tr>
    </tbody>
</table>
<xsl:for-each select="in/recurringSalesOrders/recurringSalesOrder">
<table cellspacing="0" cellpadding="3" border="1" style="width: 100%;">
    <colgroup><col /><col /><col /></colgroup>
    <tbody>
        <tr>
            <td width="60%">
            <span><xsl:value-of select="productVariant/product/name" /> - </span><xsl:value-of select="productVariant/name" /><br />
            <xsl:for-each select="dynamicFormResult/fields/field"><xsl:value-of select="replace(@id, '_', ' ')" />: <xsl:value-of select="." />, </xsl:for-each>
            </td>
            <td width="15%"><xsl:value-of select="quantity" /></td>
        </tr>
    </tbody>
</table>
</xsl:for-each>
	</htmlBody>
    </out>
  </xsl:template>
</xsl:transform>