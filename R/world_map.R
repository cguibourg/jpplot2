#' Loads a world map
#'
#' This function loads a world map ready for plotting with ggplot.
#' @param keep The amount you want to simplify the shapefile to - defaults to five percent
#' @param region What you want to call each region when fortified. This should be an area code or other unique identifier.
#' It defaults to the 3-letter ISO code
#' @keywords world_map
#' @export
#' @examples
#' world <- world_map() %>% inner_join(life.exp, by = c('id' = 'three_letter_iso'))


#world map, where ISO3 is the default
world_map <- function(keep = 0.05, region = 'ISO_A3'){
  shapefile <- rgdal::readOGR(dsn = 'shapefiles/ne_50m_admin_0_countries',
                              layer = 'ne_50m_admin_0_countries')
  simplified <- rmapshaper::ms_simplify(shapefile, keep)
  PROJ <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
  world_rob  <- sp::spTransform(simplified, CRSobj = PROJ)
  ggplot2::fortify(world_rob, region = region)
}
