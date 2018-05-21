<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <allowed>
        <xsl:choose>
          <xsl:when test="count(in/history/couponCodes[couponCode = /in/this/coupon/code]) = 0">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </allowed>
    </out>
  </xsl:template>
</xsl:transform>