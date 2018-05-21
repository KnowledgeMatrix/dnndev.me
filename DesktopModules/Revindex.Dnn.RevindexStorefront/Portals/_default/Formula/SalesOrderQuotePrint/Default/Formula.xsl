<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format decimal-separator="." grouping-separator="," />
  <xsl:template match="/">
    <out>
      <title>
        <xsl:value-of select="in/configuration/generalStoreName" /> Quote [<xsl:value-of select="in/user/username" /> - Order #<xsl:value-of select="in/salesOrder/salesOrderNumber" />]
      </title>
      <htmlBody xml:space="preserve">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" style="background-color:#EEEEEE">
			<tr>
				<td style="font-size:large"><xsl:value-of select="in/configuration/generalStoreName" /> Quote</td>
			</tr>
		</table>
		<br /><br />
		<table border="0" cellpadding="0" cellspacing="3">
			<tr>
				<td><b>Quote Number:</b></td><td><xsl:value-of select="in/salesOrder/salesOrderNumber" /></td>
			</tr>
			<tr>
				<td><b>Order Date:</b><br /><br /></td><td><xsl:value-of select="format-dateTime(in/salesOrder/orderDate, '[Y]-[M01]-[D01] [H01]:[m01]')" /><br /><br /></td>
			</tr>
			<tr>
				<td style="vertical-align:top"><b>Bill To:</b></td>
				<td>
					<xsl:value-of select="in/salesOrder/billingCompany" /><br />
					<xsl:value-of select="concat(in/salesOrder/billingFirstName, ' ', in/salesOrder/billingLastName)" /><br />
					<xsl:value-of select="in/salesOrder/billingStreet" />, <xsl:value-of select="in/salesOrder/billingCity" />, <xsl:value-of select="in/salesOrder/billingSubdivisionName" />, <xsl:value-of select="in/salesOrder/billingPostalCode" />, <xsl:value-of select="in/salesOrder/billingCountryName" />
				</td>
			</tr>
		</table>	
                <br /><br />
                <table border="1" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                    <td><b>SKU</b></td><td><b>Item</b></td><td><b>Quantity</b></td>
                </tr>
       <xsl:for-each select="in/salesOrder/salesOrderDetails/salesOrderDetail[parentSalesOrderDetailID='']">
					<tr>
            <td><xsl:value-of select="sku" /></td>
						<td>
                          <xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" /><br/>
                          <xsl:for-each select="salesOrderDetails/salesOrderDetail">&#160;&#160;&#160;&#160;<xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" />: <xsl:value-of select="quantity" /><br /></xsl:for-each>
                          <xsl:for-each select="dynamicFormResult/fields/field"><xsl:value-of select="replace(@id, '_', ' ')" />: <xsl:value-of select="." />, </xsl:for-each>
                        </td>
						<td><xsl:value-of select="quantity" /></td>
					</tr>
				</xsl:for-each>
                </table>
	</htmlBody>
    </out>
  </xsl:template>
</xsl:transform>