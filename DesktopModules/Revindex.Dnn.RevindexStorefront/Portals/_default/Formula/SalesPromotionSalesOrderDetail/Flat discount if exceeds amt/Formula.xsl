<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <discountAmount>
        <!-- Sum up all the sales order details amount and test if it exceeds $100 -->
        <xsl:if test="sum(in/salesOrder/salesOrderDetails/salesOrderDetail/amount) &gt; 100" >
          <xsl:value-of select="-0.10 * in/this/salesOrderDetail/amount" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
