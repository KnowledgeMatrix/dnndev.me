<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/">
    <out>
      <price>
        <!-- The following logic works in conjunction with a dynamic form code and expects the same input controls ID names -->
        <xsl:if test="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id='CustomPriceTextBox'] != ''">
          <xsl:value-of select="/in/this/salesOrderDetail/dynamicFormResult/fields/field[@id = 'CustomPriceTextBox']" />
        </xsl:if>
      </price>
    </out>
  </xsl:template>
</xsl:transform>