#!/bin/sh

echo 'db.street.drop();' |mongo bag

time \
for x in 9999OPR08112011-0000*xml
do
  xsltproc import_opr.xsl $x |mongo bag
done
