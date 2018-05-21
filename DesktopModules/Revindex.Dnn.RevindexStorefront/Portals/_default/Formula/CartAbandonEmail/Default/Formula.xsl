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
        Thank you for visiting <xsl:value-of select="in/configuration/generalStoreName" /> [Order #<xsl:value-of select="in/salesOrder/salesOrderNumber" />]
      </subject>
      <textBody xml:space="preserve">
Hi <xsl:value-of select="concat(in/user/firstName, ' ', in/user/lastName)" />

We notice that you left something in your shopping cart. We hope you didn't experience any problems when trying to place an order with us. Just in case, we've kept your recent selections for a limited time so you don't have to start all over again. Simply click the link below to resume your shopping.
        
<xsl:value-of select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/cartTabs/tab[1]/tabID, '&amp;rvdsfsoguid=', in/salesOrder/salesOrderGUID)"/>

If you have any questions or need assistance, please do not hesitate to contact us.

	</textBody>
      <htmlBody xml:space="preserve">
Hi <xsl:value-of select="concat(in/user/firstName, ' ', in/user/lastName)" /><br />
<br />
We notice that you left something in your shopping cart. We hope you didn't experience any problems when trying to place an order with us. Just in case, we've kept your recent selections for a limited time so you don't have to start all over again. Simply click the link below to resume your shopping.<br />
<br />
<a><xsl:attribute name="href"><xsl:value-of select="concat('http://', in/portal/portalAliases/portalAlias[isPrimary='true'][1]/httpAlias, '?tabid=', in/portal/cartTabs/tab[1]/tabID, '&amp;rvdsfsoguid=', in/salesOrder/salesOrderGUID)"/></xsl:attribute>Click here to resume shopping</a><br />
<br />
If you have any questions or need assistance, please do not hesitate to contact us.<br />
	</htmlBody>
    </out>
  </xsl:template>
</xsl:transform>