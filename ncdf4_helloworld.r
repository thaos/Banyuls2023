library(ncdf4)


nc <- nc_open("data/orog_EUR-11_IPSL-IPSL-CM5A-LR_historical_r0i0p0_GERICS-REMO2015_v1_fx.nc")
orog <- ncvar_get(nc, "orog")
rlon <- ncvar_get(nc, "rlon")
rlat <- ncvar_get(nc, "rlat")
nc_close(nc)

fields::image.plot(rlon, rlat, orog)

crs = "+proj=ob_tran +o_proj=longlat +o_lon_p=0 +o_lat_p=39.25 +lon_0=18 +to_meter=0.01745329"
world1 <- sf::st_as_sf(maps::map("world", plot = FALSE, fill = TRUE))
world2 <- lwgeom::st_transform_proj(world1, crs = crs)
plot(sf::st_geometry(world2), add = TRUE)

