<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!--Free product with purchase of another product. The ProductVariant ID that must be purchased to qualify for giving away another product.-->
      <xsl:variable name="requiredProductVariantID" select="1" />
      <!--The ProductVariant ID to give away as free.-->
      <xsl:variable name="freeProductVariantID" select="2" />
      <discountAmount>
        <xsl:if test="/in/this/salesOrderDetail/productVariantID = $freeProductVariantID and /in/salesOrder/salesOrderDetails/salesOrderDetail[productVariantID = $requiredProductVariantID]">
          <xsl:value-of select="-1 * in/this/salesOrderDetail/amount" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
