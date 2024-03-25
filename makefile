all: analysis data_preparation 

data_preparation:
	make -C src/data_preparation

analysis:
	make -C src/analysis

clean:
	R -e "unlink('gen/analysis/temp/*.*')" "unlink('gen/data_preparation/temp*.*')"