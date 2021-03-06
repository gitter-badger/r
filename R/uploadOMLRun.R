#' @title Upload an OpenML run.
#'
#' @description
#' Share a run of an flow on a given OpenML task by uploading it to the OpenML server.
#'
#' @note
#' This function will reset the cache of \code{link{listOMLRuns}} and
#' \code{\link{listOMLRunEvaluations}} on success.
#'
#' @param run [\code{\link{OMLRun}}]\cr
#'   The run that should be uploaded.
#' @template arg_verbosity
#' @return [\code{invisible(numeric(1))}].
#'   The run ID.
#' @family uploading functions
#' @family run related functions
#' @export
uploadOMLRun = function(run, verbosity = NULL) {
  assertClass(run, "OMLRun")

  if (is.na(run$flow.id)) {
    if (!is.null(run$flow))
      run$flow.id = uploadOMLFlow(run$flow) else
        stop("Please provide a 'flow.id'")
#     if (!missing(flow.id)) {
#       run$flow.id = asCount(flow.id)
#     } else stop("Please provide a 'flow.id'")
  } #else {
#    if (!missing(flow.id)) stop("This run has already a 'flow.id'.")
#  }
  if (is.na(run$error.message)) {
    assertDataFrame(run$predictions)
  } else {
    assertString(run$error.message)
  }

  description = tempfile()
  on.exit(unlink(description))
  writeOMLRunXML(run, description)

  if (!is.null(run$predictions)) {
    output = tempfile()
    on.exit(unlink(output), add = TRUE)
    if (getOMLConfig()$arff.reader == "RWeka")
      RWeka::write.arff(run$predictions, file = output) else farff::writeARFF(run$predictions, path = output)

    content = doAPICall(api.call = "run", method = "POST", file = NULL, verbosity = verbosity,
      post.args = list(description = upload_file(path = description),
                       predictions = upload_file(path = output)))
  } else {
    content = doAPICall(api.call = "run", method = "POST", file = NULL, verbosity = verbosity,
      post.args = list(description = upload_file(path = description)) )
  }
  # was uploading successful?
  doc = try(parseXMLResponse(content, "Uploading run", "upload_run", as.text = TRUE), silent = TRUE)

  # if not, print the error.
  if (is.error(doc)) {
    parseXMLResponse(content, "Uploading run", "response")
  }
  run.id = xmlRValI(doc, "/oml:upload_run/oml:run_id")
  # else, return the run.id invisibly
  showInfo(verbosity, "Run successfully uploaded. Run ID: %i", run.id)
  forget(listOMLRuns)
  forget(listOMLRunEvaluations)

  return(run.id)
}
