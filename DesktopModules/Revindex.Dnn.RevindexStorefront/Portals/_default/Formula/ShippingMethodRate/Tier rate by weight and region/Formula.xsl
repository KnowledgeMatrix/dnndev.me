<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- $0.10/g of weight in U.S, $0.20/g Canada and $0.30/g elsewhere -->
      <shippingAmount>
        <!-- Use a variable to hold the calculated shipping amount that takes the sum of the shipping weight multiplied by the regional rate. -->
        <xsl:variable name="shippingAmount">
          <xsl:choose>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">
              <xsl:sequence select="0.10 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:when>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">
              <xsl:sequence select="0.20 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="0.30 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Print the value from the variable -->
        <xsl:value-of select="$shippingAmount" />
      </shippingAmount>
    </out>
  </xsl:template>
</xsl:transform>
