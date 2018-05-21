<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">
  <xsl:template match="/">
    <!-- The following rule varies the price by the number of hours booked -->
    <out>
      <price>
        <xsl:value-of select="in/product/productVariant/basePrice * ((xs:dateTime(in/this/salesOrderDetail/bookingStopDate) - xs:dateTime(in/this/salesOrderDetail/bookingStartDate)) div xs:dayTimeDuration('PT1H'))" />
      </price>
    </out>
  </xsl:template>
</xsl:transform>
