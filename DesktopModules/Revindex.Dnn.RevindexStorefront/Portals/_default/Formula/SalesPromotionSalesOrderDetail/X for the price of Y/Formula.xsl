<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!--The quantity to qualify for promotion. E.g. If "2 for the price of 1", you will enter 2 here.-->
      <xsl:variable name="qualifyQty" select="2" />
      <!--The promotion quantity to charge. E.g. If "2 for the price of 1", you will enter 1 here.-->
      <xsl:variable name="promotionQty" select="1" />
        <discountAmount>
          <xsl:if test="in/this/salesOrderDetail/quantity &gt;= $qualifyQty">
            <!-- We're giving a discount amount equivalent to difference of the selling price between qualifyQty and promotionQty-->
            <xsl:value-of select="-1 * in/this/salesOrderDetail/price * floor(in/this/salesOrderDetail/quantity div $qualifyQty) * ($qualifyQty - $promotionQty)" />
          </xsl:if>
        </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
