<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <sendMail>
        <mailFrom>support@company.com</mailFrom>
        <mailTo>johndoe@example.com</mailTo>
        <subject>Email subject</subject>
        <textBody>Email text body</textBody>
        <htmlBody>
          <h1>Email HTML body</h1>
        </htmlBody>
      </sendMail>
    </out>
  </xsl:template>
</xsl:transform>
