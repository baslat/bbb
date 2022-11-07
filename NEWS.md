# bbb 1.0.0

- Use `{sf}` to make the bounding box with `sf::st_bbox()`.

# bbb 0.4.1

- `box` now returns the code to set CRS attribute with EPSG:4326 in accordance
with [Stack
Exchange](https://gis.stackexchange.com/questions/310091/what-does-the-default-crs-being-epsg3857-in-leaflet-mean)

# bbb 0.4.0

- `box` now returns the code to set CRS attribute with EPSG:3857 in accordance
with [leaflet documentation](https://rstudio.github.io/leaflet/projections.html)
, and this is respected by `morph`
- minor didactic tweaks

# bbb 0.3.0

- adds `morph` functions to change the format of bounding boxes
- fixes an incorrect reference in the returned code
- changes to use left, right etc instead of xmin, xmax in returned code
- removes `crayon` from dependencies
- adds `dplyr` to `suggests`

# bbb 0.2.0

- removes pipe from returned code
- unforces bbox code to print to console
- makes the instructions more explicit
- removes `sf` from dependencies
- removes most of the unnecessary features

# bbb 0.1.1

- forces bbox code to print to console
- comments out creation of global objects

# bbb 0.1.0

- Added a `NEWS.md` file to track changes to the package.
