##### LDP Project ~ Assignment 2 ~ October 2020
##### Script 1 ~ Download & Process raw data

# Load Packages -----------------------------------------------------------

library(raster) # For spatial operations
library(ncdf4) # For loading NetCDF data
library(rgeobon) # For accessing EBV data

# Import EBV / GEO BON data -----------------------------------------------

# Look at the list of datasets and search for our data
dataset_list <- geobon_list()
View(dataset_list) # We need dataset 1 and 4

# Download data in data/raw
# Dataset 1 is bird data and is very light
# Dataset 4 is fragmentation data, and is quite heavy
geobon_download(id = c(1,4), path = "data/raw")