all:
	latexmk -pdf main.tex
	latexmk -c 

clean:
	rm main.run.xml main.bbl