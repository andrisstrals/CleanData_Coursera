# Check if data directory is exists; create if doesn't
dataDirName <- "./data"
if(!file.exists(dataDirName)) {
	dir.create(dataDirName)
}

# Download and unzip source data
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tmpFile <- tempfile()
library(RCurl)
download.file(zipUrl, destfile = tmpFile, method = "libcurl")
unzip(tmpFile, exdir = dataDirName)

