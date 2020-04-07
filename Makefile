publish: docs/index.html

data/nsw_poa_simple.gpkg :
	Rscript dataprep-gis.R
	
data/case_stream.rds : update

update:
	Rscript dataprep-covid.R

docs/index.html : dashboard.Rmd data/nsw_poa_simple.gpkg data/poa_pop.csv update
	Rscript Render.R

clean :
	rm -rf data/nsw_poa_simple.gpkg data/case_stream.rds docs dashboard.html