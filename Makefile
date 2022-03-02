.SECONDARY:

%.png: piechart.gpi %.sum
	gnuplot -e "set terminal pngcairo noenhanced size 1000,600; set output '$@';" -c $^

%.sum: piechart.awk %.txt
	SUMMARY=$$(./$< < $(word 2,$^)); ORDERED=$$(echo "$$SUMMARY" | head -n-2 | sort -r -g -k 2); CODA=$$(echo "$$SUMMARY" | tail -n-2); echo -e "$$ORDERED\n$$CODA" > $@
