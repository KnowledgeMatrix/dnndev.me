<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <webRequest>
        <url>http://domain.com/trigger?name=value</url>
      </webRequest>
    </out>
  </xsl:template>
</xsl:transform>
