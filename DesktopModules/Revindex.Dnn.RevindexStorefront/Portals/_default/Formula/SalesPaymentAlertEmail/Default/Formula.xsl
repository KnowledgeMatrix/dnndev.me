<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format decimal-separator="." grouping-separator="," />
  <xsl:template match="/">
    <out>
      <mailFrom>
        <xsl:value-of select="in/configuration/generalEmailSender" />
      </mailFrom>
      <mailTo>
        <xsl:value-of select="in/configuration/generalEmailRecipient" />
      </mailTo>
      <subject>
        <xsl:value-of select="in/configuration/generalStoreName" /> Payment Alert [<xsl:value-of select="in/user/username" /> - Order #<xsl:value-of select="in/salesOrder/salesOrderNumber" />]
      </subject>
      <textBody xml:space="preserve">
========================================================================
<xsl:value-of select="in/configuration/generalStoreName" /> Payment Alert
========================================================================

Order Number : <xsl:value-of select="in/salesOrder/salesOrderNumber" />
PO Number    : <xsl:value-of select="in/salesOrder/purchaseOrderNumber" />
Order Date   : <xsl:value-of select="format-dateTime(in/salesOrder/orderDate, '[Y]-[M01]-[D01] [H01]:[m01]')" />

Bill To:
<xsl:value-of select="in/salesOrder/billingCompany" />
<xsl:value-of select="concat(in/salesOrder/billingFirstName, ' ', in/salesOrder/billingLastName)" />
<xsl:value-of select="in/salesOrder/billingStreet" />, <xsl:value-of select="in/salesOrder/billingCity" />, <xsl:value-of select="in/salesOrder/billingSubdivisionName" />, <xsl:value-of select="in/salesOrder/billingPostalCode" />, <xsl:value-of select="in/salesOrder/billingCountryName" />

Ship To:
<xsl:value-of select="in/salesOrder/shippingCompany" /> 
<xsl:value-of select="concat(in/salesOrder/shippingFirstName, ' ', in/salesOrder/shippingLastName)" />
<xsl:value-of select="in/salesOrder/shippingStreet" />, <xsl:value-of select="in/salesOrder/shippingCity" />, <xsl:value-of select="in/salesOrder/shippingSubdivisionName" />, <xsl:value-of select="in/salesOrder/shippingPostalCode" /> <xsl:value-of select="in/salesOrder/shippingCountryName" />

Payment:
<xsl:for-each select="in/salesOrder/salesPayments/salesPayment[transactionType = 1 or transactionType = 2]">
<xsl:value-of select="paymentMethodName"/> <xsl:value-of select="creditCardHint"/><xsl:value-of select="paymentHint"/><xsl:value-of select="voucherHint"/> <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(amount * /in/salesOrder/exchangeRate, '#,##0.00')" />
</xsl:for-each>

------------------------------------------------------------------------
<xsl:for-each select="in/salesOrder/salesOrderDetails/salesOrderDetail[parentSalesOrderDetailID='']">
SKU          : <xsl:value-of select="sku" />
Item         : <xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" />
               <xsl:for-each select="salesOrderDetails/salesOrderDetail">    <xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" />: <xsl:value-of select="quantity" />, </xsl:for-each>
               <xsl:for-each select="dynamicFormResult/fields/field"><xsl:value-of select="replace(@id, '_', ' ')" />: <xsl:value-of select="." />, </xsl:for-each>
Quantity     : <xsl:value-of select="quantity" />
Amount       : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(combinedAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />

</xsl:for-each>
------------------------------------------------------------------------
Discount     : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(sum(in/salesOrder/salesOrderDetails/salesOrderDetail/discountAmount) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Sub-Total    : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/subTotalAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Shipping     : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/shippingAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Handling     : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/handlingAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /> 
Taxes        : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number((in/salesOrder/taxAmount1 + in/salesOrder/taxAmount2 + in/salesOrder/taxAmount3 + in/salesOrder/taxAmount4 + in/salesOrder/taxAmount5) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Total        : <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/totalAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Total Savings: <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number((sum(in/salesOrder/salesOrderDetails/salesOrderDetail/discountAmount) + in/salesOrder/handlingDiscountAmount + in/salesOrder/shippingDiscountAmount + in/salesOrder/taxDiscountAmount) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" />
Points earned: <xsl:value-of select="in/salesOrder/rewardsPointsQualified" />
	</textBody>
      <htmlBody xml:space="preserve">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" style="background-color:#EEEEEE">
			<tr>
				<td style="font-size:large"><xsl:value-of select="in/configuration/generalStoreName" /> Payment Alert</td>
			</tr>
		</table>
		<br />
		<table border="0" cellpadding="0" cellspacing="3">
			<tr>
				<td><b>Order Number:</b></td><td><xsl:value-of select="in/salesOrder/salesOrderNumber" /></td>
			</tr>
            <tr>
				<td><b>PO Number:</b></td><td><xsl:value-of select="in/salesOrder/purchaseOrderNumber" /></td>
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
			<tr>
				<td style="vertical-align:top"><b>Ship To:</b></td>
				<td>
					<xsl:value-of select="in/salesOrder/shippingCompany" /><br />
					<xsl:value-of select="concat(in/salesOrder/shippingFirstName, ' ', in/salesOrder/shippingLastName)" /><br />
					<xsl:value-of select="in/salesOrder/shippingStreet" />, <xsl:value-of select="in/salesOrder/shippingCity" />, <xsl:value-of select="in/salesOrder/shippingSubdivisionName" />, <xsl:value-of select="in/salesOrder/shippingPostalCode" />, <xsl:value-of select="in/salesOrder/shippingCountryName" />
				</td>
			</tr>
      <tr>
				<td style="vertical-align:top"><b>Payment:</b></td>
				<td>
					<xsl:for-each select="in/salesOrder/salesPayments/salesPayment[transactionType = 1 or transactionType = 2]">
              <xsl:value-of select="paymentMethodName"/> <xsl:value-of select="creditCardHint"/><xsl:value-of select="paymentHint"/><xsl:value-of select="voucherHint"/> <xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(amount * /in/salesOrder/exchangeRate, '#,##0.00')" /><br />
          </xsl:for-each>
				</td>
			</tr>
		</table>	
                <br /><br />
                <table border="1" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                    <td><b>SKU</b></td><td><b>Item</b></td><td><b>Quantity</b></td><td><b>Amount</b></td>
                </tr>
       <xsl:for-each select="in/salesOrder/salesOrderDetails/salesOrderDetail[parentSalesOrderDetailID='']">
					<tr>
						<td><xsl:value-of select="sku" /></td>
						<td>
                          <xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" /><br/>
                          <xsl:for-each select="salesOrderDetails/salesOrderDetail">    <xsl:value-of select="productName" /> - <xsl:value-of select="productVariantName" />: <xsl:value-of select="quantity" /><br /></xsl:for-each>  
                          <xsl:for-each select="dynamicFormResult/fields/field"><xsl:value-of select="replace(@id, '_', ' ')" />: <xsl:value-of select="." />, </xsl:for-each>
                        </td>
						<td><xsl:value-of select="quantity" /></td>
						<td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(combinedAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
					</tr>
				</xsl:for-each>
                </table>
		<br /><br />
		<table border="0" cellpadding="3" cellspacing="0">
			<tr>
				<td><b>Discount:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(sum(in/salesOrder/salesOrderDetails/salesOrderDetail/discountAmount) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Sub-Total:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/subTotalAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Shipping:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/shippingAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Handling:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/handlingAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Taxes:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number((in/salesOrder/taxAmount1 + in/salesOrder/taxAmount2 + in/salesOrder/taxAmount3 + in/salesOrder/taxAmount4  + in/salesOrder/taxAmount5) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Total:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number(in/salesOrder/totalAmount * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
			<tr>
				<td><b>Total Savings:</b></td><td><xsl:value-of select="/in/salesOrder/currency/currencySymbol" /><xsl:value-of select="format-number((sum(in/salesOrder/salesOrderDetails/salesOrderDetail/discountAmount) + in/salesOrder/handlingDiscountAmount + in/salesOrder/shippingDiscountAmount + in/salesOrder/taxDiscountAmount) * /in/salesOrder/exchangeRate, &quot;#,##0.00&quot;)" /></td>
			</tr>
      <tr>
        <td><strong>Points earned:</strong></td>
        <td><xsl:value-of select="in/salesOrder/rewardsPointsQualified" /></td>
      </tr>
		</table>
	</htmlBody>
    </out>
  </xsl:template>
</xsl:transform>