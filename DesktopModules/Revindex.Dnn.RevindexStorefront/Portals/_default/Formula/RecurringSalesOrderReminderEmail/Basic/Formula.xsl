<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:decimal-format decimal-separator="." grouping-separator="," />
  <xsl:template match="/">
    <out>
      <!--Sender address-->
      <mailFrom>
        johndoe@example.com
      </mailFrom>
      <!--Destination address-->
      <mailTo>
        jane@acme.com
      </mailTo>
      <mailBcc>
        johndoe@example.com
      </mailBcc>
      <!--Email subject line-->
      <subject>
        Sales order receipt
      </subject>
      <!--Text version of the email-->
      <textBody xml:space="preserve">
        Text version of the email
	    </textBody>
      <!--HTML version of the email-->
      <htmlBody xml:space="preserve">
		    <b>HTML version of the email</b>
	    </htmlBody>
    </out>
  </xsl:template>
</xsl:transform>
