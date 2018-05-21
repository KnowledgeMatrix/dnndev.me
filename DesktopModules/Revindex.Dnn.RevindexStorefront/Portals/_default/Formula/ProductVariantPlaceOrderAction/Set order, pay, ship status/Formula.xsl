<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <!-- Set order status completed, payment status paid, shipping status shipped -->
    <out>
      <setData>
        <salesOrder>
          <status>4</status>
          <salesPaymentStatus>2</salesPaymentStatus>
          <shippingStatus>3</shippingStatus>
        </salesOrder>
      </setData>
    </out>
  </xsl:template>
</xsl:transform>