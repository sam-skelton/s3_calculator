# S3 Cost Calculator  

A simple ruby script to calculate s3 bucket costs. It uses your local aws env vars and takes an argument for how many buckets to calculate. Outputs a JSON object.

example:  
```
ruby ./s3_calculator.rb 2
```  
result:  
```
[{"name":"bucket_1","size_in_mb":256717858.7,"cost": 5264.72},{"name":"bucket_2","size_in_mb": 38433997.77,"cost": 788.2}]
```

to do:  
* add size options (mb, gb, tb)
* add flag to simply calculate for all buckets
* add optional custom cost flag
