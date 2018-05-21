<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give 10% discount on regular price if user has the "Role1" security role -->
      <promotionPrice>
        <xsl:choose>
          <xsl:when test="in/user/roles[role = 'Role1']">
            <xsl:value-of select="0.90 * in/product/productVariant/price" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="in/product/productVariant/price" />
          </xsl:otherwise>
        </xsl:choose>
      </promotionPrice>
    </out>
  </xsl:template>
</xsl:transform>
