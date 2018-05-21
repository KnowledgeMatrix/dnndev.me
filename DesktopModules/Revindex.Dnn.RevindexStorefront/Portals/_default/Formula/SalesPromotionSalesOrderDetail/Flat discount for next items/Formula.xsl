<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <discountAmount>
        <!-- Apply discount if customer purchases more than 1. -->
        <xsl:if test="/in/this/salesOrderDetail/quantity &gt;= 2" >
          <!-- Give $50 discount on each subsequent item purchased except the first one so we need subtract 1 from the total quantity -->
          <xsl:value-of select="-50.00 * (/in/this/salesOrderDetail/quantity - 1)" />
        </xsl:if>
      </discountAmount>
    </out>
  </xsl:template>
</xsl:transform>
