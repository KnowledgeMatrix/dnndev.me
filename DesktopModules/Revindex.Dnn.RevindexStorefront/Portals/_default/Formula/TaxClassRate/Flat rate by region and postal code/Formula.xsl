<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- 5% for U.S, 6% for New York and 8% for Manhattan postal code. Use separate taxAmount nodes to store the federal, state tax, etc. This separation allows us to report accurate tax collected to the appropriate government level. The final tax to be paid by the customer is the sum of all the taxes. -->
      <taxAmount1>
        <xsl:if test="in/salesOrder/billingCountryCode = 'US'">
          <xsl:value-of select="0.05 * in/this/salesOrderDetail/totalAmount" />
        </xsl:if>
      </taxAmount1>
      <taxAmount2>
        <xsl:if test="in/salesOrder/billingSubdivisionCode = 'US-NY'">
          <xsl:value-of select="0.06 * in/this/salesOrderDetail/totalAmount" />
        </xsl:if>
      </taxAmount2>
      <taxAmount3>
        <xsl:if test="in/salesOrder/billingCountryCode = 'US'">
          <xsl:variable name="postalCode" select="number(substring(in/salesOrder/billingPostalCode, 1, 5))" />
          <xsl:if test="$postalCode &gt;= 10001 and $postalCode &lt;= 10286">
            <xsl:value-of select="0.08 * in/this/salesOrderDetail/totalAmount" />
          </xsl:if>
        </xsl:if>
      </taxAmount3>
      <taxAmount4></taxAmount4>
      <taxAmount5></taxAmount5>
    </out>
  </xsl:template>
</xsl:transform>
