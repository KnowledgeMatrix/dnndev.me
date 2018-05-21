<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html"/>
	<xsl:param name="ControlID" />
	<xsl:param name="Options" />
	<xsl:template match="/*">
		<xsl:apply-templates select="root" />
	</xsl:template>
	<xsl:template match="root">
		<ol>
			<xsl:apply-templates select="node">
				<xsl:with-param name="level" select="0" />
				<xsl:with-param name="megaMenuColumns" select="0" />
			</xsl:apply-templates>
		</ol>
	</xsl:template>
	<xsl:template match="node">
		<xsl:param name="level" />
		<xsl:param name="megaMenuColumns" />
		<xsl:if test="not($megaMenuColumns = 0) and not(position() = 1) and position() mod $megaMenuColumns = 1">
			<xsl:text disable-output-escaping="yes"><![CDATA[</ol><ol>]]></xsl:text>
		</xsl:if>
		<li>
			<xsl:attribute name="class">
				<xsl:text>edsmm_menuItem</xsl:text>
				<xsl:if test="@first = 1">
					<xsl:text> edsmm_first</xsl:text>
				</xsl:if>
				<xsl:if test="@last = 1">
					<xsl:text> edsmm_last</xsl:text>
				</xsl:if>
				<xsl:if test="node">
					<xsl:text> edsmm_hasChild</xsl:text>
				</xsl:if>
				<xsl:if test="@breadcrumb = 1">
					<xsl:text> edsmm_active</xsl:text>
				</xsl:if>
				<xsl:if test="@enabled != 1">
					<xsl:text> edsmm_disabled</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<span>
				<xsl:choose>
					<xsl:when test="@enabled = 1">
						<a class="edsmm_itemContainer">
							<xsl:attribute name="href">
								<xsl:value-of select="@url"/>
							</xsl:attribute>
							<xsl:value-of select="@text" />
						</a>
					</xsl:when>
					<xsl:otherwise>
						<span class="edsmm_itemContainer">
							<xsl:value-of select="@text" />
						</span>
					</xsl:otherwise>
				</xsl:choose>
				<span class="edsmm_childIndicator"></span>
			</span>
			<xsl:if test="node">
				<div>
					<xsl:attribute name="class">
						<xsl:text>edsmm_level_</xsl:text>
						<xsl:value-of select="$level + 1"/>
					</xsl:attribute>
					<xsl:if test="node">
						<div class="edsmm_menuListsContainer">
							<ol>
							<xsl:apply-templates select="node">
								<xsl:with-param name="level" select="$level + 1" />
								<xsl:with-param name="megaMenuColumns" select="0" />
							</xsl:apply-templates>
							</ol>
						</div>
					</xsl:if>
				</div>
			</xsl:if>
		</li>
	</xsl:template>
</xsl:stylesheet>