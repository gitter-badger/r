Browse the database
===================

Data sets have different data qualities and users might want to work on data sets that meet certain conditions. 

### Get data qualities
With the function `getDataQualities` you can obtain all data qualities of all stored data sets. By default, only basic data characteristics like the number of features/instances/classes/missing values etc. are retrieved:


```r
dq <- getDataQualities()
```


If you want to retrieve not only the basic data qualities but also meta learning features, please use the argument 'set':


```r
dq <- getDataQualities(set = "all")
```


### Make an arbitrary SQL-query
The freest way to browse the OpenML database is by SQL-queries. The function `runSQLQuery` is an interface for any arbitrary SQL-query. The query is passed as a string to the function as you can see in the following example:


```r
runSQLQuery(query = "SELECT id FROM implementation WHERE name = 'classif.rpart'")
```


Note, that most users should not need this function.

----------------------------------------------------------------------------------------------------------------------
Jump to:   
[1 Introduction](1-Introduction.md)  
[2 Download a task](2-Download-a-task.md)  
[3 Upload an implementation](3-Upload-an-implementation.md)  
[4 Upload predictions](4-Upload-predictions.md)  
[5 Download performance measures](5-Download-performance-measures.md)  
6 Browse the database