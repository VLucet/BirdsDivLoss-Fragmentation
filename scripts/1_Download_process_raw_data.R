##### LDP Project ~ Assignment 2 ~ October 2020
##### Script 1 ~ Download & Process raw data

# Load Packages -----------------------------------------------------------

library(raster) # For spatial operations on grid data
library(sf) # For spatial operations on vector data
library(ncdf4) # For loading NetCDF data
library(rgeobon) # For accessing EBV data

# Import EBV / GEO BON data -----------------------------------------------

# Look at the list of datasets and search for our data
dataset_list <- geobon_list()
View(dataset_list) # We need dataset 1 and 4

# Download data in data/raw
# Dataset 1 is bird data and is 1.5 MB.
# Dataset 4 is fragmentation data, and is 12 GB.
geobon_download(id = c(1,4), path = "data/raw")

# Import data -------------------------------------------------------------

# Bird data 
# Print info
print(nc_open("data/raw/cSAR_idiv_v1.nc"))
# Import as raster brick and set epsg correctly
bird <- brick("data/raw/cSAR_idiv_v1.nc")
crs(bird) <- crs("+proj=longlat +datum=WGS84 +no_defs")
# Change the naming of columns
names(bird) <- paste0("change_", c(seq(from=1910, to=2010, by=10), 2015))
# Get most recent layer
bird_2015 <- bird$change_2015

# Fragmentation data
# Print info
RMF <- (nc_open("data/raw/RMF_002.nc"))
# Import as raster brick and set epsg correctly
RMF <- brick("data/raw/RMF_002.nc")
crs(RMF) <- crs("+proj=longlat +datum=WGS84 +no_defs")
# Get most recent layer
RMF_2018 <- RMF$X2018.01.01

# Canada Ecodistricts
# Downloaded the GML here 
# https://open.canada.ca/data/en/dataset/fe9fd41c-1f67-4bc5-809d-05b62986b26b
ecodist <- st_read("data/raw/BIO_CA_TER_ECODISTRICT_V2_2/BIO_CA_TER_ECODISTRICT_V2_2.gml")
         
# Process data ------------------------------------------------------------

writeRaster(RMF_2018, "test.tif")

# Crop data
bird_2015_ca <- crop(bird_2015, st_transform(ecodist, crs(bird_2015)))
RMF_2018_ca <- crop(RMF_2018, st_transform(ecodist, crs(RMF_2018)))
