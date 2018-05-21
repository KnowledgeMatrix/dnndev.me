<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- This simple rule packs all the products into a single box and sums up the weight regardless of product dimensions and adds the weight of the box itself.  -->
      <shippingPackages>
        <shippingPackage>
          <name>Big box</name>
          <packageType>2000</packageType>
          <weight>
            <xsl:value-of select="sum(/in/salesOrder/salesOrderDetails/salesOrderDetail[requireShipping='true']/(weight * quantity)) + 50"/>
          </weight>
          <width>100</width>
          <depth>100</depth>
          <height>100</height>
          <insurredAmount>
            <xsl:value-of select="sum(/in/salesOrder/salesOrderDetails/salesOrderDetail[requireShipping='true']/totalAmount)"/>
          </insurredAmount>
          <shippingCode>50</shippingCode>
          <products>
            <xsl:for-each select="/in/salesOrder/salesOrderDetails/salesOrderDetail[requireShipping='true']">
              <product>
                <salesOrderDetailID>
                  <xsl:value-of select="salesOrderDetailID"/>
                </salesOrderDetailID>
                <quantity>
                  <xsl:value-of select="quantity"/>
                </quantity>
                <insurredAmount>
                  <xsl:value-of select="totalAmount div quantity" />
                </insurredAmount>
              </product>
            </xsl:for-each>
          </products>
        </shippingPackage>
      </shippingPackages>
    </out>
  </xsl:template>
</xsl:transform>

