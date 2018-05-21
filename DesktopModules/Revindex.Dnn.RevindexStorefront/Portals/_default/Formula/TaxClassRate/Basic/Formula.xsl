<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:template match="/">
    <out>
      <!-- Return the tax amount to charge -->
      <!-- Use separate taxAmount nodes to store the federal, state tax, etc. This separation allows us to report accurate tax collected to the appropriate government level. The final tax to be paid by the customer is the sum of all the taxes. -->
      <taxAmount1>0.00</taxAmount1>
      <taxAmount2>0.00</taxAmount2>
      <taxAmount3>0.00</taxAmount3>
      <taxAmount4>0.00</taxAmount4>
      <taxAmount5>0.00</taxAmount5>
    </out>
  </xsl:template>
</xsl:transform>
