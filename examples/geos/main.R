# Geo examples

# Try out 2 exemplary packages:
library(sf)
library(terra)

# sf
nc <- st_read(system.file("shape/nc.shp", package = "sf"))
class(nc)
print(nc[9:15], n = 3)

# terra
f <- system.file("ex/lux.shp", package = "terra")
p <- vect(f)
print(p)
