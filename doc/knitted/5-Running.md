Running
=======



You can apply an implementation of an algorithm to a specific task. There are several possibilities to do this.

### Run a task with a specified mlr learner

If you are working with [**mlr**](https://github.com/mlr-org/mlr), you can specify a `RLearner` object and use the function `runTaskMlr` to create the desired `"OMLMlrRun"` object.
The `task` was created in the previous section as `task = getOMLTask(task.id = 59L)`.

```r
library(mlr)
lrn = makeLearner("classif.rpart")
run.mlr = runTaskMlr(task, lrn)
run.mlr
```

```
## 
## OpenML Run NA :: (Task ID = 59, Flow ID = NA)
## 
## Resample Result
## Task: OpenML-Task-59
## Learner: classif.rpart
## acc.aggr: 0.94
## acc.mean: 0.94
## acc.sd: 0.05
## timetrain.aggr: 0.07
## timetrain.mean: 0.01
## timetrain.sd: 0.01
## timepredict.aggr: 0.06
## timepredict.mean: 0.01
## timepredict.sd: 0.01
## Runtime: 0.229022
```

(**??? Fixme: Why is it `OpenML Run NA :: ` and why is the flow ID missing as well???**)
Note that locally created runs don't have an ID. Maybe we should change the print function here?

### Run a task without using mlr

If you are not using **mlr**, you will have to invest quite a bit more time to get things done. So -- unless you have good reasons to do otherwise -- we strongly encourage you to use **mlr**.

The following example shows how to create an OpenML flow description object manually.

The first step is to create a list of `OMLFlowParameter`s, where each parameter of your implementation is stored. Let's assume we have written an algorithm that has two parameters called `a` (with default value: `500`) and `b` (with default value: `TRUE`).


```r
flow.par.a = makeOMLFlowParameter(
  name = "a",
  data.type = "numeric",
  default.value = "500",  # All defaults must be passed as strings.
  description = "An optional description of parameter a.")

flow.par.b = makeOMLFlowParameter(
  name = "b",
  data.type = "logical",
  default.value = "TRUE",
  description = "An optional description of parameter b.")

flow.pars = list(flow.par.a, flow.par.b)
```

Now we can create the whole description object. Try to find a good name for your algorithm that gives other users an idea of what is happening.


```r
oml.flow = makeOMLFlow(
  name = "good_name",
  external.version = "1.0",
  description = "A proper description of your algorithm, changes, etc.",
  parameter = flow.pars)
```

Before you can apply the created flow to a task, you have to create a `OMLRun` object. If you want to change the parameter settings for the run, you can do this by a list that contains an `OMLRunParameter` objects for each parameter defined by the flow **whose setting varies from the default**. The class `OMLRunParameter` has the following slots:

* name
* value
* component (optional and only needed if the parameter belongs to a (sub-)component of the implementation. Then, the name of this component must be handed over here.) (**??? Fixme: What is a (sub-)component? Any good example here???**)

Let's assume that we want to set the parameter `a` to a value of `300`. Parameter `b`, on the other hand, remains in the default setting, so that we do not need to define a `OMLRunParameter` for it:


```r
run.par.a = makeOMLRunParameter(name = "a", value = "300")
run.pars = list(run.par.a)
```

Now you can create your `OMLRun` object using the `makeOMLRun` function. 
If you want to upload the run to OpenML you will need to create a `data.frame` for the `predictions` parameter, which has to be in a standardized form before you can create a run using `makeOMLRun`. 
The call `task$output$predictions` (*??? Fixme: No, it doesn't**) gives us the expected column names and their types. 
For supervised classification and regression tasks, these are:

* `repeat` (integer)
* `fold` (integer)
* `row_id` (integer)
* `prediction` (string)

The columns `repeat`, `fold` and `row_id` have to be zero-based, i.e., we start numbering
with 0 and not with 1 as we would usually do in R. For an example see below.

Additionally, in case of a classification task one needs:

* confidence.*classname_1*
* confidence.*classname_2*
* ... 

(one column for each level of the target variable).

##### Example: An excerpt of predictions (Iris data set, 2x10-fold CV).

Here we used two repetitions (`repeat` can be either `0` or `1`) of a 10-fold cross-validation
(`fold` can be in `0:9`). The data set has 150 observations, thus, the `row_id` can be in
`0:149`. 

(**??? Fixme: This is created WHILE or AFTER running the learner? I.e. `prediction` and `confidence.xyz` are the results of the learner? And how would one usually create all these objects? I.e. are the run parameters perhaps the result from cross-validation?**)


```r
set.seed(1907)  # set seed for reproducible results
preds = data.frame('repeat' = rep(0:1, each = nrow(iris.data)),
                   fold = rep(0:9, each = nrow(iris.data)/10),
                   row.id = sample(1:nrow(iris.data)) - 1)
names(preds)[1] = "repeat"
head(preds)
```

```
##   repeat fold row.id
## 1      0    0      1
## 2      0    0    117
## 3      0    0     27
## 4      0    0     84
## 5      0    0     85
## 6      0    0     79
```
(**??? Fixme: Why can't one specify `repeat = ...`**)

```
    repeat fold row_id      prediction confidence.Iris-setosa confidence.Iris-versicolor confidence.Iris-virginica
1        0    0    140  Iris-virginica                      0                          0                         1
...    ...  ...    ...             ...                    ...                        ...                       ...
51       0    3     37     Iris-setosa                      1                          0                         0
...    ...  ...    ...             ...                    ...                        ...                       ...
150      0    9     76  Iris-virginica                      0                          0                         1
151      1    0    110  Iris-virginica                      0                          0                         1
...    ...  ...    ...             ...                    ...                        ...                       ...
300      1    9     58 Iris-versicolor                      0                          1                         0
```

(**??? Fixme: Is it possible to NOT wrap the above code block but use scroll bars instead? This would strongly increase readability. Problem would be the PDF version, though.**)

When you have created such a data frame you can create an OpenML run by:


```r
run = makeOMLRun(task.id = 59L, parameter.setting = run.pars, predictions = preds)
```

This run can now be uploaded to the [OpenML server](http://openml.org) as we will show in the next section.

----------------------------------------------------------------------------------------------------
Jump to:

- [Introduction](1-Introduction.md)
- [Configuration](2-Configuration.md)
- [Listing](3-Listing.md)
- [Downloading](4-Downloading.md)
- Running models on tasks
- [Uploading](6-Uploading.md)
- [Example workflow with mlr](7-Example-workflow-with-mlr.md)
