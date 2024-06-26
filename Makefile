# github.com/mrmt/anno2024
# Makefile

include targets.mk

default: $(addsuffix .kml, $(TARGETS))

.SUFFIXES: .csv.kmz .kmlorig .kml

.csv.kmz.kmlorig:
	unzip -p $? doc.kml > $@

.kmlorig.kml:
	cat $? | xmlstarlet ed -N k="http://www.opengis.net/kml/2.2" -d "//k:Placemark[k:styleUrl!='#icon-1899-0288D1-labelson']" > $@
	@echo $(basename $?)
	@echo -n 'ピン数(総計)'
	@grep labelson $(basename $?).kmlorig | wc -l
	@echo -n 'ピン数(未貼付)'
	@grep icon-1899-0288D1-labelson $@ | wc -l

clean:
	rm -f *.kml *.csv.kmz

include local.mk

# EOF
