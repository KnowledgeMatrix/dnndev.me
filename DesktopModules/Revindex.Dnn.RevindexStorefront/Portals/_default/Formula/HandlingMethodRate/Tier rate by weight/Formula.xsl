<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <handlingAmount>
        <!-- Use a variable to hold the calculated handling amount that takes the sum of the weight multiplied by $0.10. -->
        <xsl:variable name="handlingAmount">
          <xsl:sequence select="0.10 * sum(in/salesOrder/salesOrderDetails/salesOrderDetail[requireHandling = 'true']/(quantity * weight))" />
        </xsl:variable>
        <!-- Print the value from the variable and add a base rate of $1.00 -->
        <xsl:value-of select="$handlingAmount + 1.00" />
      </handlingAmount>
    </out>
  </xsl:template>
</xsl:transform>
