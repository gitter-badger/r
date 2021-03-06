Introduction
============

The R package OpenML is an interface to make interactions with the [OpenML](http://openml.org/) server as comfortable as possible. 
Users can download and upload files, run their implementations on specific tasks, get predictions in the correct form, and run SQL queries, etc. directly via R commands. 
In this tutorial, we will show you the most important functions of this package and give you examples on standard workflows.

For general information on what OpenML is, please have a look at the [README file](https://github.com/openml/OpenML/blob/master/README.md) or visit the [official OpenML website](http://openml.org/).

Before making practical use of the package, in most cases it is desirable to
[setup a configuration file](2-Configuration.md) to simplify further steps.

Afterwards, there are different basic stages when using this package or OpenML, respectively:

* [Listing](3-Listing.md)
    * function names begin with `listOML`
    * result is always a `data.frame`
    * available for `DataSets`, `Tasks`, `Flows`, `Runs`, `RunEvaluations`, `EvaluationMeasures` and `TaskTypes`
* [Downloading](4-Downloading.md)
    * function names begin with `getOML`
    * result is an object of a specific OpenML class
    * available for `DataSets`, `Tasks`, `Runs`, `Predictions` and `Flows`
* [Running models on tasks](5-Running.md)
    * function `runTaskMlr`
    * input: `OMLTask` and [`Learner`](https://mlr-org.github.io/mlr-tutorial/release/html/learner/index.html)
    * output: `OMLMlrRun`, `OMLRun`
* [Uploading](6-Uploading.md)
    * function `uploadOMLRun`

----------------------------------------------------------------------------------------------------
Jump to:

- Introduction
- [Configuration](2-Configuration.md)
- [Listing](3-Listing.md)
- [Downloading](4-Downloading.md)
- [Running models on tasks](5-Running.md)
- [Uploading](6-Uploading.md)
- [Example workflow with mlr](7-Example-workflow-with-mlr.md)
