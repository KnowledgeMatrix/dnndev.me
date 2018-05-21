<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- $0.10 flat surcharge rate in U.S, $0.20 Canada and $0.50 elsewhere -->
      <shippingSurchargeAmount>
        <xsl:choose>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">0.10</xsl:when>
          <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">0.20</xsl:when>
          <xsl:otherwise>0.50</xsl:otherwise>
        </xsl:choose>
      </shippingSurchargeAmount>
    </out>
  </xsl:template>
</xsl:transform>
