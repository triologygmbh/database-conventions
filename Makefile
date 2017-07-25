all: README.md i18n/README.de.md


README.md: README.pp
	./src/prepro -l \~ README.pp > README.tmp
	./src/prepro -l \~ README.tmp > README.md

i18n/README.de.md: i18n/README.de.pp
	./src/prepro -l \~ i18n/README.de.pp > README.tmp
	./src/prepro -l \~ README.tmp > i18n/README.de.md

clean:
	rm -f README.md
	rm -f i18n/README.de.md
	rm -f toc.tmp
	rm -f README.tmp
	rm -f *~

.PHONY: clean
