library(ncdf4)


nc <- nc_open("data/orog_EUR-11_IPSL-IPSL-CM5A-LR_historical_r0i0p0_GERICS-REMO2015_v1_fx.nc")
orog <- ncvar_get(nc, "orog")
rlon <- ncvar_get(nc, "rlon")
rlat <- ncvar_get(nc, "rlat")
nc_close(nc)



fields::image.plot(rlon, rlat, orog)
lines(mapproj::mapproject(maps::map("world", plot = FALSE), orientation = c(39.25, 0 , 18)))
fields::image.plot(rlat, rlon, t(orog))


crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=180 +to_meter=0.01745329"
world1 <- sf::st_as_sf(maps::map("world", plot = FALSE, fill = TRUE))
world2 <- sf::st_transform(world1, crs = crs)
sf::st_crs(world2) = NA
sf::st_crs(world2) = 4326
plot(sf::st_geometry(world2))


crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=18 +to_meter=0.01745329"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=180 +ellps=sphere +no_defs"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=180 +ellps=WGS84"
  library(maptools)
data(wrld_simpl) # loads the world map dataset
wrl <- as(wrld_simpl,"SpatialLines")
world_rot <- spTransform(wrl, crs)
plot(world_rot)
plot(spTransform(world_rot, CRS('+proj=longlat')))

plot(world_rot, add = TRUE)

crsmoll = "+proj=ob_tran +o_proj=moll +o_lon_p=0.0 +o_lat_p=39.25 +lon_0=18.0 +to_meter=111319.4907932736 +ellps=WGS84 +a=6378137.0  +no_defs"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0.0 +o_lat_p=39.25 +lon_0=18.0 +to_meter=111319.4907932736 +ellps=WGS84 +a=6378137.0  +no_defs"
crs = "+proj=ob_tran +o_proj=moll +o_lon_p=40 +o_lat_p=50 +lon_0=60"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=40 +o_lat_p=50 +lon_0=60"

crs = "+proj=ob_tran +o_proj=longlat +ellps=WGS84  +o_lon_p=-160 +o_lat_p=90 +lon_0=90"
world_rot <- spTransform(wrld_simpl, crsmoll)
world_rot <- spTransform(world_rot, crs)

coordinates(world_rot)
plot(world_rot, xlim = c(-20, 20), ylim =  c(-20, 20))

crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=18 +to_meter=0.01745329"

rot.coords <- expand.grid(lon = rlon, lat = rlat)
tas_grid <- cbind(rot.coords, tas = as.vector(orog))
coordinates(tas_grid) <- ~ lon + lat
gridded(tas_grid) <- TRUE

# coerce to SpatialPixelsDataFrame
proj4string(tas_grid) <- CRS(crs)
plot(spTransform(tas_grid, CRS('+proj=longlat')))
world_rot <- spTransform(wrld_simpl, crs)

plot(tas_grid, axes = FALSE)   ## Lola : ne marche pas !
plot(world_rot, add = TRUE)


library(sf)
# Linking to GEOS 3.5.1, GDAL 2.2.1, proj.4 4.9.3
library(lwgeom)
# Linking to liblwgeom 2.5.0dev r16016, GEOS 3.5.1, proj.4 4.9.3
crs = c("+proj=longlat", "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=18  +to_meter=0.01745329")
(pole = st_point(c(0,90)))
# POINT (0 90)
st_transform_proj(pole, crs)
# POINT (-162 40.00001)
(p = st_point(c(0,80)))
# POINT (0 80)
(pp = st_transform_proj(p, crs))
# POINT (-162 30)
st_transform_proj(pp, crs[2:1])
# POINT (2.537951e-13 80)

world_rot <- (st_transform_proj(world1, crs))
plot(sf::st_geometry(world_rot), add = TRUE)
