<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give 50% increase on the current voucher amount -->
      <promotionAmount>
        <xsl:value-of select="1.50 * in/voucherDefinition/voucher/amount" />
      </promotionAmount>
      <maxRedemption></maxRedemption>
    </out>
  </xsl:template>
</xsl:transform>