<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Give 50% increase on the actual voucher amount if user has the "Role1" security role -->
      <promotionAmount>
        <xsl:choose>
          <xsl:when test="in/user/roles[role = 'Role1']">
            <xsl:value-of select="1.50 * in/voucherDefinition/voucher/amount" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="in/voucherDefinition/voucher/amount" />
          </xsl:otherwise>
        </xsl:choose>
      </promotionAmount>
      <maxRedemption></maxRedemption>
    </out>
  </xsl:template>
</xsl:transform>
