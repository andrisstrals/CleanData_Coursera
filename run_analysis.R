# Check if data directory is exists; create if doesn't
dataDirName <- "./data"
if(!file.exists(dataDirName)) {
	dir.create(dataDirName)
}

