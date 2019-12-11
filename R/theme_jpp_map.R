#' Add Journalism++ theme to a ggplot2 map
#'
#' This function allows you to add a modified version of the standard Journalism++ theme, when making map graphics
#' @keywords theme_jpp_map
#' @export
#' @examples
#' line <- ggplot(line_df, aes(x = year, y = lifeExp)) +
#' geom_line(colour = "#990000", size = 1) +
#' geom_hline(yintercept = 0, size = 1, colour="#333333") +
#' theme_jpp()


theme_jpp_map <- function() {

  font <- "OpenSans-Regular"

  theme(

    #sets panel background for regular and facet-wrapped plots as blank
    panel.background = element_blank(),
    strip.background = element_rect(fill = "white"),

    #removes gridlines, setting only horizontal as default
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.grid.major.y = element_blank(),

    #sets axis formats, setting title and ticks as blank by default
    axis.title = element_blank(),
    axis.ticks = element_blank(),
    axis.line = element_blank(),

    #sets text styles
    plot.title = element_text(family = "OpenSansCondensed-Bold",
                              size = 24,
                              face = "bold"),
    plot.subtitle = element_text(family = font,
                                 size = 18,
                                 margin = margin(8, 0, 9, 0)),
    plot.caption = element_blank(),
    axis.text = element_text(family = font,
                             size = 14),
    legend.text = element_text(family = font,
                               size = 14),
    strip.text = element_text(family = font,
                              size = 18),

    #sets legend format
    legend.position = "top",
    legend.justification = "left",
    legend.margin = margin(5.5, 0, 5.5, 0),
    legend.text.align = 0,
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.key = element_blank()

  )

}
