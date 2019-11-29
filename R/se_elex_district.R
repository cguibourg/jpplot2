#' Loads a map of Swedish electoral districts for plotting with ggplot2
#'
#' This function loads a map of Swedish electoral districts (valdistrikt), ready for plotting with ggplot. The shapefile comes from Valmyndigheten.se
#' @param keep The amount you want to simplify the shapefile to - defaults to five percent
#' @param region What you want to call each region when fortified. This should be an area code or other unique identifier.
#' It defaults to the 8-letter code for each electoral district
#' @keywords se_county
#' @export
#' @examples
#' sweden <- se_elex_district() %>% inner_join(life.exp, by = c('id' = 'district_id'))


#Municipality-level map of Sweden, where the electoral district ID is the default
se_elex_district <- function(keep = 0.05, region = 'VD'){
  shapefile <- rgdal::readOGR(dsn = '~/Documents/Data/jpplot2/2018_valgeografi_valdistrikt',
                              layer = 'alla_valdistrikt')
  simplified <- rmapshaper::ms_simplify(shapefile, keep)
  ggplot2::fortify(simplified, region = region)
}
