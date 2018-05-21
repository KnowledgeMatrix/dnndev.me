<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <!-- Set order detail shipping status shipped -->
    <out>
      <setData>
        <salesOrderDetail>
          <salesOrderDetailID>1</salesOrderDetailID>
          <status>1</status>
          <shippingStatus>3</shippingStatus>
        </salesOrderDetail>
      </setData>
    </out>
  </xsl:template>
</xsl:transform>