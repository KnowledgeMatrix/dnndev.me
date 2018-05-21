<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- 10% discount if product belongs in category -->
      <promotionPrice>
        <xsl:if test="in/product/categories[categoryID = 2]">
          <xsl:value-of select="0.90 * in/product/productVariant/price" />
        </xsl:if>
      </promotionPrice>
    </out>
  </xsl:template>
</xsl:transform>