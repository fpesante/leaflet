leafletProviderDependencies <- function() {
  list(
    htmltools::htmlDependency(
      "leaflet-providers",
      "1.0.27",
      system.file("htmlwidgets/lib/leaflet-providers", package = "leaflet"),
      script = "leaflet-providers.js"
    ),
    htmltools::htmlDependency(
      "leaflet-providers-plugin",
      packageVersion("leaflet"),
      system.file("htmlwidgets/plugins/leaflet-providers-plugin", package = "leaflet"),
      script = "leaflet-providers-plugin.js"
    )
  )
}

#' Add a tile layer from a known map provider
#'
#' @param map the map to add the tile layer to
#' @param provider the name of the provider (see
#'   \url{http://leaflet-extras.github.io/leaflet-providers/preview/} and
#'   \url{https://github.com/leaflet-extras/leaflet-providers})
#' @param layerId the layer id to assign
#' @param options tile options
#' @return modified map object
#'
#' @examples
#' \donttest{
#' leaflet() %>%
#'   addProviderTiles("Stamen.Watercolor") %>%
#'   addProviderTiles("Stamen.TonerHybrid")
#' }
#'
#' @export
addProviderTiles <- function(
  map,
  provider,
  layerId = NULL,
  options = providerTileOptions()
) {
  map$dependencies <- c(map$dependencies, leafletProviderDependencies())
  invokeMethod(map, getMapData(map), 'addProviderTiles',
    provider, layerId, options)
}

#' @param
#' errorTileUrl,noWrap,opacity,zIndex,unloadInvisibleTiles,updateWhenIdle,detectRetina,reuseTiles
#' the tile layer options; see
#' \url{http://leafletjs.com/reference.html#tilelayer}
#' @param ... named parameters to add to the options
#' @rdname addProviderTiles
#' @export
providerTileOptions <- function(errorTileUrl = '', noWrap = FALSE,
  opacity = NULL, zIndex = NULL, unloadInvisibleTiles = NULL,
  updateWhenIdle = NULL, detectRetina = FALSE, reuseTiles = FALSE, ...
) {
  opts <- list(errorTileUrl = errorTileUrl, noWrap = noWrap,
    zIndex = zIndex, unloadInvisibleTiles = unloadInvisibleTiles,
    updateWhenIdle = updateWhenIdle, detectRetina = detectRetina,
    reuseTiles = reuseTiles, ...)
  # Don't include opacity=NULL--it overrides the provider's default opacity
  if (!is.null(opacity))
    opts$opacity <- opacity
  opts
}
