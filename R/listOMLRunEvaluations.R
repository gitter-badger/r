.listOMLRunEvaluations = function(task.id = NULL, setup.id = NULL, flow.id = NULL,
  run.id = NULL, uploader.id = NULL, verbosity = NULL) {
  if (!is.null(task.id)) assertInt(task.id)
  if (!is.null(setup.id)) assertInt(setup.id)
  if (!is.null(flow.id)) assertInt(flow.id)
  if (!is.null(run.id)) assertNumeric(run.id)
  if (!is.null(uploader.id)) assertInt(uploader.id)
  if (is.null(task.id) && is.null(setup.id) && is.null(flow.id) && is.null(run.id) && is.null(uploader.id))
    stop("Please hand over at least one of the following: task.id, setup.id, flow.id, run.id, uploader.id")

  if (length(run.id) > 1)
    run.id = collapse(run.id)
  url.args = list(
    task = task.id,
    setup = setup.id,
    flow = flow.id,
    run = run.id,
    uploader = uploader.id
  )
  url.args = Filter(function(x) !is.null(x), url.args)

  api.call = paste0("evaluation/list/", collapseNamedList(url.args, sep = "/", collapse = "/"))
  content = doAPICall(api.call, file = NULL, method = "GET", verbosity = verbosity)

  d = try(parseXMLResponse(content, "Getting task results", "evaluations", as.text = TRUE, return.doc = FALSE), silent = TRUE)
  if (is.error(d)) return(NULL)

  mat = xmlSApply(d, function(x) {
    line = getChildrenStringsNA(x)
    if ("array_data" %nin% names(line)) 
      line = c(line, "array_data" = NA)
    if ("value" %nin% names(line))
      line = c(line, "value" = NA)
    return(line)
  })
  
  mat = t(mat)
  ret = setNames(as.data.frame(unname(mat), stringsAsFactors = FALSE), colnames(mat))
  ret = reshape(ret, timevar = "function", idvar = c("run_id", "task_id", "setup_id", "flow_id"), direction = "wide")
  # remove NA columns
  ret = ret[,vlapply(ret, function(x) !all(is.na(x)))]

  colnames(ret) = gsub("value[.]", "", colnames(ret))
  arr.ind = grepl("array_data[.]", colnames(ret))
  colnames(ret)[arr.ind] = paste0(gsub("array_data[.]", "", colnames(ret)[arr.ind]), ".array")
  ret = as.data.frame(lapply(ret, type.convert, numerals = "no.loss", as.is = TRUE))

  colnames(ret) = gsub("_", ".", colnames(ret))
  return(ret)
}

#' @title List run results of a task.
#'
#' @description
#' Retrieves all run results for a task (\code{task.id}), a setup
#' (\code{setup.id}), a flow (\code{flow.id}) or a run (\code{run.id}) and returns
#' a \code{data.frame}. Each row contains, among others, the run id \dQuote{rid}.
#'
#' @template note_memoise
#'
#' @inheritParams listOMLRuns
#' @return [\code{data.frame}].
#' @family list
#' @export
listOMLRunEvaluations = memoise(.listOMLRunEvaluations)
