Upload predictions
==================

Predictions have to be uploaded in a standardized form. In the slot 'task.preds', every task contains information on which columns must be supplied. For supervised classification and regression tasks, these are:
* repeat 
* fold 
* row_id     
* prediction  

and additionally, in case of a classification task:
* confidence.*classname_1* 
* confidence.*classname_2* 
* ... (one column for each level of the target variable).

**Note: The columns "repeat", "fold" and "row_id" have to be zero-based!** 

Example: An excerpt of predictions (Iris data set, 10-fold CV, 2 repeats).

        repeat fold row_id      prediction confidence.Iris-setosa confidence.Iris-versicolor confidence.Iris-virginica  
    1        0    0    140  Iris-virginica                      0                          0                         1  
    ...    ...  ...    ...             ...                    ...                        ...                       ...  
    51       0    3     37     Iris-setosa                      1                          0                         0  
    ...    ...  ...    ...             ...                    ...                        ...                       ...  
    150      0    9     76  Iris-virginica                      0                          0                         1  
    151      1    0    110  Iris-virginica                      0                          0                         1  
    ...    ...  ...    ...             ...                    ...                        ...                       ...  
    300      1    9     58 Iris-versicolor                      0                          1                         0  

### Compute predictions of an mlr learner for an OpenML task
If you are working with [mlr](https://github.com/berndbischl/mlr), you can use the OpenML function `runTask` that returns a data.frame of predictions in the desired form:


```r
predictions <- runTask(task, learner)
```


If the prediction type of the learner is set to "response" instead of "prob", the confidence-columns will contain only 0s and 1s as in the example above. Else, the predicted class probabilities will be used.

### Upload predictions to the server
To upload the predictions, mlr users only need the following call:

```r
run.ul <- uploadOpenMLRun(task = task, mlr.lrn = learner, oml.impl = openML.impl, 
    predictions = predictions, session.hash = hash)
```


If you do not work with mlr, you must create a run parameter list. This is a list that contains an `OpenMLRunParameter` for every parameter **whose setting varies from the default**. The class `OpenMLRunParameter` has the following slots: 
* name
* value 
* component (Optional and only needed if the parameter belongs to a (sub-)component of the implementation. Then, the name of this component must be handed over here.)

Let's continue with the fictive example from [section 3](3-Upload-an-implementation.md) and assume, that we set the parameter "a" to a value of 300. Parameter "b" on the other hand remains in the default setting. 

```r
run.par.a <- OpenMLRunParameter(name = "a", value = "300")

run.pars <- list(run.par.a)
```


Now we upload the run. We leave out the argument "mlr.lrn", because we are not using mlr. Instead, we hand over our run parameter list "run.pars":

```r
run.ul <- uploadOpenMLRun(task = task, oml.impl = openML.impl, predictions = predictions, 
    run.pars = run.pars, session.hash = hash)
```


----------------------------------------------------------------------------------------------------------------------
Jump to:    
[1 Introduction](1-Introduction.md)    
[2 Download a task](2-Download-a-task.md)  
[3 Upload an implementation](3-Upload-an-implementation.md)  
4 Upload predictions  
[5 Download performance measures](5-Download-performance-measures.md)