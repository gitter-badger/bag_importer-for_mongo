<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xb="http://www.kadaster.nl/schemas/bag-verstrekkingen/extract-deelbestand-lvc/v20090901"
  xmlns:product_LVC="http://www.kadaster.nl/schemas/bag-verstrekkingen/extract-producten-lvc/v20090901"
  xmlns:bag_LVC="http://www.kadaster.nl/schemas/imbag/lvc/v20090901"
  xmlns:bagtype="http://www.kadaster.nl/schemas/imbag/imbag-types/v20090901" >

    <xsl:output method="text" indent="yes"/>

  <xsl:template match="product_LVC:LVC-product">
    db.street.count();
    <xsl:apply-templates/>
    db.street.count();
  </xsl:template>

  <xsl:template match="text()"/>

  <xsl:template match="bag_LVC:OpenbareRuimte">
db.street.insert({
    <xsl:apply-templates select="bag_LVC:identificatie"/>
    <xsl:apply-templates select="bag_LVC:openbareRuimteNaam"/>
    <xsl:apply-templates select="bag_LVC:openbareRuimteType"/>
    <xsl:apply-templates select="bag_LVC:openbareruimteStatus"/>
    history: {
      <xsl:apply-templates select="bag_LVC:aanduidingRecordInactief"/>
      <xsl:apply-templates select="bag_LVC:aanduidingRecordCorrectie"/>
      <xsl:apply-templates select="bag_LVC:officieel"/>
      <xsl:apply-templates select="bag_LVC:tijdvakgeldigheid"/>
      <xsl:apply-templates select="bag_LVC:bron"/>
    },
});
  </xsl:template>

  <xsl:template match="bag_LVC:identificatie">
    id: <xsl:value-of select="."/>,
  </xsl:template>

  <xsl:template match="bag_LVC:openbareRuimteNaam">
    name: "<xsl:value-of select="."/>",
  </xsl:template>

  <xsl:template match="bag_LVC:openbareRuimteType">
    type: "<xsl:value-of select="."/>",
  </xsl:template>

  <xsl:template match="bag_LVC:openbareruimteStatus">
    status: "<xsl:value-of select="."/>",
  </xsl:template>

  <xsl:template match="bag_LVC:aanduidingRecordInactief">
    active: <xsl:if test=". = 'N'">true</xsl:if><xsl:if test=". = 'J'">false</xsl:if>,
  </xsl:template>

  <xsl:template match="bag_LVC:aanduidingRecordCorrectie">
    correctionNumber: <xsl:value-of select="."/>,
  </xsl:template>

  <xsl:template match="bag_LVC:officieel">
    official: <xsl:if test=". = 'J'">true</xsl:if><xsl:if test=". = 'N'">false</xsl:if>,
  </xsl:template>

  <xsl:template match="bag_LVC:tijdvakgeldigheid">
      valid: {
        <xsl:apply-templates/>
      },
  </xsl:template>

  <xsl:template match="bagtype:begindatumTijdvakGeldigheid">
    start: <xsl:value-of select="."/>,
  </xsl:template>

  <xsl:template match="bagtype:einddatumTijdvakGeldigheid">
    end: <xsl:value-of select="."/>,
  </xsl:template>

  <xsl:template match="bag_LVC:bron">
    sourceDocument: {
      <xsl:apply-templates/>
    },
  </xsl:template>

  <xsl:template match="bagtype:documentdatum">
    date: <xsl:value-of select="."/>,
  </xsl:template>

  <xsl:template match="bagtype:documentnummer">
    number: "<xsl:value-of select="."/>",
  </xsl:template>

</xsl:stylesheet>
