<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Specify the role name to grant. You can grant multiple roles by repeating the node elements -->
      <grantSecurityRole>
        <roleName>Role 1</roleName>
        <!-- Optionally provide an expiry date if you want the role to expire after a fixed period -->
        <expire>2021-01-01T12:00:00</expire>
      </grantSecurityRole>

      <!-- Specify the role name to revoke. You can revoke multiple roles by repeating the node elements -->
      <revokeSecurityRole>
        <roleName>Role 2</roleName>
      </revokeSecurityRole>

      <!-- Make a web request -->
      <webRequest>
        <url>http://domain.com/trigger?name=value</url>

        <!-- Specify GET or POST method -->
        <method>POST</method>

        <!-- Optional POST data -->
        <postString>name1=value1&amp;name2=value2</postString>

        <!-- Optional timeout value -->
        <timeout>30000</timeout>
      </webRequest>

      <!-- Send mail -->
      <sendMail>
        <mailFrom>support@company.com</mailFrom>
        <mailTo>johndoe@example.com</mailTo>
        <subject>Email subject</subject>
        <textBody>Email text body</textBody>
        <htmlBody>
          <h1>Email HTML body</h1>
        </htmlBody>
      </sendMail>

      <!-- Set object data -->
      <setData>
        <salesOrder>
          <status>4</status>
          <salesPaymentStatus>2</salesPaymentStatus>
          <shippingStatus>3</shippingStatus>
        </salesOrder>
        <salesOrderDetail>
          <salesOrderDetailID>1</salesOrderDetailID>
          <shippingStatus>2</shippingStatus>
        </salesOrderDetail>
      </setData>

      <!-- Decrement inventory -->
      <decrementInventory />

      <!-- Increment inventory -->
      <incrementInventory />

      <!-- Execute SQL queries or stored procedure(s). You must enable SQL queries in your security settings first. 
      Optionally provide a connection string name or leave blank to use default connection. -->
      <sql>
        <connectionStringName>ExternalSqlServer</connectionStringName>
        <query>
          INSERT INTO {databaseOwner}{objectQualifier}Table (Col1, Col2) VALUES (1, 2);
          INSERT INTO {databaseOwner}{objectQualifier}Table (Col1, Col2) VALUES (3, 4);
        </query>
      </sql>
    </out>
  </xsl:template>
</xsl:transform>
