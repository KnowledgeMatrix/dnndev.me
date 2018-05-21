<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Specify the promotional price to override the regular price -->
      <promotionPrice>0.00</promotionPrice>
    </out>
  </xsl:template>
</xsl:transform>