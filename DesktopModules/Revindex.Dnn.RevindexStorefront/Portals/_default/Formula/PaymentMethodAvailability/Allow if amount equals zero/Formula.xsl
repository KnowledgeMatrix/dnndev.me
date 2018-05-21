<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <allowed>
        <xsl:choose>
          <!--Allow if subtotal equals to zero. This calculation excludes any shipping, handling or tax charges that could occur downstream-->
          <xsl:when test="/in/salesOrder/subTotalAmount = 0">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </allowed>
    </out>
  </xsl:template>
</xsl:transform>
