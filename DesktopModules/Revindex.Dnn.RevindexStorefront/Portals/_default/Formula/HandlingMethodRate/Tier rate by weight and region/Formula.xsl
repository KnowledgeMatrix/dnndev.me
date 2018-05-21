<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <handlingAmount>
        <!-- Use a variable to hold the calculated handling amount that takes the sum of the weight multiplied by the regional rate. -->
        <xsl:variable name="handlingAmount">
          <xsl:choose>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">
              <xsl:sequence select="0.10 * sum(in/salesOrder/salesOrderDetails/salesOrderDetail[requireHandling = 'true']/(quantity * weight))" />
            </xsl:when>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">
              <xsl:sequence select="0.20 * sum(in/salesOrder/salesOrderDetails/salesOrderDetail[requireHandling = 'true']/(quantity * weight))" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="0.30 * sum(in/salesOrder/salesOrderDetails/salesOrderDetail[requireHandling = 'true']/(quantity * weight))" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Print the value from the variable -->
        <xsl:value-of select="$handlingAmount" />
      </handlingAmount>
    </out>
  </xsl:template>
</xsl:transform>