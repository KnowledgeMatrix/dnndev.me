<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <shippingAmount>
        <!-- Use a variable to hold the calculated shipping amount that takes the sum of the shipping weight multiplied by $0.10. -->
        <xsl:variable name="shippingAmount">
          <xsl:sequence select="0.10 * sum(in/salesOrder/shippingPackages/shippingPackage/weight)" />
        </xsl:variable>
        <!-- Print the value from the variable and add a base rate of $1.00 -->
        <xsl:value-of select="$shippingAmount + 1.00" />
      </shippingAmount>
    </out>
  </xsl:template>
</xsl:transform>
