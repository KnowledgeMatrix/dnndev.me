<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <discountAmount>
        <!-- Coupon code is always tested in lowercase -->
        <xsl:if test="in/salesOrder/couponCodes[couponCode = 'free2']" >
          <xsl:value-of select="-0.10 * in/this/salesOrderDetail/amount" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
