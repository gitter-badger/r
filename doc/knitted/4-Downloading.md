Downloading
===========



### Download an OpenML task
A user can download a task from the OpenML server, compute predictions with an algorithm (i.e., with a specific setup)
and upload this algorithm as well as the predictions. The server will then calculate many different performance measures
and add them to the data base.

The following call returns an OpenML task object:


```r
task = getOMLTask(task.id = 59L)
task
```

```
## 
## OpenML Task 59 :: (Data ID = 61)
##   Task Type            : Supervised Classification
##   Data Set             : iris :: (Version = 1, OpenML ID = 61)
##   Target Feature(s)    : class
##   Estimation Procedure : Stratified crossvalidation (1 x 10 folds)
```

The corresponding `"OMLDataSet"` object can be accessed by


```r
task$input$data.set
```

```
## 
## Data Set "iris" :: (Version = 1, OpenML ID = 61)
##   Collection Date         : 1936
##   Creator(s)              : R.A. Fisher
##   Default Target Attribute: class
```

A special print function gives the basic information on the data set. To extract the data itself one can use


```r
iris.data = task$input$data.set$data
head(iris.data)
```

```
##   sepallength sepalwidth petallength petalwidth       class
## 0         5.1        3.5         1.4        0.2 Iris-setosa
## 1         4.9        3.0         1.4        0.2 Iris-setosa
## 2         4.7        3.2         1.3        0.2 Iris-setosa
## 3         4.6        3.1         1.5        0.2 Iris-setosa
## 4         5.0        3.6         1.4        0.2 Iris-setosa
## 5         5.4        3.9         1.7        0.4 Iris-setosa
```

### Download an OpenML data set only
To directly download a data set, e.g., when you want to run a few preliminary experiments, one can
use the function `getOMLDataSet`. The function accepts a data set ID as input and returns the corresponding `OMLDataSet`:


```r
iris.data2 = getOMLDataSet(did = 61L)  # the iris data set has the data set ID 61
iris.data2
```

```
## 
## Data Set "iris" :: (Version = 1, OpenML ID = 61)
##   Collection Date         : 1936
##   Creator(s)              : R.A. Fisher
##   Default Target Attribute: class
```

### Download an OpenML flow

You can download a flow by specifying the `flow.id` parameter in the `getOMLFlow` function:


```r
flow = getOMLFlow(flow.id = 2700L)
flow
```

```
## 
## Flow "classif.randomForest" :: (Version = 47, Flow ID = 2700)
## 	External Version         : R_3.1.2-734b029d
## 	Dependencies             : mlr_2.9, randomForest_4.6.12
## 	Number of Flow Parameters: 16
## 	Number of Flow Components: 0
```

### Download an OpenML run
To download the results of one run including all server and user computed metrics, you have to know
the corresponding run ID. These IDs can be extracted from the `runs` object, which was created in the
previous section. Here we use the first run of task 59, which has the `run.id` 234.
You can download a single OpenML run with the `getOMLRun` function:


```r
run = getOMLRun(run.id = 525534L)  # see ?OMLRun for each slot of the OMLRun object
```

There are some slots which are of major intereset for the `OMLRun` object. A list containing the parameter settings can be obtained by `run$parameter.setting`:

```r
run$parameter.setting  ## retrieve first parameter setting
```

```
## [[1]]
##  seed = 1
## 
## [[2]]
##  kind = Mersenne-Twister
## 
## [[3]]
##  normal.kind = Inversion
```
(**??? FIXME: WHAT DOES THIS REPRESENT???**)
The first three parameters refer to the RNG settings, e.g. the seed, which will help you to reproduce the run. It the flow that created this run has hyperparameters that are different from the default values of the corresponding learner, they are also shown, otherwise the default hyperparameters are used. 

All data that served as input for the run, including the URL to the data is stored in 

```r
run$input.data
```

```
## 
## ** Data Sets **
##   did name                                                         url
## 1  61 iris http://www.openml.org/data/download/61/dataset_61_iris.arff
## 
## ** Files **
## Dataframe mit 0 Spalten und 0 Zeilen
## 
## ** Evaluations **
## Dataframe mit 0 Spalten und 0 Zeilen
```
(**??? FIXME: STRANGE???**)

To retrieve predictions of an uploaded run, you can use:


```r
head(run$predictions)
```

```
##   repeat fold row_id      prediction           truth
## 1      0    0     43     Iris-setosa     Iris-setosa
## 2      0    0     14     Iris-setosa     Iris-setosa
## 3      0    0     37     Iris-setosa     Iris-setosa
## 4      0    0     23     Iris-setosa     Iris-setosa
## 5      0    0     10     Iris-setosa     Iris-setosa
## 6      0    0     99 Iris-versicolor Iris-versicolor
##   confidence.Iris-setosa confidence.Iris-versicolor
## 1                      1                          0
## 2                      1                          0
## 3                      1                          0
## 4                      1                          0
## 5                      1                          0
## 6                      0                          1
##   confidence.Iris-virginica
## 1                         0
## 2                         0
## 3                         0
## 4                         0
## 5                         0
## 6                         0
```
(**??? FIXME: STRANGE???**)

----------------------------------------------------------------------------------------------------
Jump to:

- [Introduction](1-Introduction.md)
- [Configuration](2-Configuration.md)
- [Listing](3-Listing.md)
- Downloading
- [Running models on tasks](5-Running.md)
- [Uploading](6-Uploading.md)
- [Example workflow with mlr](7-Example-workflow-with-mlr.md)
