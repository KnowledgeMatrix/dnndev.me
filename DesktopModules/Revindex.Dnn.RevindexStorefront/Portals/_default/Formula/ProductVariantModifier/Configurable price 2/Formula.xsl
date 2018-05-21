<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/">
    <out>
      <price>
        <!-- The following logic works in conjunction with a dynamic form code and expects the same input controls ID names -->
        <xsl:variable name="cpuPrice">
          <xsl:choose>
            <xsl:when test="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomCPUDropDownList']/selected != ''">
              <xsl:value-of select="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomCPUDropDownList']/selected" />
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="memoryPrice">
          <xsl:choose>
            <xsl:when test="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomMemoryDropDownList']/selected != ''">
              <xsl:value-of select="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomMemoryDropDownList']/selected" />
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="optionsPrice">
          <xsl:choose>
            <xsl:when test="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomOptionsCheckBoxList']">
              <xsl:value-of select="sum(/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomOptionsCheckBoxList']/selected)" />
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="/in/product/productVariant/basePrice + $cpuPrice + $memoryPrice + $optionsPrice" />
      </price>
    </out>
  </xsl:template>
</xsl:transform>
