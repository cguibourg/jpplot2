#' Loads a map of Swedish counties for plotting with ggplot2
#'
#' This function loads a map of Swedish counties (län), ready for plotting with ggplot. The shapefile comes from Valmyndigheten.se
#' @param keep The amount you want to simplify the shapefile to - defaults to five percent
#' @param region What you want to call each region when fortified. This should be an area code or other unique identifier.
#' It defaults to the 2-letter county ID
#' @keywords se_county
#' @export
#' @examples
#' sweden <- se_county() %>% inner_join(life.exp, by = c('id' = 'county_id'))


#County-level map of Sweden, where the county ID is the default
se_county <- function(keep = 0.05, region = 'LAN'){
  shapefile <- rgdal::readOGR(dsn = '~/Documents/Data/jpplot2/2018_valgeografi_lan',
                              layer = 'alla_lan')
  simplified <- rmapshaper::ms_simplify(shapefile, keep)
  ggplot2::fortify(simplified, region = region)
}
