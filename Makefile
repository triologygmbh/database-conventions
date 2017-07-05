README.md: README.pp
	./src/prepro -l \~ README.pp > README.tmp
	./src/prepro -l \~ README.tmp > README.md

clean:
	rm README.md
	rm toc.tmp
	rm README.tmp
	rm *~

.PHONY: clean
