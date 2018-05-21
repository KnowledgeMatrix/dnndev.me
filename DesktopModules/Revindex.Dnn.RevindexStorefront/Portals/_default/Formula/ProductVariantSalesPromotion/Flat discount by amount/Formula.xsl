<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give fixed $1.50 discount on the regular price -->
      <promotionPrice>
        <xsl:value-of select="in/product/productVariant/price - 1.50" />
      </promotionPrice>
    </out>
  </xsl:template>
</xsl:transform>