% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/listOMLDataSets.R
\name{listOMLDataSets}
\alias{listOMLDataSets}
\title{List available OpenML data sets.}
\usage{
listOMLDataSets(verbosity = NULL, status = "active")
}
\arguments{
\item{verbosity}{[\code{integer(1)}]\cr
Print verbose output on console? Possible values are:\cr
\code{0}: normal output,\cr
\code{1}: info output,\cr
\code{2}: debug output.\cr
Default is set via \code{\link{setOMLConfig}}.}

\item{status}{[\code{character}]\cr
Subsets the results according to the status, can take one or more values of
\code{{"active", "deactivated", "in_preparation"}}.
Default is \code{"active"}.}
}
\value{
[\code{data.frame}].
}
\description{
The returned \code{data.frame} contains the data set id \dQuote{did},
the \dQuote{status} (\dQuote{active}, \dQuote{deactivated}, \dQuote{in_preparation})
and describing data qualities.
}
\note{
This function is memoised. I.e., if you call this function twice in a running R session,
the first call will query the server and store the results in memory while the second and all subsequent calls will return
the cached results from the first call.
You can reset the cache by calling \code{\link[memoise]{forget}} on the function manually.
}
\seealso{
Other dataset related functions: \code{\link{OMLDataSetDescription}},
  \code{\link{OMLDataSet}},
  \code{\link{convertOMLDataSetToMlr}},
  \code{\link{deleteOMLObject}},
  \code{\link{getOMLDataSet}}, \code{\link{tagOMLObject}},
  \code{\link{uploadOMLDataSet}}

Other listing functions: \code{\link{listOMLDataSetQualities}},
  \code{\link{listOMLEstimationProcedures}},
  \code{\link{listOMLEvaluationMeasures}},
  \code{\link{listOMLFlows}}, \code{\link{listOMLRuns}},
  \code{\link{listOMLTaskTypes}},
  \code{\link{listOMLTasks}}
}

