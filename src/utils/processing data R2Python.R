# Robust export of plot_glasgow to GeoPackage and GeoJSON

suppressPackageStartupMessages({
  library(sf)
})

# Load source data
stopifnot(exists("plot_glasgow"))
g <- plot_glasgow

# Make geometry valid
g <- st_make_valid(g)
View(plot_glasgow)

# Ensure CRS exists
if (is.na(st_crs(g))) {
  st_crs(g) <- 27700  # British National Grid
}

# Cast to MULTIPOLYGON when possible
suppressWarnings({
  g <- st_cast(g, "MULTIPOLYGON", warn = FALSE)
})

# Keep current geometry column name to avoid losing sf pointer
geom_keep <- attr(g, "sf_column")

# Sanitizer for column names that avoids GDAL conflicts
sanitize_names <- function(x) {
  x <- iconv(x, to = "ASCII//TRANSLIT")
  x <- gsub("[^A-Za-z0-9_]", "_", x)
  x <- gsub("_+", "_", x)
  x <- gsub("^_+|_+$", "", x)
  x <- tolower(x)
  x[x == "" | is.na(x)] <- "col"
  x
}

# Clean names while preserving geometry column name
nm_raw <- names(g)
nm_clean <- sanitize_names(nm_raw)

# Avoid reserved or conflicting names
nm_clean[nm_clean == "fid"] <- "fid_col"
nm_clean[nm_raw == geom_keep] <- geom_keep   # do not rename geometry column

# Enforce uniqueness after cleaning
nm_unique <- make.unique(nm_clean, sep = "_")
names(g) <- nm_unique

# Re attach geometry pointer explicitly
st_geometry(g) <- geom_keep

# Drop or convert unsupported field classes for GDAL
ok_types <- c("logical", "integer", "numeric", "character", "Date", "POSIXct", "POSIXt")
drop_cols <- character(0)
for (cn in setdiff(names(g), geom_keep)) {
  cls <- class(g[[cn]])[1]
  if (!cls %in% ok_types) {
    conv <- try(as.character(g[[cn]]), silent = TRUE)
    if (inherits(conv, "try-error")) {
      drop_cols <- c(drop_cols, cn)
    } else {
      g[[cn]] <- conv
    }
  }
}
if (length(drop_cols)) {
  g <- g[, setdiff(names(g), drop_cols)]
}

# Final safety check on duplicated names
if (any(duplicated(names(g)))) {
  dupes <- names(g)[duplicated(names(g))]
  stop(paste("Still duplicated after cleaning:", paste(unique(dupes), collapse = ", ")))
}

# Output paths (modified to save in processed folder)
gpkg_path <- "C:\\Users\\glauc\\Desktop\\PHS\\Operational_A-E\\data\\processed\\glasgow_intermediate_zones.gpkg"
geojson_path <- "C:\\Users\\glauc\\Desktop\\PHS\\Operational_A-E\\data\\processed\\glasgow_intermediate_zones.geojson"

# Remove previous files if present
if (file.exists(gpkg_path)) unlink(gpkg_path)
if (file.exists(geojson_path)) unlink(geojson_path)

# Write outputs
st_write(g, gpkg_path, layer = "glasgow", delete_dsn = TRUE, quiet = TRUE)
st_write(g, geojson_path, delete_dsn = TRUE, quiet = TRUE)

message("Wrote GeoPackage to: ", normalizePath(gpkg_path))
message("Wrote GeoJSON to: ", normalizePath(geojson_path))
