<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give $10 extra to the original voucher amount -->
      <promotionAmount>
        <xsl:value-of select="in/voucherDefinition/voucher/amount + 10" />
      </promotionAmount>
      <maxRedemption></maxRedemption>
    </out>
  </xsl:template>
</xsl:transform>