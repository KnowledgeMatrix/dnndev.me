<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <allowed>
        <xsl:choose>
          <!-- Coupon code is always tested in lowercase -->
          <xsl:when test="count(in/salesOrder/couponCodes/couponCode[. != 'free1']) = 1">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </allowed>
    </out>
  </xsl:template>
</xsl:transform>