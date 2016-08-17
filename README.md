# ColdFusion Script: QueryToDataTable
ColdFusion Script function for converting a ColdFusion Query object into the Google Charts Library's DataTable format, described [here](https://developers.google.com/chart/interactive/docs/reference#dataparam).

## Usage
```cfm
<cfset dataTable = QueryToDataTable(qMyQuery, "Label1,Label2")>
```
## Requirements
Tested on ColdFusion 11 with queries from a MySQL database. However, the code could easily be extended for other databases by updating the `typeMap` object (around line 3).
