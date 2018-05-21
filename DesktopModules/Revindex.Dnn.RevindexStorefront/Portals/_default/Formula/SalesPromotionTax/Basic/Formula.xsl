<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Specify the discount amount to apply to the tax amount. This amount should be a negative value -->
      <discountAmount>-1.00</discountAmount>
    </out>
  </xsl:template>
</xsl:transform>