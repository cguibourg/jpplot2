save_plot <- function (plot_grid, width, height, save_filepath) {

  grid::grid.draw(plot_grid)
  #save it
  ggplot2::ggsave(filename = save_filepath,
                  plot=plot_grid, width=(width/72), height=(height/72),  bg="white")

}

#Left align text
left_align <- function (plot_name, pieces) {

  grob <- ggplot2::ggplotGrob(plot_name)
  n <- length(pieces)
  grob$layout$l[grob$layout$name %in% pieces] <- 2
  return(grob)

}

create_footer <- function (source_name, logo_image_path, tv) {

  footer <-

    grid::grobTree(grid::textGrob(source_name,
                                  x = 0.004, hjust = 0, gp = grid::gpar(fontsize = 10, fontfamily = "OpenSans-Light")),
                   grid::rasterGrob(png::readPNG(logo_image_path), x = 0.929))


}

get_plot_grid <- function (plot_left_aligned, height_pixels, footnote, footer) {
  ## The footer (aka source, logo) height is the same whether there is a footnote above it or not
  footer_height <- 0.040/(height_pixels/450)
  if (!is.null(footnote)) {
    footnote_grob <- grid::textGrob(footnote, x = 0.004, hjust = 0, gp = grid::gpar(fontsize = 10, fontfamily = "OpenSans-Light", lineheight = 0.85))
    count_newlines <- function(s) {
      s2 <- gsub('\n',"",s)
      return (nchar(s) - nchar(s2))
    }
    num_footnote_lines <- count_newlines(footnote)
    ## The height of the footnote grob is defined as a function of the number of
    ## newline characters found in the footnote text
    footnote_height <- (0.08 + (0.06 * num_footnote_lines))/(height_pixels/450)
    plot_grid <- ggpubr::ggarrange(plot_left_aligned, footnote_grob, footer,
                                   ncol = 1, nrow = 3,
                                   heights = c(1, footnote_height, footer_height)
    )
  } else {
    plot_grid <- ggpubr::ggarrange(plot_left_aligned, footer,
                                   ncol = 1, nrow = 2,
                                   heights = c(1, footer_height)
    )
  }
  return(plot_grid)
}

#' Arrange alignment and save Newsworthy style ggplot chart
#'
#' Running this function will save your plot with the correct guidelines for publication
#' It will left align your title, subtitle, legend and source, add the Newsworthy logo at the bottom right and save it to your specified location.
#' @param plot_name The variable name of the plot you have created that you want to format and save
#' @param source_name The text you want to put including the text 'Source:' in the bottom left hand side of your side
#' @param save_filepath Exact or relative filepath that you want the plot to be saved to
#' @param width_pixels Width in pixels that you want to save your chart to - defaults to 640
#' @param height_pixels Height in pixels that you want to save your chart to - defaults to 450
#' @param logo_image_path File path for the logo image you want to use in the right hand side of your chart,
#'  which needs to be a PNG file - defaults to Newsworthy logo that sits within the data folder of your package
#' @param left_aligned Character vector naming the
#'   left-aligned elements that you want
#'   to shift from the left of the plot area to the left of the graph.
#'   The default option covers the title, subtitle and legend.
#' @param footnote String that you would like to appear below plot and above source and logo. Add line breaks
#' by using newline characters (\n) - defaults to no footnote
#' @param tinify_file Boolean that if set to TRUE will compress your png using Will's tinifyr package - defaults
#' to FALSE
#'
#' @return (Invisibly) an updated ggplot object.
#' @keywords finalise_plot
#' @examples
#' finalise_plot(plot_name = myplot,
#' source = "The source for my data",
#' save_filepath = "filename_that_my_plot_should_be_saved_to-nc.png",
#' width_pixels = 640,
#' height_pixels = 450,
#' logo_image_path = "logo_image_filepath.png"
#' )
#'
#' @export

finalise_plot <- function (plot_name,
                           source_name=NULL,
                           save_filepath=file.path(tempdir(), "tmp-nc.png"),
                           width_pixels=640,
                           height_pixels=450,
                           logo_image_path = file.path(system.file("data", package = 'jpplot2'),"newsworthy-logo.png"),
                           left_aligned=c("title", "subtitle", "legend"),
                           footnote=NULL,
                           scale = 0.7) {

  footer <- create_footer(source_name, logo_image_path)

  # For some reason, the grob referring to the legend is named "guide-box".
  left_aligned <- gsub("^legend$", "guide-box", left_aligned)

  # Draw your left-aligned grid
  plot_left_aligned <- left_align(plot_name, left_aligned)
  ## print(paste("Saving to", save_filepath))
  ## Set up the grid, with two rows if no footnote and three if there is one defined
  plot_grid <- get_plot_grid(plot_left_aligned, height_pixels, footnote, footer)

  # print(paste("Saving to", save_filepath))
  save_plot(plot_grid, width_pixels, height_pixels, save_filepath)

  ## Return (invisibly) a copy of the graph. Can be assigned to a
  ## variable or silently ignored.
  invisible(plot_grid)

}
