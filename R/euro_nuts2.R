#' Loads a NUTS2-level map of Europe, for plotting Eurostat data
#'
#' This function loads a map of European NUTS2 regions, ready for plotting with ggplot.
#' @param keep The amount you want to simplify the shapefile to - defaults to five percent
#' @param region What you want to call each region when fortified. This should be an area code or other unique identifier.
#' It defaults to the 4-letter NUTS ID
#' @keywords euro_nuts2
#' @export
#' @examples
#' europe <- euro_nuts2() %>% inner_join(life.exp, by = c('id' = 'nuts_id'))


#NUTS2 map, where NUTS_ID is the default
euro_nuts2 <- function(keep = 0.05, region = 'NUTS_ID'){
  shapefile <- rgdal::readOGR(dsn = '~/Documents/Data/jpplot2/ref-nuts-2016-20m.shp/NUTS_RG_20M_2016_4326_LEVL_2.shp',
                              layer = 'NUTS_RG_20M_2016_4326_LEVL_2')
  simplified <- rmapshaper::ms_simplify(shapefile, keep)
  ggplot2::fortify(simplified, region = region)
}
