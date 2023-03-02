# https://docs.xarray.dev/en/stable/user-guide/io.html

import xarray as xr
import numpy as np
import pandas as pd
import cartopy.crs as ccrs
import matplotlib.pyplot as plt


ds = xr.Dataset(
    {"foo": (("x", "y"), np.random.rand(4, 5))},
    coords={
        "x": [10, 20, 30, 40],
        "y": pd.date_range("2000-01-01", periods=5),
        "z": ("x", list("abcd")),
    },
)


ds.to_netcdf("saved_on_disk.nc")

ds_disk = xr.open_dataset("saved_on_disk.nc")
ds_disk = xr.open_dataset(
    'data/orog_EUR-11_IPSL-IPSL-CM5A-LR_historical_r0i0p0_GERICS-REMO2015_v1_fx.nc')
ds_disk

# this automatically closes the dataset after use

with xr.open_dataset("saved_on_disk.nc") as ds:
    print(ds.keys())

#  ds_disk["foo"]

pole = (-162.0, 39.25)
projection = ccrs.PlateCarree()
transform = ccrs.RotatedPole(pole_latitude=pole[1], pole_longitude=pole[0])
ax = plt.axes(projection=transform)
p = ds_disk["orog"].plot(
    ax=ax,
    transform=transform,
    x="rlon",
    y="rlat"
)
ax.coastlines()


ax.coastlines()
