#' Loads a map of Swedish municipalities for plotting with ggplot2
#'
#' This function loads a map of Swedish municipalities (kommuner), ready for plotting with ggplot. The shapefile comes from Valmyndigheten.se
#' @param keep The amount you want to simplify the shapefile to - defaults to five percent
#' @param region What you want to call each region when fortified. This should be an area code or other unique identifier.
#' It defaults to the 4-letter municipality ID
#' @keywords se_municipality
#' @export
#' @examples
#' sweden <- se_municipality() %>% inner_join(life.exp, by = c('id' = 'municipality_id'))


#Municipality-level map of Sweden, where the municipality ID is the default
se_municipality <- function(keep = 0.05, region = 'KOM'){
  shapefile <- rgdal::readOGR(dsn = '~/Documents/Data/jpplot2/2018_valgeografi_kommuner',
                              layer = 'alla_kommuner')
  simplified <- rmapshaper::ms_simplify(shapefile, keep)
  ggplot2::fortify(simplified, region = region)
}
