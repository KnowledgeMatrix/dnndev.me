<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format decimal-separator="." grouping-separator="," />
  <xsl:template match="/">
    <out>
      <title></title>
      <htmlBody xml:space="preserve">
		    <b>HTML version of the invoice</b>
	    </htmlBody>
    </out>
  </xsl:template>
</xsl:transform>