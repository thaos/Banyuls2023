# https://cran.r-project.org/web/packages/ecmwfr/vignettes/cds_vignette.html

library(ecmwfr)

# wf_set_key(user, key, service)


request <- list(
    "dataset_short_name" = "reanalysis-era5-single-levels",
    "product_type"   = "reanalysis",
    "variable"       = "2m_temperature",
    "year"           = "1940",
    "month"          = "01",
    "day"            = c(
        '01', '02', '03',
        '04', '05', '06',
        '07', '08', '09',
        '10', '11', '12',
        '13', '14', '15',
        '16', '17', '18',
        '19', '20', '21',
        '22', '23', '24',
        '25', '26', '27',
        '28', '29', '30',
        '31'
    ),
    "time"           = c(
        '00:00', '01:00', '02:00',
        '03:00', '04:00', '05:00',
        '06:00', '07:00', '08:00',
        '09:00', '10:00', '11:00',
        '12:00', '13:00', '14:00',
        '15:00', '16:00', '17:00',
        '18:00', '19:00', '20:00',
        '21:00', '22:00', '23:00'
    ),
    "area"           = "70/-20/30/60",
    "format"         = "netcdf",
    "target"         =  'data/era5_2m_temperature_194001.nc'
)

# Start downloading the data, the path of the file
# will be returned as a variable (ncfile)
ncfile <- wf_request(
    user = "8136",
    request = request,   
    transfer = TRUE,  
    path = ".",
    verbose = TRUE)
    
