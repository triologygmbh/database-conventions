README.md: README.pp
	./src/prepro -l \~ README.pp > README.tmp
	./src/prepro -l \~ README.tmp > README.md

clean:
	rm -f README.md
	rm -f toc.tmp
	rm -f README.tmp
	rm -f *~

.PHONY: clean
