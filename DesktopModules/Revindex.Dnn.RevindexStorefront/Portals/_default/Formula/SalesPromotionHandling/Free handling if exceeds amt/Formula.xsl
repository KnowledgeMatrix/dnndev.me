<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!--  Give discount if order exceeds $100 -->
      <discountAmount>
        <xsl:if test="sum(in/salesOrder/salesOrderDetails/salesOrderDetail/amount) &gt; 100">
          <xsl:value-of select="-1 * in/salesOrder/handlingAmount" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
