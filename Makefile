# Makefile

default: 練馬区.kml 東村山市.kml

map:
	open $(URL_TAMA) $(URL_WEST)

URL_TAMA	=	'https://www.google.com/maps/d/viewer?hl=ja&mid=1ZiG9f7Zy_yeFmmcVENK0tWt1YGghdtk&ll=35.743870311984374%2C139.4759485&z=12'
URL_WEST	=	'https://www.google.com/maps/d/viewer?hl=ja&mid=1vta483ns58fvyi8oWecYCy0nkGcEmqY&ll=35.66905955832993%2C139.66700335&z=11'

.SUFFIXES: .csv.kmz .kmlorig .kml

.csv.kmz.kmlorig:
	unzip -p $? doc.kml > $@

.kmlorig.kml:
	cat $? | xmlstarlet ed -N k="http://www.opengis.net/kml/2.2" -d "//k:Placemark[k:styleUrl!='#icon-1899-0288D1-labelson']" > $@
	@echo $(basename $?)
	@echo -n pins all
	@grep labelson $(basename $?).kmlorig | wc -l
	@echo -n pins to go
	@grep icon-1899-0288D1-labelson $@ | wc -l

clean:
	rm -f *.kml *.csv.kmz

# EOF
