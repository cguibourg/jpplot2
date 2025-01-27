% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/theme_jpp_map.R
\name{theme_jpp_map}
\alias{theme_jpp_map}
\title{Add Journalism++ theme to a ggplot2 map}
\usage{
theme_jpp_map()
}
\description{
This function allows you to add a modified version of the standard Journalism++ theme, when making map graphics
}
\examples{
line <- ggplot(line_df, aes(x = year, y = lifeExp)) +
geom_line(colour = "#990000", size = 1) +
geom_hline(yintercept = 0, size = 1, colour="#333333") +
theme_jpp()
}
\keyword{theme_jpp_map}
