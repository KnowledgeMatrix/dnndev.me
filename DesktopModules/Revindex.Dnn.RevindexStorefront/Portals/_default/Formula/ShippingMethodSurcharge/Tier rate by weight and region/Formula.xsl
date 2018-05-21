<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- $0.01/g of weight in U.S, $0.02/g Canada and $0.03/g elsewhere -->
      <shippingSurchargeAmount>
        <!-- Use a variable to hold the calculated shipping surcharge amount that takes the sum of the shipping weight multiplied by the regional rate. -->
        <xsl:variable name="shippingSurchargeAmount">
          <xsl:choose>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'US'">
              <xsl:sequence select="0.01 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:when>
            <xsl:when test="in/salesOrder/shippingCountryCode = 'CA'">
              <xsl:sequence select="0.02 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:sequence select="0.03 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <!-- Print the value from the variable -->
        <xsl:value-of select="$shippingSurchargeAmount" />
      </shippingSurchargeAmount>
    </out>
  </xsl:template>
</xsl:transform>
