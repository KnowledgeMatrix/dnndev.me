<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <webRequest>
        <url>http://domain.com/trigger?name=value</url>
        <method>POST</method>
        <postString>name1=value1&amp;name2=value2</postString>
        <timeout>30000</timeout>
      </webRequest>
    </out>
  </xsl:template>
</xsl:transform>
