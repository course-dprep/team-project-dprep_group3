all: analysis data_preparation

data_preparation:
	make -c src/data_preparation

analysis:
	make -c src/analysis

clean:
	R -e "unlink('gen/analysis/temp/*.*')" "unlink('gen/data_preparation/temp*.*')"