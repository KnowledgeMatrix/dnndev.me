<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <grantSecurityRole>
        <roleName>Role 1</roleName>
      </grantSecurityRole>
      <grantSecurityRole>
        <roleName>Role 2</roleName>
      </grantSecurityRole>
    </out>
  </xsl:template>
</xsl:transform>
