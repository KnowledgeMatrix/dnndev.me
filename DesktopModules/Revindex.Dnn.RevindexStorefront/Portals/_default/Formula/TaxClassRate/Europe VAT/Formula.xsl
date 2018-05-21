<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <taxAmount1>
        <!-- Europe 20% France VAT tax. Charge 20% VAT tax for European countries except if the VAT number is provided. If the billing country is France, charge tax regardless of VAT number. -->
        <xsl:if test="in/salesOrder/billingCountryCode = 'AT' or&#xA;in/salesOrder/billingCountryCode = 'BE' or&#xA;in/salesOrder/billingCountryCode = 'BG' or&#xA;in/salesOrder/billingCountryCode = 'CY' or&#xA;in/salesOrder/billingCountryCode = 'CZ' or&#xA;in/salesOrder/billingCountryCode = 'DE' or&#xA;in/salesOrder/billingCountryCode = 'DK' or&#xA;in/salesOrder/billingCountryCode = 'EE' or&#xA;in/salesOrder/billingCountryCode = 'GR' or&#xA;in/salesOrder/billingCountryCode = 'ES' or&#xA;in/salesOrder/billingCountryCode = 'FI' or&#xA;in/salesOrder/billingCountryCode = 'FR' or&#xA;in/salesOrder/billingCountryCode = 'GB' or&#xA;in/salesOrder/billingCountryCode = 'HU' or&#xA;in/salesOrder/billingCountryCode = 'IE' or&#xA;in/salesOrder/billingCountryCode = 'IT' or&#xA;in/salesOrder/billingCountryCode = 'LT' or&#xA;in/salesOrder/billingCountryCode = 'LU' or&#xA;in/salesOrder/billingCountryCode = 'LV' or&#xA;in/salesOrder/billingCountryCode = 'MT' or&#xA;in/salesOrder/billingCountryCode = 'NL' or&#xA;in/salesOrder/billingCountryCode = 'PL' or&#xA;in/salesOrder/billingCountryCode = 'PT' or&#xA;in/salesOrder/billingCountryCode = 'RO' or&#xA;in/salesOrder/billingCountryCode = 'SE' or&#xA;in/salesOrder/billingCountryCode = 'SI' or&#xA;in/salesOrder/billingCountryCode = 'SK'">
          <xsl:if test="/in/salesOrder/billingCountryCode = 'FR' or /in/salesOrder/businessTaxNumber = ''">
            <xsl:value-of select="0.20 * in/this/salesOrderDetail/totalAmount" />
          </xsl:if>
        </xsl:if>
      </taxAmount1>
      <taxAmount2 />
      <taxAmount3 />
      <taxAmount4 />
      <taxAmount5 />
    </out>
  </xsl:template>
</xsl:transform>