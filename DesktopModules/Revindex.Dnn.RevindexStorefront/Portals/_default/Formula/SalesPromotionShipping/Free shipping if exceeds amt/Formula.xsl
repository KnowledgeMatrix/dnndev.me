<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <discountAmount>
        <xsl:if test="sum(in/salesOrder/salesOrderDetails/salesOrderDetail/amount) &gt; 100">
          <xsl:value-of select="-1 * in/salesOrder/shippingAmount" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>