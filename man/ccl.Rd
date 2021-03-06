% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ccl.R
\name{ccl}
\alias{ccl}
\title{ccl connected components labeling}
\usage{
ccl(x, verbose = TRUE)
}
\arguments{
\item{x}{3D binary array or nifti object}

\item{verbose}{if TRUE will print progress bars}
}
\value{
3D array or nifti object of labels
}
\description{
labels connected components in a 3D binary array
}
\examples{
\dontrun{
 img = array(rbinom(1000, 1, .5), dim=c(10,10,10))
 img[,,1] = 0
 img[,,10] = 0
 img[1,,] = 0
 img[10,,] = 0
 img[,1,] = 0
 img[,10,] = 0
 labels = ccl(img)
}
}

