library(ncdf4)


nc <- nc_open("data/orog_EUR-11_IPSL-IPSL-CM5A-LR_historical_r0i0p0_GERICS-REMO2015_v1_fx.nc")
orog <- ncvar_get(nc, "orog")
rlon <- ncvar_get(nc, "rlon")
rlat <- ncvar_get(nc, "rlat")
nc_close(nc)



fields::image.plot(rlon, rlat, orog)
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=180 +to_meter=0.01745329"
world1 <- sf::st_as_sf(maps::map("world", plot = FALSE, fill = TRUE))
world2 <- sf::st_transform(world1, crs = crs)
sf::st_crs(world2) = NA
sf::st_crs(world2) = 4326
plot(sf::st_geometry(world2))


crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=10 +to_meter=0.01745329"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=180 +ellps=sphere +no_defs"
crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=180 +ellps=WGS84"
library(maptools)
data(wrld_simpl) # loads the world map dataset
wrl <- as(wrld_simpl,"SpatialLines")
world_rot <- spTransform(wrld_simpl, crs)
plot(world_rot)
plot(world_rot, add = TRUE)

crs = "+proj=ob_tran +o_proj=longlat +ellps=WGS84 +a=6378137.0 +o_lon_p=0.0 +o_lat_p=39.25 +lon_0=18 +to_meter=111319.49079327357"
world_rot <- spTransform(wrld_simpl, crs)
plot(world_rot)

crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=-162 +o_lat_p=39.25 +lon_0=18 +to_meter=0.01745329"

rot.coords <- expand.grid(lon = rlon, lat = rlat)
tas_grid <- cbind(rot.coords, tas = as.vector(orog))
coordinates(tas_grid) <- ~ lon + lat
gridded(tas_grid) <- TRUE

# coerce to SpatialPixelsDataFrame
proj4string(tas_grid) <- CRS(crs)
world_rot <- spTransform(wrld_simpl, crs)

plot(tas_grid, axes = FALSE)   ## Lola : ne marche pas !
plot(world_rot, add = TRUE)
