<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <price>
        <xsl:choose>
          <xsl:when test="in/this/salesOrderDetail/quantity &gt;= 2 and in/this/salesOrderDetail/quantity &lt;= 5">
            <xsl:value-of select="0.90 * in/product/productVariant/basePrice" />
          </xsl:when>
          <xsl:when test="in/this/salesOrderDetail/quantity &gt; 5">
            <xsl:value-of select="0.80 * in/product/productVariant/basePrice" />
          </xsl:when>
        </xsl:choose>
      </price>
    </out>
  </xsl:template>
</xsl:transform>