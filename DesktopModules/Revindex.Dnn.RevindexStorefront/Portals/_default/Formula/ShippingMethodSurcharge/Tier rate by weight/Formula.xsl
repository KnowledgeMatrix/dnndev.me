<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <shippingSurchargeAmount>
        <!-- Use a variable to hold the calculated shipping amount that takes the sum of the shipping weight multiplied by $0.01. -->
        <xsl:variable name="shippingSurchargeAmount">
          <xsl:sequence select="0.01 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
        </xsl:variable>
        <!-- Print the value from the variable and add a base surcharge rate of $0.50 -->
        <xsl:value-of select="$shippingSurchargeAmount + 0.50" />
      </shippingSurchargeAmount>
    </out>
  </xsl:template>
</xsl:transform>
