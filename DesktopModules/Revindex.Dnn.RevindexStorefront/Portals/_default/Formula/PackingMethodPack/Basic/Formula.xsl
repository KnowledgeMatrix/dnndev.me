<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Return the packages needed to fulfill shipping. -->
      <shippingPackages>
        <shippingPackage>
          <name>Regular box</name>
          <packageType>2000</packageType>
          <weight>500</weight>
          <width>20</width>
          <depth>20</depth>
          <height>20</height>
          <insurredAmount>10.00</insurredAmount>
          <shippingCode>50</shippingCode>
          <products>
            <product>
              <salesOrderDetailID>2</salesOrderDetailID>
              <quantity>1</quantity>
              <insurredAmount>10.00</insurredAmount>
            </product>
          </products>
        </shippingPackage>     
      </shippingPackages>
    </out>
  </xsl:template>
</xsl:transform>
