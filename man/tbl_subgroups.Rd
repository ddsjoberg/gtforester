% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tbl_subgroups.R
\name{tbl_subgroups}
\alias{tbl_subgroups}
\title{Subgroup Analyses}
\usage{
tbl_subgroups(data, subgroups, .tbl_fun, ...)
}
\arguments{
\item{data}{data frame}

\item{subgroups}{character vector of column names to perform stratified analyses among}

\item{.tbl_fun}{A function or formula. If a \emph{function}, it is used as is.
If a formula, e.g. \code{~ .x \%>\% tbl_summary() \%>\% add_p()}, it is converted to a function.
The stratified data frame is passed to this function.}

\item{...}{Additional arguments passed on to the \code{.tbl_fun} function.}
}
\value{
a gt table
}
\description{
Subgroup Analyses
}
\examples{
# add example
}
