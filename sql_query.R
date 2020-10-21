if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GEOmetadb")
BiocManager::install("SRAdb")
library(GEOquery)
library(GEOmetadb)
library(SRAdb)


if(!file.exists('GEOmetadb.sqlite')) {
  getSQLiteFile()
   }

file.info('GEOmetadb.sqlite') 
con <- dbConnect(SQLite(), "GEOmetadb.sqlite")
dbDisconnect(con)

geo_tables <- dbListTables(con)
geo_tables

# get the GEO series accession and titie from GEO series that were submitted by "sean davis"

rs <- dbGetQuery (con,paste("select gse, title from gse where", "contributor like '%Sean%Davis%'", sep=" "))


# As another example, GEOmetadb can find all samples on GPL96 (Affymetrix hgu133a) that have .CEL files available for download.
rs <- dbGetQuery(con,paste("select gsm,supplementary_file",
                              "from gsm where gpl='GPL96'",
                              "and supplementary_file like '%CEL.gz'"))
dim(rs)
[1] 18910 2


rs
# The first step, then, is to get the SRAdb SQLite file from the online location
# The download and uncompress steps are done automatically with a single command, getSRAdbFile
library(SRAdb)
if(!file.exists('SRAdb.sqlite')) {
 sqlfile <- getSRAdbFile()
}
file.info('SRAmetadb.sqlite') 
# open connection
sra_con <- dbConnect(SQLite(), 'SRAdb.sqlite')
sra_con


# ---------------------------------------------------------------------------------------------------------
