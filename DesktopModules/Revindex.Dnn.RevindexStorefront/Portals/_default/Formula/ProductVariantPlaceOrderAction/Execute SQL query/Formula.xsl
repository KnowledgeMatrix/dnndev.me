<xsl:transform version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <out>
      <!-- Execute SQL queries or stored procedure(s). You must enable SQL queries in your security settings first. 
      Optionally provide a connection string name or leave blank to use default connection. -->
      <sql>
        <connectionStringName />
        <query>
          DECLARE @Data varchar(100)
          SET @Data = 'something'
          INSERT INTO {databaseOwner}{objectQualifier}Table (Col1, Col2) VALUES (1, @Data);

          -- EXEC {databaseOwner}{objectQualifier}StoredProcedureName @params1 = 1, @params2 = 2
        </query>
      </sql>
    </out>
  </xsl:template>
</xsl:transform>