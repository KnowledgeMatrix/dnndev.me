<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Specify the discount amount to apply to the sales order detail item. This amount should be a negative value -->
      <!-- The system will apply this rule for each sales order detail item in the cart. You can use conditional instructions to decide if the current sales order detail item should receive the discount amount -->
      <discountAmount>-1.00</discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
