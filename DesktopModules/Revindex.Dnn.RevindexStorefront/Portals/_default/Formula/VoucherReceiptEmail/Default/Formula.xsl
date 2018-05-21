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
        <xsl:value-of select="in/configuration/generalStoreName" /> Vouchers
      </subject>
      <textBody xml:space="preserve">
Hi <xsl:value-of select="concat(in/user/firstName, ' ', in/user/lastName)" />

Here are your vouchers issued to you with the following codes:

<xsl:for-each select="in/vouchers/voucher" >
<xsl:value-of select="code" /> - <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:choose><xsl:when test="promotionAmount/text()" ><xsl:value-of select="format-number(promotionAmount * in/salesOrder/exchangeRate, '#,##0.00')" /></xsl:when><xsl:otherwise><xsl:value-of select="format-number(amount * in/salesOrder/exchangeRate, '#,##0.00')" /></xsl:otherwise></xsl:choose>
</xsl:for-each>
        
<xsl:variable name="ManageVoucherUrl" select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/manageVoucherTabs/tab[1]/tabID)" />
Remember, vouchers are like cash so keep the codes in a safe place and delete this email after reading. You can visit your account page anytime to obtain more information about your vouchers.

<xsl:value-of select="$ManageVoucherUrl" />
        
If you have any questions, please do not hesitate to contact customer support.
	</textBody>
      <htmlBody xml:space="preserve">
<p>Hi <xsl:value-of select="in/user/firstName" /> <xsl:value-of select="in/user/lastName" />,</p>
<p>Here are your vouchers issued to you with the following codes:</p>
<p><xsl:for-each select="in/vouchers/voucher" >
<strong><xsl:value-of select="code" /></strong> - <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:choose><xsl:when test="promotionAmount/text()" ><xsl:value-of select="format-number(promotionAmount * in/salesOrder/exchangeRate, '#,##0.00')" /></xsl:when><xsl:otherwise><xsl:value-of select="format-number(amount * in/salesOrder/exchangeRate, '#,##0.00')" /></xsl:otherwise></xsl:choose><br />
</xsl:for-each></p>
<xsl:variable name="ManageVoucherUrl" select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/manageVoucherTabs/tab[1]/tabID)" />
<p>Remember, vouchers are like cash so keep the codes in a safe place and delete this email after reading. You can visit your account page anytime to obtain more information about your vouchers.</p>
<p><xsl:value-of select="$ManageVoucherUrl" /></p>        
<p>If you have any questions, please do not hesitate to contact customer support.</p>
	</htmlBody>
    </out>
  </xsl:template>
</xsl:transform>