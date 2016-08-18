# ColdFusion Script: QueryToDataTable
ColdFusion Script function for converting a ColdFusion Query object into the Google Charts Library's DataTable format, described [here](https://developers.google.com/chart/interactive/docs/reference#dataparam).

## Usage
Outline:
```
QueryToDataTable(<query>, <labels>, [roles], [dform], [nform], [tform])
=> { "cols": [ ... ], "rows": [ ... ] }
```

## Examples
Basic:
```cfm
<cfset dataTable = QueryToDataTable(qMyQuery, "Label1,Label2")>
```
Advanced
```cfm
<cfset dataTable = QueryToDataTable(qMyQuery, "Label1,Label2,Label3", ",,,tooltip", "mm/dd/yyyy", "0.00%")>
```

## Requirements
Tested on ColdFusion 11 with queries from a MySQL database. However, the code could easily be extended for other databases by updating the `typeMap` object (around line 3).

## Parameters
### query
Query results object.
### labels
List of column labels corresponding to the columns in the query.
### roles
Optional. List of roles for the columns. See the Google Charts Documentation for more information.
### dform
Optional. Date format string to use when the DataTable has dates or datetimes. See the documentation for ColdFusion's DateFormat and DateTimeFormat functions for more information.
### nform
Optional. Number format string to use when the DataTable has numbers. See the documentation for ColdFusion's NumberFormat function for more information.
The QueryToDataTable function also supports an additional operator from the NumberFormat function: if your format string has a '%' as the last character, the formatted number will be multiplied by 100 before being formatted and a '%' will be appended to the formatted string. For example, an nform of "0.00%" will turn 0.4 into "40.00%"
### tform
Optional. Time format string to use when the DataTable has time of day objects. See the documentation for ColdFusion's TimeFormat function for more information.
