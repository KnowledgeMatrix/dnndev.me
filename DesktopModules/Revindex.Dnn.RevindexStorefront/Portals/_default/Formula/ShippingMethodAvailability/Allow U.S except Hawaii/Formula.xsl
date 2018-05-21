<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <allowed>
        <xsl:choose>
          <!-- Test if ship to United States but not to Hawaii -->
          <xsl:when test="in/salesOrder/shippingCountryCode = 'US' and in/salesOrder/shippingSubdivisionCode != 'US-HI'">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </allowed>
    </out>
  </xsl:template>
</xsl:transform>