#!/bin/bash

function DecryptString() {
echo "${1}" | /usr/bin/openssl enc -aes256 -d -a -A -S "${2}" -k "${3}"
}

EncryptedString="U2FsdGVkX1+1nTgI0CtcIWeucYoiUzsRzEiQKmbBKDQ="
Salt="b59d3808d02b5c21"
Passphrase="21899c3d8247dce72ad190d9"

jamfpro_username="jamfproadmin"
jamfpro_password=$(DecryptString "${EncryptedString}" "${Salt}" "${Passphrase}")
jamfpro_url="https://jamf.pro.server.here:8443"


#######################################
# Create an XSLT file at /tmp/stylesheet.xslt
#######################################
cat << EOF > /tmp/stylesheet.xslt
<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
<xsl:output method="text"/> 
<xsl:template match="/">
<xsl:text>You have </xsl:text>
<xsl:value-of select="computers/size"/>
<xsl:text> Computers</xsl:text>
<xsl:text>&#xa;</xsl:text> 
<xsl:text>&#xa;</xsl:text>
<xsl:for-each select="computers/computer">
<xsl:text>Computer name: </xsl:text> 
<xsl:value-of select="name"/>
<xsl:text>&#xa;</xsl:text> 
<xsl:text>ID: </xsl:text> 
<xsl:value-of select="id"/> 
<xsl:text>&#xa;</xsl:text> 
</xsl:for-each> 
</xsl:template> 
</xsl:stylesheet>
EOF
#######################################
# Request a list of computers from the Jamf Pro API
# Pass the XML data to xsltproc applying the stylesheet
#######################################
curl -su "$jamfpro_username":"$jamfpro_password" -H "Accept: text/xml" "$jamfpro_url"/JSSResource/computers | xsltproc /tmp/stylesheet.xslt -