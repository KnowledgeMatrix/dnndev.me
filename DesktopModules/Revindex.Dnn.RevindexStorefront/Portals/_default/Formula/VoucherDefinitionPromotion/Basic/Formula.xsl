<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Specify the promotion price to override the regular price -->
      <promotionAmount>0.00</promotionAmount>
      
      <!-- Specify the max number of times the voucher can be redeemed -->
      <maxRedemption>1</maxRedemption>
    </out>
  </xsl:template>
</xsl:transform>
