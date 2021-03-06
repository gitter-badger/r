% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/listOMLRuns.R
\name{listOMLRuns}
\alias{listOMLRuns}
\title{List OpenML runs.}
\usage{
listOMLRuns(task.id = NULL, setup.id = NULL, flow.id = NULL,
  run.id = NULL, uploader.id = NULL, verbosity = NULL)
}
\arguments{
\item{task.id}{[\code{integer(1)}]\cr
Task ID.}

\item{setup.id}{[\code{integer(1)}]\cr
ID of the parameter setup.}

\item{flow.id}{[\code{integer(1)}]\cr
ID of the implementation of an OpenML flow.}

\item{run.id}{[\code{integer}]\cr
a single ID or a vector of IDs of the runs.}

\item{uploader.id}{[\code{integer(1)}]\cr
ID of the uploader.}

\item{verbosity}{[\code{integer(1)}]\cr
Print verbose output on console? Possible values are:\cr
\code{0}: normal output,\cr
\code{1}: info output,\cr
\code{2}: debug output.\cr
Default is set via \code{\link{setOMLConfig}}.}
}
\value{
[\code{data.frame}].
}
\description{
This function returns information on all OpenML runs that match a certain
\code{task.id}, \code{setup.id} and/or implementation ID \code{flow.id}.
}
\note{
This function is memoised. I.e., if you call this function twice in a running R session,
the first call will query the server and store the results in memory while the second and all subsequent calls will return
the cached results from the first call.
You can reset the cache by calling \code{\link[memoise]{forget}} on the function manually.
}
\seealso{
Other listing functions: \code{\link{listOMLDataSetQualities}},
  \code{\link{listOMLDataSets}},
  \code{\link{listOMLEstimationProcedures}},
  \code{\link{listOMLEvaluationMeasures}},
  \code{\link{listOMLFlows}},
  \code{\link{listOMLTaskTypes}},
  \code{\link{listOMLTasks}}

Other run related functions: \code{\link{deleteOMLObject}},
  \code{\link{getOMLRun}},
  \code{\link{makeOMLRunParameter}},
  \code{\link{makeOMLRun}}, \code{\link{tagOMLObject}},
  \code{\link{uploadOMLRun}}
}

