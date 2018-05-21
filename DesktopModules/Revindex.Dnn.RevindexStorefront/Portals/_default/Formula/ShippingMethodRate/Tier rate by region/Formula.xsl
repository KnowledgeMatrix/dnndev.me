<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- $1.00 flat rate in U.S, $2.00 Canada and $5.00 elsewhere -->
      <shippingAmount>
        <xsl:choose>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">1.00</xsl:when>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">2.00</xsl:when>
          <xsl:otherwise>5.00</xsl:otherwise>
        </xsl:choose>
      </shippingAmount>
    </out>
  </xsl:template>
</xsl:transform>
