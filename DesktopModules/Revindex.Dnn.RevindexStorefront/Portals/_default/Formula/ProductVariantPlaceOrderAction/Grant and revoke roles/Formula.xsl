<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <grantSecurityRole>
        <roleName>Role 1</roleName>
      </grantSecurityRole>
      <revokeSecurityRole>
        <roleName>Role 2</roleName>
      </revokeSecurityRole>
    </out>
  </xsl:template>
</xsl:transform>
