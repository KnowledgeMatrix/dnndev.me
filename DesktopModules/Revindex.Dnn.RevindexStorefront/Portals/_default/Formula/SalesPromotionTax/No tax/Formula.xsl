<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give a discount amount equivalent to the sum of all the taxes -->
      <discountAmount>
        <xsl:value-of select="-1 * (in/salesOrder/taxAmount1 + in/salesOrder/taxAmount2 + in/salesOrder/taxAmount3 + in/salesOrder/taxAmount4 + in/salesOrder/taxAmount5)" />
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>