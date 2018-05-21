<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <price>
        <!-- Suppose we have a Dynamic form dropdown list with ID of 'CustomSize'. We can test if customer selected the XL size. -->
        <xsl:if test="in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomSize']/selected = 'XL'" >
          <xsl:value-of select="2 + in/product/productVariant/basePrice" />
        </xsl:if>
      </price>
    </out>
  </xsl:template>
</xsl:transform>
