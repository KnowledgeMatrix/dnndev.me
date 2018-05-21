<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <!-- Set order status completed -->
    <out>
      <setData>
        <salesOrder>
          <status>4</status>
        </salesOrder>
      </setData>
    </out>
  </xsl:template>
</xsl:transform>