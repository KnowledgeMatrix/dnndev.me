<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <handlingAmount>
        <xsl:choose>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">1.00</xsl:when>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">2.00</xsl:when>
          <xsl:otherwise>5.00</xsl:otherwise>
        </xsl:choose>
      </handlingAmount>
    </out>
  </xsl:template>
</xsl:transform>
