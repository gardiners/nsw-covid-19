# Prepare ABS postcode data for visualisation

library(tidyverse)
library(sf)
library(rmapshaper)

# Download:
poa_url <- "https://www.ausstats.abs.gov.au/ausstats/subscriber.nsf/0/4FB811FA48EECA7ACA25802C001432D0/$File/1270055003_poa_2016_aust_shape.zip"
download_path <- tempfile(fileext = ".zip")
extract_path <- tempfile()
download.file(poa_url, download_path, method = "libcurl")

# Extract
unzip(download_path, list = TRUE)
unzip(download_path, exdir = extract_path)

# Load and filter to NSW postcodes only
aus_poa <- st_read(paste0(extract_path, "/POA_2016_AUST.shp"),
                   stringsAsFactors = FALSE)

nsw_poa <- aus_poa %>%
  filter(str_detect(POA_NAME16, "^2"))

# Simplify geometries to reduce file size and browser memory requirement
nsw_simple <- ms_simplify(nsw_poa)
st_write(nsw_simple, "data/nsw_poa_simple.gpkg", delete_dsn = TRUE)
