<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <xsl:if test="/this/salesOrderDetail/quantity = 5" >
        <grantSecurityRole>
          <roleName>Role 1</roleName>
        </grantSecurityRole>
      </xsl:if>
    </out>
  </xsl:template>
</xsl:transform>