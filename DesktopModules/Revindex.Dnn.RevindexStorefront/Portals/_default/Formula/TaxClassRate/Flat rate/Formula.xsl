<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- 10% on sales order detail amount -->
      <taxAmount1>
        <xsl:value-of select="0.10 * in/this/salesOrderDetail/totalAmount" />
      </taxAmount1>
      <taxAmount2></taxAmount2>
      <taxAmount3></taxAmount3>
      <taxAmount4></taxAmount4>
      <taxAmount5></taxAmount5>
    </out>
  </xsl:template>
</xsl:transform>
