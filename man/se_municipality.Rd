% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/se_municipality.R
\name{se_municipality}
\alias{se_municipality}
\title{Loads a map of Swedish municipalities for plotting with ggplot2}
\usage{
se_municipality(keep = 0.05, region = "KOM")
}
\arguments{
\item{keep}{The amount you want to simplify the shapefile to - defaults to five percent}

\item{region}{What you want to call each region when fortified. This should be an area code or other unique identifier.
It defaults to the 4-letter municipality ID}
}
\description{
This function loads a map of Swedish municipalities (kommuner), ready for plotting with ggplot. The shapefile comes from Valmyndigheten.se
}
\examples{
sweden <- se_municipality() \%>\% inner_join(life.exp, by = c('id' = 'municipality_id'))
}
\keyword{se_municipality}
