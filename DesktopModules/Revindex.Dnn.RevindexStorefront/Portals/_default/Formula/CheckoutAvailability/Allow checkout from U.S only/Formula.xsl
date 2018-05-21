<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <allowed>
        <xsl:choose>
          <xsl:when test="in/salesOrder/billingCountryCode = 'US'">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </allowed>
      <message>
        <locale en-US="Sorry, we currently fulfill for U.S addresses only." />
      </message>
    </out>
  </xsl:template>
</xsl:transform>
